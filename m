Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA5F4857F1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242748AbiAESH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:07:29 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:43468 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242741AbiAESHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:07:20 -0500
X-IronPort-AV: E=Sophos;i="5.88,264,1635174000"; 
   d="scan'208";a="105608771"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Jan 2022 03:07:19 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 33BDC40BD264;
        Thu,  6 Jan 2022 03:07:17 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-serial@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] serial: 8250_bcm7271: Fix return error code in case of dma_alloc_coherent() failure
Date:   Wed,  5 Jan 2022 18:07:03 +0000
Message-Id: <20220105180704.8989-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of dma_alloc_coherent() failure return -ENOMEM instead of
returning -EINVAL.

Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
v1->v2
* Dropped fixes tag as suggested by Florian/Andy
---
 drivers/tty/serial/8250/8250_bcm7271.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index cc60a7874e8b..9b878d023dac 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1075,7 +1075,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 						   priv->rx_size,
 						   &priv->rx_addr, GFP_KERNEL);
 		if (!priv->rx_bufs) {
-			ret = -EINVAL;
+			ret = -ENOMEM;
 			goto err;
 		}
 		priv->tx_size = UART_XMIT_SIZE;
@@ -1083,7 +1083,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 						  priv->tx_size,
 						  &priv->tx_addr, GFP_KERNEL);
 		if (!priv->tx_buf) {
-			ret = -EINVAL;
+			ret = -ENOMEM;
 			goto err;
 		}
 	}
-- 
2.17.1

