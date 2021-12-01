Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3603D464704
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 07:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346842AbhLAGKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 01:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhLAGKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 01:10:20 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BB1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 22:07:00 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id x5so23308840pfr.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 22:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=a6WI6kmm9iqStm7clJyoQn8Vl9qcng7/4VaNkmIimF8=;
        b=cURKL3jem4rRiqeLpwHrKu3/1uYb/cO0/+k97l7jNyYCzeFppf59V9TI7EbS4wOjUY
         g12PM87nLGduXlKgzRaPS85cTLXe8cMKogoJlEE0RcVNxLXOHWuRp55wWy4TZevJjHSg
         nAqeorpiaqdmyDPX8kCYv9RRSzrE7SZxFoqa9Qx7OhMUjq4T/4ekFaj7NhyAgpNwoetH
         Z+FzCwl9yRje92g1L94MApAJR+7xVBHWsaZffLRWTvxrIQak61FGNFDhCvLp0BD3FlVG
         iJ8vi5AiVbKQkTfqUP+KHfeA2dgUhx5j6xv0zwd9YF3anLS6NXWK39HhZRexdW4mqT83
         T8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=a6WI6kmm9iqStm7clJyoQn8Vl9qcng7/4VaNkmIimF8=;
        b=bdLVcxI1RQy4GFg02fWLQHlP5e77buX52HIiw1A/YnyX1FgxtNEga5whon9oSt/lzd
         XSp329N02aBYe0oYBGN3wqvv0eT0XqGfwN0TlaY4zxWFVixz7U7mPVvpUfbqUkWbKc5P
         attq4e5vPURcq1Zvkb93u6g0swY9vwJJ3Yw2cZdRrEU1S1DpHO28ePV4QfAlzoObuOgl
         vIO9B6xxOxSPdsS4mbtaOyJGx/4/ieKFKL71lH54duKY3FT7mVvKTjt+9gBJ7sk7c1jn
         JvykcG/28LJDAkbPAwWP/xCdqd1c+PlwmSNg+T/TKuRp9IOYgOfqX7cU5sCqjfEXRoH8
         DxJA==
X-Gm-Message-State: AOAM532LAQ+amkw+AKkeQz9+Hw9HFL3qCBN2mDebWwG+FnvuHjP9us55
        K7igMRboePF36cG+3cSLxKHeORjyPao=
X-Google-Smtp-Source: ABdhPJxcaQZ3c3yG+DP0lAPCc52eOtA2zzspmC/KrPXYbzbLCczNKAx15Vvxbk6zUmhj3UGXZi8G6A==
X-Received: by 2002:a05:6a00:2188:b0:4a7:ec46:349c with SMTP id h8-20020a056a00218800b004a7ec46349cmr4321534pfi.26.1638338820114;
        Tue, 30 Nov 2021 22:07:00 -0800 (PST)
Received: from localhost (115-64-213-93.static.tpgi.com.au. [115.64.213.93])
        by smtp.gmail.com with ESMTPSA id h3sm4368768pjz.43.2021.11.30.22.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 22:06:59 -0800 (PST)
Date:   Wed, 01 Dec 2021 16:06:54 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 rebased 7/9] powerpc/mm: Convert to default topdown
 mmap layout
To:     alex@ghiti.fr, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1637862579.git.christophe.leroy@csgroup.eu>
        <de169ef3c9ecc6fafbec4d4d4cc85a4555338a7d.1637862579.git.christophe.leroy@csgroup.eu>
In-Reply-To: <de169ef3c9ecc6fafbec4d4d4cc85a4555338a7d.1637862579.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1638338684.ngcoex1af4.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of November 26, 2021 3:52 am:
> Select CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT and
> remove arch/powerpc/mm/mmap.c
>=20
> This change provides standard randomisation of mmaps.
>=20
> See commit 8b8addf891de ("x86/mm/32: Enable full randomization on i386
> and X86_32") for all the benefits of mmap randomisation.

What's the actual difference before/after this patch? The mm/util.c
code looks very similar to the code removed with a few small=20
differences. Can these differences be explained in this patch?

Thanks,
Nick

>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v2: Also remove selection of ARCH_HAS_ELF_RANDOMIZE as it is already sele=
cted by CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> ---
>  arch/powerpc/Kconfig                 |   2 +-
>  arch/powerpc/include/asm/processor.h |   2 -
>  arch/powerpc/mm/Makefile             |   2 +-
>  arch/powerpc/mm/mmap.c               | 105 ---------------------------
>  4 files changed, 2 insertions(+), 109 deletions(-)
>  delete mode 100644 arch/powerpc/mm/mmap.c
>=20
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index fb48823ccd62..20504a9901f2 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -122,7 +122,6 @@ config PPC
>  	select ARCH_HAS_DEBUG_WX		if STRICT_KERNEL_RWX
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
>  	select ARCH_HAS_DMA_MAP_DIRECT 		if PPC_PSERIES
> -	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select ARCH_HAS_HUGEPD			if HUGETLB_PAGE
> @@ -158,6 +157,7 @@ config PPC
>  	select ARCH_USE_MEMTEST
>  	select ARCH_USE_QUEUED_RWLOCKS		if PPC_QUEUED_SPINLOCKS
>  	select ARCH_USE_QUEUED_SPINLOCKS	if PPC_QUEUED_SPINLOCKS
> +	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
>  	select ARCH_WANT_IPC_PARSE_VERSION
>  	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
>  	select ARCH_WANT_LD_ORPHAN_WARN
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/=
asm/processor.h
> index e39bd0ff69f3..d906b14dd599 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -378,8 +378,6 @@ static inline void prefetchw(const void *x)
> =20
>  #define spin_lock_prefetch(x)	prefetchw(x)
> =20
> -#define HAVE_ARCH_PICK_MMAP_LAYOUT
> -
>  /* asm stubs */
>  extern unsigned long isa300_idle_stop_noloss(unsigned long psscr_val);
>  extern unsigned long isa300_idle_stop_mayloss(unsigned long psscr_val);
> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
> index d4c20484dad9..503a6e249940 100644
> --- a/arch/powerpc/mm/Makefile
> +++ b/arch/powerpc/mm/Makefile
> @@ -5,7 +5,7 @@
> =20
>  ccflags-$(CONFIG_PPC64)	:=3D $(NO_MINIMAL_TOC)
> =20
> -obj-y				:=3D fault.o mem.o pgtable.o mmap.o maccess.o pageattr.o \
> +obj-y				:=3D fault.o mem.o pgtable.o maccess.o pageattr.o \
>  				   init_$(BITS).o pgtable_$(BITS).o \
>  				   pgtable-frag.o ioremap.o ioremap_$(BITS).o \
>  				   init-common.o mmu_context.o drmem.o \
> diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
> deleted file mode 100644
> index 5972d619d274..000000000000
> --- a/arch/powerpc/mm/mmap.c
> +++ /dev/null
> @@ -1,105 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - *  flexible mmap layout support
> - *
> - * Copyright 2003-2004 Red Hat Inc., Durham, North Carolina.
> - * All Rights Reserved.
> - *
> - * Started by Ingo Molnar <mingo@elte.hu>
> - */
> -
> -#include <linux/personality.h>
> -#include <linux/mm.h>
> -#include <linux/random.h>
> -#include <linux/sched/signal.h>
> -#include <linux/sched/mm.h>
> -#include <linux/elf-randomize.h>
> -#include <linux/security.h>
> -#include <linux/mman.h>
> -
> -/*
> - * Top of mmap area (just below the process stack).
> - *
> - * Leave at least a ~128 MB hole.
> - */
> -#define MIN_GAP (128*1024*1024)
> -#define MAX_GAP (TASK_SIZE/6*5)
> -
> -static inline int mmap_is_legacy(struct rlimit *rlim_stack)
> -{
> -	if (current->personality & ADDR_COMPAT_LAYOUT)
> -		return 1;
> -
> -	if (rlim_stack->rlim_cur =3D=3D RLIM_INFINITY)
> -		return 1;
> -
> -	return sysctl_legacy_va_layout;
> -}
> -
> -unsigned long arch_mmap_rnd(void)
> -{
> -	unsigned long shift, rnd;
> -
> -	shift =3D mmap_rnd_bits;
> -#ifdef CONFIG_COMPAT
> -	if (is_32bit_task())
> -		shift =3D mmap_rnd_compat_bits;
> -#endif
> -	rnd =3D get_random_long() % (1ul << shift);
> -
> -	return rnd << PAGE_SHIFT;
> -}
> -
> -static inline unsigned long stack_maxrandom_size(void)
> -{
> -	if (!(current->flags & PF_RANDOMIZE))
> -		return 0;
> -
> -	/* 8MB for 32bit, 1GB for 64bit */
> -	if (is_32bit_task())
> -		return (1<<23);
> -	else
> -		return (1<<30);
> -}
> -
> -static inline unsigned long mmap_base(unsigned long rnd,
> -				      struct rlimit *rlim_stack)
> -{
> -	unsigned long gap =3D rlim_stack->rlim_cur;
> -	unsigned long pad =3D stack_maxrandom_size() + stack_guard_gap;
> -
> -	/* Values close to RLIM_INFINITY can overflow. */
> -	if (gap + pad > gap)
> -		gap +=3D pad;
> -
> -	if (gap < MIN_GAP)
> -		gap =3D MIN_GAP;
> -	else if (gap > MAX_GAP)
> -		gap =3D MAX_GAP;
> -
> -	return PAGE_ALIGN(DEFAULT_MAP_WINDOW - gap - rnd);
> -}
> -
> -/*
> - * This function, called very early during the creation of a new
> - * process VM image, sets up which VM layout function to use:
> - */
> -void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_sta=
ck)
> -{
> -	unsigned long random_factor =3D 0UL;
> -
> -	if (current->flags & PF_RANDOMIZE)
> -		random_factor =3D arch_mmap_rnd();
> -
> -	/*
> -	 * Fall back to the standard layout if the personality
> -	 * bit is set, or if the expected stack growth is unlimited:
> -	 */
> -	if (mmap_is_legacy(rlim_stack)) {
> -		mm->mmap_base =3D TASK_UNMAPPED_BASE;
> -		mm->get_unmapped_area =3D arch_get_unmapped_area;
> -	} else {
> -		mm->mmap_base =3D mmap_base(random_factor, rlim_stack);
> -		mm->get_unmapped_area =3D arch_get_unmapped_area_topdown;
> -	}
> -}
> --=20
> 2.33.1
>=20
>=20
>=20
