Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18040528D83
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345183AbiEPSzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiEPSzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:55:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1A33EB91;
        Mon, 16 May 2022 11:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652727303; x=1684263303;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TUcY0yvjkA4ZWXoXYlBDa+cQV3rSyCIF+AQTKalBBvo=;
  b=lgWmALw3xi+OG2E6leXNZsh2z10s8dlzn0JT9yL9JaPUaY4dxmIuooWl
   4EIXQ3q+xXEw4a08b0ZLnri6QFlWLXAIr1qaGyijvc5DAiXOsBopp0TcR
   b3KTjIu30IkdSkdOXG1D9OIKZYz7XJiCUqfR5J1DhtT6OiLO8sgMP9Qge
   Sp2JEgrk5SV+SrRNYi57SeTVDn0qOMW2sgK0dlsm0Uu1ptfyAODSgD4BZ
   M40hBsmxytkIz6iYvsJP0FWDecSekBipESv4lpVC5pF4j4/HkuqHq0d/U
   /LNHpvouOr/iD2OlnHgINa5Enx8x6f+r4UShfQiZL7qsKQR2d9ZhBqVo5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="268517962"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="268517962"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 11:55:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="816532117"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 16 May 2022 11:55:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7A049A8; Mon, 16 May 2022 21:55:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: cherryview: Use GPIO chip pointer in chv_gpio_irq_mask_unmask()
Date:   Mon, 16 May 2022 21:55:00 +0300
Message-Id: <20220516185500.32304-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callers already have dereferenced pointer to GPIO chip, no need to
do it again in chv_gpio_irq_mask_unmask(). Hence, replace IRQ data pointer
by GPIO chip pointer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index b696f9392789..26b2a425d201 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1255,9 +1255,8 @@ static void chv_gpio_irq_ack(struct irq_data *d)
 	raw_spin_unlock(&chv_lock);
 }
 
-static void chv_gpio_irq_mask_unmask(struct irq_data *d, irq_hw_number_t hwirq, bool mask)
+static void chv_gpio_irq_mask_unmask(struct gpio_chip *gc, irq_hw_number_t hwirq, bool mask)
 {
-	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
 	u32 value, intr_line;
 	unsigned long flags;
@@ -1283,7 +1282,7 @@ static void chv_gpio_irq_mask(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
-	chv_gpio_irq_mask_unmask(d, hwirq, true);
+	chv_gpio_irq_mask_unmask(gc, hwirq, true);
 	gpiochip_disable_irq(gc, hwirq);
 }
 
@@ -1293,7 +1292,7 @@ static void chv_gpio_irq_unmask(struct irq_data *d)
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
 	gpiochip_enable_irq(gc, hwirq);
-	chv_gpio_irq_mask_unmask(d, hwirq, false);
+	chv_gpio_irq_mask_unmask(gc, hwirq, false);
 }
 
 static unsigned chv_gpio_irq_startup(struct irq_data *d)
-- 
2.35.1

