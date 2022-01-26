Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A8949C087
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbiAZBRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:17:55 -0500
Received: from mga09.intel.com ([134.134.136.24]:5135 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235675AbiAZBRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643159860; x=1674695860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Y5QFgrRE6gbcfE8Im68LjhUmIaas2atxywqLCLJsx/Q=;
  b=Wlh3GDE34iPDvaK/vdZXNI787RIcv/hMWlyVeqSzUptecrCLlhAiujtx
   aMLKb/zV8XMFAB5j53e0815HpU+cAg5tYqw4nopJw6HYOxICvMX/+GNb0
   ORDNyc6UZKOilwdRcQOjbRfEDutc75zdx48sz95yTmu/1h/1vt55Lvdjw
   dA+1bzShuVBO0wh5k6AsUguvJrZK4Ru32YI1hxQqkJjGEZuCUuLjiL4Ou
   foTRZvuMojtrHJ75XOJfCsP6owCCR8sN5xvha8mKKewNRhudSa1dPtpGq
   W7X1ou5XPEgPXpVgOxpaxkaZqle9tuQ5EM7PZR37ujwiIFUZvqMzr5k8g
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246236134"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="246236134"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="520617403"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:37 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 04/19] soundwire: stream: add alloc/config/free helpers for ports
Date:   Wed, 26 Jan 2022 09:17:00 +0800
Message-Id: <20220126011715.28204-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
References: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The existing code only has a config helper that allocates memory,
start adding alloc/config/free for ports, as a first step in the
simplification of the stream API.

This change removes a kfree() on a configuration error, this should
have not impact on existing platforms and error handling will be
revisited in follow-up patches to make sure invalid configurations
have not impact on memory allocation.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 83 +++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 38 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 3ac2e5a66700..49d3a8d2fa31 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -865,6 +865,39 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 	return ret;
 }
 
+static struct sdw_port_runtime *sdw_port_alloc(struct list_head *port_list)
+{
+	struct sdw_port_runtime *p_rt;
+
+	p_rt = kzalloc(sizeof(*p_rt), GFP_KERNEL);
+	if (!p_rt)
+		return NULL;
+
+	list_add_tail(&p_rt->port_node, port_list);
+
+	return p_rt;
+}
+
+static int sdw_port_config(struct sdw_port_runtime *p_rt,
+			   struct sdw_port_config *port_config,
+			   int port_index)
+{
+	p_rt->ch_mask = port_config[port_index].ch_mask;
+	p_rt->num = port_config[port_index].num;
+
+	/*
+	 * TODO: Check port capabilities for requested configuration
+	 */
+
+	return 0;
+}
+
+static void sdw_port_free(struct sdw_port_runtime *p_rt)
+{
+	list_del(&p_rt->port_node);
+	kfree(p_rt);
+}
+
 /**
  * sdw_release_stream() - Free the assigned stream runtime
  *
@@ -995,8 +1028,7 @@ static void sdw_master_port_release(struct sdw_bus *bus,
 	struct sdw_port_runtime *p_rt, *_p_rt;
 
 	list_for_each_entry_safe(p_rt, _p_rt, &m_rt->port_list, port_node) {
-		list_del(&p_rt->port_node);
-		kfree(p_rt);
+		sdw_port_free(p_rt);
 	}
 }
 
@@ -1015,8 +1047,7 @@ static void sdw_slave_port_release(struct sdw_bus *bus,
 
 			list_for_each_entry_safe(p_rt, _p_rt,
 						 &s_rt->port_list, port_node) {
-				list_del(&p_rt->port_node);
-				kfree(p_rt);
+				sdw_port_free(p_rt);
 			}
 		}
 	}
@@ -1187,43 +1218,24 @@ static int sdw_is_valid_port_range(struct device *dev, int num)
 	return 0;
 }
 
-static struct sdw_port_runtime
-*sdw_port_alloc(struct device *dev,
-		struct sdw_port_config *port_config,
-		int port_index)
-{
-	struct sdw_port_runtime *p_rt;
-
-	p_rt = kzalloc(sizeof(*p_rt), GFP_KERNEL);
-	if (!p_rt)
-		return NULL;
-
-	p_rt->ch_mask = port_config[port_index].ch_mask;
-	p_rt->num = port_config[port_index].num;
-
-	return p_rt;
-}
-
 static int sdw_master_port_config(struct sdw_bus *bus,
 				  struct sdw_master_runtime *m_rt,
 				  struct sdw_port_config *port_config,
 				  unsigned int num_ports)
 {
 	struct sdw_port_runtime *p_rt;
+	int ret;
 	int i;
 
 	/* Iterate for number of ports to perform initialization */
 	for (i = 0; i < num_ports; i++) {
-		p_rt = sdw_port_alloc(bus->dev, port_config, i);
+		p_rt = sdw_port_alloc(&m_rt->port_list);
 		if (!p_rt)
 			return -ENOMEM;
 
-		/*
-		 * TODO: Check port capabilities for requested
-		 * configuration (audio mode support)
-		 */
-
-		list_add_tail(&p_rt->port_node, &m_rt->port_list);
+		ret = sdw_port_config(p_rt, port_config, i);
+		if (ret < 0)
+			return ret;
 	}
 
 	return 0;
@@ -1239,7 +1251,7 @@ static int sdw_slave_port_config(struct sdw_slave *slave,
 
 	/* Iterate for number of ports to perform initialization */
 	for (i = 0; i < num_config; i++) {
-		p_rt = sdw_port_alloc(&slave->dev, port_config, i);
+		p_rt = sdw_port_alloc(&s_rt->port_list);
 		if (!p_rt)
 			return -ENOMEM;
 
@@ -1248,17 +1260,12 @@ static int sdw_slave_port_config(struct sdw_slave *slave,
 		 * slave
 		 */
 		ret = sdw_is_valid_port_range(&slave->dev, port_config[i].num);
-		if (ret < 0) {
-			kfree(p_rt);
+		if (ret < 0)
 			return ret;
-		}
 
-		/*
-		 * TODO: Check port capabilities for requested
-		 * configuration (audio mode support)
-		 */
-
-		list_add_tail(&p_rt->port_node, &s_rt->port_list);
+		ret = sdw_port_config(p_rt, port_config, i);
+		if (ret < 0)
+			return ret;
 	}
 
 	return 0;
-- 
2.17.1

