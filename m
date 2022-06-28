Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE2A55F100
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiF1WVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbiF1WV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:21:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6053F30F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656454703; x=1687990703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FHwNmTlimRwHlMbSKeoQ89340hJRsjpWPe2o5s0ZoOA=;
  b=A2LbUht88mGc14N46L4CzH6kACKV/BMY4HSh9o3S30KPewslUpD2nN5S
   89NYWH0aI5PMp8SzVe1BHSJNuLxosX3jQqz5IAPZQnduKd0uC+D4k2hXZ
   IMBjg/E7S+PhVltImTsUKhr1//6Kb5hwMqTyCTPrMpbbFnMXT+UQxD1u2
   fwRrbStxMFnHyy6mNeASKe2qD9Ks3PnP3GlcbcSQQ5epl6XsnTiUPs2O0
   Cf60b3S8KdpTaHrEtPCGUZGvpwOss+0YTecALQqBYcyR+2KtVJRjZSMQI
   uzAaZH8g9DR7O4j9fJ308dEcK+iBNPmlp5PLQkpW0FkVEd3wqvBrPSuHX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="345856986"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="345856986"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 15:17:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="617341440"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 28 Jun 2022 15:17:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 21EDA5F9; Wed, 29 Jun 2022 01:17:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 08/11] mfd: intel_soc_pmic_bxtwc: Use bits.h macros for all masks
Date:   Wed, 29 Jun 2022 01:17:44 +0300
Message-Id: <20220628221747.33956-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
References: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we are using BIT(), but GENMASK(). Make use of the latter one
as well (far less error-prone, far more concise).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
v2: added tag (Lee)

 drivers/mfd/intel_soc_pmic_bxtwc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index f79ae0ddc495..5ac623eda1c1 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -18,9 +19,9 @@
 #include <asm/intel_scu_ipc.h>
 
 /* PMIC device registers */
-#define REG_ADDR_MASK		0xFF00
+#define REG_ADDR_MASK		GENMASK(15, 8)
 #define REG_ADDR_SHIFT		8
-#define REG_OFFSET_MASK		0xFF
+#define REG_OFFSET_MASK		GENMASK(7, 0)
 
 /* Interrupt Status Registers */
 #define BXTWC_IRQLVL1		0x4E02
@@ -112,29 +113,29 @@ static const struct regmap_irq bxtwc_regmap_irqs[] = {
 };
 
 static const struct regmap_irq bxtwc_regmap_irqs_pwrbtn[] = {
-	REGMAP_IRQ_REG(BXTWC_PWRBTN_IRQ, 0, 0x01),
+	REGMAP_IRQ_REG(BXTWC_PWRBTN_IRQ, 0, BIT(0)),
 };
 
 static const struct regmap_irq bxtwc_regmap_irqs_bcu[] = {
-	REGMAP_IRQ_REG(BXTWC_BCU_IRQ, 0, 0x1f),
+	REGMAP_IRQ_REG(BXTWC_BCU_IRQ, 0, GENMASK(4, 0)),
 };
 
 static const struct regmap_irq bxtwc_regmap_irqs_adc[] = {
-	REGMAP_IRQ_REG(BXTWC_ADC_IRQ, 0, 0xff),
+	REGMAP_IRQ_REG(BXTWC_ADC_IRQ, 0, GENMASK(7, 0)),
 };
 
 static const struct regmap_irq bxtwc_regmap_irqs_chgr[] = {
-	REGMAP_IRQ_REG(BXTWC_USBC_IRQ, 0, 0x20),
-	REGMAP_IRQ_REG(BXTWC_CHGR0_IRQ, 0, 0x1f),
-	REGMAP_IRQ_REG(BXTWC_CHGR1_IRQ, 1, 0x1f),
+	REGMAP_IRQ_REG(BXTWC_USBC_IRQ, 0, BIT(5)),
+	REGMAP_IRQ_REG(BXTWC_CHGR0_IRQ, 0, GENMASK(4, 0)),
+	REGMAP_IRQ_REG(BXTWC_CHGR1_IRQ, 1, GENMASK(4, 0)),
 };
 
 static const struct regmap_irq bxtwc_regmap_irqs_tmu[] = {
-	REGMAP_IRQ_REG(BXTWC_TMU_IRQ, 0, 0x06),
+	REGMAP_IRQ_REG(BXTWC_TMU_IRQ, 0, GENMASK(2, 1)),
 };
 
 static const struct regmap_irq bxtwc_regmap_irqs_crit[] = {
-	REGMAP_IRQ_REG(BXTWC_CRIT_IRQ, 0, 0x03),
+	REGMAP_IRQ_REG(BXTWC_CRIT_IRQ, 0, GENMASK(1, 0)),
 };
 
 static struct regmap_irq_chip bxtwc_regmap_irq_chip = {
-- 
2.35.1

