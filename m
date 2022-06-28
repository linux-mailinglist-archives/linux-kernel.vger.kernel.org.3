Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847B855CAD4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344750AbiF1KJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344742AbiF1KJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:09:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD542F666;
        Tue, 28 Jun 2022 03:09:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D28ACB81D93;
        Tue, 28 Jun 2022 10:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50878C3411D;
        Tue, 28 Jun 2022 10:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656410986;
        bh=2kqaknsisyJeDGY+X+iXUz3e7OQebOSh2VPWs+t5KCg=;
        h=From:To:Cc:Subject:Date:From;
        b=q1iUDDhb4Thtudo3GzAwdrBX82kGmMRcje8fr/uXlbXAFdRnPNpKwhaAPQTN48ldn
         DyYyBVMqYtYsOhc8Mv6OGUCgEVB53zlNXTuk4ASoWTpN9k1CkhCs3bPwYSov+WosdU
         m5ZYQ33St0tkBwQZAXzqgVOiBBUUavpizv+AGDGIWvr6RmcpPWmtniqRh0KNqw8Yb6
         uBYzsw1KCOvX5Di4rUvkznt7Y0KoMCFmTBrBAzkt6VzkTyfUCOTvQ0FEpEj5oYOKhW
         UKhBXtsUGs0YhZyA2NrnTkIGQY6Ct5ofQj5YuiM5/B+wDkNH/zEOzzDfLSeGNHovR3
         bZxgAP1IuNIVA==
Received: by pali.im (Postfix)
        id 69C6D7AE; Tue, 28 Jun 2022 12:09:43 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Allen Yan <yanwei@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: mvebu-uart: correctly report configured baudrate value
Date:   Tue, 28 Jun 2022 12:09:22 +0200
Message-Id: <20220628100922.10717-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions tty_termios_encode_baud_rate() and uart_update_timeout() should
be called with the baudrate value which was set to hardware. Linux then
report exact values via ioctl(TCGETS2) to userspace.

Change mvebu_uart_baud_rate_set() function to return baudrate value which
was set to hardware and propagate this value to above mentioned functions.

With this change userspace would see precise value in termios c_ospeed
field.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 68a0db1d7da2 ("serial: mvebu-uart: add function to change baudrate")
---
 drivers/tty/serial/mvebu-uart.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 0429c2a54290..93489fe334d0 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -470,14 +470,14 @@ static void mvebu_uart_shutdown(struct uart_port *port)
 	}
 }
 
-static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
+static unsigned int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
 {
 	unsigned int d_divisor, m_divisor;
 	unsigned long flags;
 	u32 brdv, osamp;
 
 	if (!port->uartclk)
-		return -EOPNOTSUPP;
+		return 0;
 
 	/*
 	 * The baudrate is derived from the UART clock thanks to divisors:
@@ -548,7 +548,7 @@ static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
 			(m_divisor << 16) | (m_divisor << 24);
 	writel(osamp, port->membase + UART_OSAMP);
 
-	return 0;
+	return DIV_ROUND_CLOSEST(port->uartclk, d_divisor * m_divisor);
 }
 
 static void mvebu_uart_set_termios(struct uart_port *port,
@@ -587,15 +587,11 @@ static void mvebu_uart_set_termios(struct uart_port *port,
 	max_baud = port->uartclk / 80;
 
 	baud = uart_get_baud_rate(port, termios, old, min_baud, max_baud);
-	if (mvebu_uart_baud_rate_set(port, baud)) {
-		/* No clock available, baudrate cannot be changed */
-		if (old)
-			baud = uart_get_baud_rate(port, old, NULL,
-						  min_baud, max_baud);
-	} else {
-		tty_termios_encode_baud_rate(termios, baud, baud);
-		uart_update_timeout(port, termios->c_cflag, baud);
-	}
+	baud = mvebu_uart_baud_rate_set(port, baud);
+
+	/* In case baudrate cannot be changed, report previous old value */
+	if (baud == 0 && old)
+		baud = tty_termios_baud_rate(old);
 
 	/* Only the following flag changes are supported */
 	if (old) {
@@ -606,6 +602,11 @@ static void mvebu_uart_set_termios(struct uart_port *port,
 		termios->c_cflag |= CS8;
 	}
 
+	if (baud != 0) {
+		tty_termios_encode_baud_rate(termios, baud, baud);
+		uart_update_timeout(port, termios->c_cflag, baud);
+	}
+
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-- 
2.20.1

