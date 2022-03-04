Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63114CDA06
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241059AbiCDRUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241019AbiCDRU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:20:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1DC114FFFE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:19:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 714F11478;
        Fri,  4 Mar 2022 09:19:40 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.42.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF13A3F73D;
        Fri,  4 Mar 2022 09:19:38 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com
Cc:     mathieu.poirier@linaro.org, leo.yan@linaro.com,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/15] coresight: etm4x: Cleanup TRCEVENTCTL1R register accesses
Date:   Fri,  4 Mar 2022 17:19:04 +0000
Message-Id: <20220304171913.2292458-8-james.clark@arm.com>
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
 .../coresight/coresight-etm4x-sysfs.c         | 25 +++++++++++--------
 drivers/hwtracing/coresight/coresight-etm4x.h |  8 ++++++
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 53f84da3fe44..2d29e9daf515 100644
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
+	val = FIELD_GET(TRCEVENTCTL1R_INSTEN_MASK, config->eventctrl1);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -551,23 +551,28 @@ static ssize_t event_instren_store(struct device *dev,
 
 	spin_lock(&drvdata->spinlock);
 	/* start by clearing all instruction event enable bits */
-	config->eventctrl1 &= ~(BIT(0) | BIT(1) | BIT(2) | BIT(3));
+	config->eventctrl1 &= ~TRCEVENTCTL1R_INSTEN_MASK;
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
index 4c8d7be3c159..cbba46f14ada 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -188,6 +188,14 @@
 #define TRCCONFIGR_DA				BIT(16)
 #define TRCCONFIGR_DV				BIT(17)
 
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

