Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BFC47EF98
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 15:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352959AbhLXO3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 09:29:55 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:19891 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1352945AbhLXO3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 09:29:52 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="105108389"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 Dec 2021 23:29:52 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 661BC4000AA9;
        Fri, 24 Dec 2021 23:29:49 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 04/10] serial: meson: Use platform_get_irq() to get the interrupt
Date:   Fri, 24 Dec 2021 14:29:10 +0000
Message-Id: <20211224142917.6966-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211224142917.6966-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211224142917.6966-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/tty/serial/meson_uart.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index efee3935917f..4bc87f0c5868 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -713,10 +713,11 @@ static int meson_uart_probe_clocks(struct platform_device *pdev,
 
 static int meson_uart_probe(struct platform_device *pdev)
 {
-	struct resource *res_mem, *res_irq;
+	struct resource *res_mem;
 	struct uart_port *port;
 	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
 	int ret = 0;
+	int irq;
 
 	if (pdev->dev.of_node)
 		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
@@ -739,9 +740,9 @@ static int meson_uart_probe(struct platform_device *pdev)
 	if (!res_mem)
 		return -ENODEV;
 
-	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res_irq)
-		return -ENODEV;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
 
@@ -766,7 +767,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 	port->iotype = UPIO_MEM;
 	port->mapbase = res_mem->start;
 	port->mapsize = resource_size(res_mem);
-	port->irq = res_irq->start;
+	port->irq = irq;
 	port->flags = UPF_BOOT_AUTOCONF | UPF_LOW_LATENCY;
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MESON_CONSOLE);
 	port->dev = &pdev->dev;
-- 
2.17.1

