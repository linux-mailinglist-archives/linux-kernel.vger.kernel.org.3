Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F86A4A7555
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345701AbiBBQDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:03:41 -0500
Received: from foss.arm.com ([217.140.110.172]:39946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343607AbiBBQDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:03:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E62311FB;
        Wed,  2 Feb 2022 08:03:32 -0800 (PST)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6C2423F73B;
        Wed,  2 Feb 2022 08:03:30 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, coresight@lists.linaro.org
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] coresight: Make ETM4x TRCRSCTLRn register accesses consistent with sysreg.h
Date:   Wed,  2 Feb 2022 16:02:25 +0000
Message-Id: <20220202160226.37858-16-james.clark@arm.com>
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

