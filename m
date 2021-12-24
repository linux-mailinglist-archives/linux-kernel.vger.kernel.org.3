Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD0847EFA1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 15:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353000AbhLXOaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 09:30:15 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:55816 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1352956AbhLXOaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 09:30:08 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="104623572"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Dec 2021 23:30:07 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 202D04000AA9;
        Fri, 24 Dec 2021 23:30:04 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/10] serial: pmac_zilog: Use platform_get_irq() to get the interrupt
Date:   Fri, 24 Dec 2021 14:29:16 +0000
Message-Id: <20211224142917.6966-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 drivers/tty/serial/pmac_zilog.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index 12ce150b0ad4..5359236b32d6 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -1702,17 +1702,21 @@ extern struct platform_device scc_a_pdev, scc_b_pdev;
 
 static int __init pmz_init_port(struct uart_pmac_port *uap)
 {
-	struct resource *r_ports, *r_irq;
+	struct resource *r_ports;
+	int irq;
 
 	r_ports = platform_get_resource(uap->pdev, IORESOURCE_MEM, 0);
-	r_irq = platform_get_resource(uap->pdev, IORESOURCE_IRQ, 0);
-	if (!r_ports || !r_irq)
+	if (!r_ports)
 		return -ENODEV;
 
+	irq = platform_get_irq(uap->pdev, 0);
+	if (irq < 0)
+		return irq;
+
 	uap->port.mapbase  = r_ports->start;
 	uap->port.membase  = (unsigned char __iomem *) r_ports->start;
 	uap->port.iotype   = UPIO_MEM;
-	uap->port.irq      = r_irq->start;
+	uap->port.irq      = irq;
 	uap->port.uartclk  = ZS_CLOCK;
 	uap->port.fifosize = 1;
 	uap->port.ops      = &pmz_pops;
-- 
2.17.1

