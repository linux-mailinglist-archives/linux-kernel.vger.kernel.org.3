Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D899659FD4B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbiHXO3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239207AbiHXO3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:29:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3201B5B7BF;
        Wed, 24 Aug 2022 07:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661351379; x=1692887379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HeVu9/CMfMxDmJqZrVHFxtwjuciRTrJJHoMMUYqANE8=;
  b=aYaODmHeXxQ9JWBz3qmiNS9PBKY5nwoSDpZDepLPbE/hWZFcw3TKfKJe
   wF8JrRRrFjESdLvW1d2HTypPpFAeqmsa5bUlGf5HobMNc6ycELHQui2AV
   +lm7JqqrG807mki1dgznhsgSB2JpLekCi4Wx1Pn1TftCJrZDbNVfcgUrz
   JwFiKV2MARBx/bANCM8Zg3IuIvNE92uj+QVoMgn0jT3c+QsYAr2dpGRid
   CBfmeey+O63LGhpgmS/61WWfkWjdEdry9I4lTIO1xyNEdQvll10GZxwka
   5KM54fOFonYeLz5G+C8CkEARVuo5hI3TDtg6Se4kAP581A9KXNCAkdIZb
   A==;
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="173938073"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2022 07:29:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 24 Aug 2022 07:29:37 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 24 Aug 2022 07:29:34 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <UNGLinuxDriver@microchip.com>, <gregkh@linuxfoundation.org>,
        <arnd@arndb.de>, <dragan.cvetic@xilinx.com>,
        <derek.kiernan@xilinx.com>
Subject: [PATCH v1 char-misc-next 5/5] misc: microchip: pci1xxxx: Add power management functions - suspend & resume handlers.
Date:   Thu, 25 Aug 2022 01:30:47 +0530
Message-ID: <20220824200047.150308-6-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220824200047.150308-1-kumaravel.thiagarajan@microchip.com>
References: <20220824200047.150308-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Power event handlers suspend and resume are invoked by the operating
system to notify the driver about the power events. Wakeup is enabled
before entering suspend and disabled after resuming.

Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
---
 .../misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c   | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
index eb5ad75c9c88..230503cca2ff 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
@@ -14,6 +14,7 @@
 #include "mchp_pci1xxxx_gp.h"
 
 #define PCI1XXXX_NR_PINS		93
+#define PERI_GEN_RESET			0
 #define OUT_EN_OFFSET(x)		((((x) / 32) * 4) + 0x400)
 #define INP_EN_OFFSET(x)		((((x) / 32) * 4) + 0x400 + 0x10)
 #define OUT_OFFSET(x)			((((x) / 32) * 4) + 0x400 + 0x20)
@@ -291,6 +292,38 @@ static struct irq_chip pci1xxxx_gpio_irqchip = {
 	.irq_set_type = pci1xxxx_gpio_set_type,
 };
 
+static int pci1xxxx_gpio_suspend(struct device *dev)
+{
+	struct pci1xxxx_gpio *priv = dev_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	pci1xxx_assign_bit(priv->reg_base, PIO_GLOBAL_CONFIG_OFFSET,
+			   16, true);
+	pci1xxx_assign_bit(priv->reg_base, PIO_GLOBAL_CONFIG_OFFSET,
+			   17, false);
+	pci1xxx_assign_bit(priv->reg_base, PERI_GEN_RESET, 16, true);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int pci1xxxx_gpio_resume(struct device *dev)
+{
+	struct pci1xxxx_gpio *priv = dev_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	pci1xxx_assign_bit(priv->reg_base, PIO_GLOBAL_CONFIG_OFFSET,
+			   17, true);
+	pci1xxx_assign_bit(priv->reg_base, PIO_GLOBAL_CONFIG_OFFSET,
+			   16, false);
+	pci1xxx_assign_bit(priv->reg_base, PERI_GEN_RESET, 16, false);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
 static int pci1xxxx_gpio_setup(struct pci1xxxx_gpio *priv, int irq)
 {
 	struct gpio_chip *gchip = &priv->gpio;
@@ -325,6 +358,7 @@ static int pci1xxxx_gpio_setup(struct pci1xxxx_gpio *priv, int irq)
 	girq->parents = NULL;
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_bad_irq;
+
 	return 0;
 }
 
@@ -370,6 +404,8 @@ static int pci1xxxx_gpio_probe(struct auxiliary_device *aux_dev,
 	return devm_gpiochip_add_data(&aux_dev->dev, &priv->gpio, priv);
 }
 
+static SIMPLE_DEV_PM_OPS(pci1xxxx_gpio_pm_ops, pci1xxxx_gpio_suspend, pci1xxxx_gpio_resume);
+
 const struct auxiliary_device_id pci1xxxx_gpio_auxiliary_id_table[] = {
 	{.name = "mchp_pci1xxxx_gp.gp_gpio"},
 	{}
@@ -378,6 +414,7 @@ const struct auxiliary_device_id pci1xxxx_gpio_auxiliary_id_table[] = {
 static struct auxiliary_driver pci1xxxx_gpio_driver = {
 	.driver = {
 		.name = "PCI1xxxxGPIO",
+		.pm = &pci1xxxx_gpio_pm_ops,
 		},
 	.probe = pci1xxxx_gpio_probe,
 	.id_table = pci1xxxx_gpio_auxiliary_id_table
-- 
2.25.1

