Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8D249C08F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbiAZBSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:18:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:5195 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235744AbiAZBSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643159881; x=1674695881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ktNU35jvB6Wlvb2Vej7NMspOL8Sc09iGaTQH2Ct64/4=;
  b=FcqxsUjRAqgdoMIShFY8eatdY9tvbdEfSJUSxAkOsb2vfJ039pmIFTQJ
   NtUU9f3mpabQNAYt7bIgNPSfscSxzJngfRGu62XC8vqMEAcRsmQ7I5wO2
   roZUJt/2GBks5UKY1Wa7EGnxx/iDoztcNU5H0AC/d0ahWZ2Hgy5yH4pRq
   BBO2AKAKzQ2x6F1iRFvax6OKMtNbVTMJyyvg7B7yO+GSTIX+QaPMg2ili
   iUCjyIem74w8jH9F+Ej+rNXmP8PZrtTQRn0w95wfezaP8T5GHYoF1Ap3U
   wyH3/2rVnidi6JLCVRsdb6QA2RCLi7Hi0yLdECpheXud+Ug4hB7qbWXq2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246236207"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208,217";a="246236207"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:18:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208,217";a="520617564"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:59 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 12/19] soundwire: stream: split sdw_alloc_slave_rt() in alloc and config
Date:   Wed, 26 Jan 2022 09:17:08 +0800
Message-Id: <20220126011715.28204-13-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
References: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Split the two parts so that we can do multiple configurations during
ALSA/ASoC hw_params stage. Also follow existing convention
sdw_<object>_<action> used at lower level.

No functionality change here.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index eef2e5fd245e..b7ccfa5a9cfc 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1055,16 +1055,14 @@ struct sdw_stream_runtime *sdw_alloc_stream(const char *stream_name)
 EXPORT_SYMBOL(sdw_alloc_stream);
 
 /**
- * sdw_alloc_slave_rt() - Allocate and initialize Slave runtime handle.
+ * sdw_slave_rt_alloc() - Allocate a Slave runtime handle.
  *
  * @slave: Slave handle
- * @stream_config: Stream configuration
  *
  * This function is to be called with bus_lock held.
  */
 static struct sdw_slave_runtime
-*sdw_alloc_slave_rt(struct sdw_slave *slave,
-		    struct sdw_stream_config *stream_config)
+*sdw_slave_rt_alloc(struct sdw_slave *slave)
 {
 	struct sdw_slave_runtime *s_rt;
 
@@ -1073,13 +1071,28 @@ static struct sdw_slave_runtime
 		return NULL;
 
 	INIT_LIST_HEAD(&s_rt->port_list);
-	s_rt->ch_count = stream_config->ch_count;
-	s_rt->direction = stream_config->direction;
 	s_rt->slave = slave;
 
 	return s_rt;
 }
 
+/**
+ * sdw_slave_rt_config() - Configure a Slave runtime handle.
+ *
+ * @s_rt: Slave runtime handle
+ * @stream_config: Stream configuration
+ *
+ * This function is to be called with bus_lock held.
+ */
+static int sdw_slave_rt_config(struct sdw_slave_runtime *s_rt,
+			       struct sdw_stream_config *stream_config)
+{
+	s_rt->ch_count = stream_config->ch_count;
+	s_rt->direction = stream_config->direction;
+
+	return 0;
+}
+
 static struct sdw_master_runtime
 *sdw_master_rt_find(struct sdw_bus *bus,
 		    struct sdw_stream_runtime *stream)
@@ -1423,16 +1436,18 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 		goto stream_error;
 
 skip_alloc_master_rt:
-	s_rt = sdw_alloc_slave_rt(slave, stream_config);
+	s_rt = sdw_slave_rt_alloc(slave);
 	if (!s_rt) {
-		dev_err(&slave->dev,
-			"Slave runtime config failed for stream:%s\n",
-			stream->name);
+		dev_err(&slave->dev, "Slave runtime alloc failed for stream:%s\n", stream->name);
 		ret = -ENOMEM;
 		goto stream_error;
 	}
 	list_add_tail(&s_rt->m_rt_node, &m_rt->slave_rt_list);
 
+	ret = sdw_slave_rt_config(s_rt, stream_config);
+	if (ret)
+		goto stream_error;
+
 	ret = sdw_config_stream(&slave->dev, stream, stream_config, true);
 	if (ret)
 		goto stream_error;
-- 
2.17.1

