Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6BF511B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbiD0N07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbiD0N0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:26:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82D42DD60;
        Wed, 27 Apr 2022 06:23:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 295841F44713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651065815;
        bh=RYxkRKR/3cb3vO8LFUsbVomDNF2N7fZfsSHl253gbJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GvauR+UFrvlr16NuXikZ4xqvxHUuYosy7/elmDi1uLZJ/0qtujA+fxTIF4GgIrfML
         51OuOWqZdmphgHexTugZIhUq66T7pTs60Tp+yuCaIL3+gwdRIRzNxLe5GfwgHxiz/j
         QhOwC0e/9swV2+fk8Hp/hom9QA4Y/kmK95qwoPLeziviiXjK6bBTvMZO1EWiI3qC5Y
         UQ3hUwjF2LOhIkmORZnegIhXYEK5m63eUuWcyV6KieJKeFa1QuMexmmM15pfaYWvIn
         P+7w1KsiZNZg0jl2PavK9mu/ztDgcKUge51kgFjT+KQEJQmuqp391Ela1nrV6L3yfj
         3jmXh7Pjo18pQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, zhiyong.tao@mediatek.com,
        colin.king@intel.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] serial: 8250_mtk: Fix UART_EFR register address
Date:   Wed, 27 Apr 2022 15:23:26 +0200
Message-Id: <20220427132328.228297-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220427132328.228297-1-angelogioacchino.delregno@collabora.com>
References: <20220427132328.228297-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On MediaTek SoCs, the UART IP is 16550A compatible, but there are some
specific quirks: we are declaring a register shift of 2, but this is
only valid for the majority of the registers, as there are some that
are out of the standard layout.

Specifically, this driver is using definitions from serial_reg.h, where
we have a UART_EFR register defined as 2: this results in a 0x8 offset,
but there we have the FCR register instead.

The right offset for the EFR register on MediaTek UART is at 0x98,
so, following the decimal definition convention in serial_reg.h and
accounting for the register left shift of two, add and use the correct
register address for this IP, defined as decimal 38, so that the final
calculation results in (0x26 << 2) = 0x98.

Fixes: bdbd0a7f8f03 ("serial: 8250-mtk: modify baudrate setting")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index f4a0caa56f84..cd62a5f34014 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -37,6 +37,7 @@
 #define MTK_UART_IER_RTSI	0x40	/* Enable RTS Modem status interrupt */
 #define MTK_UART_IER_CTSI	0x80	/* Enable CTS Modem status interrupt */
 
+#define MTK_UART_EFR		38	/* I/O: Extended Features Register */
 #define MTK_UART_EFR_EN		0x10	/* Enable enhancement feature */
 #define MTK_UART_EFR_RTS	0x40	/* Enable hardware rx flow control */
 #define MTK_UART_EFR_CTS	0x80	/* Enable hardware tx flow control */
@@ -169,7 +170,7 @@ static void mtk8250_dma_enable(struct uart_8250_port *up)
 		   MTK_UART_DMA_EN_RX | MTK_UART_DMA_EN_TX);
 
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-	serial_out(up, UART_EFR, UART_EFR_ECB);
+	serial_out(up, MTK_UART_EFR, UART_EFR_ECB);
 	serial_out(up, UART_LCR, lcr);
 
 	if (dmaengine_slave_config(dma->rxchan, &dma->rxconf) != 0)
@@ -232,7 +233,7 @@ static void mtk8250_set_flow_ctrl(struct uart_8250_port *up, int mode)
 	int lcr = serial_in(up, UART_LCR);
 
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-	serial_out(up, UART_EFR, UART_EFR_ECB);
+	serial_out(up, MTK_UART_EFR, UART_EFR_ECB);
 	serial_out(up, UART_LCR, lcr);
 	lcr = serial_in(up, UART_LCR);
 
@@ -241,7 +242,7 @@ static void mtk8250_set_flow_ctrl(struct uart_8250_port *up, int mode)
 		serial_out(up, MTK_UART_ESCAPE_DAT, MTK_UART_ESCAPE_CHAR);
 		serial_out(up, MTK_UART_ESCAPE_EN, 0x00);
 		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-		serial_out(up, UART_EFR, serial_in(up, UART_EFR) &
+		serial_out(up, MTK_UART_EFR, serial_in(up, MTK_UART_EFR) &
 			(~(MTK_UART_EFR_HW_FC | MTK_UART_EFR_SW_FC_MASK)));
 		serial_out(up, UART_LCR, lcr);
 		mtk8250_disable_intrs(up, MTK_UART_IER_XOFFI |
@@ -255,8 +256,8 @@ static void mtk8250_set_flow_ctrl(struct uart_8250_port *up, int mode)
 		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 
 		/*enable hw flow control*/
-		serial_out(up, UART_EFR, MTK_UART_EFR_HW_FC |
-			(serial_in(up, UART_EFR) &
+		serial_out(up, MTK_UART_EFR, MTK_UART_EFR_HW_FC |
+			(serial_in(up, MTK_UART_EFR) &
 			(~(MTK_UART_EFR_HW_FC | MTK_UART_EFR_SW_FC_MASK))));
 
 		serial_out(up, UART_LCR, lcr);
@@ -270,8 +271,8 @@ static void mtk8250_set_flow_ctrl(struct uart_8250_port *up, int mode)
 		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 
 		/*enable sw flow control */
-		serial_out(up, UART_EFR, MTK_UART_EFR_XON1_XOFF1 |
-			(serial_in(up, UART_EFR) &
+		serial_out(up, MTK_UART_EFR, MTK_UART_EFR_XON1_XOFF1 |
+			(serial_in(up, MTK_UART_EFR) &
 			(~(MTK_UART_EFR_HW_FC | MTK_UART_EFR_SW_FC_MASK))));
 
 		serial_out(up, UART_XON1, START_CHAR(port->state->port.tty));
-- 
2.35.1

