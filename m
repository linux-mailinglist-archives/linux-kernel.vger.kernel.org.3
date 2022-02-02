Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D774A7549
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiBBQCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:02:48 -0500
Received: from foss.arm.com ([217.140.110.172]:39712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345665AbiBBQCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:02:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 183D911D4;
        Wed,  2 Feb 2022 08:02:46 -0800 (PST)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B6FBF3F73B;
        Wed,  2 Feb 2022 08:02:43 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, coresight@lists.linaro.org
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] coresight: Make ETM4x TRCIDR2 register accesses consistent with sysreg.h
Date:   Wed,  2 Feb 2022 16:02:12 +0000
Message-Id: <20220202160226.37858-3-james.clark@arm.com>
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
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 6 +++---
 drivers/hwtracing/coresight/coresight-etm4x.h      | 7 +++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 8aefee4e72fd..4abe5444234e 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1111,11 +1111,11 @@ static void etm4_init_arch_data(void *info)
 	/* maximum size of resources */
 	etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
 	/* CIDSIZE, bits[9:5] Indicates the Context ID size */
-	drvdata->ctxid_size = BMVAL(etmidr2, 5, 9);
+	drvdata->ctxid_size = REG_VAL(etmidr2, TRCIDR2_CIDSIZE);
 	/* VMIDSIZE, bits[14:10] Indicates the VMID size */
-	drvdata->vmid_size = BMVAL(etmidr2, 10, 14);
+	drvdata->vmid_size = REG_VAL(etmidr2, TRCIDR2_VMIDSIZE);
 	/* CCSIZE, bits[28:25] size of the cycle counter in bits minus 12 */
-	drvdata->ccsize = BMVAL(etmidr2, 25, 28);
+	drvdata->ccsize = REG_VAL(etmidr2, TRCIDR2_CCSIZE);
 
 	etmidr3 = etm4x_relaxed_read32(csa, TRCIDR3);
 	/* CCITMIN, bits[11:0] minimum threshold value that can be programmed */
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 2bd8ad953b8e..a95df5686b4b 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -147,6 +147,13 @@
 #define TRCIDR0_TSSIZE_SHIFT			24
 #define TRCIDR0_TSSIZE_MASK			GENMASK(4, 0)
 
+#define TRCIDR2_CIDSIZE_SHIFT			5
+#define TRCIDR2_CIDSIZE_MASK			GENMASK(4, 0)
+#define TRCIDR2_VMIDSIZE_SHIFT			10
+#define TRCIDR2_VMIDSIZE_MASK			GENMASK(4, 0)
+#define TRCIDR2_CCSIZE_SHIFT			25
+#define TRCIDR2_CCSIZE_MASK			GENMASK(3, 0)
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
-- 
2.28.0

