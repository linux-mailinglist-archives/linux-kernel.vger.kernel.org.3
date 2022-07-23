Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67B157EC56
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 08:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiGWGdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 02:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiGWGdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 02:33:40 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA65452450
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 23:33:35 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id a7so1534488vkl.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 23:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BfpIOV/6ZvhwkFNNi8F5n6UGeETzcQ0Ic7VQTjCcaxA=;
        b=T8THoq6U5rrJ6eOYnptWyaffD33E8b6arT8i7Fvu3PMM8WjwopfPP7FK1MCR60/LUT
         60AtWKe+av+lrxVtHbOkq/NrgxArG9NWpVkOG5aeXSb6XMu6rClL+ux9fBwdxEbNhuqm
         XUNCmj12Ktce3ApVxwtETXUylNRuzEhZOswTa6YdbyZOHYH78pzWpJWwlf5NQCQNNidK
         xBojGlWIXKPodPmAwsuVy87Ad/RTWLR9YR08ZcqELX6Hkj5d1MPhq3h/wkOGSXAA75A7
         cKeoulaRK+6zV4LFnZuO8ZT9RO38M+MBT9hsYhy5WuNHt8vmJ1ZMjH8RCUG7OjKAvB2x
         nUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BfpIOV/6ZvhwkFNNi8F5n6UGeETzcQ0Ic7VQTjCcaxA=;
        b=bsb11lYLp2cA7IcZH9P7SL2ynsWiBLaEmiefmlHu7fHS55AmfetfQ9Q/iNwTNblfvR
         5Os02KX7RLv5lTWk89cZCQLZ5QGWqsLd1EFbYR6q4k8MhM2/F3WYgsuXyWRR1z4k0OKr
         766lqcjHVBewbam+2rtJb4tPTJ3UKSeQBKmVkaRfxcnJimyk+X2b9SVtApV9GJKnHuSt
         iRgIFCryUyMVcfe9GOKMz32Gk3CLIcq7s6xt28B3OQ+VPhZweDs8AvZunad7UZOowW7g
         APHoug0ujL63zElUCi72OFubcWFBrW88ZdBmBA3kj9rc1UYMlVCMCInS5nWsggLi6+ru
         Rn+w==
X-Gm-Message-State: AJIora+Iu1XR4A+6nYcacC2A93Qs4nfimuP5P3oiHuTMZ1gUTKUcMmUS
        UUE6JaPFNflY+KawYBgjf5tuff3JmFw30H2MhoNTeg==
X-Google-Smtp-Source: AGRyM1tRd8CzElUHBeDtzmGnV1yUfi7c8RHRAmVBCaCVgIsof/b/Ob6GDs1QKgyF8YI4pAW5kXGdCY+RBq7EcApefuw=
X-Received: by 2002:a1f:bf54:0:b0:375:fdf2:e014 with SMTP id
 p81-20020a1fbf54000000b00375fdf2e014mr938673vkf.4.1658558014485; Fri, 22 Jul
 2022 23:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220722171534.3576419-1-dlatypov@google.com> <20220722171534.3576419-5-dlatypov@google.com>
In-Reply-To: <20220722171534.3576419-5-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 23 Jul 2022 14:33:23 +0800
Message-ID: <CABVgOS=pbEhUn3Hm7hrtQSQcqmj9a5T1MXNgomtbjsFc1RaphA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] kunit: make kunit_kfree(NULL) a no-op to match kfree()
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

On Sat, Jul 23, 2022 at 1:15 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> The real kfree() function will silently return when given a NULL.
> So a user might reasonably think they can write the following code:
>   char *buffer = NULL;
>   if (param->use_buffer) buffer = kunit_kzalloc(test, 10, GFP_KERNEL);
>   ...
>   kunit_kfree(test, buffer);
>
> As-is, kunit_kfree() will mark the test as FAILED when buffer is NULL.
> (And in earlier times, it would segfault).
>
> Let's match the semantics of kfree().
>
> Suggested-by: David Gow <davidgow@google.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
> v1 -> v2: add this patch to the series.
> ---

Thanks! This looks good to me, and worked with a basic test.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/test.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index c7ca87484968..879c8db36cb5 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -698,6 +698,9 @@ static inline bool kunit_kfree_match(struct kunit *test,
>
>  void kunit_kfree(struct kunit *test, const void *ptr)
>  {
> +       if (!ptr)
> +               return;
> +
>         if (kunit_destroy_resource(test, kunit_kfree_match, (void *)ptr))
>                 KUNIT_FAIL(test, "kunit_kfree: %px already freed or not allocated by kunit", ptr);
>  }
> --
> 2.37.1.359.gd136c6c3e2-goog
>
