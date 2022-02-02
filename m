Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B5B4A7547
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345680AbiBBQC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:02:56 -0500
Received: from foss.arm.com ([217.140.110.172]:39744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345678AbiBBQCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:02:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4CBD11FB;
        Wed,  2 Feb 2022 08:02:52 -0800 (PST)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C6B283F73B;
        Wed,  2 Feb 2022 08:02:50 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, coresight@lists.linaro.org
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] coresight: Make ETM4x TRCIDR4 register accesses consistent with sysreg.h
Date:   Wed,  2 Feb 2022 16:02:14 +0000
Message-Id: <20220202160226.37858-5-james.clark@arm.com>
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
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 12 ++++++------
 drivers/hwtracing/coresight/coresight-etm4x.h      | 14 ++++++++++++++
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index f973e7187b1f..78f01c9e45cb 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1150,9 +1150,9 @@ static void etm4_init_arch_data(void *info)
 	/* number of resources trace unit supports */
 	etmidr4 = etm4x_relaxed_read32(csa, TRCIDR4);
 	/* NUMACPAIRS, bits[0:3] number of addr comparator pairs for tracing */
-	drvdata->nr_addr_cmp = BMVAL(etmidr4, 0, 3);
+	drvdata->nr_addr_cmp = REG_VAL(etmidr4, TRCIDR4_NUMACPAIRS);
 	/* NUMPC, bits[15:12] number of PE comparator inputs for tracing */
-	drvdata->nr_pe_cmp = BMVAL(etmidr4, 12, 15);
+	drvdata->nr_pe_cmp = REG_VAL(etmidr4, TRCIDR4_NUMPC);
 	/*
 	 * NUMRSPAIR, bits[19:16]
 	 * The number of resource pairs conveyed by the HW starts at 0, i.e a
@@ -1163,7 +1163,7 @@ static void etm4_init_arch_data(void *info)
 	 * the default TRUE and FALSE resource selectors are omitted.
 	 * Otherwise for values 0x1 and above the number is N + 1 as per v4.2.
 	 */
-	drvdata->nr_resource = BMVAL(etmidr4, 16, 19);
+	drvdata->nr_resource = REG_VAL(etmidr4, TRCIDR4_NUMRSPAIR);
 	if ((drvdata->arch < ETM_ARCH_V4_3) || (drvdata->nr_resource > 0))
 		drvdata->nr_resource += 1;
 	/*
@@ -1171,15 +1171,15 @@ static void etm4_init_arch_data(void *info)
 	 * comparator control for tracing. Read any status regs as these
 	 * also contain RO capability data.
 	 */
-	drvdata->nr_ss_cmp = BMVAL(etmidr4, 20, 23);
+	drvdata->nr_ss_cmp = REG_VAL(etmidr4, TRCIDR4_NUMSSCC);
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
 		drvdata->config.ss_status[i] =
 			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
 	}
 	/* NUMCIDC, bits[27:24] number of Context ID comparators for tracing */
-	drvdata->numcidc = BMVAL(etmidr4, 24, 27);
+	drvdata->numcidc = REG_VAL(etmidr4, TRCIDR4_NUMCIDC);
 	/* NUMVMIDC, bits[31:28] number of VMID comparators for tracing */
-	drvdata->numvmidc = BMVAL(etmidr4, 28, 31);
+	drvdata->numvmidc = REG_VAL(etmidr4, TRCIDR4_NUMVMIDC);
 
 	etmidr5 = etm4x_relaxed_read32(csa, TRCIDR5);
 	/* NUMEXTIN, bits[8:0] number of external inputs implemented */
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 051d7948f15b..0b22c57a9da1 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -169,6 +169,20 @@
 #define TRCIDR3_NUMPROC_HI_SHIFT		12
 #define TRCIDR3_NUMPROC_HI_MASK			GENMASK(1, 0)
 #define TRCIDR3_NOOVERFLOW			BIT(31)
+
+#define TRCIDR4_NUMACPAIRS_SHIFT		0
+#define TRCIDR4_NUMACPAIRS_MASK			GENMASK(3, 0)
+#define TRCIDR4_NUMPC_SHIFT			12
+#define TRCIDR4_NUMPC_MASK			GENMASK(3, 0)
+#define TRCIDR4_NUMRSPAIR_SHIFT			16
+#define TRCIDR4_NUMRSPAIR_MASK			GENMASK(3, 0)
+#define TRCIDR4_NUMSSCC_SHIFT			20
+#define TRCIDR4_NUMSSCC_MASK			GENMASK(3, 0)
+#define TRCIDR4_NUMCIDC_SHIFT			24
+#define TRCIDR4_NUMCIDC_MASK			GENMASK(3, 0)
+#define TRCIDR4_NUMVMIDC_SHIFT			28
+#define TRCIDR4_NUMVMIDC_MASK			GENMASK(3, 0)
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
-- 
2.28.0

