Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B3C49C093
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbiAZBSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:18:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:5200 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235744AbiAZBSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643159898; x=1674695898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=3uhG1F2z4hDlx2mEu52GZg62Yh8eL4mwJdp5JqpLoI8=;
  b=ciCC/zk3h3iMLlpZYHXAn37k56lPUPwfzk+dYgFncxgbwGsi+K0hx5ZM
   2xUru3rSBCoOIUy8cWCw5CldsUx5zfYb2Yhyhl6rbxdVDf4fwj7ZFSqTB
   av/pnoWKEzSUACwqkTacDS+LXxKaf+bL9cHn5G1cK3VGkDiFTYlBx9tAA
   BgEFhfkStyClZRiQeick1dJlfnofeLw9WC+ywI3+PwjTDCFUgIVt9lW3u
   QjRfvOTAsvlIJRV7I3yD9mutED9JqPBYznZADXVAvEoWriq7DtHP8YxkD
   nfPz53nwSs3ltNWUAnts5CF4v21f093Hdusj52lVSi7bxg4jn8Ne484Dv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246236233"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="246236233"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:18:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="520617648"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:18:09 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 16/19] soundwire: stream: separate alloc and config within sdw_stream_add_xxx()
Date:   Wed, 26 Jan 2022 09:17:12 +0800
Message-Id: <20220126011715.28204-17-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
References: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Separate alloc and config parts so that follow-up patches can allow
for multiple calls to sdw_stream_add_slave/master. This is a feature
from the ALSA/ASoC frameworks which is not supported today.

This is an invasive patch which modifies the error handling flow, with
cleanups only done when an allocation fails. Configuration failures
only return an error code.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 81 ++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 33 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 8a76d6605f93..03cfac0129af 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1811,6 +1811,7 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 			  struct sdw_stream_runtime *stream)
 {
 	struct sdw_master_runtime *m_rt;
+	bool alloc_master_rt = true;
 	int ret;
 
 	mutex_lock(&bus->bus_lock);
@@ -1832,8 +1833,10 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 	 * it first), if so skip allocation and go to configuration
 	 */
 	m_rt = sdw_master_rt_find(bus, stream);
-	if (m_rt)
+	if (m_rt) {
+		alloc_master_rt = false;
 		goto skip_alloc_master_rt;
+	}
 
 	m_rt = sdw_master_rt_alloc(bus, stream);
 	if (!m_rt) {
@@ -1841,30 +1844,32 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 		ret = -ENOMEM;
 		goto unlock;
 	}
+skip_alloc_master_rt:
+
+	ret = sdw_master_port_alloc(m_rt, num_ports);
+	if (ret)
+		goto alloc_error;
+
+	stream->m_rt_count++;
 
 	ret = sdw_master_rt_config(m_rt, stream_config);
 	if (ret < 0)
 		goto unlock;
 
-skip_alloc_master_rt:
 	ret = sdw_config_stream(bus->dev, stream, stream_config, false);
 	if (ret)
-		goto stream_error;
-
-	ret = sdw_master_port_alloc(m_rt, num_ports);
-	if (ret)
-		goto stream_error;
+		goto unlock;
 
 	ret = sdw_master_port_config(m_rt, port_config);
-	if (ret)
-		goto stream_error;
-
-	stream->m_rt_count++;
 
 	goto unlock;
 
-stream_error:
-	sdw_master_rt_free(m_rt, stream);
+alloc_error:
+	/*
+	 * we only cleanup what was allocated in this routine
+	 */
+	if (alloc_master_rt)
+		sdw_master_rt_free(m_rt, stream);
 unlock:
 	mutex_unlock(&bus->bus_lock);
 	return ret;
@@ -1926,6 +1931,9 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 {
 	struct sdw_slave_runtime *s_rt;
 	struct sdw_master_runtime *m_rt;
+	bool alloc_master_rt = true;
+	bool alloc_slave_rt = true;
+
 	int ret;
 
 	mutex_lock(&slave->bus->bus_lock);
@@ -1935,8 +1943,10 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 	 * and go to configuration
 	 */
 	m_rt = sdw_master_rt_find(slave->bus, stream);
-	if (m_rt)
+	if (m_rt) {
+		alloc_master_rt = false;
 		goto skip_alloc_master_rt;
+	}
 
 	/*
 	 * If this API is invoked by Slave first then m_rt is not valid.
@@ -1946,35 +1956,37 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 	if (!m_rt) {
 		dev_err(&slave->dev, "Master runtime alloc failed for stream:%s\n", stream->name);
 		ret = -ENOMEM;
-		goto error;
+		goto unlock;
 	}
-	ret =  sdw_master_rt_config(m_rt, stream_config);
-	if (ret < 0)
-		goto stream_error;
 
 skip_alloc_master_rt:
 	s_rt = sdw_slave_rt_alloc(slave, m_rt);
 	if (!s_rt) {
 		dev_err(&slave->dev, "Slave runtime alloc failed for stream:%s\n", stream->name);
+		alloc_slave_rt = false;
 		ret = -ENOMEM;
-		goto stream_error;
+		goto alloc_error;
 	}
 
+	ret = sdw_slave_port_alloc(slave, s_rt, num_ports);
+	if (ret)
+		goto alloc_error;
+
+	ret =  sdw_master_rt_config(m_rt, stream_config);
+	if (ret)
+		goto unlock;
+
 	ret = sdw_slave_rt_config(s_rt, stream_config);
 	if (ret)
-		goto stream_error;
+		goto unlock;
 
 	ret = sdw_config_stream(&slave->dev, stream, stream_config, true);
 	if (ret)
-		goto stream_error;
-
-	ret = sdw_slave_port_alloc(slave, s_rt, num_ports);
-	if (ret)
-		goto stream_error;
+		goto unlock;
 
 	ret = sdw_slave_port_config(slave, s_rt, port_config);
 	if (ret)
-		goto stream_error;
+		goto unlock;
 
 	/*
 	 * Change stream state to CONFIGURED on first Slave add.
@@ -1983,15 +1995,19 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 	 * change stream state to CONFIGURED.
 	 */
 	stream->state = SDW_STREAM_CONFIGURED;
-	goto error;
+	goto unlock;
 
-stream_error:
+alloc_error:
 	/*
-	 * we hit error so cleanup the stream, release all Slave(s) and
-	 * Master runtime
+	 * we only cleanup what was allocated in this routine. The 'else if'
+	 * is intentional, the 'master_rt_free' will call sdw_slave_rt_free()
+	 * internally.
 	 */
-	sdw_master_rt_free(m_rt, stream);
-error:
+	if (alloc_master_rt)
+		sdw_master_rt_free(m_rt, stream);
+	else if (alloc_slave_rt)
+		sdw_slave_rt_free(slave, stream);
+unlock:
 	mutex_unlock(&slave->bus->bus_lock);
 	return ret;
 }
@@ -2018,4 +2034,3 @@ int sdw_stream_remove_slave(struct sdw_slave *slave,
 	return 0;
 }
 EXPORT_SYMBOL(sdw_stream_remove_slave);
-
-- 
2.17.1

