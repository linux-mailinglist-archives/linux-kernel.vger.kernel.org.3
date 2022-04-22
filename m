Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFED850AF7A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 07:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444106AbiDVFVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 01:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444053AbiDVFVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:21:18 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DA64F449;
        Thu, 21 Apr 2022 22:18:25 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id g13so14159296ejb.4;
        Thu, 21 Apr 2022 22:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=23Uj3FIOOcaORV5qgjnYr5YCkK8Dhv7rmKVGy4X8LM4=;
        b=lteYT3F6tDUKra8RXqovy8gJ1AsA3azdRdENxA/xyIJiwVu/KqoD+aFiTDX7n0BWM+
         6TvcDkZpNP2hzPb9os3oNda/zde/sGJD///GPH5aDZ0pqXkKCn2YcPFypm6/70la3khs
         z+kVU7BxU22MH6XySivncKP7doB4cUWSTH64OHgBxjDSsaxgUX4AekjzB3MdjQoimmJQ
         8J8mJUTkjKwXcwCkDSslAB/oHJEvRsXzW+9JphXPfnaUwSqorDNLsP80PVjjCacKyFuU
         15I6jRMtfOnBmsd8Bgp8KWAE8mD6o3gqYR5oK1coJsD/bxGZwFlr+eGkC2VisyUWvxNJ
         9Phg==
X-Gm-Message-State: AOAM531eu4brTfTbei2jpyRFN7EOHaPeMwuwF7yOSx1hhK7abbc/CYH6
        YaTTFgisb/4nLcmKoBviuhs=
X-Google-Smtp-Source: ABdhPJwnV3iKp+jT7aWnWY4swmm1llnWhnQgch4NLbPPGrhXCOKdJCMCETCItTXWCu051Me1d95IhQ==
X-Received: by 2002:a17:906:24ce:b0:6ef:b33e:f477 with SMTP id f14-20020a17090624ce00b006efb33ef477mr2519155ejb.425.1650604704379;
        Thu, 21 Apr 2022 22:18:24 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id g11-20020a1709061e0b00b006eff90d9c18sm372987ejj.92.2022.04.21.22.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 22:18:23 -0700 (PDT)
Message-ID: <0da4659a-6efb-9734-49cb-968558033a56@kernel.org>
Date:   Fri, 22 Apr 2022 07:18:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] serial: sunplus-uart: change sunplus_console_ports from
 global to static
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, hammerh0314@gmail.com,
        gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220421152505.1531507-1-trix@redhat.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220421152505.1531507-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 04. 22, 17:25, Tom Rix wrote:
> Smatch reports this issue
> sunplus-uart.c:501:26: warning: symbol 'sunplus_console_ports' was not declared. Should it be static?
> 
> sunplus_console_ports is only used in sunplus-uart.c so change
> its storage-class specifier to static

Heh, coincidentally, I've sent the same fix yesterday too:
https://lore.kernel.org/all/20220421101708.5640-2-jslaby@suse.cz/

Greg, whichever you take:
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   drivers/tty/serial/sunplus-uart.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sunplus-uart.c b/drivers/tty/serial/sunplus-uart.c
> index 9f15922e681b..60c73662f955 100644
> --- a/drivers/tty/serial/sunplus-uart.c
> +++ b/drivers/tty/serial/sunplus-uart.c
> @@ -498,7 +498,7 @@ static const struct uart_ops sunplus_uart_ops = {
>   };
>   
>   #ifdef CONFIG_SERIAL_SUNPLUS_CONSOLE
> -struct sunplus_uart_port *sunplus_console_ports[SUP_UART_NR];
> +static struct sunplus_uart_port *sunplus_console_ports[SUP_UART_NR];
>   
>   static void sunplus_uart_console_putchar(struct uart_port *port,
>   					 unsigned char ch)


-- 
js
suse labs
