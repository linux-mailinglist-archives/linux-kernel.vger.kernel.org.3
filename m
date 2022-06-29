Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B704560BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiF2VkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiF2VkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:40:07 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA67B34BB3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:40:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id n8so10050169eda.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klf2T5uOmYkulw+Ytxhor7E1jRh+wZUXX4z/9h4gYAk=;
        b=hAQm1c13W/XqzJEQGpVDQndjuXTIF/hnLGFygg19fcRMwVFwwvtwTnuY62qNkTKPsN
         ummZuhAltApu5WzcBlZRapxwbWg7c0aLtThrKLZaU63b6nHxlLMnebmA/0hCeagDrFcn
         hagyyVyTMpXMrTeCXHSAtT7Z8257jVCbYTvK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klf2T5uOmYkulw+Ytxhor7E1jRh+wZUXX4z/9h4gYAk=;
        b=a/qMLYQwDK545jIQfijbcAWdaJFNpV6gZD3grdlG2OHeLnoJffbuGtQg+LsWxQnK/u
         ebaV7K19l+YW0SQVt0nc8+XjuNIsaqv3ohAzRZhhw5FvGBRvWd0/L7+OusyzzCUYBuje
         BlAyHKYAsfCweD/micC6BpRl5h0HEBf1uYdDE3dcxpeu9KjV7Bd3qFRnmXFao6pX/GHS
         +jipw5K9fYTuhSzN4xv1oVZUveNlSepMehqsInjO9mZgAlgU81V6p2U9zmDo/sBa/Sq0
         jDI9fpi4C1oiDOXT2H+Ocb867BgklmkaxOq4rctnn/rPkx+6KVJN3IjVmuHQyujqeAZo
         sBtw==
X-Gm-Message-State: AJIora/Xu5bkDXJlxkySekM4CDp9SSCC0FmXXvgqu+dLDGhq/3Xu3qjU
        HWn3RJIu6tTxG9FW2aQvZBd4X8RxVbuQY5L2
X-Google-Smtp-Source: AGRyM1s/GGbJoRGZfECk/Osn6vIW+SQGrZ7QEh1pycHVs5JXkbCUkw1lysJ9px00t8uENwmaCXJ7Gg==
X-Received: by 2002:a05:6402:274a:b0:435:9807:7752 with SMTP id z10-20020a056402274a00b0043598077752mr7457387edd.63.1656538804107;
        Wed, 29 Jun 2022 14:40:04 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id s16-20020a170906455000b00722bc0aa9e3sm1911850ejq.162.2022.06.29.14.40.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 14:40:03 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id f190so9854605wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:40:01 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecc:b0:3a1:68bf:d17a with SMTP id
 g12-20020a05600c4ecc00b003a168bfd17amr5659198wmq.154.1656538801585; Wed, 29
 Jun 2022 14:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <YrLtpixBqWDmZT/V@debian> <CAHk-=wiN1ujyVTgyt1GuZiyWAPfpLwwg-FY1V-J56saMyiA1Lg@mail.gmail.com>
 <YrMu5bdhkPzkxv/X@dev-arch.thelio-3990X> <CAHk-=wjTS9OJzggD8=tqtj0DoRCKhjjhpYWoB=bPQAv3QMa+eA@mail.gmail.com>
 <YrNQrPNF/XfriP99@debian> <CAHk-=wjje8UdsQ_mjGVF4Bc_TcjAWRgOps7E_Cytg4xTbXfyig@mail.gmail.com>
 <CAKwvOdmQKo4tZRLWxK2tTvd+OEtUmKJM7XiijLAF8JWMeUzFMA@mail.gmail.com>
 <CAKwvOdnfRnqBF8exO-Y1ooX=67TrO_8fSzgZwvUtidN_P31hzw@mail.gmail.com>
 <20220628224255.w4lmzalkx3qejuyg@treble> <CAHk-=wivq+i2-xp3WagixzQMBXaD4etMDmiTp5f-mgsfwOjxtA@mail.gmail.com>
 <20220629163400.cgeqmuu45zsyxtwq@treble> <CAKwvOdm7=6M3pdHnqLFYkV21ypYpN4rTaNCe48dN3hWOOd+T2A@mail.gmail.com>
In-Reply-To: <CAKwvOdm7=6M3pdHnqLFYkV21ypYpN4rTaNCe48dN3hWOOd+T2A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Jun 2022 14:39:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1qhf7y3VNACEexyp5EbkNpdcu_542k-xZpzmYLOjiCg@mail.gmail.com>
Message-ID: <CAHk-=wj1qhf7y3VNACEexyp5EbkNpdcu_542k-xZpzmYLOjiCg@mail.gmail.com>
Subject: Re: mainline build failure due to 281d0c962752 ("fortify: Add Clang support")
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Peter Zijlstra <peterz@infradead.org>
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

On Wed, Jun 29, 2022 at 2:21 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> For hahas I tried:
>
> ```
> diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c

Yeah, no.

I think the proper fix is to just say

     depends on !CLANG

in the UBSAN Kconfig.

The whole point of UBSAN is to *detect* undefined behavior, but continue.

If we wanted to crash on undefined behavior, we'd just leave it alone,
without any compiler option.

Think of it this way: you have a user (corporate-speak: "customer")
that is seeing behavior you can't figure out. You enable a lot of
these debug options to see "are they triggering something I can't
trigger?".

But you want to get the *report* about that, you don't want to
actually break the users load.  You want the user to be able to do
what they always did, knowing that at least you're not making their
problem any worse. Sure, it's slower, but it should just continue as
well as it ever did.

Whatever UBSAN then detects may OR MAY NOT be the actual cause of the
user report. So no, it's not ok to say "Ahh, I found it, I will now
print out the report and crash".

So at no point is it ok to say "oh, that's undefined, so we can do
anything we want". NOT AT ALL. That's actually true in general, but
it's _particularly_ true when you build with UBSAN, since now you're
actively trying to get reports about undefined behavior, and crashing
will destroy that.

It will destroy that particularly for a kernel where crashing in an
unusual place that the developer doesn't see quite possibly means "odd
device driver". In this case it would be the particular frame buffer
the user uses - crashing there probably means that there is no output
to help debug things.

But this is actually true even for non-kernel uses: if you are running
an app as a developer, and you're looking for problems, having one
place with undefined behavior in no way means that you don't care
about any other undefined places. So crashing is literally *never* the
right thing to do.

So no, the whole "it's still undefined, so we can't return" argument
is completely broken.

                Linus
