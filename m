Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FEF4FB8C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbiDKJ7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344940AbiDKJ7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:59:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB88419AC;
        Mon, 11 Apr 2022 02:57:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56FDDB811A6;
        Mon, 11 Apr 2022 09:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA839C385A4;
        Mon, 11 Apr 2022 09:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649671039;
        bh=XzgoCOpDFPeXrNAPZ9n2pn/IKCFb6l3nipun5dFyDyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qehk1AnZjxsI1bTVdtNm6FoAFTYc9s6SC81gzZzZ9XQpHKl3pdty27Pou50Gy47Hd
         Ib/+Ci9lmxlDlxIXQWBdNPsRjz9seUH+heHR/qvgWTxbt0fYLbp6O5pzXShWQ2AVSx
         kfdCgC3VqJ5wSeb7GOrfA8qBckqIIPunxrKlj+C1dezGCv/o2OKaZ21C78lDq31L2O
         ou4ucjIKEjrjn8Te/midQyF4KMj9XItdnSiFOOiiaWdQLxbBJoUYkaEqzI/q1NjX8y
         k08yzPZ0q0NxH0xn4lZHhWyP5dyKkztA8meuUZVXLAJ6uKGTC40eaKHs/6IBqA4+yh
         YWp+p8RIp9Q0g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ndqnI-0003if-V8; Mon, 11 Apr 2022 11:57:13 +0200
Date:   Mon, 11 Apr 2022 11:57:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Matwey V . Kornilov" <matwey@sai.msu.ru>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] serial: 8250: Fix runtime PM for start_tx() for RS485
Message-ID: <YlP7eArvvNWnbMF2@hovoldconsulting.com>
References: <20220411094805.45696-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220411094805.45696-1-tony@atomide.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 12:48:04PM +0300, Tony Lindgren wrote:
> The early return from serial8250_start_tx() added by commit e490c9144cfa
> ("tty: Add software emulated RS485 support for 8250") failed to call
> serial8250_rpm_put_tx() that normally gets called on __stop_tx().
> 
> Likely this is a harmless issue as the RS485 using folks probably are not
> using runtime PM for the serial ports.
> 
> Fixes: e490c9144cfa ("tty: Add software emulated RS485 support for 8250")
> Cc: Matwey V. Kornilov <matwey@sai.msu.ru>
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
> @@ -1681,8 +1681,10 @@ static void serial8250_start_tx(struct uart_port *port)
>  		return;
>  
>  	if (em485 &&
> -	    em485->active_timer == &em485->start_tx_timer)
> +	    em485->active_timer == &em485->start_tx_timer) {
> +		serial8250_rpm_put_tx(up);
>  		return;
> +	}

I was just taking a quick look at your report about this and also
noticed this return statement.

The runtime PM implementation is a bit of mess as we've discussed
elsewhere, but the change you propose here doesn't look right.

start_tx() can be deferred in the rs485 case, but that doesn't mean you
should suspend the device here. In fact, that look like it would just
break runtime PM (the parts that may work to some extent).

>  
>  	if (em485)
>  		start_tx_rs485(port);

Johan
