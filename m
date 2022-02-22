Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08614C0072
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbiBVRvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiBVRvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:51:18 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78C01680A2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:50:52 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2d646fffcc2so183615487b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9xVaMbyiCTyGVqLYvVRvUgZYTi80RFry9SG8JbTIuM=;
        b=E7oEHcm+ntyxOhoqbMu+HSBjq0dpxawKzssjfQF1nJrK/A7c8zAU4F1uFDmbT6cmSl
         RJDJWlz3bXfYH9pxdVKWEF10fZFGfTDqUUVwR3P3I0iXOaRcUueIPJLRKaGW+pJmO30n
         vBmqwJWmUIJ09UVSQ270yISMqFCxdOslp1quL9cgbsVXdDGbECPdHsZSOjlOuxHtLWyH
         cZIz/PXqfF3sST4Sn6uJVNgfoK/6BP1zCnIaQMz3xBwgJxRJOtwgKG2a3iaAKjTs1WxO
         8TfUqEHXnx85HRX5dXNvAd468gci2yERMHCZbeDMtk/+1Anr3FYyb4bcu6ac8uMOz2J/
         7dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9xVaMbyiCTyGVqLYvVRvUgZYTi80RFry9SG8JbTIuM=;
        b=KIW3i3uG1DQ1RR+VfHUqAamKcgoG9vEh7/BvDqY07CWsGlKdJxL12yEbsYi9s39ICp
         HRviRcKlqgHWOnwXdp87Sdbfq2PquzayZsMOPiB7mbenKTucZzZ9rfD68KU/3EVaiEqb
         7cWAAIpu4ODDdfZ5sjpriek5wX3qBJF+tjtTujMmZf8oFpZwfB8ls1TCllu28rNdVl+m
         s0q8eVZkujKXoSH83rmi4iilGB4YuY0iNZf2Y41gZ9N/rVW/9m4fVHOo+CYv83PrpMEw
         /EHnFHRWHc7LX2C8C+TVuBdMtJgyeExLuH95xdLBNjeh55cDecOeYdTsd5G8GD+ZPRIC
         +i7g==
X-Gm-Message-State: AOAM5332BdWAf6U0kv/BSN2smJk5JVCU88XW7tI5Tntk6XhftybFGc4T
        lfPy8Zw0UG9qbXwwOM73QnMCamCOpLMxlYpK5ufm8Q==
X-Google-Smtp-Source: ABdhPJx10vs403agr7Ha9dQrnJxuqut368Zs9E6OP/cT8QB4W05q1e1Ho91pZzmrt8lFJt9MKq3jtwau3zHsctXBbdg=
X-Received: by 2002:a81:743:0:b0:2ca:287c:6ca2 with SMTP id
 64-20020a810743000000b002ca287c6ca2mr24456433ywh.327.1645552251533; Tue, 22
 Feb 2022 09:50:51 -0800 (PST)
MIME-Version: 1.0
References: <2d44632c4067be35491b58b147a4d1329fdfcf16.1645549750.git.andreyknvl@google.com>
In-Reply-To: <2d44632c4067be35491b58b147a4d1329fdfcf16.1645549750.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 22 Feb 2022 18:50:40 +0100
Message-ID: <CANpmjNOnr=B_o83BJ6b1S6FKWe+p2vR58H8CHtGPNPnu6-cQZg@mail.gmail.com>
Subject: Re: [PATCH mm] another fix for "kasan: improve vmalloc tests"
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        kernel test robot <lkp@intel.com>
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

On Tue, 22 Feb 2022 at 18:10, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> set_memory_rw/ro() are not exported to be used in modules and thus
> cannot be used in KUnit-compatible KASAN tests.
>
> Drop the checks that rely on these functions.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  lib/test_kasan.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index ef99d81fe8b3..448194bbc41d 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -1083,12 +1083,6 @@ static void vmalloc_helpers_tags(struct kunit *test)
>         KUNIT_ASSERT_TRUE(test, is_vmalloc_addr(ptr));
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vmalloc_to_page(ptr));
>
> -       /* Make sure vmalloc'ed memory permissions can be changed. */
> -       rv = set_memory_ro((unsigned long)ptr, 1);
> -       KUNIT_ASSERT_GE(test, rv, 0);
> -       rv = set_memory_rw((unsigned long)ptr, 1);
> -       KUNIT_ASSERT_GE(test, rv, 0);

You can still test it by checking 'ifdef MODULE'. You could add a
separate test which is skipped if MODULE is defined. Does that work?
