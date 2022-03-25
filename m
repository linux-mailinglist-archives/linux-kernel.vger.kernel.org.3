Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44AB4E7B79
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiCYRaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 13:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245046AbiCYR3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 13:29:43 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960F61020
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:28:07 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r22so11209794ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yIMApoDu0cSTb9UHBH+0bGiaMNz8inAICwvHUwG31uM=;
        b=fImwDEmarxWlMb6gMb1DB3uyeS0b4STGPcZKODQdrNUIGD5G9Kqoh0FWkcCAPqbziQ
         HIDiJvpOAZ/Hvsyijyg/cAIgAtvr9nzllE3BZOBmRvLYdvbfnrL0+xcorU8NV97pFVmz
         6HjdVE2BWnwep3mBHwh1GU9827E94rVX0KV9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIMApoDu0cSTb9UHBH+0bGiaMNz8inAICwvHUwG31uM=;
        b=EnXfrDKCz2EpL5S85Tzf85Fk5uLExkaJhYpAn1MfcOfvFVdSQT0EAuGc+o9+mCj6Wk
         mVxR/7Zb32eGGjS9TLiL9ZxxO33/BYbgeddQfgA6iWhR0Oah5/LDdCH8YgPt2AlWb6L4
         B+fYE48VMlMuBo+5x57fH2W3UxBMev0i5Xvmo3WBZHJT4bG+NoKnHOKBI5T0gOssbHA5
         tMAMtHGXEDaTLpNBxHbwAKcpm0xDSlbdFvTY+BzwSRHKiFIbWIAXYfPuzbX1rKKnvVVY
         VsXI1PfsD24CmB7sWBTmIQ1TzesUc2R0r+DsxXHajmeDbaDvxdRd9Q+cT0Oh8vcQzzk9
         gAQg==
X-Gm-Message-State: AOAM533N06HbC/JbwZmz1YkXwxpCotD3Mont/lp1F1+uo5VgAlsaqC6Y
        b4d5i/IhWXFxS7yv+WH6BV7ESiUYTd5Fpb+2IYg=
X-Google-Smtp-Source: ABdhPJxTnDLMKEu9PxHqWuQS3ZgJNLV3IJlZxH8BzaEn2xjj98lEIG/7/7EMAmhfgvAaQQAalxVyUg==
X-Received: by 2002:a05:6512:1387:b0:44a:2d7b:adca with SMTP id p7-20020a056512138700b0044a2d7badcamr8592038lfa.680.1648228834334;
        Fri, 25 Mar 2022 10:20:34 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id p9-20020a056512312900b0044a5312dcbcsm766983lfd.89.2022.03.25.10.20.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 10:20:33 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id q5so11162810ljb.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:20:32 -0700 (PDT)
X-Received: by 2002:a2e:a5c4:0:b0:249:9ec3:f2b with SMTP id
 n4-20020a2ea5c4000000b002499ec30f2bmr8829088ljp.358.1648228831778; Fri, 25
 Mar 2022 10:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220325131348.3995-1-andriy.shevchenko@linux.intel.com> <CAK7LNAR9HS7LK5D-07i8_tFcwd=uiHEFu05n0t_UuFZExcfBpw@mail.gmail.com>
In-Reply-To: <CAK7LNAR9HS7LK5D-07i8_tFcwd=uiHEFu05n0t_UuFZExcfBpw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Mar 2022 10:20:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGsKD=DYgYqYUDzGKT8BOPLhqebw2YB6PCuZenE3qEzA@mail.gmail.com>
Message-ID: <CAHk-=wjGsKD=DYgYqYUDzGKT8BOPLhqebw2YB6PCuZenE3qEzA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Makefile.extrawarn: Turn off -Werror when extra
 warnings are enabled
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
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

On Fri, Mar 25, 2022 at 7:35 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> WERROR should not be enabled for regular builds.

No.

WERROR should be on for regular builds.

It's W=1 that is questionable. It enables warnings that are often
false positives, and if you use W=1 (and particularly W=2) then that's
_your_ problem.

W=1 is most definitely not "regular builds". It's only for people who
want to deal with crazy compiler warnings.

I want WERROR on as widely as possible, because I'm really sick and
tired of developers not noticing when they add warnings because they
did a "regular build"

Stop this idiocy where you think warnings are acceptable.

                Linus
