Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAF749F28B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 05:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346068AbiA1EgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 23:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbiA1EgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 23:36:00 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16342C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 20:35:59 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u15so8546708wrt.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 20:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NjMVNnFHw5l0SfQ5jsSi4cfE7ZyRsd0RS1s9FDyEMkM=;
        b=YuTuDc9DAfgYJkx9ivUhquM9vU+HCogTo5W5T9biL0smE3wnwMLh2lIc9HPVJcFQvw
         qkW+EhLNxQRxNVtYj16ro3C+N7J3oPFuFBvTAapIa3I5AxmSwbTONuln75vn+NqFx+zT
         U6voGOy8puLmzyQWf03ecJkq3hbxvO4NT57FAUyaNf4CYo0v5qDo44U7N2u7wfCUSOcp
         mnDM0tyHAt23lBGdUorDIratSEDq075JZTqd5rvOIW9uWV9XTon3KK/vJWMkrzFV/2jq
         hGGrK5wE9OelYNj2odHo6kcTXXBaHkgh5JW+asknpBRkmQrBeK8S3AUlgA7rKAK0oBpt
         c5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjMVNnFHw5l0SfQ5jsSi4cfE7ZyRsd0RS1s9FDyEMkM=;
        b=2fkyw7D7rIAZCrfvS4k1lUggOxKKrXM97Tht27JJplQTmXc0CD8dSJF1ThkuMS9qDO
         GCIG7KrFMwTnhel3EvEq6WT2fBJLNL17+iOCtDETJYv+PfbysXJ69MTWYTPLU/GaxCWG
         auz4PklxqWwfYgFhCWpztfKMek3xZF3s8PbnTMzgIcYMWIcadcrhcLfo1VOnsZemv7DW
         kNzHF2Wbn0hKyn0cX7hzGwRsmTjkmXKTf6HWzCP5s2lG4iT6HkV27Wzgy3PKzcMt5ttJ
         GUqVcxR2ZbC1HYvrYzi4CefbnL05qcXG5JQnb6OrN34uRwRka3TNFvwQwveemViJKVtq
         Q+2A==
X-Gm-Message-State: AOAM5313RW6TbzhGfbv8E0ozJxXeKng94qfy8o5G9a+RQVcxDEeEVjuP
        rY03FB3DsXqnUCfbCf8sgRflz+xNH06JHaBH81xO7ZoUIGU=
X-Google-Smtp-Source: ABdhPJykWubi5/tbvcApmthmKfSxqyTZFndZ1SFfaPB43XRPYsXMeGtvKxe7G2LP563J7zfVIirtGjF7g8TDEzYuwB0=
X-Received: by 2002:adf:fb05:: with SMTP id c5mr5627495wrr.220.1643344557501;
 Thu, 27 Jan 2022 20:35:57 -0800 (PST)
MIME-Version: 1.0
References: <20220127215222.159049-1-dlatypov@google.com>
In-Reply-To: <20220127215222.159049-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 28 Jan 2022 12:35:45 +0800
Message-ID: <CABVgOSnUni8Vk5BCweNgfOSFPEsFXiAegsz3FgBSd0PNL3OoTA@mail.gmail.com>
Subject: Re: [PATCH] kunit: cleanup assertion macro internal variables
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 5:52 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> All the operands should be tagged `const`.
> We're only assigning them to variables so that we can compare them (e.g.
> check if left == right, etc.) and avoid evaluating expressions multiple
> times.
>
> There's no need for them to be mutable.
>
> Also rename the helper variable `loc` to `__loc` like we do with
> `__assertion` and `__strs` to avoid potential name collisions with user
> code.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
> Note: this patch is based on top of
> https://lore.kernel.org/all/20220125210011.3817742-4-dlatypov@google.com/
> There is no semantic dependency between the patches, but they touch
> adjacent lines.
> ---

Looks good.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  include/kunit/test.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 088ff394ae94..00b9ff7783ab 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -779,10 +779,10 @@ void kunit_do_failed_assertion(struct kunit *test,
>
>  #define KUNIT_ASSERTION(test, assert_type, pass, assert_class, INITIALIZER, fmt, ...) do { \
>         if (unlikely(!(pass))) {                                               \
> -               static const struct kunit_loc loc = KUNIT_CURRENT_LOC;         \
> +               static const struct kunit_loc __loc = KUNIT_CURRENT_LOC;       \
>                 struct assert_class __assertion = INITIALIZER;                 \
>                 kunit_do_failed_assertion(test,                                \
> -                                         &loc,                                \
> +                                         &__loc,                              \
>                                           assert_type,                         \
>                                           &__assertion.assert,                 \
>                                           fmt,                                 \
> @@ -872,8 +872,8 @@ void kunit_do_failed_assertion(struct kunit *test,
>                                     fmt,                                       \
>                                     ...)                                       \
>  do {                                                                          \
> -       typeof(left) __left = (left);                                          \
> -       typeof(right) __right = (right);                                       \
> +       const typeof(left) __left = (left);                                    \
> +       const typeof(right) __right = (right);                                 \
>         static const struct kunit_binary_assert_text __text = {                \
>                 .operation = #op,                                              \
>                 .left_text = #left,                                            \
> @@ -956,7 +956,7 @@ do {                                                                               \
>                                                 fmt,                           \
>                                                 ...)                           \
>  do {                                                                          \
> -       typeof(ptr) __ptr = (ptr);                                             \
> +       const typeof(ptr) __ptr = (ptr);                                       \
>                                                                                \
>         KUNIT_ASSERTION(test,                                                  \
>                         assert_type,                                           \
> --
> 2.35.0.rc2.247.g8bbb082509-goog
>
