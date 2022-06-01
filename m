Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8733253A590
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353053AbiFAM5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiFAM5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:57:47 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9162811162
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:57:46 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j7so1948629pjn.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 05:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AcIRtYOJLSzuRssnzfJVtzfKr0+ChYvv9prLqxP1I5s=;
        b=SHG1oE1XEAyxFt4cAXfSoE6o/bWFzDd/edK/hX6u++QQo03OWJbzt1GeJ6ZQgPLuLM
         O4ei4bnaUbGd5Lnm9Vh13w/UXIpVvS4WeyN38CKwCoj/PWRePXFUL+fmShT+10iLe9iF
         U7WFyhysCzd86F38KgNlEyf2tluDtZtrmVun+VQ33hkxRjnFMNc8bANmIYLa4jzmMDCm
         TIyvtRlhjbgt8TJm7R+xqZUZrf3pF6cWtyVUSvyf39DcGIv7JPEWKrC1KRxhoJRDexk0
         IhUFvISrdcLrAVMOrdsRsvB7C/Fkh9FDihpq/em2XdPmc9pE5bztazD5X+sYIcCITRKt
         6ehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AcIRtYOJLSzuRssnzfJVtzfKr0+ChYvv9prLqxP1I5s=;
        b=yDzwp93H3UfLmH3270QaT3gzaf+brOxS66fk5M5TKyY1ePyzfscjc0PVr0/eJD4u/q
         8oXq5j6kM8ct23b6LLF/QCUrX1o5Yykfq7FpuQI0KWQOuyCJnh4fEaWqlkSTYoOAcW4m
         IXwEs16y5ABvwqVr2OTvgxyEEAf5VMOywEX8zjT0TnS1xTY6JmvR1Wek2EpNenfSP45V
         /1uJJXzCsDSMIGqrkkN9NK92H2nS2rayZ6PnCIdZlmNLnPhXMtDxbq+31U3kCbzccM1v
         Xnj5xrmrY7m+ecBVBsCRogKJ6Ow4XyeUsGoVkoPaRsi/WRUMBpXp+lL+fM2urcwt6Pw6
         HV6w==
X-Gm-Message-State: AOAM532s4K7deOgtwXqH1cAvWrjDxAfigI/Y6MqrW4iLKyjECcNcuNNF
        x2N1KQ4TCYiv1N+NXZRBvS1h6374zGllht1t4GqzZDTOnOk=
X-Google-Smtp-Source: ABdhPJyR/n91fsUDJNMDgnHO3eQR32QRPYx6OFVi00/UExDKCU6gtw59Aap5tc4DOA+AYngA1fBkhDDQyyQCMLyTpbM=
X-Received: by 2002:a17:902:bf4c:b0:15c:3d1b:8a47 with SMTP id
 u12-20020a170902bf4c00b0015c3d1b8a47mr68608437pls.118.1654088265704; Wed, 01
 Jun 2022 05:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAEQFVGZ=6K8wudbS--3z+JpKTsL_dfM-8Co7NwViRo0i3t2EZg@mail.gmail.com>
 <Ym2qdHAB6BMMlegB@thelio-3990X> <CAEQFVGZB6eAetmt1kk+TYbGxpfrDut37DEO_-1HECqM6FEERww@mail.gmail.com>
 <CAEQFVGby3Q1mf1GGJwkFyAgaq38NvVAMx6tQM+9LO+HE8Z8Z8A@mail.gmail.com>
 <YnhbOpXHT8k+g9Qu@dev-arch.thelio-3990X> <CAEQFVGYSV=boBYGHfJLis8ayftzNPJy1UYgeEEQLuNb0hSfhjg@mail.gmail.com>
 <CAKwvOd=c=9xbzg0CjGxNnHtu3BOatWpe0gYQU7TWw0rkjwCCxA@mail.gmail.com>
In-Reply-To: <CAKwvOd=c=9xbzg0CjGxNnHtu3BOatWpe0gYQU7TWw0rkjwCCxA@mail.gmail.com>
From:   Mauro Rossi <issor.oruam@gmail.com>
Date:   Wed, 1 Jun 2022 14:57:34 +0200
Message-ID: <CAEQFVGYOkTi4oNSnfyN48Re_4uhQqPF81+M7Xd5VJ0+tETwSbA@mail.gmail.com>
Subject: Re: arch/x86/entry/entry: RFC on recent kernels building error with
 llvm 11.0.2 internal assembler
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, luto@kernel.org,
        Chih-Wei Huang <cwhuang@android-x86.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
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

On Wed, Jun 1, 2022 at 12:09 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, May 29, 2022 at 10:52 AM Mauro Rossi <issor.oruam@gmail.com> wrote:
> >
> >
> >
> > On Mon, May 9, 2022 at 2:07 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >>
> >> On Sat, May 07, 2022 at 02:19:00PM +0200, Mauro Rossi wrote:
> >> > > > Alternatively, you could apply the hack that Nick inserted into Android
> >> > > > for this issue if upgrading your toolchain or turning off the integrated
> >> > > > assembler is not possible:
> >> > > >
> >> > > > https://android.googlesource.com/kernel/common/+/e58f084735b8abf744d61083b92172ee23d45aae
> >> > > >
> >> > > > I really do not mean to sound dismissive or rude, I apologize if it
> >> > > > comes off that way, but we have worked quite hard to avoid inserting
> >> > > > unnecessary workarounds, as they are ultimately technical debt that can
> >> > > > be hard to manage over the long term.
> >> > > >
> >> > > > Cheers,
> >> > > > Nathan
> >> > >
> >> > > Thanks a lot Nathan
> >> > >
> >> > > It is definitely the clang version 11.0.x which is not updated in aosp
> >> > > Android 11 production tags
> >> > >
> >> > > I will use Nick's workaround which works since only lsl %rax, %rax is
> >> > > currently happening
> >> > >
> >> > > Many thanks, problem solved
> >> >
> >> > Hello,
> >> > I'm back again because I was assuming that Nick's workaround was working ok,
> >> > but I have found that ARCH=x86_64 i.e. 64bit built kernel is causing
> >> > an immediate hard reboot at initrd execution,
> >> > just after hitting [ENTER] at grub/efi menu.
> >>
> >> It looks like there was a follow up fix for that workaround, maybe that
> >> resolves this issue as well?
> >>
> >> https://android.googlesource.com/kernel/common/+/cc7f7a84191f5defc2ea4633eeea4acb4486b549
> >>
> >> > ARCh=x86 i.e. 32bit kernel binary is not affected, but is Nick's
> >> > workaround targeting 32 bit kernel builds?
> >>
> >> No, the file that the build error originates from (entry_64.S) is only
> >> built on x86_64.
> >>
> >> > How do aosp android-mailine kernels avoid this instantaneous hard reboot issue?
> >>
> >> That hack was reverted once the toolchain was upgraded:
> >>
> >> https://android.googlesource.com/kernel/common/+/ff0216d09fd31802537f2d1702ec2f3e9be73aa3
> >> https://android.googlesource.com/kernel/common/+/3c2c8d8f7f2639e319212d10cb8df5bd13098dae
> >>
> >> Cheers,
> >> Nathan
> >
> >
> > Hello,
> >
> > sorry i still have the issue when building with hack "ANDROID: x86: entry: work around LLVM_IAS=1 bug in LSL"
> > I'd just like to understand why I get instant reboot in 64bit kernel built with LLVM_IAS=1
>
> As Nathan noted, I messed up the commit "ANDROID: x86: entry: work
> around LLVM_IAS=1 bug in LSL". Please see:
> https://android-review.googlesource.com/c/kernel/common/+/1521061
> https://android-review.googlesource.com/c/kernel/common/+/1560152/
>
> If you're using an older toolchain, you'll need just the first. If
> you're using a newer toolchain, you'll need BOTH (or none, including
> dropping "ANDROID: x86: entry: work around LLVM_IAS=1 bug in LSL").

Thanks Nick,

I had already applied the squashed commit composed of  "ANDROID: x86:
entry: work around LLVM_IAS=1 bug in LSL" (the one using .quad) and
"ANDROID: x86: entry: fix LSL open coding", so I have already:

.macro LOAD_CPU_AND_NODE_SEG_LIMIT reg:req
movq $__CPUNODE_SEG, \reg
+#ifdef __clang__
+.long 0xc0030f48
+#else
lsl \reg, \reg
+#endif
.endm


So in principle my kernel image should boot when built with LLVM_IAS=1
but to my surprise all my systems (Sony VAIO i7, Intel NUC DN2820FYKH
with Celeron D2830, Athlon 200GE) are affected by hard reboot when
executing the kernel image

I'm trying to understand how to build (and boot) with LLVM_IAS=1 and
using clang 11.0.2 shipped with AOSP Android 11

>
> >
> > I searched for the places where #include "calling.h" is used
> >
> > utente@utente-3TB:~/r-x86_kernel/kernel$ grep -r \#include\ \"calling
> > arch/x86/entry/thunk_64.S:#include "calling.h"
> > arch/x86/entry/entry_32.S:#include "calling.h"
> > arch/x86/entry/entry_64_compat.S:#include "calling.h"
> > arch/x86/entry/entry_64.S:#include "calling.h"
> >
> > Probably the hardcoding done in the hack is impacting some other asm target built in 64 bit kernel and causes a wrong X86 instruction , is there a way to refine the #if to avoid that problem while still building with LLVM_IAS=1 ?
> >
> > Thanks for the info
> > Mauro
> >
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
