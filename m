Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9387C47BA62
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhLUHA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbhLUHAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:00:55 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120C3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 23:00:55 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id g79-20020a9d12d5000000b0058f08f31338so241706otg.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 23:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+5ef5JzSGQ5fXSk8VRtgDlO2+PhbXiBhrkEtspsXmP8=;
        b=K1y9AZVS+k8Chh/ds2P0r+AcB6QNzw7kvYr9qSeZIxLJTlIAo6wJGJrbsbSv0oY6TZ
         bzTuo9ZjsxpghoBXlRcBz+o/A5YLo5Y0FLf6Wked8WGqIJXebssvvwXkvW2INVUB4y9D
         cQB8+g5IZetmJfK1FZTipomWBSnLjQi7UI8qWNH2tDTgImtUiehGddZ3w70vmbgn1yBJ
         O/1zH1nPsEfUeBrAIPTbOWO17pNJY0AT7VxkpMmipRFUKxxUl7svo7VI3tGW4aXxaGCU
         XFpkV2IYqXTS1EhenMT9g+pjHDpCdRmHn0caECGNK+9EJujTN168Un7bzb+l5c4LGoEb
         75Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5ef5JzSGQ5fXSk8VRtgDlO2+PhbXiBhrkEtspsXmP8=;
        b=qWbgkOw34E2nyQ43qdxvdjIA3tBJYi+VhgMjP2uPwFFBf5FOD9p+n01ZQHOvnYb9RO
         trniLHVcIxEwAbFNqyHyHyUd2l/2a06Wz2L3GpoH6Tq/VV70OzjP6yjcJsbSv8X3iWSK
         UuUpU0OlfgAbdYaH4j3JVNpCd2q7M2nG5V3ZMXT7BNvdSj821ZYxVd+upWgKr5zguUbZ
         iJ8kuvZ8NFZCGc5HplpNNhSKj1cP+g+e2h6YquNpDjDh/KrP88dZ40HbfH6UaUEnfzR9
         0EaclEJWMPbKP1Qvvp3e94UvMl4YyKgb3xYZurRMN0sZiqNnKQ3mXfJKl86oVTkT48yT
         kf1A==
X-Gm-Message-State: AOAM532tyXl+Ig7SfS9B14kBdqwmI3f2QzLewn1UETNSknDCmhMnDGf+
        9gCsof40dqIPNEze+VfNLXAXATT4l/s2CY6oRmM2Fg==
X-Google-Smtp-Source: ABdhPJyOUkGGFxtTg3D3jNKcPQsV7mcwjLkhKTtrIneuJrvWU64vMnWKBvMiqgDd2epsSBBofVkzEW05qC0DD2s8SsA=
X-Received: by 2002:a9d:77d1:: with SMTP id w17mr1233943otl.329.1640070054151;
 Mon, 20 Dec 2021 23:00:54 -0800 (PST)
MIME-Version: 1.0
References: <2805da5df4b57138fdacd671f5d227d58950ba54.1640037083.git.andreyknvl@google.com>
In-Reply-To: <2805da5df4b57138fdacd671f5d227d58950ba54.1640037083.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 21 Dec 2021 08:00:00 +0100
Message-ID: <CANpmjNPKoKxafo22y9KVBvc52bhsX5nPr3s27y0TvdncXVyn1A@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: fix quarantine conflicting with init_on_free
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2021 at 22:56, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> KASAN's quarantine might save its metadata inside freed objects. As
> this happens after the memory is zeroed by the slab allocator when
> init_on_free is enabled, the memory coming out of quarantine is not
> properly zeroed.
>
> This causes lib/test_meminit.c tests to fail with Generic KASAN.
>
> Zero the metadata when the object is removed from quarantine.
>
> Fixes: 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and init_on_free=1 boot options")
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

Thank you.

> ---
>
> Changes v1->v2:
> - Use memzero_explicit() instead of memset().
> ---
>  mm/kasan/quarantine.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index 587da8995f2d..08291ed33e93 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -132,11 +132,22 @@ static void *qlink_to_object(struct qlist_node *qlink, struct kmem_cache *cache)
>  static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
>  {
>         void *object = qlink_to_object(qlink, cache);
> +       struct kasan_free_meta *meta = kasan_get_free_meta(cache, object);
>         unsigned long flags;
>
>         if (IS_ENABLED(CONFIG_SLAB))
>                 local_irq_save(flags);
>
> +       /*
> +        * If init_on_free is enabled and KASAN's free metadata is stored in
> +        * the object, zero the metadata. Otherwise, the object's memory will
> +        * not be properly zeroed, as KASAN saves the metadata after the slab
> +        * allocator zeroes the object.
> +        */
> +       if (slab_want_init_on_free(cache) &&
> +           cache->kasan_info.free_meta_offset == 0)
> +               memzero_explicit(meta, sizeof(*meta));
> +
>         /*
>          * As the object now gets freed from the quarantine, assume that its
>          * free track is no longer valid.
> --
> 2.25.1
>
