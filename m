Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1624A754F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345685AbiBBQDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:03:07 -0500
Received: from foss.arm.com ([217.140.110.172]:39802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345702AbiBBQDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:03:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF27012FC;
        Wed,  2 Feb 2022 08:03:02 -0800 (PST)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 098C23F73B;
        Wed,  2 Feb 2022 08:03:00 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, coresight@lists.linaro.org
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] coresight: Make ETM4x TRCEVENTCTL1R register accesses consistent with sysreg.h
Date:   Wed,  2 Feb 2022 16:02:17 +0000
Message-Id: <20220202160226.37858-8-james.clark@arm.com>
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
 .../coresight/coresight-etm4x-sysfs.c         | 25 +++++++++++--------
 drivers/hwtracing/coresight/coresight-etm4x.h |  9 +++++++
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 4c29ab4464a0..cfa6f72a1e39 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -384,16 +384,16 @@ static ssize_t mode_store(struct device *dev,
 	/* bit[11], AMBA Trace Bus (ATB) trigger enable bit */
 	if ((config->mode & ETM_MODE_ATB_TRIGGER) &&
 	    (drvdata->atbtrig == true))
-		config->eventctrl1 |= BIT(11);
+		config->eventctrl1 |= TRCEVENTCTL1R_ATB;
 	else
-		config->eventctrl1 &= ~BIT(11);
+		config->eventctrl1 &= ~TRCEVENTCTL1R_ATB;
 
 	/* bit[12], Low-power state behavior override bit */
 	if ((config->mode & ETM_MODE_LPOVERRIDE) &&
 	    (drvdata->lpoverride == true))
-		config->eventctrl1 |= BIT(12);
+		config->eventctrl1 |= TRCEVENTCTL1R_LPOVERRIDE;
 	else
-		config->eventctrl1 &= ~BIT(12);
+		config->eventctrl1 &= ~TRCEVENTCTL1R_LPOVERRIDE;
 
 	/* bit[8], Instruction stall bit */
 	if ((config->mode & ETM_MODE_ISTALL_EN) && (drvdata->stallctl == true))
@@ -534,7 +534,7 @@ static ssize_t event_instren_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
-	val = BMVAL(config->eventctrl1, 0, 3);
+	val = REG_VAL(config->eventctrl1, TRCEVENTCTL1R_INSTEN);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -551,23 +551,28 @@ static ssize_t event_instren_store(struct device *dev,
 
 	spin_lock(&drvdata->spinlock);
 	/* start by clearing all instruction event enable bits */
-	config->eventctrl1 &= ~(BIT(0) | BIT(1) | BIT(2) | BIT(3));
+	config->eventctrl1 &= ~(TRCEVENTCTL1R_INSTEN_MASK << TRCEVENTCTL1R_INSTEN_SHIFT);
 	switch (drvdata->nr_event) {
 	case 0x0:
 		/* generate Event element for event 1 */
-		config->eventctrl1 |= val & BIT(1);
+		config->eventctrl1 |= val & TRCEVENTCTL1R_INSTEN_1;
 		break;
 	case 0x1:
 		/* generate Event element for event 1 and 2 */
-		config->eventctrl1 |= val & (BIT(0) | BIT(1));
+		config->eventctrl1 |= val & (TRCEVENTCTL1R_INSTEN_0 | TRCEVENTCTL1R_INSTEN_1);
 		break;
 	case 0x2:
 		/* generate Event element for event 1, 2 and 3 */
-		config->eventctrl1 |= val & (BIT(0) | BIT(1) | BIT(2));
+		config->eventctrl1 |= val & (TRCEVENTCTL1R_INSTEN_0 |
+					     TRCEVENTCTL1R_INSTEN_1 |
+					     TRCEVENTCTL1R_INSTEN_2);
 		break;
 	case 0x3:
 		/* generate Event element for all 4 events */
-		config->eventctrl1 |= val & 0xF;
+		config->eventctrl1 |= val & (TRCEVENTCTL1R_INSTEN_0 |
+					     TRCEVENTCTL1R_INSTEN_1 |
+					     TRCEVENTCTL1R_INSTEN_2 |
+					     TRCEVENTCTL1R_INSTEN_3);
 		break;
 	default:
 		break;
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 55e756020a94..eb72b81bbf85 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -211,6 +211,15 @@
 #define TRCCONFIGR_DA				BIT(16)
 #define TRCCONFIGR_DV				BIT(17)
 
+#define TRCEVENTCTL1R_INSTEN_SHIFT		0
+#define TRCEVENTCTL1R_INSTEN_MASK		GENMASK(3, 0)
+#define TRCEVENTCTL1R_INSTEN_0			BIT(0)
+#define TRCEVENTCTL1R_INSTEN_1			BIT(1)
+#define TRCEVENTCTL1R_INSTEN_2			BIT(2)
+#define TRCEVENTCTL1R_INSTEN_3			BIT(3)
+#define TRCEVENTCTL1R_ATB			BIT(11)
+#define TRCEVENTCTL1R_LPOVERRIDE		BIT(12)
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
-- 
2.28.0

