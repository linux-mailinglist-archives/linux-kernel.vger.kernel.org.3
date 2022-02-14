Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C24E4B5CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiBNVc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:32:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiBNVaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:30:46 -0500
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B8214235D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:30:36 -0800 (PST)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1nJivO-00AkGx-Ej; Mon, 14 Feb 2022 21:30:22 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] serial: imx: leave IRTS disabled if using modem-control CTS
Date:   Mon, 14 Feb 2022 13:30:20 -0800
Message-Id: <20220214213020.685-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If using modem-control gpios for CTS we must leave IRTS disabled
as otherwise the hardware will only transmit based on the internal RTS
pin routed to it.

This allows hardware flow control to be used with cts-gpios.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/tty/serial/imx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index df8a0c8b8b29..bf2bb987a51f 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -201,6 +201,7 @@ struct imx_port {
 	unsigned int		old_status;
 	unsigned int		have_rtscts:1;
 	unsigned int		have_rtsgpio:1;
+	unsigned int		have_ctsgpio:1;
 	unsigned int		dte_mode:1;
 	unsigned int		inverted_tx:1;
 	unsigned int		inverted_rx:1;
@@ -1674,8 +1675,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 		if (ucr2 & UCR2_CTS)
 			ucr2 |= UCR2_CTSC;
 	}
-
-	if (termios->c_cflag & CRTSCTS)
+	if (!sport->have_ctsgpio && termios->c_cflag & CRTSCTS)
 		ucr2 &= ~UCR2_IRTS;
 	if (termios->c_cflag & CSTOPB)
 		ucr2 |= UCR2_STPB;
@@ -2227,6 +2227,9 @@ static int imx_uart_probe(struct platform_device *pdev)
 	if (of_get_property(np, "fsl,dte-mode", NULL))
 		sport->dte_mode = 1;
 
+	if (of_get_property(np, "cts-gpios", NULL))
+		sport->have_ctsgpio = 1;
+
 	if (of_get_property(np, "rts-gpios", NULL))
 		sport->have_rtsgpio = 1;
 
-- 
2.17.1

