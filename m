Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4DF4A8385
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350485AbiBCMGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:06:34 -0500
Received: from foss.arm.com ([217.140.110.172]:42510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350423AbiBCMGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:06:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E642D1396;
        Thu,  3 Feb 2022 04:06:22 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.13.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6BDA63F774;
        Thu,  3 Feb 2022 04:06:21 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     leo.yan@linaro.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/15] coresight: Make ETM4x TRCIDR5 register accesses consistent with sysreg.h
Date:   Thu,  3 Feb 2022 12:05:53 +0000
Message-Id: <20220203120604.128396-6-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220203120604.128396-1-james.clark@arm.com>
References: <20220203120604.128396-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a no-op change for style and consistency and has no effect on the
binary produced by gcc-11.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../hwtracing/coresight/coresight-etm4x-core.c | 18 ++++++------------
 drivers/hwtracing/coresight/coresight-etm4x.h  | 11 +++++++++++
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 553a532b65f8..0f0628968bfd 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1182,26 +1182,20 @@ static void etm4_init_arch_data(void *info)
 
 	etmidr5 = etm4x_relaxed_read32(csa, TRCIDR5);
 	/* NUMEXTIN, bits[8:0] number of external inputs implemented */
-	drvdata->nr_ext_inp = BMVAL(etmidr5, 0, 8);
+	drvdata->nr_ext_inp = REG_VAL(etmidr5, TRCIDR5_NUMEXTIN);
 	/* TRACEIDSIZE, bits[21:16] indicates the trace ID width */
-	drvdata->trcid_size = BMVAL(etmidr5, 16, 21);
+	drvdata->trcid_size = REG_VAL(etmidr5, TRCIDR5_TRACEIDSIZE);
 	/* ATBTRIG, bit[22] implementation can support ATB triggers? */
-	if (BMVAL(etmidr5, 22, 22))
-		drvdata->atbtrig = true;
-	else
-		drvdata->atbtrig = false;
+	drvdata->atbtrig = !!(etmidr5 & TRCIDR5_ATBTRIG);
 	/*
 	 * LPOVERRIDE, bit[23] implementation supports
 	 * low-power state override
 	 */
-	if (BMVAL(etmidr5, 23, 23) && (!drvdata->skip_power_up))
-		drvdata->lpoverride = true;
-	else
-		drvdata->lpoverride = false;
+	drvdata->lpoverride = (etmidr5 & TRCIDR5_LPOVERRIDE) && (!drvdata->skip_power_up);
 	/* NUMSEQSTATE, bits[27:25] number of sequencer states implemented */
-	drvdata->nrseqstate = BMVAL(etmidr5, 25, 27);
+	drvdata->nrseqstate = REG_VAL(etmidr5, TRCIDR5_NUMSEQSTATE);
 	/* NUMCNTR, bits[30:28] number of counters available for tracing */
-	drvdata->nr_cntr = BMVAL(etmidr5, 28, 30);
+	drvdata->nr_cntr = REG_VAL(etmidr5, TRCIDR5_NUMCNTR);
 	etm4_cs_lock(drvdata, csa);
 	cpu_detect_trace_filtering(drvdata);
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 0b22c57a9da1..ca6ed39ceaf7 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -183,6 +183,17 @@
 #define TRCIDR4_NUMVMIDC_SHIFT			28
 #define TRCIDR4_NUMVMIDC_MASK			GENMASK(3, 0)
 
+#define TRCIDR5_NUMEXTIN_SHIFT			0
+#define TRCIDR5_NUMEXTIN_MASK			GENMASK(8, 0)
+#define TRCIDR5_TRACEIDSIZE_SHIFT		16
+#define TRCIDR5_TRACEIDSIZE_MASK		GENMASK(5, 0)
+#define TRCIDR5_ATBTRIG				BIT(22)
+#define TRCIDR5_LPOVERRIDE			BIT(23)
+#define TRCIDR5_NUMSEQSTATE_SHIFT		25
+#define TRCIDR5_NUMSEQSTATE_MASK		GENMASK(2, 0)
+#define TRCIDR5_NUMCNTR_SHIFT			28
+#define TRCIDR5_NUMCNTR_MASK			GENMASK(2, 0)
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
-- 
2.28.0

