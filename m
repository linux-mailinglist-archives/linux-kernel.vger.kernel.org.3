Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8734ACF7E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 04:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346066AbiBHDJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 22:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238531AbiBHDJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 22:09:35 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E9AC061A73
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 19:09:34 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso980649pjg.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 19:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MHD6q+Bg1CAZFEstaZFHsulOzcBrpeMzXQI3VG7uoNM=;
        b=XJRcGlNT0cBC2DmG39HOUGpo9qN5/1Cz3pdW6NxY6e/wELu6IC29R0W/n3DdG6Kc8s
         YnyWU10ZuVrBs1aFfIiLaun5+HIaEKTMS+fp5dQEZCOuiYAa4fcJg+XaX9aoducLDvRz
         IKMl9X7l6jvykRysYNEIixCpuActzIJVqC6I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MHD6q+Bg1CAZFEstaZFHsulOzcBrpeMzXQI3VG7uoNM=;
        b=AkzMWzdfivFmn3ufpfYlvtL87qz+n4Mt5vujYEUiz4/H8pzC3MENRholBCcQvRAKZ+
         B5gLlRpRy2tyx7s96RWf28jLD0UQ91PQL1LOmVeiE0f5/J8rD7BRXtUKXem8rD1VSDbG
         o26IjNVkyVa/UXdOUwzwwaihkvEab3W5uxrMGIs5vMwKP0MCBFfq1yUQz414dv4oVZQ5
         BIzx4B32qV/JD68MThDlAROIVe4eKy1pldJ0fAAfy+QS2uQNabfIaJvoTO3DI5i+GqWR
         qgav9DX44UilmgoajWOhldc4KXLuRR/c36P9qWxCqjoplg6CwBj4mfp0PWuBdCQ7JEAQ
         xwgg==
X-Gm-Message-State: AOAM533uvh8qtCuZTrW7IBO1dlC+K7tYY8Xpbd84QHmabQ7bK0fCfJ3r
        5MtvDdb1qAoA2sSXZ993VYGe1Q==
X-Google-Smtp-Source: ABdhPJzLkZBnlG17z1SKnOBJtO48AA5tnV6wY4N8E4knuC0jCuJMbcSKNnSJbDaVwVOpDPLET8djog==
X-Received: by 2002:a17:902:f70c:: with SMTP id h12mr2557265plo.53.1644289774153;
        Mon, 07 Feb 2022 19:09:34 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n13sm10099487pfv.212.2022.02.07.19.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 19:09:33 -0800 (PST)
Date:   Mon, 7 Feb 2022 19:09:32 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Fangrui Song <maskray@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, kernel test robot <oliver.sang@intel.com>
Subject: Re: [x86] 1099ce55b0: BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202202071858.0B5538E7CB@keescook>
References: <20220204123740.GA4077@xsang-OptiPlex-9020>
 <CAKwvOdm0+bB=UY91V=ai2TPg3XCbNUZQfBzxrSUA0AtW=zM=LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm0+bB=UY91V=ai2TPg3XCbNUZQfBzxrSUA0AtW=zM=LA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 04:23:06PM -0800, Nick Desaulniers wrote:
> On Fri, Feb 4, 2022 at 4:37 AM kernel test robot <oliver.sang@intel.com> wrote:
> > FYI, we noticed the following commit (built with clang-15):
> >
> > commit: 1099ce55b0530ff429312dc37362ad43aee8c5c0 ("x86: don't build CONFIG_X86_32 as -ffreestanding")
> > https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git for-next/memcpy
> >
> > in testcase: boot
> [...]
> I've been having a hard time pinpointing via bisection when this
> stopped working.  I suspect it's actually the change on llvm's side
> that would replace memcmp with bcmp.  With this diff, we can boot
> ARCH=i386 defconfig

Thanks for spending the time on this!

> 
> ```
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 7ef211865239..5e4570495206 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -88,6 +88,8 @@ ifeq ($(CONFIG_X86_32),y)
>          include $(srctree)/arch/x86/Makefile_32.cpu
>          KBUILD_CFLAGS += $(cflags-y)
> 
> +        KBUILD_CFLAGS += -fno-builtin-bcmp
> +
>         ifeq ($(CONFIG_STACKPROTECTOR),y)
>                 ifeq ($(CONFIG_SMP),y)
>                         KBUILD_CFLAGS +=
> -mstack-protector-guard-reg=fs
> -mstack-protector-guard-symbol=__stack_chk_guard
> ```
> 
> It looks like the call argument setup in the _callers_ of memcmp is messed up.
> 
> Before:
> pushl %ecx
> pushl %ebx
> pushl -24(%ebp)
> calll bcmp
> 
> After:
> movl  %ebx, %eax
> movl  %esi, %edx
> movl  %ecx, %ebx
> calll memcmp
> 
> it looks like they're not obeying `-mregparm=3`.
> 
> https://godbolt.org/z/z3fjveP4h
> 
> Diffing the IR between `-mregparm=3` vs not, it looks like there's an
> LLVM IR function argument attribute inreg.
> https://llvm.org/docs/LangRef.html#parameter-attributes
> >> This indicates that this parameter or return value should be treated in a
> >> special target-dependent fashion while emitting code for a function call
> >> or return (usually, by putting it in a register as opposed to memory,
> >> though some targets use it to distinguish between two different kinds of
> >> registers). Use of this attribute is target-specific.
> 
> As is tradition, instcombine is not checking+carrying over the
> function argument attributes when replacing calls to memcmp w/ bcmp.
> 
> Before:
>   %4 = call i32 @memcmp(i8* inreg noundef %3, i8* inreg noundef %0,
> i32 inreg noundef %1) #4, !dbg !22
> 
> After:
>   %bcmp = call i32 @bcmp(i8* %3, i8* %0, i32 %1), !dbg !22
> 
> Filed:
> https://github.com/llvm/llvm-project/issues/53645
> 
> So I think the best course of action is to disable memcmp to bcmp
> BEFORE the removal of -ffreestanding, and only for clang until we have
> a fix in hand.

What do you mean about BEFORE the removal of -ffreestanding? As in, add
two patches, one to add -fno-builtin-bcmp and the next to remove
-ffreestanding? i.e.:


diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index e84cdd409b64..c92f69e916b4 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -90,6 +90,9 @@ ifeq ($(CONFIG_X86_32),y)
 
         # temporary until string.h is fixed
         KBUILD_CFLAGS += -ffreestanding
+        ifdef CONFIG_CC_IS_CLANG
+                KBUILD_CFLAGS += -fno-builtin-bcmp
+        endif
 
 	ifeq ($(CONFIG_STACKPROTECTOR),y)
 		ifeq ($(CONFIG_SMP),y)


then:



diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index c92f69e916b4..f56936aeed9e 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -88,8 +88,6 @@ ifeq ($(CONFIG_X86_32),y)
         include $(srctree)/arch/x86/Makefile_32.cpu
         KBUILD_CFLAGS += $(cflags-y)
 
-        # temporary until string.h is fixed
-        KBUILD_CFLAGS += -ffreestanding
         ifdef CONFIG_CC_IS_CLANG
                 KBUILD_CFLAGS += -fno-builtin-bcmp
         endif

?

-- 
Kees Cook
