Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1AD522145
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347435AbiEJQfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347410AbiEJQfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:35:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C144D61A
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:31:44 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so1780267wmn.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mWGzBUsWBBDH/P677svrWdBEwqX8mcCwwVWbeqZWyLM=;
        b=mp+dUgzLD4/aCLY9HUnigMrWJJnPCtVY67VICGXnZi/Ibm1aI1RupWH/WFm4Lg3DJc
         RHYE3K/zWkzGzTb8icJxuI3AmVLYGdHmc2Tsz01br4rDumBHHB7NU4wwJJeuCTjpGBRn
         Nc9cKW2K1z+tZC/9zPq2EZMm1DmD0HqLGz/K4PM5Wuc0iP5RlnzGg/KtjsBo92nP3Mbk
         YTlR52T2RPBol7QG5IrBEmxdc2rk8APC9ILl8VPnqJRu+johonHlBafRa5R8NTv7bkDx
         Ev98I0OgfHTQ4J2Sl3E4B+P6BwRATwJhRcHISuWvL9xe2LloKFDByHLMbA9IloQNDRRp
         TM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mWGzBUsWBBDH/P677svrWdBEwqX8mcCwwVWbeqZWyLM=;
        b=bFxi85mQc/EAyiXtmK2viPNZ3fizma/6pfM2i/cm31rMRbdLO+eWeitKVzlUKhH0r8
         TY0YuyZqtxmQ0MPmM8pNf6cjEyMqYU2dIrzNP7zmc9lUeHHQ961LHm+3pUnP0RHCs77a
         T+gqj3HiWJPpt/elYjPOWgfeVlwl3SjZKDl65lS9/BmySSJR2Yc2ftsrvhnxVk8ghoLK
         AzVDr8tG4TfZFFSsQc5vzaUVLheuBhWVHorxlqYWvY9J5e1Cxq5gLUxWWaQgcGS61FdI
         2HV66JVPKwd7b+u4FbHTyus9GpSilm/jBxGfTna4xgvkEo2dr4/OxJfWBWH3pds3Pq83
         I/7g==
X-Gm-Message-State: AOAM530cfQg/HNN7BweFTDKFP8JOzzA35uyFMEYo1lR1TR1u0ieBDokN
        0ilL+Aiq+Fz36ZVPe/a1s2QV9YFD5GW+CFHMMuckAA==
X-Google-Smtp-Source: ABdhPJzQtKdjWFU8w2Qsa+cEZtvGNo/+m/RKVZhKkEZcyeqc6UGOm2ftqsMkQI0qDdQfORovWRe/wzgyIxFX1xZN6Kw=
X-Received: by 2002:a05:600c:1d08:b0:394:54ee:c994 with SMTP id
 l8-20020a05600c1d0800b0039454eec994mr782732wms.137.1652200302633; Tue, 10 May
 2022 09:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220510154750.212913-1-yury.norov@gmail.com> <20220510154750.212913-8-yury.norov@gmail.com>
In-Reply-To: <20220510154750.212913-8-yury.norov@gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 10 May 2022 22:01:30 +0530
Message-ID: <CAAhSdy0=g1pp+VgV2=1-3t_u32nX6xx=zmMuVQBd-zyFtQ983A@mail.gmail.com>
Subject: Re: [PATCH 07/22] risc-v: replace bitmap_weight with bitmap_empty in riscv_fill_hwcap()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@aculab.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 9:18 PM Yury Norov <yury.norov@gmail.com> wrote:
>
> bitmap_empty() is better than bitmap_weight() because it may return
> earlier, and improves on readability.
>
> CC: Albert Ou <aou@eecs.berkeley.edu>
> CC: Anup Patel <anup@brainfault.org>
> CC: Atish Patra <atishp@atishpatra.org>
> CC: Jisheng Zhang <jszhang@kernel.org>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Tsukasa OI <research_trasio@irq.a4lg.com>
> CC: linux-riscv@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kernel/cpufeature.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 1b2d42d7f589..f0298d756f66 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -206,11 +206,10 @@ void __init riscv_fill_hwcap(void)
>                 else
>                         elf_hwcap = this_hwcap;
>
> -               if (bitmap_weight(riscv_isa, RISCV_ISA_EXT_MAX))
> -                       bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
> -               else
> +               if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
>                         bitmap_copy(riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
> -
> +               else
> +                       bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
>         }
>
>         /* We don't support systems with F but without D, so mask those out
> --
> 2.32.0
>
