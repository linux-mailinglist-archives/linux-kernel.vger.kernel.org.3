Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA784C28B1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiBXJ4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiBXJ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:56:30 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6921C285AA2;
        Thu, 24 Feb 2022 01:56:01 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 26FEF1F44A;
        Thu, 24 Feb 2022 09:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645696560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=757ZRRjpJoiVS489R5WI0W5vTxny+PNszy3i98nF14M=;
        b=Hx43IEhL5S0JH1QQPNvVsNkeyUHpp+Bxwc5FSojlyPhtozRZZnw+ZEiZuLoOyODUS38dlr
        Gf+cfNQTAl3PlE4PBEFU9lB9En0Moj3lQPSwq6qlnBxCLrfIHKFIuuomYafe9YugQ8PkZe
        VU1ZF4SSL2h8/lJ1I1APn/LjULzkZFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645696560;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=757ZRRjpJoiVS489R5WI0W5vTxny+PNszy3i98nF14M=;
        b=AlX7aBWo4+ZvAqOobLGxC0gwEW2VZ/fgkvq9hNQHPa1JBtCMVyb9A3YdIKlO83J7On+TII
        nHXgrTk6ZvDopIAA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D7B81A3B98;
        Thu, 24 Feb 2022 09:55:59 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Johan Hovold <johan@kernel.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 3/5] USB: serial: make use of UART_LCR_WLEN() + tty_get_char_size()
Date:   Thu, 24 Feb 2022 10:55:56 +0100
Message-Id: <20220224095558.30929-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224095558.30929-1-jslaby@suse.cz>
References: <20220224095517.30872-1-jslaby@suse.cz>
 <20220224095558.30929-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a generic UART_LCR_WLEN() macro and the tty_get_char_size()
helper, we can remove all those repeated switch-cases in drivers.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/serial/ark3116.c  | 17 ++---------------
 drivers/usb/serial/f81232.c   | 16 +---------------
 drivers/usb/serial/f81534.c   | 16 +---------------
 drivers/usb/serial/mos7720.c  | 20 +-------------------
 drivers/usb/serial/quatech2.c | 16 +---------------
 drivers/usb/serial/ssu100.c   | 16 +---------------
 6 files changed, 7 insertions(+), 94 deletions(-)

diff --git a/drivers/usb/serial/ark3116.c b/drivers/usb/serial/ark3116.c
index 5dd710e9fe7d..c0e4df87ff22 100644
--- a/drivers/usb/serial/ark3116.c
+++ b/drivers/usb/serial/ark3116.c
@@ -200,21 +200,8 @@ static void ark3116_set_termios(struct tty_struct *tty,
 	__u8 lcr, hcr, eval;
 
 	/* set data bit count */
-	switch (cflag & CSIZE) {
-	case CS5:
-		lcr = UART_LCR_WLEN5;
-		break;
-	case CS6:
-		lcr = UART_LCR_WLEN6;
-		break;
-	case CS7:
-		lcr = UART_LCR_WLEN7;
-		break;
-	default:
-	case CS8:
-		lcr = UART_LCR_WLEN8;
-		break;
-	}
+	lcr = UART_LCR_WLEN(tty_get_char_size(cflag));
+
 	if (cflag & CSTOPB)
 		lcr |= UART_LCR_STOP;
 	if (cflag & PARENB)
diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 3ad1f515fb68..d9f20256a6a8 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -643,21 +643,7 @@ static void f81232_set_termios(struct tty_struct *tty,
 	if (C_CSTOPB(tty))
 		new_lcr |= UART_LCR_STOP;
 
-	switch (C_CSIZE(tty)) {
-	case CS5:
-		new_lcr |= UART_LCR_WLEN5;
-		break;
-	case CS6:
-		new_lcr |= UART_LCR_WLEN6;
-		break;
-	case CS7:
-		new_lcr |= UART_LCR_WLEN7;
-		break;
-	default:
-	case CS8:
-		new_lcr |= UART_LCR_WLEN8;
-		break;
-	}
+	new_lcr |= UART_LCR_WLEN(tty_get_char_size(tty->termios.c_cflag));
 
 	mutex_lock(&priv->lock);
 
diff --git a/drivers/usb/serial/f81534.c b/drivers/usb/serial/f81534.c
index c0bca52ef92a..d789c1ec87b3 100644
--- a/drivers/usb/serial/f81534.c
+++ b/drivers/usb/serial/f81534.c
@@ -970,21 +970,7 @@ static void f81534_set_termios(struct tty_struct *tty,
 	if (C_CSTOPB(tty))
 		new_lcr |= UART_LCR_STOP;
 
-	switch (C_CSIZE(tty)) {
-	case CS5:
-		new_lcr |= UART_LCR_WLEN5;
-		break;
-	case CS6:
-		new_lcr |= UART_LCR_WLEN6;
-		break;
-	case CS7:
-		new_lcr |= UART_LCR_WLEN7;
-		break;
-	default:
-	case CS8:
-		new_lcr |= UART_LCR_WLEN8;
-		break;
-	}
+	new_lcr |= UART_LCR_WLEN(tty_get_char_size(tty->termios.c_cflag));
 
 	baud = tty_get_baud_rate(tty);
 	if (!baud)
diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 227f43d2bd56..1e12b5f30dcc 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -1380,30 +1380,12 @@ static void change_port_settings(struct tty_struct *tty,
 		return;
 	}
 
-	lData = UART_LCR_WLEN8;
 	lStop = 0x00;	/* 1 stop bit */
 	lParity = 0x00;	/* No parity */
 
 	cflag = tty->termios.c_cflag;
 
-	/* Change the number of bits */
-	switch (cflag & CSIZE) {
-	case CS5:
-		lData = UART_LCR_WLEN5;
-		break;
-
-	case CS6:
-		lData = UART_LCR_WLEN6;
-		break;
-
-	case CS7:
-		lData = UART_LCR_WLEN7;
-		break;
-	default:
-	case CS8:
-		lData = UART_LCR_WLEN8;
-		break;
-	}
+	lData = UART_LCR_WLEN(tty_get_char_size(cflag));
 
 	/* Change the Parity bit */
 	if (cflag & PARENB) {
diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.c
index 971907f083a3..36b1e064e51f 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -281,21 +281,7 @@ static void qt2_set_termios(struct tty_struct *tty,
 			new_lcr |= SERIAL_EVEN_PARITY;
 	}
 
-	switch (cflag & CSIZE) {
-	case CS5:
-		new_lcr |= UART_LCR_WLEN5;
-		break;
-	case CS6:
-		new_lcr |= UART_LCR_WLEN6;
-		break;
-	case CS7:
-		new_lcr |= UART_LCR_WLEN7;
-		break;
-	default:
-	case CS8:
-		new_lcr |= UART_LCR_WLEN8;
-		break;
-	}
+	new_lcr |= UART_LCR_WLEN(tty_get_char_size(cflag));
 
 	baud = tty_get_baud_rate(tty);
 	if (!baud)
diff --git a/drivers/usb/serial/ssu100.c b/drivers/usb/serial/ssu100.c
index 3baf7c0f5a98..181e302136a5 100644
--- a/drivers/usb/serial/ssu100.c
+++ b/drivers/usb/serial/ssu100.c
@@ -231,21 +231,7 @@ static void ssu100_set_termios(struct tty_struct *tty,
 			urb_value |= SERIAL_EVEN_PARITY;
 	}
 
-	switch (cflag & CSIZE) {
-	case CS5:
-		urb_value |= UART_LCR_WLEN5;
-		break;
-	case CS6:
-		urb_value |= UART_LCR_WLEN6;
-		break;
-	case CS7:
-		urb_value |= UART_LCR_WLEN7;
-		break;
-	default:
-	case CS8:
-		urb_value |= UART_LCR_WLEN8;
-		break;
-	}
+	urb_value |= UART_LCR_WLEN(tty_get_char_size(cflag));
 
 	baud = tty_get_baud_rate(tty);
 	if (!baud)
-- 
2.35.1

