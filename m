Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1411484735
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 18:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbiADRut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 12:50:49 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:30825 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233839AbiADRuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:50:46 -0500
X-IronPort-AV: E=Sophos;i="5.88,261,1635174000"; 
   d="scan'208";a="105493655"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jan 2022 02:50:44 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id A87A240B3513;
        Wed,  5 Jan 2022 02:50:42 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-serial@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250_bcm7271: Fix return error code in case of dma_alloc_coherent() failure
Date:   Tue,  4 Jan 2022 17:50:08 +0000
Message-Id: <20220104175009.7029-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of dma_alloc_coherent() failure return -ENOMEM instead of
returning -EINVAL.

Fixes: c195438f1e84 ("serial: 8250_bcm7271: Propagate error codes from brcmuart_probe()")
Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi All,

This patch applies to -next.

Cheers,
Prabhakar
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

