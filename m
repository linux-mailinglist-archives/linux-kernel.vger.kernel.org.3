Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4712B4A02F9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 22:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351555AbiA1VhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 16:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351511AbiA1VhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:37:09 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDB7C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 13:37:08 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id j2so20128841ejk.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 13:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CUuoA1H1xCLa0a1bVW4NlOMKpUawKO6N9kfvmo3RGOM=;
        b=U4gZi4VClu3Fy3b0MUuy+OH+FPtbaikctEYX0ZAeCHxIky1wQ3Bv9sLZYdRg3sg8jn
         gQ1TXW9cQQmRIce4Ur/I/oZRJXONbWQcitCi62NNG88NPyiRR+VM+o4JLs4Dq6pKlLfV
         AcoEjvvNLllQuFcBUmosqPuyp+bqe3K28zBRwUKVQwN21sapCudCqhEcwXysEXBsV7MM
         sqaSGvuY3gaejvqSaltDVaWFAfdhdJzBPwug1N3YFxZG1jE3HY3ZSB96jaV2sot9rL4T
         Lk2G8s1Xc7Kjce44nsgXExVd/IwlbhuqsTeJYKLhn2asN1FSNCIKYWjURZbpdZ/y/6m3
         +bww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CUuoA1H1xCLa0a1bVW4NlOMKpUawKO6N9kfvmo3RGOM=;
        b=OJpYIa/aek0zPCc58HIFc7BBxibkIk9vojit+dxQoaNaq6Xe8IcD/lDhI6FKhyWv6Q
         /MFZelURl6+6Bw/+dmKsUCE4g/BXoCYSBOhKsXNFt/428OJ0TJWi18EyssffqeOSFLTq
         Dry70hryH6BCnB2Ge8IHvEvBMPZxw8kJ1+T8qZZfosv/tDLrJje+TGIjCE++2Vs77FbN
         HR6kWN3iNo1O8z3sT82JDAUbHjah3QtLdlP4PSxj8qXP3wPls1fBbt5dKlcP7SUPWrpi
         fLQjChPs38/4An1qiAU3UI+4plljHt4Ao2IuY4MjafoR1HXbXzpEk+ZA+veDYkjP1MzM
         2G6g==
X-Gm-Message-State: AOAM532pfRSukP4mZTwnCr9qhfklKhcBmgbj4bj8k0B2d/hLeRgIwqP1
        pFj6fUiWhyQ9psD1SAKIAh4ekQvT/onIRWzWirnW93o7qV9paA==
X-Google-Smtp-Source: ABdhPJxVAzum5yLTwHC5et+cUTTSy3/uTZLz/Hrr/hiuqjfdxn1Bg2Sxql6rOIt5SPVlxQ+oLnZsJk3HnWnNlRZVAGo=
X-Received: by 2002:a17:906:794f:: with SMTP id l15mr8765287ejo.75.1643405827189;
 Fri, 28 Jan 2022 13:37:07 -0800 (PST)
MIME-Version: 1.0
References: <20220127215222.159049-1-dlatypov@google.com> <CAFd5g47imcBAPNqrX+ZpmVzw8mgaPiBX_ip0euFAgmTA3cxitA@mail.gmail.com>
In-Reply-To: <CAFd5g47imcBAPNqrX+ZpmVzw8mgaPiBX_ip0euFAgmTA3cxitA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 28 Jan 2022 13:36:55 -0800
Message-ID: <CAGS_qxoSn16TgDUvQTUpamu1xzY85Cbqy7Qg94fyKwjE4jw7Fg@mail.gmail.com>
Subject: Re: [PATCH] kunit: cleanup assertion macro internal variables
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 1:21 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Thu, Jan 27, 2022 at 4:52 PM Daniel Latypov <dlatypov@google.com> wrot=
e:
> >
> > All the operands should be tagged `const`.
> > We're only assigning them to variables so that we can compare them (e.g=
.
> > check if left =3D=3D right, etc.) and avoid evaluating expressions mult=
iple
> > times.
> >
> > There's no need for them to be mutable.
>
> Agreed.
>
> > Also rename the helper variable `loc` to `__loc` like we do with
> > `__assertion` and `__strs` to avoid potential name collisions with user
> > code.
>
> Probably not necessary since we create a new code block (we are inside
> of an if-statement, do-while-loop, etc), but I don't really care
> either way.

You're totally right that this doesn't matter with our current macros.

given
int loc =3D 42;
KUNIT_EXPECT_TRUE(test, loc);
KUNIT_EXPECT_EQ(test, loc, 42);

becomes
do {
        if (__builtin_expect(!!(!(!!(loc) =3D=3D !!true)), 0)) {
                /* we don't use the operands in here, so `loc` is fine */
                static const struct kunit_loc loc =3D {
                        .file =3D "lib/kunit/kunit-example-test.c", .line =
=3D 25
                };
...
do {
        typeof(loc) __left =3D (loc);
        typeof(42) __right =3D (42);
        do {
                /* We never reference the expression again, so `loc` is fin=
e */
                if (__builtin_expect(!!(!(__left =3D=3D __right)), 0)) {
                        static const struct kunit_loc loc =3D {
                                .file =3D "lib/kunit/kunit-example-test.c",
                                .line =3D 24
                        };

But reminder: this was *not* the case until very recently.
Sau we didn't have my earlier patch to move the `if(!(passed))` check
into the macro.
Then we'd have issues, e.g.
../lib/kunit/kunit-example-test.c: In function =E2=80=98example_simple_test=
=E2=80=99:
../include/kunit/test.h:828:26: error: wrong type argument to unary
exclamation mark
  828 |                         !!(condition) =3D=3D !!expected_true,
                \
      |
...
../lib/kunit/kunit-example-test.c:25:9: note: in expansion of macro
=E2=80=98KUNIT_EXPECT_TRUE=E2=80=99
   25 |         KUNIT_EXPECT_TRUE(test, loc);
      |         ^~~~~~~~~~~~~~~~~

So being defensive here lets us change up our implementation more freely.

>
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
