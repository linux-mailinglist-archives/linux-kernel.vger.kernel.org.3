Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E00949D14B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243984AbiAZR5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244063AbiAZR5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:57:17 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4572C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:57:16 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id BD0C392009C; Wed, 26 Jan 2022 18:57:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B869E92009B;
        Wed, 26 Jan 2022 17:57:13 +0000 (GMT)
Date:   Wed, 26 Jan 2022 17:57:13 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Tobias Klauser <tklauser@distanz.ch>,
        Russell King <linux@armlinux.org.uk>,
        Vineet Gupta <vgupta@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Baruch Siach <baruch@tkos.co.il>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 10/11] serial: make uart_console_write->putchar()'s
 character a char
In-Reply-To: <20220124071430.14907-11-jslaby@suse.cz>
Message-ID: <alpine.DEB.2.21.2201261700460.58572@angie.orcam.me.uk>
References: <20220124071430.14907-1-jslaby@suse.cz> <20220124071430.14907-11-jslaby@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022, Jiri Slaby wrote:

> diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
> index e9edabc5a211..3493e201d67f 100644
> --- a/drivers/tty/serial/dz.c
> +++ b/drivers/tty/serial/dz.c
> @@ -802,7 +802,7 @@ static void __init dz_init_ports(void)
>   * restored.  Welcome to the world of PDP-11!
>   * -------------------------------------------------------------------
>   */
> -static void dz_console_putchar(struct uart_port *uport, int ch)
> +static void dz_console_putchar(struct uart_port *uport, char ch)
>  {
>  	struct dz_port *dport = to_dport(uport);
>  	unsigned long flags;

 Hmm, this is unsafe, because on the MIPS target the lone `char' type is 
signed and therefore a call to `->putchar' will see `ch' sign-extended 
from bit #7 to the width of the argument register used.  Which means that 
if a character is sent to the console that has its bit #7 set, then the 
call to:

		dz_out(dport, DZ_TDR, ch);

i.e.:

static void dz_out(struct dz_port *dport, unsigned offset, u16 value)

will send a value to DZ_TDR with bits #15:8 set to all-ones.  And bits 
#11:8 there are the BREAK control bits, active high, for serial lines #3:0 
respectively.

 We could handle this with a preparatory change by calling:

		dz_out(dport, DZ_TDR, ch & 0xffu);

instead, but perhaps `->putchar' should simply take `unsigned char' or 
maybe even `u8' as its third argument?

> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index c58cc142d23f..68e62703eaa6 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -399,7 +399,7 @@ int uart_set_options(struct uart_port *port, struct console
> *co, int baud,
>  struct tty_driver *uart_console_device(struct console *co, int *index);
>  void uart_console_write(struct uart_port *port, const char *s,
>  			unsigned int count,
> -			void (*putchar)(struct uart_port *, int));
> +			void (*putchar)(struct uart_port *, char));
>  
>  /*
>   * Port/driver registration/removal

 I.e.:

			void (*putchar)(struct uart_port *, unsigned char));

I can see we get it right already with:

	unsigned char		x_char;			/* xon/xoff char */

and for `dz_transmit_chars' we have:

	unsigned char tmp;
[...]
	tmp = xmit->buf[xmit->tail];
	xmit->tail = (xmit->tail + 1) & (DZ_XMIT_SIZE - 1);
	dz_out(dport, DZ_TDR, tmp);

(because `struct circ_buf' is generic and not limited to unsigned buffer 
contents interpretation; it's not clear to me if that has been intended 
though).

  Maciej
