Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE225386FF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240565AbiE3SEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237939AbiE3SEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:04:00 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE6EA206A
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:03:58 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id f7so1565701ilr.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ZeR0nN/1eFyuWwXvp0L7EiUsdKyoUpqzB7kyH/D/WM=;
        b=GTWyyPNRACEttMtFjSJ8gUXIGRBmUXZBKEwGpHWqYbIHSfqlUiXqSzBt+r5ZE3DmjF
         AUV2Em9x+IZRGz4QfdnIc1mS7RwLGT8ZMTYS5JBM1oDAZx1BKBCSekGFONRhU+w/qUOo
         DWyUbkGNTcx8E/ASF0dmHm9B1CbjYIW99zv/TFXbZzv5LkCdfaaCIiTmT/Zo0fb5QDXw
         /FU7HR0av4bMFFJ5xR1yA2v91frTUAxaS2pWVoWv7SE1BKdxx5jQ32HzihvT6ZI4I1qi
         v2m0PzCHg12pUVrR5/Qh92oO7Ck/kW+eUVU0ZbgbVA0XIzsNXQzCl1Tg5SVAPuLaMG09
         nUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ZeR0nN/1eFyuWwXvp0L7EiUsdKyoUpqzB7kyH/D/WM=;
        b=pab4aliOXWFW6kWLnYLaxllXLPtiUm/nxDPyaEImrNCazJGZFwi5O7BqmXNiF2nxbL
         7jtK2XY+Prlz47vTKDroEiznlg2VmLOifDoUXO8HC//KQOqlU/lQgDv8oqcdJxUN05jg
         mFcsQWNspuFfEUduJKOqbWVbWB+KSmtwPIGBbDyZ1C0Tm70za5u3KuL7j0QDEUjcA0Wp
         QPx9+DrMBCJu6Cs1WLiQ5Bvohn95EVfpi5DyN+4tlpkR6rfG5cJPIOlb4NgTXdxg8fPu
         6ndJzp5JbKc+l9EHzSSa/tLDsRYxDUiqqdnJg0ngO2C/vX5N+Ni9hoBggLE44FS1+aVN
         6MRw==
X-Gm-Message-State: AOAM530Tdo9sM3AgxxKvn8FApoBpfHPxyn+RjiHQ4YeiBXdrQfEeljQy
        KeDrGyoWmoTXeCJWgQ2QQK09b1r3GIGeia6Fwf4=
X-Google-Smtp-Source: ABdhPJxiqxPqwJuqTiFuZDkGTIRpFwwWIWMOfo3koX/mS67/Z2NFSGsiwTDAU3oePhaHTSWXzOV+eDNnRpinoTkJYk8=
X-Received: by 2002:a92:3609:0:b0:2c6:3595:2a25 with SMTP id
 d9-20020a923609000000b002c635952a25mr29189046ila.233.1653933838071; Mon, 30
 May 2022 11:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220527185600.1236769-1-davidgow@google.com> <20220527185600.1236769-2-davidgow@google.com>
In-Reply-To: <20220527185600.1236769-2-davidgow@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 30 May 2022 20:03:47 +0200
Message-ID: <CA+fCnZe63vugPRbD3fVNGnTWbSvjd08g8coG3D71-=NtqpjOvQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] UML: add support for KASAN under x86_64
To:     David Gow <davidgow@google.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 8:56 PM David Gow <davidgow@google.com> wrote:
>
> From: Patricia Alfonso <trishalfonso@google.com>
>
> Make KASAN run on User Mode Linux on x86_64.
>
> The UML-specific KASAN initializer uses mmap to map the roughly 2.25TB
> of shadow memory to the location defined by KASAN_SHADOW_OFFSET.
> kasan_init() utilizes constructors to initialize KASAN before main().
>
> The location of the KASAN shadow memory, starting at
> KASAN_SHADOW_OFFSET, can be configured using the KASAN_SHADOW_OFFSET
> option. UML uses roughly 18TB of address space, and KASAN requires 1/8th
> of this. The default location of this offset is 0x100000000000, which
> keeps it out-of-the-way even on UML setups with more "physical" memory.
>
> For low-memory setups, 0x7fff8000 can be used instead, which fits in an
> immediate and is therefore faster, as suggested by Dmitry Vyukov. There
> is usually enough free space at this location; however, it is a config
> option so that it can be easily changed if needed.
>
> Note that, unlike KASAN on other architectures, vmalloc allocations
> still use the shadow memory allocated upfront, rather than allocating
> and free-ing it per-vmalloc allocation.
>
> Also note that, while UML supports both KASAN in inline mode
> (CONFIG_KASAN_INLINE) and static linking (CONFIG_STATIC_LINK), it does
> not support both at the same time.
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> Co-developed-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> Signed-off-by: David Gow <davidgow@google.com>

Hi David,

Thanks for working on this!

> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index a4f07de21771..c993d99116f2 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -295,9 +295,29 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
>                 return 0;
>
>         shadow_start = (unsigned long)kasan_mem_to_shadow((void *)addr);
> -       shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
>         shadow_end = (unsigned long)kasan_mem_to_shadow((void *)addr + size);
> -       shadow_end = ALIGN(shadow_end, PAGE_SIZE);
> +
> +       /*
> +        * User Mode Linux maps enough shadow memory for all of physical memory
> +        * at boot, so doesn't need to allocate more on vmalloc, just clear it.

Should this say "for all of _virtual_ memory"?

Otherwise, this is confusing. All KASAN-enabled architectures map
shadow for physical memory. And they still need map shadow for
vmalloc() separately. This is what kasan_populate_vmalloc() is for.

> +        *
> +        * If another architecture chooses to go down the same path, we should
> +        * replace this check for CONFIG_UML with something more generic, such
> +        * as:
> +        * - A CONFIG_KASAN_NO_SHADOW_ALLOC option, which architectures could set
> +        * - or, a way of having architecture-specific versions of these vmalloc
> +        *   and module shadow memory allocation options.

I think this part above and the first sentence below belong to the
commit changelog, not to a comment.

> +        *
> +        * For the time being, though, this check works. The remaining CONFIG_UML
> +        * checks in this file exist for the same reason.
> +        */
> +       if (IS_ENABLED(CONFIG_UML)) {
> +               __memset((void *)shadow_start, KASAN_VMALLOC_INVALID, shadow_end - shadow_start);
> +               return 0;
> +       }
> +
> +       shadow_start = PAGE_ALIGN_DOWN(shadow_start);
> +       shadow_end = PAGE_ALIGN(shadow_end);
>
>         ret = apply_to_page_range(&init_mm, shadow_start,
>                                   shadow_end - shadow_start,
> @@ -466,6 +486,10 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
>
>         if (shadow_end > shadow_start) {
>                 size = shadow_end - shadow_start;
> +               if (IS_ENABLED(CONFIG_UML)) {
> +                       __memset(shadow_start, KASAN_SHADOW_INIT, shadow_end - shadow_start);
> +                       return;
> +               }
>                 apply_to_existing_page_range(&init_mm,
>                                              (unsigned long)shadow_start,
>                                              size, kasan_depopulate_vmalloc_pte,
> @@ -531,6 +555,11 @@ int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
>         if (WARN_ON(!PAGE_ALIGNED(shadow_start)))
>                 return -EINVAL;
>
> +       if (IS_ENABLED(CONFIG_UML)) {
> +               __memset((void *)shadow_start, KASAN_SHADOW_INIT, shadow_size);
> +               return 0;
> +       }
> +
>         ret = __vmalloc_node_range(shadow_size, 1, shadow_start,
>                         shadow_start + shadow_size,
>                         GFP_KERNEL,
> @@ -554,6 +583,9 @@ int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
>
>  void kasan_free_module_shadow(const struct vm_struct *vm)
>  {
> +       if (IS_ENABLED(CONFIG_UML))
> +               return;
> +
>         if (vm->flags & VM_KASAN)
>                 vfree(kasan_mem_to_shadow(vm->addr));
>  }
> --
> 2.36.1.124.g0e6072fb45-goog
>

Thanks!
