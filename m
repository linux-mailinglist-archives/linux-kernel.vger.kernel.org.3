Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36084573B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbiGMQme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiGMQmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:42:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291BA2E9EB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:42:30 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u13so20007438lfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8U/kpprYOiKhRtd/pitD6dzqU8q761nxCcIW1SxfQ/I=;
        b=om+4qQHrG9fC3TgF/PgRIpHyp0cIv77lO4cS+gZ7c9Djl807JiQp8cTiOOuqiBGa/Y
         SGdQWh3B4eD6KWhSc9sXrIOJ69sIe2N73ONPMD/eXmZgSKNf/8k7VrRcQAb4MpfywDZt
         wGr0INbkx/ila5QNHhqU2ilTw1UM9RkR6x0LmFZfuz/itpukhSw8NwcSfVSkgt1Y4XWS
         pCrApOIFgKCBUkOExgjeusS1GRP/ePsgi1m8OEls0tpCy65eNtMALGrhVOieFwicPo56
         ecbyq79Y9rQvkWJkyauwCGqJ+yE1srhGgrY+eLFu48Mt5has7XoQTxjqKTsndLmg3KmW
         VUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8U/kpprYOiKhRtd/pitD6dzqU8q761nxCcIW1SxfQ/I=;
        b=P8U5gN5b/Aeg/pNmPL3lY/I+CKrh+yoLRyOrwaTav7/jY0Kss0q/44DCBKPZFGsLs+
         yfc21HBvZdiYgQ+m0FNjMxJ9GW5cULry/xnYGoyhFpCsXL7L1Ns4O2+ro6MyciwGQUfz
         JJQQexYYm4gA7CGKhstVlir/qlRr1+j4h18UdEieSjwKiumikvsdnmc1JzUpaifXhKlA
         pozUSbsoKMGpdm3L88ADnnWQ+kyw0CUgb+X3YT6+HVWbG+uItZp4Nuy6Ft5fb81GEijZ
         tXCz6bcgnyrHNMP9qzNjoZLtKtNzQhK3D7tMiaawdV+h1WDELXSwSOLAMdn7PNXPhZVf
         GGBQ==
X-Gm-Message-State: AJIora8Hl7YvjN6C3+hLjBYPXI0dzAwEzfgzWImP5wSM7tpGRfyElNhc
        6xE4jjPSTewCZ8N/mAcy/GmNWTPAVJZlq3XOi2p2Pg==
X-Google-Smtp-Source: AGRyM1tl2RI3IV+VBNDQPx3uJ6naiV2PHsHydAS7JxITurhIUX48/sr1CJ5414fOVONa/KGr7l7+ObTVcWw1yBVXMpw=
X-Received: by 2002:a05:6512:1188:b0:481:2eb7:f2 with SMTP id
 g8-20020a056512118800b004812eb700f2mr2485552lfr.401.1657730548248; Wed, 13
 Jul 2022 09:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <Ys7pLq+tQk5xEa/B@dev-arch.thelio-3990X> <CAKwvOd=kqfAZoywsOFbvvzUJD+zVgFgmDAAcb7h0U8LGzfG33A@mail.gmail.com>
 <Ys7vKYJ9tyih8Cng@dev-arch.thelio-3990X> <Ys7yBcfBRWXPLsLq@hirez.programming.kicks-ass.net>
In-Reply-To: <Ys7yBcfBRWXPLsLq@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 Jul 2022 09:42:16 -0700
Message-ID: <CAKwvOdmcU3SxgMGsX4MRfR6mskYu5kPYNwUNuNLKeSeskMV5Qg@mail.gmail.com>
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

On Wed, Jul 13, 2022 at 9:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jul 13, 2022 at 09:13:29AM -0700, Nathan Chancellor wrote:
> > On Wed, Jul 13, 2022 at 09:01:58AM -0700, Nick Desaulniers wrote:
> > > On Wed, Jul 13, 2022 at 8:48 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > > >
> > > > Hi Josh and Peter,
> > > >
> > > > After commit 9bb2ec608a20 ("objtool: Update Retpoline validation") and
> > > > commit f43b9876e857 ("x86/retbleed: Add fine grained Kconfig knobs"), I
> > > > see a spew of objtool warnings when building certain configurations with
> > > > clang. Examples below, they appear to trigger in every single file.
> > > >
> > > > With x86_64_defconfig + CONFIG_KASAN=y:
> > > >
> > > > arch/x86/ia32/audit.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > > > arch/x86/ia32/audit.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > > > init/version.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > > > init/version.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > > > arch/x86/kernel/cpu/rdrand.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > > > arch/x86/kernel/cpu/rdrand.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > > > arch/x86/kernel/fpu/bugs.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > > > arch/x86/kernel/fpu/bugs.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > > > arch/x86/kernel/platform-quirks.o: warning: objtool: asan.module_ctor+0x0: 'naked' return found in RETHUNK build
> > > > init/calibrate.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
> > > > init/calibrate.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
> > > >
> > > > With x86_64_defconfig + CONFIG_KCSAN=y:
> > > >
> > > > arch/x86/ia32/audit.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > > init/calibrate.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > > init/version.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > > arch/x86/kernel/fpu/bugs.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > > arch/x86/kernel/cpu/rdrand.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > > arch/x86/events/probe.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > > > arch/x86/kernel/apic/ipi.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
> > >
> > > Thanks for the report. I wonder if this might be a compiler bug; it
> > > seems like the {a|t}san.module_{c|d}tor functions are being emitted
> > > with ret instructions?
> > >
> > > If you have one of these builds lying around still, can you provide:
> > >
> > > $ llvm-objdump -dr --disassemble-symbols=tsan.module_ctor
> > > arch/x86/kernel/fpu/bugs.o
> >
> > Sure thing.
> >
> > With KASAN:
> >
> > $ llvm-objdump -r --disassemble-symbols=asan.module_ctor,asan.module_dtor build/arch/x86/kernel/fpu/bugs.o
> >
> > build/arch/x86/kernel/fpu/bugs.o:     file format elf64-x86-64
> >
> > Disassembly of section .text.asan.module_ctor:
> >
> > 0000000000000000 <asan.module_ctor>:
> >        0: be 01 00 00 00                      movl    $1, %esi
> >        5: 48 c7 c7 00 00 00 00                movq    $0, %rdi
> >               0000000000000008:  R_X86_64_32S .data
> >        c: e8 00 00 00 00                      callq   0x11 <asan.module_ctor+0x11>
> >               000000000000000d:  R_X86_64_PLT32       __asan_register_globals-0x4
> >       11: c3                                  retq
>
> As Nick said; this should be: 'jmp __x86_return_thunk', on those builds.

https://github.com/llvm/llvm-project/issues/56514

-- 
Thanks,
~Nick Desaulniers
