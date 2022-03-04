Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105C54CDA02
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240988AbiCDRUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241017AbiCDRU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:20:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96A0714FBCB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:19:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 667A41478;
        Fri,  4 Mar 2022 09:19:32 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.42.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C3FB33F73D;
        Fri,  4 Mar 2022 09:19:30 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com
Cc:     mathieu.poirier@linaro.org, leo.yan@linaro.com,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/15] coresight: etm4x: Cleanup TRCIDR4 register accesses
Date:   Fri,  4 Mar 2022 17:19:01 +0000
Message-Id: <20220304171913.2292458-5-james.clark@arm.com>
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
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 12 ++++++------
 drivers/hwtracing/coresight/coresight-etm4x.h      |  8 ++++++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 1b377f6b31bf..c52ab7f29f41 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1155,9 +1155,9 @@ static void etm4_init_arch_data(void *info)
 	/* number of resources trace unit supports */
 	etmidr4 = etm4x_relaxed_read32(csa, TRCIDR4);
 	/* NUMACPAIRS, bits[0:3] number of addr comparator pairs for tracing */
-	drvdata->nr_addr_cmp = BMVAL(etmidr4, 0, 3);
+	drvdata->nr_addr_cmp = FIELD_GET(TRCIDR4_NUMACPAIRS_MASK, etmidr4);
 	/* NUMPC, bits[15:12] number of PE comparator inputs for tracing */
-	drvdata->nr_pe_cmp = BMVAL(etmidr4, 12, 15);
+	drvdata->nr_pe_cmp = FIELD_GET(TRCIDR4_NUMPC_MASK, etmidr4);
 	/*
 	 * NUMRSPAIR, bits[19:16]
 	 * The number of resource pairs conveyed by the HW starts at 0, i.e a
@@ -1168,7 +1168,7 @@ static void etm4_init_arch_data(void *info)
 	 * the default TRUE and FALSE resource selectors are omitted.
 	 * Otherwise for values 0x1 and above the number is N + 1 as per v4.2.
 	 */
-	drvdata->nr_resource = BMVAL(etmidr4, 16, 19);
+	drvdata->nr_resource = FIELD_GET(TRCIDR4_NUMRSPAIR_MASK, etmidr4);
 	if ((drvdata->arch < ETM_ARCH_V4_3) || (drvdata->nr_resource > 0))
 		drvdata->nr_resource += 1;
 	/*
@@ -1176,15 +1176,15 @@ static void etm4_init_arch_data(void *info)
 	 * comparator control for tracing. Read any status regs as these
 	 * also contain RO capability data.
 	 */
-	drvdata->nr_ss_cmp = BMVAL(etmidr4, 20, 23);
+	drvdata->nr_ss_cmp = FIELD_GET(TRCIDR4_NUMSSCC_MASK, etmidr4);
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
 		drvdata->config.ss_status[i] =
 			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
 	}
 	/* NUMCIDC, bits[27:24] number of Context ID comparators for tracing */
-	drvdata->numcidc = BMVAL(etmidr4, 24, 27);
+	drvdata->numcidc = FIELD_GET(TRCIDR4_NUMCIDC_MASK, etmidr4);
 	/* NUMVMIDC, bits[31:28] number of VMID comparators for tracing */
-	drvdata->numvmidc = BMVAL(etmidr4, 28, 31);
+	drvdata->numvmidc = FIELD_GET(TRCIDR4_NUMVMIDC_MASK, etmidr4);
 
 	etmidr5 = etm4x_relaxed_read32(csa, TRCIDR5);
 	/* NUMEXTIN, bits[8:0] number of external inputs implemented */
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 1b95c63938f0..c9c5fd655196 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -157,6 +157,14 @@
 #define TRCIDR3_NUMPROC_LO_MASK			GENMASK(30, 28)
 #define TRCIDR3_NUMPROC_HI_MASK			GENMASK(13, 12)
 #define TRCIDR3_NOOVERFLOW			BIT(31)
+
+#define TRCIDR4_NUMACPAIRS_MASK			GENMASK(3, 0)
+#define TRCIDR4_NUMPC_MASK			GENMASK(15, 12)
+#define TRCIDR4_NUMRSPAIR_MASK			GENMASK(19, 16)
+#define TRCIDR4_NUMSSCC_MASK			GENMASK(23, 20)
+#define TRCIDR4_NUMCIDC_MASK			GENMASK(27, 24)
+#define TRCIDR4_NUMVMIDC_MASK			GENMASK(31, 28)
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
-- 
2.28.0

