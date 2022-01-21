Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2366A495CE9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349617AbiAUJgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:36:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:26726 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379794AbiAUJfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:35:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642757738; x=1674293738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=j2m6NEt0OamlY75WiDCRpKOuZmrkgh+vHH0zmjRWEtQ=;
  b=D9NxkPNoLiNgctpU4329VKEowxSkNBf6gjhiUtYgD5CGDENoZFlpQ20k
   MhGTyrc/iEPa+o55ctB8tIWME7jftLDiejmDWykFGALYggyook+eDGKhm
   z0JDGbav189CGc3HiJFZlhAo6J6u7uSgKAod8ycnqV6RmgFKLy7tFmZy2
   88I63cKnOhuCrostyqspLuA6m3KdBDWBtACAgAIJhJR1pzYcqKu4YXP97
   Oxr5bzz0H/HZpWPF0OS2LOQOStMItwTQyCzfs0czLPplO9VcGJ82wGnJ2
   c+X+O8BIvDxmdQUVM3Bm6XjmBziuV+ZC57QV1AupkGMYU33rnL5qSH3Y5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="270033181"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="270033181"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 01:35:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="493788420"
Received: from kaograce-desk1.itwn.intel.com ([10.5.232.28])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 01:35:35 -0800
From:   Grace Kao <grace.kao@intel.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kane Chen <kane.chen@intel.com>, grace.kao@intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: pinctrl: intel: Fix a glitch when updating IRQ flags on a preconfigured line
Date:   Fri, 21 Jan 2022 17:34:26 +0800
Message-Id: <20220121093426.6336-1-grace.kao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220119181915.27519-1>
References: <20220119181915.27519-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

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
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Grace Kao <grace.kao@intel.com>
Change-Id: I6ff5cf0c42a76dce709a445c1820c8f3a84d6d89
---
 drivers/pinctrl/intel/pinctrl-intel.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 85750974d182..afd35e6999cc 100644
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
2.17.1

