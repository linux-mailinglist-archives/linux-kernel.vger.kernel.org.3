Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5554547EF94
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 15:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352938AbhLXO3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 09:29:50 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:18174 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1352920AbhLXO3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 09:29:47 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="104623533"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Dec 2021 23:29:45 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 07B9C4000ABD;
        Fri, 24 Dec 2021 23:29:43 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-serial@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 02/10] serial: 8250_bcm7271: Use platform_get_irq() to get the interrupt
Date:   Fri, 24 Dec 2021 14:29:08 +0000
Message-Id: <20211224142917.6966-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 drivers/tty/serial/8250/8250_bcm7271.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 5163d60756b7..7ecfcc650d28 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -941,7 +941,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 	struct brcmuart_priv *priv;
 	struct clk *baud_mux_clk;
 	struct uart_8250_port up;
-	struct resource *irq;
+	int irq;
 	void __iomem *membase = NULL;
 	resource_size_t mapbase = 0;
 	u32 clk_rate = 0;
@@ -952,11 +952,9 @@ static int brcmuart_probe(struct platform_device *pdev)
 		"uart", "dma_rx", "dma_tx", "dma_intr2", "dma_arb"
 	};
 
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq) {
-		dev_err(dev, "missing irq\n");
-		return -EINVAL;
-	}
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 	priv = devm_kzalloc(dev, sizeof(struct brcmuart_priv),
 			GFP_KERNEL);
 	if (!priv)
@@ -1044,7 +1042,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 	up.port.dev = dev;
 	up.port.mapbase = mapbase;
 	up.port.membase = membase;
-	up.port.irq = irq->start;
+	up.port.irq = irq;
 	up.port.handle_irq = brcmuart_handle_irq;
 	up.port.regshift = 2;
 	up.port.iotype = of_device_is_big_endian(np) ?
-- 
2.17.1

