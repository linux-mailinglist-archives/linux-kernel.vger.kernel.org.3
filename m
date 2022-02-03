Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA6F4A8075
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 09:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347138AbiBCIfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 03:35:37 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:35371 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbiBCIfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:35:33 -0500
Received: by mail-ed1-f49.google.com with SMTP id n10so4264527edv.2;
        Thu, 03 Feb 2022 00:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UDLQXccY8khiIDOJFfBR4ygkIJ/GybqwD/KHxUpMzWo=;
        b=Ara9Awd+UewRQA/nYOjYB6/dRy40KRNY8iKhb0kItWtTI+aAcWz2OUM9GgLcWGdzkO
         3uh30rkbbs0qGex5aF1bU2msSbtWDhWRKLNJCBtNIXUUg1Ofhu2z6e9an8F8PtH5D92o
         igYwIoRag/CBqKKkOVcOULzaxkTt/iuNWeF4FO2gFix8iGPb67jbmVFU4UL38VpAl0h2
         i28TjS7OhPboNbR43b/SeFoP+WOPD+AT81YQIHtjh5T2xw2YC0wNLZwkV+w1wJq2JeKZ
         9V9RBxmAf5/KKCexRIhbWpXHMfvBAkuN9/bE3hKkEiE4zzwaI71Q6rmI+5GTzYhQDzL2
         aR5Q==
X-Gm-Message-State: AOAM530Mj2hdxF4z6EZ/NtYlSNnqcb/ZTsNKLO/m/yfZcWIWV2Tt8RI6
        bYLQc0gKZH97zBxBxubPffx2eBUJToc=
X-Google-Smtp-Source: ABdhPJwWE5+147Aqgf0yuUM7dhv3HEl5pjP4D22RG7rzjnNUzB1XZDD6uVYydxtjbSKz1gInL7U6EQ==
X-Received: by 2002:a05:6402:d0d:: with SMTP id eb13mr33641225edb.6.1643877332574;
        Thu, 03 Feb 2022 00:35:32 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id s19sm19773838edr.23.2022.02.03.00.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 00:35:31 -0800 (PST)
Message-ID: <ca20a8f0-286e-2cd2-9f8d-09677132e132@kernel.org>
Date:   Thu, 3 Feb 2022 09:35:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/1] serial: core: Drop duplicate NULL check in
 uart_*shutdown()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220202165648.5610-1-andriy.shevchenko@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220202165648.5610-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 02. 22, 17:56, Andy Shevchenko wrote:
> The free_page(addr), which becomes free_pages(addr, 0) checks addr
> against 0. No need to repeat this check in the callers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/serial/serial_core.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 57f472268b6d..59f93040d807 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -328,8 +328,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
>   	state->xmit.buf = NULL;
>   	spin_unlock_irqrestore(&uport->lock, flags);
>   
> -	if (xmit_buf)
> -		free_page((unsigned long)xmit_buf);
> +	free_page((unsigned long)xmit_buf);
>   }
>   
>   /**
> @@ -1621,8 +1620,7 @@ static void uart_tty_port_shutdown(struct tty_port *port)
>   	state->xmit.buf = NULL;
>   	spin_unlock_irq(&uport->lock);
>   
> -	if (buf)
> -		free_page((unsigned long)buf);
> +	free_page((unsigned long)buf);
>   }
>   
>   static void uart_wait_until_sent(struct tty_struct *tty, int timeout)

thanks,
-- 
js
suse labs
