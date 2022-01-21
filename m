Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF682495A94
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378945AbiAUHWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378912AbiAUHV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:21:57 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBC3C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 23:21:56 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso12468141wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 23:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3CrLAhHri6cW7ge5sJ5mw2A/ImHNlJKr/VuNGqWz4kw=;
        b=m5S5VWVhb+cg0vapaRftt4gkZ1W0KfvP07ZZ1t0HTKbr9d+dFs2IgWRGb6TbEK2e1L
         zUzxbtW1kQO6YAfwDI+xp8libeaa23DDtRwFC6WT0jCuv2u/lq2waA/MpljtzyHALje4
         mTvAjdLHL2cs7nuhbt0GJKTLZVaXT4loISsejC0yURPHQxdBAnqxaOe1FDvmc44UFRnt
         a6Yoitgr8DYqw1bosKyXya7LAZQFUq4gcPyjoHo3GI751r7QufdK8u+ECHuqJMHdZM9c
         U99OeA2cvsBp5/m645kRNB0gNGNdee0l99CLSjsQsETTPZK6sm1IfuENFbpngA9yfNTt
         0WNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3CrLAhHri6cW7ge5sJ5mw2A/ImHNlJKr/VuNGqWz4kw=;
        b=WnvxzutFsrcp8XBVuK5Z4dKvrfj8ONSYe8macIzSCwltVWLD2D0Fm6mO8otEWmt1VY
         y0DUVnnQTFsa4ByEwdoTkp0/gix1dAjLFbg9YYAyIzDHLn33/RERxIyKP1g3LLVVY3uG
         SU/bkm1nJ+dXhsQOZ4kMh9emmAY69jy7FP17AJwS1ESkBWQBkb9Y+CACnD9wGwSpFIXk
         EnLULZ0/hV3zc//t7v0nCJivyyR+rpnQ6UPxT6+/guaEioXYbD3smQ6vgJ5gKpL1v20c
         D9KsbHfVSSs06UNB81r1y16+JWdH60p4NH0uGmzj7JrI07KznGVyFeXGCZDyVP49YLGd
         rMcA==
X-Gm-Message-State: AOAM532/NUIhsuYCF25OPuLgwnTgd9WykQYqcZWQJgz/zFzms/F+hrg6
        fdtCqVVOY1cGR4PPSY77JDcgr6889dFKA3zBzFBGig==
X-Google-Smtp-Source: ABdhPJwohDIXrdLpuEbLWAz2ODrca7mxD95P2+aqpcfyNr9ZWv0FukkVThQIUPjiU3jxvkcYy2vI4hqAU2aiLr1aXBI=
X-Received: by 2002:a5d:6d85:: with SMTP id l5mr2682374wrs.447.1642749715107;
 Thu, 20 Jan 2022 23:21:55 -0800 (PST)
MIME-Version: 1.0
References: <20220118223506.1701553-1-dlatypov@google.com> <20220118223506.1701553-3-dlatypov@google.com>
In-Reply-To: <20220118223506.1701553-3-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 21 Jan 2022 15:21:42 +0800
Message-ID: <CABVgOSmZuOgMMEQqzQDo=mdtBmnZZEkXohBzViJQw3bdxnzheA@mail.gmail.com>
Subject: Re: [PATCH 2/5] kunit: drop unused intermediate macros for ptr
 inequality checks
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 6:35 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> We have the intermediate macros for KUNIT_EXPECT_PTR_GT() and friends,
> but these macros don't exist.
>
> I can see niche usecases for these macros existing, but since we've been
> fine without them for so long, let's drop this dead code.
>
> Users can instead cast the pointers and use the other GT/LT macros.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Agreed: while I can sort-of see why one might want to use something
like this for bounds checking, casting to an integer is definitely
acceptable (and we've got things like KASAN and fortify-source for
many bounds-checking cases anyway).

Also, many languages explicitly treat pointers as not being comparable
this way anyway, and rely on casting to integer, which is a trend
worth following, I think.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  include/kunit/test.h | 60 --------------------------------------------
>  1 file changed, 60 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index b032dd6816d2..c021945a75e3 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -1044,21 +1044,6 @@ do {                                                                            \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,                                       \
> -                                         assert_type,                         \
> -                                         left,                                \
> -                                         right,                               \
> -                                         fmt,                                 \
> -                                         ...)                                 \
> -       KUNIT_BASE_LT_MSG_ASSERTION(test,                                      \
> -                                   kunit_binary_ptr_assert,                   \
> -                                   KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
> -                                   assert_type,                               \
> -                                   left,                                      \
> -                                   right,                                     \
> -                                   fmt,                                       \
> -                                   ##__VA_ARGS__)
> -
>  #define KUNIT_BINARY_LE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
>         KUNIT_BASE_LE_MSG_ASSERTION(test,                                      \
>                                     kunit_binary_assert,                       \
> @@ -1069,21 +1054,6 @@ do {                                                                            \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,                                       \
> -                                         assert_type,                         \
> -                                         left,                                \
> -                                         right,                               \
> -                                         fmt,                                 \
> -                                         ...)                                 \
> -       KUNIT_BASE_LE_MSG_ASSERTION(test,                                      \
> -                                   kunit_binary_ptr_assert,                   \
> -                                   KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
> -                                   assert_type,                               \
> -                                   left,                                      \
> -                                   right,                                     \
> -                                   fmt,                                       \
> -                                   ##__VA_ARGS__)
> -
>  #define KUNIT_BINARY_GT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
>         KUNIT_BASE_GT_MSG_ASSERTION(test,                                      \
>                                     kunit_binary_assert,                       \
> @@ -1094,21 +1064,6 @@ do {                                                                            \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,                                       \
> -                                         assert_type,                         \
> -                                         left,                                \
> -                                         right,                               \
> -                                         fmt,                                 \
> -                                         ...)                                 \
> -       KUNIT_BASE_GT_MSG_ASSERTION(test,                                      \
> -                                   kunit_binary_ptr_assert,                   \
> -                                   KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
> -                                   assert_type,                               \
> -                                   left,                                      \
> -                                   right,                                     \
> -                                   fmt,                                       \
> -                                   ##__VA_ARGS__)
> -
>  #define KUNIT_BINARY_GE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
>         KUNIT_BASE_GE_MSG_ASSERTION(test,                                      \
>                                     kunit_binary_assert,                       \
> @@ -1119,21 +1074,6 @@ do {                                                                            \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,                                       \
> -                                         assert_type,                         \
> -                                         left,                                \
> -                                         right,                               \
> -                                         fmt,                                 \
> -                                         ...)                                 \
> -       KUNIT_BASE_GE_MSG_ASSERTION(test,                                      \
> -                                   kunit_binary_ptr_assert,                   \
> -                                   KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
> -                                   assert_type,                               \
> -                                   left,                                      \
> -                                   right,                                     \
> -                                   fmt,                                       \
> -                                   ##__VA_ARGS__)
> -
>  #define KUNIT_BINARY_STR_ASSERTION(test,                                      \
>                                    assert_type,                                \
>                                    left,                                       \
> --
> 2.34.1.703.g22d0c6ccf7-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220118223506.1701553-3-dlatypov%40google.com.
