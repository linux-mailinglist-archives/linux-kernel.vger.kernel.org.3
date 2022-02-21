Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F264BEB39
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiBUSlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:41:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiBUSk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:40:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14610195;
        Mon, 21 Feb 2022 10:40:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2AFAB811F3;
        Mon, 21 Feb 2022 18:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C894DC340E9;
        Mon, 21 Feb 2022 18:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645468799;
        bh=TIouyKTrY9MePsjLZLYLg6ZFF8gkEtGp45zObJ6uN5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pYW+0/BuOS+GOb9Lnz6lRJxJbKBzTzErbZuoZTtdX60lLN5pXWz2LyTqoNiYFJbFi
         prkXb8WGTQftUX43eBZGEvDvSXLrRWCOGZ/HWyQVhAoYAC9rM2T+D19S5UAUFeWVds
         KgVRbxksEU8RkGyNbgxBbmK1COFq6zRa+WnmaKFQ=
Date:   Mon, 21 Feb 2022 19:39:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     jirislaby@kernel.org, u.kleine-koenig@pengutronix.de,
        linux@armlinux.org.uk, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, lukas@wunner.de
Subject: Re: [PATCH 2 1/9] serial: core: move RS485 configuration tasks from
 drivers into core
Message-ID: <YhPcfMtE7xhykgcI@kroah.com>
References: <20220216001803.637-1-LinoSanfilippo@gmx.de>
 <20220216001803.637-2-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216001803.637-2-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 01:17:55AM +0100, Lino Sanfilippo wrote:
> Several drivers that support setting the RS485 configuration via userspace
> implement one or more of the following tasks:
> 
> - in case of an invalid RTS configuration (both RTS after send and RTS on
>   send set or both unset) fall back to enable RTS on send and disable RTS
>   after send
> 
> - nullify the padding field of the returned serial_rs485 struct
> 
> - copy the configuration into the uart port struct
> 
> - limit RTS delays to 100 ms
> 
> Move these tasks into the serial core to make them generic and to provide
> a consistent behaviour among all drivers.
> 
> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> ---
>  drivers/tty/serial/serial_core.c | 18 ++++++++++++++++++
>  include/uapi/linux/serial.h      |  3 +++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 846192a7b4bf..a4f7e847d414 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1282,8 +1282,26 @@ static int uart_set_rs485_config(struct uart_port *port,
>  	if (copy_from_user(&rs485, rs485_user, sizeof(*rs485_user)))
>  		return -EFAULT;
>  
> +	/* pick sane settings if the user hasn't */
> +	if (!(rs485.flags & SER_RS485_RTS_ON_SEND) ==
> +	    !(rs485.flags & SER_RS485_RTS_AFTER_SEND)) {
> +		rs485.flags |= SER_RS485_RTS_ON_SEND;
> +		rs485.flags &= ~SER_RS485_RTS_AFTER_SEND;
> +	}
> +
> +	rs485.delay_rts_before_send = min_t(unsigned int,
> +					    rs485.delay_rts_before_send,
> +					    SER_RS485_MAX_RTS_DELAY);
> +	rs485.delay_rts_after_send = min_t(unsigned int,
> +					   rs485.delay_rts_after_send,
> +					   SER_RS485_MAX_RTS_DELAY);
> +	/* Return clean padding area to userspace */
> +	memset(rs485.padding, 0, sizeof(rs485.padding));
> +
>  	spin_lock_irqsave(&port->lock, flags);
>  	ret = port->rs485_config(port, &rs485);
> +	if (!ret)
> +		port->rs485 = rs485;
>  	spin_unlock_irqrestore(&port->lock, flags);
>  	if (ret)
>  		return ret;
> diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
> index fa6b16e5fdd8..859045a53231 100644
> --- a/include/uapi/linux/serial.h
> +++ b/include/uapi/linux/serial.h
> @@ -128,6 +128,9 @@ struct serial_rs485 {
>  							   (if supported) */
>  	__u32	delay_rts_before_send;	/* Delay before send (milliseconds) */
>  	__u32	delay_rts_after_send;	/* Delay after send (milliseconds) */
> +#define SER_RS485_MAX_RTS_DELAY		100		/* Max time with active
> +							   RTS before/after
> +							   data sent (msecs) */

Why is this a userspace value now?  What can userspace do with this
number?  Once we add this, it's fixed for forever.

thanks,

greg k-h
