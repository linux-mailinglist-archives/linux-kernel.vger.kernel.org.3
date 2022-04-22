Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7368D50BF70
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbiDVSIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbiDVSGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 14:06:18 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C72ECC50A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:03:20 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id v133so8145724vsv.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZVGIj4tUMtOzUQeEJsn9To8y+Iu7srnhe9+RZIuWOI=;
        b=pkOd/P6aQrs9xk9SK5o3HiZlz8oNjOlMYHEYiSWjfjZ3nxHxpnaXr5ig1LKYGbEyEJ
         4bVbKyVfYMarfZvKkLGT4O7GrKpmzgiWSMGuU9G/V7ITcxN4E8eGMX1wtMDmV/V7tAI8
         4TB1oVvywb27j5Xtks52r/oplLfLwX8A450JZ9pzZLRLg8mBeLcDUYnHZa7mWHbdHHUJ
         hntntY+KTHUi3QFYLSOM4WLcOtJ5m2RbbXe4ZDcnsXsMF7umFed4F0ehdk26zplFPY3c
         uaXeR9R/zp2Y3cawJCSUnBuVLTGhmsrMUOk99qx8nZ2RGDhXYd8TGLtm86ZUXS/bFdc2
         lvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZVGIj4tUMtOzUQeEJsn9To8y+Iu7srnhe9+RZIuWOI=;
        b=B3Cw7ZLngjwnRguag6mtTo4czS11Bm/pFAGaFM7qz/TYw40b43NBl7PaVxHCrXLJKJ
         MhWAelACB/VCyDkcXq8XAsi1w9/aSkrIrK5XKeqO9i4LWYWA3syien+1MoX1qoBWP/Cu
         pIAOCYz6O+NVF3swzsG6yYXUca2OdBetVYmUWnDovB5OhKnu9rhtpmf8BnZxPIIpstlX
         ij7jGxbu9WGM4+Q7G2B5gmeFhKleRjPjB3mMztiVnKDpbcOTVTV80pMXqNEQ0vOV9czM
         XcI82R+9JeQTzzMo3vaNcEw13TCS9UN719cRQI09D6IG6HXJ7x1BZi3EXYkZ/Zk3hZW1
         u3QA==
X-Gm-Message-State: AOAM5309ZR+VZ6T15h0VYqt1e/PT8Mq6cpnN2Uv8VLfKWcpgdzZU969U
        ON49kVGUkjzZ8nvWfchH1ne0DYT5az3aY5rr4mxTmw==
X-Google-Smtp-Source: ABdhPJzDmgIwFY4f0yUV+byn0j+Nu5+VzLL9jIQ7SXS0tv/19kR2sQlytJ5wPI13Ob31AlpEwtvLG87Osgl0StKy4ds=
X-Received: by 2002:a67:2f44:0:b0:32a:27a3:7319 with SMTP id
 v65-20020a672f44000000b0032a27a37319mr1833795vsv.49.1650650598274; Fri, 22
 Apr 2022 11:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220421031738.3168157-1-pcc@google.com> <YmFORWyMAVacycu5@hyeyoo>
 <CAMn1gO5xHZvFSSsW5sTVaUBN_gS-cYYNMG3PnpgCmh7kk_Zx7Q@mail.gmail.com>
 <YmKiDt12Xb/KXX3z@hyeyoo> <f2f7ac96-6fb7-3733-f389-208c7c191caf@suse.cz>
In-Reply-To: <f2f7ac96-6fb7-3733-f389-208c7c191caf@suse.cz>
From:   Peter Collingbourne <pcc@google.com>
Date:   Fri, 22 Apr 2022 11:03:07 -0700
Message-ID: <CAMn1gO5SgwJLWxCSH8z0_DgGHY16hTd7rJLvDwCTPkNAWidiPQ@mail.gmail.com>
Subject: Re: [PATCH] mm: make minimum slab alignment a runtime property
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>, cl@linux.org,
        roman.gushchin@linux.dev, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
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

On Fri, Apr 22, 2022 at 9:19 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 4/22/22 14:39, Hyeonggon Yoo wrote:
> > On Thu, Apr 21, 2022 at 10:16:25AM -0700, Peter Collingbourne wrote:
> >> On Thu, Apr 21, 2022 at 5:30 AM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> >> >
> >> > On Wed, Apr 20, 2022 at 08:17:38PM -0700, Peter Collingbourne wrote:
> >> > > When CONFIG_KASAN_HW_TAGS is enabled we currently increase the minimum
> >> > > slab alignment to 16. This happens even if MTE is not supported in
> >> > > hardware or disabled via kasan=off, which creates an unnecessary
> >> > > memory overhead in those cases. Eliminate this overhead by making
> >> > > the minimum slab alignment a runtime property and only aligning to
> >> > > 16 if KASAN is enabled at runtime.
> >> > >
> >> > > On a DragonBoard 845c (non-MTE hardware) with a kernel built with
> >> > > CONFIG_KASAN_HW_TAGS, waiting for quiescence after a full Android
> >> > > boot I see the following Slab measurements in /proc/meminfo (median
> >> > > of 3 reboots):
> >> > >
> >> > > Before: 169020 kB
> >> > > After:  167304 kB
> >> > >
> >> > > Link: https://linux-review.googlesource.com/id/I752e725179b43b144153f4b6f584ceb646473ead
> >> > > Signed-off-by: Peter Collingbourne <pcc@google.com>
> >> > > ---
> >> > >  arch/arc/include/asm/cache.h        |  4 ++--
> >> > >  arch/arm/include/asm/cache.h        |  2 +-
> >> > >  arch/arm64/include/asm/cache.h      | 19 +++++++++++++------
> >> > >  arch/microblaze/include/asm/page.h  |  2 +-
> >> > >  arch/riscv/include/asm/cache.h      |  2 +-
> >> > >  arch/sparc/include/asm/cache.h      |  2 +-
> >> > >  arch/xtensa/include/asm/processor.h |  2 +-
> >> > >  fs/binfmt_flat.c                    |  9 ++++++---
> >> > >  include/crypto/hash.h               |  2 +-
> >> > >  include/linux/slab.h                | 22 +++++++++++++++++-----
> >> > >  mm/slab.c                           |  7 +++----
> >> > >  mm/slab_common.c                    |  3 +--
> >> > >  mm/slob.c                           |  6 +++---
> >> > >  13 files changed, 51 insertions(+), 31 deletions(-)
> >> >
> >> > [+Cc slab people, Catalin and affected subsystems' folks]
> >> >
> >> > just FYI, There is similar discussion about kmalloc caches' alignment.
> >> > https://lore.kernel.org/linux-mm/20220405135758.774016-1-catalin.marinas@arm.com/
> >> >
> >> > It seems this is another demand for runtime resolution of slab
> >> > alignment, But slightly different from kmalloc as there is no requirement
> >> > for DMA alignment.
> >> >
> >> > >
> >> > > diff --git a/arch/arc/include/asm/cache.h b/arch/arc/include/asm/cache.h
> >> > > index f0f1fc5d62b6..b6a7763fd5d6 100644
> >> > > --- a/arch/arc/include/asm/cache.h
> >> > > +++ b/arch/arc/include/asm/cache.h
> >> > > @@ -55,11 +55,11 @@
> >> > >   * Make sure slab-allocated buffers are 64-bit aligned when atomic64_t uses
> >> > >   * ARCv2 64-bit atomics (LLOCKD/SCONDD). This guarantess runtime 64-bit
> >> > >   * alignment for any atomic64_t embedded in buffer.
> >> > > - * Default ARCH_SLAB_MINALIGN is __alignof__(long long) which has a relaxed
> >> > > + * Default ARCH_SLAB_MIN_MINALIGN is __alignof__(long long) which has a relaxed
> >> > >   * value of 4 (and not 8) in ARC ABI.
> >> > >   */
> >> > >  #if defined(CONFIG_ARC_HAS_LL64) && defined(CONFIG_ARC_HAS_LLSC)
> >> > > -#define ARCH_SLAB_MINALIGN   8
> >> > > +#define ARCH_SLAB_MIN_MINALIGN       8
> >> > >  #endifh
> >> > >
> >> >
> >> > Why isn't it just ARCH_SLAB_MINALIGN?
> >>
> >> Because this is the minimum possible value of the minimum alignment
> >> decided at runtime. I chose to give it a different name to
> >> arch_slab_minalign() because the two have different meanings.
> >>
> >> Granted this isn't a great name because of the stuttering but
> >> hopefully it will prompt folks to investigate the meaning of this
> >> constant if necessary.
> >
> > To be honest I don't care much about the name but just thought it's just better
> > to be consistent with Catalin's series: ARCH_KMALLOC_MINALIGN for static
> > alignment and arch_kmalloc_minalign() for (possibly bigger) alignment decided
> > at runtime.
>
> Agree it should be consistent, one way or another. I would (not overly
> strongly) prefer Catalin's approach as it's less churn. The name
> ARCH_SLAB_MINALIGN is not wrong as the actual alignment can be only bigger
> than that (or equal).
> Realistically it seems only slab internals are going to use
> arch_kmalloc_minalign(), so there shouldn't be too much need of "prompt
> folks to investigate".

No strong opinion, so I'll change it back to ARCH_SLAB_MINALIGN then.

> >> > >  extern int ioc_enable;
> >> > > diff --git a/arch/arm/include/asm/cache.h b/arch/arm/include/asm/cache.h
> >> > > index e3ea34558ada..3e1018bb9805 100644
> >> > > --- a/arch/arm/include/asm/cache.h
> >> > > +++ b/arch/arm/include/asm/cache.h
> >> > > @@ -21,7 +21,7 @@
> >> > >   * With EABI on ARMv5 and above we must have 64-bit aligned slab pointers.
> >> > >   */
> >> > >  #if defined(CONFIG_AEABI) && (__LINUX_ARM_ARCH__ >= 5)
> >> > > -#define ARCH_SLAB_MINALIGN 8
> >> > > +#define ARCH_SLAB_MIN_MINALIGN 8
> >> > >  #endif
> >> > >
> >> > >  #define __read_mostly __section(".data..read_mostly")
> >> > > diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
> >> > > index a074459f8f2f..38f171591c3f 100644
> >> > > --- a/arch/arm64/include/asm/cache.h
> >> > > +++ b/arch/arm64/include/asm/cache.h
> >> > > @@ -6,6 +6,7 @@
> >> > >  #define __ASM_CACHE_H
> >> > >
> >> > >  #include <asm/cputype.h>
> >> > > +#include <asm/mte-def.h>
> >> > >
> >> > >  #define CTR_L1IP_SHIFT               14
> >> > >  #define CTR_L1IP_MASK                3
> >> > > @@ -49,15 +50,21 @@
> >> > >   */
> >> > >  #define ARCH_DMA_MINALIGN    (128)
> >> > >
> >> > > -#ifdef CONFIG_KASAN_SW_TAGS
> >> > > -#define ARCH_SLAB_MINALIGN   (1ULL << KASAN_SHADOW_SCALE_SHIFT)
> >> > > -#elif defined(CONFIG_KASAN_HW_TAGS)
> >> > > -#define ARCH_SLAB_MINALIGN   MTE_GRANULE_SIZE
> >> > > -#endif
> >> > > -
> >> > >  #ifndef __ASSEMBLY__
> >> > >
> >> > >  #include <linux/bitops.h>
> >> > > +#include <linux/kasan-enabled.h>
> >> > > +
> >> > > +#ifdef CONFIG_KASAN_SW_TAGS
> >> > > +#define ARCH_SLAB_MIN_MINALIGN       (1ULL << KASAN_SHADOW_SCALE_SHIFT)
> >> > > +#elif defined(CONFIG_KASAN_HW_TAGS)
> >> > > +static inline size_t arch_slab_minalign(void)
> >> > > +{
> >> > > +     return kasan_hw_tags_enabled() ? MTE_GRANULE_SIZE :
> >> > > +                                      __alignof__(unsigned long long);
> >> > > +}
> >> > > +#define arch_slab_minalign() arch_slab_minalign()
> >> > > +#endif
> >> > >
> >> >
> >> > kasan_hw_tags_enabled() is also false when kasan is just not initialized yet.
> >> > What about writing a new helper something like kasan_is_disabled()
> >> > instead?
> >>
> >> The decision of whether to enable KASAN is made early, before the slab
> >> allocator is initialized (start_kernel -> smp_prepare_boot_cpu ->
> >> kasan_init_hw_tags vs start_kernel -> mm_init -> kmem_cache_init). If
> >> you think about it, this needs to be the case for KASAN to operate
> >> correctly because it influences the behavior of the slab allocator via
> >> the kasan_*poison* hooks. So I don't think we can end up calling this
> >> function before then.
> >
> > Sounds not bad. I wanted to make sure the value of arch_slab_minaligned()
> > is not changed during its execution.
> >
> > Just some part of me thought something like this would be more
> > intuitive/robust.
> >
> > if (systems_supports_mte() && kasan_arg != KASAN_ARG_OFF)
> >       return MTE_GRANULE_SIZE;
> > else
> >       return __alignof__(unsigned long long);
>
> Let's see if kasan or arm folks have an opinion here.
>
> >
> >> > >  #define ICACHEF_ALIASING     0
> >> > >  #define ICACHEF_VPIPT                1
> >> > > diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
> >> > > index 4b8b2fa78fc5..ccdbc1da3c3e 100644
> >> > > --- a/arch/microblaze/include/asm/page.h
> >> > > +++ b/arch/microblaze/include/asm/page.h
> >> > > @@ -33,7 +33,7 @@
> >> > >  /* MS be sure that SLAB allocates aligned objects */
> >> > >  #define ARCH_DMA_MINALIGN    L1_CACHE_BYTES
> >> > >
> >> > > -#define ARCH_SLAB_MINALIGN   L1_CACHE_BYTES
> >> > > +#define ARCH_SLAB_MIN_MINALIGN       L1_CACHE_BYTES
> >> > >
> >> > >  /*
> >> > >   * PAGE_OFFSET -- the first address of the first page of memory. With MMU
> >> > > diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
> >> > > index 9b58b104559e..7beb3b5d27c7 100644
> >> > > --- a/arch/riscv/include/asm/cache.h
> >> > > +++ b/arch/riscv/include/asm/cache.h
> >> > > @@ -16,7 +16,7 @@
> >> > >   * the flat loader aligns it accordingly.
> >> > >   */
> >> > >  #ifndef CONFIG_MMU
> >> > > -#define ARCH_SLAB_MINALIGN   16
> >> > > +#define ARCH_SLAB_MIN_MINALIGN       16
> >> > >  #endif
> >> > >
> >> > >  #endif /* _ASM_RISCV_CACHE_H */
> >> > > diff --git a/arch/sparc/include/asm/cache.h b/arch/sparc/include/asm/cache.h
> >> > > index e62fd0e72606..9d8cb4687b7e 100644
> >> > > --- a/arch/sparc/include/asm/cache.h
> >> > > +++ b/arch/sparc/include/asm/cache.h
> >> > > @@ -8,7 +8,7 @@
> >> > >  #ifndef _SPARC_CACHE_H
> >> > >  #define _SPARC_CACHE_H
> >> > >
> >> > > -#define ARCH_SLAB_MINALIGN   __alignof__(unsigned long long)
> >> > > +#define ARCH_SLAB_MIN_MINALIGN       __alignof__(unsigned long long)
> >> > >
> >> > >  #define L1_CACHE_SHIFT 5
> >> > >  #define L1_CACHE_BYTES 32
> >> > > diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
> >> > > index 4489a27d527a..e3ea278e3fcf 100644
> >> > > --- a/arch/xtensa/include/asm/processor.h
> >> > > +++ b/arch/xtensa/include/asm/processor.h
> >> > > @@ -18,7 +18,7 @@
> >> > >  #include <asm/types.h>
> >> > >  #include <asm/regs.h>
> >> > >
> >> > > -#define ARCH_SLAB_MINALIGN XTENSA_STACK_ALIGNMENT
> >> > > +#define ARCH_SLAB_MIN_MINALIGN XTENSA_STACK_ALIGNMENT
> >> > >
> >> > >  /*
> >> > >   * User space process size: 1 GB.
> >> > > diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
> >> > > index 626898150011..8ff1bf7d1e87 100644
> >> > > --- a/fs/binfmt_flat.c
> >> > > +++ b/fs/binfmt_flat.c
> >> > > @@ -64,7 +64,10 @@
> >> > >   * Here we can be a bit looser than the data sections since this
> >> > >   * needs to only meet arch ABI requirements.
> >> > >   */
> >> > > -#define FLAT_STACK_ALIGN     max_t(unsigned long, sizeof(void *), ARCH_SLAB_MINALIGN)
> >> > > +static size_t flat_stack_align(void)
> >> > > +{
> >> > > +     return max_t(unsigned long, sizeof(void *), arch_slab_minalign());
> >> > > +}
>
> I think this might not be necessary at all. There doesn't seem to be actual
> connection to the slab+kasan constraints here. My brief digging into git
> blame suggest they just used the ARCH_SLAB_MINALIGN constant because it
> existed, e.g. commit 2952095c6b2ee includes in changelog "Arguably, this is
> kind of hokey that the FLAT is semi-abusing defines it shouldn't."
> So, there shouldn't be a reason to increase this due to KASAN/MTE granule
> size, it was done unnecessarily as a side-effect before (AFAIU it shouldn't
> have caused existing userspace binaries to break, but maybe in some corner
> case it could?), and if this patch leaves out the binfmt_flat changes, the
> alignment will be (IMHO correctly) decreased again.

Okay, I'll revert this part.

> >> > >
> >> > >  #define RELOC_FAILED 0xff00ff01              /* Relocation incorrect somewhere */
> >> > >  #define UNLOADED_LIB 0x7ff000ff              /* Placeholder for unused library */
> >> > > @@ -148,7 +151,7 @@ static int create_flat_tables(struct linux_binprm *bprm, unsigned long arg_start
> >> > >               sp -= 2; /* argvp + envp */
> >> > >       sp -= 1;  /* &argc */
> >> > >
> >> > > -     current->mm->start_stack = (unsigned long)sp & -FLAT_STACK_ALIGN;
> >> > > +     current->mm->start_stack = (unsigned long)sp & -flat_stack_align();
> >> > >       sp = (unsigned long __user *)current->mm->start_stack;
> >> > >
> >> > >       if (put_user(bprm->argc, sp++))
> >> > > @@ -966,7 +969,7 @@ static int load_flat_binary(struct linux_binprm *bprm)
> >> > >  #endif
> >> > >       stack_len += (bprm->argc + 1) * sizeof(char *);   /* the argv array */
> >> > >       stack_len += (bprm->envc + 1) * sizeof(char *);   /* the envp array */
> >> > > -     stack_len = ALIGN(stack_len, FLAT_STACK_ALIGN);
> >> > > +     stack_len = ALIGN(stack_len, flat_stack_align());
> >> > >
> >> > >       res = load_flat_file(bprm, &libinfo, 0, &stack_len);
> >> > >       if (res < 0)
> >> > > diff --git a/include/crypto/hash.h b/include/crypto/hash.h
> >> > > index f140e4643949..442c290f458c 100644
> >> > > --- a/include/crypto/hash.h
> >> > > +++ b/include/crypto/hash.h
> >> > > @@ -149,7 +149,7 @@ struct ahash_alg {
> >> > >
> >> > >  struct shash_desc {
> >> > >       struct crypto_shash *tfm;
> >> > > -     void *__ctx[] __aligned(ARCH_SLAB_MINALIGN);
> >> > > +     void *__ctx[] __aligned(ARCH_SLAB_MIN_MINALIGN);
> >> > >  };
> >> > >
> >> > >  #define HASH_MAX_DIGESTSIZE   64
> >> > > diff --git a/include/linux/slab.h b/include/linux/slab.h
> >> > > index 373b3ef99f4e..80e517593372 100644
> >> > > --- a/include/linux/slab.h
> >> > > +++ b/include/linux/slab.h
> >> > > @@ -201,21 +201,33 @@ void kmem_dump_obj(void *object);
> >> > >  #endif
> >> > >
> >> > >  /*
> >> > > - * Setting ARCH_SLAB_MINALIGN in arch headers allows a different alignment.
> >> > > + * Setting ARCH_SLAB_MIN_MINALIGN in arch headers allows a different alignment.
> >> > >   * Intended for arches that get misalignment faults even for 64 bit integer
> >> > >   * aligned buffers.
> >> > >   */
> >> > > -#ifndef ARCH_SLAB_MINALIGN
> >> > > -#define ARCH_SLAB_MINALIGN __alignof__(unsigned long long)
> >> > > +#ifndef ARCH_SLAB_MIN_MINALIGN
> >> > > +#define ARCH_SLAB_MIN_MINALIGN __alignof__(unsigned long long)
> >> > > +#endif
> >> > > +
> >> > > +/*
> >> > > + * Arches can define this function if they want to decide the minimum slab
> >> > > + * alignment at runtime. The value returned by the function must be
> >> > > + * >= ARCH_SLAB_MIN_MINALIGN.
> >> > > + */
> >> >
> >> > Not only the value should be bigger than or equal to ARCH_SLAB_MIN_MINALIGN,
> >> > it should be compatible with ARCH_SLAB_MIN_MINALIGN.
> >>
> >> What's the difference?
> >>
> >
> > 231 /*
> > 232  * kmalloc and friends return ARCH_KMALLOC_MINALIGN aligned
> > 233  * pointers. kmem_cache_alloc and friends return ARCH_SLAB_MIN_MINALIGN
> > 234  * aligned pointers.
> > 235  */
> > 236 #define __assume_kmalloc_alignment __assume_aligned(ARCH_KMALLOC_MINALIGN)
> > 237 #define __assume_slab_alignment __assume_aligned(ARCH_SLAB_MIN_MINALIGN)
> > 238 #define __assume_page_alignment __assume_aligned(PAGE_SIZE)
> >
> > I mean actual slab object size should be both ARCH_SLAB_MIN_MINALIGN-aligned and
> > arch_slab_minalign()-aligned. Otherwise we are lying to the compiler.
> >
> > It's okay If we use just power-of-two alignment.
> > But adding a comment wouldn't harm :)
>
> Agreed, technically it's not ">=ARCH_SLAB_MIN_MINALIGN", but "a least common
> multiple of ARCH_SLAB_MIN_MINALIGN and whatever the other alignment
> requirements arch_slab_minalign() wants to guarantee". But AFAIK in practice
> these constraints are always power-of-two.

I think it's pretty much assumed that alignments are a power of two,
so from that viewpoint it's enough to say that it must be
>=ARCH_SLAB_MIN_MINALIGN. I guess I'll change the comment to say that
it must return a power of two since there's no reason not to.

Peter
