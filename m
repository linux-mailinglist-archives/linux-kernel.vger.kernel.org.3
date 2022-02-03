Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9874A8382
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350403AbiBCMGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:06:22 -0500
Received: from foss.arm.com ([217.140.110.172]:42474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350400AbiBCMGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:06:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA75E1396;
        Thu,  3 Feb 2022 04:06:17 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.13.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 302E23F774;
        Thu,  3 Feb 2022 04:06:16 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     leo.yan@linaro.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/15] coresight: Make ETM4x TRCIDR3 register accesses consistent with sysreg.h
Date:   Thu,  3 Feb 2022 12:05:51 +0000
Message-Id: <20220203120604.128396-4-james.clark@arm.com>
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
 .../coresight/coresight-etm4x-core.c          | 40 +++++--------------
 drivers/hwtracing/coresight/coresight-etm4x.h | 15 +++++++
 2 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 891cfcd93f94..ba43fb9a4526 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1118,53 +1118,33 @@ static void etm4_init_arch_data(void *info)
 
 	etmidr3 = etm4x_relaxed_read32(csa, TRCIDR3);
 	/* CCITMIN, bits[11:0] minimum threshold value that can be programmed */
-	drvdata->ccitmin = BMVAL(etmidr3, 0, 11);
+	drvdata->ccitmin = REG_VAL(etmidr3, TRCIDR3_CCITMIN);
 	/* EXLEVEL_S, bits[19:16] Secure state instruction tracing */
-	drvdata->s_ex_level = BMVAL(etmidr3, 16, 19);
+	drvdata->s_ex_level = REG_VAL(etmidr3, TRCIDR3_EXLEVEL_S);
 	drvdata->config.s_ex_level = drvdata->s_ex_level;
 	/* EXLEVEL_NS, bits[23:20] Non-secure state instruction tracing */
-	drvdata->ns_ex_level = BMVAL(etmidr3, 20, 23);
-
+	drvdata->ns_ex_level = REG_VAL(etmidr3, TRCIDR3_EXLEVEL_NS);
 	/*
 	 * TRCERR, bit[24] whether a trace unit can trace a
 	 * system error exception.
 	 */
-	if (BMVAL(etmidr3, 24, 24))
-		drvdata->trc_error = true;
-	else
-		drvdata->trc_error = false;
-
+	drvdata->trc_error = !!(etmidr3 & TRCIDR3_TRCERR);
 	/* SYNCPR, bit[25] implementation has a fixed synchronization period? */
-	if (BMVAL(etmidr3, 25, 25))
-		drvdata->syncpr = true;
-	else
-		drvdata->syncpr = false;
-
+	drvdata->syncpr = !!(etmidr3 & TRCIDR3_SYNCPR);
 	/* STALLCTL, bit[26] is stall control implemented? */
-	if (BMVAL(etmidr3, 26, 26))
-		drvdata->stallctl = true;
-	else
-		drvdata->stallctl = false;
-
+	drvdata->stallctl = !!(etmidr3 & TRCIDR3_STALLCTL);
 	/* SYSSTALL, bit[27] implementation can support stall control? */
-	if (BMVAL(etmidr3, 27, 27))
-		drvdata->sysstall = true;
-	else
-		drvdata->sysstall = false;
-
+	drvdata->sysstall = !!(etmidr3 & TRCIDR3_SYSSTALL);
 	/*
 	 * NUMPROC - the number of PEs available for tracing, 5bits
 	 *         = TRCIDR3.bits[13:12]bits[30:28]
 	 *  bits[4:3] = TRCIDR3.bits[13:12] (since etm-v4.2, otherwise RES0)
 	 *  bits[3:0] = TRCIDR3.bits[30:28]
 	 */
-	drvdata->nr_pe = (BMVAL(etmidr3, 12, 13) << 3) | BMVAL(etmidr3, 28, 30);
-
+	drvdata->nr_pe = (REG_VAL(etmidr3, TRCIDR3_NUMPROC_HI) << 3) |
+			  REG_VAL(etmidr3, TRCIDR3_NUMPROC_LO);
 	/* NOOVERFLOW, bit[31] is trace overflow prevention supported */
-	if (BMVAL(etmidr3, 31, 31))
-		drvdata->nooverflow = true;
-	else
-		drvdata->nooverflow = false;
+	drvdata->nooverflow = !!(etmidr3 & TRCIDR3_NOOVERFLOW);
 
 	/* number of resources trace unit supports */
 	etmidr4 = etm4x_relaxed_read32(csa, TRCIDR4);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index a95df5686b4b..051d7948f15b 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -154,6 +154,21 @@
 #define TRCIDR2_CCSIZE_SHIFT			25
 #define TRCIDR2_CCSIZE_MASK			GENMASK(3, 0)
 
+#define TRCIDR3_CCITMIN_SHIFT			0
+#define TRCIDR3_CCITMIN_MASK			GENMASK(11, 0)
+#define TRCIDR3_EXLEVEL_S_SHIFT			16
+#define TRCIDR3_EXLEVEL_S_MASK			GENMASK(3, 0)
+#define TRCIDR3_EXLEVEL_NS_SHIFT		20
+#define TRCIDR3_EXLEVEL_NS_MASK			GENMASK(3, 0)
+#define TRCIDR3_TRCERR				BIT(24)
+#define TRCIDR3_SYNCPR				BIT(25)
+#define TRCIDR3_STALLCTL			BIT(26)
+#define TRCIDR3_SYSSTALL			BIT(27)
+#define TRCIDR3_NUMPROC_LO_SHIFT		28
+#define TRCIDR3_NUMPROC_LO_MASK			GENMASK(2, 0)
+#define TRCIDR3_NUMPROC_HI_SHIFT		12
+#define TRCIDR3_NUMPROC_HI_MASK			GENMASK(1, 0)
+#define TRCIDR3_NOOVERFLOW			BIT(31)
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
-- 
2.28.0

