Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98FC4CED41
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 19:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiCFStz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 13:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiCFStx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 13:49:53 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED71B7CD;
        Sun,  6 Mar 2022 10:49:00 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id D9283300097A8;
        Sun,  6 Mar 2022 19:48:57 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C9F4844C287; Sun,  6 Mar 2022 19:48:57 +0100 (CET)
Date:   Sun, 6 Mar 2022 19:48:57 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 1/7] serial: 8250_dwlib: RS485 HW half duplex support
Message-ID: <20220306184857.GA19394@wunner.de>
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com>
 <20220302095606.14818-2-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220302095606.14818-2-ilpo.jarvinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 11:56:00AM +0200, Ilpo Järvinen wrote:
> +static int dw8250_rs485_config(struct uart_port *p, struct serial_rs485 *rs485)
> +{
> +	u32 tcr;
> +
> +	tcr = dw8250_readl_ext(p, DW_UART_TCR);
> +	tcr &= ~DW_UART_TCR_XFER_MODE;
> +
> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		/* Clearing unsupported flags. */

Nit:  Usually we use imperative mood, i.e. "/* clear unsupported flags */".


> +		rs485->flags &= SER_RS485_ENABLED;
> +
> +		tcr |= DW_UART_TCR_RS485_EN | DW_UART_TCR_XFER_MODE_DE_OR_RE;
> +		dw8250_writel_ext(p, DW_UART_DE_EN, 1);
> +		dw8250_writel_ext(p, DW_UART_RE_EN, 1);
> +	} else {
> +		rs485->flags = 0;
> +
> +		tcr &= ~DW_UART_TCR_RS485_EN;
> +		dw8250_writel_ext(p, DW_UART_DE_EN, 0);
> +		dw8250_writel_ext(p, DW_UART_RE_EN, 0);

Do the DW_UART_DE_EN and DW_UART_RE_EN registers have any effect at all
if DW_UART_TCR_RS485_EN is disabled in the TCR register?

If they don't, there's no need to clear them here.  It would be sufficient
to set them once (e.g. on probe).


> +	/* Resetting the default DE_POL & RE_POL */
> +	tcr &= ~(DW_UART_TCR_DE_POL | DW_UART_TCR_RE_POL);

Nit:  Imperative mood, i.e. "/* reset to default polarity */"


> +	if (device_property_read_bool(p->dev, "snps,de-active-high"))
> +		tcr |= DW_UART_TCR_DE_POL;

That device property is a duplication of the existing "rs485-rts-active-low"
property.  Please use the existing one unless there are devices already
in the field which use the new property (in which case that should be
provided as justification in the commit message).

Does the DesignWare UART use dedicated DE and RE pins instead of
the RTS pin?  That would be quite unusual.


> +	if (device_property_read_bool(p->dev, "snps,re-active-high"))
> +		tcr |= DW_UART_TCR_RE_POL;

Heiko Stübner (+cc) posted patches in 2020 to support a separate RE pin
in addition to a DE pin (which is usually simply the RTS pin):

https://lore.kernel.org/linux-serial/20200517215610.2131618-4-heiko@sntech.de/

He called the devicetree property for the pin "rs485-rx-enable",
so perhaps "rs485-rx-active-low" would be a better name here.


> +	/*
> +	 * XXX: Though we could interpret the "RTS" timings as Driver Enable
> +	 * (DE) assertion/de-assertion timings, initially not supporting that.
> +	 * Ideally we should have timing values for the Driver instead of the
> +	 * RTS signal.
> +	 */
> +	rs485->delay_rts_before_send = 0;
> +	rs485->delay_rts_after_send = 0;

I don't quite understand this code comment.


>  void dw8250_setup_port(struct uart_port *p)
>  {
> +	struct dw8250_port_data *d = p->private_data;
>  	struct uart_8250_port *up = up_to_u8250p(p);
>  	u32 reg;
>  
> +	d->hw_rs485_support = device_property_read_bool(p->dev, "snps,rs485-interface-en");
> +	if (d->hw_rs485_support)
> +		p->rs485_config = dw8250_rs485_config;
> +

You wrote in the commit message that rs485 support is present from
version 4.0 onward.  Can't we just check the IP version and enable
rs485 support for >= 4.0?  That would seem more appropriate instead
of introducing yet another new property.

Note that dw8250_setup_port() already reads the version from the
DW_UART_UCV register.

Thanks,

Lukas
