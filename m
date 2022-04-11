Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C784F4FBB85
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345149AbiDKMC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345970AbiDKMCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:02:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891912E9C4;
        Mon, 11 Apr 2022 05:00:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24B6C615F8;
        Mon, 11 Apr 2022 12:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80110C385A3;
        Mon, 11 Apr 2022 12:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649678426;
        bh=XWyT2gSrb4+C9rkQbhdXvdrW3Sjl4g7Oic7Daaiyo54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fYUO9NsiBIMMUowftL7/peZDKRXHIj1vp8SNY2dRbdJ48EBt93HZlPHT7ZW+DOW9s
         0r6IfHBNWviA80fMLpryasJ9hZdUJeS4YDjQ6S5xNXSbV0uYBqDEyIMr1kIVstXBTn
         gzNDF82d089JgpcS9r+TNfgyRGDxhqmHhtSi/jT6LibGM5xbhUDjyN4ZJeKsCGpOY0
         onQutsgec2BJYQ7FHwfRans6Hxgjc5wfX6/YPZDx9VlY6TyKDnGO7nrzMGvAckO56j
         wVUb52+iZ1ANdBWXPHPhEeRp01h+e6c1oQuym+hJeyqYAHfG9KugX1lDB1iWmf8Ahn
         1nhQCPzOaDFYg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ndsiS-0004h7-66; Mon, 11 Apr 2022 14:00:20 +0200
Date:   Mon, 11 Apr 2022 14:00:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCHv2] serial: 8250: Fix runtime PM for start_tx() for empty
 buffer
Message-ID: <YlQYVDuPmXV0nvwt@hovoldconsulting.com>
References: <20220411111657.16744-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220411111657.16744-1-tony@atomide.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 02:16:57PM +0300, Tony Lindgren wrote:
> Commit 932d596378b0 ("serial: 8250: Return early in .start_tx() if there
> are no chars to send") caused a regression where the drivers implementing
> runtime PM stopped idling. This is because serial8250_rpm_put_tx() is now
> unbalanced on early return, it normally gets called at __stop_tx().
> 
> Fixes: 932d596378b0 ("serial: 8250: Return early in .start_tx() if there are no chars to send")
> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes since v1:
> 
> - Call serial8250_rpm_get_tx() only after buffer empty test as suggested
>   by Uwe and Johan
> 
> - Drop RS885 related patch for now, it needs to be investigated further
> 
> ---
>  drivers/tty/serial/8250/8250_port.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1675,11 +1675,11 @@ static void serial8250_start_tx(struct uart_port *port)
>  	struct uart_8250_port *up = up_to_u8250p(port);
>  	struct uart_8250_em485 *em485 = up->em485;
>  
> -	serial8250_rpm_get_tx(up);
> -
>  	if (!port->x_char && uart_circ_empty(&port->state->xmit))
>  		return;
>  
> +	serial8250_rpm_get_tx(up);
> +
>  	if (em485 &&
>  	    em485->active_timer == &em485->start_tx_timer)
>  		return;

Reviewed-by: Johan Hovold <johan@kernel.org>
