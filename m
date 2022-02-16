Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAAB4B8530
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbiBPKCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:02:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiBPKCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:02:03 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB7C75E5E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:01:51 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id e140so4383829ybh.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6LWdrzCSVeHr2t82bSdnaI065vYCk5GbX/G1ZKc0RA=;
        b=UK52QltyXkrM0wMM/f4bYZKZG795s7LaUW25/5noaMNn05HLnozC6ZwXn3IETp10YP
         9Lfq0Bg+O7zDtXL8Dznf2kHEghY0nxQFjbcFGLr8rLeDeMtQqje/VApxMh/UJTI/DiR/
         6c0z6Cokz794PgoZiU4wivLpLpYnbuUheyvfbjDc2ijAEQfLOB5MS/QNj2Q+8gxgOA23
         zmk7Igsat5F9ewFfjec8wV3QbguluR5Z/J6AcedYeSAdfpSwosOU8PgjuMlJZ9t5n8Ql
         WpBR3cf557FR+S6t+qYZ8fDqNkLonIkpjKFBikQE9+8CcPlnPhLrXnE97hfIxjS+KTgu
         1muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6LWdrzCSVeHr2t82bSdnaI065vYCk5GbX/G1ZKc0RA=;
        b=utgzNDS1E3GS5vB2IcH9c711rBVxkveQ8pAfnSsJGXAcjFBKfDFygUAQM+hVnbcSEM
         fM7XIAgqBKQL/Tuof8Ll3nKkH14LLBYGx/Rc45cwJVnDpLu7zzKsOXI+zR+feEUr9+qx
         8L5APMD+y7OJX0TXZ78BqCVd0sYxsZAF3nO9XVYvUqvWYUcXozX4qcqf2+XTmOiknJ9q
         Rl26sgiLy+qvX1ZV0k+rPLqThwwI+Yd2DmMrtgUswcRFSGvjwgD6OjCnlfL2SewIGRM0
         VwLRD7NJWefn2FG4rQ/uTrAneSDAk9WygYLqz63rqYLWOgn5SzmW2HckvB1m41Z7I0Qz
         qCqw==
X-Gm-Message-State: AOAM532KkI4Nz07z89J7lOx4M867cIcRP3FR3cRSCjym8m3lMLi4cdha
        lunWm2oRQYKeJOufyyRAkadC9vUYfLQuM7OSfRlwuQ==
X-Google-Smtp-Source: ABdhPJyILCEt/42x2fZi87wMwuOsI9Lh/rToYatkHndVcxwT04AF24jAetxuHwWDnLECRBVSVj8PEW8HlErhTWVU1ms=
X-Received: by 2002:a81:7943:0:b0:2d0:c8bb:a45d with SMTP id
 u64-20020a817943000000b002d0c8bba45dmr1600577ywc.264.1645005710386; Wed, 16
 Feb 2022 02:01:50 -0800 (PST)
MIME-Version: 1.0
References: <865c91ba49b90623ab50c7526b79ccb955f544f0.1644950160.git.andreyknvl@google.com>
In-Reply-To: <865c91ba49b90623ab50c7526b79ccb955f544f0.1644950160.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 16 Feb 2022 11:01:39 +0100
Message-ID: <CANpmjNNtE9nYT-NKZpn3k2gwBUY_223mWOKZPgLyDQNzfygBTA@mail.gmail.com>
Subject: Re: [PATCH mm] fix for "kasan: improve vmalloc tests"
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Tue, 15 Feb 2022 at 19:39, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> vmap_tags() and vm_map_ram_tags() pass invalid page array size to
> vm_map_ram() and vm_unmap_ram(). It's supposed to be 1, but it's
> 1 << order == 2 currently.
>
> Remove order variable (it can only be 0 with the current code)
> and hardcode the number of pages in these tests.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: Marco Elver <elver@google.com>


> ---
>  lib/test_kasan.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 491a82006f06..8416161d5177 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -1149,7 +1149,6 @@ static void vmap_tags(struct kunit *test)
>  {
>         char *p_ptr, *v_ptr;
>         struct page *p_page, *v_page;
> -       size_t order = 1;
>
>         /*
>          * This test is specifically crafted for the software tag-based mode,
> @@ -1159,12 +1158,12 @@ static void vmap_tags(struct kunit *test)
>
>         KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_VMALLOC);
>
> -       p_page = alloc_pages(GFP_KERNEL, order);
> +       p_page = alloc_pages(GFP_KERNEL, 1);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p_page);
>         p_ptr = page_address(p_page);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p_ptr);
>
> -       v_ptr = vmap(&p_page, 1 << order, VM_MAP, PAGE_KERNEL);
> +       v_ptr = vmap(&p_page, 1, VM_MAP, PAGE_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, v_ptr);
>
>         /*
> @@ -1186,14 +1185,13 @@ static void vmap_tags(struct kunit *test)
>         KUNIT_EXPECT_PTR_EQ(test, p_page, v_page);
>
>         vunmap(v_ptr);
> -       free_pages((unsigned long)p_ptr, order);
> +       free_pages((unsigned long)p_ptr, 1);
>  }
>
>  static void vm_map_ram_tags(struct kunit *test)
>  {
>         char *p_ptr, *v_ptr;
>         struct page *page;
> -       size_t order = 1;
>
>         /*
>          * This test is specifically crafted for the software tag-based mode,
> @@ -1201,12 +1199,12 @@ static void vm_map_ram_tags(struct kunit *test)
>          */
>         KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_SW_TAGS);
>
> -       page = alloc_pages(GFP_KERNEL, order);
> +       page = alloc_pages(GFP_KERNEL, 1);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, page);
>         p_ptr = page_address(page);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p_ptr);
>
> -       v_ptr = vm_map_ram(&page, 1 << order, -1);
> +       v_ptr = vm_map_ram(&page, 1, -1);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, v_ptr);
>
>         KUNIT_EXPECT_GE(test, (u8)get_tag(v_ptr), (u8)KASAN_TAG_MIN);
> @@ -1216,8 +1214,8 @@ static void vm_map_ram_tags(struct kunit *test)
>         *p_ptr = 0;
>         *v_ptr = 0;
>
> -       vm_unmap_ram(v_ptr, 1 << order);
> -       free_pages((unsigned long)p_ptr, order);
> +       vm_unmap_ram(v_ptr, 1);
> +       free_pages((unsigned long)p_ptr, 1);
>  }
>
>  static void vmalloc_percpu(struct kunit *test)
> --
> 2.25.1
>
