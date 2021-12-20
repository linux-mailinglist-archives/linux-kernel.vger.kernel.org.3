Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A475C47AA5D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbhLTN3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:29:41 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:41740 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhLTN3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:29:40 -0500
Received: by mail-wm1-f54.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so6673190wmb.0;
        Mon, 20 Dec 2021 05:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HG3aMXL+GZ2vKby52WWcP6IVGG9523s9GfSvNTqrIOU=;
        b=KPvRvXRWbWgz76SgL5jVIJ6C4P8Jf/yGHl33iS8dK45teAtWetKczq/xeJVkzLB+Ub
         36Ojit/hk13k1daCvvyOnbF0o1+M9yViUAuntfndumHhKC0+Cozkj5tvf+UfoJhLwjRe
         JvsovlhhWP+Seed7KANXeLv2uVCWZq5cUfS+X/n50vacThqeR8t1D1ZDdPzBnnMKu3KH
         0Lv9bost6u7rl8wXW2NmFXGPB6dNlq06FeS/ZJ0fEQN8Nykk+2SouqidJaeeZW4GRy5Q
         R4clMwRcin8DqeXsWl18LA4rvNRWD4kLwBTUEUHIm0PPc568NY9WyX6E3vs9l8lCK+si
         34Qw==
X-Gm-Message-State: AOAM533CWuaoPgp1GOpUxE+DjntNLbzPjgVsKBFC1RPV8kroIFn5JFEb
        tfikCqWDV/a7Oa7hRAIoZKc=
X-Google-Smtp-Source: ABdhPJycNSfyZo9Hx006TVwSq4DWOqD5dtWDV0AQZDnQ6DVxaaRsAYhgglVmTlrDRQWluIfYofMRCA==
X-Received: by 2002:a05:600c:19d0:: with SMTP id u16mr14095219wmq.111.1640006979519;
        Mon, 20 Dec 2021 05:29:39 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id z5sm12206891wru.87.2021.12.20.05.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 05:29:39 -0800 (PST)
Message-ID: <13b27c0f-f3a5-1176-7d80-5a6d0ce52925@kernel.org>
Date:   Mon, 20 Dec 2021 14:29:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] tty: timbuart: Check for null res pointer
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211220082127.883885-1-jiasheng@iscas.ac.cn>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20211220082127.883885-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20. 12. 21, 9:21, Jiasheng Jiang wrote:
> The return value of platform_get_resource() needs to be checked.
> To avoid use of error pointer in case that there is no suitable
> resource.
> 
> Fixes: ab4382d27412 ("tty: move drivers/serial/ to drivers/tty/serial/")

Barely.

> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   drivers/tty/serial/timbuart.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuart.c
> index 08941eabe7b1..262154d2f40f 100644
> --- a/drivers/tty/serial/timbuart.c
> +++ b/drivers/tty/serial/timbuart.c
> @@ -312,9 +312,14 @@ static const char *timbuart_type(struct uart_port *port)
>    */
>   static void timbuart_release_port(struct uart_port *port)
>   {
> +	struct resource *res;
> +	int size;
>   	struct platform_device *pdev = to_platform_device(port->dev);
> -	int size =
> -		resource_size(platform_get_resource(pdev, IORESOURCE_MEM, 0));
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		size = 0;

How can this happen and what happens when you pass zero size to 
release_mem_region?

> +	else
> +		size = resource_size(res);
>   
>   	if (port->flags & UPF_IOREMAP) {
>   		iounmap(port->membase);


-- 
js
suse labs
