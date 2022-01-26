Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946A349C08C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbiAZBSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:18:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:5177 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235693AbiAZBRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643159875; x=1674695875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=dL1KHyWmbzK6Rny1+Jx1gBeDHgqwGVS/OLQiDKKLSaU=;
  b=OVdv4PQYeYNYJGxirG4Vgt8F50UMEkcTcnUHp1A7KcBly76m5UMtlBAE
   VqofmXeLjwUG66ppJqUkV9NDADpbCvkDTqjvSMlNS/sHjsRouWdtMLDwh
   aIPC/RrrUJgu3UBeciYHf7NA3NVXTBi4ZhzFHwqjjXPPSdAgYqEKGM19+
   TQHYPxh1Ti0kXdB5KqwH5ARWXf9wWLLVj8f/ikG9gxnOz5yg8OrU1sHuy
   hbkcV6UD7U895IVAD2059H3a4H7tgutVVexIn47q3dabePXcTKc22+V27
   d4LfLRqUSIdGC28GLgN17mnfDUI1eCExDPm2b0wsWoqIkzjNZSt2e8Ysl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246236184"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="246236184"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="520617508"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:51 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 09/19] soundwire: stream: simplify sdw_alloc_master_rt()
Date:   Wed, 26 Jan 2022 09:17:05 +0800
Message-Id: <20220126011715.28204-10-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
References: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Only do the allocation in that function, and move check for allocation
in the caller. This will it easier to split allocation and
configuration.

No functionality change in this patch.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 5e2d29448aaf..263b76230f8f 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1085,14 +1085,6 @@ static struct sdw_master_runtime
 {
 	struct sdw_master_runtime *m_rt;
 
-	/*
-	 * check if Master is already allocated (as a result of Slave adding
-	 * it first), if so skip allocation and go to configure
-	 */
-	m_rt = sdw_find_master_rt(bus, stream);
-	if (m_rt)
-		goto stream_config;
-
 	m_rt = kzalloc(sizeof(*m_rt), GFP_KERNEL);
 	if (!m_rt)
 		return NULL;
@@ -1104,7 +1096,6 @@ static struct sdw_master_runtime
 
 	list_add_tail(&m_rt->bus_node, &bus->m_rt_list);
 
-stream_config:
 	m_rt->ch_count = stream_config->ch_count;
 	m_rt->bus = bus;
 	m_rt->stream = stream;
@@ -1326,6 +1317,14 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 		goto unlock;
 	}
 
+	/*
+	 * check if Master is already allocated (e.g. as a result of Slave adding
+	 * it first), if so skip allocation and go to configuration
+	 */
+	m_rt = sdw_find_master_rt(bus, stream);
+	if (m_rt)
+		goto skip_alloc_master_rt;
+
 	m_rt = sdw_alloc_master_rt(bus, stream_config, stream);
 	if (!m_rt) {
 		dev_err(bus->dev,
@@ -1335,6 +1334,7 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 		goto unlock;
 	}
 
+skip_alloc_master_rt:
 	ret = sdw_config_stream(bus->dev, stream, stream_config, false);
 	if (ret)
 		goto stream_error;
@@ -1384,6 +1384,14 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 
 	mutex_lock(&slave->bus->bus_lock);
 
+	/*
+	 * check if Master is already allocated, if so skip allocation
+	 * and go to configuration
+	 */
+	m_rt = sdw_find_master_rt(slave->bus, stream);
+	if (m_rt)
+		goto skip_alloc_master_rt;
+
 	/*
 	 * If this API is invoked by Slave first then m_rt is not valid.
 	 * So, allocate m_rt and add Slave to it.
@@ -1397,6 +1405,7 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 		goto error;
 	}
 
+skip_alloc_master_rt:
 	s_rt = sdw_alloc_slave_rt(slave, stream_config);
 	if (!s_rt) {
 		dev_err(&slave->dev,
-- 
2.17.1

