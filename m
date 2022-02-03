Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9874A8077
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 09:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349497AbiBCIg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 03:36:59 -0500
Received: from mail-ej1-f43.google.com ([209.85.218.43]:43626 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbiBCIg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:36:58 -0500
Received: by mail-ej1-f43.google.com with SMTP id d10so6207784eje.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 00:36:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rST6XoS1u5VzZxuiTsE/1QU7kaonjAW+wgoRJl2TR6U=;
        b=Aow1bysBhxsa0Vu8IvCCXgsqfVt2r2PQ9j2rNct+RfCJRYSv9CkNzga7nqNI2rkpo3
         TOl5tsFPwkDFO4eIu2u8rM8LmFRkeSaO6LZdrfiLh0D5jdcAcYMCcjtXazIWZ5Uq2PD+
         HLMIiYsa3oN8MG5CuS0JdACxT4qEw8d6SQHHKEkJqq/3ABtjQUSfmd2Vww2XNJLeIGXc
         Dm52oj3f+leYOnJmwMuTcqoJe62B+midEXf6U7b8HaVtcDos21jifta/w3KSvXcAOYGC
         Z1hFnkvpfvbaeSVv74oTy9vzLZEortQKosF7SLte6Y1t2q+Y6QUt1A3exdAmVeG38jFl
         bZUQ==
X-Gm-Message-State: AOAM533TSk2symfGt+4ae4Wbc7nrXN+7OsqO0kBBT0x6AfK6E2AezyZ0
        pQnW11HKcwUCXlq23wpTQCnQKYaC4+U=
X-Google-Smtp-Source: ABdhPJw8WkVKaUmDwMBpPGJf+l+UkfYFE9ZLGalO/Mqir6cDzU/qaJZjacUk63kbsVD/jICvfkS7Sg==
X-Received: by 2002:a17:907:6d83:: with SMTP id sb3mr28985595ejc.21.1643877416997;
        Thu, 03 Feb 2022 00:36:56 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id i12sm16180535ejy.43.2022.02.03.00.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 00:36:56 -0800 (PST)
Message-ID: <37e31d03-eee6-7052-fe32-1f37f1b460e1@kernel.org>
Date:   Thu, 3 Feb 2022 09:36:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/1] tty: Drop duplicate NULL check in TTY port
 functions
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20220202165704.5680-1-andriy.shevchenko@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220202165704.5680-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 02. 22, 17:57, Andy Shevchenko wrote:
> The free_page(addr), which becomes free_pages(addr, 0) checks addr against 0.
> No need to repeat this check in the callers, i.e.  tty_port_free_xmit_buf()
> and tty_port_destructor().
> 
> Note, INIT_KFIFO() is safe without that check, because it's aware of kfifo PTR
> versus embedded kfifo.

Not sure what you mean here ^^^? But it might be one of the morning 
brain parser errors.

Acked-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/tty/tty_port.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> index 4282895ede9e..880608a65773 100644
> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -240,11 +240,9 @@ EXPORT_SYMBOL(tty_port_alloc_xmit_buf);
>   void tty_port_free_xmit_buf(struct tty_port *port)
>   {
>   	mutex_lock(&port->buf_mutex);
> -	if (port->xmit_buf != NULL) {
> -		free_page((unsigned long)port->xmit_buf);
> -		port->xmit_buf = NULL;
> -		INIT_KFIFO(port->xmit_fifo);
> -	}
> +	free_page((unsigned long)port->xmit_buf);
> +	port->xmit_buf = NULL;
> +	INIT_KFIFO(port->xmit_fifo);
>   	mutex_unlock(&port->buf_mutex);
>   }
>   EXPORT_SYMBOL(tty_port_free_xmit_buf);
> @@ -271,8 +269,7 @@ static void tty_port_destructor(struct kref *kref)
>   	/* check if last port ref was dropped before tty release */
>   	if (WARN_ON(port->itty))
>   		return;
> -	if (port->xmit_buf)
> -		free_page((unsigned long)port->xmit_buf);
> +	free_page((unsigned long)port->xmit_buf);
>   	tty_port_destroy(port);
>   	if (port->ops && port->ops->destruct)
>   		port->ops->destruct(port);


-- 
js
suse labs
