Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C565155F0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380977AbiD2Unw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359728AbiD2Uni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:43:38 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C0B315719;
        Fri, 29 Apr 2022 13:40:19 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id A56B192009D; Fri, 29 Apr 2022 22:40:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 9F1A892009B;
        Fri, 29 Apr 2022 21:40:18 +0100 (BST)
Date:   Fri, 29 Apr 2022 21:40:18 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] serial: sifive: Report actual baud base rather than
 fixed 115200
In-Reply-To: <alpine.DEB.2.21.2204281344190.9383@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2204291656280.9383@angie.orcam.me.uk>
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

The base baud value reported is supposed to be the highest baud rate 
that can be set for a serial port.  The SiFive FU740-C000 SOC's on-chip 
UART supports baud rates of up to 1/16 of the input clock rate, which is 
the bus clock `tlclk'[1], often at 130MHz in the case of the HiFive 
Unmatched board.

However the sifive UART driver reports a fixed value of 115200 instead:

10010000.serial: ttySIF0 at MMIO 0x10010000 (irq = 1, base_baud = 115200) is a SiFive UART v0
10011000.serial: ttySIF1 at MMIO 0x10011000 (irq = 2, base_baud = 115200) is a SiFive UART v0

even though we already support setting higher baud rates, e.g.:

$ tty
/dev/ttySIF1
$ stty speed
230400

The baud base value is computed by the serial core by dividing the UART 
clock recorded in `struct uart_port' by 16, which is also the minimum 
value of the clock divider supported, so correct the baud base value 
reported by setting the UART clock recorded to the input clock rate 
rather than 115200:

10010000.serial: ttySIF0 at MMIO 0x10010000 (irq = 1, base_baud = 8125000) is a SiFive UART v0
10011000.serial: ttySIF1 at MMIO 0x10011000 (irq = 2, base_baud = 8125000) is a SiFive UART v0

References:

[1] "SiFive FU740-C000 Manual", v1p3, SiFive, Inc., August 13, 2021, 
    Section 16.9 "Baud Rate Divisor Register (div)", pp.143-144

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: 1f1496a923b6 ("riscv: Fix sifive serial driver")
---
 drivers/tty/serial/sifive.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

linux-serial-sifive-base-baud.diff
Index: linux-macro/drivers/tty/serial/sifive.c
===================================================================
--- linux-macro.orig/drivers/tty/serial/sifive.c
+++ linux-macro/drivers/tty/serial/sifive.c
@@ -998,7 +998,7 @@ static int sifive_serial_probe(struct pl
 	/* Set up clock divider */
 	ssp->clkin_rate = clk_get_rate(ssp->clk);
 	ssp->baud_rate = SIFIVE_DEFAULT_BAUD_RATE;
-	ssp->port.uartclk = ssp->baud_rate * 16;
+	ssp->port.uartclk = ssp->clkin_rate;
 	__ssp_update_div(ssp);
 
 	platform_set_drvdata(pdev, ssp);
