Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7746B573F61
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbiGMWFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbiGMWFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:05:46 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9482845049
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:05:45 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z25so21342848lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CVPURYDSdi9kkIBxu2J8OfzWwrMxbZ9TkMBa/yDaqbI=;
        b=LGx/babJfl+Y6xdyF7x7eVHkVsNPeGrKZXB/vlSpnRKiFwIEbEdT+om3gcdVShfutk
         ttzO/XQ7XccC/2fi6sSjNVa0/LRMuMIhuB3lBZsrUPOx7DOQocrpDdPkr9+woi/7yaUE
         iwGmpJYPewHHHKgAJNhl3WHWmBurU4N4+GfNeCPrNcT+5xEyqMjTWgEmu93skeXa21Ni
         J0nJpw5UIwPvM7FnfmHvJTo92zviDVIQ9fmLTjyK3trz8Bfu4ibZH3u3YNBxSf+RFoDf
         CvJD0c8F6WACY4CHiJ2Y+CsOT8lT8yIiiCxG37ojl5JAqpRSvgVr9yagvllN/ZtSvLfx
         2ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CVPURYDSdi9kkIBxu2J8OfzWwrMxbZ9TkMBa/yDaqbI=;
        b=1a3G6rqTQojITKQIbUKfGrXv7C00WfoAOcQC+Dk0bLlIGdHg6jM1FPRgNKCN4QDcQV
         MOoDpaPggbrrwcmteCYLyvVx9BM5a4sgNv0ZjH1qkGFonejUiBn90jp025xCdDHzEt+o
         91oIO/e/cejd+6vTlhHdBhT9+fBHeyMlZqXq6om/obXCGN9/vpHXCkqdrSFzyojASLbd
         hwnZ2FeCvUmiHj3EMBKP/8Hq+XrWlZqpUftMC3ySvPhGAiaMaTcfTHrm7K+9QaEx64vQ
         mycnYd5Rq4O+LSWqhfsNx4ROXCCWdFlsH7gnckP4rQhN0dcM20Si0CIgEyPkFhlWhBU6
         xSeQ==
X-Gm-Message-State: AJIora9k09cHxBi+RMlYp8FFvTBUKnJtZRWhAIqye395iatSz3plqC3g
        /Tt7KfEFhULfqIs6X/Y2zTvNJ0puD9eiGZV+MLX0uZ0jDYBj+w==
X-Google-Smtp-Source: AGRyM1u+R0H25ckFnrRFa69dJVpugjvCWY4ydQDn4vkcqRK09kVCwM2Gdokbj5tZpUcNzgLnQdvki6JctOr42JiEl60=
X-Received: by 2002:a05:6512:e83:b0:489:c6fe:e121 with SMTP id
 bi3-20020a0565120e8300b00489c6fee121mr3227885lfb.100.1657749943665; Wed, 13
 Jul 2022 15:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <Ys7pLq+tQk5xEa/B@dev-arch.thelio-3990X> <CAKwvOd=kqfAZoywsOFbvvzUJD+zVgFgmDAAcb7h0U8LGzfG33A@mail.gmail.com>
 <Ys7vKYJ9tyih8Cng@dev-arch.thelio-3990X> <Ys7yBcfBRWXPLsLq@hirez.programming.kicks-ass.net>
 <CAKwvOdmcU3SxgMGsX4MRfR6mskYu5kPYNwUNuNLKeSeskMV5Qg@mail.gmail.com>
In-Reply-To: <CAKwvOdmcU3SxgMGsX4MRfR6mskYu5kPYNwUNuNLKeSeskMV5Qg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 Jul 2022 15:05:32 -0700
Message-ID: <CAKwvOdkfz9aYDb9vzdttVucJDYX+98=O58sLE+6aTmCORwX0YA@mail.gmail.com>
Subject: Re: objtool "'naked' return found in RETHUNK build" with clang + CONFIG_K{A,C}SAN=y
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>
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

On Wed, Jul 13, 2022 at 9:42 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Jul 13, 2022 at 9:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Jul 13, 2022 at 09:13:29AM -0700, Nathan Chancellor wrote:
> > > On Wed, Jul 13, 2022 at 09:01:58AM -0700, Nick Desaulniers wrote:
> > > > On Wed, Jul 13, 2022 at 8:48 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > > > >
> > > > > Hi Josh and Peter,
> > > > >
> > > > > After commit 9bb2ec608a20 ("objtool: Update Retpoline validation") and
> > > > > commit f43b9876e857 ("x86/retbleed: Add fine grained Kconfig knobs"), I
> > > > > see a spew of objtool warnings when building certain configurations with
> > > > > clang. Examples below, they appear to trigger in every single file.
> > > > >
> > > > > With x86_64_defconfig + CONFIG_KASAN=y:
> > > > >
> > > > > arch/x86/ia32/audit.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > > > > arch/x86/ia32/audit.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > > > > init/version.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > > > > init/version.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > > > > arch/x86/kernel/cpu/rdrand.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > > > > arch/x86/kernel/cpu/rdrand.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > > > > arch/x86/kernel/fpu/bugs.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > > > > arch/x86/kernel/fpu/bugs.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > > > > arch/x86/kernel/platform-quirks.o: warning: objtool: asan.module_ctor+0x0: 'naked' return found in RETHUNK build
> > > > > init/calibrate.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > > > > init/calibrate.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > > > >
> > > > > With x86_64_defconfig + CONFIG_KCSAN=y:
> > > > >
> > > > > arch/x86/ia32/audit.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > > > init/calibrate.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > > > init/version.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > > > arch/x86/kernel/fpu/bugs.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > > > arch/x86/kernel/cpu/rdrand.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > > > arch/x86/events/probe.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > > > arch/x86/kernel/apic/ipi.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build

It's not just the sanitizers, `CONFIG_GCOV_KERNEL=y` +
`CONFIG_GCOV_PROFILE_ALL=y` also has this issue:
```
...
drivers/base/platform.o: warning: objtool: __llvm_gcov_reset+0xa94:
'naked' return found in RETHUNK build
net/core/netpoll.o: warning: objtool: __llvm_gcov_reset+0xde3: 'naked'
return found in RETHUNK build
net/netfilter/nf_conntrack_netlink.o: warning: objtool:
__llvm_gcov_reset+0x1b94: 'naked' return found in RETHUNK build
fs/fs_parser.o: warning: objtool: __llvm_gcov_reset+0x344: 'naked'
return found in RETHUNK build
drivers/acpi/debugfs.o: warning: objtool: __llvm_gcov_reset+0xb:
'naked' return found in RETHUNK build
mm/pagewalk.o: warning: objtool: __llvm_gcov_reset+0x77f: 'naked'
return found in RETHUNK build
drivers/tty/serial/8250/8250_pnp.o: warning: objtool:
__llvm_gcov_reset+0x231: 'naked' return found in RETHUNK build
fs/init.o: warning: objtool: __llvm_gcov_reset+0x2f7: 'naked' return
found in RETHUNK build
drivers/gpu/drm/drm_fourcc.o: warning: objtool:
__llvm_gcov_reset+0x1ce: 'naked' return found in RETHUNK build
...
```

> > > >
> > > > Thanks for the report. I wonder if this might be a compiler bug; it
> > > > seems like the {a|t}san.module_{c|d}tor functions are being emitted
> > > > with ret instructions?
> > > >
> > > > If you have one of these builds lying around still, can you provide:
> > > >
> > > > $ llvm-objdump -dr --disassemble-symbols=tsan.module_ctor
> > > > arch/x86/kernel/fpu/bugs.o
> > >
> > > Sure thing.
> > >
> > > With KASAN:
> > >
> > > $ llvm-objdump -r --disassemble-symbols=asan.module_ctor,asan.module_dtor build/arch/x86/kernel/fpu/bugs.o
> > >
> > > build/arch/x86/kernel/fpu/bugs.o:     file format elf64-x86-64
> > >
> > > Disassembly of section .text.asan.module_ctor:
> > >
> > > 0000000000000000 <asan.module_ctor>:
> > >        0: be 01 00 00 00                      movl    $1, %esi
> > >        5: 48 c7 c7 00 00 00 00                movq    $0, %rdi
> > >               0000000000000008:  R_X86_64_32S .data
> > >        c: e8 00 00 00 00                      callq   0x11 <asan.module_ctor+0x11>
> > >               000000000000000d:  R_X86_64_PLT32       __asan_register_globals-0x4
> > >       11: c3                                  retq
> >
> > As Nick said; this should be: 'jmp __x86_return_thunk', on those builds.
>
> https://github.com/llvm/llvm-project/issues/56514
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
