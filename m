Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8284CDA03
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241008AbiCDRU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241006AbiCDRUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:20:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4451514EF59
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:19:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACC021424;
        Fri,  4 Mar 2022 09:19:29 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.42.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 166803F73D;
        Fri,  4 Mar 2022 09:19:27 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com
Cc:     mathieu.poirier@linaro.org, leo.yan@linaro.com,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/15] coresight: etm4x: Cleanup TRCIDR3 register accesses
Date:   Fri,  4 Mar 2022 17:19:00 +0000
Message-Id: <20220304171913.2292458-4-james.clark@arm.com>
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
 .../coresight/coresight-etm4x-core.c          | 40 +++++--------------
 drivers/hwtracing/coresight/coresight-etm4x.h | 10 +++++
 2 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index fd44231e9d8a..1b377f6b31bf 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1124,53 +1124,33 @@ static void etm4_init_arch_data(void *info)
 
 	etmidr3 = etm4x_relaxed_read32(csa, TRCIDR3);
 	/* CCITMIN, bits[11:0] minimum threshold value that can be programmed */
-	drvdata->ccitmin = BMVAL(etmidr3, 0, 11);
+	drvdata->ccitmin = FIELD_GET(TRCIDR3_CCITMIN_MASK, etmidr3);
 	/* EXLEVEL_S, bits[19:16] Secure state instruction tracing */
-	drvdata->s_ex_level = BMVAL(etmidr3, 16, 19);
+	drvdata->s_ex_level = FIELD_GET(TRCIDR3_EXLEVEL_S_MASK, etmidr3);
 	drvdata->config.s_ex_level = drvdata->s_ex_level;
 	/* EXLEVEL_NS, bits[23:20] Non-secure state instruction tracing */
-	drvdata->ns_ex_level = BMVAL(etmidr3, 20, 23);
-
+	drvdata->ns_ex_level = FIELD_GET(TRCIDR3_EXLEVEL_NS_MASK, etmidr3);
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
+	drvdata->nr_pe =  (FIELD_GET(TRCIDR3_NUMPROC_HI_MASK, etmidr3) << 3) |
+			   FIELD_GET(TRCIDR3_NUMPROC_LO_MASK, etmidr3);
 	/* NOOVERFLOW, bit[31] is trace overflow prevention supported */
-	if (BMVAL(etmidr3, 31, 31))
-		drvdata->nooverflow = true;
-	else
-		drvdata->nooverflow = false;
+	drvdata->nooverflow = !!(etmidr3 & TRCIDR3_NOOVERFLOW);
 
 	/* number of resources trace unit supports */
 	etmidr4 = etm4x_relaxed_read32(csa, TRCIDR4);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index cfdf966016b7..1b95c63938f0 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -147,6 +147,16 @@
 #define TRCIDR2_VMIDSIZE_MASK			GENMASK(14, 10)
 #define TRCIDR2_CCSIZE_MASK			GENMASK(28, 25)
 
+#define TRCIDR3_CCITMIN_MASK			GENMASK(11, 0)
+#define TRCIDR3_EXLEVEL_S_MASK			GENMASK(19, 16)
+#define TRCIDR3_EXLEVEL_NS_MASK			GENMASK(23, 20)
+#define TRCIDR3_TRCERR				BIT(24)
+#define TRCIDR3_SYNCPR				BIT(25)
+#define TRCIDR3_STALLCTL			BIT(26)
+#define TRCIDR3_SYSSTALL			BIT(27)
+#define TRCIDR3_NUMPROC_LO_MASK			GENMASK(30, 28)
+#define TRCIDR3_NUMPROC_HI_MASK			GENMASK(13, 12)
+#define TRCIDR3_NOOVERFLOW			BIT(31)
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
-- 
2.28.0

