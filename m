Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1E55495B7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384158AbiFMOfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 10:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385485AbiFMObO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 10:31:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC05FABE53;
        Mon, 13 Jun 2022 04:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655120937; x=1686656937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5NKcZfokKiMXdb17rYsBnqG3M0QQOCbpXskNYGP1iPc=;
  b=Wf6prYgfnWgOYOvlQEM8pmqsZCuNycOQSUs0derxDUXgXzyLDmXVsGi1
   ZK0MsbMtdT86rM2A9rj2otUwSXGrS6IkP1/6C0Krt5fvAWyet1Y942c/L
   U6NCkJ1RQQxJ92gbPzbUT65txwGuwtg+cbiFV8pcAEf+64BP2Ihy2uOUC
   LXHGjz5l0ZxV7GF8tus8DgAkX6UqFViUBMSkkoJL+nZRMScA8shBBMbzh
   98YYvxPkJEhoZJONdPwYYxlcRbyCT0x1vWXy4RvaZOPa54kX9b102drIS
   hPoL9I9L9vIaiEgPZdlRNhcFDfTIpF7rme1c2MN0Nu4Zy/rulial4rUsA
   w==;
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="168174932"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2022 04:48:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Jun 2022 04:48:31 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 13 Jun 2022 04:48:29 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] usb: musb: Add support for PolarFire SoC's musb controller
Date:   Mon, 13 Jun 2022 12:46:42 +0100
Message-ID: <20220613114642.1615292-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220613114642.1615292-1-conor.dooley@microchip.com>
References: <20220613114642.1615292-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Microchips's PolarFire SoC's musb controller in host,
peripheral and otg mode.

Tested-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/usb/musb/Kconfig  |  13 +-
 drivers/usb/musb/Makefile |   1 +
 drivers/usb/musb/mpfs.c   | 265 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 278 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/musb/mpfs.c

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 4d61df6a9b5c..f906dfd360d3 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -123,6 +123,17 @@ config USB_MUSB_MEDIATEK
 	select GENERIC_PHY
 	select USB_ROLE_SWITCH
 
+config USB_MUSB_POLARFIRE_SOC
+	tristate "Microchip PolarFire SoC platforms"
+	depends on SOC_MICROCHIP_POLARFIRE || COMPILE_TEST
+	depends on NOP_USB_XCEIV
+	select USB_MUSB_DUAL_ROLE
+	help
+	  Say Y here to enable support for USB on Microchip's PolarFire SoC.
+
+	  This support is also available as a module.  If so, the module
+	  will be called mpfs.
+
 comment "MUSB DMA mode"
 
 config MUSB_PIO_ONLY
@@ -146,7 +157,7 @@ config USB_UX500_DMA
 
 config USB_INVENTRA_DMA
 	bool 'Inventra'
-	depends on USB_MUSB_OMAP2PLUS || USB_MUSB_MEDIATEK || USB_MUSB_JZ4740
+	depends on USB_MUSB_OMAP2PLUS || USB_MUSB_MEDIATEK || USB_MUSB_JZ4740 || USB_MUSB_POLARFIRE_SOC
 	help
 	  Enable DMA transfers using Mentor's engine.
 
diff --git a/drivers/usb/musb/Makefile b/drivers/usb/musb/Makefile
index 932247360a9f..51dd54a8de49 100644
--- a/drivers/usb/musb/Makefile
+++ b/drivers/usb/musb/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_USB_MUSB_UX500)			+= ux500.o
 obj-$(CONFIG_USB_MUSB_JZ4740)			+= jz4740.o
 obj-$(CONFIG_USB_MUSB_SUNXI)			+= sunxi.o
 obj-$(CONFIG_USB_MUSB_MEDIATEK)      		+= mediatek.o
+obj-$(CONFIG_USB_MUSB_POLARFIRE_SOC)		+= mpfs.o
 
 # the kconfig must guarantee that only one of the
 # possible I/O schemes will be enabled at a time ...
diff --git a/drivers/usb/musb/mpfs.c b/drivers/usb/musb/mpfs.c
new file mode 100644
index 000000000000..99666ef8af06
--- /dev/null
+++ b/drivers/usb/musb/mpfs.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PolarFire SoC (MPFS) MUSB Glue Layer
+ *
+ * Copyright (c) 2020-2022 Microchip Corporation. All rights reserved.
+ * Based on {omap2430,tusb6010,ux500}.c
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/usb/usb_phy_generic.h>
+#include "musb_core.h"
+#include "musb_dma.h"
+
+#define MPFS_MUSB_MAX_EP_NUM	8
+#define MPFS_MUSB_RAM_BITS	12
+
+struct mpfs_glue {
+	struct device *dev;
+	struct platform_device *musb;
+	struct platform_device *phy;
+	struct clk *clk;
+};
+
+static struct musb_fifo_cfg mpfs_musb_mode_cfg[] = {
+	{ .hw_ep_num = 1, .style = FIFO_TX, .maxpacket = 512, },
+	{ .hw_ep_num = 1, .style = FIFO_RX, .maxpacket = 512, },
+	{ .hw_ep_num = 2, .style = FIFO_TX, .maxpacket = 512, },
+	{ .hw_ep_num = 2, .style = FIFO_RX, .maxpacket = 512, },
+	{ .hw_ep_num = 3, .style = FIFO_TX, .maxpacket = 512, },
+	{ .hw_ep_num = 3, .style = FIFO_RX, .maxpacket = 512, },
+	{ .hw_ep_num = 4, .style = FIFO_TX, .maxpacket = 1024, },
+	{ .hw_ep_num = 4, .style = FIFO_RX, .maxpacket = 4096, },
+};
+
+static const struct musb_hdrc_config mpfs_musb_hdrc_config = {
+	.fifo_cfg = mpfs_musb_mode_cfg,
+	.fifo_cfg_size = ARRAY_SIZE(mpfs_musb_mode_cfg),
+	.multipoint = true,
+	.dyn_fifo = true,
+	.num_eps = MPFS_MUSB_MAX_EP_NUM,
+	.ram_bits = MPFS_MUSB_RAM_BITS,
+};
+
+static irqreturn_t mpfs_musb_interrupt(int irq, void *__hci)
+{
+	unsigned long flags;
+	irqreturn_t ret = IRQ_NONE;
+	struct musb *musb = __hci;
+
+	spin_lock_irqsave(&musb->lock, flags);
+
+	musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB);
+	musb->int_tx = musb_readw(musb->mregs, MUSB_INTRTX);
+	musb->int_rx = musb_readw(musb->mregs, MUSB_INTRRX);
+
+	if (musb->int_usb || musb->int_tx || musb->int_rx) {
+		musb_writeb(musb->mregs, MUSB_INTRUSB, musb->int_usb);
+		musb_writew(musb->mregs, MUSB_INTRTX, musb->int_tx);
+		musb_writew(musb->mregs, MUSB_INTRRX, musb->int_rx);
+		ret = musb_interrupt(musb);
+	}
+
+	spin_unlock_irqrestore(&musb->lock, flags);
+
+	return ret;
+}
+
+static void mpfs_musb_set_vbus(struct musb *musb, int is_on)
+{
+	u8 devctl;
+
+	/*
+	 * HDRC controls CPEN, but beware current surges during device
+	 * connect.  They can trigger transient overcurrent conditions
+	 * that must be ignored.
+	 */
+	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
+
+	if (is_on) {
+		musb->is_active = 1;
+		musb->xceiv->otg->default_a = 1;
+		musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
+		devctl |= MUSB_DEVCTL_SESSION;
+		MUSB_HST_MODE(musb);
+	} else {
+		musb->is_active = 0;
+
+		/*
+		 * NOTE:  skipping A_WAIT_VFALL -> A_IDLE and
+		 * jumping right to B_IDLE...
+		 */
+		musb->xceiv->otg->default_a = 0;
+		musb->xceiv->otg->state = OTG_STATE_B_IDLE;
+		devctl &= ~MUSB_DEVCTL_SESSION;
+
+		MUSB_DEV_MODE(musb);
+	}
+
+	musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
+
+	dev_dbg(musb->controller, "VBUS %s, devctl %02x\n",
+		usb_otg_state_string(musb->xceiv->otg->state),
+		musb_readb(musb->mregs, MUSB_DEVCTL));
+}
+
+static int mpfs_musb_init(struct musb *musb)
+{
+	struct device *dev = musb->controller;
+
+	musb->xceiv = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
+	if (IS_ERR(musb->xceiv)) {
+		dev_err(dev, "HS UDC: no transceiver configured\n");
+		return PTR_ERR(musb->xceiv);
+	}
+
+	musb->dyn_fifo = true;
+	musb->isr = mpfs_musb_interrupt;
+
+	musb_platform_set_vbus(musb, 1);
+
+	return 0;
+}
+
+static const struct musb_platform_ops mpfs_ops = {
+	.quirks		= MUSB_DMA_INVENTRA,
+	.init		= mpfs_musb_init,
+	.fifo_mode	= 2,
+#ifdef CONFIG_USB_INVENTRA_DMA
+	.dma_init	= musbhs_dma_controller_create,
+	.dma_exit	= musbhs_dma_controller_destroy,
+#endif
+	.set_vbus	= mpfs_musb_set_vbus
+};
+
+static int mpfs_probe(struct platform_device *pdev)
+{
+	struct musb_hdrc_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct mpfs_glue *glue;
+	struct platform_device *musb_pdev;
+	struct device *dev = &pdev->dev;
+	struct clk *clk;
+	int ret;
+
+	glue = devm_kzalloc(dev, sizeof(*glue), GFP_KERNEL);
+	if (!glue)
+		return -ENOMEM;
+
+	musb_pdev = platform_device_alloc("musb-hdrc", PLATFORM_DEVID_AUTO);
+	if (!musb_pdev) {
+		dev_err(dev, "failed to allocate musb device\n");
+		return -ENOMEM;
+	}
+
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "failed to get clock\n");
+		ret = PTR_ERR(clk);
+		goto err_phy_release;
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable clock\n");
+		goto err_phy_release;
+	}
+
+	musb_pdev->dev.parent = dev;
+	musb_pdev->dev.coherent_dma_mask = DMA_BIT_MASK(39);
+	musb_pdev->dev.dma_mask = &musb_pdev->dev.coherent_dma_mask;
+	device_set_of_node_from_dev(&musb_pdev->dev, dev);
+
+	glue->dev = dev;
+	glue->musb = musb_pdev;
+	glue->clk = clk;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		goto err_clk_disable;
+
+	pdata->config = &mpfs_musb_hdrc_config;
+	pdata->platform_ops = &mpfs_ops;
+
+	pdata->mode = usb_get_dr_mode(dev);
+	if (pdata->mode == USB_DR_MODE_UNKNOWN) {
+		dev_info(dev, "No dr_mode property found, defaulting to otg\n");
+		pdata->mode = USB_DR_MODE_OTG;
+	}
+
+	glue->phy = usb_phy_generic_register();
+	if (IS_ERR(glue->phy)) {
+		dev_err(dev, "failed to register usb-phy %ld\n",
+			PTR_ERR(glue->phy));
+		goto err_clk_disable;
+	}
+
+	platform_set_drvdata(pdev, glue);
+
+	ret = platform_device_add_resources(musb_pdev, pdev->resource, pdev->num_resources);
+	if (ret) {
+		dev_err(dev, "failed to add resources\n");
+		goto err_clk_disable;
+	}
+
+	ret = platform_device_add_data(musb_pdev, pdata, sizeof(*pdata));
+	if (ret) {
+		dev_err(dev, "failed to add platform_data\n");
+		goto err_clk_disable;
+	}
+
+	ret = platform_device_add(musb_pdev);
+	if (ret) {
+		dev_err(dev, "failed to register musb device\n");
+		goto err_clk_disable;
+	}
+
+	dev_info(&pdev->dev, "Registered MPFS MUSB driver\n");
+	return 0;
+
+err_clk_disable:
+	clk_disable_unprepare(clk);
+
+err_phy_release:
+	usb_phy_generic_unregister(glue->phy);
+	platform_device_put(musb_pdev);
+	return ret;
+}
+
+static int mpfs_remove(struct platform_device *pdev)
+{
+	struct mpfs_glue *glue = platform_get_drvdata(pdev);
+
+	platform_device_unregister(glue->musb);
+	usb_phy_generic_unregister(pdev);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id mpfs_id_table[] = {
+	{ .compatible = "microchip,mpfs-musb" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mpfs_id_table);
+#endif
+
+static struct platform_driver mpfs_musb_driver = {
+	.probe = mpfs_probe,
+	.remove = mpfs_remove,
+	.driver = {
+		.name = "mpfs-musb",
+		.of_match_table = of_match_ptr(mpfs_id_table)
+	},
+};
+
+module_platform_driver(mpfs_musb_driver);
+
+MODULE_DESCRIPTION("PolarFire SoC MUSB Glue Layer");
+MODULE_LICENSE("GPL");
-- 
2.36.1

