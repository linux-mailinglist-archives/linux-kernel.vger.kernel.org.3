Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4285A6BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiH3SCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiH3SBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:01:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F82B81E1;
        Tue, 30 Aug 2022 11:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661882494; x=1693418494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FyggbpqorrMc8GLbvcRrEkWiM/E5tR2cnCbtt20Xe40=;
  b=mUxKuMfNkv0Cu8S2wJj+wx8wzq1lFLpNy4DoBkhTJJVkyVmcG6Ox/erZ
   d5KtnFyrB1AqfAGTminD+WRHLfXR9PAY+FEJMxTCOEG0M/za6MgN5x/aY
   f1SBQO3/xbR62YVsQcnUzIdmqL/nD2QzO6Q1cNHnfUB+yS+vgReHxmFtq
   wbCROxm8R+WAmP4d0RD5BPu2kxHLLtLCxQAHRhghA8jBG46z4bu0rh9iB
   JUF+NLIGgAD9CK8Vx3DU4llxXCR05NTgu+0RilS+VuhVtnGKpEurZfLlf
   eLt7Whibys2qO6n4bU7Sisht6TVK+tOHsHA89CuXWaoIQQpy1jsV8Nkp4
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="178360340"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 11:01:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 11:01:31 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 30 Aug 2022 11:01:26 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <andy.shevchenko@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <johan@kernel.org>,
        <wander@redhat.com>, <etremblay@distech-controls.com>,
        <macro@orcam.me.uk>, <geert+renesas@glider.be>, <jk@ozlabs.org>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH v1 tty-next 2/2] 8250: microchip: pci1xxxx: Add power management functions to pci1xxxx's  quad-uart driver.
Date:   Tue, 30 Aug 2022 23:30:54 +0530
Message-ID: <20220830180054.1998296-3-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830180054.1998296-1-kumaravel.thiagarajan@microchip.com>
References: <20220830180054.1998296-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci1xxxx's quad-uart function has the capability to wake up the host from
suspend state. Enable wakeup before entering into suspend and disable
wakeup upon resume.

Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
---
 drivers/tty/serial/8250/8250_pci1xxxx.c | 122 ++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index 56852ae0585e..38c2a6a9e5d5 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -70,6 +70,7 @@
 
 #define UART_PCI_CTRL_REG		0x80
 #define UART_PCI_CTRL_SET_MULTIPLE_MSI	BIT(4)
+#define UART_PCI_CTRL_D3_CLK_ENABLE	BIT(0)
 
 #define UART_WAKE_REG			0x8C
 #define UART_WAKE_MASK_REG		0x90
@@ -78,6 +79,9 @@
 #define UART_WAKE_INT			BIT(0)
 #define UART_WAKE_SRCS			(UART_WAKE_N_PIN | UART_WAKE_NCTS | UART_WAKE_INT)
 
+#define UART_RESET_REG			0x94
+#define UART_RESET_D3_RESET_DISABLE	BIT(16)
+
 #define UART_BIT_SAMPLE_CNT 16
 
 struct pci1xxxx_8250 {
@@ -439,6 +443,121 @@ static void pci1xxxx_serial_remove(struct pci_dev *dev)
 		serial8250_unregister_port(priv->line[i]);
 }
 
+#ifdef CONFIG_PM_SLEEP
+
+static char pci1xxxx_port_suspend(int line)
+{
+	struct uart_8250_port *up = serial8250_get_port(line);
+	struct uart_port *port = &up->port;
+	unsigned long flags;
+	u8 wakeup_mask;
+	char ret = 0;
+
+	if (port->suspended == 0 && port->dev) {
+		wakeup_mask = readb(up->port.membase + UART_WAKE_MASK_REG);
+
+		spin_lock_irqsave(&port->lock, flags);
+		port->mctrl &= ~TIOCM_OUT2;
+		port->ops->set_mctrl(port, port->mctrl);
+		spin_unlock_irqrestore(&port->lock, flags);
+
+		if ((wakeup_mask & UART_WAKE_SRCS) != UART_WAKE_SRCS)
+			ret = 0x01;
+		else
+			ret = 0x00;
+	}
+
+	writeb(UART_WAKE_SRCS, port->membase + UART_WAKE_REG);
+
+	return ret;
+}
+
+void pci1xxxx_port_resume(int line)
+{
+	struct uart_8250_port *up = serial8250_get_port(line);
+	struct uart_port *port = &up->port;
+	unsigned long flags;
+
+	writeb(UART_WAKE_SRCS, port->membase + UART_WAKE_REG);
+
+	if (port->suspended == 0) {
+		spin_lock_irqsave(&port->lock, flags);
+		port->mctrl |= TIOCM_OUT2;
+		port->ops->set_mctrl(port, port->mctrl);
+		spin_unlock_irqrestore(&port->lock, flags);
+	}
+}
+
+static int pci1xxxx_suspend(struct device *dev)
+{
+	struct pci1xxxx_8250 *priv = dev_get_drvdata(dev);
+	struct pci_dev *pcidev = to_pci_dev(dev);
+	unsigned int data;
+	void __iomem *p;
+	char wakeup = 0;
+	int i;
+
+	for (i = 0; i < priv->nr; i++) {
+		if (priv->line[i] >= 0) {
+			serial8250_suspend_port(priv->line[i]);
+			wakeup |= pci1xxxx_port_suspend(priv->line[i]);
+		}
+	}
+
+	p = pci_ioremap_bar(pcidev, 0);
+	if (!p) {
+		dev_err(dev, "remapping of bar 0 memory failed");
+		return -ENOMEM;
+	}
+
+	data = readl(p + UART_RESET_REG);
+	writel(data | UART_RESET_D3_RESET_DISABLE, p + UART_RESET_REG);
+
+	if (wakeup)
+		writeb(UART_PCI_CTRL_D3_CLK_ENABLE, (p + UART_PCI_CTRL_REG));
+
+	iounmap(p);
+
+	device_set_wakeup_enable(dev, true);
+
+	pci_wake_from_d3(pcidev, true);
+
+	return 0;
+}
+
+static int pci1xxxx_resume(struct device *dev)
+{
+	struct pci1xxxx_8250 *priv = dev_get_drvdata(dev);
+	struct pci_dev *pcidev = to_pci_dev(dev);
+	unsigned int data;
+	void __iomem *p;
+	int i;
+
+	p = pci_ioremap_bar(pcidev, 0);
+	if (!p) {
+		dev_err(dev, "remapping of bar 0 memory failed");
+		return -ENOMEM;
+	}
+
+	data = readl(p + UART_RESET_REG);
+	writel(data & ~UART_RESET_D3_RESET_DISABLE, p + UART_RESET_REG);
+	iounmap(p);
+
+	for (i = 0; i < priv->nr; i++) {
+		if (priv->line[i] >= 0) {
+			pci1xxxx_port_resume(priv->line[i]);
+			serial8250_resume_port(priv->line[i]);
+		}
+	}
+
+	return 0;
+}
+
+#endif
+
+static SIMPLE_DEV_PM_OPS(pci1xxxx_pm_ops, pci1xxxx_suspend,
+			 pci1xxxx_resume);
+
 static const struct pci_device_id pci1xxxx_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MCHP_PCI1XXXX, PCI_DEVICE_ID_MCHP_PCI11010) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MCHP_PCI1XXXX, PCI_DEVICE_ID_MCHP_PCI11101) },
@@ -453,6 +572,9 @@ static struct pci_driver pci1xxxx_pci_driver = {
 	.name		= "pci1xxxx serial",
 	.probe		= pci1xxxx_serial_probe,
 	.remove	= pci1xxxx_serial_remove,
+	.driver	= {
+		.pm     = &pci1xxxx_pm_ops,
+	},
 	.id_table	= pci1xxxx_pci_tbl,
 };
 
-- 
2.25.1

