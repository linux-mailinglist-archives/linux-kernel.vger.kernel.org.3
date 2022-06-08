Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64642543F03
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 00:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbiFHWM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 18:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiFHWMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 18:12:24 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B391DB1D0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 15:12:22 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q1so24217617ljb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 15:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=si2+VHD/m8K45LSNp+CHy2tMwu+ooVIDNxOew95hfY0=;
        b=rsJJepFZ7Vyj+B/vp/jZJ4mBzRoA92lnZrSAl1IooOs6Y7spyJ/Zqg3Vbs8E1mtCaP
         GgLDRa9haamlTeHg3mUcvgIXDyPafeZihReu0luvOIVZvwuoYNG/H3hDYrJt+BMlZ8bX
         Xb2GxbWoZQw2MSodDVyoi+Q0B7aeNS+TD5NGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=si2+VHD/m8K45LSNp+CHy2tMwu+ooVIDNxOew95hfY0=;
        b=j0eOjZGyVvZRiCq0g9R9/zKrXLeSxv406kUbwaxTkpWRE/RT6DBW/afKuJEfG9D91Y
         Zc7654SC8rxRtrXqNwvVAfoA7fXmsDw45MHXkRlUMVsHwWzr3NBqIEFZO3ka5+xrLPec
         EXEAz/e7cgmM7sjEiws+Cv3g8tNN2LwDh8ZksWOjwUg4LcdvUbVZi2eTzQv1zTmg+Hl7
         oQNAhPURIuYAFH5XGahBDG/vxP4ZTPs2CEeaasDPNhsd8Zs5mCyObintDh9WvpvrC5il
         Yt+I2USqKzzhHBq8uFmBxjEuCTlP8zN8aSKTcWJLU66evvUIjv9EK/+Gp9AbYoCPYjvm
         Yz+A==
X-Gm-Message-State: AOAM532xrH2HWzqk6y3tsVRmT1fbVLuTTv1HVaKtzWhjPv6dCCvNUcs/
        eqGP8m/hEFwR4KnhDBdAObv9wq8/Dp9O13kYO+lt3A==
X-Google-Smtp-Source: ABdhPJxKd4NrcWkzr2nyaoIiDRVYUOaMwtmMC4FuaXd84p6YL0OJHVlKkP+3ixzrZ8NcGlDOW3KkLRPdEEZvM6xVU7c=
X-Received: by 2002:a2e:22c4:0:b0:255:997a:e952 with SMTP id
 i187-20020a2e22c4000000b00255997ae952mr9783301lji.252.1654726340154; Wed, 08
 Jun 2022 15:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <a802eefebee4d2c01f479a7d3f2008fdd32ce270.1654702810.git.jpoimboe@kernel.org>
In-Reply-To: <a802eefebee4d2c01f479a7d3f2008fdd32ce270.1654702810.git.jpoimboe@kernel.org>
From:   Joe Damato <jdamato@fastly.com>
Date:   Thu, 9 Jun 2022 01:12:09 +0300
Message-ID: <CALALjgy6=Ebi-k-YrSsEozW3Yy4KJGWLiH_5M8i4neEd9ozj_A@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Fix RESERVE_BRK() for older binutils
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        jiangshanlai@gmail.com, bp@suse.de, brgerst@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 08:40:42AM -0700, Josh Poimboeuf wrote:
> With binutils 2.26, RESERVE_BRK() causes a build failure:
>
>   /tmp/ccnGOKZ5.s: Assembler messages:
>   /tmp/ccnGOKZ5.s:98: Error: missing ')'
>   /tmp/ccnGOKZ5.s:98: Error: missing ')'
>   /tmp/ccnGOKZ5.s:98: Error: missing ')'
>   /tmp/ccnGOKZ5.s:98: Error: junk at end of line, first unrecognized
>   character is `U'
>
> The problem is this line:
>
>   RESERVE_BRK(early_pgt_alloc, INIT_PGT_BUF_SIZE)
>
> Specifically, the INIT_PGT_BUF_SIZE macro which (via PAGE_SIZE's use
> _AC()) has a "1UL", which makes older versions of the assembler unhappy.
> Unfortunately the _AC() macro doesn't work for inline asm.
>
> Fix it (and further simplify RESERVE_BRK) by taking a completely
> different approach.  Instead of specifying the "nobits" at compile-time,
> do so at link-time.  Then the variable can just be allocated in C.
>
> Note this changes the name of the variable from .brk.##name to
> __brk_##name.  The variable names aren't actually used anywhere, so it's
> harmless.
>
> Reported-by: Joe Damato <jdamato@fastly.com>
> Fixes: a1e2c031ec39 ("x86/mm: Simplify RESERVE_BRK()")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/x86/include/asm/setup.h  | 35 +++++++++++++++++------------------
>  arch/x86/kernel/vmlinux.lds.S |  2 +-
>  2 files changed, 18 insertions(+), 19 deletions(-)
>
> diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
> index 7590ac2570b9..ef9bb6caad8c 100644
> --- a/arch/x86/include/asm/setup.h
> +++ b/arch/x86/include/asm/setup.h
> @@ -108,19 +108,11 @@ extern unsigned long _brk_end;
>  void *extend_brk(size_t size, size_t align);
>
>  /*
> - * Reserve space in the brk section.  The name must be unique within the file,
> - * and somewhat descriptive.  The size is in bytes.
> - *
> - * The allocation is done using inline asm (rather than using a section
> - * attribute on a normal variable) in order to allow the use of @nobits, so
> - * that it doesn't take up any space in the vmlinux file.
> + * Reserve space in the .brk section.  The size is in bytes.
>   */
> -#define RESERVE_BRK(name, size)                                              \
> -     asm(".pushsection .brk_reservation,\"aw\",@nobits\n\t"          \
> -         ".brk." #name ":\n\t"                                       \
> -         ".skip " __stringify(size) "\n\t"                           \
> -         ".size .brk." #name ", " __stringify(size) "\n\t"           \
> -         ".popsection\n\t")
> +#define RESERVE_BRK(name, size)                                      \
> +     __section(".brk_reservation") __aligned(1) __used       \
> +     static char __brk_##name[size]
>
>  extern void probe_roms(void);
>  #ifdef __i386__
> @@ -133,12 +125,19 @@ asmlinkage void __init x86_64_start_reservations(char *real_mode_data);
>
>  #endif /* __i386__ */
>  #endif /* _SETUP */
> -#else
> -#define RESERVE_BRK(name,sz)                         \
> -     .pushsection .brk_reservation,"aw",@nobits;     \
> -.brk.name:                                           \
> -1:   .skip sz;                                       \
> -     .size .brk.name,.-1b;                           \
> +
> +#else  /* __ASSEMBLY */
> +
> +.macro __RESERVE_BRK name, size
> +     .pushsection .brk_reservation, "aw"
> +SYM_DATA_START(__brk_\name)
> +     .skip \size
> +SYM_DATA_END(__brk_\name)
>       .popsection
> +.endm
> +
> +#define RESERVE_BRK(name, size) __RESERVE_BRK name, size
> +
>  #endif /* __ASSEMBLY__ */
> +
>  #endif /* _ASM_X86_SETUP_H */
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index f5f6dc2e8007..9b63f8a00b4f 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -385,7 +385,7 @@ SECTIONS
>       __end_of_kernel_reserve = .;
>
>       . = ALIGN(PAGE_SIZE);
> -     .brk : AT(ADDR(.brk) - LOAD_OFFSET) {
> +     .brk (NOLOAD) : AT(ADDR(.brk) - LOAD_OFFSET) {
>               __brk_base = .;
>               . += 64 * 1024;         /* 64k alignment slop space */
>               *(.brk_reservation)     /* areas brk users have reserved */
> --
> 2.34.3
>

I applied the patch on top of commit 58f9d52ff689 ("Merge tag
'net-5.19-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net") and the kernel
now builds successfully for me.

The resulting kernel boots fine on the machine, as well.

Tested-by: Joe Damato <jdamato@fastly.com>
