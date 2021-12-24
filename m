Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820D447EF99
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 15:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352989AbhLXO36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 09:29:58 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:18174 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1352958AbhLXO3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 09:29:54 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="104623543"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Dec 2021 23:29:54 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id C85C34000ABD;
        Fri, 24 Dec 2021 23:29:52 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 05/10] serial: pxa: Use platform_get_irq() to get the interrupt
Date:   Fri, 24 Dec 2021 14:29:11 +0000
Message-Id: <20211224142917.6966-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 drivers/tty/serial/pxa.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 41319ef96fa6..30b099746a75 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -842,14 +842,18 @@ static int serial_pxa_probe_dt(struct platform_device *pdev,
 static int serial_pxa_probe(struct platform_device *dev)
 {
 	struct uart_pxa_port *sport;
-	struct resource *mmres, *irqres;
+	struct resource *mmres;
 	int ret;
+	int irq;
 
 	mmres = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	irqres = platform_get_resource(dev, IORESOURCE_IRQ, 0);
-	if (!mmres || !irqres)
+	if (!mmres)
 		return -ENODEV;
 
+	irq = platform_get_irq(dev, 0);
+	if (irq < 0)
+		return irq;
+
 	sport = kzalloc(sizeof(struct uart_pxa_port), GFP_KERNEL);
 	if (!sport)
 		return -ENOMEM;
@@ -869,7 +873,7 @@ static int serial_pxa_probe(struct platform_device *dev)
 	sport->port.type = PORT_PXA;
 	sport->port.iotype = UPIO_MEM;
 	sport->port.mapbase = mmres->start;
-	sport->port.irq = irqres->start;
+	sport->port.irq = irq;
 	sport->port.fifosize = 64;
 	sport->port.ops = &serial_pxa_pops;
 	sport->port.dev = &dev->dev;
-- 
2.17.1

