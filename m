Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6234922F0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240730AbiARJj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:39:29 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:45787 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237272AbiARJj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:39:28 -0500
Received: by mail-wm1-f48.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso3185290wms.4;
        Tue, 18 Jan 2022 01:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mpMvg9Xq83m6YgFkwSrnYeaarj8V2qnTV6HoEOfUKrc=;
        b=5wqQdrQRBv+EYmA8HZx6nK9cNxbQPvliCiuNLpmpj/9Uh+5fAK/I5Ge4aeEKilHUcf
         8nlQrPDTb51FYG69j76ni8ZLw8Y9JSm7JYKCrdKTXG7FWM5Aklu/ifp5h+bQrxlHwMpk
         kVvYp7QRwwaxZmE0f/9NZXBa5wgaX6HvXGvsTqQOV+i231e1XNLNCSgycXWLVppF5u6c
         s7ZVVNWDXMJ94oSH/29QAQkLT2u9QKr7sjR227mXAGR9zBBMT3TgmBq9G/PDNF6p+E/G
         k1rXteUDNsR5xLLq6fzR6Py/0bJBBMH292USRXGRceO7frkCx2CYrcab4Q7E8azN/uO7
         64xw==
X-Gm-Message-State: AOAM5332BO3zli12+9/lURTqz4JKtgBygfEw28Z41lNXx5XAb0RQnvGV
        /Ui9YkoFgSzvWT4T/Zs7aaI=
X-Google-Smtp-Source: ABdhPJw1cCHpAySIqyCarXq5MJKNu6tszRGXIckjEH6mzi+KENvCwwLTlOyRKIEaPx5b3RDe6kUqzQ==
X-Received: by 2002:a05:600c:4153:: with SMTP id h19mr16847619wmm.50.1642498767408;
        Tue, 18 Jan 2022 01:39:27 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id s12sm89617wru.25.2022.01.18.01.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 01:39:26 -0800 (PST)
Message-ID: <7a8016ba-730b-f599-2032-31cf03990a55@kernel.org>
Date:   Tue, 18 Jan 2022 10:39:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V6 3/5] tty: serial: meson: Describes the calculation of
 the UART baud rate clock using a clock frame
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220118030911.12815-1-yu.tu@amlogic.com>
 <20220118030911.12815-4-yu.tu@amlogic.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220118030911.12815-4-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 01. 22, 4:09, Yu Tu wrote:
> Using the common Clock code to describe the UART baud rate clock
> makes it easier for the UART driver to be compatible with the
> baud rate requirements of the UART IP on different meson chips.
...
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
...
> @@ -629,57 +640,105 @@ static struct uart_driver meson_uart_driver = {
>   	.cons		= MESON_SERIAL_CONSOLE,
>   };
>   
> -static inline struct clk *meson_uart_probe_clock(struct device *dev,
> -						 const char *id)
> -{
> -	struct clk *clk = NULL;
> -	int ret;
> -
> -	clk = devm_clk_get(dev, id);
> -	if (IS_ERR(clk))
> -		return clk;
> -
> -	ret = clk_prepare_enable(clk);
> -	if (ret) {
> -		dev_err(dev, "couldn't enable clk\n");
> -		return ERR_PTR(ret);
> -	}
> -
> -	devm_add_action_or_reset(dev,
> -			(void(*)(void *))clk_disable_unprepare,
> -			clk);
> -
> -	return clk;
> -}
> +static struct clk_div_table xtal_div_table[] = {

This can be const, right?

> +	{0, 3},
> +	{1, 1},
> +	{2, 2},
> +	{3, 2},

Not sure if you didn't remove too much whitespace. I think it should be 
like: "{ 0, 3 },". But I actually don't care, it's a minor thing.

I cannot comment on the rest (clk and OF part) as my knowledge is pretty 
limited there. Leaving up to others.

thanks,
-- 
js
suse labs
