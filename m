Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675345651C3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbiGDKKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiGDKKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:10:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB37CE23;
        Mon,  4 Jul 2022 03:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656929438; x=1688465438;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pw9Nrp0Vv9RZax0caTah0wHYemQm/jouii9axMgSRvA=;
  b=znSwudlUaVZuSn789I6Gl6WsfCjb3pORnJh4ds7ZK34YAsFUP6a+8p6L
   HpZUQvd/N5EDUkOynjAgUmBMa6IQ9rTbH0g8AmqEH5ZZc85286fwO9r+D
   CJ5Of0cKyHyf55qNnzxJ15hn1zmLI09LCBvxHvQSEjGx9jnwT+XWlJcnb
   ZF+LNn2ptLlJ3j/st1+W8PkFE5OgU3yM8EZ/nyVkKCGGIGk0r22SrU+Fs
   XGAJ1TZdGr5Kx4VenFtSZVMOgTNHVEZ9KExjPCNJBMrLzTszLy+5FnQYN
   7wdhYKN7kv9j5GfrdxY73A/sWGcdpPpvRqGUuFsxb9mFDqBCIwPdYosyV
   g==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="170941199"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jul 2022 03:10:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 4 Jul 2022 03:10:35 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 4 Jul 2022 03:10:33 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/2] pinctrl: at91-pio4: remove #ifdef CONFIG_PM_SLEEP
Date:   Mon, 4 Jul 2022 13:12:52 +0300
Message-ID: <20220704101253.808519-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove #ifdef CONFIG_PM_SLEEP and use pm_sleep_ptr() macro instead.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pinctrl/pinctrl-at91-pio4.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 517f2a6330ad..82b921fd630d 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -237,8 +237,6 @@ static void atmel_gpio_irq_unmask(struct irq_data *d)
 			 BIT(pin->line));
 }
 
-#ifdef CONFIG_PM_SLEEP
-
 static int atmel_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 {
 	struct atmel_pioctrl *atmel_pioctrl = irq_data_get_irq_chip_data(d);
@@ -255,9 +253,6 @@ static int atmel_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 
 	return 0;
 }
-#else
-#define atmel_gpio_irq_set_wake NULL
-#endif /* CONFIG_PM_SLEEP */
 
 static struct irq_chip atmel_gpio_irq_chip = {
 	.name		= "GPIO",
@@ -265,7 +260,7 @@ static struct irq_chip atmel_gpio_irq_chip = {
 	.irq_mask	= atmel_gpio_irq_mask,
 	.irq_unmask	= atmel_gpio_irq_unmask,
 	.irq_set_type	= atmel_gpio_irq_set_type,
-	.irq_set_wake	= atmel_gpio_irq_set_wake,
+	.irq_set_wake	= pm_sleep_ptr(atmel_gpio_irq_set_wake),
 };
 
 static int atmel_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
-- 
2.34.1

