Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BAC5651C2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbiGDKKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiGDKKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:10:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752ECCE0F;
        Mon,  4 Jul 2022 03:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656929440; x=1688465440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qt6tSdZXQTrdRjfjeYCNAiCt892FA8Kq7qXXepazT0k=;
  b=HmxhDHMAkZDjdnOG23cOCoGkRzwwrf6exlVpu2GaK04hV9YZHfG9LNQy
   zgQUzkGZm6b/o2oUOAKdXArOdl7ECMuhkP7oC8F8yXi770TKft3ZN1p8P
   mGUQT60v4jT6OHzSJTJnGzI3yFuR37aZI48i3kLDOpjBZX7uAsaufpl6h
   yQrJq6+/4QQaw03be9flVNxecoXObtmCtlUiUSLlvN/fPki72PwYZD78J
   nHg834+j2UYCZN2cqiHuQX4vEXJ+bgi2oBclXU7Nz5c9m7API4pbIoc6T
   mxiv2yPgqplg9HoGdXj3yNlhth1+HDfEub6K9r6aZVpwit4XZGwfxFoFy
   A==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="163185372"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jul 2022 03:10:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 4 Jul 2022 03:10:38 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 4 Jul 2022 03:10:36 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/2] pinctrl: at91: remove #ifdef CONFIG_PM
Date:   Mon, 4 Jul 2022 13:12:53 +0300
Message-ID: <20220704101253.808519-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220704101253.808519-1-claudiu.beznea@microchip.com>
References: <20220704101253.808519-1-claudiu.beznea@microchip.com>
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

Remove #ifdef CONFIG_PM and use pm_ptr() macro instead.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pinctrl/pinctrl-at91.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index d91a010e65f5..5e3a2f4c2bb6 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1615,8 +1615,6 @@ static void gpio_irq_ack(struct irq_data *d)
 	/* the interrupt is already cleared before by reading ISR */
 }
 
-#ifdef CONFIG_PM
-
 static u32 wakeups[MAX_GPIO_BANKS];
 static u32 backups[MAX_GPIO_BANKS];
 
@@ -1683,10 +1681,6 @@ void at91_pinctrl_gpio_resume(void)
 	}
 }
 
-#else
-#define gpio_irq_set_wake	NULL
-#endif /* CONFIG_PM */
-
 static void gpio_irq_handler(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -1741,7 +1735,7 @@ static int at91_gpio_of_irq_setup(struct platform_device *pdev,
 	gpio_irqchip->irq_disable = gpio_irq_mask;
 	gpio_irqchip->irq_mask = gpio_irq_mask;
 	gpio_irqchip->irq_unmask = gpio_irq_unmask;
-	gpio_irqchip->irq_set_wake = gpio_irq_set_wake;
+	gpio_irqchip->irq_set_wake = pm_ptr(gpio_irq_set_wake);
 	gpio_irqchip->irq_set_type = at91_gpio->ops->irq_type;
 
 	/* Disable irqs of this PIO controller */
-- 
2.34.1

