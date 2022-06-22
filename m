Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F42555133
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376504AbiFVQVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357785AbiFVQVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:21:30 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4853C720
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:21:29 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e40so12079505eda.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=La2lbdp3UKjWCqW4lfnhUIczS1kJzOzEyt2PeIAhoKo=;
        b=FfAyOh/DVgRc9cG+OdaMU7PGb120Oo+8Kt5ymO0wHtxBrqKW6X7uECKSgxFEsKK7FZ
         ++TO/Q/qoaRDQ3KpT2ZrF2Di7QOCKeDTU2gFD7Id15IeekIIww1BKJvriU3KWot8Qpd6
         m/1qCo3kwFiKykHlUgjb8oqTit3FZn4QWp6Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=La2lbdp3UKjWCqW4lfnhUIczS1kJzOzEyt2PeIAhoKo=;
        b=FBVYtsMhfLy9QnHdCMHs7I7GDvfjVRHJgm+G8etpIa0frwuf17aYyKLpjGJXcK6DPa
         xK9amvdP6RABaBJFIDPm5+dkOTUrguRBE4Gz5ZN5bw3jZ61GR0mSVk5UDjC7zyX+RzVS
         45zPcw1zQN1jfWUSyOeC9EH0M7LdbC0v6yCZ3DMkNitpKjOmARkD/IyCrq4jgHuw1p7k
         AX0GcFxfltaBHUemymK6SULdhK6jN3AIOH8duMapa+oWSXWZ2i9amHQDwhYbClo2iZD7
         4pT8hLvK7+hg70ewQXQdjwZ2Qfj40usMHSvyuqpZAyEHvpFjfkjOUqs0xfx66VVYoeN/
         aBtw==
X-Gm-Message-State: AJIora9sRHmq1O3x1+XhbkA6CKpS+KcBCCkHxTcdkaSJ1WKp8KhWaZg/
        /d4gsCIaa6Db9HaSazD59XKG5CG9DsaT2W0v
X-Google-Smtp-Source: AGRyM1uDAuOZ+oo0bz/OEfHZ4rYkptBvKrnf6CK4DAaFmpHDfUZNleM25DtuV8dq2WZ2b3tI5mltDA==
X-Received: by 2002:a05:6402:1e88:b0:435:bf05:f0f with SMTP id f8-20020a0564021e8800b00435bf050f0fmr1252883edf.2.1655914887929;
        Wed, 22 Jun 2022 09:21:27 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id r1-20020a170906280100b006fefd1d5c2bsm9678781ejc.148.2022.06.22.09.21.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 09:21:26 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id i10so20381982wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:21:26 -0700 (PDT)
X-Received: by 2002:a5d:6da3:0:b0:219:bcdd:97cd with SMTP id
 u3-20020a5d6da3000000b00219bcdd97cdmr4126190wrs.274.1655914886112; Wed, 22
 Jun 2022 09:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <YrLtpixBqWDmZT/V@debian> <CAHk-=wiN1ujyVTgyt1GuZiyWAPfpLwwg-FY1V-J56saMyiA1Lg@mail.gmail.com>
 <YrMu5bdhkPzkxv/X@dev-arch.thelio-3990X>
In-Reply-To: <YrMu5bdhkPzkxv/X@dev-arch.thelio-3990X>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Jun 2022 11:21:09 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjTS9OJzggD8=tqtj0DoRCKhjjhpYWoB=bPQAv3QMa+eA@mail.gmail.com>
Message-ID: <CAHk-=wjTS9OJzggD8=tqtj0DoRCKhjjhpYWoB=bPQAv3QMa+eA@mail.gmail.com>
Subject: Re: mainline build failure due to 281d0c962752 ("fortify: Add Clang support")
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_RED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 10:02 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Right, we are working on a statically linked and optimized build of LLVM
> that people can use similar to the GCC builds provided on kernel.org,
> which should make the compile time problem not as bad as well as making
> it easier for developers to get access to a recent version of clang with
> all the fixes and improvements that we have made in upstream LLVM.

So I'm on the road, and will try to see how well I can do that
allmodconfig build on my poor laptop and see what else goes wrong for
now.

But I do have to say that it's just a lot better if the regular distro
compiler build works out of the box. I did build my own clang binary
for a while, just because I was an early adopter of the whole "ask
goto with outputs" thing, but I've been *so* much happier now that I
don't need to do that any more.

So I would prefer not going backwards.

I wish the standard clang build just stopped doing the crazy shared
library thing. The security arguments for it are just ridiculous, when
any shared library update for any security reason would mean a full
clang update _anyway_.

I realize it's partly distro rules too, but the distros only do that
"we always build shared libraries" when the project itself makes that
an option. And it's a really stupid option for the regular C compiler
case.

Side note: I think gcc takes almost exactly the opposite approach, and
does much better as a result. It doesn't do a shared libary, but what
it *does* do is make 'gcc' itself a reasonably small binary that just
does the command line front-end parsing.

The advantage of the gcc model is that it works *really* well for the
"test compiler options" kind of stage, where you only run that much
simpler 'gcc' wrapper binary.

We don't actually take full advantage of that, because we do end up
doing a real "build" of an empty file, so "cc1" does actually get
executed, but even then it's done fairly efficiently with 'vfork()'.
That "cc-option" part of the kernel build is actually noticeable
during configuration etc, and clang is *much* slower because of how it
is built.

See

    time clang -Werror -c -x c /dev/null

and compare it with gcc. And if you want to see a really *big*
difference, pick a command line option that causes an error because it
doesn't exist..

I really wish clang wasn't so much noticeably slower. It's limiting
what I do with it, and I've had other developers say the same.

              Linus
