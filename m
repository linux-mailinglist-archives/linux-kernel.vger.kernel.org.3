Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B69544BF5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbiFIM2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiFIM2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:28:01 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF0013F70
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:27:59 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id v22so41514909ybd.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 05:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a07Ug1Brw0ahaT/nA7crXS0MElk/cywUhm7ShD7oUjM=;
        b=YccLDNASXEYbwewBVR99kh5pf1+x7X/eNYpluDIkH5Zkjjf1fkJer+1cnzltUggsJU
         fNWPFtRGWziHE06jnd072i4qEcD3/CJpfR39Sp2zDekl8vF7MDSKtkeqBPV1Eh9ht/v9
         2w1f0J+4QEjIl/w6+0y+hvhYldw0MYV1eUkmy2Ao/K+Jz5mB7whYMpWGNoFkJDT1KqyO
         7AT8LdZybhkryMR0aRu62OmWztyaWeK8AOqaoPFi/dJ8SbtFx9Ic723wd6Edekqcrv8W
         K/B2ptEKalvT/9LAECNbSojLjd3uF0k8V59aICc4sohb4+t4g598gMyXiUS9ur5SXk2/
         zYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a07Ug1Brw0ahaT/nA7crXS0MElk/cywUhm7ShD7oUjM=;
        b=o1+YvkC0rIdO9miLVXtXitJm923IFW+YBCXaItUv4lnTnnolLOVPKj42L4KVQ3euAY
         WVrjxRxUUMsPkIStejSOclly11ZQAgYoeKBkvKAALq3Gmibwsv9ovUsrXLhpqqzUkJak
         DzQSiqKnKYWd++SFCSa4tfWy0jc4R9byDdiZM3wC8jRu0gXb8VHed0wv7fX2P/STzZzf
         ewwpLHxq+LoCr0jjNRSJuZv01nguFMG4FroEW+3bMkj30nljC2NXq/pWEPr24yafedSy
         CuD5Eef1xBpndo/pAI5ZZK6BwM0yFL3Cpk9giwktDsHwoQyvh8mzFPEYnatcwtJ1BPuV
         q0Pw==
X-Gm-Message-State: AOAM533pPR1rL2j25lIVIpSil0V20p1+zu2aUtNzMPQoCwhxD0/m1Cja
        qZgxywbigqSPHRNueDkddj24wiAq61/+65af5ag1vQ==
X-Google-Smtp-Source: ABdhPJz9iCktdQX1tAh/BGW+89D+n/GowcL403xT6Q1bcyslGiDvIW8eLZtHkf3OTS2rGp7CKDrhb6Im7uZzpFXl2wI=
X-Received: by 2002:a25:e203:0:b0:663:de4f:f233 with SMTP id
 h3-20020a25e203000000b00663de4ff233mr13625471ybe.168.1654777678188; Thu, 09
 Jun 2022 05:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220609121709.12939-1-Jason@zx2c4.com>
In-Reply-To: <20220609121709.12939-1-Jason@zx2c4.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 9 Jun 2022 14:27:21 +0200
Message-ID: <CANpmjNMKEP246YyDDqW5TPb090f4Fr-PY3Kn2X7N62wTRCEUrw@mail.gmail.com>
Subject: Re: [PATCH] mm/kfence: select random number before taking raw lock
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 at 14:17, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> The RNG uses vanilla spinlocks, not raw spinlocks, so kfence should pick
> its random numbers before taking its raw spinlocks. This also has the
> nice effect of doing less work inside the lock. It should fix a splat
> that Geert saw with CONFIG_PROVE_RAW_LOCK_NESTING:
>
>      dump_backtrace.part.0+0x98/0xc0
>      show_stack+0x14/0x28
>      dump_stack_lvl+0xac/0xec
>      dump_stack+0x14/0x2c
>      __lock_acquire+0x388/0x10a0
>      lock_acquire+0x190/0x2c0
>      _raw_spin_lock_irqsave+0x6c/0x94
>      crng_make_state+0x148/0x1e4
>      _get_random_bytes.part.0+0x4c/0xe8
>      get_random_u32+0x4c/0x140
>      __kfence_alloc+0x460/0x5c4
>      kmem_cache_alloc_trace+0x194/0x1dc
>      __kthread_create_on_node+0x5c/0x1a8
>      kthread_create_on_node+0x58/0x7c
>      printk_start_kthread.part.0+0x34/0xa8
>      printk_activate_kthreads+0x4c/0x54
>      do_one_initcall+0xec/0x278
>      kernel_init_freeable+0x11c/0x214
>      kernel_init+0x24/0x124
>      ret_from_fork+0x10/0x20
>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  mm/kfence/core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 4e7cd4c8e687..6322b7729b50 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -360,6 +360,9 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
>         unsigned long flags;
>         struct slab *slab;
>         void *addr;
> +       bool random_right_allocate = prandom_u32_max(2);
> +       bool random_fault = CONFIG_KFENCE_STRESS_TEST_FAULTS &&
> +                           !prandom_u32_max(CONFIG_KFENCE_STRESS_TEST_FAULTS);
>
>         /* Try to obtain a free object. */
>         raw_spin_lock_irqsave(&kfence_freelist_lock, flags);
> @@ -404,7 +407,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
>          * is that the out-of-bounds accesses detected are deterministic for
>          * such allocations.
>          */
> -       if (prandom_u32_max(2)) {
> +       if (random_right_allocate) {
>                 /* Allocate on the "right" side, re-calculate address. */
>                 meta->addr += PAGE_SIZE - size;
>                 meta->addr = ALIGN_DOWN(meta->addr, cache->align);
> @@ -444,7 +447,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
>         if (cache->ctor)
>                 cache->ctor(addr);
>
> -       if (CONFIG_KFENCE_STRESS_TEST_FAULTS && !prandom_u32_max(CONFIG_KFENCE_STRESS_TEST_FAULTS))
> +       if (random_fault)

The compiler should elide this branch entirely if
CONFIG_KFENCE_STRESS_TEST_FAULTS=0, but not sure it'll always do so
now. My suggestion is to make both new bools consts, to help out the
compiler a little.

Otherwise looks good, thanks for the quick fix!
