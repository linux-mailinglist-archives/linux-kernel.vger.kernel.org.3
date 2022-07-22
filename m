Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C16B57DB5F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiGVHfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbiGVHf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:35:28 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2654A53D20
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:35:26 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id 125so3615614vsx.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIXvAaSW5DBMQmZr/o71wlkcHcjE5t5Cw7BSqv0X5TU=;
        b=Nhacxl3MXayW7aaoYCXJWsTgzG7gbf4KkzQY+ICMD4yHn8UYPUZJNCsJ6GAYKBYKKO
         7b1NO321W5m6fG4eTUxm5B4GdORnPGMEa4oOlLf1MrW2c6e9HvwGnMNX9+EvJt5vu/TJ
         rcwm+Oqvg5k3Vt5J3rCGWtCikThPXVWBrb3Lm83QuB3zUWLtXWNjCEIP/3VZnchywQ5H
         735jptWUTIrfz69Fq00KQ1wPJCDbX5EPDhyqD3WQnYxxK9xWOL3Sp1JthMHELGqv3utv
         0R12Wupu7ZvKvKfj29EoNbm4Lt/UbrQAGV1Ic7HPfGSjoAHBu7PrwN3TDCBIyb68vZ7p
         gKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIXvAaSW5DBMQmZr/o71wlkcHcjE5t5Cw7BSqv0X5TU=;
        b=O4Rfp7uxTO7g/d/UJhePj4IgF8xEVuASz7te7mKuy2YP5gGXk1f5SMIHun9AvB1xdq
         q9y1VzGc/X+iQYketF7V3c+9e8uyH4KrmynslgQ4VcEFVPWzHtEYw1rhJhS9LA9gDCZA
         i1mFqHotvOrH+HxSYPdzUgbRFC23KWREvchBAkyUNwaHgowEBRovuMGWKsOY+n1D8JuP
         f0avnnLjY6mf2kuW8XHi3k/cd8aOD7o+d45uXNWd+R4HAHodFAy+YQHua4SRj1rY0hTK
         U2oHrP3XzPv5QOueXG0Hl1l6dU8pX1yDJ46GGZglxxD4M44mBi20l2i6F5ve0j6ftowK
         T3vw==
X-Gm-Message-State: AJIora81nx2HWMUltWcldOEm6po1Gk8lWMYfUVLCCGold5z8zUmYwKyE
        UvuS44p3SRtjErYWfXjCAACk7vfv/KIHOEUQ/n0jGQ==
X-Google-Smtp-Source: AGRyM1vChcaBz2dWLY/qMzpEDulfg11hmEElJ6QknyFZPyhzwQrGsq47B0QWAHXWymoKsaYgUZY56itiw7gyYLEW1MY=
X-Received: by 2002:a05:6102:381:b0:357:a112:adc7 with SMTP id
 m1-20020a056102038100b00357a112adc7mr624492vsq.38.1658475325123; Fri, 22 Jul
 2022 00:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220721180214.3223778-1-dlatypov@google.com> <20220721180214.3223778-4-dlatypov@google.com>
In-Reply-To: <20220721180214.3223778-4-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 22 Jul 2022 15:35:14 +0800
Message-ID: <CABVgOSkHCDt4DPRTCpSgWUSa5_5adEoqwW1fNnXyev9fK1eiuQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] kunit: make knuit_kfree() not segfault on invalid inputs
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Nit: typo in the subject line "knuit_free" --> "kunit_free"
On Fri, Jul 22, 2022 at 2:02 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> kunit_kfree() can only work on data ("resources") allocated by KUnit.
>
> Currently for code like this,
> > void *ptr = kmalloc(4, GFP_KERNEL);
> > kunit_kfree(test, ptr);
> kunit_kfree() will segfault.
>
> It'll try and look up the kunit_resource associated with `ptr` and get a
> NULL back, but it won't check for this. This means we also segfault if
> you double-free.

Personally, I don't think the case of people calling kunit_kfree() on
pointers allocated with kmalloc() is too worrying, but I do think we
should error more gracefully in cases like double-frees (and maybe
handle kfree(NULL) situations).
>
> Change kunit_kfree() so it'll notice these invalid pointers and respond
> by failing the test.
>
> Implementation: kunit_destroy_resource() does what kunit_kfree() does,
> but is more generic and returns -ENOENT when it can't find the resource.
> Sadly, unlike just letting it crash, this means we don't get a stack
> trace. But kunit_kfree() is so infrequently used it shouldn't be hard to
> track down the bad callsite anyways.

One day we should look into printing stacktraces on failed
expectations... It could be spammy in some cases, but it'd be nice to
have the option for things like this.
>
> After this change, the above code gives:
> > # example_simple_test: EXPECTATION FAILED at lib/kunit/test.c:702
> > kunit_kfree: 00000000626ec200 already freed or not allocated by kunit
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Looks good to me: this is both more correct and so much simpler as a
function. I can live without the nitpicks fixed.

Reviewed-by: David Gow <davidgow@google.com>

Thanks!
-- David

>  lib/kunit/test.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 82019a78462e..c7ca87484968 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -698,18 +698,8 @@ static inline bool kunit_kfree_match(struct kunit *test,
>
>  void kunit_kfree(struct kunit *test, const void *ptr)
>  {
> -       struct kunit_resource *res;
> -
> -       res = kunit_find_resource(test, kunit_kfree_match, (void *)ptr);
> -
> -       /*
> -        * Removing the resource from the list of resources drops the
> -        * reference count to 1; the final put will trigger the free.
> -        */
> -       kunit_remove_resource(test, res);
> -
> -       kunit_put_resource(res);
> -
> +       if (kunit_destroy_resource(test, kunit_kfree_match, (void *)ptr))
> +               KUNIT_FAIL(test, "kunit_kfree: %px already freed or not allocated by kunit", ptr);

_Maybe_ we should no-op if ptr is NULL. I think it's legal for
free()/kfree(), and while I don't see much use of it for kunit tests,
maybe it'll save someone confusion down the road.

But I could live with it either way...

>  }
>  EXPORT_SYMBOL_GPL(kunit_kfree);
>
> --
> 2.37.1.359.gd136c6c3e2-goog
>
