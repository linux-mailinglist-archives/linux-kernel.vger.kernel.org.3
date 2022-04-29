Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB7E5155E9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiD2UoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380993AbiD2Uns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:43:48 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE11065404;
        Fri, 29 Apr 2022 13:40:26 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 1D9FD92009C; Fri, 29 Apr 2022 22:40:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 169AD92009B;
        Fri, 29 Apr 2022 21:40:26 +0100 (BST)
Date:   Fri, 29 Apr 2022 21:40:26 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] serial: sifive: Remove duplicate `clkin_rate' setting
In-Reply-To: <alpine.DEB.2.21.2204281344190.9383@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2204291656150.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2204281344190.9383@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `clkin_rate' member of `struct sifive_serial_port' now duplicates 
`uartclk' from nested `struct uart_port', so use `uartclk' throughout 
and remove `clkin_rate'.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/tty/serial/sifive.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

linux-serial-sifive-uartclk.diff
Index: linux-macro/drivers/tty/serial/sifive.c
===================================================================
--- linux-macro.orig/drivers/tty/serial/sifive.c
+++ linux-macro/drivers/tty/serial/sifive.c
@@ -148,7 +148,6 @@
  * @port: struct uart_port embedded in this struct
  * @dev: struct device *
  * @ier: shadowed copy of the interrupt enable register
- * @clkin_rate: input clock to the UART IP block.
  * @baud_rate: UART serial line rate (e.g., 115200 baud)
  * @clk: reference to this device's clock
  * @clk_notifier: clock rate change notifier for upstream clock changes
@@ -159,7 +158,6 @@ struct sifive_serial_port {
 	struct uart_port	port;
 	struct device		*dev;
 	unsigned char		ier;
-	unsigned long		clkin_rate;
 	unsigned long		baud_rate;
 	struct clk		*clk;
 	struct notifier_block	clk_notifier;
@@ -463,7 +461,7 @@ static void __ssp_update_div(struct sifi
 {
 	u16 div;
 
-	div = DIV_ROUND_UP(ssp->clkin_rate, ssp->baud_rate) - 1;
+	div = DIV_ROUND_UP(ssp->port.uartclk, ssp->baud_rate) - 1;
 
 	__ssp_writel(div, SIFIVE_SERIAL_DIV_OFFS, ssp);
 }
@@ -648,8 +646,8 @@ static int sifive_serial_clk_notifier(st
 		udelay(DIV_ROUND_UP(12 * 1000 * 1000, ssp->baud_rate));
 	}
 
-	if (event == POST_RATE_CHANGE && ssp->clkin_rate != cnd->new_rate) {
-		ssp->clkin_rate = cnd->new_rate;
+	if (event == POST_RATE_CHANGE && ssp->port.uartclk != cnd->new_rate) {
+		ssp->port.uartclk = cnd->new_rate;
 		__ssp_update_div(ssp);
 	}
 
@@ -678,7 +676,8 @@ static void sifive_serial_set_termios(st
 	__ssp_set_stop_bits(ssp, nstop);
 
 	/* Set line rate */
-	rate = uart_get_baud_rate(port, termios, old, 0, ssp->clkin_rate / 16);
+	rate = uart_get_baud_rate(port, termios, old, 0,
+				  ssp->port.uartclk / 16);
 	__ssp_update_baud_rate(ssp, rate);
 
 	spin_lock_irqsave(&ssp->port.lock, flags);
@@ -996,9 +995,8 @@ static int sifive_serial_probe(struct pl
 	}
 
 	/* Set up clock divider */
-	ssp->clkin_rate = clk_get_rate(ssp->clk);
+	ssp->port.uartclk = clk_get_rate(ssp->clk);
 	ssp->baud_rate = SIFIVE_DEFAULT_BAUD_RATE;
-	ssp->port.uartclk = ssp->clkin_rate;
 	__ssp_update_div(ssp);
 
 	platform_set_drvdata(pdev, ssp);
