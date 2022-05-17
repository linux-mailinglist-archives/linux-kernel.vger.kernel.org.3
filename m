Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4371E529D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbiEQJMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiEQJMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:12:40 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15EF3056F;
        Tue, 17 May 2022 02:12:37 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id gh6so33520399ejb.0;
        Tue, 17 May 2022 02:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u9TgFyNaE4p2EaZjj5YgXSyanohJeg831YsqvlUy2XI=;
        b=ro9trW4/N3KuztgkC55vFwJJFFWdOo16tJViXJ1B38Ugr2Z48ws0nAE3OR21NfkB0J
         f/rrdw6amvkf59uP+52jUE92aW6e2u78JM9+DhO3BrDXf7oda45uRY3U98I7mA6WFCEY
         Nh1o17QZsy4MMtZviy5b4Vysvvu3rMON5JfiuJUu0iOm39ow8pYQumj4PCCuUIbP9SEA
         pGjuaOnpZB/dcmm3ay3hmYaSpGnLsVZj+P2N2bQzH7u+qGbuTfBbLw08pHfRmzaL5n4S
         MuPwGP1R6qoO40CJ3MXmzgiw5S9FOvKPQEC4EUvWjMDPHXz+ycNU7Q8dC2ncLWB3cvGz
         Hxvw==
X-Gm-Message-State: AOAM533FTZmNLYNXAsgQYZsMuZmxrYhuHOU7bo3spbi32iri30reO+xB
        anXiLnZ2UeH2+LMt5DXkFBY=
X-Google-Smtp-Source: ABdhPJwo3pxSdraA2uivrQySwWjWLtIN4MSsEULWrOe+I6i9F+VrLl+L5tUWZor0uNVAElfwc7I4Cw==
X-Received: by 2002:a17:906:5d05:b0:6f6:2f7c:ffb8 with SMTP id g5-20020a1709065d0500b006f62f7cffb8mr19829361ejt.649.1652778756171;
        Tue, 17 May 2022 02:12:36 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id er22-20020a170907739600b006f3ef214e29sm802668ejc.143.2022.05.17.02.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 02:12:35 -0700 (PDT)
Message-ID: <2612fae5-e972-5c82-c44e-af1fb1d839fd@kernel.org>
Date:   Tue, 17 May 2022 11:12:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH -next] serial: cpm_uart: Fix build error without
 CONFIG_SERIAL_CPM_CONSOLE
Content-Language: en-US
To:     YueHaibing <yuehaibing@huawei.com>, gregkh@linuxfoundation.org,
        geert@linux-m68k.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220517081355.35456-1-yuehaibing@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220517081355.35456-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17. 05. 22, 10:13, YueHaibing wrote:
> drivers/tty/serial/cpm_uart/cpm_uart_core.c: In function ‘cpm_uart_init_port’:
> drivers/tty/serial/cpm_uart/cpm_uart_core.c:1251:7: error: ‘udbg_port’ undeclared (first use in this function); did you mean ‘uart_port’?
>    if (!udbg_port)
>         ^~~~~~~~~
>         uart_port
> 
> commit d142585bceb3 leave this corner, wrap it with #ifdef block
> 
> Fixes: d142585bceb3 ("serial: cpm_uart: Protect udbg definitions by CONFIG_SERIAL_CPM_CONSOLE")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/tty/serial/cpm_uart/cpm_uart_core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> index d6d3db9c3b1f..ec3a8f768555 100644
> --- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> +++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
> @@ -1248,7 +1248,9 @@ static int cpm_uart_init_port(struct device_node *np,
>   
>   #ifdef CONFIG_PPC_EARLY_DEBUG_CPM
>   #ifdef CONFIG_CONSOLE_POLL
> +#ifdef CONFIG_SERIAL_CPM_CONSOLE
>   	if (!udbg_port)
> +#endif
>   #endif

That's ugly, could you merge the two to
   #if defined(ONE) && defined(TWO)
instead
?

>   		udbg_putc = NULL;
>   #endif


-- 
js
suse labs
