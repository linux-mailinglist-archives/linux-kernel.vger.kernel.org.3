Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA404A754D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345717AbiBBQDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:03:10 -0500
Received: from foss.arm.com ([217.140.110.172]:39822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234720AbiBBQDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:03:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABDD611D4;
        Wed,  2 Feb 2022 08:03:06 -0800 (PST)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 82EBA3F73B;
        Wed,  2 Feb 2022 08:03:04 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, coresight@lists.linaro.org
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] coresight: Make ETM4x TRCSTALLCTLR register accesses consistent with sysreg.h
Date:   Wed,  2 Feb 2022 16:02:18 +0000
Message-Id: <20220202160226.37858-9-james.clark@arm.com>
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
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 12 ++++++------
 drivers/hwtracing/coresight/coresight-etm4x.h       |  4 ++++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index cfa6f72a1e39..d808eeae8b07 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -397,22 +397,22 @@ static ssize_t mode_store(struct device *dev,
 
 	/* bit[8], Instruction stall bit */
 	if ((config->mode & ETM_MODE_ISTALL_EN) && (drvdata->stallctl == true))
-		config->stall_ctrl |= BIT(8);
+		config->stall_ctrl |= TRCSTALLCTLR_ISTALL;
 	else
-		config->stall_ctrl &= ~BIT(8);
+		config->stall_ctrl &= ~TRCSTALLCTLR_ISTALL;
 
 	/* bit[10], Prioritize instruction trace bit */
 	if (config->mode & ETM_MODE_INSTPRIO)
-		config->stall_ctrl |= BIT(10);
+		config->stall_ctrl |= TRCSTALLCTLR_INSTPRIORITY;
 	else
-		config->stall_ctrl &= ~BIT(10);
+		config->stall_ctrl &= ~TRCSTALLCTLR_INSTPRIORITY;
 
 	/* bit[13], Trace overflow prevention bit */
 	if ((config->mode & ETM_MODE_NOOVERFLOW) &&
 		(drvdata->nooverflow == true))
-		config->stall_ctrl |= BIT(13);
+		config->stall_ctrl |= TRCSTALLCTLR_NOOVERFLOW;
 	else
-		config->stall_ctrl &= ~BIT(13);
+		config->stall_ctrl &= ~TRCSTALLCTLR_NOOVERFLOW;
 
 	/* bit[9] Start/stop logic control bit */
 	if (config->mode & ETM_MODE_VIEWINST_STARTSTOP)
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index eb72b81bbf85..e37393934e0d 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -220,6 +220,10 @@
 #define TRCEVENTCTL1R_ATB			BIT(11)
 #define TRCEVENTCTL1R_LPOVERRIDE		BIT(12)
 
+#define TRCSTALLCTLR_ISTALL			BIT(8)
+#define TRCSTALLCTLR_INSTPRIORITY		BIT(10)
+#define TRCSTALLCTLR_NOOVERFLOW			BIT(13)
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
-- 
2.28.0

