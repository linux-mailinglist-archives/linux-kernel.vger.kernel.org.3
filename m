Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C258753D700
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 15:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348484AbiFDNTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 09:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiFDNTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 09:19:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D157657;
        Sat,  4 Jun 2022 06:19:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8DC360BD4;
        Sat,  4 Jun 2022 13:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3016FC34119;
        Sat,  4 Jun 2022 13:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654348749;
        bh=ci8xQi3kRBYwslseB4Rk9sRgkZ3TEX5HhAgsld+BiY4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VcZZoiM8n5M0BcfM/D9gdIsH4lUoKsyhWJg3s7igRx9e0zq8BLRDhk/Z0Dpn84XkJ
         XDJCh++GucdY9ql5jY8wnqOLAbciG19eIzTY7Dib6LUL6zu/J5jSgvxWdzsnmsSkgf
         PzBHvQ1MTBsXSsa2r+UqxR8H1kcgHow/8m6jPr0MWmZBzJu3h+SSwQmZIja/wccIws
         Z5ku/k3szwgX/cTOkqcnG13dOmOnL+DI/Ax5oCvWVST4vX04kuZBesvebZ+weQ2MOr
         02zY+amMM0Po4nWE0dX1SLx5q7OqAydPEybSH/7wwd4pwag814/3dO/JKsXJYUFx3k
         vJAEt0Lz8Zvag==
Received: by mail-io1-f44.google.com with SMTP id a10so8127712ioe.9;
        Sat, 04 Jun 2022 06:19:09 -0700 (PDT)
X-Gm-Message-State: AOAM53096JQkyzdOIl4Kz5IUpuUp+84fUETcMyYd56oumaLCKEm6UqEp
        MSOIMiTTfUIzjEKKgmqX4FlXx+O+BJIBcdqY+2U=
X-Google-Smtp-Source: ABdhPJxrDkmm3CFJKtheneWOw1Lk/af/lrPJtnKyUireiGFreCs0r1zQ/ir+DdRWYL0P+m5iAcHegGRjGm/PftugQtA=
X-Received: by 2002:a05:6638:4407:b0:331:692c:1d5f with SMTP id
 bp7-20020a056638440700b00331692c1d5fmr6598166jab.208.1654348748353; Sat, 04
 Jun 2022 06:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220604124052.1550-1-jiaxun.yang@flygoat.com>
In-Reply-To: <20220604124052.1550-1-jiaxun.yang@flygoat.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 4 Jun 2022 21:18:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6KMC7OiLO74nN05+qfcR6ZZCih12T-iBGQ4_L9RVOjoQ@mail.gmail.com>
Message-ID: <CAAhV-H6KMC7OiLO74nN05+qfcR6ZZCih12T-iBGQ4_L9RVOjoQ@mail.gmail.com>
Subject: Re: [PATCH for-5.19 1/2] irqchip/loongson-liointc: Use architecture
 register to get coreid
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, Marc Zyngier <maz@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jiaxun,

On Sat, Jun 4, 2022 at 8:41 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> fa84f89395e0 ("irqchip/loongson-liointc: Fix build error for
> LoongArch") replaced get_ebase_cpunum with physical processor
> id from SMP facilities. However that breaks MIPS non-SMP build
> and makes booting from other cores inpossible on non-SMP kernel.
>
> Thus we revert get_ebase_cpunum back and use get_csr_cpuid for
> LoongArch.
>
> Fixes: fa84f89395e0 ("irqchip/loongson-liointc: Fix build error for LoongArch")
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  drivers/irqchip/irq-loongson-liointc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
> index aed88857d90f..c11cf97bcd1a 100644
> --- a/drivers/irqchip/irq-loongson-liointc.c
> +++ b/drivers/irqchip/irq-loongson-liointc.c
> @@ -39,6 +39,14 @@
>
>  #define LIOINTC_ERRATA_IRQ     10
>
> +#if defined(CONFIG_MIPS)
> +#define liointc_core_id get_ebase_cpunum()
> +#elif defined(CONFIG_LOONGARCH)
> +#define liointc_core_id get_csr_cpuid()
> +#else
> +#define liointc_core_id 0
> +#endif
Thank you for your quick fix. But I think it is better to do like this:

#if defined(CONFIG_LOONGARCH)
#define liointc_core_id get_csr_cpuid()
#else
#define liointc_core_id get_ebase_cpunum()
#endif

Because this driver doesn't depend on COMPILE_TEST, it can only be
built under MIPS and LOONGARCH. Moreover, let the else branch be the
same as the old behavior looks more reasonable.

Huacai

> +
>  struct liointc_handler_data {
>         struct liointc_priv     *priv;
>         u32                     parent_int_map;
> @@ -57,7 +65,7 @@ static void liointc_chained_handle_irq(struct irq_desc *desc)
>         struct liointc_handler_data *handler = irq_desc_get_handler_data(desc);
>         struct irq_chip *chip = irq_desc_get_chip(desc);
>         struct irq_chip_generic *gc = handler->priv->gc;
> -       int core = cpu_logical_map(smp_processor_id()) % LIOINTC_NUM_CORES;
> +       int core = liointc_core_id % LIOINTC_NUM_CORES;
>         u32 pending;
>
>         chained_irq_enter(chip, desc);
> --
> 2.25.1
>
