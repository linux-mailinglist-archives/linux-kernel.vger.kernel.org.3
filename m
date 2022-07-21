Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422D957CE18
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiGUOs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGUOsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:48:54 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877EF66AFE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:48:53 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u19so3235313lfs.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b6hct8xCrE6CB9ftodiKvDlwTR0gdrnA5ClwcliBbPY=;
        b=JMubbrBv1Nd+8w6FEi5or5LUmjlC2ld6RSrBV9zeh4LiULoqJiy9EVpd3jtEFtwJCi
         PZHnxwTZ1skg3P7ZHuFqsRPmgQuZUhh5qDWu0VuZ/qPk4BjGMeThmvjpzJLjrSpIK2Cm
         EKrTCSJ7od43H4++62FeYEuZDqMh+oH31imbnETjgycNPi0hBVSySmdfM+XljybFGRBM
         Z1lu2fA4faSic32ei6AxwHfu2kATgh69lgbGfQy6YffNkFLmFlWU+qpcfDGFmoZEE0Ha
         fpSY4lN7hB544+d/F4GCctLNlY12yUCNT9vWbPbeYvBd0NBzY3dVsAVs5dgzZrBjtciR
         pBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b6hct8xCrE6CB9ftodiKvDlwTR0gdrnA5ClwcliBbPY=;
        b=H9QBFyGYL21cislOjdxf3idD+H5zVZ7j6sqFHn5YaaTIWfSUvhFzaZ5zPIVW2rzA49
         8GUtU6rsXNlY8M2dFhCm/NlGhjL8ZZi+AgxLkTwKf3jCkFYGv1mBGIPp9N0nNVs1sEA6
         rFHfGmHlDI9djTKJ2iV0J0/0xd1xy1j6Uylux0v531SKv6SuM0VNLkI0y7c5SHkjYv22
         v2uR2kh84VKf5YuwERgEIyZb4YyusMPZQyZfjsJkdD1mXlbUEgShlGTy36bVnrPUF8VM
         Fr4Na2AplLoSNiIZINTw09w3fmRsBPDP0ZPgKFgplV9cRY3Y08A5qb9aJfOHvjxP/I5U
         0D4A==
X-Gm-Message-State: AJIora+tGN13cg69pOdEjOt1YZ7d7Ru+SzRygUWLNZKvFj5QkfkzGW2x
        wxsscPGrZefMuN2/yslTFr9lT/KIEYnlzUX27MNb3g==
X-Google-Smtp-Source: AGRyM1viW5VSMgPFgPinMrTL+kpk+XpxDY9JqlD86usXfDLVMuZ2ksntxKfHUq/p0uaQkcha+Bst/d+d0seMWLDTQO0=
X-Received: by 2002:ac2:4f03:0:b0:48a:6061:bd8e with SMTP id
 k3-20020ac24f03000000b0048a6061bd8emr3942194lfr.647.1658414931709; Thu, 21
 Jul 2022 07:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220714205646.4023495-1-ndesaulniers@google.com>
 <CAHk-=wgf=mrK7KzNh23dGtegSfJZx=423dCwF0hVTPOjfQ7jtQ@mail.gmail.com> <CAHk-=wh6iW0Fv9mbtX9k2=9Kc9pFEEX7unWzmN7vqB4qXhBL+w@mail.gmail.com>
In-Reply-To: <CAHk-=wh6iW0Fv9mbtX9k2=9Kc9pFEEX7unWzmN7vqB4qXhBL+w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 21 Jul 2022 07:48:39 -0700
Message-ID: <CAKwvOdn1btTr1DeAJz-xRw4tLcwCMmrXbJChOVrvjAZ1KtnZew@mail.gmail.com>
Subject: Re: [PATCH] ubsan: disable UBSAN_DIV_ZERO for clang
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 10:34 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I decided to make a non-kernel test-case so that clang people can look
> at it without having to worry about any kernel code issues or the
> details of the SMAP rules, and it really shows how clang generates
> horribly pointless and wrong code.

Perfect, thank you.  I was having a hard time reducing this one.

>
> I'm not sure what the right thing to do is to get this sorted out, but
> I created an "issue" on github for this:
>
>     https://github.com/llvm/llvm-project/issues/56568
>
> in the hope that this can get fixed. Because it's very clearly a clang
> misfeature, where clang basically generates insane code that violates
> the rules we try to enforce with objdump.
>
> Nick / Nathan / clang-built-linux people - if there are other better
> ways than that github issue thing to make people aware of this, that
> would be lovely, and please forward that issue to the right people.

Perfect, thank you.

LLVM moved from bugzilla to github for issue tracking last year.  It's
best to file issues there, or in our issue tracker (also github) which
is more specific to issues pertaining to the kernel:
https://github.com/ClangBuiltLinux/linux/issues

You can cc Nathan or myself in bugreports via mentioning @nathanchance
and @nickdesaulniers explicitly, or just forward us the link and we
can subscribe.

Putting out some other fires/regressions at the moment; it looks like
Yuanfang has already started chewing on your bug report.  If they get
stuck, I'll dive in once these regressions are sorted.  Should be an
optimization opportunity regardless of UBSAN when we know only certain
bits are set.
-- 
Thanks,
~Nick Desaulniers
