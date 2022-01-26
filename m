Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCA649C08D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbiAZBSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:18:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:5181 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235660AbiAZBR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643159877; x=1674695877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Rck6GQHkEM2Tw3dk9P1Wljy6YtVFUEjagAG7ehSug/0=;
  b=gZPbcPmqhnO1VgD5dLmbQ4ifZJks5xVH+W9jrOdQCXsHD01L8hGAtwMG
   5Iqgv74lOucXhtEQ0o6eWHoPemBUT0WIYXEBR4gzPV8epX83XtkAsnGcn
   oJysgai02E/4NoeEaULqmcZ9frjFeB87eCpTk+JLGGb/y+niITznAvL70
   kid4uQdvwGVknPY+snyRVAF6l+fQiV36MUeYpSpvpqu5CoNp20xVEImzm
   SzxxC2t87Ztu9iX9G4afrZEKucSHYYqAgZo11gpO5Fxqg78gXqhkV3pRP
   tIExbOGJsRNEf/cKjZyNloMwZUJ2D4tgnm9FkoY8E3mU7gRKt8gVO55z/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246236191"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208,217";a="246236191"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208,217";a="520617525"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:54 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 10/19] soundwire: stream: split sdw_alloc_master_rt() in alloc and config
Date:   Wed, 26 Jan 2022 09:17:06 +0800
Message-Id: <20220126011715.28204-11-yung-chuan.liao@linux.intel.com>
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
 drivers/soundwire/stream.c | 51 +++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 263b76230f8f..e38c9208c77b 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1055,7 +1055,7 @@ struct sdw_stream_runtime *sdw_alloc_stream(const char *stream_name)
 EXPORT_SYMBOL(sdw_alloc_stream);
 
 static struct sdw_master_runtime
-*sdw_find_master_rt(struct sdw_bus *bus,
+*sdw_master_rt_find(struct sdw_bus *bus,
 		    struct sdw_stream_runtime *stream)
 {
 	struct sdw_master_runtime *m_rt;
@@ -1070,17 +1070,15 @@ static struct sdw_master_runtime
 }
 
 /**
- * sdw_alloc_master_rt() - Allocates and initialize Master runtime handle
+ * sdw_master_rt_alloc() - Allocates a Master runtime handle
  *
  * @bus: SDW bus instance
- * @stream_config: Stream configuration
  * @stream: Stream runtime handle.
  *
  * This function is to be called with bus_lock held.
  */
 static struct sdw_master_runtime
-*sdw_alloc_master_rt(struct sdw_bus *bus,
-		     struct sdw_stream_config *stream_config,
+*sdw_master_rt_alloc(struct sdw_bus *bus,
 		     struct sdw_stream_runtime *stream)
 {
 	struct sdw_master_runtime *m_rt;
@@ -1096,14 +1094,30 @@ static struct sdw_master_runtime
 
 	list_add_tail(&m_rt->bus_node, &bus->m_rt_list);
 
-	m_rt->ch_count = stream_config->ch_count;
 	m_rt->bus = bus;
 	m_rt->stream = stream;
-	m_rt->direction = stream_config->direction;
 
 	return m_rt;
 }
 
+/**
+ * sdw_master_rt_config() - Configure Master runtime handle
+ *
+ * @m_rt: Master runtime handle
+ * @stream_config: Stream configuration
+ *
+ * This function is to be called with bus_lock held.
+ */
+
+static int sdw_master_rt_config(struct sdw_master_runtime *m_rt,
+				struct sdw_stream_config *stream_config)
+{
+	m_rt->ch_count = stream_config->ch_count;
+	m_rt->direction = stream_config->direction;
+
+	return 0;
+}
+
 /**
  * sdw_alloc_slave_rt() - Allocate and initialize Slave runtime handle.
  *
@@ -1321,19 +1335,21 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 	 * check if Master is already allocated (e.g. as a result of Slave adding
 	 * it first), if so skip allocation and go to configuration
 	 */
-	m_rt = sdw_find_master_rt(bus, stream);
+	m_rt = sdw_master_rt_find(bus, stream);
 	if (m_rt)
 		goto skip_alloc_master_rt;
 
-	m_rt = sdw_alloc_master_rt(bus, stream_config, stream);
+	m_rt = sdw_master_rt_alloc(bus, stream);
 	if (!m_rt) {
-		dev_err(bus->dev,
-			"Master runtime config failed for stream:%s\n",
-			stream->name);
+		dev_err(bus->dev, "Master runtime alloc failed for stream:%s\n", stream->name);
 		ret = -ENOMEM;
 		goto unlock;
 	}
 
+	ret = sdw_master_rt_config(m_rt, stream_config);
+	if (ret < 0)
+		goto unlock;
+
 skip_alloc_master_rt:
 	ret = sdw_config_stream(bus->dev, stream, stream_config, false);
 	if (ret)
@@ -1388,7 +1404,7 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 	 * check if Master is already allocated, if so skip allocation
 	 * and go to configuration
 	 */
-	m_rt = sdw_find_master_rt(slave->bus, stream);
+	m_rt = sdw_master_rt_find(slave->bus, stream);
 	if (m_rt)
 		goto skip_alloc_master_rt;
 
@@ -1396,14 +1412,15 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 	 * If this API is invoked by Slave first then m_rt is not valid.
 	 * So, allocate m_rt and add Slave to it.
 	 */
-	m_rt = sdw_alloc_master_rt(slave->bus, stream_config, stream);
+	m_rt = sdw_master_rt_alloc(slave->bus, stream);
 	if (!m_rt) {
-		dev_err(&slave->dev,
-			"alloc master runtime failed for stream:%s\n",
-			stream->name);
+		dev_err(&slave->dev, "Master runtime alloc failed for stream:%s\n", stream->name);
 		ret = -ENOMEM;
 		goto error;
 	}
+	ret =  sdw_master_rt_config(m_rt, stream_config);
+	if (ret < 0)
+		goto stream_error;
 
 skip_alloc_master_rt:
 	s_rt = sdw_alloc_slave_rt(slave, stream_config);
-- 
2.17.1

