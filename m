Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B574F5CE2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiDFLnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiDFLnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:43:16 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36EF563CAE;
        Wed,  6 Apr 2022 01:29:17 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id qh7so2636129ejb.11;
        Wed, 06 Apr 2022 01:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v2z8gRO/swq08y+iM83Fo/YT89U4twO1dtpzDAI+wds=;
        b=bo+Urh9v+B0kSQwYll4Qm4BeXZn8u9TOLVgE4WP+QcIfu7+eOoQQBVS8o5Esa2X/P2
         oiN0kj/Nq+JcJ5XGsKDTogBVGlX2r6I6LCO4tlULRhd5bjPiUPhyHFMn4geel5wLFuKj
         r3EHxiRaPrHH6KihVdtQs84Df/QJF2Vh+bujoh8KiVr5ajpl+wH1buXaa8LV4nQxxWGj
         iJhEVXvOuIzlyeX+PdVK5KS5GGfUq2erTBIqSCq3hsruPgDx+nNIxwpF+RSze0lgUjng
         e1enkv68bHZe2ioczifY4/x4i0IDBacJb7V8OHrsD0TjBDWCjDoRxT2C4IwM2g5SuZVD
         gQHw==
X-Gm-Message-State: AOAM533lOUVX5QTnZGdcYi2x4sbbJl/9vtqFSxKBkGkuKz0ofguiKlHw
        2fkk692ALNklzF5kl1YfxLRhe1Nawwo=
X-Google-Smtp-Source: ABdhPJzHQmSDjpC1O1mIJBNaZCFY2jUV1wWvoQC5P1RqZ8q+ceuPa2kq451RXmkcGjRd0ITGO0yuaQ==
X-Received: by 2002:a17:907:6e2a:b0:6e0:b263:37a6 with SMTP id sd42-20020a1709076e2a00b006e0b26337a6mr7259741ejc.622.1649233756378;
        Wed, 06 Apr 2022 01:29:16 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id w14-20020a170906d20e00b006cee22553f7sm6322837ejz.213.2022.04.06.01.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 01:29:15 -0700 (PDT)
Message-ID: <afeeec95-f2c3-2e58-eac6-97bf5872a042@kernel.org>
Date:   Wed, 6 Apr 2022 10:29:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] tty: serial: Prepare cleanup of powerpc's asm/prom.h
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org
References: <49fc0d4b6446da630b1e9f29c4bab38f8ed087bf.1648833419.git.christophe.leroy@csgroup.eu>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <49fc0d4b6446da630b1e9f29c4bab38f8ed087bf.1648833419.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 04. 22, 12:20, Christophe Leroy wrote:
> powerpc's asm/prom.h brings some headers that it doesn't
> need itself.
> 
> In order to clean it up, first add missing headers in
> users of asm/prom.h
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c | 1 -
>   drivers/tty/serial/mpc52xx_uart.c           | 2 ++
>   drivers/tty/serial/pmac_zilog.c             | 1 -
>   3 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
> index 6a1cd03bfe39..108af254e8f3 100644
> --- a/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
> +++ b/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
> @@ -25,7 +25,6 @@
>   #include <asm/io.h>
>   #include <asm/irq.h>
>   #include <asm/fs_pd.h>
> -#include <asm/prom.h>
>   
>   #include <linux/serial_core.h>
>   #include <linux/kernel.h>
> diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
> index 8a6958377764..4ec785e4f9b1 100644
> --- a/drivers/tty/serial/mpc52xx_uart.c
> +++ b/drivers/tty/serial/mpc52xx_uart.c
> @@ -38,6 +38,8 @@
>   #include <linux/delay.h>
>   #include <linux/io.h>
>   #include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
>   #include <linux/of_platform.h>
>   #include <linux/clk.h>
>   
> diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
> index 5d97c201ad88..c903085acb8d 100644
> --- a/drivers/tty/serial/pmac_zilog.c
> +++ b/drivers/tty/serial/pmac_zilog.c
> @@ -51,7 +51,6 @@
>   #include <asm/irq.h>
>   
>   #ifdef CONFIG_PPC_PMAC
> -#include <asm/prom.h>
>   #include <asm/machdep.h>
>   #include <asm/pmac_feature.h>
>   #include <asm/dbdma.h>


-- 
js
suse labs
