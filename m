Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10A653D382
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 00:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349524AbiFCWNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 18:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiFCWNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 18:13:47 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7251E3F1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 15:13:46 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j10so14602512lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 15:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xSlVDrcC6ThhuqFYVSDbH5zX5O/WG80a5ABV8+/WiYc=;
        b=jaXFhDCS8i3EMl+QHJtBD5GpPr5TQXbP2mE+ZuLw9VbjZMEY7AVTB//49N2rYgKc0j
         GjdW3v6cfPeBGqpOD+aZtY/rh+QlkTnf+Pnjf5ErLzn27MclKpSjJXZtF3dkvr8bICm/
         rW4E1nRdwfRFb4hjEXPugXZD44dkyt/sGRopzgsj021Jg3FnT3asCMUjXEMd2tT7/Z3C
         1AYAjXIg8B81YEqSmimrxPk1jYZRTVhuNBRGLI8LEcZD8cZvMQNJEPADEeYfS99sKYfZ
         /5SWpfwDusOzwIMwRhDtIT+W0a96l0AhulLR9NKYAQeFzhmqkn77KfW8Yy9pvkLX8QMh
         ENJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xSlVDrcC6ThhuqFYVSDbH5zX5O/WG80a5ABV8+/WiYc=;
        b=UxCXvh7xIVuxUUOggUlL1df2QsW+KHXLeLkkLKnY/75fnN2LsTNLgjjWBfqQu7E3F1
         9dotJGYpU/vEDW6CSpOsK+zqRsWdlkwuVBSBpv1H30AnT+V3YJra1iszV2Xa8axjadB7
         Ne1quXSUiLsgx45Sia6CA0OvC/ZIlUIxpz4OrWNEJwLYcDZ3FzOezSwnJEBt67ZdOh7+
         ZQ+uTyMj+PdOc8GptwlmCKkeLHwnixJw8upBGfN0GHZydcmI4hSoeGckftSF9ReWpo8o
         vR9Uo4DwRUmLzAZ7T3pLMxcieL4PAXp7bMF3316BC3C5Tk5MvmNS76Y7zCusTHw/BElw
         KI9A==
X-Gm-Message-State: AOAM532aNFoK9295k4fSGTcJClRYZ5dreWf/3BZTOt0EyowWYCkHJj42
        Uv7L1r6zKyYI3W85a2Lu/5FB77kSL6PzchfE6A9N0w==
X-Google-Smtp-Source: ABdhPJz5rB3V9OJ/RwPFdNbD9H6X0cg6eR5CVzghqkVYkNmu/4n5c5l5xYeWVXBVbpbswIbFmiBStEMzc1bzTe7AzPA=
X-Received: by 2002:a05:6512:ad3:b0:479:911:8463 with SMTP id
 n19-20020a0565120ad300b0047909118463mr8005984lfu.103.1654294424159; Fri, 03
 Jun 2022 15:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAEQFVGZ=6K8wudbS--3z+JpKTsL_dfM-8Co7NwViRo0i3t2EZg@mail.gmail.com>
 <Ym2qdHAB6BMMlegB@thelio-3990X> <CAEQFVGZB6eAetmt1kk+TYbGxpfrDut37DEO_-1HECqM6FEERww@mail.gmail.com>
 <CAEQFVGby3Q1mf1GGJwkFyAgaq38NvVAMx6tQM+9LO+HE8Z8Z8A@mail.gmail.com>
 <YnhbOpXHT8k+g9Qu@dev-arch.thelio-3990X> <CAEQFVGYSV=boBYGHfJLis8ayftzNPJy1UYgeEEQLuNb0hSfhjg@mail.gmail.com>
 <CAKwvOd=c=9xbzg0CjGxNnHtu3BOatWpe0gYQU7TWw0rkjwCCxA@mail.gmail.com> <CAEQFVGYOkTi4oNSnfyN48Re_4uhQqPF81+M7Xd5VJ0+tETwSbA@mail.gmail.com>
In-Reply-To: <CAEQFVGYOkTi4oNSnfyN48Re_4uhQqPF81+M7Xd5VJ0+tETwSbA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 3 Jun 2022 15:13:32 -0700
Message-ID: <CAKwvOdmrwfm3HsyvGg2_HwYw1tdcj67DLj22oeGGf8MUO4x=mQ@mail.gmail.com>
Subject: Re: arch/x86/entry/entry: RFC on recent kernels building error with
 llvm 11.0.2 internal assembler
To:     Mauro Rossi <issor.oruam@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, luto@kernel.org,
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

On Wed, Jun 1, 2022 at 5:57 AM Mauro Rossi <issor.oruam@gmail.com> wrote:
>
> On Wed, Jun 1, 2022 at 12:09 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > As Nathan noted, I messed up the commit "ANDROID: x86: entry: work
> > around LLVM_IAS=1 bug in LSL". Please see:
> > https://android-review.googlesource.com/c/kernel/common/+/1521061
> > https://android-review.googlesource.com/c/kernel/common/+/1560152/
> >
> > If you're using an older toolchain, you'll need just the first. If
> > you're using a newer toolchain, you'll need BOTH (or none, including
> > dropping "ANDROID: x86: entry: work around LLVM_IAS=1 bug in LSL").
>
> Thanks Nick,
>
> I had already applied the squashed commit composed of  "ANDROID: x86:
> entry: work around LLVM_IAS=1 bug in LSL" (the one using .quad) and
> "ANDROID: x86: entry: fix LSL open coding", so I have already:
>
> .macro LOAD_CPU_AND_NODE_SEG_LIMIT reg:req
> movq $__CPUNODE_SEG, \reg
> +#ifdef __clang__
> +.long 0xc0030f48

LGTM

> +#else
> lsl \reg, \reg
> +#endif
> .endm
>
>
> So in principle my kernel image should boot when built with LLVM_IAS=1
> but to my surprise all my systems (Sony VAIO i7, Intel NUC DN2820FYKH
> with Celeron D2830, Athlon 200GE) are affected by hard reboot when
> executing the kernel image

Might need more info.  Do they boot when LLVM_IAS=0 is explicitly set
with your command line invocation of make? i.e. `make LLVM=1
LLVM_IAS=0 ...`?  Can you launch these kernels in qemu?

>
> I'm trying to understand how to build (and boot) with LLVM_IAS=1 and
> using clang 11.0.2 shipped with AOSP Android 11

I think this combo should work; we are testing x86_64 with mainline
https://github.com/ClangBuiltLinux/continuous-integration2/blob/95b9a12cad31675118d61c26d0b541fa4e3c8f09/generator.yml#L1694

Could be something in your .config files though.
-- 
Thanks,
~Nick Desaulniers
