Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F857545B42
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 06:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242143AbiFJEot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 00:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiFJEop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 00:44:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C7222ABEE;
        Thu,  9 Jun 2022 21:44:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61C6AB830F5;
        Fri, 10 Jun 2022 04:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A7EC385A9;
        Fri, 10 Jun 2022 04:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654836279;
        bh=6g8FeECka/KS2OLX1kxuu5yztPOwSYzNR43hULG6+8Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E3wNbIM4qlOnhH5R9OAfUinrtC77k/72ABLwvZGgUA3Re9CWAXoP332lZlxjeRePm
         /ZTNnWx2KC5UGLglD+QnvPKnhUrc1lMctnmAPgPlkrNXMcy+8bplePqGlhaEeMt2Gl
         b4X1VWTEPm3/svMjAWhVp+Yzam3CFRy3riM5c5o179W/z1jGYBwLy8Bdw4rkhgHDC1
         jrZAti5votTEtRGUfHycsBpw4E3zzgecUMhGu9YPTwe6QUqKhClmPJ3cVguY8qUSG6
         ldKV73X5m/V5XGL4OPgn8eJ35MqME/ZrIKRNjB2RlFozaiGCIsCumj6J0pu8Z1sT4v
         5xE1b3Z3OaY4Q==
Received: by mail-lj1-f172.google.com with SMTP id b7so15806510ljr.6;
        Thu, 09 Jun 2022 21:44:38 -0700 (PDT)
X-Gm-Message-State: AOAM530/hIk6uyBooC8NfYJDFKAnY4SvXVMt6XMglXeiAL5lTJBBRgnL
        5iCXiTzTz39Ltkh6m6iBLRM93C07Izvpz7j+tmY=
X-Google-Smtp-Source: ABdhPJy5/YxRiE2j7JzJj5kNHWQCd1L9sjVAS061CWCsWWdXO/0bRtO7RJBYvN8z2BbzNpYDOyZk8RnoIs3UB2Vxfeg=
X-Received: by 2002:a2e:9695:0:b0:255:6eb1:469c with SMTP id
 q21-20020a2e9695000000b002556eb1469cmr24151525lji.188.1654836276984; Thu, 09
 Jun 2022 21:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220610011958.3263650-1-liyupeng@zbhlos.com>
In-Reply-To: <20220610011958.3263650-1-liyupeng@zbhlos.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 10 Jun 2022 12:44:26 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7HY=vT5Z2d2WEt75LYSxEgrf+TSKebt0hjc7qUNhKd9g@mail.gmail.com>
Message-ID: <CAAhV-H7HY=vT5Z2d2WEt75LYSxEgrf+TSKebt0hjc7qUNhKd9g@mail.gmail.com>
Subject: Re: [PATCH 1/1] irqchip/loongson-liointc: Guard uses of cpu_logical_map
To:     Yupeng Li <liyupeng@zbhlos.com>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, caizp2008@163.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yupeng,

On Fri, Jun 10, 2022 at 9:20 AM Yupeng Li <liyupeng@zbhlos.com> wrote:
>
>   cpu_logical_map is only defined for CONFIG_SMP builds, when we are in an
>   UP configuration, the boot CPU is 0. Some kernel compilation error
>   information is as follows:
>
>   CALL    scripts/atomic/check-atomics.sh
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   CC      drivers/irqchip/irq-loongson-liointc.o
> drivers/irqchip/irq-loongson-liointc.c: In function 'liointc_chained_handle_irq':
> drivers/irqchip/irq-loongson-liointc.c:60:13: error: implicit declaration of function 'cpu_logical_map' [-Werror=implicit-function-declaration]
>   int core = cpu_logical_map(smp_processor_id()) % LIOINTC_NUM_CORES;
>              ^~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> make[2]: *** [scripts/Makefile.build:249:drivers/irqchip/irq-loongson-liointc.o] error 1
> make[1]: *** [scripts/Makefile.build:466:drivers/irqchip] error 2
This has been fixed by Jiaxun:
https://lore.kernel.org/lkml/20220609175242.977-1-jiaxun.yang@flygoat.com/T/#t


Huacai

>
> Acked-by: Caicai <caizp2008@163.com>
> Signed-off-by: Yupeng Li <liyupeng@zbhlos.com>
> ---
>  drivers/irqchip/irq-loongson-liointc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
> index aed88857d90f..927e236bf18e 100644
> --- a/drivers/irqchip/irq-loongson-liointc.c
> +++ b/drivers/irqchip/irq-loongson-liointc.c
> @@ -57,7 +57,11 @@ static void liointc_chained_handle_irq(struct irq_desc *desc)
>         struct liointc_handler_data *handler = irq_desc_get_handler_data(desc);
>         struct irq_chip *chip = irq_desc_get_chip(desc);
>         struct irq_chip_generic *gc = handler->priv->gc;
> +#ifdef CONFIG_SMP
>         int core = cpu_logical_map(smp_processor_id()) % LIOINTC_NUM_CORES;
> +#else
> +       int core = 0;
> +#endif
>         u32 pending;
>
>         chained_irq_enter(chip, desc);
> --
> 2.34.1
>
