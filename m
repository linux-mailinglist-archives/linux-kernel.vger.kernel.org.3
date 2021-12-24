Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12FF47EFA3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 15:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353026AbhLXOaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 09:30:20 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:42271 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1353036AbhLXOaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 09:30:05 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="104623565"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Dec 2021 23:30:04 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4C5504000AA9;
        Fri, 24 Dec 2021 23:30:02 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/10] serial: bcm63xx: Use platform_get_irq() to get the interrupt
Date:   Fri, 24 Dec 2021 14:29:15 +0000
Message-Id: <20211224142917.6966-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 drivers/tty/serial/bcm63xx_uart.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 5fb0e84f7fd1..6471a54b616b 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -804,7 +804,7 @@ static struct uart_driver bcm_uart_driver = {
  */
 static int bcm_uart_probe(struct platform_device *pdev)
 {
-	struct resource *res_mem, *res_irq;
+	struct resource *res_mem;
 	struct uart_port *port;
 	struct clk *clk;
 	int ret;
@@ -833,9 +833,10 @@ static int bcm_uart_probe(struct platform_device *pdev)
 	if (IS_ERR(port->membase))
 		return PTR_ERR(port->membase);
 
-	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res_irq)
-		return -ENODEV;
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
+	port->irq = ret;
 
 	clk = clk_get(&pdev->dev, "refclk");
 	if (IS_ERR(clk) && pdev->dev.of_node)
@@ -845,7 +846,6 @@ static int bcm_uart_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	port->iotype = UPIO_MEM;
-	port->irq = res_irq->start;
 	port->ops = &bcm_uart_ops;
 	port->flags = UPF_BOOT_AUTOCONF;
 	port->dev = &pdev->dev;
-- 
2.17.1

