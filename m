Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA2A4AF070
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiBIL6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiBIL5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:57:34 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31F3E00F7DE;
        Wed,  9 Feb 2022 02:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644404258; x=1675940258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=cg10MGlJrKIR3nLHa7WUVaDqw03CeaDXenuWD5LOhV4=;
  b=NXLLQULYQFg9g3FMQTxEz9ytggi6YaaSJlygZGDZEl59aU4LONL3ICm5
   LgJUWWgj76NK8XRhodr9DjTu9RKqjJeAdqwhXELRAog1/hwM1Pb+5xEjc
   zlgur1M1u4KhcIFl76XVByds+eHB/Av+nAvn8/rSxbS9IjJ3vARsNrhGc
   g=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Feb 2022 02:57:38 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 02:57:37 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 02:57:37 -0800
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 02:57:33 -0800
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v3 02/10] coresight: Use bitmap to assign trace id to the sources
Date:   Wed, 9 Feb 2022 18:56:58 +0800
Message-ID: <20220209105706.18852-3-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220209105706.18852-1-quic_jinlmao@quicinc.com>
References: <20220209105706.18852-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Except from STM and ETM/ETE, there could be other sources. Each
source needs a unique trace id. Define a bitmap for the trace ids.
The position of each bit represents trace id of the source.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 48 ++++++++++++++++++++
 include/linux/coresight-pmu.h                | 11 +++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index a90097f88425..6cb55c3f41d5 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -16,6 +16,7 @@
 #include <linux/mutex.h>
 #include <linux/clk.h>
 #include <linux/coresight.h>
+#include <linux/coresight-pmu.h>
 #include <linux/of_platform.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
@@ -25,8 +26,11 @@
 #include "coresight-syscfg.h"
 
 static DEFINE_MUTEX(coresight_mutex);
+static DEFINE_MUTEX(coresight_id_mutex);
 static DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
 
+static DECLARE_BITMAP(coresight_trace_id, CORESIGHT_TRACE_ID_NUM);
+
 /*
  * Use IDR to map the hash length of the source's device name
  * to the pointer of path for the source
@@ -51,6 +55,48 @@ struct coresight_node {
 const u32 coresight_barrier_pkt[4] = {0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff};
 EXPORT_SYMBOL_GPL(coresight_barrier_pkt);
 
+/* Init the coresight_trace_id bit map. */
+static void coresight_init_trace_id(void)
+{
+	int i;
+
+	/* Trace id 0 is invalid. */
+	set_bit(CORESIGHT_TRACE_ID_0, coresight_trace_id);
+	/* Trace id 1 is fixed for STM. */
+	set_bit(CORESIGHT_TRACE_ID_1, coresight_trace_id);
+	/* Trace id from 112 to 127 are reserved. */
+	for (i = CORESIGHT_TRACE_ID_112; i <= CORESIGHT_TRACE_ID_127; i++)
+		set_bit(i, coresight_trace_id);
+	/* Skip the trace ids of ETM/ETE. */
+	for (i = 0; i <= cpumask_last(cpu_possible_mask); i++)
+		set_bit(coresight_get_trace_id(i), coresight_trace_id);
+
+}
+
+/*
+ * Return the first zero bit position of bitmap coresight_trace_id
+ * as source's trace id.
+ *
+ */
+int coresight_get_system_trace_id(void)
+{
+	int id;
+
+	mutex_lock(&coresight_id_mutex);
+	id = find_first_zero_bit(coresight_trace_id, CORESIGHT_TRACE_ID_NUM);
+	/* If no zero bit is found, return error value. */
+	if (id == CORESIGHT_TRACE_ID_NUM) {
+		mutex_unlock(&coresight_id_mutex);
+		return -EINVAL;
+	}
+
+	set_bit(id, coresight_trace_id);
+	mutex_unlock(&coresight_id_mutex);
+
+	return id;
+}
+EXPORT_SYMBOL(coresight_get_system_trace_id);
+
 static const struct cti_assoc_op *cti_assoc_ops;
 
 void coresight_set_cti_ops(const struct cti_assoc_op *cti_op)
@@ -1750,6 +1796,8 @@ static int __init coresight_init(void)
 		return 0;
 
 	etm_perf_exit();
+
+	coresight_init_trace_id();
 exit_bus_unregister:
 	bus_unregister(&coresight_bustype);
 	return ret;
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 4ac5c081af93..1e2c5ca4c6e6 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -32,6 +32,14 @@
 #define ETM4_CFG_BIT_RETSTK	12
 #define ETM4_CFG_BIT_VMID_OPT	15
 
+/* Coresight component supports 7 bits trace id. */
+#define CORESIGHT_TRACE_ID_NUM	128
+
+#define CORESIGHT_TRACE_ID_0	0
+#define CORESIGHT_TRACE_ID_1	1
+#define CORESIGHT_TRACE_ID_112	112
+#define CORESIGHT_TRACE_ID_127	127
+
 static inline int coresight_get_trace_id(int cpu)
 {
 	/*
@@ -43,4 +51,7 @@ static inline int coresight_get_trace_id(int cpu)
 	return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
 }
 
+/* Get the trace id for the sources except from STM, ETM/ETE. */
+extern int coresight_get_system_trace_id(void);
+
 #endif
-- 
2.17.1

