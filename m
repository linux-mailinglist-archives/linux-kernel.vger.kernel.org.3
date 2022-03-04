Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5AC4CD9FF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240998AbiCDRUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240981AbiCDRUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:20:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AF1A143445
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:19:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 613C31478;
        Fri,  4 Mar 2022 09:19:24 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.42.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BC6463F73D;
        Fri,  4 Mar 2022 09:19:22 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com
Cc:     mathieu.poirier@linaro.org, leo.yan@linaro.com,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/15] coresight: etm4x: Cleanup TRCIDR0 register accesses
Date:   Fri,  4 Mar 2022 17:18:58 +0000
Message-Id: <20220304171913.2292458-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220304171913.2292458-1-james.clark@arm.com>
References: <20220304171913.2292458-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a no-op change for style and consistency and has no effect on
the binary output by the compiler. In sysreg.h fields are defined as
the register name followed by the field name and then _MASK. This
allows for grepping for fields by name rather than using magic numbers.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 36 +++++--------------
 drivers/hwtracing/coresight/coresight-etm4x.h | 13 +++++++
 2 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 7f416a12000e..9120390a7613 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1097,41 +1097,21 @@ static void etm4_init_arch_data(void *info)
 	etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
 
 	/* INSTP0, bits[2:1] P0 tracing support field */
-	if (BMVAL(etmidr0, 1, 2) == 0b11)
-		drvdata->instrp0 = true;
-	else
-		drvdata->instrp0 = false;
-
+	drvdata->instrp0 = !!(FIELD_GET(TRCIDR0_INSTP0_MASK, etmidr0) == 0b11);
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
+	drvdata->nr_event = FIELD_GET(TRCIDR0_NUMEVENT_MASK, etmidr0);
 	/* QSUPP, bits[16:15] Q element support field */
-	drvdata->q_support = BMVAL(etmidr0, 15, 16);
+	drvdata->q_support = FIELD_GET(TRCIDR0_QSUPP_MASK, etmidr0);
 	/* TSSIZE, bits[28:24] Global timestamp size field */
-	drvdata->ts_size = BMVAL(etmidr0, 24, 28);
+	drvdata->ts_size = FIELD_GET(TRCIDR0_TSSIZE_MASK, etmidr0);
 
 	/* maximum size of resources */
 	etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 3c4d69b096ca..300741fbc0de 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -130,6 +130,19 @@
 
 #define TRCRSR_TA			BIT(12)
 
+/*
+ * Bit positions of registers that are defined above, in the sysreg.h style
+ * of _MASK for multi bit fields and BIT() for single bits.
+ */
+#define TRCIDR0_INSTP0_MASK			GENMASK(2, 1)
+#define TRCIDR0_TRCBB				BIT(5)
+#define TRCIDR0_TRCCOND				BIT(6)
+#define TRCIDR0_TRCCCI				BIT(7)
+#define TRCIDR0_RETSTACK			BIT(9)
+#define TRCIDR0_NUMEVENT_MASK			GENMASK(11, 10)
+#define TRCIDR0_QSUPP_MASK			GENMASK(16, 15)
+#define TRCIDR0_TSSIZE_MASK			GENMASK(28, 24)
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
-- 
2.28.0

