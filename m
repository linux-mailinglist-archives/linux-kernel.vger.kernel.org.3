Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B2F495A99
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378965AbiAUHWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378974AbiAUHWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:22:09 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470CAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 23:22:08 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id f202-20020a1c1fd3000000b0034dd403f4fbso16905542wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 23:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCDndzprpmt8J8usmKa7r2GPdiDYtq7skjq7Pt9qfoQ=;
        b=QCieyO2kWXOr2DpiaXjV/KoX0Ajl448G0dwUzo5kFvqqHD+IYgOEWSaLoumC64fH+4
         4WQmmdLfAcGfCBE3LinJAo8VRmm5vsnbjF3J41VI/t+mXMZHZs2ozW2asmlBn6quEDw2
         Q4/oktIaczLAp/vvLHBIcAL3W0KFaLxgcYE/lxkAi/ERhywyvgukWpevBJiB4uS7xsLW
         K3GW98SeDrSQivgDdskRd5jIzKEAcCNfJcY0ztF4wvIdYe+jHnUHN3nyohL7790zsvay
         bUx4UhrKQ0tMFPrVBJZihVTryBa6772zfAlcNWK80mNhVXbnLSEwvxdYuCdz+IOIK1ue
         3Ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCDndzprpmt8J8usmKa7r2GPdiDYtq7skjq7Pt9qfoQ=;
        b=1Gm/0mx5AtG4SPsVQsJE9vLrj6gcHfuo4czLejoMrHVpo8eqjoEvR0CsMcYIoIhLoM
         w+QO/EoYFgkRDOnkWj9mPffIBTYFNzFUBcfTB9xPKA1nJ0QmRPSBCK8U9jfNQEZ3gG9J
         C6ctQtXRD2FQjHYF7s0SaqMoOjZXaXdISHWsJRjxmG4c8IYaYzqJXOpdT+q016zTkJCo
         EX2FKdWv1wiLfnopnGIOh9dqDlS7xe/lXHkYWkOKXWvZsIXvrXRb/PGqiAwdc770B4Yj
         x/pCkAnez23NtsDULy2Gn+37FAXPHHrBSwzTJsgSZLeITwUpS52CvFPuquRKphDQ8sIe
         LpxQ==
X-Gm-Message-State: AOAM533gAGSOfyNi+euBX2/JQnxD4vORUkDhlTu7aSvR+T+ovLFDexbr
        QCmzL6GZGdD2d36oGYcCzlS1ErrmF74rRRuqjeIMkQ==
X-Google-Smtp-Source: ABdhPJwa2l4w+YMQCxgTiMyfE2V4Eg+RSPSv3p5PwiJiRNK0dQzi5wFKTN2Ihmrz4SgnjSWeAoUoeI5O4nozegoZEmE=
X-Received: by 2002:a05:6000:1786:: with SMTP id e6mr2580030wrg.177.1642749726698;
 Thu, 20 Jan 2022 23:22:06 -0800 (PST)
MIME-Version: 1.0
References: <20220118223506.1701553-1-dlatypov@google.com> <20220118223506.1701553-5-dlatypov@google.com>
In-Reply-To: <20220118223506.1701553-5-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 21 Jan 2022 15:21:55 +0800
Message-ID: <CABVgOS=srLPwLxpdPGK4CPXmcz-FC0G1-zUAiMnYq1XLuy5BUQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] kunit: decrease macro layering for integer asserts
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

On Wed, Jan 19, 2022 at 6:35 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Introduce a KUNIT_BINARY_INT_ASSERTION for the likes of KUNIT_EXPECT_LT.
> This is analagous to KUNIT_BINARY_STR_ASSERTION.
>
> Note: this patch leaves the EQ/NE macros untouched since those share
> some intermediate macros for the pointer-based macros.

I didn't like this until I realised the next patch in the series fixes it. :-)

>
> The current macro chain looks like:
> KUNIT_EXPECT_LT_MSG => KUNIT_BASE_LT_MSG_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
> KUNIT_EXPECT_GT_MSG => KUNIT_BASE_GT_MSG_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
> <ditto for LE, GE, and ASSERT variants>
>
> After this change:
> KUNIT_EXPECT_LT_MSG => KUNIT_BINARY_INT_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
> KUNIT_EXPECT_GT_MSG => KUNIT_BINARY_INT_ASSERTION => KUNIT_BASE_BINARY_ASSERTION
>
> I.e. we've traded all the unique intermediary macros for a single shared
> KUNIT_BINARY_INT_ASSERTION. The only difference is that users of
> KUNIT_BINARY_INT_ASSERTION also need to pass the operation (==, <, etc.).
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

This also seems like a win to me. While I'm not a huge fan of passing
the operation into macros in general, it's so clearly an improvement
here (and we're doing it elsewhere in the macros with good results)
that I think it's a good idea in this case.

Reviewed-by: David Gow <davidgow@google.com>


-- David

>  include/kunit/test.h | 199 +++++++++++--------------------------------
>  1 file changed, 51 insertions(+), 148 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index d5dc1ef68bfe..48cf520b69ce 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -920,77 +920,28 @@ do {                                                                             \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BASE_LT_MSG_ASSERTION(test,                                     \
> -                                   assert_class,                              \
> -                                   ASSERT_CLASS_INIT,                         \
> -                                   assert_type,                               \
> -                                   left,                                      \
> -                                   right,                                     \
> -                                   fmt,                                       \
> -                                   ...)                                       \
> -       KUNIT_BASE_BINARY_ASSERTION(test,                                      \
> -                                   assert_class,                              \
> -                                   ASSERT_CLASS_INIT,                         \
> -                                   assert_type,                               \
> -                                   left, <, right,                            \
> -                                   fmt,                                       \
> -                                   ##__VA_ARGS__)
> -
> -#define KUNIT_BASE_LE_MSG_ASSERTION(test,                                     \
> -                                   assert_class,                              \
> -                                   ASSERT_CLASS_INIT,                         \
> -                                   assert_type,                               \
> -                                   left,                                      \
> -                                   right,                                     \
> -                                   fmt,                                       \
> -                                   ...)                                       \
> -       KUNIT_BASE_BINARY_ASSERTION(test,                                      \
> -                                   assert_class,                              \
> -                                   ASSERT_CLASS_INIT,                         \
> -                                   assert_type,                               \
> -                                   left, <=, right,                           \
> -                                   fmt,                                       \
> -                                   ##__VA_ARGS__)
> -
> -#define KUNIT_BASE_GT_MSG_ASSERTION(test,                                     \
> -                                   assert_class,                              \
> -                                   ASSERT_CLASS_INIT,                         \
> +#define KUNIT_BINARY_EQ_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
> +       KUNIT_BASE_EQ_MSG_ASSERTION(test,                                      \
> +                                   kunit_binary_assert,                       \
> +                                   KUNIT_INIT_BINARY_ASSERT_STRUCT,           \
>                                     assert_type,                               \
>                                     left,                                      \
>                                     right,                                     \
>                                     fmt,                                       \
> -                                   ...)                                       \
> -       KUNIT_BASE_BINARY_ASSERTION(test,                                      \
> -                                   assert_class,                              \
> -                                   ASSERT_CLASS_INIT,                         \
> -                                   assert_type,                               \
> -                                   left, >, right,                            \
> -                                   fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BASE_GE_MSG_ASSERTION(test,                                     \
> -                                   assert_class,                              \
> -                                   ASSERT_CLASS_INIT,                         \
> -                                   assert_type,                               \
> -                                   left,                                      \
> -                                   right,                                     \
> -                                   fmt,                                       \
> +#define KUNIT_BINARY_INT_ASSERTION(test,                                      \
> +                                  assert_type,                                \
> +                                  left,                                       \
> +                                  op,                                         \
> +                                  right,                                      \
> +                                  fmt,                                        \
>                                     ...)                                       \
>         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
> -                                   assert_class,                              \
> -                                   ASSERT_CLASS_INIT,                         \
> -                                   assert_type,                               \
> -                                   left, >=, right,                           \
> -                                   fmt,                                       \
> -                                   ##__VA_ARGS__)
> -
> -#define KUNIT_BINARY_EQ_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
> -       KUNIT_BASE_EQ_MSG_ASSERTION(test,                                      \
>                                     kunit_binary_assert,                       \
>                                     KUNIT_INIT_BINARY_ASSERT_STRUCT,           \
>                                     assert_type,                               \
> -                                   left,                                      \
> -                                   right,                                     \
> +                                   left, op, right,                           \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> @@ -1034,46 +985,6 @@ do {                                                                             \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_LT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
> -       KUNIT_BASE_LT_MSG_ASSERTION(test,                                      \
> -                                   kunit_binary_assert,                       \
> -                                   KUNIT_INIT_BINARY_ASSERT_STRUCT,           \
> -                                   assert_type,                               \
> -                                   left,                                      \
> -                                   right,                                     \
> -                                   fmt,                                       \
> -                                   ##__VA_ARGS__)
> -
> -#define KUNIT_BINARY_LE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
> -       KUNIT_BASE_LE_MSG_ASSERTION(test,                                      \
> -                                   kunit_binary_assert,                       \
> -                                   KUNIT_INIT_BINARY_ASSERT_STRUCT,           \
> -                                   assert_type,                               \
> -                                   left,                                      \
> -                                   right,                                     \
> -                                   fmt,                                       \
> -                                   ##__VA_ARGS__)
> -
> -#define KUNIT_BINARY_GT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
> -       KUNIT_BASE_GT_MSG_ASSERTION(test,                                      \
> -                                   kunit_binary_assert,                       \
> -                                   KUNIT_INIT_BINARY_ASSERT_STRUCT,           \
> -                                   assert_type,                               \
> -                                   left,                                      \
> -                                   right,                                     \
> -                                   fmt,                                       \
> -                                   ##__VA_ARGS__)
> -
> -#define KUNIT_BINARY_GE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
> -       KUNIT_BASE_GE_MSG_ASSERTION(test,                                      \
> -                                   kunit_binary_assert,                       \
> -                                   KUNIT_INIT_BINARY_ASSERT_STRUCT,           \
> -                                   assert_type,                               \
> -                                   left,                                      \
> -                                   right,                                     \
> -                                   fmt,                                       \
> -                                   ##__VA_ARGS__)
> -
>  #define KUNIT_BINARY_STR_ASSERTION(test,                                      \
>                                    assert_type,                                \
>                                    left,                                       \
> @@ -1259,12 +1170,11 @@ do {                                                                           \
>         KUNIT_EXPECT_LT_MSG(test, left, right, NULL)
>
>  #define KUNIT_EXPECT_LT_MSG(test, left, right, fmt, ...)                      \
> -       KUNIT_BINARY_LT_MSG_ASSERTION(test,                                    \
> -                                     KUNIT_EXPECTATION,                       \
> -                                     left,                                    \
> -                                     right,                                   \
> -                                     fmt,                                     \
> -                                     ##__VA_ARGS__)
> +       KUNIT_BINARY_INT_ASSERTION(test,                                       \
> +                                  KUNIT_EXPECTATION,                          \
> +                                  left, <, right,                             \
> +                                  fmt,                                        \
> +                                   ##__VA_ARGS__)
>
>  /**
>   * KUNIT_EXPECT_LE() - Expects that @left is less than or equal to @right.
> @@ -1281,12 +1191,11 @@ do {                                                                           \
>         KUNIT_EXPECT_LE_MSG(test, left, right, NULL)
>
>  #define KUNIT_EXPECT_LE_MSG(test, left, right, fmt, ...)                      \
> -       KUNIT_BINARY_LE_MSG_ASSERTION(test,                                    \
> -                                     KUNIT_EXPECTATION,                       \
> -                                     left,                                    \
> -                                     right,                                   \
> -                                     fmt,                                     \
> -                                     ##__VA_ARGS__)
> +       KUNIT_BINARY_INT_ASSERTION(test,                                       \
> +                                  KUNIT_ASSERTION,                            \
> +                                  left, <=, right,                            \
> +                                  fmt,                                        \
> +                                   ##__VA_ARGS__)
>
>  /**
>   * KUNIT_EXPECT_GT() - An expectation that @left is greater than @right.
> @@ -1303,12 +1212,11 @@ do {                                                                           \
>         KUNIT_EXPECT_GT_MSG(test, left, right, NULL)
>
>  #define KUNIT_EXPECT_GT_MSG(test, left, right, fmt, ...)                      \
> -       KUNIT_BINARY_GT_MSG_ASSERTION(test,                                    \
> -                                     KUNIT_EXPECTATION,                       \
> -                                     left,                                    \
> -                                     right,                                   \
> -                                     fmt,                                     \
> -                                     ##__VA_ARGS__)
> +       KUNIT_BINARY_INT_ASSERTION(test,                                       \
> +                                  KUNIT_EXPECTATION,                          \
> +                                  left, >, right,                             \
> +                                  fmt,                                        \
> +                                   ##__VA_ARGS__)
>
>  /**
>   * KUNIT_EXPECT_GE() - Expects that @left is greater than or equal to @right.
> @@ -1325,12 +1233,11 @@ do {                                                                           \
>         KUNIT_EXPECT_GE_MSG(test, left, right, NULL)
>
>  #define KUNIT_EXPECT_GE_MSG(test, left, right, fmt, ...)                      \
> -       KUNIT_BINARY_GE_MSG_ASSERTION(test,                                    \
> -                                     KUNIT_EXPECTATION,                       \
> -                                     left,                                    \
> -                                     right,                                   \
> -                                     fmt,                                     \
> -                                     ##__VA_ARGS__)
> +       KUNIT_BINARY_INT_ASSERTION(test,                                       \
> +                                  KUNIT_EXPECTATION,                          \
> +                                  left, >=, right,                            \
> +                                  fmt,                                        \
> +                                   ##__VA_ARGS__)
>
>  /**
>   * KUNIT_EXPECT_STREQ() - Expects that strings @left and @right are equal.
> @@ -1536,12 +1443,11 @@ do {                                                                           \
>         KUNIT_ASSERT_LT_MSG(test, left, right, NULL)
>
>  #define KUNIT_ASSERT_LT_MSG(test, left, right, fmt, ...)                      \
> -       KUNIT_BINARY_LT_MSG_ASSERTION(test,                                    \
> -                                     KUNIT_ASSERTION,                         \
> -                                     left,                                    \
> -                                     right,                                   \
> -                                     fmt,                                     \
> -                                     ##__VA_ARGS__)
> +       KUNIT_BINARY_INT_ASSERTION(test,                                       \
> +                                  KUNIT_EXPECTATION,                          \
> +                                  left, <, right,                             \
> +                                  fmt,                                        \
> +                                   ##__VA_ARGS__)
>  /**
>   * KUNIT_ASSERT_LE() - An assertion that @left is less than or equal to @right.
>   * @test: The test context object.
> @@ -1557,12 +1463,11 @@ do {                                                                           \
>         KUNIT_ASSERT_LE_MSG(test, left, right, NULL)
>
>  #define KUNIT_ASSERT_LE_MSG(test, left, right, fmt, ...)                      \
> -       KUNIT_BINARY_LE_MSG_ASSERTION(test,                                    \
> -                                     KUNIT_ASSERTION,                         \
> -                                     left,                                    \
> -                                     right,                                   \
> -                                     fmt,                                     \
> -                                     ##__VA_ARGS__)
> +       KUNIT_BINARY_INT_ASSERTION(test,                                       \
> +                                  KUNIT_ASSERTION,                            \
> +                                  left, <=, right,                            \
> +                                  fmt,                                        \
> +                                   ##__VA_ARGS__)
>
>  /**
>   * KUNIT_ASSERT_GT() - An assertion that @left is greater than @right.
> @@ -1579,12 +1484,11 @@ do {                                                                           \
>         KUNIT_ASSERT_GT_MSG(test, left, right, NULL)
>
>  #define KUNIT_ASSERT_GT_MSG(test, left, right, fmt, ...)                      \
> -       KUNIT_BINARY_GT_MSG_ASSERTION(test,                                    \
> -                                     KUNIT_ASSERTION,                         \
> -                                     left,                                    \
> -                                     right,                                   \
> -                                     fmt,                                     \
> -                                     ##__VA_ARGS__)
> +       KUNIT_BINARY_INT_ASSERTION(test,                                       \
> +                                  KUNIT_EXPECTATION,                          \
> +                                  left, >, right,                             \
> +                                  fmt,                                        \
> +                                   ##__VA_ARGS__)
>
>  /**
>   * KUNIT_ASSERT_GE() - Assertion that @left is greater than or equal to @right.
> @@ -1601,12 +1505,11 @@ do {                                                                           \
>         KUNIT_ASSERT_GE_MSG(test, left, right, NULL)
>
>  #define KUNIT_ASSERT_GE_MSG(test, left, right, fmt, ...)                      \
> -       KUNIT_BINARY_GE_MSG_ASSERTION(test,                                    \
> -                                     KUNIT_ASSERTION,                         \
> -                                     left,                                    \
> -                                     right,                                   \
> -                                     fmt,                                     \
> -                                     ##__VA_ARGS__)
> +       KUNIT_BINARY_INT_ASSERTION(test,                                       \
> +                                  KUNIT_ASSERTION,                            \
> +                                  left, >=, right,                            \
> +                                  fmt,                                        \
> +                                   ##__VA_ARGS__)
>
>  /**
>   * KUNIT_ASSERT_STREQ() - An assertion that strings @left and @right are equal.
> --
> 2.34.1.703.g22d0c6ccf7-goog
>
