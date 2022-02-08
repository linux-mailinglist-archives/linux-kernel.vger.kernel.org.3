Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFEE4AE48E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389085AbiBHWd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386426AbiBHUcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 15:32:16 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87501C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 12:32:14 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id j14so1092077ejy.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 12:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gtsDfpCrFsnfisbUPJhBruwT+fgEbgdfMntNnmidtvM=;
        b=OgouE37mlONXTn5boL+/fmyvPcIbs4YGlNMohOcrJSJvZTWscTei0nRrlBlR9sRaU1
         o+ETGcoKZIRIy5tNRm874mJI2WJBAR2VFhJPclA+G6fbtYgbWRqrR3OGD+Q4ToeWJXlb
         KZUxeKagOPnpDSBAGcXHUoTBPzK1WOY/8J+NnrsmH7YuGcdOpFu5ENh4JZjnwy0kSIWH
         iwQPyodsMlEy2e28ISFyrdzj7cfYB3S6JCUyFI1cOT2wCY81pkDnrE9iEB0J7zs1myN8
         hhLglJfFPBiDBT9ua1Jfm5H7ODAZWluunQCTH4LFMLQhL00YmWRaEtU7nYkPJd6sC4AU
         jheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gtsDfpCrFsnfisbUPJhBruwT+fgEbgdfMntNnmidtvM=;
        b=LC9G8DoJd1+8+ri4i8QQNbTfRRCHIfmoc5Qr/z90/x2msjaUy23J2EnO2t21goiNlq
         d6mhao8IKmGE2mZ8mj3mbfecWI5zYYVVwmcbAaa/CHbC++s5V34hBoe1y8rLGfpIWMwD
         9TJIVUmpJPdgGyuIBg36COx96KKUFcWMYMBQmpHiOWGzYeVOfgyRjLnY2s8WwActMjTU
         KIjYa1rB08Vi+DofUh50CkfUnss2BUMiCl4laEamlkrVtbK2YkYLDoTwAFlviID1fjyH
         HB+vvEFjxRfaYWDa59TmHtGRty0fSqfC5wDIIjO8kuR7lSh3kK/QC6H6B17aZlGMCQSV
         8HOg==
X-Gm-Message-State: AOAM533/Q5fXY+yVRIiaj7gUwquXGRLxohzbxGeDc6QwBxuBArpRwUnZ
        GL6ZRQzZKLnBz7s0t7Ae2qQlL7N8YLX+Ceb+gzcN7RU8o9Q=
X-Google-Smtp-Source: ABdhPJyKX2QCjePrd78NKzT7Vs0ZKfpBWbGmmdWVdIe7lQvwiKYAbFCZ2zFkA5UPbCuFPWzwLZ8OwhUUUp+1Jgv18ZE=
X-Received: by 2002:a17:906:4fca:: with SMTP id i10mr4866638ejw.542.1644352332735;
 Tue, 08 Feb 2022 12:32:12 -0800 (PST)
MIME-Version: 1.0
References: <20220208040122.695258-1-davidgow@google.com>
In-Reply-To: <20220208040122.695258-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 8 Feb 2022 12:32:01 -0800
Message-ID: <CAGS_qxrrgq0v3pXGv+33KkH2NZMhx-Yt_0XEq8P2NAag4DkgLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] list: test: Add test for list_del_init_careful()
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 8:01 PM David Gow <davidgow@google.com> wrote:
>
> The list_del_init_careful() function was added[1] after the list KUnit
> test. Add a very basic test to cover it.
>
> Note that this test only covers the single-threaded behaviour (which
> matches list_del_init()), as is already the case with the test for
> list_empty_careful().
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c6fe44d96fc1536af5b11cd859686453d1b7bfd1
>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20220205061539.273330-1-davidgow@google.com/
> - Patch 1/3 unchanged
>
> ---
>  lib/list-test.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/lib/list-test.c b/lib/list-test.c
> index ee09505df16f..976e9ae1f3c5 100644
> --- a/lib/list-test.c
> +++ b/lib/list-test.c
> @@ -161,6 +161,24 @@ static void list_test_list_del_init(struct kunit *test)
>         KUNIT_EXPECT_TRUE(test, list_empty_careful(&a));
>  }
>
> +static void list_test_list_del_init_careful(struct kunit *test)
> +{
> +       /* This test doesn't check correctness under concurrent access */

nit: I personally didn't read this comment in the intended way at first.
I'd personally find something like

NOTE: this doesn't test for concurrency/memory
ordering/however-you-want-to-word-it issues

a bit more readable.

> +       struct list_head a, b;
> +       LIST_HEAD(list);
> +
> +       list_add_tail(&a, &list);
> +       list_add_tail(&b, &list);
> +
> +       /* before: [list] -> a -> b */
> +       list_del_init(&a);

Is this supposed to use list_del_init_careful(&a)?
That would make it match the name of the test case.

> +       /* after: [list] -> b, a initialised */
> +
> +       KUNIT_EXPECT_PTR_EQ(test, list.next, &b);
> +       KUNIT_EXPECT_PTR_EQ(test, b.prev, &list);
> +       KUNIT_EXPECT_TRUE(test, list_empty_careful(&a));
> +}
> +
>  static void list_test_list_move(struct kunit *test)
>  {
>         struct list_head a, b;
> @@ -707,6 +725,7 @@ static struct kunit_case list_test_cases[] = {
>         KUNIT_CASE(list_test_list_replace_init),
>         KUNIT_CASE(list_test_list_swap),
>         KUNIT_CASE(list_test_list_del_init),
> +       KUNIT_CASE(list_test_list_del_init_careful),
>         KUNIT_CASE(list_test_list_move),
>         KUNIT_CASE(list_test_list_move_tail),
>         KUNIT_CASE(list_test_list_bulk_move_tail),
> --
> 2.35.0.263.gb82422642f-goog
>
