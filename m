Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0634CDA07
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241093AbiCDRUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241038AbiCDRUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:20:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 646F7151D27
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:19:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F57A1424;
        Fri,  4 Mar 2022 09:19:43 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.42.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7CCAA3F73D;
        Fri,  4 Mar 2022 09:19:41 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com
Cc:     mathieu.poirier@linaro.org, leo.yan@linaro.com,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/15] coresight: etm4x: Cleanup TRCSTALLCTLR register accesses
Date:   Fri,  4 Mar 2022 17:19:05 +0000
Message-Id: <20220304171913.2292458-9-james.clark@arm.com>
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
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 12 ++++++------
 drivers/hwtracing/coresight/coresight-etm4x.h       |  4 ++++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 2d29e9daf515..cd24590ea38a 100644
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
index cbba46f14ada..36934056a5dc 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -196,6 +196,10 @@
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

