Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D19D4A838A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350506AbiBCMHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:07:04 -0500
Received: from foss.arm.com ([217.140.110.172]:42676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350469AbiBCMGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:06:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C7861396;
        Thu,  3 Feb 2022 04:06:49 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.13.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 85AB53F774;
        Thu,  3 Feb 2022 04:06:47 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     leo.yan@linaro.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/15] coresight: Make ETM4x TRCRSCTLRn register accesses consistent with sysreg.h
Date:   Thu,  3 Feb 2022 12:06:03 +0000
Message-Id: <20220203120604.128396-16-james.clark@arm.com>
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
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 7 +++++--
 drivers/hwtracing/coresight/coresight-etm4x.h       | 9 +++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index a0cdd2cd978a..c876a63fa84d 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1728,8 +1728,11 @@ static ssize_t res_ctrl_store(struct device *dev,
 	/* For odd idx pair inversal bit is RES0 */
 	if (idx % 2 != 0)
 		/* PAIRINV, bit[21] */
-		val &= ~BIT(21);
-	config->res_ctrl[idx] = val & GENMASK(21, 0);
+		val &= ~TRCRSCTLRn_PAIRINV;
+	config->res_ctrl[idx] = val & (TRCRSCTLRn_PAIRINV |
+				       TRCRSCTLRn_INV |
+				       (TRCRSCTLRn_GROUP_MASK << TRCRSCTLRn_GROUP_SHIFT) |
+				       (TRCRSCTLRn_SELECT_MASK << TRCRSCTLRn_SELECT_SHIFT));
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 4d943faade33..dd2156a5e70b 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -258,6 +258,15 @@
 #define TRCBBCTLR_RANGE_SHIFT			0
 #define TRCBBCTLR_RANGE_MASK			GENMASK(7, 0)
 
+#define TRCRSCTLRn_PAIRINV			BIT(21)
+#define TRCRSCTLRn_INV				BIT(20)
+#define TRCRSCTLRn_GROUP_SHIFT			16
+#define TRCRSCTLRn_GROUP_MASK			GENMASK(3, 0)
+#define TRCRSCTLRn_SELECT_SHIFT			0
+#define TRCRSCTLRn_SELECT_MASK			GENMASK(15, 0)
+
+
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
-- 
2.28.0

