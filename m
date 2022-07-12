Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3BC57278F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiGLUn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGLUn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:43:56 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBC917AA8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:43:52 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id l24so9038966ion.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r642Vyyz6e/+S5tpfBaXlyA6JS5RlQbrmCv6QVyB8K8=;
        b=P0GjUZi6k2XUuDuOUcGkDu4SqlKVGUf+WSFsq9CovnTp6jXeaG7D1wDtXc/XuA7/OA
         Jd3V+TpkLWwOF+rw9GbArlMGJ9EZpd7xFh8L/9ZR2krQU7pqNVd0muDLroIMObDgV57r
         sg5C1R0LVLSDHKLMRzNqFsLgpRve9RuTdiWUHLNtKz2WPsoxHlTWhNYsYkyx8DJvUpas
         /EN71ATmeMYnnjAReVsAvcMmzXmTWQ13SyzikUzseDu+2nTySxL5sweakGdbMG8qD/03
         qA9V5IBxKGSUjcQJ8hCIzse6BLmH8SIHPwR1PdhnCP7JBmdOlOC/8jqJtrVw8+YJoV1Q
         onEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r642Vyyz6e/+S5tpfBaXlyA6JS5RlQbrmCv6QVyB8K8=;
        b=pIw9PoinbVghVLIyNVIl72YhTKSnzCmgOZHdDi69PYt9OkXIhHNYwGhqtnFFJTWzhH
         8eQ+MG8KdG8khLKvpFigIxLIxxcJkLjYjcn35Qo89brzyAMBGmOd58vZOlvS+1RD5mma
         m/6pkvWnFUZc2TrvXi0U7RaS7dqNA2pYn8gwUAyz5l6DBuTwXNkPBwHfjwF6SxTkUyfu
         Z7XQ4cn3KfX6DaUkaCFMetUU5fTp0D69W9rHzosI8P80yHPh7c114fuhv3Agw2JssGi1
         bJg2gmjYweXhTvOsGNBwkQzqTIv2ez9iZbCyNDJQMJex4rKLFeEL+J6fA9GwLP2Xf4QX
         2IAA==
X-Gm-Message-State: AJIora9f4kBv2HG8Vgw+kZYzIfSvVFaXUA9csoANJvQpbsuAANj0ZBEH
        Gy53x/xqlYKAD0mCYZd32qF3BSoYVqHvmp50OMw=
X-Google-Smtp-Source: AGRyM1v8eG97aE4krYkn/F8yItrbDnfjNiaM0VRKOizY8OIQOgn07Df4wgh09jw8crDjYJlpgao321yTdGtJDDmjoM0=
X-Received: by 2002:a6b:5f06:0:b0:67b:853f:565d with SMTP id
 t6-20020a6b5f06000000b0067b853f565dmr20947iob.118.1657658632140; Tue, 12 Jul
 2022 13:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220701091621.3022368-1-davidgow@google.com> <20220701091621.3022368-2-davidgow@google.com>
In-Reply-To: <20220701091621.3022368-2-davidgow@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 12 Jul 2022 22:43:41 +0200
Message-ID: <CA+fCnZdRUDO5wB1UKCZxT=XkLR49rjntXGi9-3S5h6_LTyBc8g@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] UML: add support for KASAN under x86_64
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
        Linux Memory Management List <linux-mm@kvack.org>,
        kunit-dev@googlegroups.com
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

On Fri, Jul 1, 2022 at 11:16 AM David Gow <davidgow@google.com> wrote:
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
> This is v5 of the KASAN/UML port. It should be ready to go (this time,
> for sure! :-))
>
> Note that this will fail to build if UML is linked statically due to:
> https://lore.kernel.org/all/20220526185402.955870-1-davidgow@google.com/
>
> Changes since v4:
> https://lore.kernel.org/lkml/20220630080834.2742777-2-davidgow@google.com/
> - Instrument all of the stacktrace code (except for the actual reading
>   of the stack frames).
>   - This means that stacktrace.c and sysrq.c are now instrumented.
>   - Stack frames are read with READ_ONCE_NOCHECK()
>   - Thanks Andrey for pointing this out.
>
> Changes since v3:
> https://lore.kernel.org/lkml/20220630074757.2739000-2-davidgow@google.com/
> - Fix some tabs which got converted to spaces by a rogue vim plugin.
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
>  arch/um/Kconfig                  | 15 +++++++++++++
>  arch/um/include/asm/common.lds.S |  2 ++
>  arch/um/include/asm/kasan.h      | 37 ++++++++++++++++++++++++++++++++
>  arch/um/kernel/dyn.lds.S         |  6 +++++-
>  arch/um/kernel/mem.c             | 19 ++++++++++++++++
>  arch/um/kernel/stacktrace.c      |  2 +-
>  arch/um/os-Linux/mem.c           | 22 +++++++++++++++++++
>  arch/um/os-Linux/user_syms.c     |  4 ++--
>  arch/x86/um/Makefile             |  3 ++-
>  arch/x86/um/vdso/Makefile        |  3 +++
>  mm/kasan/shadow.c                | 29 +++++++++++++++++++++++--
>  11 files changed, 135 insertions(+), 7 deletions(-)
>  create mode 100644 arch/um/include/asm/kasan.h
>
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 8062a0c08952..289c9dc226d6 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -12,6 +12,8 @@ config UML
>         select ARCH_HAS_STRNLEN_USER
>         select ARCH_NO_PREEMPT
>         select HAVE_ARCH_AUDITSYSCALL
> +       select HAVE_ARCH_KASAN if X86_64
> +       select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
>         select HAVE_ARCH_SECCOMP_FILTER
>         select HAVE_ASM_MODVERSIONS
>         select HAVE_UID16
> @@ -220,6 +222,19 @@ config UML_TIME_TRAVEL_SUPPORT
>
>           It is safe to say Y, but you probably don't need this.
>
> +config KASAN_SHADOW_OFFSET
> +       hex
> +       depends on KASAN
> +       default 0x100000000000
> +       help
> +         This is the offset at which the ~16TB of shadow memory is
> +         mapped and used by KASAN for memory debugging. This can be any
> +         address that has at least KASAN_SHADOW_SIZE (total address space divided
> +         by 8) amount of space so that the KASAN shadow memory does not conflict
> +         with anything. The default is 0x100000000000, which works even if mem is
> +         set to a large value. On low-memory systems, try 0x7fff8000, as it fits
> +         into the immediate of most instructions, improving performance.
> +
>  endmenu
>
>  source "arch/um/drivers/Kconfig"
> diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
> index eca6c452a41b..fd481ac371de 100644
> --- a/arch/um/include/asm/common.lds.S
> +++ b/arch/um/include/asm/common.lds.S
> @@ -83,6 +83,8 @@
>    }
>    .init_array : {
>         __init_array_start = .;
> +       *(.kasan_init)
> +       *(.init_array.*)
>         *(.init_array)
>         __init_array_end = .;
>    }
> diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
> new file mode 100644
> index 000000000000..0d6547f4ec85
> --- /dev/null
> +++ b/arch/um/include/asm/kasan.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_UM_KASAN_H
> +#define __ASM_UM_KASAN_H
> +
> +#include <linux/init.h>
> +#include <linux/const.h>
> +
> +#define KASAN_SHADOW_OFFSET _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
> +
> +/* used in kasan_mem_to_shadow to divide by 8 */
> +#define KASAN_SHADOW_SCALE_SHIFT 3
> +
> +#ifdef CONFIG_X86_64
> +#define KASAN_HOST_USER_SPACE_END_ADDR 0x00007fffffffffffUL
> +/* KASAN_SHADOW_SIZE is the size of total address space divided by 8 */
> +#define KASAN_SHADOW_SIZE ((KASAN_HOST_USER_SPACE_END_ADDR + 1) >> \
> +                       KASAN_SHADOW_SCALE_SHIFT)
> +#else
> +#error "KASAN_SHADOW_SIZE is not defined for this sub-architecture"
> +#endif /* CONFIG_X86_64 */
> +
> +#define KASAN_SHADOW_START (KASAN_SHADOW_OFFSET)
> +#define KASAN_SHADOW_END (KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
> +
> +#ifdef CONFIG_KASAN
> +void kasan_init(void);
> +void kasan_map_memory(void *start, unsigned long len);
> +extern int kasan_um_is_ready;
> +
> +#ifdef CONFIG_STATIC_LINK
> +#define kasan_arch_is_ready() (kasan_um_is_ready)
> +#endif
> +#else
> +static inline void kasan_init(void) { }
> +#endif /* CONFIG_KASAN */
> +
> +#endif /* __ASM_UM_KASAN_H */
> diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
> index 2f2a8ce92f1e..2b7fc5b54164 100644
> --- a/arch/um/kernel/dyn.lds.S
> +++ b/arch/um/kernel/dyn.lds.S
> @@ -109,7 +109,11 @@ SECTIONS
>       be empty, which isn't pretty.  */
>    . = ALIGN(32 / 8);
>    .preinit_array     : { *(.preinit_array) }
> -  .init_array     : { *(.init_array) }
> +  .init_array     : {
> +    *(.kasan_init)
> +    *(.init_array.*)
> +    *(.init_array)
> +  }
>    .fini_array     : { *(.fini_array) }
>    .data           : {
>      INIT_TASK_DATA(KERNEL_STACK_SIZE)
> diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
> index 15295c3237a0..276a1f0b91f1 100644
> --- a/arch/um/kernel/mem.c
> +++ b/arch/um/kernel/mem.c
> @@ -18,6 +18,25 @@
>  #include <kern_util.h>
>  #include <mem_user.h>
>  #include <os.h>
> +#include <linux/sched/task.h>
> +
> +#ifdef CONFIG_KASAN
> +int kasan_um_is_ready;
> +void kasan_init(void)
> +{
> +       /*
> +        * kasan_map_memory will map all of the required address space and
> +        * the host machine will allocate physical memory as necessary.
> +        */
> +       kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
> +       init_task.kasan_depth = 0;
> +       kasan_um_is_ready = true;
> +}
> +
> +static void (*kasan_init_ptr)(void)
> +__section(".kasan_init") __used
> += kasan_init;
> +#endif
>
>  /* allocated in paging_init, zeroed in mem_init, and unchanged thereafter */
>  unsigned long *empty_zero_page = NULL;
> diff --git a/arch/um/kernel/stacktrace.c b/arch/um/kernel/stacktrace.c
> index 86df52168bd9..fd3b61b3d4d2 100644
> --- a/arch/um/kernel/stacktrace.c
> +++ b/arch/um/kernel/stacktrace.c
> @@ -27,7 +27,7 @@ void dump_trace(struct task_struct *tsk,
>
>         frame = (struct stack_frame *)bp;
>         while (((long) sp & (THREAD_SIZE-1)) != 0) {
> -               addr = *sp;
> +               addr = READ_ONCE_NOCHECK(*sp);
>                 if (__kernel_text_address(addr)) {
>                         reliable = 0;
>                         if ((unsigned long) sp == bp + sizeof(long)) {
> diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
> index 3c1b77474d2d..8530b2e08604 100644
> --- a/arch/um/os-Linux/mem.c
> +++ b/arch/um/os-Linux/mem.c
> @@ -17,6 +17,28 @@
>  #include <init.h>
>  #include <os.h>
>
> +/*
> + * kasan_map_memory - maps memory from @start with a size of @len.
> + * The allocated memory is filled with zeroes upon success.
> + * @start: the start address of the memory to be mapped
> + * @len: the length of the memory to be mapped
> + *
> + * This function is used to map shadow memory for KASAN in uml
> + */
> +void kasan_map_memory(void *start, size_t len)
> +{
> +       if (mmap(start,
> +                len,
> +                PROT_READ|PROT_WRITE,
> +                MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE|MAP_NORESERVE,
> +                -1,
> +                0) == MAP_FAILED) {
> +               os_info("Couldn't allocate shadow memory: %s\n.",
> +                       strerror(errno));
> +               exit(1);
> +       }
> +}
> +
>  /* Set by make_tempfile() during early boot. */
>  static char *tempdir = NULL;
>
> diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
> index 715594fe5719..cb667c9225ab 100644
> --- a/arch/um/os-Linux/user_syms.c
> +++ b/arch/um/os-Linux/user_syms.c
> @@ -27,10 +27,10 @@ EXPORT_SYMBOL(strstr);
>  #ifndef __x86_64__
>  extern void *memcpy(void *, const void *, size_t);
>  EXPORT_SYMBOL(memcpy);
> -#endif
> -
>  EXPORT_SYMBOL(memmove);
>  EXPORT_SYMBOL(memset);
> +#endif
> +
>  EXPORT_SYMBOL(printf);
>
>  /* Here, instead, I can provide a fake prototype. Yes, someone cares: genksyms.
> diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
> index ba5789c35809..f778e37494ba 100644
> --- a/arch/x86/um/Makefile
> +++ b/arch/x86/um/Makefile
> @@ -28,7 +28,8 @@ else
>
>  obj-y += syscalls_64.o vdso/
>
> -subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o
> +subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o \
> +       ../lib/memmove_64.o ../lib/memset_64.o
>
>  endif
>
> diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
> index 5943387e3f35..8c0396fd0e6f 100644
> --- a/arch/x86/um/vdso/Makefile
> +++ b/arch/x86/um/vdso/Makefile
> @@ -3,6 +3,9 @@
>  # Building vDSO images for x86.
>  #
>
> +# do not instrument on vdso because KASAN is not compatible with user mode
> +KASAN_SANITIZE                 := n
> +
>  # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
>  KCOV_INSTRUMENT                := n
>
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index a4f07de21771..0e3648b603a6 100644
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
> +        * The remaining CONFIG_UML checks in this file exist for the same
> +        * reason.
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
> @@ -466,6 +479,10 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
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
> @@ -531,6 +548,11 @@ int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
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
> @@ -554,6 +576,9 @@ int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
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
> 2.37.0.rc0.161.g10f37bed90-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
