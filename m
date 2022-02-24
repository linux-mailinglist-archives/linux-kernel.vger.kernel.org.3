Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9C64C289D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiBXJ4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiBXJ4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:56:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD5A285AA0;
        Thu, 24 Feb 2022 01:56:01 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D2A0421110;
        Thu, 24 Feb 2022 09:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645696559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i5lREHa3mtX8u6rlzp2pDXxb2q4QB9XYD1KbBac2Ti0=;
        b=ephuaJ95xCG8H/EC29MkfMFQkfFWhXC87InWW8jE0hQ/aBWLefi+7rgr+OKcjB2K0YMv+e
        uy+YL3JluTsKhM2Re7cdmiX3FjvJ9NfFfTxSDMWRSGDByepR0gQ7jo4gyoPbH1dobuet+W
        XLE7WK21Y9461dGJxRJVL7m2yulDkq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645696559;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i5lREHa3mtX8u6rlzp2pDXxb2q4QB9XYD1KbBac2Ti0=;
        b=5Px6ROspi4uKW0FRmcpAyOalitNMNniRCwkiY/RLJFQk2m5iJMcysk637nxPRC1q2PIYU6
        ddtw2GEy8evi44AQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 99915A3B97;
        Thu, 24 Feb 2022 09:55:59 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH 2/5] tty: serial: make use of UART_LCR_WLEN() + tty_get_char_size()
Date:   Thu, 24 Feb 2022 10:55:55 +0100
Message-Id: <20220224095558.30929-2-jslaby@suse.cz>
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
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org
---
 drivers/tty/serial/8250/8250_omap.c | 16 +---------------
 drivers/tty/serial/8250/8250_port.c | 16 +---------------
 drivers/tty/serial/jsm/jsm_cls.c    | 16 +---------------
 drivers/tty/serial/jsm/jsm_neo.c    | 16 +---------------
 drivers/tty/serial/omap-serial.c    | 16 +---------------
 drivers/tty/serial/pxa.c            | 16 +---------------
 drivers/tty/serial/serial-tegra.c   | 22 ++++------------------
 drivers/tty/serial/vr41xx_siu.c     | 15 +--------------
 8 files changed, 11 insertions(+), 122 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 73e5f1dbd075..ac8bfa042391 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -357,21 +357,7 @@ static void omap_8250_set_termios(struct uart_port *port,
 	unsigned char cval = 0;
 	unsigned int baud;
 
-	switch (termios->c_cflag & CSIZE) {
-	case CS5:
-		cval = UART_LCR_WLEN5;
-		break;
-	case CS6:
-		cval = UART_LCR_WLEN6;
-		break;
-	case CS7:
-		cval = UART_LCR_WLEN7;
-		break;
-	default:
-	case CS8:
-		cval = UART_LCR_WLEN8;
-		break;
-	}
+	cval = UART_LCR_WLEN(tty_get_char_size(termios->c_cflag));
 
 	if (termios->c_cflag & CSTOPB)
 		cval |= UART_LCR_STOP;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 863f38e036a7..8642f02e4f05 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2590,21 +2590,7 @@ static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
 {
 	unsigned char cval;
 
-	switch (c_cflag & CSIZE) {
-	case CS5:
-		cval = UART_LCR_WLEN5;
-		break;
-	case CS6:
-		cval = UART_LCR_WLEN6;
-		break;
-	case CS7:
-		cval = UART_LCR_WLEN7;
-		break;
-	default:
-	case CS8:
-		cval = UART_LCR_WLEN8;
-		break;
-	}
+	cval = UART_LCR_WLEN(tty_get_char_size(c_cflag));
 
 	if (c_cflag & CSTOPB)
 		cval |= UART_LCR_STOP;
diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
index b507a2cec926..b280da50290c 100644
--- a/drivers/tty/serial/jsm/jsm_cls.c
+++ b/drivers/tty/serial/jsm/jsm_cls.c
@@ -737,21 +737,7 @@ static void cls_param(struct jsm_channel *ch)
 	if (ch->ch_c_cflag & CSTOPB)
 		lcr |= UART_LCR_STOP;
 
-	switch (ch->ch_c_cflag & CSIZE) {
-	case CS5:
-		lcr |= UART_LCR_WLEN5;
-		break;
-	case CS6:
-		lcr |= UART_LCR_WLEN6;
-		break;
-	case CS7:
-		lcr |= UART_LCR_WLEN7;
-		break;
-	case CS8:
-	default:
-		lcr |= UART_LCR_WLEN8;
-		break;
-	}
+	lcr |= UART_LCR_WLEN(tty_get_char_size(ch->ch_c_cflag));
 
 	ier = readb(&ch->ch_cls_uart->ier);
 	uart_lcr = readb(&ch->ch_cls_uart->lcr);
diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index c6f927a76c3b..c4fd31de04b4 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -1008,21 +1008,7 @@ static void neo_param(struct jsm_channel *ch)
 	if (ch->ch_c_cflag & CSTOPB)
 		lcr |= UART_LCR_STOP;
 
-	switch (ch->ch_c_cflag & CSIZE) {
-	case CS5:
-		lcr |= UART_LCR_WLEN5;
-		break;
-	case CS6:
-		lcr |= UART_LCR_WLEN6;
-		break;
-	case CS7:
-		lcr |= UART_LCR_WLEN7;
-		break;
-	case CS8:
-	default:
-		lcr |= UART_LCR_WLEN8;
-	break;
-	}
+	lcr |= UART_LCR_WLEN(tty_get_char_size(ch->ch_c_cflag));
 
 	ier = readb(&ch->ch_neo_uart->ier);
 	uart_lcr = readb(&ch->ch_neo_uart->lcr);
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 7074670cf81d..8d5ffa196097 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -808,21 +808,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned long flags;
 	unsigned int baud, quot;
 
-	switch (termios->c_cflag & CSIZE) {
-	case CS5:
-		cval = UART_LCR_WLEN5;
-		break;
-	case CS6:
-		cval = UART_LCR_WLEN6;
-		break;
-	case CS7:
-		cval = UART_LCR_WLEN7;
-		break;
-	default:
-	case CS8:
-		cval = UART_LCR_WLEN8;
-		break;
-	}
+	cval = UART_LCR_WLEN(tty_get_char_size(termios->c_cflag));
 
 	if (termios->c_cflag & CSTOPB)
 		cval |= UART_LCR_STOP;
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 5d7b7e56661f..e80ba8e10407 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -430,21 +430,7 @@ serial_pxa_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned int baud, quot;
 	unsigned int dll;
 
-	switch (termios->c_cflag & CSIZE) {
-	case CS5:
-		cval = UART_LCR_WLEN5;
-		break;
-	case CS6:
-		cval = UART_LCR_WLEN6;
-		break;
-	case CS7:
-		cval = UART_LCR_WLEN7;
-		break;
-	default:
-	case CS8:
-		cval = UART_LCR_WLEN8;
-		break;
-	}
+	cval = UART_LCR_WLEN(tty_get_char_size(termios->c_cflag));
 
 	if (termios->c_cflag & CSTOPB)
 		cval |= UART_LCR_STOP;
diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index b6223fab0687..d942ab152f5a 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1277,6 +1277,7 @@ static void tegra_uart_set_termios(struct uart_port *u,
 	unsigned int baud;
 	unsigned long flags;
 	unsigned int lcr;
+	unsigned char char_bits;
 	int symb_bit = 1;
 	struct clk *parent_clk = clk_get_parent(tup->uart_clk);
 	unsigned long parent_clk_rate = clk_get_rate(parent_clk);
@@ -1316,25 +1317,10 @@ static void tegra_uart_set_termios(struct uart_port *u,
 		}
 	}
 
+	char_bits = tty_get_char_size(termios->c_cflag);
+	symb_bit += char_bits;
 	lcr &= ~UART_LCR_WLEN8;
-	switch (termios->c_cflag & CSIZE) {
-	case CS5:
-		lcr |= UART_LCR_WLEN5;
-		symb_bit += 5;
-		break;
-	case CS6:
-		lcr |= UART_LCR_WLEN6;
-		symb_bit += 6;
-		break;
-	case CS7:
-		lcr |= UART_LCR_WLEN7;
-		symb_bit += 7;
-		break;
-	default:
-		lcr |= UART_LCR_WLEN8;
-		symb_bit += 8;
-		break;
-	}
+	lcr |= UART_LCR_WLEN(char_bits);
 
 	/* Stop bits */
 	if (termios->c_cflag & CSTOPB) {
diff --git a/drivers/tty/serial/vr41xx_siu.c b/drivers/tty/serial/vr41xx_siu.c
index 6b303af5ee54..e0bf003ca3a1 100644
--- a/drivers/tty/serial/vr41xx_siu.c
+++ b/drivers/tty/serial/vr41xx_siu.c
@@ -504,20 +504,7 @@ static void siu_set_termios(struct uart_port *port, struct ktermios *new,
 	unsigned long flags;
 
 	c_cflag = new->c_cflag;
-	switch (c_cflag & CSIZE) {
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
-		lcr = UART_LCR_WLEN8;
-		break;
-	}
+	lcr = UART_LCR_WLEN(tty_get_char_size(c_cflag));
 
 	if (c_cflag & CSTOPB)
 		lcr |= UART_LCR_STOP;
-- 
2.35.1

