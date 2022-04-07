Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9444F780C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242271AbiDGHs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241974AbiDGHsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:48:51 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F903E5E20;
        Thu,  7 Apr 2022 00:46:50 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a6so9168997ejk.0;
        Thu, 07 Apr 2022 00:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n9ByRjCgN7UyNGlvzfT7jWJ7BAn1HisGnqSo99JqgB8=;
        b=XJs4dPrHM6T6XT+3sAWKgHKTdRlIHtB1qbtbBQbeCeYm2lgKMG1ROFoYXmGcw/WejB
         Ysl+qdc70+4y+QbaesP5knS1DOhJrJOlt+V6wlPCPaWZ6UruMvUZX/ybUkGu7MbAH9gO
         RUJHkCyULKRhhC02oe4s+yqFZY6OosBNEKVyNcm4q3DAxdPde5wCrPz9X6MU8LeHqMaM
         UVzLa5pFwnQEggEFLBwmWUBPDncgKGIi3hUF/o/yXc7b5ezYPBjmN379uUZYjTLwmf8i
         SBSisOQvvZYjrmu2ozpGHYwwN/8WhvvyxknnQyozQ7kNrZw97z4XPUtApT6eVofj3QMt
         eq8g==
X-Gm-Message-State: AOAM533eL05j4KpO3Fc80HI6yQjxaJv0Nl2s/iqwfRO0Kf4OWxR26Zdt
        rdiuOG7EKNSgl82UN6eUrXk=
X-Google-Smtp-Source: ABdhPJzv09r1vMw4Ze8r90GmCwPXjqCMtbVGmOmg1d166H3EkJmoklQuCS2wRak5XhZI0Cgz8VQy4g==
X-Received: by 2002:a17:906:37cd:b0:6e0:bdb6:f309 with SMTP id o13-20020a17090637cd00b006e0bdb6f309mr12180762ejc.394.1649317608706;
        Thu, 07 Apr 2022 00:46:48 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id lj20-20020a170906f9d400b006e7f1e1f4a0sm4232922ejb.60.2022.04.07.00.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 00:46:47 -0700 (PDT)
Message-ID: <b53be23f-7935-dae3-9dc8-f850493a5fa9@kernel.org>
Date:   Thu, 7 Apr 2022 09:46:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/1] tty: serial: samsung: add spin_lock for interrupt
 and console_write
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
References: <20220407071619.102249-1-jaewon02.kim@samsung.com>
 <CGME20220407071223epcas2p16bb11821a0894a3375e84d17c4ff0844@epcas2p1.samsung.com>
 <20220407071619.102249-2-jaewon02.kim@samsung.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220407071619.102249-2-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 04. 22, 9:16, Jaewon Kim wrote:
> The console_write and IRQ handler can run concurrently.
> Problems may occurs console_write is continuously executed while
> the IRQ handler is running.

 From the patch POV:

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

But given this is a v3 with no version changelog below "---", you've 
just kicked the Greg's bot to wake up :P.

> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>   drivers/tty/serial/samsung_tty.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index e1585fbae909..8af5aceb9f4e 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -2480,12 +2480,24 @@ s3c24xx_serial_console_write(struct console *co, const char *s,
>   			     unsigned int count)
>   {
>   	unsigned int ucon = rd_regl(cons_uart, S3C2410_UCON);
> +	unsigned long flags;
> +	bool locked = true;
>   
>   	/* not possible to xmit on unconfigured port */
>   	if (!s3c24xx_port_configured(ucon))
>   		return;
>   
> +	if (cons_uart->sysrq)
> +		locked = false;
> +	else if (oops_in_progress)
> +		locked = spin_trylock_irqsave(&cons_uart->lock, flags);
> +	else
> +		spin_lock_irqsave(&cons_uart->lock, flags);
> +
>   	uart_console_write(cons_uart, s, count, s3c24xx_serial_console_putchar);
> +
> +	if (locked)
> +		spin_unlock_irqrestore(&cons_uart->lock, flags);
>   }
>   
>   /* Shouldn't be __init, as it can be instantiated from other module */


-- 
js
suse labs
