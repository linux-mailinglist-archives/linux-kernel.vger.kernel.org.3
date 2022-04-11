Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1498E4FB929
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345178AbiDKKPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345176AbiDKKPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:15:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC0842A2C;
        Mon, 11 Apr 2022 03:13:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11684613CA;
        Mon, 11 Apr 2022 10:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707D8C385A4;
        Mon, 11 Apr 2022 10:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649672006;
        bh=eAjd+uz3pByz1YM7mKrWkVh1deu4XVVZWAkzHDsqQKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6Cj+OI7Vd0uF21CT48MBCPVm5TgxYwOZq0gP8hYfJaBAX7Nl2L1VjMj4Ihk8aUVJ
         HoygkBgR8EU61VIGQcpmuD8bTaEmIloZqDp4JeKzgiLV8b/zDLTszRaZt2p54G5N39
         eDmQXlWroVS1s1YwtkPfskgAheTHWOqrzEvXfAXnyJdEbvAtxTQKOVlfjzPwXZ44Qi
         3+NpdP4j19yBhOuIliCA4mvV9Tsd7MK4jY6K1/n2MuqpkU3dvSDmrvPrLF076DBDMe
         8GBbcvKxZwr//MdDsiK6eGEVWmb7sx6ApsKmmERg5tWrDQuSNBg1VdYnS6F7IBureO
         3TWvxiL5LewOQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ndr2t-0003tc-Pk; Mon, 11 Apr 2022 12:13:19 +0200
Date:   Mon, 11 Apr 2022 12:13:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: Re: [PATCH 2/2] serial: 8250: Fix runtime PM for start_tx() for
 empty buffer
Message-ID: <YlP/P/JeZ/fS1zAK@hovoldconsulting.com>
References: <20220411094805.45696-1-tony@atomide.com>
 <20220411094805.45696-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220411094805.45696-2-tony@atomide.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 12:48:05PM +0300, Tony Lindgren wrote:
> Commit 932d596378b0 ("serial: 8250: Return early in .start_tx() if there
> are no chars to send") caused a regression where the drivers implementing
> runtime PM stopped idling.
> 
> We need to call serial8250_rpm_put_tx() on early exit, it normally gets
> called later on at __stop_tx().
> 
> Fixes: 932d596378b0 ("serial: 8250: Return early in .start_tx() if there are no chars to send")
> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1677,8 +1677,10 @@ static void serial8250_start_tx(struct uart_port *port)
>  
>  	serial8250_rpm_get_tx(up);
>  
> -	if (!port->x_char && uart_circ_empty(&port->state->xmit))
> +	if (!port->x_char && uart_circ_empty(&port->state->xmit)) {
> +		serial8250_rpm_put_tx(up);
>  		return;
> +	}

Move this before the runtime pm get instead?

>  
>  	if (em485 &&
>  	    em485->active_timer == &em485->start_tx_timer) {

Johan
