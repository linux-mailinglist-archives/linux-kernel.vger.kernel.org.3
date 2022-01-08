Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282EA4885CC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 21:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiAHUKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 15:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiAHUKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 15:10:45 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0057BC061401
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 12:10:44 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id q25so27734532edb.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 12:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iD4a6uEwkGzhV9ZR3rAuaktGDkUY36sehuvaU03nU68=;
        b=J70dfVCkP/UVwSADaOG5pn4SSuDU7kItk7Cqr9eOGU9m+lL+cf5Qr2M0YZghxqCW2X
         rWU11Dg45fCALxmXodChTlsQ+/F/d2Ojhy0FXgXd2eBh4ASKNF14wrPxDJFpEKbkxpc0
         rNE49ua/InyqlBx/ml5LyWO1hbjLd7i4czvbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iD4a6uEwkGzhV9ZR3rAuaktGDkUY36sehuvaU03nU68=;
        b=emkbwhCM8fJ8DEBn/mkNEkO6zLuqN3vHFDQjL+6i1hqSLW9njO7QvNkRdZupQ5J3E9
         l+hj33r61HzsBLpU/WanTo5B5+dBUgHymuo83srWM4jalsKmKY06krnBZYAXUxcsaExo
         pgUn9iXXSFqA8RuF/aCPleQWvZJCvCu92YSKzIeA3qxOdNYvMFybrBxqGP6Cfut7Uyod
         pFy5ob4nfxDZShN1UMHRUbwXjnJlHxlCKRwaLR9BML+6jOUbg8QTFDScOAPuPlLlaOEC
         aWW7uK0Ng9PF4CRqmL/+R1F0cEblyzwtsfmBWvfR07fpNN7ZKOibaGiTRgqt+YzWmadO
         qrKA==
X-Gm-Message-State: AOAM532XPRhmPEtHEc5zfM/qrbs8qgOVKs3/rCgDgTEHbZNV3Z3IseJ/
        IYc/V/uJgUEXnAZdaV26N8TiQ57JAfNS5Kp5
X-Google-Smtp-Source: ABdhPJzjreIXMX+1yYtjdVTPAG6V08OQ3ts92QaMigF+ufnA31PiYzAXAj//8Uw2BIMn7KTLLI0fug==
X-Received: by 2002:a05:6402:27cf:: with SMTP id c15mr62564010ede.390.1641672643154;
        Sat, 08 Jan 2022 12:10:43 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id q18sm1124449eds.11.2022.01.08.12.10.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jan 2022 12:10:42 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id v6so18256098wra.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 12:10:42 -0800 (PST)
X-Received: by 2002:adf:eeca:: with SMTP id a10mr14312457wrp.274.1641672642052;
 Sat, 08 Jan 2022 12:10:42 -0800 (PST)
MIME-Version: 1.0
References: <20220108112229.v3d7enmuibypa5tm@earth.universe>
In-Reply-To: <20220108112229.v3d7enmuibypa5tm@earth.universe>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Jan 2022 12:10:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh55h__rC6+RTH7pLLTbnBuuOXPNzGGswVDGN7C6NW1pQ@mail.gmail.com>
Message-ID: <CAHk-=wh55h__rC6+RTH7pLLTbnBuuOXPNzGGswVDGN7C6NW1pQ@mail.gmail.com>
Subject: Re: [GIT PULL] power-supply fixes for 5.16
To:     Sebastian Reichel <sre@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 8, 2022 at 3:22 AM Sebastian Reichel <sre@kernel.org> wrote:
>
> 2. Replace 1E6L with NSEC_PER_MSEC to avoid floating point calculation
>    in LLVM resulting in a build failure

So I think the patch is obviously the right thing to do regardless,
but that still makes me go "WTF?"

Those uses of 1E6L were perhaps strange, but they were only used in
constant compile-time expressions that were cast to 'unsigned long' in
the end, so how the heck did llvm end up with any floating point in
there?

In this case there was really no excuse not to just use a better
constant, but there are other situations where it might well be quite
reasonable to use floating point calculations to create an integer
constant (eg maybe some spec describes an algorithm in FP, but the
implementation uses fixed-point arithmetic and has initializers that
do the conversion).

Imagine for a moment that you want to do fixed-point math (perhaps
because you have a microcontroller without an FP unit - it's not
limited to just "the kernel doesn't do FP"). Further imagine just for
a moment that you still want some fundamental constants like PI in
that fixed-point format.

The sane way to generate said constants is to do something like

      #define FIXPT_1 (1u << FIXPT_SHIFT)
      #define FIXPT_FP(x) ((fixpt_t) (((x)*FIXPT_1)+0.5))
      #define FIXPT_PI FIXPT_FP(3.14159265)

rather than have to do something incredibly stupid and illogical and
unreadable like

    #define FIXPT_PI 205887

So honestly, this seems to be just llvm being completely stupid. The
fact that you don't want to generate floating point code has *NOTHING*
to do with floating point literals for constant expressions.

In fact, even if you don't want to generate floating point code -
again, maybe you don't have a FP unit - doesn't mean that you might
not want to generate normal floating point constants. You may end up
having explicit software floating point, and doing things like passing
the floating point values around manually, ie

        union fp {
            uint64_t val;
            double fp_val;
       };

and having code like

        static const union fp sqrt2 = { .fp_val = 1.4142.... };

and then doing all the math in 'uint64_t' just because you wrote a
couple of math routines yourself:

        fp_mul(&res,  sqrt2.val, x);

again, there's no floating point *code* generated, but that doesn't
mean that the compiler shouldn't allow users to use floating point
*values*.

Sadly, I see in the LLVM discussions that the llvm people seem to be
completely out to lunch and in denial, and claim "maybe this is a gcc
bug".

No. Gcc just isn't being stupid.

Nathan, Nick, please talk some sense into the llvm people. The two
examples above are very much not about the Linux kernel (although I
think we actually have a couple of places that do things exactly like
that) they are about generic coding issues.

              Linus
