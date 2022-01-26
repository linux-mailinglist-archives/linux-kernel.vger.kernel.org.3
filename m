Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DDA49C090
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbiAZBSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:18:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:5200 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235758AbiAZBSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:18:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643159887; x=1674695887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=b59jTAE/DjKDRknOz4w/Dz0RG6Sqxw3hnLnDkfdbU/4=;
  b=Lpr0kNKrZOK5E1ES2zS3XffEic64W47WBBf4TbZsCuMvFOtt0kfMcNFz
   idctONwlleHThUFJarAC29O7xNB4P3kvR7bCsGHsT2zK4g3Gww3r1aMmV
   boTm/OnkTAOZf+gCCLEBnoeXoCjwJaNAPswJ1rsdPI/4yk+BPaApFP/T3
   O06YZdMIAlElURFumoT6VYHehCWkUUn8yahaCELIwvPkNEoCBQURkQC0A
   wR8VKU8LIXjzD1H9psz1hUBNln6Lhlgn6AJetpelXe/NY6xrL5niOkizj
   3mHpOyUJ6FOKcNHwsdQOs75P1eKD5fAOifKas+YQuxkfHwVIZt9SGLjzD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246236219"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208,217";a="246236219"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:18:06 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208,217";a="520617617"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:18:04 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 14/19] soundwire: stream: rename and move master/slave_rt_free routines
Date:   Wed, 26 Jan 2022 09:17:10 +0800
Message-Id: <20220126011715.28204-15-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
References: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The naming is rather inconsistent, use the sdw_<object>_<action>
convention, and move the free routine after alloc/config.

No functionality change beyond rename/move.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 72 +++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index b0f21f2ca599..e57920ee4c55 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1054,6 +1054,33 @@ static int sdw_slave_rt_config(struct sdw_slave_runtime *s_rt,
 	return 0;
 }
 
+/**
+ * sdw_slave_rt_free() - Free Slave(s) runtime handle
+ *
+ * @slave: Slave handle.
+ * @stream: Stream runtime handle.
+ *
+ * This function is to be called with bus_lock held.
+ */
+static void sdw_slave_rt_free(struct sdw_slave *slave,
+			      struct sdw_stream_runtime *stream)
+{
+	struct sdw_slave_runtime *s_rt, *_s_rt;
+	struct sdw_master_runtime *m_rt;
+
+	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
+		/* Retrieve Slave runtime handle */
+		list_for_each_entry_safe(s_rt, _s_rt,
+					 &m_rt->slave_rt_list, m_rt_node) {
+			if (s_rt->slave == slave) {
+				list_del(&s_rt->m_rt_node);
+				kfree(s_rt);
+				return;
+			}
+		}
+	}
+}
+
 static struct sdw_master_runtime
 *sdw_master_rt_find(struct sdw_bus *bus,
 		    struct sdw_stream_runtime *stream)
@@ -1119,51 +1146,24 @@ static int sdw_master_rt_config(struct sdw_master_runtime *m_rt,
 }
 
 /**
- * sdw_release_slave_stream() - Free Slave(s) runtime handle
- *
- * @slave: Slave handle.
- * @stream: Stream runtime handle.
- *
- * This function is to be called with bus_lock held.
- */
-static void sdw_release_slave_stream(struct sdw_slave *slave,
-				     struct sdw_stream_runtime *stream)
-{
-	struct sdw_slave_runtime *s_rt, *_s_rt;
-	struct sdw_master_runtime *m_rt;
-
-	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
-		/* Retrieve Slave runtime handle */
-		list_for_each_entry_safe(s_rt, _s_rt,
-					 &m_rt->slave_rt_list, m_rt_node) {
-			if (s_rt->slave == slave) {
-				list_del(&s_rt->m_rt_node);
-				kfree(s_rt);
-				return;
-			}
-		}
-	}
-}
-
-/**
- * sdw_release_master_stream() - Free Master runtime handle
+ * sdw_master_rt_free() - Free Master runtime handle
  *
  * @m_rt: Master runtime node
  * @stream: Stream runtime handle.
  *
  * This function is to be called with bus_lock held
  * It frees the Master runtime handle and associated Slave(s) runtime
- * handle. If this is called first then sdw_release_slave_stream() will have
+ * handle. If this is called first then sdw_slave_rt_free() will have
  * no effect as Slave(s) runtime handle would already be freed up.
  */
-static void sdw_release_master_stream(struct sdw_master_runtime *m_rt,
-				      struct sdw_stream_runtime *stream)
+static void sdw_master_rt_free(struct sdw_master_runtime *m_rt,
+			       struct sdw_stream_runtime *stream)
 {
 	struct sdw_slave_runtime *s_rt, *_s_rt;
 
 	list_for_each_entry_safe(s_rt, _s_rt, &m_rt->slave_rt_list, m_rt_node) {
 		sdw_slave_port_free(s_rt->slave, stream);
-		sdw_release_slave_stream(s_rt->slave, stream);
+		sdw_slave_rt_free(s_rt->slave, stream);
 	}
 
 	list_del(&m_rt->stream_node);
@@ -1860,7 +1860,7 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 	goto unlock;
 
 stream_error:
-	sdw_release_master_stream(m_rt, stream);
+	sdw_master_rt_free(m_rt, stream);
 unlock:
 	mutex_unlock(&bus->bus_lock);
 	return ret;
@@ -1888,7 +1888,7 @@ int sdw_stream_remove_master(struct sdw_bus *bus,
 			continue;
 
 		sdw_master_port_free(m_rt);
-		sdw_release_master_stream(m_rt, stream);
+		sdw_master_rt_free(m_rt, stream);
 		stream->m_rt_count--;
 	}
 
@@ -1987,7 +1987,7 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 	 * we hit error so cleanup the stream, release all Slave(s) and
 	 * Master runtime
 	 */
-	sdw_release_master_stream(m_rt, stream);
+	sdw_master_rt_free(m_rt, stream);
 error:
 	mutex_unlock(&slave->bus->bus_lock);
 	return ret;
@@ -2008,7 +2008,7 @@ int sdw_stream_remove_slave(struct sdw_slave *slave,
 	mutex_lock(&slave->bus->bus_lock);
 
 	sdw_slave_port_free(slave, stream);
-	sdw_release_slave_stream(slave, stream);
+	sdw_slave_rt_free(slave, stream);
 
 	mutex_unlock(&slave->bus->bus_lock);
 
-- 
2.17.1

