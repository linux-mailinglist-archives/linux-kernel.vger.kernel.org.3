Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FBB4BF23E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 07:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiBVGwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 01:52:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiBVGwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 01:52:08 -0500
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C23827B10;
        Mon, 21 Feb 2022 22:51:43 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id z22so34480327edd.1;
        Mon, 21 Feb 2022 22:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bR8Q0QY9SX7TEWCLjuX9Gl0qDTq1gqx2gu8NIUCvNZY=;
        b=oqiGuTD3Dl1pZGMyO1xCU/U2c0AfNgqoHtki+0Fz2rXhoyIQddoecfd46DyhrVmXpM
         qh7ixkWDUN5AR9JntSvDcvf8UGuHrvmuyP3KxLzJ0XEwID2FwIXYqe/glRi6i83+D5kO
         i6466vUz6vZe6JSSS3v+PfghJiRA0JuXHUqWWGiYC6HEJfVA/s5fiLLX1PE5LThlcAPO
         +DH5xnn0CGX7FrfTN/9erfg74WxmINNoeX85mqJapwfxj+VZa2xfmXvTY0Gt32qkpoXK
         G0sTahFvs+dXlF5lnEOvvIzQyRHfm+YBg9HXE/NV06B2VAw8q7x+zgvfMpvb9kizjnNm
         IQ/Q==
X-Gm-Message-State: AOAM533FDThjVnEvALDP83vr2FPhEqJ3WN31G6ngxAA5XR9GqMbxq/3T
        1UstFFa79342DwPqJPmY0+Y=
X-Google-Smtp-Source: ABdhPJybXoH/4IC5sxgRdrpiS40oI8K5YpOtI4ArFM9KXKTCbppArM6MONHlNQCHPNBdKQfXpU+8Ng==
X-Received: by 2002:a05:6402:1e8b:b0:3da:58e6:9a09 with SMTP id f11-20020a0564021e8b00b003da58e69a09mr25358130edf.155.1645512701870;
        Mon, 21 Feb 2022 22:51:41 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id x6sm9348611edv.109.2022.02.21.22.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 22:51:41 -0800 (PST)
Message-ID: <e883ccb5-68ea-f802-e4fd-864672d8ad7b@kernel.org>
Date:   Tue, 22 Feb 2022 07:51:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 1/9] serial: core: move RS485 configuration tasks from
 drivers into core
Content-Language: en-US
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        gregkh@linuxfoundation.org, u.kleine-koenig@pengutronix.de
Cc:     linux@armlinux.org.uk, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, lukas@wunner.de,
        p.rosenberger@kunbus.com
References: <20220222011433.8761-1-LinoSanfilippo@gmx.de>
 <20220222011433.8761-2-LinoSanfilippo@gmx.de>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220222011433.8761-2-LinoSanfilippo@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 02. 22, 2:14, Lino Sanfilippo wrote:
> Several drivers that support setting the RS485 configuration via userspace
> implement one or more of the following tasks:
> 
> - in case of an invalid RTS configuration (both RTS after send and RTS on
>    send set or both unset) fall back to enable RTS on send and disable RTS
>    after send
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
>   drivers/tty/serial/serial_core.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 846192a7b4bf..2b3afe038c1c 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -42,6 +42,11 @@ static struct lock_class_key port_lock_key;
>   
>   #define HIGH_BITS_OFFSET	((sizeof(long)-sizeof(int))*8)
>   
> +/*
> + * Max time with active RTS before/after data is sent.
> + */
> +#define RS485_MAX_RTS_DELAY	100 /* msecs */
> +
>   static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
>   					struct ktermios *old_termios);
>   static void uart_wait_until_sent(struct tty_struct *tty, int timeout);
> @@ -1282,8 +1287,32 @@ static int uart_set_rs485_config(struct uart_port *port,
>   	if (copy_from_user(&rs485, rs485_user, sizeof(*rs485_user)))
>   		return -EFAULT;
>   
> +	/* pick sane settings if the user hasn't */
> +	if (!(rs485.flags & SER_RS485_RTS_ON_SEND) ==
> +	    !(rs485.flags & SER_RS485_RTS_AFTER_SEND)) {
> +		pr_warn("invalid RTS setting, using RTS_ON_SEND instead\n");

Can't we have a device prefix here, so that everyone knows what device 
is affected? Without that, it's not that useful. At least port->name & 
port->line could be printed. The uart core uses dev_* prints, but prints 
also line as uport->dev can be NULL sometimes.

Hm, we could introduce uart_print family (to print something like what 
is in uart_report_port).

thanks,
-- 
js
suse labs
