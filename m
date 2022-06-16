Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2994F54E83B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbiFPQ7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbiFPQ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:58:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC553BF84
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655398710; x=1686934710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wlgRJkfaNUJojj/xGs1IJBxduLtqn9lZftWj49JVVcA=;
  b=WUlEEO+NES3dm7AbgdnsyRqful1qIEMsZaAK5MbXcPcL2ZhWt7ci96ll
   hc1/cnN0BQpYRQuNAUxILUqKpMVHc8OvRF2IGFwuVYI4kYDuX936VtmjF
   HFqjRcGkslB7mRiOOA41OeJl1UM5FFhT7PkLK3sM+NmI8lwtrt+NVv+C2
   X7Q/82vhL+REqiqzh/k9sNKD6ufkfIAbevEO7GHFLBJM3Alrtu6FWwZUm
   UWriTFCxDBWqlbz9kqy/d8oivrDKG1f3iNk1Kv5jag1zVLAwsQJWGNiyZ
   Zcg+4NbqD8urlO6MOuDkvXV+n+QAfslkxDIORZDelIRxVa9PgXH2KL+gt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="340950388"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="340950388"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 09:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="618950926"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 16 Jun 2022 09:58:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9FF3D51E; Thu, 16 Jun 2022 19:58:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 08/11] mfd: intel_soc_pmic_bxtwc: Use bits.h macros for all masks
Date:   Thu, 16 Jun 2022 19:58:20 +0300
Message-Id: <20220616165823.4919-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index b48e620de7a3..529aec38389c 100644
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

