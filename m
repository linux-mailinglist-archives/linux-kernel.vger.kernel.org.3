Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C45450C0A6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 22:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiDVUPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 16:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiDVUPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 16:15:00 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0E615A432
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:06:13 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id a5so6860968qvx.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NDEqcBhWfl+VEeADqX1cuVP35Bwxo39I117kMXuRP20=;
        b=TLtW1qg60rSGVQeGek0tIZbyfjQkLJWNt2ngGVAqGrQrV73U7QZtPSFld4Uyi0B6RP
         J9GPkHNV3XuQhGBYiytSnqd/7l1Gv/e1iTmShfjHJd7aH2wgp+/pbA9v+dtWis78Jnpu
         shzDMOEg9NWFbY6b1iewLe00f4U+La5RPbyk6Ie0Ag7oryOkMlVRhjEkwLlPuhZUcxwB
         eg3NNw7urj70jyvLtzGbE31gCm4Plz6qEPQs58pVl4HHSt2yZDX2K7lXm3NSPByh6cky
         4Fh3WvhbaSpX6tmGDaUcBj72izF712SRHKPdmbs3TTcHsNQuJCdhoWYA9kih0BVMMGnN
         kH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDEqcBhWfl+VEeADqX1cuVP35Bwxo39I117kMXuRP20=;
        b=VhE3w6Pj4oUK9npXoUREhbc3aYWymQinQU3bCwulesoEVFbATO8fXnYSB03T/cKXqo
         Okcqc0VV2N0SsbpVLRHo8qmQ/ASfWvLmz188r0RgEpf4Hyu46gXGCmkPRfGCF4rTHcnG
         h4sEyvOpU8WRG0s3BHI8Hcv3rgqMwhQLJBeiYmWh9ldFuEmRGyDBUH74dexU2JO2Hgf2
         ctAGo/L1Yro+Fx3wWl7/QJCb0l8fMGjhj4YJC80PS8Jk/YDUy3ueER0Hd6hGWysrgKpM
         6xqG2DHVAbzNCb8NAk6UUF5xfu7/Qzab8HZ4Z4v0XbybW7EX9HAq/8Tq/66SnpB74d6n
         NhWQ==
X-Gm-Message-State: AOAM533RgL/SzKeC2/+9Q2x7B10/NFG5ThmUetEfDR2q5WswVnH9rX6L
        vvZ0JKzyuWwLtFewsKiCx6DzDLYQs20EIBTgfD5IZk+IzWoYtvMD
X-Google-Smtp-Source: ABdhPJzFRaF/faHnVzvRvbLroYvArL300ra3ebJiuClesrr1sjxw+ZwLuwVyHz2uC4w6FbE23qJp/8nA5BlJJS6geDs=
X-Received: by 2002:a1f:314b:0:b0:331:fff6:a89e with SMTP id
 x72-20020a1f314b000000b00331fff6a89emr2323548vkx.26.1650656761610; Fri, 22
 Apr 2022 12:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220421211549.3884453-1-pcc@google.com> <CA+fCnZdouu-v1MKndMbeOw96pknGN=77=8B=_K4kedRROrL9pw@mail.gmail.com>
In-Reply-To: <CA+fCnZdouu-v1MKndMbeOw96pknGN=77=8B=_K4kedRROrL9pw@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Fri, 22 Apr 2022 12:45:50 -0700
Message-ID: <CAMn1gO5GXVJ37wgpvnxymWGBhWn=HjopviPC6zd=K4cBkzuTbA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: make minimum slab alignment a runtime property
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pekka Enberg <penberg@kernel.org>, roman.gushchin@linux.dev,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 9:04 AM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Thu, Apr 21, 2022 at 11:16 PM Peter Collingbourne <pcc@google.com> wrote:
> >
> > When CONFIG_KASAN_HW_TAGS is enabled we currently increase the minimum
> > slab alignment to 16. This happens even if MTE is not supported in
> > hardware or disabled via kasan=off, which creates an unnecessary
> > memory overhead in those cases. Eliminate this overhead by making
> > the minimum slab alignment a runtime property and only aligning to
> > 16 if KASAN is enabled at runtime.
> >
> > On a DragonBoard 845c (non-MTE hardware) with a kernel built with
> > CONFIG_KASAN_HW_TAGS, waiting for quiescence after a full Android
> > boot I see the following Slab measurements in /proc/meminfo (median
> > of 3 reboots):
> >
> > Before: 169020 kB
> > After:  167304 kB
>
> Thanks for the improvement, Peter!
>
> Overall, the patch looks good to me:
>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!

> While looking at the code, I noticed a couple of issues in the already
> existing comments. Not sure if they are worth fixing, but I'll point
> them out just in case.
>
> > Link: https://linux-review.googlesource.com/id/I752e725179b43b144153f4b6f584ceb646473ead
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > ---
> > v2:
> > - use max instead of max_t in flat_stack_align()
> >
> >  arch/arc/include/asm/cache.h        |  4 ++--
> >  arch/arm/include/asm/cache.h        |  2 +-
> >  arch/arm64/include/asm/cache.h      | 19 +++++++++++++------
> >  arch/microblaze/include/asm/page.h  |  2 +-
> >  arch/riscv/include/asm/cache.h      |  2 +-
> >  arch/sparc/include/asm/cache.h      |  2 +-
> >  arch/xtensa/include/asm/processor.h |  2 +-
> >  fs/binfmt_flat.c                    |  9 ++++++---
> >  include/crypto/hash.h               |  2 +-
> >  include/linux/slab.h                | 22 +++++++++++++++++-----
> >  mm/slab.c                           |  7 +++----
> >  mm/slab_common.c                    |  3 +--
> >  mm/slob.c                           |  6 +++---
> >  13 files changed, 51 insertions(+), 31 deletions(-)
> >
> > diff --git a/arch/arc/include/asm/cache.h b/arch/arc/include/asm/cache.h
> > index f0f1fc5d62b6..b6a7763fd5d6 100644
> > --- a/arch/arc/include/asm/cache.h
> > +++ b/arch/arc/include/asm/cache.h
> > @@ -55,11 +55,11 @@
> >   * Make sure slab-allocated buffers are 64-bit aligned when atomic64_t uses
> >   * ARCv2 64-bit atomics (LLOCKD/SCONDD). This guarantess runtime 64-bit
> >   * alignment for any atomic64_t embedded in buffer.
> > - * Default ARCH_SLAB_MINALIGN is __alignof__(long long) which has a relaxed
> > + * Default ARCH_SLAB_MIN_MINALIGN is __alignof__(long long) which has a relaxed
> >   * value of 4 (and not 8) in ARC ABI.
> >   */
> >  #if defined(CONFIG_ARC_HAS_LL64) && defined(CONFIG_ARC_HAS_LLSC)
> > -#define ARCH_SLAB_MINALIGN     8
> > +#define ARCH_SLAB_MIN_MINALIGN 8
> >  #endif
> >
> >  extern int ioc_enable;
> > diff --git a/arch/arm/include/asm/cache.h b/arch/arm/include/asm/cache.h
> > index e3ea34558ada..3e1018bb9805 100644
> > --- a/arch/arm/include/asm/cache.h
> > +++ b/arch/arm/include/asm/cache.h
> > @@ -21,7 +21,7 @@
> >   * With EABI on ARMv5 and above we must have 64-bit aligned slab pointers.
> >   */
> >  #if defined(CONFIG_AEABI) && (__LINUX_ARM_ARCH__ >= 5)
> > -#define ARCH_SLAB_MINALIGN 8
> > +#define ARCH_SLAB_MIN_MINALIGN 8
> >  #endif
> >
> >  #define __read_mostly __section(".data..read_mostly")
> > diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
> > index a074459f8f2f..38f171591c3f 100644
> > --- a/arch/arm64/include/asm/cache.h
> > +++ b/arch/arm64/include/asm/cache.h
> > @@ -6,6 +6,7 @@
> >  #define __ASM_CACHE_H
> >
> >  #include <asm/cputype.h>
> > +#include <asm/mte-def.h>
> >
> >  #define CTR_L1IP_SHIFT         14
> >  #define CTR_L1IP_MASK          3
> > @@ -49,15 +50,21 @@
> >   */
> >  #define ARCH_DMA_MINALIGN      (128)
> >
> > -#ifdef CONFIG_KASAN_SW_TAGS
> > -#define ARCH_SLAB_MINALIGN     (1ULL << KASAN_SHADOW_SCALE_SHIFT)
> > -#elif defined(CONFIG_KASAN_HW_TAGS)
> > -#define ARCH_SLAB_MINALIGN     MTE_GRANULE_SIZE
> > -#endif
> > -
> >  #ifndef __ASSEMBLY__
> >
> >  #include <linux/bitops.h>
> > +#include <linux/kasan-enabled.h>
> > +
> > +#ifdef CONFIG_KASAN_SW_TAGS
> > +#define ARCH_SLAB_MIN_MINALIGN (1ULL << KASAN_SHADOW_SCALE_SHIFT)
> > +#elif defined(CONFIG_KASAN_HW_TAGS)
> > +static inline size_t arch_slab_minalign(void)
> > +{
> > +       return kasan_hw_tags_enabled() ? MTE_GRANULE_SIZE :
> > +                                        __alignof__(unsigned long long);
> > +}
> > +#define arch_slab_minalign() arch_slab_minalign()
> > +#endif
> >
> >  #define ICACHEF_ALIASING       0
> >  #define ICACHEF_VPIPT          1
> > diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
> > index 4b8b2fa78fc5..ccdbc1da3c3e 100644
> > --- a/arch/microblaze/include/asm/page.h
> > +++ b/arch/microblaze/include/asm/page.h
> > @@ -33,7 +33,7 @@
> >  /* MS be sure that SLAB allocates aligned objects */
> >  #define ARCH_DMA_MINALIGN      L1_CACHE_BYTES
> >
> > -#define ARCH_SLAB_MINALIGN     L1_CACHE_BYTES
> > +#define ARCH_SLAB_MIN_MINALIGN L1_CACHE_BYTES
> >
> >  /*
> >   * PAGE_OFFSET -- the first address of the first page of memory. With MMU
> > diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
> > index 9b58b104559e..7beb3b5d27c7 100644
> > --- a/arch/riscv/include/asm/cache.h
> > +++ b/arch/riscv/include/asm/cache.h
> > @@ -16,7 +16,7 @@
> >   * the flat loader aligns it accordingly.
> >   */
> >  #ifndef CONFIG_MMU
> > -#define ARCH_SLAB_MINALIGN     16
> > +#define ARCH_SLAB_MIN_MINALIGN 16
> >  #endif
> >
> >  #endif /* _ASM_RISCV_CACHE_H */
> > diff --git a/arch/sparc/include/asm/cache.h b/arch/sparc/include/asm/cache.h
> > index e62fd0e72606..9d8cb4687b7e 100644
> > --- a/arch/sparc/include/asm/cache.h
> > +++ b/arch/sparc/include/asm/cache.h
> > @@ -8,7 +8,7 @@
> >  #ifndef _SPARC_CACHE_H
> >  #define _SPARC_CACHE_H
> >
> > -#define ARCH_SLAB_MINALIGN     __alignof__(unsigned long long)
> > +#define ARCH_SLAB_MIN_MINALIGN __alignof__(unsigned long long)
> >
> >  #define L1_CACHE_SHIFT 5
> >  #define L1_CACHE_BYTES 32
> > diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
> > index 4489a27d527a..e3ea278e3fcf 100644
> > --- a/arch/xtensa/include/asm/processor.h
> > +++ b/arch/xtensa/include/asm/processor.h
> > @@ -18,7 +18,7 @@
> >  #include <asm/types.h>
> >  #include <asm/regs.h>
> >
> > -#define ARCH_SLAB_MINALIGN XTENSA_STACK_ALIGNMENT
> > +#define ARCH_SLAB_MIN_MINALIGN XTENSA_STACK_ALIGNMENT
> >
> >  /*
> >   * User space process size: 1 GB.
> > diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
> > index 626898150011..23ce3439eafa 100644
> > --- a/fs/binfmt_flat.c
> > +++ b/fs/binfmt_flat.c
> > @@ -64,7 +64,10 @@
> >   * Here we can be a bit looser than the data sections since this
> >   * needs to only meet arch ABI requirements.
> >   */
> > -#define FLAT_STACK_ALIGN       max_t(unsigned long, sizeof(void *), ARCH_SLAB_MINALIGN)
> > +static size_t flat_stack_align(void)
> > +{
> > +       return max(sizeof(void *), arch_slab_minalign());
> > +}
> >
> >  #define RELOC_FAILED 0xff00ff01                /* Relocation incorrect somewhere */
> >  #define UNLOADED_LIB 0x7ff000ff                /* Placeholder for unused library */
> > @@ -148,7 +151,7 @@ static int create_flat_tables(struct linux_binprm *bprm, unsigned long arg_start
> >                 sp -= 2; /* argvp + envp */
> >         sp -= 1;  /* &argc */
> >
> > -       current->mm->start_stack = (unsigned long)sp & -FLAT_STACK_ALIGN;
> > +       current->mm->start_stack = (unsigned long)sp & -flat_stack_align();
> >         sp = (unsigned long __user *)current->mm->start_stack;
> >
> >         if (put_user(bprm->argc, sp++))
> > @@ -966,7 +969,7 @@ static int load_flat_binary(struct linux_binprm *bprm)
> >  #endif
> >         stack_len += (bprm->argc + 1) * sizeof(char *);   /* the argv array */
> >         stack_len += (bprm->envc + 1) * sizeof(char *);   /* the envp array */
> > -       stack_len = ALIGN(stack_len, FLAT_STACK_ALIGN);
> > +       stack_len = ALIGN(stack_len, flat_stack_align());
> >
> >         res = load_flat_file(bprm, &libinfo, 0, &stack_len);
> >         if (res < 0)
> > diff --git a/include/crypto/hash.h b/include/crypto/hash.h
> > index f140e4643949..442c290f458c 100644
> > --- a/include/crypto/hash.h
> > +++ b/include/crypto/hash.h
> > @@ -149,7 +149,7 @@ struct ahash_alg {
> >
> >  struct shash_desc {
> >         struct crypto_shash *tfm;
> > -       void *__ctx[] __aligned(ARCH_SLAB_MINALIGN);
> > +       void *__ctx[] __aligned(ARCH_SLAB_MIN_MINALIGN);
> >  };
> >
> >  #define HASH_MAX_DIGESTSIZE     64
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 373b3ef99f4e..80e517593372 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -201,21 +201,33 @@ void kmem_dump_obj(void *object);
> >  #endif
> >
> >  /*
> > - * Setting ARCH_SLAB_MINALIGN in arch headers allows a different alignment.
> > + * Setting ARCH_SLAB_MIN_MINALIGN in arch headers allows a different alignment.
> >   * Intended for arches that get misalignment faults even for 64 bit integer
> >   * aligned buffers.
> >   */
> > -#ifndef ARCH_SLAB_MINALIGN
> > -#define ARCH_SLAB_MINALIGN __alignof__(unsigned long long)
> > +#ifndef ARCH_SLAB_MIN_MINALIGN
> > +#define ARCH_SLAB_MIN_MINALIGN __alignof__(unsigned long long)
> > +#endif
> > +
> > +/*
> > + * Arches can define this function if they want to decide the minimum slab
> > + * alignment at runtime. The value returned by the function must be
> > + * >= ARCH_SLAB_MIN_MINALIGN.
> > + */
> > +#ifndef arch_slab_minalign
> > +static inline size_t arch_slab_minalign(void)
> > +{
> > +       return ARCH_SLAB_MIN_MINALIGN;
> > +}
> >  #endif
> >
> >  /*
> >   * kmalloc and friends return ARCH_KMALLOC_MINALIGN aligned
> > - * pointers. kmem_cache_alloc and friends return ARCH_SLAB_MINALIGN
> > + * pointers. kmem_cache_alloc and friends return ARCH_SLAB_MIN_MINALIGN
> >   * aligned pointers.
>
> This comment is not precise: kmalloc relies on kmem_cache_alloc, so
> kmalloc technically returns pointers aligned to
> max(ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MIN_MINALIGN). See
> create_kmalloc_cache()->create_boot_cache()->calculate_alignment() for
> SLAB and SLUB and __do_kmalloc_node() for SLOB. This alignment is
> stronger than the one is specified for __assume_kmalloc_alignment
> below, so the code should be fine. However, the comment is confusing.
>
> Also, the comment next to the ARCH_KMALLOC_MINALIGN definition says
> "Setting ARCH_KMALLOC_MINALIGN in arch headers" while it should say
> "Setting ARCH_DMA_MINALIGN in arch headers".

Good catches. Let's fix these issues separately (especially since I
reverted the ARCH_SLAB_MIN_MINALIGN change so the patches shouldn't
conflict). Would you like to send patches? I can if not.

Peter
