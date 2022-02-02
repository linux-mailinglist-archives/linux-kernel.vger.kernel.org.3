Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CC34A7548
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345652AbiBBQCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:02:44 -0500
Received: from foss.arm.com ([217.140.110.172]:39692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343957AbiBBQCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:02:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69ED611FB;
        Wed,  2 Feb 2022 08:02:42 -0800 (PST)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5A6C53F73B;
        Wed,  2 Feb 2022 08:02:40 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, coresight@lists.linaro.org
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] coresight: Make ETM4x TRCIDR0 register accesses consistent with sysreg.h
Date:   Wed,  2 Feb 2022 16:02:11 +0000
Message-Id: <20220202160226.37858-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220202160226.37858-1-james.clark@arm.com>
References: <20220202160226.37858-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a no-op change for style and consistency and has no effect on the
binary produced by gcc-11.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 37 +++++--------------
 drivers/hwtracing/coresight/coresight-etm4x.h | 17 +++++++++
 drivers/hwtracing/coresight/coresight-priv.h  |  1 +
 3 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index bf18128cf5de..8aefee4e72fd 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1091,41 +1091,22 @@ static void etm4_init_arch_data(void *info)
 	etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
 
 	/* INSTP0, bits[2:1] P0 tracing support field */
-	if (BMVAL(etmidr0, 1, 1) && BMVAL(etmidr0, 2, 2))
-		drvdata->instrp0 = true;
-	else
-		drvdata->instrp0 = false;
-
+	drvdata->instrp0 = !!((REG_VAL(etmidr0, TRCIDR0_INSTP0) & 0b01) &&
+			      (REG_VAL(etmidr0, TRCIDR0_INSTP0) & 0b10));
 	/* TRCBB, bit[5] Branch broadcast tracing support bit */
-	if (BMVAL(etmidr0, 5, 5))
-		drvdata->trcbb = true;
-	else
-		drvdata->trcbb = false;
-
+	drvdata->trcbb = !!(etmidr0 & TRCIDR0_TRCBB);
 	/* TRCCOND, bit[6] Conditional instruction tracing support bit */
-	if (BMVAL(etmidr0, 6, 6))
-		drvdata->trccond = true;
-	else
-		drvdata->trccond = false;
-
+	drvdata->trccond = !!(etmidr0 & TRCIDR0_TRCCOND);
 	/* TRCCCI, bit[7] Cycle counting instruction bit */
-	if (BMVAL(etmidr0, 7, 7))
-		drvdata->trccci = true;
-	else
-		drvdata->trccci = false;
-
+	drvdata->trccci = !!(etmidr0 & TRCIDR0_TRCCCI);
 	/* RETSTACK, bit[9] Return stack bit */
-	if (BMVAL(etmidr0, 9, 9))
-		drvdata->retstack = true;
-	else
-		drvdata->retstack = false;
-
+	drvdata->retstack = !!(etmidr0 & TRCIDR0_RETSTACK);
 	/* NUMEVENT, bits[11:10] Number of events field */
-	drvdata->nr_event = BMVAL(etmidr0, 10, 11);
+	drvdata->nr_event = REG_VAL(etmidr0, TRCIDR0_NUMEVENT);
 	/* QSUPP, bits[16:15] Q element support field */
-	drvdata->q_support = BMVAL(etmidr0, 15, 16);
+	drvdata->q_support = REG_VAL(etmidr0, TRCIDR0_QSUPP);
 	/* TSSIZE, bits[28:24] Global timestamp size field */
-	drvdata->ts_size = BMVAL(etmidr0, 24, 28);
+	drvdata->ts_size = REG_VAL(etmidr0, TRCIDR0_TSSIZE);
 
 	/* maximum size of resources */
 	etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 3c4d69b096ca..2bd8ad953b8e 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -130,6 +130,23 @@
 
 #define TRCRSR_TA			BIT(12)
 
+/*
+ * Bit positions of registers that are defined above, in the sysreg.h style
+ * of _MASK, _SHIFT and BIT().
+ */
+#define TRCIDR0_INSTP0_SHIFT			1
+#define TRCIDR0_INSTP0_MASK			GENMASK(1, 0)
+#define TRCIDR0_TRCBB				BIT(5)
+#define TRCIDR0_TRCCOND				BIT(6)
+#define TRCIDR0_TRCCCI				BIT(7)
+#define TRCIDR0_RETSTACK			BIT(9)
+#define TRCIDR0_NUMEVENT_SHIFT			10
+#define TRCIDR0_NUMEVENT_MASK			GENMASK(1, 0)
+#define TRCIDR0_QSUPP_SHIFT			15
+#define TRCIDR0_QSUPP_MASK			GENMASK(1, 0)
+#define TRCIDR0_TSSIZE_SHIFT			24
+#define TRCIDR0_TSSIZE_MASK			GENMASK(4, 0)
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index ff1dd2092ac5..e22fa6184c6d 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -36,6 +36,7 @@
 
 #define TIMEOUT_US		100
 #define BMVAL(val, lsb, msb)	((val & GENMASK(msb, lsb)) >> lsb)
+#define REG_VAL(val, name)	((val & (name##_MASK << name##_SHIFT)) >> name##_SHIFT)
 
 #define ETM_MODE_EXCL_KERN	BIT(30)
 #define ETM_MODE_EXCL_USER	BIT(31)
-- 
2.28.0

