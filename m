Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55062591CC0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 23:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240991AbiHMViM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 17:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240986AbiHMViJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 17:38:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA7127B0A
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 14:38:08 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y3so5213789eda.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pJARGpYDRG1Jl/rpwzXhVmN1AU3CPPfwsaLJnAGsXAU=;
        b=cGbBvlx6n7XyT6C3og9s4r5BWLakWyXg0ooz0frMES8mhFJIpDwHSlooUIsagfxrFh
         a/EXAPLQOjke/H1apCB4rNCjDu+y5KJk5Bad7OIB5a94D2pKbjoVtNy+WnZdRypOiTIE
         +6PewrzivrtgxLIhNx5Cjrs+lkgEKK89hWFC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pJARGpYDRG1Jl/rpwzXhVmN1AU3CPPfwsaLJnAGsXAU=;
        b=z09uj/n47fGX55rkcVVyo9NRT2pslBS5gIgpgA4Phm/GIq3O0suPY8jKNmJGFhdbT7
         oTqSzOL8zZwN6oJwaku+WzShHUdDBTbHYlctw6pjp6zZNVp5JT5cvFW3ftMPdhXCo6Eu
         9sJiMtUUz+XyQmfWvysiCuvPGuk+oVcKi3PdxZytq7Qinm0lzhCZBS2ZwKdjwboZ0DgU
         HRL0DZAvdFrf3H01E0fX+4kS0OeEtDmcfBsvngoaqmod9Aqt4C4OPAwP8KTm0KME99vc
         sjb+RKMS1CoNyEbx4JGB60bYxl65oDbMfOqbxDKBWaxXC5KyB3Rwo3bq8knBgs1O7bfI
         /Y+w==
X-Gm-Message-State: ACgBeo2elkqJpUBYImtqYf2l9bSZye5IcgEc8yC/gwVk60MN1b9+rcU6
        wg0lSRlY7EjAu52S4eBclklyDLAi9j75iixg
X-Google-Smtp-Source: AA6agR6SJavLcFhxoSzQL3F3QHHvHd3tmFm0XAVNTG54q0VSlWwv6jWh17bv47xib/86xvyTUdqtQA==
X-Received: by 2002:a05:6402:501d:b0:443:1c7:ccb9 with SMTP id p29-20020a056402501d00b0044301c7ccb9mr8650183eda.101.1660426687332;
        Sat, 13 Aug 2022 14:38:07 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id 15-20020a170906318f00b007314a01766asm2250393ejy.211.2022.08.13.14.38.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Aug 2022 14:38:06 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id r83-20020a1c4456000000b003a5cb389944so2058919wma.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 14:38:06 -0700 (PDT)
X-Received: by 2002:a1c:f603:0:b0:3a5:23ca:3e7c with SMTP id
 w3-20020a1cf603000000b003a523ca3e7cmr6229444wmc.38.1660426685890; Sat, 13 Aug
 2022 14:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <YvfGY2qnl2YXrUgX@shikoro>
In-Reply-To: <YvfGY2qnl2YXrUgX@shikoro>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Aug 2022 14:37:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGmhaE-Y8GqWKPtWYOi=bOarFgo7UkzHNoOVEKnkXXrQ@mail.gmail.com>
Message-ID: <CAHk-=wjGmhaE-Y8GqWKPtWYOi=bOarFgo7UkzHNoOVEKnkXXrQ@mail.gmail.com>
Subject: Re: [PULL REQUEST] i2c-for-5.20-part2
To:     Wolfram Sang <wsa@kernel.org>, Julia Lawall <julia.lawall@inria.fr>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
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

On Sat, Aug 13, 2022 at 8:42 AM Wolfram Sang <wsa@kernel.org> wrote:
>
> * subsystem-wide move from strlcpy to strscpy

Hmm.

Looking around, we still do have a lot of those 'strlcpy()' users, but
99% of them don't use the return value.

And since 'strlcpy()' is complete and utter garbage exactly *BECAUSE*
of the bad return value (it returns the length of the source string -
but an untrusted and possibly unterminated source string is often the
*problem* in the first place), that would make it fairly easy to
convert the rest.

I see two possibilities:

 (a) fix strlcpy() by making it return 'void', and leave all those 99%
of users alone, and convert the (few) cases that actually look at the
return value to strscpy

 (b) auto-convert (with a coccinelle script) all the 'strlcpy()' users
that don't care about the return value, and leave a few broken users
of strlcpy around

I think (b) is the simpler thing, but I have no idea how to write a
coccinelle patch that basically does "if return value of strlcpy is
not used, convert the strlcpy to a strscpy".

I'd love to get rid of strlcpy() entirely, since it's such a horribly
badly designed thing.

                  Linus
