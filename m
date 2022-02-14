Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686904B4177
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 06:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240533AbiBNFlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 00:41:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238010AbiBNFlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 00:41:24 -0500
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058004EA11;
        Sun, 13 Feb 2022 21:41:17 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id s7so25345862edd.3;
        Sun, 13 Feb 2022 21:41:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UODiaWTZTO5qlU00FWM6CcCRa/ILiX84iGscvUMk8+E=;
        b=4dNGZcEdM9ivYr8sDJYwX1XGsJCj96kux7tnoy2JAjSdTvciZuzaAiLGGcnM0418RK
         0GYpc68aU7V0Dfpu5szHT6UtUXSAh04bKiPU6MOtgNiJGnRXp2tN1MHeQ5wS3L2wcQTD
         Uu4SdIwyqUrIAUjhvUSm3pOeAkQ+mbPBGp0dG/REVkW0yDm1BarKflvOvsADyhjcIJ9P
         KXCIVFHLLbo6nA/bsdzZoGWE+h0I1qZpul98w9ivDWSPKf0Z+/F+3XxgH8cEO9uG5fAS
         LnpKVOiaw1QkrqJ0s1g/WGEKqTg21ohMJ2no2G5sx5XPPpeDsgYdVd+bB+1Ol51nt5aS
         1BMA==
X-Gm-Message-State: AOAM530QqWT7EQ7FW/y7AhaMmT+nZpbuejP2cw2jPXBFYYltDKtQyBT9
        5qHqWfKqijbLJEPjSWhIrAk=
X-Google-Smtp-Source: ABdhPJyuQDIOMXfuuo91JtjsHZ+mln7dCRyvjT6jZY72fda4wnY2b4VSFc1jdoPxFKGHjsLgq4GZ0A==
X-Received: by 2002:a05:6402:190f:: with SMTP id e15mr13795490edz.195.1644817275463;
        Sun, 13 Feb 2022 21:41:15 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id jz17sm10240567ejb.195.2022.02.13.21.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Feb 2022 21:41:14 -0800 (PST)
Message-ID: <aa45fed9-7a40-7ac1-a000-18d2805d088f@kernel.org>
Date:   Mon, 14 Feb 2022 06:41:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/9] serial: core: move RS485 configuration tasks from
 drivers into core
Content-Language: en-US
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, gregkh@linuxfoundation.org
Cc:     linux@armlinux.org.uk, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, lukas@wunner.de
References: <20220213222737.15709-1-LinoSanfilippo@gmx.de>
 <20220213222737.15709-2-LinoSanfilippo@gmx.de>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220213222737.15709-2-LinoSanfilippo@gmx.de>
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

On 13. 02. 22, 23:27, Lino Sanfilippo wrote:
> Several drivers that support setting the RS485 configuration via userspace
> implement on or more of the following tasks:
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
> a consistent beheviour among all drivers.
> 
> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> ---
>   drivers/tty/serial/serial_core.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 846192a7b4bf..3fab4070359c 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1282,8 +1282,21 @@ static int uart_set_rs485_config(struct uart_port *port,
>   	if (copy_from_user(&rs485, rs485_user, sizeof(*rs485_user)))
>   		return -EFAULT;
>   
> +	/* pick sane settings if the user hasn't */
> +	if (!(rs485.flags & SER_RS485_RTS_ON_SEND) ==
> +	    !(rs485.flags & SER_RS485_RTS_AFTER_SEND)) {
> +		rs485.flags |= SER_RS485_RTS_ON_SEND;
> +		rs485.flags &= ~SER_RS485_RTS_AFTER_SEND;
> +	}
> +	/* clamp the delays to [0, 100ms] */
> +	rs485.delay_rts_before_send = min(rs485.delay_rts_before_send, 100U);
> +	rs485.delay_rts_after_send = min(rs485.delay_rts_after_send, 100U);

Why is this magic 100? Can we have that number somehow documented? You 
should define a macro for that anyway.

> +	memset(rs485.padding, 0, sizeof(rs485.padding));

What is this memset good for?

>   	spin_lock_irqsave(&port->lock, flags);
>   	ret = port->rs485_config(port, &rs485);
> +	if (!ret)
> +		port->rs485 = rs485;
>   	spin_unlock_irqrestore(&port->lock, flags);
>   	if (ret)
>   		return ret;

thanks,
-- 
js
suse labs
