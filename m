Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1E249404F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356990AbiASTGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:06:33 -0500
Received: from mga05.intel.com ([192.55.52.43]:38395 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356972AbiASTG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642619186; x=1674155186;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xOc3zclTNK3FO8yo0t2qxVdSrH3WD9wCaAquSBbbHsc=;
  b=nn9N7soS67Sg7u9gzw61fBaH0hdFBxl7DY6EAe36O6q1NorBAZNPYT6u
   cA4cCOtvFCc7gSs/06KRJiEpoKHxCYQBs5FwuAnB5/ehVPNVfoP6NU5eE
   KOQGhaXmJ+JQTsWFFnqLdYrvAM9WkQ8Jo8ni3GV8nZg6bTy3bdLyOXLDM
   esc5MPgX4lz0rtep3d4RpYIlV2RIC3m7OLRhZWf2+AeVJRsuMzm3dNO+H
   sLKcXkuhDt27Yhko2LkSZ/qG67bbxyowgxEA9VBehILfX2dG9A9fCo3/0
   1RjZow2G1NPBZ/C3GKrAIHd8Y1qE+V0H0dituYhFg7jrO8VC617XNPGfC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="331509629"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="331509629"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 10:19:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="532406646"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 19 Jan 2022 10:19:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0BD2F109; Wed, 19 Jan 2022 20:19:17 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kane Chen <kane.chen@intel.com>
Subject: [PATCH v1 1/1] pinctrl: intel: Fix a glitch when updating IRQ flags on a preconfigured line
Date:   Wed, 19 Jan 2022 20:19:15 +0200
Message-Id: <20220119181915.27519-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit af7e3eeb84e2 ("pinctrl: intel: Disable input and output buffer
when switching to GPIO") hadn't taken into account an update of the IRQ
flags scenario.

When updating the IRQ flags on the preconfigured line the ->irq_set_type()
is called again. In such case the sequential Rx buffer configuration
changes may trigger a falling or rising edge interrupt that may lead,
on some platforms, to an undesired event.

This may happen because each of intel_gpio_set_gpio_mode() and
__intel_gpio_set_direction() updates the pad configuration with a different
value of the GPIORXDIS bit. Notable, that the intel_gpio_set_gpio_mode() is
called only for the pads that are configured as an input. Due to this fact,
integrate the logic of __intel_gpio_set_direction() call into the
intel_gpio_set_gpio_mode() so that the Rx buffer won't be disabled and
immediately re-enabled.

Fixes: af7e3eeb84e2 ("pinctrl: intel: Disable input and output buffer when switching to GPIO")
Reported-by: Kane Chen <kane.chen@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 7d8a7e7b0aef..4d718a928288 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -451,8 +451,8 @@ static void intel_gpio_set_gpio_mode(void __iomem *padcfg0)
 	value &= ~PADCFG0_PMODE_MASK;
 	value |= PADCFG0_PMODE_GPIO;
 
-	/* Disable input and output buffers */
-	value |= PADCFG0_GPIORXDIS;
+	/* Disable TX buffer and enable RX (this will be input) */
+	value &= ~PADCFG0_GPIORXDIS;
 	value |= PADCFG0_GPIOTXDIS;
 
 	/* Disable SCI/SMI/NMI generation */
@@ -497,9 +497,6 @@ static int intel_gpio_request_enable(struct pinctrl_dev *pctldev,
 
 	intel_gpio_set_gpio_mode(padcfg0);
 
-	/* Disable TX buffer and enable RX (this will be input) */
-	__intel_gpio_set_direction(padcfg0, true);
-
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
@@ -1115,9 +1112,6 @@ static int intel_gpio_irq_type(struct irq_data *d, unsigned int type)
 
 	intel_gpio_set_gpio_mode(reg);
 
-	/* Disable TX buffer and enable RX (this will be input) */
-	__intel_gpio_set_direction(reg, true);
-
 	value = readl(reg);
 
 	value &= ~(PADCFG0_RXEVCFG_MASK | PADCFG0_RXINV);
-- 
2.34.1

