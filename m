Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D0D4A7554
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345761AbiBBQDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:03:36 -0500
Received: from foss.arm.com ([217.140.110.172]:39892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345733AbiBBQDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:03:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BF0E11D4;
        Wed,  2 Feb 2022 08:03:21 -0800 (PST)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BBF503F73B;
        Wed,  2 Feb 2022 08:03:18 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, coresight@lists.linaro.org
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] coresight: Make ETM4x TRCSSCCRn and TRCSSCSRn register accesses consistent with sysreg.h
Date:   Wed,  2 Feb 2022 16:02:22 +0000
Message-Id: <20220202160226.37858-13-james.clark@arm.com>
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
 drivers/hwtracing/coresight/coresight-etm4x-core.c  | 2 +-
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 6 +++---
 drivers/hwtracing/coresight/coresight-etm4x.h       | 5 +++++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 00285e2533b5..e7a9490c509d 100644
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
index 51f6e13e3b29..7d9372ba1168 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1793,9 +1793,9 @@ static ssize_t sshot_ctrl_store(struct device *dev,
 
 	spin_lock(&drvdata->spinlock);
 	idx = config->ss_idx;
-	config->ss_ctrl[idx] = val & GENMASK(24, 0);
+	config->ss_ctrl[idx] = val & (TRCSSCCRn_SAC_ARC_RST_MASK << TRCSSCCRn_SAC_ARC_RST_SHIFT);
 	/* must clear bit 31 in related status register on programming */
-	config->ss_status[idx] &= ~BIT(31);
+	config->ss_status[idx] &= ~TRCSSCSRn_STATUS;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1845,7 +1845,7 @@ static ssize_t sshot_pe_ctrl_store(struct device *dev,
 	idx = config->ss_idx;
 	config->ss_pe_cmp[idx] = val & GENMASK(7, 0);
 	/* must clear bit 31 in related status register on programming */
-	config->ss_status[idx] &= ~BIT(31);
+	config->ss_status[idx] &= ~TRCSSCSRn_STATUS;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 5701d970d81a..9c22a5b0777f 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -246,6 +246,11 @@
 #define TRCACATRn_CONTEXT_MASK			GENMASK(2, 0)
 #define TRCACATRn_EXLEVEL_SHIFT			8
 #define TRCACATRn_EXLEVEL_MASK			GENMASK(6, 0)
+
+#define TRCSSCSRn_STATUS			BIT(31)
+#define TRCSSCCRn_SAC_ARC_RST_SHIFT		0
+#define TRCSSCCRn_SAC_ARC_RST_MASK		GENMASK(24, 0)
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
-- 
2.28.0

