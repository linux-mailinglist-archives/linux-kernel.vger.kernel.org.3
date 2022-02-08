Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759604AE1DA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385784AbiBHTDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385768AbiBHTD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:03:29 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9FAC0612C0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:03:28 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id x3so172346pll.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 11:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IrUFFmu7diX45k+HZcIAj+7gcRPvHdpeoaLjjT09/58=;
        b=gSoiRyt1p670lrL+pWigcwHORjHeA+doJG5FiYljuWZyuRyjyDSV4mHj9/12U+mVhJ
         yHZUw/N4XzypQZPwZBZ2Be4tcO9isdgwhT/qnqVEUaOx82ZlG+CVkI+tiLzLUet56ajI
         +a0XQgbrndG+tLGio0yaamVCrcs9jiyXysI8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IrUFFmu7diX45k+HZcIAj+7gcRPvHdpeoaLjjT09/58=;
        b=YfL5tAdx7HrD2fjqF4PM4QxgPCKjGRlsORypiqfjIRbxVKt7NUSeCnsGOaPPUGEVnf
         JGzoB0dvgVxl0LWv+pk159ayDk44I1P58WMmZUWS8jJy7vl1v60u8+JPbZRn/QqrgR+w
         YVNuPU92mYLgXT8GHIWbIMVRo2UEYYRDFWCX1C9bCdeA5cZWEU9WTdw1ZqTBbQ2yAWfz
         NAnwuaKeH5IUNSO2KXHiv4LH5i/rYP/S7x7mYUqz/+rmZnwr/DPdHcy60oBmPnMVfzrt
         BvIgevS5uKexAIKjY/OGygD3sHAx42mSORXGLXJypgExAkfUuSOk9fYdp89O7Xa/KqSF
         b4yw==
X-Gm-Message-State: AOAM5323iNgfPqh+fZeoNuLGCcx1qcTlJxn7dGjRqk2Du8M5xjXcpr0O
        sx1zyHFuOp+YxIZm+BdljEAgvw==
X-Google-Smtp-Source: ABdhPJy/v9VJlDF8sP6ji14+GUX0A1roKV7ALsFK9xZHw98cwWWg65GF3OQQk58kg0Rp4/kXVxt+hw==
X-Received: by 2002:a17:902:d484:: with SMTP id c4mr6003106plg.106.1644347007742;
        Tue, 08 Feb 2022 11:03:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h3sm15436341pfo.66.2022.02.08.11.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:03:27 -0800 (PST)
Date:   Tue, 8 Feb 2022 11:03:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Fangrui Song <maskray@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, kernel test robot <oliver.sang@intel.com>
Subject: Re: [x86] 1099ce55b0: BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202202081100.8A27D97@keescook>
References: <20220204123740.GA4077@xsang-OptiPlex-9020>
 <CAKwvOdm0+bB=UY91V=ai2TPg3XCbNUZQfBzxrSUA0AtW=zM=LA@mail.gmail.com>
 <202202071858.0B5538E7CB@keescook>
 <CAKwvOdm1k51OxYqSq1v9UVp8ZptBkJj7FgOA_QhDjEC6vaU+RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm1k51OxYqSq1v9UVp8ZptBkJj7FgOA_QhDjEC6vaU+RQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 09:44:48AM -0800, Nick Desaulniers wrote:
> On Mon, Feb 7, 2022 at 7:09 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Feb 07, 2022 at 04:23:06PM -0800, Nick Desaulniers wrote:
> > > On Fri, Feb 4, 2022 at 4:37 AM kernel test robot <oliver.sang@intel.com> wrote:
> > > > FYI, we noticed the following commit (built with clang-15):
> > > >
> > > > commit: 1099ce55b0530ff429312dc37362ad43aee8c5c0 ("x86: don't build CONFIG_X86_32 as -ffreestanding")
> > > > https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git for-next/memcpy
> > > >
> > > > in testcase: boot
> > > [...]
> > > I've been having a hard time pinpointing via bisection when this
> > > stopped working.  I suspect it's actually the change on llvm's side
> > > that would replace memcmp with bcmp.  With this diff, we can boot
> > > ARCH=i386 defconfig
> > >
> > > ```
> > > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > > index 7ef211865239..5e4570495206 100644
> > > --- a/arch/x86/Makefile
> > > +++ b/arch/x86/Makefile
> > > @@ -88,6 +88,8 @@ ifeq ($(CONFIG_X86_32),y)
> > >          include $(srctree)/arch/x86/Makefile_32.cpu
> > >          KBUILD_CFLAGS += $(cflags-y)
> > >
> > > +        KBUILD_CFLAGS += -fno-builtin-bcmp
> > > +
> > >         ifeq ($(CONFIG_STACKPROTECTOR),y)
> > >                 ifeq ($(CONFIG_SMP),y)
> > >                         KBUILD_CFLAGS +=
> > > -mstack-protector-guard-reg=fs
> > > -mstack-protector-guard-symbol=__stack_chk_guard
> > > ```
> > >
> > > It looks like the call argument setup in the _callers_ of memcmp is messed up.
> > >
> > > Before:
> > > pushl %ecx
> > > pushl %ebx
> > > pushl -24(%ebp)
> > > calll bcmp
> > >
> > > After:
> > > movl  %ebx, %eax
> > > movl  %esi, %edx
> > > movl  %ecx, %ebx
> > > calll memcmp
> > >
> > > it looks like they're not obeying `-mregparm=3`.
> > >
> > > https://godbolt.org/z/z3fjveP4h
> > >
> > > Diffing the IR between `-mregparm=3` vs not, it looks like there's an
> > > LLVM IR function argument attribute inreg.
> > > https://llvm.org/docs/LangRef.html#parameter-attributes
> > > >> This indicates that this parameter or return value should be treated in a
> > > >> special target-dependent fashion while emitting code for a function call
> > > >> or return (usually, by putting it in a register as opposed to memory,
> > > >> though some targets use it to distinguish between two different kinds of
> > > >> registers). Use of this attribute is target-specific.
> > >
> > > As is tradition, instcombine is not checking+carrying over the
> > > function argument attributes when replacing calls to memcmp w/ bcmp.
> > >
> > > Before:
> > >   %4 = call i32 @memcmp(i8* inreg noundef %3, i8* inreg noundef %0,
> > > i32 inreg noundef %1) #4, !dbg !22
> > >
> > > After:
> > >   %bcmp = call i32 @bcmp(i8* %3, i8* %0, i32 %1), !dbg !22
> > >
> > > Filed:
> > > https://github.com/llvm/llvm-project/issues/53645
> > [...]
> 
> Yeah, that's what I had in mind yesterday afternoon. Thinking more
> about this in the evening though, I think this is a pretty
> catastrophic compiler bug in LLVM.
> 
> The compiler does change the calling convention (somewhat) as part of
> optimizations when the caller and callee are visible within the same
> TU. Here, the callee is not visible, and yet the caller is modifying
> the calling convention with no corresponding change to the callee.
> 
> Essentially, -ffreestanding is holding -mregparam=3 together for
> ARCH=i386 LLVM=1 builds.  That my above diff that only avoided the
> issue for memcmp -> bcmp was able to boot to command line is kind of a
> miracle.  I'm sure there's all kind of things that don't work right,
> and we can't ship that since it will come back to bite us for 32b x86
> (such as Android Cuttlefish).
> 
> Do we need to remove -ffreestanding for ARCH=i386 for FORTIFY_SOURCE
> to work _for GCC_?

Nope!

> If yes, then perhaps we can only add -ffreestanding for clang for now?
> If no, then perhaps we should leave -ffreestanding for now?

i.e. disable FORTIFY on Clang+i386? Ok.

> Either way, I would shelve FORTIFY_SOURCE for ARCH=i386 LLVM=1 until
> this compiler bug is fixed (and drop my patch, or I can send a v2).
> https://github.com/llvm/llvm-project/issues/53645

I'm fine with that. I can't imagine the combination of
i386+Clang+FORTIFY being in high demand.

> That said, I would consider this lower priority than
> https://github.com/llvm/llvm-project/issues/53118, which looks like a
> very obvious clang-14 regression (the 14 release is almost done, so
> it's time to fix regression NOW) that produces an true positive
> objtool warning.

+1

I will adjust my series...

-- 
Kees Cook
