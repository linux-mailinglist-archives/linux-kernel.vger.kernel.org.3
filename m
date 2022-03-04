Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805754CDA01
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241004AbiCDRUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240991AbiCDRUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:20:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DDDE14CDA3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:19:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BCDD14BF;
        Fri,  4 Mar 2022 09:19:27 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.42.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6965C3F73D;
        Fri,  4 Mar 2022 09:19:25 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com
Cc:     mathieu.poirier@linaro.org, leo.yan@linaro.com,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/15] coresight: etm4x: Cleanup TRCIDR2 register accesses
Date:   Fri,  4 Mar 2022 17:18:59 +0000
Message-Id: <20220304171913.2292458-3-james.clark@arm.com>
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
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 6 +++---
 drivers/hwtracing/coresight/coresight-etm4x.h      | 4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 9120390a7613..fd44231e9d8a 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1116,11 +1116,11 @@ static void etm4_init_arch_data(void *info)
 	/* maximum size of resources */
 	etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
 	/* CIDSIZE, bits[9:5] Indicates the Context ID size */
-	drvdata->ctxid_size = BMVAL(etmidr2, 5, 9);
+	drvdata->ctxid_size = FIELD_GET(TRCIDR2_CIDSIZE_MASK, etmidr2);
 	/* VMIDSIZE, bits[14:10] Indicates the VMID size */
-	drvdata->vmid_size = BMVAL(etmidr2, 10, 14);
+	drvdata->vmid_size = FIELD_GET(TRCIDR2_VMIDSIZE_MASK, etmidr2);
 	/* CCSIZE, bits[28:25] size of the cycle counter in bits minus 12 */
-	drvdata->ccsize = BMVAL(etmidr2, 25, 28);
+	drvdata->ccsize = FIELD_GET(TRCIDR2_CCSIZE_MASK, etmidr2);
 
 	etmidr3 = etm4x_relaxed_read32(csa, TRCIDR3);
 	/* CCITMIN, bits[11:0] minimum threshold value that can be programmed */
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 300741fbc0de..cfdf966016b7 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -143,6 +143,10 @@
 #define TRCIDR0_QSUPP_MASK			GENMASK(16, 15)
 #define TRCIDR0_TSSIZE_MASK			GENMASK(28, 24)
 
+#define TRCIDR2_CIDSIZE_MASK			GENMASK(9, 5)
+#define TRCIDR2_VMIDSIZE_MASK			GENMASK(14, 10)
+#define TRCIDR2_CCSIZE_MASK			GENMASK(28, 25)
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
-- 
2.28.0

