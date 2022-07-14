Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB3D574087
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 02:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiGNAcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 20:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiGNAcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 20:32:12 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F4F2724
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 17:32:10 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c15so387504ljr.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 17:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cCDk/erGUZ/u3ecrMonx4NhH5B0mUzK61fX+A9ryTCk=;
        b=Yk0JHxCmlrIooUUNTioP/fV2MZjZ78FuerkvUww0uexloG8rEew+YxALiuKMABloUn
         tfLoHTMsR8xc3mzoMLJmQpi7T/QL9NQ75VNiev6g/RIqToQ0ThCYNDjaJrebH9AijJg3
         rkrePLuXKA6aOxiJi99NLPEH6Ky1qPvKKLekmjUC1FI9h4dh/1RUtKmMsubN5zgBp599
         Y2knNvawI624P/zGpkRUzR1krpw+9HJKXEfSXixJY3SmDNyecT3OtYs/z9ZLMIUwlc0e
         7rgXGyFc5jN+KU21zaODPwOdaDQ/yrOhgx5h/tpH3qeQENjU7ShEd5L/a/MKboiCPtH1
         iUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cCDk/erGUZ/u3ecrMonx4NhH5B0mUzK61fX+A9ryTCk=;
        b=qDbik5U/Hag65sdJtaoLW4ShyTzrwQ6qiqmoCypJa0+4kHAkp4K9H8aE5eYpG44ECk
         r3AMVjtuyjrqk5ggLqdAwFfJ4kA7827/G3Kai3S+Lnf9Txx+Yuu1J/fCX8fZ99bxE/rJ
         wkKUnTuPv7PifblFIV8cKXJ+LpJfXT/8rjoCVD6l9lWoXqAlDqPcXbUuyO6r7J3GwCaB
         7cC4Pb8gEQqKw0npFJjut24PoENqs2N1W+YRVWmTNtus/AMDdO4znMf78/4+Zk+X1G8F
         IEplCuIqY06JDoEuuZB6AOYf7lQvDFduOApEEb5LvngpigJoZ7eobeBRiM9QF6ckNVr0
         rNfA==
X-Gm-Message-State: AJIora/xfZKKsPgEDMNPOp26jAnc5bE6y9zx+XNJET55/lcyESq3ZZ9+
        TKBSjjV/lEPVGhk5EbbPre5Pef4G5SuBPJn0OFLQn3C1m+rs8A==
X-Google-Smtp-Source: AGRyM1vz/ABBSjz64xIakX83ArOP9lhxXGcYWppLUD4sfh3RPrMt8wAJOyfJQQZ12RT7WypMYTIYktmPyft4PpAFnBM=
X-Received: by 2002:a2e:a5cb:0:b0:25d:7a70:2891 with SMTP id
 n11-20020a2ea5cb000000b0025d7a702891mr3153421ljp.295.1657758728120; Wed, 13
 Jul 2022 17:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <Ys7pLq+tQk5xEa/B@dev-arch.thelio-3990X> <CAKwvOd=kqfAZoywsOFbvvzUJD+zVgFgmDAAcb7h0U8LGzfG33A@mail.gmail.com>
 <Ys7vKYJ9tyih8Cng@dev-arch.thelio-3990X> <Ys7yBcfBRWXPLsLq@hirez.programming.kicks-ass.net>
 <CAKwvOdmcU3SxgMGsX4MRfR6mskYu5kPYNwUNuNLKeSeskMV5Qg@mail.gmail.com> <CAKwvOdkfz9aYDb9vzdttVucJDYX+98=O58sLE+6aTmCORwX0YA@mail.gmail.com>
In-Reply-To: <CAKwvOdkfz9aYDb9vzdttVucJDYX+98=O58sLE+6aTmCORwX0YA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 Jul 2022 17:31:56 -0700
Message-ID: <CAKwvOdk+x6Mq6k4hcJSMmU7GM67bOCvW7gBGcYp47t4SJmDjxg@mail.gmail.com>
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

On Wed, Jul 13, 2022 at 3:05 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Jul 13, 2022 at 9:42 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Wed, Jul 13, 2022 at 9:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Jul 13, 2022 at 09:13:29AM -0700, Nathan Chancellor wrote:
> > > > On Wed, Jul 13, 2022 at 09:01:58AM -0700, Nick Desaulniers wrote:
> > > > > On Wed, Jul 13, 2022 at 8:48 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > > > > >
> > > > > > Hi Josh and Peter,
> > > > > >
> > > > > > After commit 9bb2ec608a20 ("objtool: Update Retpoline validation") and
> > > > > > commit f43b9876e857 ("x86/retbleed: Add fine grained Kconfig knobs"), I
> > > > > > see a spew of objtool warnings when building certain configurations with
> > > > > > clang. Examples below, they appear to trigger in every single file.
> > > > > >
> > > > > > With x86_64_defconfig + CONFIG_KASAN=y:
> > > > > >
> > > > > > arch/x86/ia32/audit.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > > > > > arch/x86/ia32/audit.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > > > > > init/version.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > > > > > init/version.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > > > > > arch/x86/kernel/cpu/rdrand.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > > > > > arch/x86/kernel/cpu/rdrand.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > > > > > arch/x86/kernel/fpu/bugs.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > > > > > arch/x86/kernel/fpu/bugs.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > > > > > arch/x86/kernel/platform-quirks.o: warning: objtool: asan.module_ctor+0x0: 'naked' return found in RETHUNK build
> > > > > > init/calibrate.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > > > > > init/calibrate.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > > > > >
> > > > > > With x86_64_defconfig + CONFIG_KCSAN=y:
> > > > > >
> > > > > > arch/x86/ia32/audit.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > > > > init/calibrate.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > > > > init/version.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > > > > arch/x86/kernel/fpu/bugs.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > > > > arch/x86/kernel/cpu/rdrand.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > > > > arch/x86/events/probe.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > > > > arch/x86/kernel/apic/ipi.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
>
> It's not just the sanitizers, `CONFIG_GCOV_KERNEL=y` +
> `CONFIG_GCOV_PROFILE_ALL=y` also has this issue:
> ```
> ...
> drivers/base/platform.o: warning: objtool: __llvm_gcov_reset+0xa94:
> 'naked' return found in RETHUNK build
> net/core/netpoll.o: warning: objtool: __llvm_gcov_reset+0xde3: 'naked'
> return found in RETHUNK build
> net/netfilter/nf_conntrack_netlink.o: warning: objtool:
> __llvm_gcov_reset+0x1b94: 'naked' return found in RETHUNK build
> fs/fs_parser.o: warning: objtool: __llvm_gcov_reset+0x344: 'naked'
> return found in RETHUNK build
> drivers/acpi/debugfs.o: warning: objtool: __llvm_gcov_reset+0xb:
> 'naked' return found in RETHUNK build
> mm/pagewalk.o: warning: objtool: __llvm_gcov_reset+0x77f: 'naked'
> return found in RETHUNK build
> drivers/tty/serial/8250/8250_pnp.o: warning: objtool:
> __llvm_gcov_reset+0x231: 'naked' return found in RETHUNK build
> fs/init.o: warning: objtool: __llvm_gcov_reset+0x2f7: 'naked' return
> found in RETHUNK build
> drivers/gpu/drm/drm_fourcc.o: warning: objtool:
> __llvm_gcov_reset+0x1ce: 'naked' return found in RETHUNK build
> ...
> ```

https://reviews.llvm.org/D129709

>
> > > > >
> > > > > Thanks for the report. I wonder if this might be a compiler bug; it
> > > > > seems like the {a|t}san.module_{c|d}tor functions are being emitted
> > > > > with ret instructions?
> > > > >
> > > > > If you have one of these builds lying around still, can you provide:
> > > > >
> > > > > $ llvm-objdump -dr --disassemble-symbols=tsan.module_ctor
> > > > > arch/x86/kernel/fpu/bugs.o
> > > >
> > > > Sure thing.
> > > >
> > > > With KASAN:
> > > >
> > > > $ llvm-objdump -r --disassemble-symbols=asan.module_ctor,asan.module_dtor build/arch/x86/kernel/fpu/bugs.o
> > > >
> > > > build/arch/x86/kernel/fpu/bugs.o:     file format elf64-x86-64
> > > >
> > > > Disassembly of section .text.asan.module_ctor:
> > > >
> > > > 0000000000000000 <asan.module_ctor>:
> > > >        0: be 01 00 00 00                      movl    $1, %esi
> > > >        5: 48 c7 c7 00 00 00 00                movq    $0, %rdi
> > > >               0000000000000008:  R_X86_64_32S .data
> > > >        c: e8 00 00 00 00                      callq   0x11 <asan.module_ctor+0x11>
> > > >               000000000000000d:  R_X86_64_PLT32       __asan_register_globals-0x4
> > > >       11: c3                                  retq
> > >
> > > As Nick said; this should be: 'jmp __x86_return_thunk', on those builds.
> >
> > https://github.com/llvm/llvm-project/issues/56514
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
