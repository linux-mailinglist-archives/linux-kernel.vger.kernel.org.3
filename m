Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89815493C3C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 15:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355294AbiASOwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 09:52:35 -0500
Received: from phobos.denx.de ([85.214.62.61]:37444 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234438AbiASOwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 09:52:34 -0500
Received: from maia.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: hws@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 3D76980FE7;
        Wed, 19 Jan 2022 15:52:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1642603952;
        bh=f1UL5ZbqpBe65Hd8Hn6QP0WymJkVOmVAYuASZr8TNFQ=;
        h=From:To:Cc:Subject:Date:From;
        b=OkwiJm0jfjgthaYU/zkcIuYEQDYgX7Zhxm37trT8rpS4Kdzyi1BmbISbABYMYH4il
         fRQOpJ64TTmCa+t9E8XTqNg4Q70UI6UV++T1s40pRN08T7gHiwTXVng8ILS1j19s2n
         o0mnpXpwp+s6Ls1KM3dGRol9FKm02XJE+CQ/bdmCXi6D/g48qaQ/cVco3GI0KWBBKH
         RV8J7tZw5U/GyiYigFp4LpKWZZYusm7wV8nAKRmuP+OAJXDjMesi5Bkz1bjEAB+fc7
         whFFmlnSdgevnpqP+AjlTPx9uTZ6W6rzMXUBDoKcK1Wi53TPlGFFp1Kj3fZSxnWrW/
         SYpIUKT9ZJ1yg==
From:   Harald Seiler <hws@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Harald Seiler <hws@denx.de>, Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: imx: Add fast path when rs485 delays are 0
Date:   Wed, 19 Jan 2022 15:52:03 +0100
Message-Id: <20220119145204.238767-1-hws@denx.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, even when `delay_rts_before_send` and `delay_rts_after_send`
are 0, the hrtimer is triggered (with timeout 0) which can introduce a
few 100us of additional overhead on slower i.MX platforms.

Implement a fast path when the delays are 0, where the RTS signal is
toggled immediately instead of going through an hrtimer.  This fast path
behaves identical to the code before delay support was implemented.

Signed-off-by: Harald Seiler <hws@denx.de>
---
 drivers/tty/serial/imx.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index df8a0c8b8b29..67bbbb69229d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -455,9 +455,14 @@ static void imx_uart_stop_tx(struct uart_port *port)
 	if (port->rs485.flags & SER_RS485_ENABLED) {
 		if (sport->tx_state == SEND) {
 			sport->tx_state = WAIT_AFTER_SEND;
-			start_hrtimer_ms(&sport->trigger_stop_tx,
+
+			if (port->rs485.delay_rts_after_send > 0) {
+				start_hrtimer_ms(&sport->trigger_stop_tx,
 					 port->rs485.delay_rts_after_send);
-			return;
+				return;
+			}
+
+			/* continue without any delay */
 		}
 
 		if (sport->tx_state == WAIT_AFTER_RTS ||
@@ -698,9 +703,14 @@ static void imx_uart_start_tx(struct uart_port *port)
 				imx_uart_stop_rx(port);
 
 			sport->tx_state = WAIT_AFTER_RTS;
-			start_hrtimer_ms(&sport->trigger_start_tx,
+
+			if (port->rs485.delay_rts_before_send > 0) {
+				start_hrtimer_ms(&sport->trigger_start_tx,
 					 port->rs485.delay_rts_before_send);
-			return;
+				return;
+			}
+
+			/* continue without any delay */
 		}
 
 		if (sport->tx_state == WAIT_AFTER_SEND
-- 
2.34.1

