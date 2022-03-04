Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FBF4CDA1C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241063AbiCDRVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241040AbiCDRUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:20:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B4591C7EA0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:19:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2C421424;
        Fri,  4 Mar 2022 09:19:53 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.42.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3BC4E3F73D;
        Fri,  4 Mar 2022 09:19:52 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com
Cc:     mathieu.poirier@linaro.org, leo.yan@linaro.com,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/15] coresight: etm4x: Cleanup TRCSSCCRn and TRCSSCSRn register accesses
Date:   Fri,  4 Mar 2022 17:19:09 +0000
Message-Id: <20220304171913.2292458-13-james.clark@arm.com>
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
 drivers/hwtracing/coresight/coresight-etm4x-core.c  | 2 +-
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 6 +++---
 drivers/hwtracing/coresight/coresight-etm4x.h       | 4 ++++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 88353f8ba414..87299e99dabb 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -443,7 +443,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
 		/* always clear status bit on restart if using single-shot */
 		if (config->ss_ctrl[i] || config->ss_pe_cmp[i])
-			config->ss_status[i] &= ~BIT(31);
+			config->ss_status[i] &= ~TRCSSCSRn_STATUS;
 		etm4x_relaxed_write32(csa, config->ss_ctrl[i], TRCSSCCRn(i));
 		etm4x_relaxed_write32(csa, config->ss_status[i], TRCSSCSRn(i));
 		if (etm4x_sspcicrn_present(drvdata, i))
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 29188b1a4646..7dd7636fc2a7 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1792,9 +1792,9 @@ static ssize_t sshot_ctrl_store(struct device *dev,
 
 	spin_lock(&drvdata->spinlock);
 	idx = config->ss_idx;
-	config->ss_ctrl[idx] = val & GENMASK(24, 0);
+	config->ss_ctrl[idx] = FIELD_PREP(TRCSSCCRn_SAC_ARC_RST_MASK, val);
 	/* must clear bit 31 in related status register on programming */
-	config->ss_status[idx] &= ~BIT(31);
+	config->ss_status[idx] &= ~TRCSSCSRn_STATUS;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1844,7 +1844,7 @@ static ssize_t sshot_pe_ctrl_store(struct device *dev,
 	idx = config->ss_idx;
 	config->ss_pe_cmp[idx] = val & GENMASK(7, 0);
 	/* must clear bit 31 in related status register on programming */
-	config->ss_status[idx] &= ~BIT(31);
+	config->ss_status[idx] &= ~TRCSSCSRn_STATUS;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 802ddbe2eecd..b4217eaab450 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -214,6 +214,10 @@
 #define TRCACATRn_CONTEXTTYPE_VMID		BIT(3)
 #define TRCACATRn_CONTEXT_MASK			GENMASK(6, 4)
 #define TRCACATRn_EXLEVEL_MASK			GENMASK(14, 8)
+
+#define TRCSSCSRn_STATUS			BIT(31)
+#define TRCSSCCRn_SAC_ARC_RST_MASK		GENMASK(24, 0)
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
-- 
2.28.0

