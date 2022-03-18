Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E824DE145
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 19:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240242AbiCRSm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 14:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240144AbiCRSm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:42:26 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C7B2EA0E9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:41:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p14so4127899lfe.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T68So5s+Mvf8Yxsi6hpGLQhvBaydZiJJcf2u3DNH8AQ=;
        b=ZmBvasPMchpBJ8mkRKb7R3RhkkeHi7XstG7ccVRfInSia4wxmHPc+1XSCMLTTbtwoD
         iBBZhG8pLYhyN+/NcRaXQ6YvBWpZBO0b6qFsSWL8b/QpLIBN/MEi/ZFczp9fnO89TfiE
         WjskrGL3deHU2C25PjWZUp+gAg6DG/SMTBWTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T68So5s+Mvf8Yxsi6hpGLQhvBaydZiJJcf2u3DNH8AQ=;
        b=gdCrxLzztP9/p/WW/CYLm69woa8uXYw1eXkWGx6YcLLIsHsSmaAHC9b444x9OmGmp9
         dBE64Sqn8rPb5FSj4Lbsjqb2X+UF9lG0isAibnV8gnKUJhlO1bsWJry07SV6jcYw+W5B
         48ninoseZ+GY0ciwmkM4MwW1Fzsn9h2E0xU1dPI1oMljd1S6I3EB5mxsst2GKtxJ+8nd
         UgM/RVk0f7TlHcx7i7WrRSIxxO8z58X/uNAje7lxZ+VxeanIKjufDkuUvvu17NQmBdZF
         6kEF8owgBv3x0NNxG8+VBdi+2yDl7sBGJXfPBhFr1v3NZLFRRW/kshFaN1YmvWE0EB7h
         do+w==
X-Gm-Message-State: AOAM533pR1thrtKTvVhS2NJkZzzkq8nIfFTFrwqQK53uT0o+JMAJdMCd
        CjaSxQ4Zbp2FcN2gTx6UEKr6FZG4c6pPzGWAclY=
X-Google-Smtp-Source: ABdhPJzjYyB1xwXMknUnlasyhEts+3DLtVlrBRQoqE4nOriko/ziIpVQ1Pw+K2FOQUVk19m1GgI9Eg==
X-Received: by 2002:a05:6512:3dab:b0:44a:247:2d8 with SMTP id k43-20020a0565123dab00b0044a024702d8mr4170601lfv.628.1647628865751;
        Fri, 18 Mar 2022 11:41:05 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id v1-20020a2e6101000000b002480c4f33d5sm1116393ljb.132.2022.03.18.11.41.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 11:41:03 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id o6so12409277ljp.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:41:03 -0700 (PDT)
X-Received: by 2002:a2e:804b:0:b0:247:e81f:87e9 with SMTP id
 p11-20020a2e804b000000b00247e81f87e9mr7192968ljg.176.1647628863338; Fri, 18
 Mar 2022 11:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220316213055.2351342-1-morbo@google.com> <YjL6K49CkH+YC4FQ@smile.fi.intel.com>
 <CAKwvOdkjb3uR+kqjfdKL5gqA8R+00c5=3E7uGGW+mGZ3QRsjqg@mail.gmail.com>
 <YjSROmYwwGhpsXMl@smile.fi.intel.com> <CAKwvOdkEjrPUL4HuO3UKaUZAzVw=XV1bEOSj6HR5R1WTUSSZ4w@mail.gmail.com>
 <CAGG=3QVCkF7RdbQ85MtKgUjm8qP79BESAUiGU3wSQc0+ExO0gA@mail.gmail.com> <CAKwvOd=1+JF6mxpM_K3xCYAr-R8nrj0s7tA9GwUybyiFdLpA2w@mail.gmail.com>
In-Reply-To: <CAKwvOd=1+JF6mxpM_K3xCYAr-R8nrj0s7tA9GwUybyiFdLpA2w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Mar 2022 11:40:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wis4P8-=-0jmcDzGGuttZ3ESnq0LA5PMOVmKkPRwK1kEA@mail.gmail.com>
Message-ID: <CAHk-=wis4P8-=-0jmcDzGGuttZ3ESnq0LA5PMOVmKkPRwK1kEA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: use correct format characters
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Bill Wendling <morbo@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nathan Chancellor <nathan@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Joe Perches <joe@perches.com>
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

On Fri, Mar 18, 2022 at 11:29 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Should we add a note diagnostic to clang suggesting the explicit cast
> as one method of silencing the warning?

On the compiler side, I would love to see warnings about the ambiguity
of the sign of 'char' in the general case.

That said, I tried to add that to 'sparse' long long ago, and couldn't
make it work sanely. All the approaches I tried all get _way_ too many
false positives.

I tried to come up with some way of figuring out "this code acts
differently depending on whether 'char' is signed or not" and warning
about it, and never could.

And I suspect the same is true even for the much moire limited case of
only format warnings.

Because it's a *bad* idea to use '%d' (or almost any other format
specifier) together with a 'char' argument, but only if you don't know
the range of the char argument.

But the other side of the argument is that quite often, people *do*
know the range of the 'char' argument. If your 'char' type thing comes
from some array or string that you control, and you used 'char' simply
because you know you have small values (typical example: use it for an
array of booleans etc), then it would be very annoying if the compiler
warned you about using '%d'.

There is no reason to use '%hhd' when you know your data range is [0,1].

So honestly, I don't think you can come up with a sane warning that
doesn't cause *way* too many false positives and just annoys people.

I'd love to be proven wrong. In fact, I'd _really_ love to be proven
wrong for that generic case. The "sometimes 'char' is signed,
sometimes it is unsigned, and it depends on the architecture and the
compiler flags" can be a real problem.

                Linus
