Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7195247EF9F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 15:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353028AbhLXOaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 09:30:09 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:8002 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1353017AbhLXOaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 09:30:02 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="104623549"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Dec 2021 23:30:01 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 02DE34000ABD;
        Fri, 24 Dec 2021 23:29:59 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 08/10] serial: ar933x: Use platform_get_irq() to get the interrupt
Date:   Fri, 24 Dec 2021 14:29:14 +0000
Message-Id: <20211224142917.6966-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 drivers/tty/serial/ar933x_uart.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 4379ca4842ae..8cabe50c4a33 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -707,11 +707,11 @@ static int ar933x_uart_probe(struct platform_device *pdev)
 	struct ar933x_uart_port *up;
 	struct uart_port *port;
 	struct resource *mem_res;
-	struct resource *irq_res;
 	struct device_node *np;
 	unsigned int baud;
 	int id;
 	int ret;
+	int irq;
 
 	np = pdev->dev.of_node;
 	if (IS_ENABLED(CONFIG_OF) && np) {
@@ -730,11 +730,9 @@ static int ar933x_uart_probe(struct platform_device *pdev)
 	if (id >= CONFIG_SERIAL_AR933X_NR_UARTS)
 		return -EINVAL;
 
-	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq_res) {
-		dev_err(&pdev->dev, "no IRQ resource\n");
-		return -EINVAL;
-	}
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	up = devm_kzalloc(&pdev->dev, sizeof(struct ar933x_uart_port),
 			  GFP_KERNEL);
@@ -766,7 +764,7 @@ static int ar933x_uart_probe(struct platform_device *pdev)
 
 	port->mapbase = mem_res->start;
 	port->line = id;
-	port->irq = irq_res->start;
+	port->irq = irq;
 	port->dev = &pdev->dev;
 	port->type = PORT_AR933X;
 	port->iotype = UPIO_MEM32;
-- 
2.17.1

