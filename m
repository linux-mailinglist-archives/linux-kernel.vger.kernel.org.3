Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07834FBB5E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345920AbiDKLyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344103AbiDKLyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:54:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D89F3150B;
        Mon, 11 Apr 2022 04:51:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0145B812AA;
        Mon, 11 Apr 2022 11:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D95C385A4;
        Mon, 11 Apr 2022 11:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649677904;
        bh=BDikYPFUNZHxaMZPAkSUszg+oHpAijqAD/E62XoIl0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QLMZ8mTLfEd7kHxsGPdf39EJZp5qcYYJkFKuUlGV4xl52d7eqOjkIRx7Ab2OJqAGA
         73zSssV2zUvnGm8TCQMBY56zT3oShfL1hbJUNr3btLIFpNXGOItqZgc+0iKZxUd6OC
         fsvdLSUb0xSipfr4kUwJQYHBMruAIKdclt4afvr27XsJEv16BFlDYwy1rNtz3uFxmM
         4GLVd8av5v8N1RTmKzI/JNZMIwphosq4cfqeYiZgWi3Gq74AsFgoqW0WB77qrwzJDo
         N5loo63BXh4RtDs4qvhMg+lJ12JHGQSxrb9OHpTfR0WrjX/Wt9AQn0fqiW073vpbOK
         YuUBWrRmaRcKQ==
Received: by pali.im (Postfix)
        id 765DF807; Mon, 11 Apr 2022 13:51:41 +0200 (CEST)
Date:   Mon, 11 Apr 2022 13:51:41 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH 3/3] tty: serial: use uart_port_tx_limit() helper
Message-ID: <20220411115141.o2i3rlfcyzg6qlnz@pali>
References: <20220411105405.9519-1-jslaby@suse.cz>
 <20220411105405.9519-4-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220411105405.9519-4-jslaby@suse.cz>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Monday 11 April 2022 12:54:05 Jiri Slaby wrote:
> uart_port_tx_limit() is a new helper to send characters to the device.
> Use it in these drivers.
> 
> It means we have to define two new uart hooks: tx_ready() and put_char()
> to do the real job now.
> 
> And mux.c also needs to define tx_done(). But I'm not sure if the driver
> really wants to wait for all the characters to dismiss from the HW fifo
> at this code point. Hence I marked this as FIXME.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: "Pali Rohár" <pali@kernel.org>
> Cc: Kevin Cernekee <cernekee@gmail.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: linux-riscv@lists.infradead.org
> ---
>  drivers/tty/serial/21285.c           | 40 +++++++--------------
>  drivers/tty/serial/altera_jtaguart.c | 43 ++++++----------------
>  drivers/tty/serial/amba-pl010.c      | 40 ++++-----------------
>  drivers/tty/serial/apbuart.c         | 37 ++++---------------
>  drivers/tty/serial/bcm63xx_uart.c    | 48 ++++++-------------------
>  drivers/tty/serial/mux.c             | 48 ++++++++-----------------
>  drivers/tty/serial/mvebu-uart.c      | 47 +++++++-----------------
>  drivers/tty/serial/omap-serial.c     | 53 +++++++---------------------
>  drivers/tty/serial/pxa.c             | 43 +++++-----------------
>  drivers/tty/serial/rp2.c             | 36 ++++++-------------
>  drivers/tty/serial/serial_txx9.c     | 40 ++++-----------------
>  drivers/tty/serial/sifive.c          | 48 ++++---------------------
>  drivers/tty/serial/sprd_serial.c     | 41 ++++-----------------
>  drivers/tty/serial/st-asc.c          | 51 ++++----------------------
>  drivers/tty/serial/vr41xx_siu.c      | 42 ++++------------------
>  15 files changed, 143 insertions(+), 514 deletions(-)
...
> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> index 0429c2a54290..3d07ab9eb15e 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
> @@ -194,6 +194,16 @@ static unsigned int mvebu_uart_tx_empty(struct uart_port *port)
>  	return (st & STAT_TX_EMP) ? TIOCSER_TEMT : 0;
>  }
>  
> +static bool mvebu_uart_tx_ready(struct uart_port *port)
> +{
> +	return !(readl(port->membase + UART_STAT) & STAT_TX_FIFO_FUL);

mvebu-uart.c driver in its tx_ready function should probably use
STAT_TX_RDY macro (access to STAT_TX_RDY bit in register).

Documentation for UART1 (STD) about this bit says:

This bit is set when TRANS_HLD (our UART_TSH macro) is empty and ready
for the CPU to write the next character to be transmitted out. The TSR
can still shift out the previous character when this bit is set. This
bit is cleared when the CPU writes to TRANS_HLD.

For UART2 (EXT) there is just information: UART Tx Ready for 1 Byte
Write. UART2 (EXT) has also bit (bit 5) which indicates that CPU can
load 4 bytes, but seems that this is not used by mvebu-uart.c driver.

Macro STAT_TX_RDY() is polled also in wait_for_xmitr() function.

> +}
> +
> +static void mvebu_uart_put_char(struct uart_port *port, unsigned char ch)
> +{
> +	writel(ch, port->membase + UART_TSH(port));
> +}
> +
>  static unsigned int mvebu_uart_get_mctrl(struct uart_port *port)
>  {
>  	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
> @@ -324,40 +334,7 @@ static void mvebu_uart_rx_chars(struct uart_port *port, unsigned int status)
>  
>  static void mvebu_uart_tx_chars(struct uart_port *port, unsigned int status)
>  {
> -	struct circ_buf *xmit = &port->state->xmit;
> -	unsigned int count;
> -	unsigned int st;
> -
> -	if (port->x_char) {
> -		writel(port->x_char, port->membase + UART_TSH(port));
> -		port->icount.tx++;
> -		port->x_char = 0;
> -		return;
> -	}
> -
> -	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
> -		mvebu_uart_stop_tx(port);
> -		return;
> -	}
> -
> -	for (count = 0; count < port->fifosize; count++) {
> -		writel(xmit->buf[xmit->tail], port->membase + UART_TSH(port));
> -		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> -		port->icount.tx++;
> -
> -		if (uart_circ_empty(xmit))
> -			break;
> -
> -		st = readl(port->membase + UART_STAT);
> -		if (st & STAT_TX_FIFO_FUL)
> -			break;

I see that driver here currently use STAT_TX_FIFO_FUL for checking if it
can do next iteration and write next character to UART_TSH.

Documentation about this bit says that ... the FIFO is full, which is
indicated by TX_FIFO_FULL. TX_READY status is set as long as the FIFO is
not full. The Tx ready status is cleared when in THR FIFO is full.

In case driver does not use 4 byte loads for UART2, TX_READY and
!TX_FIFO_FULL are probably same...

Anyway, mvebu_uart_tx_chars() is called from the mvebu_uart_tx_isr()
interrupt handler which is registered for CTRL_RX_RDY_INT interrupt
which should signal when TX_READY is set.

> -	}
> -
> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> -		uart_write_wakeup(port);
> -
> -	if (uart_circ_empty(xmit))
> -		mvebu_uart_stop_tx(port);
> +	uart_port_tx_limit(port, port->fifosize);
>  }
>  
>  static irqreturn_t mvebu_uart_isr(int irq, void *dev_id)
> @@ -654,6 +631,8 @@ static void mvebu_uart_put_poll_char(struct uart_port *port, unsigned char c)
>  
>  static const struct uart_ops mvebu_uart_ops = {
>  	.tx_empty	= mvebu_uart_tx_empty,
> +	.tx_ready	= mvebu_uart_tx_ready,
> +	.put_char	= mvebu_uart_put_char,
>  	.set_mctrl	= mvebu_uart_set_mctrl,
>  	.get_mctrl	= mvebu_uart_get_mctrl,
>  	.stop_tx	= mvebu_uart_stop_tx,
