Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA59A4A838C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350578AbiBCMHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:07:02 -0500
Received: from foss.arm.com ([217.140.110.172]:42656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350436AbiBCMGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:06:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7027111D4;
        Thu,  3 Feb 2022 04:06:46 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.13.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E93953F774;
        Thu,  3 Feb 2022 04:06:44 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     leo.yan@linaro.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/15] coresight: Make ETM4x TRCBBCTLR register accesses consistent with sysreg.h
Date:   Thu,  3 Feb 2022 12:06:02 +0000
Message-Id: <20220203120604.128396-15-james.clark@arm.com>
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
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 5 +++--
 drivers/hwtracing/coresight/coresight-etm4x.h       | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 682819467755..a0cdd2cd978a 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -707,10 +707,11 @@ static ssize_t bb_ctrl_store(struct device *dev,
 	 * individual range comparators. If include then at least 1
 	 * range must be selected.
 	 */
-	if ((val & BIT(8)) && (BMVAL(val, 0, 7) == 0))
+	if ((val & TRCBBCTLR_MODE) && (REG_VAL(val, TRCBBCTLR_RANGE) == 0))
 		return -EINVAL;
 
-	config->bb_ctrl = val & GENMASK(8, 0);
+	config->bb_ctrl = val & (TRCBBCTLR_MODE |
+				 (TRCBBCTLR_RANGE_MASK << TRCBBCTLR_RANGE_SHIFT));
 	return size;
 }
 static DEVICE_ATTR_RW(bb_ctrl);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 9d0978540338..4d943faade33 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -254,6 +254,10 @@
 #define TRCSSPCICRn_PC_SHIFT			0
 #define TRCSSPCICRn_PC_MASK			GENMASK(7, 0)
 
+#define TRCBBCTLR_MODE				BIT(8)
+#define TRCBBCTLR_RANGE_SHIFT			0
+#define TRCBBCTLR_RANGE_MASK			GENMASK(7, 0)
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
-- 
2.28.0

