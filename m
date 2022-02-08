Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91864AE12B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385053AbiBHSnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385243AbiBHSmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:42:47 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37966C0611DB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:42:45 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id c6so52545629ybk.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 10:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/wpZic7Pvz+TsDyuU6lHPsRfMMkUmLxvHW1ooX7tgs4=;
        b=gaYYFlmOdYHJMDrmJcxW5Vwb6rcpbXxvMdj+tvzvZIFO5haSmHbfkt7qcyyLwRH0qN
         jvXhDdYfMLVRHEz0YO1xiH2AafDHKpeGLOw+4zKTruz5KZOotfFkDOe5UY5ph2s8xE4n
         JYGPNgWjkAMarxQNA4WKxyoQCx2MRnkIt5zcb2BtCw/TOw7IzfCvQ91pHG/9ARaBM7ph
         haMw5YjwR8V8MIJkQOcMDB4Ah7NBJQ5COnEpzo80c/SWOrukQwfwliTM1jEL64Fv/iAm
         xSIDmqFV+wJpTrV2WcOjCxXdW10DQWOd6OUlhSeYqqElibpVxTlhOk5MhJW3DJ265jOy
         l3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/wpZic7Pvz+TsDyuU6lHPsRfMMkUmLxvHW1ooX7tgs4=;
        b=DouQWH87uOu8QFcUjzUIw2TGUX8VpvPQHuJ975esjNc+OGVk2vU1xEn5894BdhtbsA
         n81ZB2K8Ug4OL61xIqZBy3H2oRqJOHh7WWz7XHdoF+AkZdjrZxQNnGW/MaeWOXMoaHMF
         q3NDnWgVnLgOQkZiKT5LRlnElfiHCDMehcuvELRWbRY4iQ3cVPQEBCvhOognvbEP6lfn
         MPirMxJEUJdWNAdKzK2+ZHsoAObLR9rNXfTlE0SSoi7he8B50gnOQhe/4qBNnDTziOKv
         tP0h5gSBGuEO24pY1bfaUor9gcyaO7iQX3Rl5j0gS6OYdcWeAh4UP/s4EV+Uk4Dsfxm+
         BlYg==
X-Gm-Message-State: AOAM533Dy37shQPKGTjx25q2KcUcLAbrpdytAsv+THxewOmg97IGbTI/
        asDqlNaE3hPoDF/fssPVKrt3FQrQlus8GuUxHhLFyQ==
X-Google-Smtp-Source: ABdhPJzzgBhFqMGwnMviH8m/k+/Na9ar8Vld1U133z3sPwDidgZQciC0WOhjzLFQ41uD+RWtK2DX4qnr+RjAJkV+OoU=
X-Received: by 2002:a81:4741:: with SMTP id u62mr6495415ywa.512.1644345764183;
 Tue, 08 Feb 2022 10:42:44 -0800 (PST)
MIME-Version: 1.0
References: <748bd5e0bad5266a4cac52ff25232bbc314b24f5.1644345308.git.andreyknvl@google.com>
In-Reply-To: <748bd5e0bad5266a4cac52ff25232bbc314b24f5.1644345308.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 8 Feb 2022 19:42:31 +0100
Message-ID: <CANpmjNOhrPie9aWGdBeTke6yz-o+MV+G5moKB=eb9EN8Ky+f1Q@mail.gmail.com>
Subject: Re: [PATCH] kasan: test: prevent cache merging in kmem_cache_double_destroy
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

On Tue, 8 Feb 2022 at 19:37, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> With HW_TAGS KASAN and kasan.stacktrace=off, the cache created in the
> kmem_cache_double_destroy() test might get merged with an existing one.
> Thus, the first kmem_cache_destroy() call won't actually destroy it
> but will only descrease the refcount. This causes the test to fail.

s/descrease/decrease/

> Provide an empty contructor for the created cache to prevent the cache

s/contructor/constructor/

> from getting merged.
>
> Fixes: f98f966cd750 ("kasan: test: add test case for double-kmem_cache_destroy()")
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  lib/test_kasan.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 26a5c9007653..3b413f8c8a71 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -869,11 +869,14 @@ static void kmem_cache_invalid_free(struct kunit *test)
>         kmem_cache_destroy(cache);
>  }
>
> +static void empty_cache_ctor(void *object) { }
> +
>  static void kmem_cache_double_destroy(struct kunit *test)
>  {
>         struct kmem_cache *cache;
>
> -       cache = kmem_cache_create("test_cache", 200, 0, 0, NULL);
> +       /* Provide a constructor to prevent cache merging. */
> +       cache = kmem_cache_create("test_cache", 200, 0, 0, empty_cache_ctor);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
>         kmem_cache_destroy(cache);
>         KUNIT_EXPECT_KASAN_FAIL(test, kmem_cache_destroy(cache));
> --
> 2.25.1
>
