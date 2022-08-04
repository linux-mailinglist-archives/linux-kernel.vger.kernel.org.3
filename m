Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE99589AB9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239493AbiHDLBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239436AbiHDLAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:00:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5352228D;
        Thu,  4 Aug 2022 04:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659610853; x=1691146853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6AE46jTvHPsB/PdH0ziYZs9AOmnJ2WGSpj6xBgaIZA8=;
  b=e4nPnYUGOVWbElCLuLp/+dU31KJfh3uXwkmJExnUU4urRQtuaZyrABc/
   0Wz1XZyOjuSHhtv423EJMjRqDQkclYc1WQnx6KpqjxaPVn0aRlyEpWTiw
   6ESxChv7bbwVmgOSlRc6EFg5gdEtzV9DpW69UGTuMlPwQyBbUu+5CERMO
   L5HGTGuWl+yat9ElrQSsKciNYQGTgygqoHkOCzj9N5Pa0gH4BbOFFoNG+
   g3qxXVMfahVa3bocnUPsZHfIGQaI91XLzADbqZ83T0MUBanRC/FclBtKR
   jzYJL4AguOcwVGzvANOfSk5GY+Y/yhZLXrd+TkIbVuQowj2sCUCb55uGC
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="170952626"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2022 04:00:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 4 Aug 2022 04:00:52 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Thu, 4 Aug 2022 04:00:49 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <UNGLinuxDriver@microchip.com>, <gregkh@linuxfoundation.org>,
        <arnd@arndb.de>, <dragan.cvetic@xilinx.com>,
        <derek.kiernan@xilinx.com>
Subject: [PATCH RFC char-misc-next 5/5] misc: microchip: pci1xxxx: Add power management functions - suspend & resume handlers.
Date:   Thu, 4 Aug 2022 22:02:19 +0530
Message-ID: <20220804163219.921640-6-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804163219.921640-1-kumaravel.thiagarajan@microchip.com>
References: <20220804163219.921640-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index c58d27407c4d..404633704d2f 100644
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
 	return devm_gpiochip_add_data(&(aux_dev->dev), &priv->gpio, priv);
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

