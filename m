Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB2647EF95
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 15:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352954AbhLXO3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 09:29:53 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:18174 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1352929AbhLXO3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 09:29:49 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="104623536"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Dec 2021 23:29:48 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id AFE944008563;
        Fri, 24 Dec 2021 23:29:46 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-serial@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 03/10] serial: 8250_bcm7271: Propagate error codes from brcmuart_probe()
Date:   Fri, 24 Dec 2021 14:29:09 +0000
Message-Id: <20211224142917.6966-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211224142917.6966-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211224142917.6966-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of failures brcmuart_probe() always returned -ENODEV, this
isn't correct for example platform_get_irq_byname() may return
-EPROBE_DEFER to handle such cases propagate error codes in
brcmuart_probe() in case of failures.

Fixes: 41a469482de25 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 7ecfcc650d28..cc60a7874e8b 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1074,14 +1074,18 @@ static int brcmuart_probe(struct platform_device *pdev)
 		priv->rx_bufs = dma_alloc_coherent(dev,
 						   priv->rx_size,
 						   &priv->rx_addr, GFP_KERNEL);
-		if (!priv->rx_bufs)
+		if (!priv->rx_bufs) {
+			ret = -EINVAL;
 			goto err;
+		}
 		priv->tx_size = UART_XMIT_SIZE;
 		priv->tx_buf = dma_alloc_coherent(dev,
 						  priv->tx_size,
 						  &priv->tx_addr, GFP_KERNEL);
-		if (!priv->tx_buf)
+		if (!priv->tx_buf) {
+			ret = -EINVAL;
 			goto err;
+		}
 	}
 
 	ret = serial8250_register_8250_port(&up);
@@ -1095,6 +1099,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 	if (priv->dma_enabled) {
 		dma_irq = platform_get_irq_byname(pdev,  "dma");
 		if (dma_irq < 0) {
+			ret = dma_irq;
 			dev_err(dev, "no IRQ resource info\n");
 			goto err1;
 		}
@@ -1114,7 +1119,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 err:
 	brcmuart_free_bufs(dev, priv);
 	brcmuart_arbitration(priv, 0);
-	return -ENODEV;
+	return ret;
 }
 
 static int brcmuart_remove(struct platform_device *pdev)
-- 
2.17.1

