Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00CE48D29A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 08:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiAMHGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 02:06:25 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:39852 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiAMHGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 02:06:24 -0500
Received: by mail-ed1-f53.google.com with SMTP id c71so19529036edf.6;
        Wed, 12 Jan 2022 23:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Mvd9n/r2q1EVHYqTjA0mQkCbJUoPmzaEOBWZ8LJyPcI=;
        b=Ub0S/Hd3lVLY/uG61yrX+6dGmsBvsXfhp2NIvXkFWTaCAw9pvf/8neKamr1Ymr7YR7
         VmZPbKYNFRCqhL/sAfW0JaJ/bUT/LD6AHEOwVNHi8ikZQC79wgrOvZIjL6453Md52wE8
         3+hsxzyBfgxgBfiQqT1k0NsMl2iQnj2S369r+69PYJH4qSpAEt80wW/WMqcMRg/rB/8V
         8csroAqOJAUYzKyKWtDWQIPSSyltdfKiqiV7T2ka0wniPhy24vvnOUd7IHLxuU+dOWdl
         3Jl9owWHuzQvY8OSAZ734cvnOZjUmP3elQyzcXdVw6bGtbr2L+dgYyeE2Tj3diT2Fn4e
         Dh9g==
X-Gm-Message-State: AOAM5338Tkq0qd3MvBkPbolWNCn/TktcD1W2y6+gaMKAezWZc2Qn6DYQ
        gS2vGH69G06slPGTV+LG8Ro=
X-Google-Smtp-Source: ABdhPJyZQj1Tl2/g2XPWJstoDpyR1bE6HvQH348hrfsdVJhRH4iaZAYq+D5wgsaCj0K55YBJBjppNg==
X-Received: by 2002:a17:906:9a52:: with SMTP id aj18mr2378613ejc.511.1642057582744;
        Wed, 12 Jan 2022 23:06:22 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id b1sm561325ejb.51.2022.01.12.23.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 23:06:22 -0800 (PST)
Message-ID: <fcd43c65-6201-9e44-061c-f04e39cef726@kernel.org>
Date:   Thu, 13 Jan 2022 08:06:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v6 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
Content-Language: en-US
To:     Hammer Hsieh <hammerh0314@gmail.com>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com
References: <1641979444-11661-1-git-send-email-hammerh0314@gmail.com>
 <1641979444-11661-3-git-send-email-hammerh0314@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <1641979444-11661-3-git-send-email-hammerh0314@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12. 01. 22, 10:24, Hammer Hsieh wrote:
> Add Sunplus SoC UART Driver
...
> --- /dev/null
> +++ b/drivers/tty/serial/sunplus-uart.c
> @@ -0,0 +1,756 @@
...
> +/* Register offsets */
> +#define SUP_UART_DATA			0x00
> +#define SUP_UART_LSR			0x04
> +#define SUP_UART_MSR			0x08
> +#define SUP_UART_LCR			0x0C
> +#define SUP_UART_MCR			0x10
> +#define SUP_UART_DIV_L			0x14
> +#define SUP_UART_DIV_H			0x18
> +#define SUP_UART_ISC			0x1C
> +#define SUP_UART_TX_RESIDUE		0x20
> +#define SUP_UART_RX_RESIDUE		0x24
> +
> +/* Line Status Register bits */
> +#define SUP_UART_LSR_BC			BIT(5) /* break condition status */
> +#define SUP_UART_LSR_FE			BIT(4) /* frame error status */
> +#define SUP_UART_LSR_OE			BIT(3) /* overrun error status */
> +#define SUP_UART_LSR_PE			BIT(2) /* parity error status */

I just wonder why do the HW creators feel so creative to redefine the 
world...

> +static void sunplus_shutdown(struct uart_port *port)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	writel(0, port->membase + SUP_UART_ISC);
> +	spin_unlock_irqrestore(&port->lock, flags);

I asked last time:
* What bus is this -- posting?

You replied:
* Here just clear interrupt.
* Not really understand your comment?

So I am asking again:
What bus is this? Isn't a posted write a problem here? I mean, shouldn't 
you read from the register so that the write hits the device? That 
depends on the bus this sits on, so just asking.

Other than that the driver looks much better now, i.e. LGTM.

thanks,
-- 
js
suse labs
