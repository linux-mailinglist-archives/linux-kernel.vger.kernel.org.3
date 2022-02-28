Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2D64C783D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240653AbiB1Sny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241347AbiB1Sna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:43:30 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49F219291
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:40:58 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id l12so6803544ljh.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+acwbp8IAqy4EQhdzrRR6UrvnBSYJWdfAOCkLBEf6s=;
        b=LvJ51tK8OGXmUdrq1FTGfGhAU7kyWg6aDacet+/T6m1xcdm96SFLNin6cqkfGY+rbg
         A+4gdF9QL3th8X1CIPS6F2KrwGpjUcAkZFh2wMRAAEhyIS9gK5hzhXTjv7RRLGY5VhDN
         /ORnVKar4p0KNDioI7O/8vsyY3PJ0BwGF0c/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+acwbp8IAqy4EQhdzrRR6UrvnBSYJWdfAOCkLBEf6s=;
        b=Xsk2YCjH1BxsMtyD8k9g67IbMLXR+0jZUG0FFKrMhYiaIvH0jcgL+o6Uuw8cm9U2t1
         WBmnriezVvTBtNJQoFmbqEesZUX+jHP/Oa9wbNK010toBC6GRk1eMPmJPudXJCmiS4MZ
         rMV4afeAsjAkjk+csTdfEQ0T2afz9gFZ0IRxGcKmUZzcTVO6Vl+hdm1V8kGgdmc8D+mN
         CQ69tC5eJTm6x1M3E7gCEOw55D6vyklgX/v4BtG6+zJNc25OKm35HsF+GU/6vsCE9Yfd
         QnxsNWGwHAKhvlcyKJccYQlyCjEQJ2bB1GyHGAd66h6jl2y8YcZ6ZKTS1AiEJjL0b46w
         DFMw==
X-Gm-Message-State: AOAM5319JLHtVimPYbPUgWGOVYQhzSs88zjb8GKRKtN4YpGnT6Jk/hub
        J3c5FGEbqcf9Oiq2nu9H8F/jg6QIWCz7MmoZMqI=
X-Google-Smtp-Source: ABdhPJz8WvhtNMkIdzY1pBlzX3esIhyq5Vg3x7P1ZKec9wAngAVuzQNEZdKmO2ZZksTGzoo1yQ/cKg==
X-Received: by 2002:a2e:681a:0:b0:23e:6350:e442 with SMTP id c26-20020a2e681a000000b0023e6350e442mr15256179lja.454.1646073656980;
        Mon, 28 Feb 2022 10:40:56 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id k14-20020a192d0e000000b00443c399e462sm1085859lfj.160.2022.02.28.10.40.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 10:40:55 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id f37so22888951lfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:40:55 -0800 (PST)
X-Received: by 2002:ac2:4c8c:0:b0:445:6c26:3cff with SMTP id
 d12-20020ac24c8c000000b004456c263cffmr13670491lfl.435.1646073655129; Mon, 28
 Feb 2022 10:40:55 -0800 (PST)
MIME-Version: 1.0
References: <20220228103142.3301082-1-arnd@kernel.org> <YhyxML05rjJ/57Vk@FVFF77S0Q05N>
 <CAK8P3a0CTmtUq+Uba2S3D7wjSstew2M+LfzZoOcKdKK9cfXO9A@mail.gmail.com>
In-Reply-To: <CAK8P3a0CTmtUq+Uba2S3D7wjSstew2M+LfzZoOcKdKK9cfXO9A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Feb 2022 10:40:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjU+DCbFG4nd3Wne-KbQ1n5=BHynv3xEmRYTaayBj-EfQ@mail.gmail.com>
Message-ID: <CAHk-=wjU+DCbFG4nd3Wne-KbQ1n5=BHynv3xEmRYTaayBj-EfQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] Kbuild: move to -std=gnu11
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>, llvm@lists.linux.dev,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>, Hu Haowen <src.res@email.cn>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Marco Elver <elver@google.com>
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

On Mon, Feb 28, 2022 at 3:37 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> I think the KBUILD_USERCFLAGS portion and the modpost.c fix for it
> make sense regardless of the -std=gnu11 change

I do think they make sense, but I want to note again that people doing
cross builds obviously use different tools for user builds than for
the kernel. In fact, even not cross-building, we've had situations
where the "kbuild" compiler is different from the host compiler,
because people have upgraded one but not the other (upgrading the
kernel build environment is actually much easier than upgrading the
host build environment, because you don't need all the random
libraries etc, and you can literally _just_ build your own gcc and
binutils)

And we have *not* necessarily required that the host tools match the
kernel tools.

So I could well imagine that there are people who build their kernels,
but their host build environment might be old enough that -std=gnu11
is problematic for that part.

And note how any change to  KBUILD_USERCFLAGS is reflected in KBUILD_HOSTCFLAGS.

So I would suggest that the KBUILD_USERCFLAGS part of the patch (and
the modpost.c change that goes with it) be done as a separate commit.
Because we might end up reverting that part.

Hmm?

           Linus
