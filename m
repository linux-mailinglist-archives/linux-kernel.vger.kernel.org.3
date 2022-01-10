Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6439489826
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245093AbiAJL6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:58:30 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:46844 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiAJL6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:58:22 -0500
Received: by mail-ed1-f53.google.com with SMTP id k15so52377413edk.13;
        Mon, 10 Jan 2022 03:58:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KEFVGpTwnkjkTyLurQERHyZuoZQJijyZqzd+Dp5wm7s=;
        b=DROv0xfaoVNkXh+61tV7xzT+Aogftmabs7u6cGjKxoVWdavkDL6GIWu58LozKeblGU
         kPzpZB+Lkzf31vkMFs7dnTj4TaB1fdh8F26wcTqBsaYy0heZSNt2LRi/46ksdFJ5kjU4
         g/34do66mdn6VQNWOe9YVO45UYc82cAoPPeiEqBJsJrvZzkfjaqFLNecCf3GnOqwMZs0
         NDF1XuHP/W7SMZwoL+h363z2RAX7uKXIgEA0OSmDJFEcXETs0O8E0e5k2inGHaHIDhgU
         qy6/upfwX5rxORLmsAoSA8jOUMIXLn+lHSzGUZzhZ8P9vUV33c8kx9BuDPq5stHQdOhn
         9M/A==
X-Gm-Message-State: AOAM530CqoZ7Zps7mUw1iUnzxKc672KS3RH0Wx3syhn6Zcv4DZIvGXRj
        P62fVBkpDZltjsIHo938RFI=
X-Google-Smtp-Source: ABdhPJxPQN6eEpI/Cx0t8t3HmA+D5/UumywGmwuBUCnHq3Kyy0xcAtzWOMjXt3wqLkF9xhVd+an9Xg==
X-Received: by 2002:a17:907:1b06:: with SMTP id mp6mr60694868ejc.275.1641815900997;
        Mon, 10 Jan 2022 03:58:20 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id b2sm2353271ejh.199.2022.01.10.03.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 03:58:20 -0800 (PST)
Message-ID: <01066e66-5d97-ab40-b4a6-99e962b47073@kernel.org>
Date:   Mon, 10 Jan 2022 12:58:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V5 2/5] tty: serial: meson: Move request the register
 region.
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220110104214.25321-1-yu.tu@amlogic.com>
 <20220110104214.25321-3-yu.tu@amlogic.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220110104214.25321-3-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10. 01. 22, 11:42, Yu Tu wrote:
> This simplifies resetting the UART controller during probe
> and will make it easier to integrate the common clock code
> which will require the registers at probe time as well.

And you are *also* switching devm_request_mem_region+devm_ioremap into 
devm_ioremap_resource without even noting it here. It should've been 
done in a separate patch.

And no, do not resend a new version in the next few days. Having v5 in 
20 days is a bit too much. Give maintainers and reviewers some more 
space to express themselves.
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>   drivers/tty/serial/meson_uart.c | 24 ++++++------------------
>   1 file changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 45e00d928253..7570958d010c 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -395,24 +395,11 @@ static int meson_uart_verify_port(struct uart_port *port,
>   
>   static void meson_uart_release_port(struct uart_port *port)
>   {
> -	devm_iounmap(port->dev, port->membase);
> -	port->membase = NULL;
> -	devm_release_mem_region(port->dev, port->mapbase, port->mapsize);
> +	/* nothing to do */
>   }
>   
>   static int meson_uart_request_port(struct uart_port *port)
>   {
> -	if (!devm_request_mem_region(port->dev, port->mapbase, port->mapsize,
> -				     dev_name(port->dev))) {
> -		dev_err(port->dev, "Memory region busy\n");
> -		return -EBUSY;
> -	}
> -
> -	port->membase = devm_ioremap(port->dev, port->mapbase,
> -					     port->mapsize);
> -	if (!port->membase)
> -		return -ENOMEM;
> -
>   	return 0;
>   }
>   
> @@ -733,6 +720,10 @@ static int meson_uart_probe(struct platform_device *pdev)
>   	if (!port)
>   		return -ENOMEM;
>   
> +	port->membase = devm_ioremap_resource(&pdev->dev, res_mem);
> +	if (IS_ERR(port->membase))
> +		return PTR_ERR(port->membase);
> +
>   	ret = meson_uart_probe_clocks(pdev, port);
>   	if (ret)
>   		return ret;
> @@ -754,10 +745,7 @@ static int meson_uart_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, port);
>   
>   	/* reset port before registering (and possibly registering console) */
> -	if (meson_uart_request_port(port) >= 0) {
> -		meson_uart_reset(port);
> -		meson_uart_release_port(port);
> -	}
> +	meson_uart_reset(port);
>   
>   	ret = uart_add_one_port(&meson_uart_driver, port);
>   	if (ret)

thanks,
-- 
js
suse labs
