Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D71A59FD4A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238399AbiHXO3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239177AbiHXO3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:29:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215CC5727F;
        Wed, 24 Aug 2022 07:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661351370; x=1692887370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OoX/xSU3Su3Rext67292A/2SvqILBex0RiVNFbZ4ti8=;
  b=MyzeSvxty7U+yAkFzekgVLm3MHhWwA8Vr+6P1A0y1NF8m6YwsJvwVCq+
   5wl0yMqdrn0oJA1gVGB+6kKtYJ9oXZE+7M7X3I0+AU66fFYpsQ+1uMXNr
   ieePpHt0PbGPvNmhYJsjdU0SKLMMSuQlNqUrkEBFVKtpJysvRer05oAsZ
   u15ZLDMRrbsJ8v/iTf5dDD7YANK0YUP4ZPFby/pl+rl1/3GEce2bDscrv
   LtuKz7oPV1YBD9wCHFeidr1qeSRYpcsfeye65NmA/lxYNzNZD+IM7FXaj
   Tey30IzlAVzISNwB3fnVe69HM/UFujdpDqMnX2bSST+1kXg0FZOJBHPZ9
   g==;
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="173938026"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2022 07:29:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 24 Aug 2022 07:29:27 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 24 Aug 2022 07:29:24 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <UNGLinuxDriver@microchip.com>, <gregkh@linuxfoundation.org>,
        <arnd@arndb.de>, <dragan.cvetic@xilinx.com>,
        <derek.kiernan@xilinx.com>
Subject: [PATCH v1 char-misc-next 3/5] misc: microchip: pci1xxxx: Add functions to configure gpio pins as input / output, get status, handle I/O for gpio pins.
Date:   Thu, 25 Aug 2022 01:30:45 +0530
Message-ID: <20220824200047.150308-4-kumaravel.thiagarajan@microchip.com>
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

direction_input and direction_output functions configures a gpio pin as
input and output respectively. get_direction function returns if a gpio
pin is output or input. get function returns the value of a gpio pin
whereas set function assigns output value for a gpio pin.

Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
---
 .../misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c   | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
index 97ed7ae1baaa..45e197fe3a3e 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
@@ -13,6 +13,10 @@
 #include "mchp_pci1xxxx_gp.h"
 
 #define PCI1XXXX_NR_PINS		93
+#define OUT_EN_OFFSET(x)		((((x) / 32) * 4) + 0x400)
+#define INP_EN_OFFSET(x)		((((x) / 32) * 4) + 0x400 + 0x10)
+#define OUT_OFFSET(x)			((((x) / 32) * 4) + 0x400 + 0x20)
+#define INP_OFFSET(x)			((((x) / 32) * 4) + 0x400 + 0x30)
 #define PULLUP_OFFSET(x)		((((x) / 32) * 4) + 0x400 + 0x40)
 #define PULLDOWN_OFFSET(x)		((((x) / 32) * 4) + 0x400 + 0x50)
 #define OPENDRAIN_OFFSET(x)		((((x) / 32) * 4) + 0x400 + 0x60)
@@ -30,6 +34,24 @@ struct pci1xxxx_gpio {
 	int irq_base;
 };
 
+static int pci1xxxx_gpio_get_direction(struct gpio_chip *gpio, unsigned int nr)
+{
+	struct pci1xxxx_gpio *priv = gpiochip_get_data(gpio);
+	u32 data;
+	int ret = -EINVAL;
+
+	data = readl(priv->reg_base + INP_EN_OFFSET(nr));
+	if (data & BIT(nr % 32)) {
+		ret =  1;
+	} else {
+		data = readl(priv->reg_base + OUT_EN_OFFSET(nr));
+		if (data & BIT(nr % 32))
+			ret =  0;
+	}
+
+	return ret;
+}
+
 static inline void pci1xxx_assign_bit(void __iomem *base_addr, unsigned int reg_offset,
 				      unsigned int bitpos, bool set)
 {
@@ -43,6 +65,58 @@ static inline void pci1xxx_assign_bit(void __iomem *base_addr, unsigned int reg_
 	writel(data, base_addr + reg_offset);
 }
 
+static int pci1xxxx_gpio_direction_input(struct gpio_chip *gpio, unsigned int nr)
+{
+	struct pci1xxxx_gpio *priv = gpiochip_get_data(gpio);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	pci1xxx_assign_bit(priv->reg_base, INP_EN_OFFSET(nr), (nr % 32), true);
+	pci1xxx_assign_bit(priv->reg_base, OUT_EN_OFFSET(nr), (nr % 32), false);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int pci1xxxx_gpio_get(struct gpio_chip *gpio, unsigned int nr)
+{
+	struct pci1xxxx_gpio *priv = gpiochip_get_data(gpio);
+
+	return (readl(priv->reg_base + INP_OFFSET(nr)) >> (nr % 32)) & 1;
+}
+
+static int pci1xxxx_gpio_direction_output(struct gpio_chip *gpio,
+					  unsigned int nr, int val)
+{
+	struct pci1xxxx_gpio *priv = gpiochip_get_data(gpio);
+	unsigned long flags;
+	u32 data;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	pci1xxx_assign_bit(priv->reg_base, INP_EN_OFFSET(nr), (nr % 32), false);
+	pci1xxx_assign_bit(priv->reg_base, OUT_EN_OFFSET(nr), (nr % 32), true);
+	data = readl(priv->reg_base + OUT_OFFSET(nr));
+	if (val)
+		data |= (1 << (nr % 32));
+	else
+		data &= ~(1 << (nr % 32));
+	writel(data, priv->reg_base + OUT_OFFSET(nr));
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static void pci1xxxx_gpio_set(struct gpio_chip *gpio,
+			      unsigned int nr, int val)
+{
+	struct pci1xxxx_gpio *priv = gpiochip_get_data(gpio);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	pci1xxx_assign_bit(priv->reg_base, OUT_OFFSET(nr), (nr % 32), val);
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
 static int pci1xxxx_gpio_set_config(struct gpio_chip *gpio, unsigned int offset,
 				    unsigned long config)
 {
@@ -81,6 +155,11 @@ static int pci1xxxx_gpio_setup(struct pci1xxxx_gpio *priv, int irq)
 	gchip->label = dev_name(&priv->aux_dev->dev);
 	gchip->parent = &priv->aux_dev->dev;
 	gchip->owner = THIS_MODULE;
+	gchip->direction_input = pci1xxxx_gpio_direction_input;
+	gchip->direction_output = pci1xxxx_gpio_direction_output;
+	gchip->get_direction = pci1xxxx_gpio_get_direction;
+	gchip->get = pci1xxxx_gpio_get;
+	gchip->set = pci1xxxx_gpio_set;
 	gchip->set_config = pci1xxxx_gpio_set_config;
 	gchip->dbg_show = NULL;
 	gchip->base = -1;
-- 
2.25.1

