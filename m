Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE95249C094
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbiAZBSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:18:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:5224 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235874AbiAZBSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643159911; x=1674695911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=HqwmM8cFsKV+ilXjUfiKlQwCHphq3jNKilfDG+AYRhU=;
  b=NJGi1DUMhSipnFyA1V5qklw6vLRCIlIu6+gfzth194lJrCreTWcTTCp+
   Qvg2qw1BV0pzMYaBbxMXCXw5y6Q+s63e7h7EFAE2m+JVphMJnYQIWU86n
   zkYWs9PjDISnQHDI2fuG8I8B1lz4CRrcVWWhcpQUaK4MDaiEtKkRh/+60
   r8weOB8D3WSif39306zYsY4Us15z8pt+LakUshiipzAvooDzTHhIOxea7
   YtPXn+rf1kvFRBE+4NgAzGgvdI551EfJo53D1Bd8iWEf5QBiX8mzYn9Eu
   EChzLMK49z0f6G1WC4pJ/sIIjhcxWNZ+dEwELkYPjO5GTgvSLCThXTSu7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246236246"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="246236246"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:18:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="520617654"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:18:11 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 17/19] soundwire: stream: introduce sdw_slave_rt_find() helper
Date:   Wed, 26 Jan 2022 09:17:13 +0800
Message-Id: <20220126011715.28204-18-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
References: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Before we split the alloc and config steps, we need a helper to find
the Slave runtime for a stream. The helper is based on the search loop
in sdw_slave_rt_free(), which can now be simplified.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 03cfac0129af..a52a9ab0eea1 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1058,6 +1058,23 @@ static int sdw_slave_rt_config(struct sdw_slave_runtime *s_rt,
 	return 0;
 }
 
+static struct sdw_slave_runtime *sdw_slave_rt_find(struct sdw_slave *slave,
+						   struct sdw_stream_runtime *stream)
+{
+	struct sdw_slave_runtime *s_rt, *_s_rt;
+	struct sdw_master_runtime *m_rt;
+
+	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
+		/* Retrieve Slave runtime handle */
+		list_for_each_entry_safe(s_rt, _s_rt,
+					 &m_rt->slave_rt_list, m_rt_node) {
+			if (s_rt->slave == slave)
+				return s_rt;
+		}
+	}
+	return NULL;
+}
+
 /**
  * sdw_slave_rt_free() - Free Slave(s) runtime handle
  *
@@ -1069,19 +1086,12 @@ static int sdw_slave_rt_config(struct sdw_slave_runtime *s_rt,
 static void sdw_slave_rt_free(struct sdw_slave *slave,
 			      struct sdw_stream_runtime *stream)
 {
-	struct sdw_slave_runtime *s_rt, *_s_rt;
-	struct sdw_master_runtime *m_rt;
+	struct sdw_slave_runtime *s_rt;
 
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
+	s_rt = sdw_slave_rt_find(slave, stream);
+	if (s_rt) {
+		list_del(&s_rt->m_rt_node);
+		kfree(s_rt);
 	}
 }
 
-- 
2.17.1

