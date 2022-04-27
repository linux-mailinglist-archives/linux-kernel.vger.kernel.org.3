Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C70E511B58
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbiD0N1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbiD0N0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:26:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC62286E0;
        Wed, 27 Apr 2022 06:23:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 78D631F4471A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651065817;
        bh=uRQdcys3z/Emz/ixII4iTX7rXIoznp7TRtvB9lmKeyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OX1E2DEzL3Lk67s5YbsSBKxcjsDM6MPwMEIjWY+Y/QyJwGNJUhMsq8KYUdn+8Hyum
         8aqBTffHO92lnKsSuhozqFrbGe/Zo/AJ5ylih7M1w6aAF/mdXKgvvDg3C2tDfu40sX
         w30c3pLWA6/dJbFzFOOKr3SPZa2Rqcmm6JqsPNmCLGPzkTU8UwQ+6Bu68Xh9Ubb1jO
         U+bFJmjQGNVZJHzaPCF9UGqWmdymZ2qajKhVWkycQW7dw4HucAK+vobR5w9s6Hg4dx
         SL4HGydx5PjViEHTTBGGJRP1cXsieo2nj2h9KudkzDwqd3Hkpz51rUgtwmbwZ3dftQ
         UwAvLcz5L+DVQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, zhiyong.tao@mediatek.com,
        colin.king@intel.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] serial: 8250_mtk: Fix register address for XON/XOFF character
Date:   Wed, 27 Apr 2022 15:23:28 +0200
Message-Id: <20220427132328.228297-4-angelogioacchino.delregno@collabora.com>
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

The XON1/XOFF1 character registers are at offset 0xa0 and 0xa8
respectively, so we cannot use the definition in serial_port.h.

Fixes: bdbd0a7f8f03 ("serial: 8250-mtk: modify baudrate setting")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 28e36459642c..21053db93ff1 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -57,6 +57,9 @@
 #define MTK_UART_FEATURE_SEL	39	/* Feature Selection register */
 #define MTK_UART_FEAT_NEWRMAP	BIT(0)	/* Use new register map */
 
+#define MTK_UART_XON1		40	/* I/O: Xon character 1 */
+#define MTK_UART_XOFF1		42	/* I/O: Xoff character 1 */
+
 #ifdef CONFIG_SERIAL_8250_DMA
 enum dma_rx_status {
 	DMA_RX_START = 0,
@@ -278,8 +281,8 @@ static void mtk8250_set_flow_ctrl(struct uart_8250_port *up, int mode)
 			(serial_in(up, MTK_UART_EFR) &
 			(~(MTK_UART_EFR_HW_FC | MTK_UART_EFR_SW_FC_MASK))));
 
-		serial_out(up, UART_XON1, START_CHAR(port->state->port.tty));
-		serial_out(up, UART_XOFF1, STOP_CHAR(port->state->port.tty));
+		serial_out(up, MTK_UART_XON1, START_CHAR(port->state->port.tty));
+		serial_out(up, MTK_UART_XOFF1, STOP_CHAR(port->state->port.tty));
 		serial_out(up, UART_LCR, lcr);
 		mtk8250_disable_intrs(up, MTK_UART_IER_CTSI|MTK_UART_IER_RTSI);
 		mtk8250_enable_intrs(up, MTK_UART_IER_XOFFI);
-- 
2.35.1

