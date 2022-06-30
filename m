Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC46F561474
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbiF3IPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiF3IPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:15:15 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF124551E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:11:59 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q9so26050151wrd.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OOTtRji8xWxni9yaz7W2gJeXuoycpc5ucnabq09T1bI=;
        b=C/t7WScdZ/5eix0bLbi5ANYeY6fv//pLAEkNiNGTQlX2F/ffEsR+ecAoWsQRUZpi4j
         d4nJ9pk1zyOyBZAky3saX2ye0R26VCTrlfnfnfbBzbop0L1f8E+raQ9k09JLPunbMvS9
         4msYhRwSFUWyBiH/XpkUcLHUQvqqBJXJ5ikK1WDRBW9Yu9FD4lPoFHFF3vb8hoTkhVDB
         M8NmmKi0v16q7gb8fffcAaZg6IVIzDbKzaEdkfn9or57m3HKOw2Lk/apcF/FqH2RVfcu
         IixbL3aooVwh7ngriV8dFFzhW5+DOvydORAtoqqkQks5g3WES+aw7SBaj2YKrW8+a4wu
         7QNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OOTtRji8xWxni9yaz7W2gJeXuoycpc5ucnabq09T1bI=;
        b=oTBvW5nzn4zYqOzJFo8uR/BgjgAVbYODRB1CLlL94eDzRC7zF8Sc1+PFC0jut/RTSr
         AxCH7aW1l8/flID7BcoTdpFNxfWPiYQ9F53hKZcMwammvnrieFHzrBrH1YpD+vBeiHjc
         5QIk3fv0IcO20xCFyyrB1CDX1M8unC5yxZXj20mPBYwMrBB5ugIyjhc4GpqwMkLxowEd
         KIutklBV61I3i1+j8ouraucks2+wFou61Coz5grENRRCoDN/na7TuPN089kbAUBkM9Qb
         BB567SjxMGuNZAR/bAuVYKDu/5DJhVQD1C5CH04zIWhSwdkPxe/hvuMKYec5/hHsd4KK
         TFHQ==
X-Gm-Message-State: AJIora8KvVXflRIn2sKBqIwjMEt8tmZoRktUgUJDGyKZliLd76wyRY5U
        8LI9QsOuqRUjPzHOXpo/p0qCnBiJfM1KjuFCKY/5Bw==
X-Google-Smtp-Source: AGRyM1sRbLewf4sxnz4dB3dN5YFnj/nq45OZFcL5LF+PbryGz/OIGzLay9e+M5ljvDXSGtGyYeW84pDmWiENzpMBuFI=
X-Received: by 2002:a05:6000:1542:b0:21d:28c0:eb43 with SMTP id
 2-20020a056000154200b0021d28c0eb43mr7083362wry.622.1656576718103; Thu, 30 Jun
 2022 01:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220630074757.2739000-1-davidgow@google.com> <20220630074757.2739000-2-davidgow@google.com>
In-Reply-To: <20220630074757.2739000-2-davidgow@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 30 Jun 2022 16:11:46 +0800
Message-ID: <CABVgOS=0PmF5k8RcP2Q3JNkMXK4Pd6ZLVGgCT9Ff+t9Dt_wA=w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] UML: add support for KASAN under x86_64
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        linux-um <linux-um@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        KUnit Development <kunit-dev@googlegroups.com>
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

On Thu, Jun 30, 2022 at 3:48 PM David Gow <davidgow@google.com> wrote:
>
> From: Patricia Alfonso <trishalfonso@google.com>
>
> Make KASAN run on User Mode Linux on x86_64.
>
> The UML-specific KASAN initializer uses mmap to map the ~16TB of shadow
> memory to the location defined by KASAN_SHADOW_OFFSET.  kasan_init()
> utilizes constructors to initialize KASAN before main().
>
> The location of the KASAN shadow memory, starting at
> KASAN_SHADOW_OFFSET, can be configured using the KASAN_SHADOW_OFFSET
> option. The default location of this offset is 0x100000000000, which
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
> If another architecture chooses to go down the same path, we should
> replace the checks for CONFIG_UML with something more generic, such
> as:
> - A CONFIG_KASAN_NO_SHADOW_ALLOC option, which architectures could set
> - or, a way of having architecture-specific versions of these vmalloc
>   and module shadow memory allocation options.
>
> Also note that, while UML supports both KASAN in inline mode
> (CONFIG_KASAN_INLINE) and static linking (CONFIG_STATIC_LINK), it does
> not support both at the same time.
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> Co-developed-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
> ---
> This is v3 of the KASAN/UML port. It should be ready to go.
>
> Note that this will fail to build if UML is linked statically due to:
> https://lore.kernel.org/all/20220526185402.955870-1-davidgow@google.com/
>
>
> Changes since v2:
> https://lore.kernel.org/lkml/20220527185600.1236769-2-davidgow@google.com/
> - Don't define CONFIG_KASAN in USER_CFLAGS, given we dont' use it.
>   (Thanks Johannes)
> - Update patch descriptions and comments given we allocate shadow memory based
>   on the size of the virtual address space, not the "physical" memory
>   used by UML.
>   - This was changed between the original RFC and v1, with
>     KASAN_SHADOW_SIZE's definition being updated.
>   - References to UML using 18TB of space and the shadow memory taking
>     2.25TB were updated. (Thanks Johannes)
>   - A mention of physical memory in a comment was updated. (Thanks
>     Andrey)
> - Move some discussion of how the vmalloc() handling could be made more
>   generic from a comment to the commit description. (Thanks Andrey)
>
> Changes since RFC v3:
> https://lore.kernel.org/all/20220526010111.755166-1-davidgow@google.com/
> - No longer print "KernelAddressSanitizer initialized" (Johannes)
> - Document the reason for the CONFIG_UML checks in shadow.c (Dmitry)
> - Support static builds via kasan_arch_is_ready() (Dmitry)
> - Get rid of a redundant call to kasam_mem_to_shadow() (Dmitry)
> - Use PAGE_ALIGN and the new PAGE_ALIGN_DOWN macros (Dmitry)
> - Reinstate missing arch/um/include/asm/kasan.h file (Johannes)
>
> Changes since v1:
> https://lore.kernel.org/all/20200226004608.8128-1-trishalfonso@google.com/
> - Include several fixes from Vincent Whitchurch:
> https://lore.kernel.org/all/20220525111756.GA15955@axis.com/
> - Support for KASAN_VMALLOC, by changing the way
>   kasan_{populate,release}_vmalloc work to update existing shadow
>   memory, rather than allocating anything new.
> - A similar fix for modules' shadow memory.
> - Support for KASAN_STACK
>   - This requires the bugfix here:
> https://lore.kernel.org/lkml/20220523140403.2361040-1-vincent.whitchurch@axis.com/
>   - Plus a couple of files excluded from KASAN.
> - Revert the default shadow offset to 0x100000000000
>   - This was breaking when mem=1G for me, at least.
> - A few minor fixes to linker sections and scripts.
>   - I've added one to dyn.lds.S on top of the ones Vincent added.
>
> ---

<... snip ...>

> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index a4f07de21771..7a7fc76e99a8 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -295,9 +295,22 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
>                 return 0;
>
>         shadow_start = (unsigned long)kasan_mem_to_shadow((void *)addr);
> -       shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
>         shadow_end = (unsigned long)kasan_mem_to_shadow((void *)addr + size);
> -       shadow_end = ALIGN(shadow_end, PAGE_SIZE);
> +
> +       /*
> +        * User Mode Linux maps enough shadow memory for all of virtual memory
> +        * at boot, so doesn't need to allocate more on vmalloc, just clear it.
> +        *
> +         * The remaining CONFIG_UML checks in this file exist for the same
> +         * reason.
> +        */

Whoops: these lines had tabs converted to spaces when I reformatted
them. I've sent out v4 which actually passes checkpatch:
https://lore.kernel.org/lkml/20220630080834.2742777-2-davidgow@google.com/

Sorry for the spam!

-- David
