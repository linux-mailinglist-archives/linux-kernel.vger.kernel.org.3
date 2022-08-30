Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951DD5A5EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiH3IyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiH3IyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:54:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF7B1A040;
        Tue, 30 Aug 2022 01:54:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCF0661587;
        Tue, 30 Aug 2022 08:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B43C433D6;
        Tue, 30 Aug 2022 08:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661849651;
        bh=hfK8VVgg9VMBUDm7mglmdkQegc1NzvnhC/rH71M5MzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eFj9Z2GJv7hwm6TnzKpZf+nu6vtqN0eKd/ZLIoU+1n9dWq8n60n+sV/lCop3c64nJ
         A57EmCLXlofRN9+kOOmWv3eWlzz1QLPOmw3Tf//iPR4bWMoXDySK27wcHfXjwhHaR4
         A7j990nEyWWvrGpu97TNK/KlxPhBboS2ZkwyK+BY=
Date:   Tue, 30 Aug 2022 10:54:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/4] serial: Rename vars in uart_get_rs485_config()
Message-ID: <Yw3QMI0m2X/8aL7z@kroah.com>
References: <20220830072956.3630-1-ilpo.jarvinen@linux.intel.com>
 <20220830072956.3630-2-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220830072956.3630-2-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 10:29:53AM +0300, Ilpo Järvinen wrote:
> Make variable names to match uart_set_rs485_config() ones:
> 	- rs485 -> rs485_user
> 	- aux -> rs485
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/serial_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 12c87cd201a7..8834414a0b2f 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1408,16 +1408,16 @@ int uart_rs485_config(struct uart_port *port)
>  EXPORT_SYMBOL_GPL(uart_rs485_config);
>  
>  static int uart_get_rs485_config(struct uart_port *port,
> -			 struct serial_rs485 __user *rs485)
> +			 struct serial_rs485 __user *rs485_user)
>  {
> +	struct serial_rs485 rs485;
>  	unsigned long flags;
> -	struct serial_rs485 aux;
>  
>  	spin_lock_irqsave(&port->lock, flags);
> -	aux = port->rs485;
> +	rs485 = port->rs485;
>  	spin_unlock_irqrestore(&port->lock, flags);

I missed this originally, but why does the lock matter here at all?  You
are just copying all data out of the structure into an on-stack one, why
the extra step at all?

As the structure can change instantly after you release the lock, I
don't see what the lock is protecting.

thanks,

greg k-h
