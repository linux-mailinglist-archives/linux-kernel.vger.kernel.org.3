Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D465353F20B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 00:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiFFWSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 18:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiFFWSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 18:18:16 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243E3694AB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 15:18:15 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i29so8709844lfp.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 15:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AEicuTVMgg6V1QO4zYkGhfVsMSgQk+TbKCz6HyUOuSA=;
        b=FkSl67D1qpP1+e0AN36ByGsngSb94JD7VibKCDEBSYAW+ITNExRg12fzsjXYaV90DT
         jm1r1bBlSEfzPb8K+SYZd/MsmF8+qdcHXxXcLri6n5Yx8FuwqWSmDg1nR30rH9WXM0Y1
         JzbtyBLhaeJAJKe0IeoXtpBwF0qG6UqATVHTRxALfhBH2fPGLh/K9COzRk7WW8k4QWXs
         jbGQjW6B/arT7ePxRTUXT7X+7f8T3nyHhycTNv/8HZZ6k/JO7gOVM5ZJKQsoTNik5IUQ
         /RYVVrwVQOnBzUsHzxrR7cQB8M0RNqjbazVxl0V4VkqKEFCLeqfI6VX1D8Ave1Jq5/KS
         ty0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEicuTVMgg6V1QO4zYkGhfVsMSgQk+TbKCz6HyUOuSA=;
        b=h1njVYaLP86UitBUucWIDbjYuwmjpa5lG6POUJQwevMMw+oEOOrEYGLGhcf8PUIEa6
         YOu9HmdRi0wSbuZ3YbVioMPHeJN0fg4hokHCkgNyILNd9l2EvkwFQM3Mo6b/aTJ8im4B
         /9HbD8PyEmJko7TPKjJBvmwfiCcwUbFAEY/VJzj1I4Fos86Tu14lPdKlt8wpmBY+L5BD
         soVMvSE5Baio6uIxx1PfuZlUhD7CTsbAYooGjjigdWPoHf/sMaQ/RO6GxxmhhaL9/7M4
         I3dTNVxULYE1npXcRVKkigefpT3WqiqBXoh3Cs8ybw2tTesM3kNTEy6hAD59lwvzbn1A
         mMig==
X-Gm-Message-State: AOAM531saoThL11vm/O8eLmhN0/9ySi+OQwZNWXL9mUR9Tp38Dn63rBT
        BDNiJeoAZSyDA1iSSIbHr2VVMATgEDoaNuWaCHZLmg==
X-Google-Smtp-Source: ABdhPJxqUrw4xLKP5o5CLTHUeWbcjcktYubJ5FZ6j5Aaz3e7EZAb3xtgpXPy5aj6klZoufbg/PxodtMNEea0nw4iYqs=
X-Received: by 2002:ac2:454b:0:b0:479:1131:f2ff with SMTP id
 j11-20020ac2454b000000b004791131f2ffmr14826098lfm.626.1654553893157; Mon, 06
 Jun 2022 15:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAEQFVGZ=6K8wudbS--3z+JpKTsL_dfM-8Co7NwViRo0i3t2EZg@mail.gmail.com>
 <Ym2qdHAB6BMMlegB@thelio-3990X> <CAEQFVGZB6eAetmt1kk+TYbGxpfrDut37DEO_-1HECqM6FEERww@mail.gmail.com>
 <CAEQFVGby3Q1mf1GGJwkFyAgaq38NvVAMx6tQM+9LO+HE8Z8Z8A@mail.gmail.com>
 <YnhbOpXHT8k+g9Qu@dev-arch.thelio-3990X> <CAEQFVGYSV=boBYGHfJLis8ayftzNPJy1UYgeEEQLuNb0hSfhjg@mail.gmail.com>
 <CAKwvOd=c=9xbzg0CjGxNnHtu3BOatWpe0gYQU7TWw0rkjwCCxA@mail.gmail.com>
 <CAEQFVGYOkTi4oNSnfyN48Re_4uhQqPF81+M7Xd5VJ0+tETwSbA@mail.gmail.com>
 <CAKwvOdmrwfm3HsyvGg2_HwYw1tdcj67DLj22oeGGf8MUO4x=mQ@mail.gmail.com> <CAEQFVGZTX9RdFvqOvZ-Lxsf4Jq--jNXKrrwKipZ6ZkYx_G2haA@mail.gmail.com>
In-Reply-To: <CAEQFVGZTX9RdFvqOvZ-Lxsf4Jq--jNXKrrwKipZ6ZkYx_G2haA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 6 Jun 2022 15:18:01 -0700
Message-ID: <CAKwvOdkOnSBZADEi44z-w+zK0+UBzVY-ZP_r08FC_eTQC_Y2Fg@mail.gmail.com>
Subject: Re: arch/x86/entry/entry: RFC on recent kernels building error with
 llvm 11.0.2 internal assembler
To:     Mauro Rossi <issor.oruam@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Chih-Wei Huang <cwhuang@android-x86.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
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

On Mon, Jun 6, 2022 at 2:57 PM Mauro Rossi <issor.oruam@gmail.com> wrote:
>
> On Sat, Jun 4, 2022 at 12:13 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Wed, Jun 1, 2022 at 5:57 AM Mauro Rossi <issor.oruam@gmail.com> wrote:
> > >
> > > On Wed, Jun 1, 2022 at 12:09 AM Nick Desaulniers
> > > <ndesaulniers@google.com> wrote:
> > > >
> > > > As Nathan noted, I messed up the commit "ANDROID: x86: entry: work
> > > > around LLVM_IAS=1 bug in LSL". Please see:
> > > > https://android-review.googlesource.com/c/kernel/common/+/1521061
> > > > https://android-review.googlesource.com/c/kernel/common/+/1560152/
> > > >
> > > > If you're using an older toolchain, you'll need just the first. If
> > > > you're using a newer toolchain, you'll need BOTH (or none, including
> > > > dropping "ANDROID: x86: entry: work around LLVM_IAS=1 bug in LSL").
> > >
> > > Thanks Nick,
> > >
> > > I had already applied the squashed commit composed of  "ANDROID: x86:
> > > entry: work around LLVM_IAS=1 bug in LSL" (the one using .quad) and
> > > "ANDROID: x86: entry: fix LSL open coding", so I have already:
> > >
> > > .macro LOAD_CPU_AND_NODE_SEG_LIMIT reg:req
> > > movq $__CPUNODE_SEG, \reg
> > > +#ifdef __clang__
> > > +.long 0xc0030f48
> >
> > LGTM
> >
> > > +#else
> > > lsl \reg, \reg
> > > +#endif
> > > .endm
> > >
> > >
> > > So in principle my kernel image should boot when built with LLVM_IAS=1
> > > but to my surprise all my systems (Sony VAIO i7, Intel NUC DN2820FYKH
> > > with Celeron D2830, Athlon 200GE) are affected by hard reboot when
> > > executing the kernel image
> >
> > Might need more info.  Do they boot when LLVM_IAS=0 is explicitly set
> > with your command line invocation of make? i.e. `make LLVM=1
> > LLVM_IAS=0 ...`?  Can you launch these kernels in qemu?
>
> Yes, kernel 5.17 and 5.18 built with LLVM=1 LLVM_IAS=0 do not cause
> instantaneus hard reboot and proceed in the boot stages
>
> The complete list of make variables Ihave used is as follows:
>
> LLVM=1 LLVM_IAS=0 \
>         CC=$(abspath $(LLVM_PREBUILTS_PATH)/clang) \
>         LD=$(abspath $(LLVM_PREBUILTS_PATH)/ld.lld) \
>         AR=$(abspath $(LLVM_PREBUILTS_PATH)/llvm-ar) \
>         NM=$(abspath $(LLVM_PREBUILTS_PATH)/llvm-nm) \
>         OBJCOPY=$(abspath $(LLVM_PREBUILTS_PATH)/llvm-objcopy) \
>         OBJDUMP=$(abspath $(LLVM_PREBUILTS_PATH)/llvm-objdump) \
>         READELF=$(abspath $(LLVM_PREBUILTS_PATH)/llvm-readelf) \
>         OBJSIZE=$(abspath $(LLVM_PREBUILTS_PATH)/llvm-size) \
>         STRIP=$(abspath $(LLVM_PREBUILTS_PATH)/llvm-strip) \
>         HOSTCC=$(abspath $(LLVM_PREBUILTS_PATH)/clang) \
>         HOSTCXX=$(abspath $(LLVM_PREBUILTS_PATH)/clang++) \
>         HOSTLD=$(abspath $(LLVM_PREBUILTS_PATH)/ld.lld) \
>         HOSTLDFLAGS=-fuse-ld=lld \
>         HOSTAR=$(abspath $(LLVM_PREBUILTS_PATH)/llvm-ar)

You could probably simplify the above to:

$ PATH=$PATH:$LLVM_PREBUILTS_PATH make LLVM=1 LLVM_IAS=0

>
> >
> > >
> > > I'm trying to understand how to build (and boot) with LLVM_IAS=1 and
> > > using clang 11.0.2 shipped with AOSP Android 11

Can you try a newer version of LLVM?  AOSP LLVM 11 is technically a
pre-release version somewhere between the LLVM 10 and 11 releases.  We
no longer support LLVM 10 with mainline, so it's hard to say if AOSP
LLVM 11.0.2 contains or does not contain problematic or necessary
commits.

Also, do you have a kernel tree I can fetch? I'd be happy to try to
boot the result in QEMU. Have you tried that?

> >
> > I think this combo should work; we are testing x86_64 with mainline
> > https://github.com/ClangBuiltLinux/continuous-integration2/blob/95b9a12cad31675118d61c26d0b541fa4e3c8f09/generator.yml#L1694
> >
> > Could be something in your .config files though.
> > --
> > Thanks,
> > ~Nick Desaulniers
>


-- 
Thanks,
~Nick Desaulniers
