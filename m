Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5BE49C08E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbiAZBSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:18:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:5188 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235720AbiAZBR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643159879; x=1674695879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=j9FedpyuD/S2NgO/mc5ZrDZt8ygTqEiARrruER7q7HU=;
  b=NXXZhihv2EJTIU7kQqEPmachCItzWqxccMCb+ThfikEiLNqtWOCrztEn
   PMhVu9CwKFoV1yEBGnMZWUl5F8UsmSNyhA8VgOrc2Fv6ScxSdHH+GAWbK
   B+/xtz2F5Ct2Edx0zjBmK7b8GXDfI5WrR4SrUhVkjR0HfWbNQm47JFTFF
   bP7jntxLdT9SIy3Qo/YBb+F7qr7WgIVYHGiYnNQhPR+EmtpLN7E1Y/Onu
   /Cxe1GSoiq9Gsi31y/rO4NqZidEyPzaQwpS0Uo5eYRnC37qXZWgt+jtfw
   iLfHJPx0Et/G8WU+k6lvbVApNly4mJ4NvRqmxdG5SBPUZkkpuJH94HiMF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246236199"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="246236199"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="520617541"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:56 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 11/19] soundwire: stream: move sdw_alloc_slave_rt() before 'master' helpers
Date:   Wed, 26 Jan 2022 09:17:07 +0800
Message-Id: <20220126011715.28204-12-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
References: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Code move before splitting the function in two.
No functionality change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 52 +++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index e38c9208c77b..eef2e5fd245e 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1054,6 +1054,32 @@ struct sdw_stream_runtime *sdw_alloc_stream(const char *stream_name)
 }
 EXPORT_SYMBOL(sdw_alloc_stream);
 
+/**
+ * sdw_alloc_slave_rt() - Allocate and initialize Slave runtime handle.
+ *
+ * @slave: Slave handle
+ * @stream_config: Stream configuration
+ *
+ * This function is to be called with bus_lock held.
+ */
+static struct sdw_slave_runtime
+*sdw_alloc_slave_rt(struct sdw_slave *slave,
+		    struct sdw_stream_config *stream_config)
+{
+	struct sdw_slave_runtime *s_rt;
+
+	s_rt = kzalloc(sizeof(*s_rt), GFP_KERNEL);
+	if (!s_rt)
+		return NULL;
+
+	INIT_LIST_HEAD(&s_rt->port_list);
+	s_rt->ch_count = stream_config->ch_count;
+	s_rt->direction = stream_config->direction;
+	s_rt->slave = slave;
+
+	return s_rt;
+}
+
 static struct sdw_master_runtime
 *sdw_master_rt_find(struct sdw_bus *bus,
 		    struct sdw_stream_runtime *stream)
@@ -1118,32 +1144,6 @@ static int sdw_master_rt_config(struct sdw_master_runtime *m_rt,
 	return 0;
 }
 
-/**
- * sdw_alloc_slave_rt() - Allocate and initialize Slave runtime handle.
- *
- * @slave: Slave handle
- * @stream_config: Stream configuration
- *
- * This function is to be called with bus_lock held.
- */
-static struct sdw_slave_runtime
-*sdw_alloc_slave_rt(struct sdw_slave *slave,
-		    struct sdw_stream_config *stream_config)
-{
-	struct sdw_slave_runtime *s_rt;
-
-	s_rt = kzalloc(sizeof(*s_rt), GFP_KERNEL);
-	if (!s_rt)
-		return NULL;
-
-	INIT_LIST_HEAD(&s_rt->port_list);
-	s_rt->ch_count = stream_config->ch_count;
-	s_rt->direction = stream_config->direction;
-	s_rt->slave = slave;
-
-	return s_rt;
-}
-
 /**
  * sdw_release_slave_stream() - Free Slave(s) runtime handle
  *
-- 
2.17.1

