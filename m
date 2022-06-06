Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4317753F1E3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbiFFV5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiFFV5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:57:45 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30833532F0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:57:44 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y196so13792685pfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 14:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OVcwc2sHusOOh0nu9Pt06N+s8Xx2ijJaFMUsraj325k=;
        b=Vl6ZhlLa66LkHCjy57MVpd00ciLWPXkcoPC2OwQw++69ENr9/ERRDcHAE8hWh9qyG7
         iCM7q+pu9vVi7jXS0NOEsdjvFV63N8GHH3GYq+8tR3FYS+ft/+ycx0kP0Gvf72Ie6U6s
         fuQ+x76yrZmJZ1ddUzUF8UlSc/SRZ8I7j0LzxyT0eC39+N29h7Zh5QK4rgrUQu2V99F+
         6CgzaUdLDxLA7crr+JPw2g71MdChCAIhFTwC+uyBHUxZt99E6HD7Z/oaadKtpm1/vk+O
         iWVVCYdfRRdX/fcyw4tHIOXoCw6ADMwhd8mh/+f398ZURQS85tv2B1MLyMh30gGDKcQk
         ubmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OVcwc2sHusOOh0nu9Pt06N+s8Xx2ijJaFMUsraj325k=;
        b=CX8gJduiLpbtuN7+eKCi6cu2yPYPspXB6nI9emwBgawZ+eXzZ0C8oHSIOI9DsO9Bia
         cp+g72SVg2YrWyfiVNFCnsO1TrxDP+VdguNJzY3aCs4TqYVo6hrOOcxfbCiV3iL9nA8Y
         8tdpWn/Xo4kg85L77nHGz9YHZKYfyHc/G2f/2U4a6+hdSbndelwINkdHngn6LM/amTBX
         M/5GnvpZyY47pkNAjbjNdSSt1BmcHMv6+hLGgQIhyHSssgDRglUeWZvzvQ/qBXt5+Uo7
         hhbJCxDrUT696nEJQ1krsdE6aD7Be4Mhm3bzfsJ7QJHEO2qHEUTWagvSvbz9XKOTZSCF
         TylA==
X-Gm-Message-State: AOAM532jRz6h6YDidfiIGnLcV/TlUEJjBMCGfruLlXg1V1ccRS4AMOAe
        gQojUfFqB/FxRtgwltMu8FpUKCtZrEHEDv1imbZAGZauIpA=
X-Google-Smtp-Source: ABdhPJwek3m/elZZR6Oa/JA63J7/4oDhXQSKSBBP+agE9Js+1sMAoDRinRqyN7+mTenzRbtccrWNt1I4Ql/NpgSKNyM=
X-Received: by 2002:a63:24a:0:b0:3fc:52a9:b5d6 with SMTP id
 71-20020a63024a000000b003fc52a9b5d6mr22439371pgc.132.1654552663428; Mon, 06
 Jun 2022 14:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAEQFVGZ=6K8wudbS--3z+JpKTsL_dfM-8Co7NwViRo0i3t2EZg@mail.gmail.com>
 <Ym2qdHAB6BMMlegB@thelio-3990X> <CAEQFVGZB6eAetmt1kk+TYbGxpfrDut37DEO_-1HECqM6FEERww@mail.gmail.com>
 <CAEQFVGby3Q1mf1GGJwkFyAgaq38NvVAMx6tQM+9LO+HE8Z8Z8A@mail.gmail.com>
 <YnhbOpXHT8k+g9Qu@dev-arch.thelio-3990X> <CAEQFVGYSV=boBYGHfJLis8ayftzNPJy1UYgeEEQLuNb0hSfhjg@mail.gmail.com>
 <CAKwvOd=c=9xbzg0CjGxNnHtu3BOatWpe0gYQU7TWw0rkjwCCxA@mail.gmail.com>
 <CAEQFVGYOkTi4oNSnfyN48Re_4uhQqPF81+M7Xd5VJ0+tETwSbA@mail.gmail.com> <CAKwvOdmrwfm3HsyvGg2_HwYw1tdcj67DLj22oeGGf8MUO4x=mQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmrwfm3HsyvGg2_HwYw1tdcj67DLj22oeGGf8MUO4x=mQ@mail.gmail.com>
From:   Mauro Rossi <issor.oruam@gmail.com>
Date:   Mon, 6 Jun 2022 23:57:31 +0200
Message-ID: <CAEQFVGZTX9RdFvqOvZ-Lxsf4Jq--jNXKrrwKipZ6ZkYx_G2haA@mail.gmail.com>
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

On Sat, Jun 4, 2022 at 12:13 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Jun 1, 2022 at 5:57 AM Mauro Rossi <issor.oruam@gmail.com> wrote:
> >
> > On Wed, Jun 1, 2022 at 12:09 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > As Nathan noted, I messed up the commit "ANDROID: x86: entry: work
> > > around LLVM_IAS=1 bug in LSL". Please see:
> > > https://android-review.googlesource.com/c/kernel/common/+/1521061
> > > https://android-review.googlesource.com/c/kernel/common/+/1560152/
> > >
> > > If you're using an older toolchain, you'll need just the first. If
> > > you're using a newer toolchain, you'll need BOTH (or none, including
> > > dropping "ANDROID: x86: entry: work around LLVM_IAS=1 bug in LSL").
> >
> > Thanks Nick,
> >
> > I had already applied the squashed commit composed of  "ANDROID: x86:
> > entry: work around LLVM_IAS=1 bug in LSL" (the one using .quad) and
> > "ANDROID: x86: entry: fix LSL open coding", so I have already:
> >
> > .macro LOAD_CPU_AND_NODE_SEG_LIMIT reg:req
> > movq $__CPUNODE_SEG, \reg
> > +#ifdef __clang__
> > +.long 0xc0030f48
>
> LGTM
>
> > +#else
> > lsl \reg, \reg
> > +#endif
> > .endm
> >
> >
> > So in principle my kernel image should boot when built with LLVM_IAS=1
> > but to my surprise all my systems (Sony VAIO i7, Intel NUC DN2820FYKH
> > with Celeron D2830, Athlon 200GE) are affected by hard reboot when
> > executing the kernel image
>
> Might need more info.  Do they boot when LLVM_IAS=0 is explicitly set
> with your command line invocation of make? i.e. `make LLVM=1
> LLVM_IAS=0 ...`?  Can you launch these kernels in qemu?

Yes, kernel 5.17 and 5.18 built with LLVM=1 LLVM_IAS=0 do not cause
instantaneus hard reboot and proceed in the boot stages

The complete list of make variables Ihave used is as follows:

LLVM=1 LLVM_IAS=0 \
        CC=$(abspath $(LLVM_PREBUILTS_PATH)/clang) \
        LD=$(abspath $(LLVM_PREBUILTS_PATH)/ld.lld) \
        AR=$(abspath $(LLVM_PREBUILTS_PATH)/llvm-ar) \
        NM=$(abspath $(LLVM_PREBUILTS_PATH)/llvm-nm) \
        OBJCOPY=$(abspath $(LLVM_PREBUILTS_PATH)/llvm-objcopy) \
        OBJDUMP=$(abspath $(LLVM_PREBUILTS_PATH)/llvm-objdump) \
        READELF=$(abspath $(LLVM_PREBUILTS_PATH)/llvm-readelf) \
        OBJSIZE=$(abspath $(LLVM_PREBUILTS_PATH)/llvm-size) \
        STRIP=$(abspath $(LLVM_PREBUILTS_PATH)/llvm-strip) \
        HOSTCC=$(abspath $(LLVM_PREBUILTS_PATH)/clang) \
        HOSTCXX=$(abspath $(LLVM_PREBUILTS_PATH)/clang++) \
        HOSTLD=$(abspath $(LLVM_PREBUILTS_PATH)/ld.lld) \
        HOSTLDFLAGS=-fuse-ld=lld \
        HOSTAR=$(abspath $(LLVM_PREBUILTS_PATH)/llvm-ar)

>
> >
> > I'm trying to understand how to build (and boot) with LLVM_IAS=1 and
> > using clang 11.0.2 shipped with AOSP Android 11
>
> I think this combo should work; we are testing x86_64 with mainline
> https://github.com/ClangBuiltLinux/continuous-integration2/blob/95b9a12cad31675118d61c26d0b541fa4e3c8f09/generator.yml#L1694
>
> Could be something in your .config files though.
> --
> Thanks,
> ~Nick Desaulniers
