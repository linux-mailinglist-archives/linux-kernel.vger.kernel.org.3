Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CDD4E8923
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 19:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbiC0Rtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 13:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbiC0Rth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 13:49:37 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C68E13DF1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 10:47:58 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p10so15303473lfa.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 10:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o1iDTaw6udoeWxS0P3g37FT6qwmikziMFuHY85TzLms=;
        b=QXev/0HctMbQHJBBNg+vNKoiZgjxrbVRSPl69GoL4dHj0DM3HKnB8D6M9SfRxR7oye
         ZjtoNDJsE178zhG1uAUpIv6gx7j2hqmmr9e61yPEb/ijmDJDrw7sxwJYVDWTMob0rc0O
         16xoprFxcmNSQ9AF+YH9lSIXRpizPi37FJt/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1iDTaw6udoeWxS0P3g37FT6qwmikziMFuHY85TzLms=;
        b=MxXmgzf0qrVVepcB7VIgc1BP8a2dK6BFecHJ7dN5aWsxYf7mj90NLqPgjJbRf53R7d
         b5LKnEGMSbim+iZRA7fAFFAPSnKNguDyAgvVqYKM4y6AHXjn+vAwjxQ0uj6zOdEPJF8T
         reAdrnj8LlMajV2aM8XqRHl+4dAVCk70il5yP1IrL1PSX4qmhbDBm8gHPrAybv1fFidM
         WR5ZDEHAfojYR3JwgblErMV47g4+jSiLLxZfX7ZCegA1lBq+WJtx+CIpSOSHykAiSG5D
         xcy79maRVOAaFLxuO1xMvJuMHx3Uh3myaSSl4IgvGdTvnUBE8Mi1Ti5lU/x2jSyB1r8x
         +2Fw==
X-Gm-Message-State: AOAM533PkpafUGVV8+zEa3EtlBABpe2lW6TNJtKce4zuppNqAMRAf+zY
        2sDM3WO4PTPQC9sdDSG+T5B6/GRalgsh3CpEn68=
X-Google-Smtp-Source: ABdhPJzGkOC8uJbA+kk3Opg7yZN437E+8XGHnK7aLiazRjMgUlp3l64iLFdAUSXz8+hA3OEvT719mA==
X-Received: by 2002:a05:6512:34d0:b0:44a:6d14:5019 with SMTP id w16-20020a05651234d000b0044a6d145019mr12636660lfr.632.1648403276151;
        Sun, 27 Mar 2022 10:47:56 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id a13-20020a195f4d000000b00443a5302315sm1416166lfj.30.2022.03.27.10.47.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 10:47:55 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id q14so16352318ljc.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 10:47:54 -0700 (PDT)
X-Received: by 2002:a2e:9b10:0:b0:247:f28c:ffd3 with SMTP id
 u16-20020a2e9b10000000b00247f28cffd3mr16448428lji.152.1648403274197; Sun, 27
 Mar 2022 10:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220326152646.GT8939@worktop.programming.kicks-ass.net>
 <CAHk-=whhG15HiqR+WM5M2mMy9F17yVdT8_M0ra0tGJS+5ibrdw@mail.gmail.com> <20220327082217.GU8939@worktop.programming.kicks-ass.net>
In-Reply-To: <20220327082217.GU8939@worktop.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Mar 2022 10:47:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whzW56xChey=k+9KeK_NFxWLfZrt5UWvVjTxYbHLP1Nwg@mail.gmail.com>
Message-ID: <CAHk-=whzW56xChey=k+9KeK_NFxWLfZrt5UWvVjTxYbHLP1Nwg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/core for 5.18
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2022 at 1:22 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Duh! I pushed the tag to the wrong repo (peterz/queue.git)... I just
> pushed it out to tip/tip/git as well, so hopefully it should all work
> now.

Thanks, looks good.

There's a few merges that don't have good explanations ("avoid
conflicts" really is not an explanation on its own), but those weren't
actually yours.

Looking around, the only other thing I notice is that the CC_HAS_IBT
conditional is horrendously unreadable.

There is no reason to make a Kconfig option use one single expression
from hell, when the Kconfig language is designed to be able to do so
much better.

That

       def_bool ((CC_IS_GCC && $(cc-option, -fcf-protection=branch
-mindirect-branch-register)) || \
                 (CC_IS_CLANG && CLANG_VERSION >= 140000)) && \
                 $(as-instr,endbr64)

really is pretty horrendous. Yeah, we have other examples ot those
kinds of horrible expressions (*cough*KCSAN*cough*), but wouldn't it
be much nicer to just write those things legibly.

And it's nice to see the comments about _why_ some particular compiler
checks are done, but when it's all part of one very complicated thing
it's not exactly easy to read or understand.

I've obviously already pulled it (you should have seen the
pr-tracker-bot reply), but I really think it should have been written
in a much more straight-forward and obvious manner, something like:

  # work around https://gcc.gnu.org/bugzilla/show_bug.cgi?id=93654
  config GCC_HAS_IBT
        def_bool y
        depends on CC_IS_GCC
        depends on $(cc-option, -fcf-protection=branch
-mindirect-branch-register)

  # Clang/LLVM >= 14
  # https://github.com/llvm/llvm-project/commit/e0b89df2e0f0130881bf6c39bf31d7f6aac00e0f
  # https://github.com/llvm/llvm-project/commit/dfcf69770bc522b9e411c66454934a37c1f35332
  config CLANG_HAS_IBT
        def_bool y
        depends on CC_IS_CLANG && CLANG_VERSION >= 140000

  # binutils >= 2.29 for 'endbr64' instruction
  config CC_HAS_IBT
        def_bool y
        depends on GCC_HAS_IBT || CLANG_HAS_IBT
        depends on $(as-instr,endbr64)

instead (ok, using "AS_HAS_IBT" and "LD_HAS_IBT" to clarify all
_those_ tests too would probably have been even more legible, but I
got bored).

The above suggested Kconfig snippet is entirely untested, and meant
purely as a "look, you can split these expressions up to be more
legible".

The actual *code* seems to be nicely abstracted out, which is why I
then reacted to that Kconfig mess.

           Linus
