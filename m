Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6903E521568
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241798AbiEJMal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241776AbiEJMaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:30:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71B42A1FDE;
        Tue, 10 May 2022 05:26:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2DE551F414F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652185587;
        bh=BQiR+KethrLXSU5KRNxuCKrRdMtiP4LV9NgZmry1IWE=;
        h=From:To:Cc:Subject:Date:From;
        b=UK52OjymyXQ50bxoRn93D0H1e5AAiwKBVZ3CH5REP+WHLsQfiDY1Cr1yf+HvPeHme
         xZs2t6DYTdc3jgYH+FKahT6uhO30jn8605JcDiT78hETmnKriBbjXpWna273HPekNa
         3NxX6Mea2XVUY8lJuTYAwpUQ2Y7veS4HTV+o8C3VpP2BC0h0xA87aA4mvIuGyBDcpx
         0r5fF2hUoWTUn3mg/y/8/qefUvhl4Y4CF+jvWRmMk6BCO2HEq0LriJjOGz/KOextMH
         521oSnKXv/Vh1rF0+pDIoUoIaNZTke5cikYs+Fz752WOlD/EP6gTDj5EXPMFiTJMBZ
         eY171MRqval0Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, zhiyong.tao@mediatek.com,
        colin.king@intel.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org, broonie@kernel.org
Subject: [PATCH] Revert "serial: 8250_mtk: Make sure to select the right FEATURE_SEL"
Date:   Tue, 10 May 2022 14:26:20 +0200
Message-Id: <20220510122620.150342-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that some MediaTek SoCs are incompatible with this
change. Also, this register was mistakenly understood as it was
related to the 16550A register layout selection but, at least
on some IPs, if not all, it's related to something else unknown.

This reverts commit 6f81fdded0d024c7d4084d434764f30bca1cd6b1.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 21053db93ff1..54051ec7b499 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -54,9 +54,6 @@
 #define MTK_UART_TX_TRIGGER	1
 #define MTK_UART_RX_TRIGGER	MTK_UART_RX_SIZE
 
-#define MTK_UART_FEATURE_SEL	39	/* Feature Selection register */
-#define MTK_UART_FEAT_NEWRMAP	BIT(0)	/* Use new register map */
-
 #define MTK_UART_XON1		40	/* I/O: Xon character 1 */
 #define MTK_UART_XOFF1		42	/* I/O: Xoff character 1 */
 
@@ -575,10 +572,6 @@ static int mtk8250_probe(struct platform_device *pdev)
 		uart.dma = data->dma;
 #endif
 
-	/* Set AP UART new register map */
-	writel(MTK_UART_FEAT_NEWRMAP, uart.port.membase +
-	       (MTK_UART_FEATURE_SEL << uart.port.regshift));
-
 	/* Disable Rate Fix function */
 	writel(0x0, uart.port.membase +
 			(MTK_UART_RATE_FIX << uart.port.regshift));
-- 
2.35.1

