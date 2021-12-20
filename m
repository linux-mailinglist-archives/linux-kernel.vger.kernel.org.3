Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9524B47B1D9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240022AbhLTRHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240025AbhLTRHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:07:31 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9045FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:07:30 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id s139so16681132oie.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2fOqYYhEHrIQH3EGI+nA0MRIDmpXYHQDdPKYEFCJPU=;
        b=DbzOy6XXO9Cu3gUCRkwnAGcf4VCW9K4svhQ22lRY8Jo2hT9gjOufJm/YrKqeweHBm7
         ofH/3w2veyxrdbknRhThz5XuBgM3/BIebH0WVZciGuhP5UK8oeO9snEbCfyk7s6WOVy/
         CjghKnwPEf0ZRwhbG1SM3dCi756DLR9xkNufQBSIIEHAyioeusQdyVacfqdqCkKKKRPE
         TbRY/ry1gZlHS6i2rEIJjUTOFT6hdNsbalFImshTp7NTLyRPmlvBr4y5BRVv3d82HdjT
         hfmhV8Ma2XfflwERnNTn/xZmNjvEUtKia8LC8XuHKF32DbA8mszouf6rLKSGP4/QGkT9
         LMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2fOqYYhEHrIQH3EGI+nA0MRIDmpXYHQDdPKYEFCJPU=;
        b=iFSed0fC7oMwElCY29NPYEiwq4rp/UyKd1yJQZG5J1fGCZsV4ca7nMLRAKtO9qLQGN
         Q1as3IJ4NSS5pRa+9VdZPHJcl/tiul3rmJaznNyXPms5Vh0p/2pbDH9AkKeZFL2BFJlV
         wjftO/y55+ICxeCAmS2kHI2H2QwNb9cQZWl7hJqGT9JSEwLZclOZzFPe3kvaIDPqhNXR
         vFK1ZHUhgs8fAIi4O3uuw58Yrucm5sqXDDOUyqC4w7qPhUkI5XJli8hVr2/8fgz7fDtr
         3kww2eMMqfwyWvts/BIYOscuVcp+ovI4tfSxQybYi6s6kyH2Pf2l/cOGT4M0PqDc3v1R
         Tq2Q==
X-Gm-Message-State: AOAM530p7JUv1chhNOJxzX3fP3e+qsfOEGRxSTOzSVuS10XdlacGJjOq
        /VgP3+5EkRd+QQe0B4qXmf2eEbwYL8FPVju/Sv/5Dg==
X-Google-Smtp-Source: ABdhPJwGvvq1EwhlNnfRxWt9o1B+wPNGDptAa9msVK50zubAZFr19kF1QX90/CoT41/VLy2U+d3HS1tS+tVNshcfEtE=
X-Received: by 2002:a05:6808:118c:: with SMTP id j12mr12803071oil.65.1640020048260;
 Mon, 20 Dec 2021 09:07:28 -0800 (PST)
MIME-Version: 1.0
References: <a746b5baebbf79f8160c1fe09d6f8a5ab7bde1d7.1640017993.git.andreyknvl@google.com>
In-Reply-To: <a746b5baebbf79f8160c1fe09d6f8a5ab7bde1d7.1640017993.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Dec 2021 18:07:17 +0100
Message-ID: <CANpmjNP11JKCEE328XomcReP7uBwZ=da=SD5OS09N4co-WPhMQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix quarantine conflicting with init_on_free
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

On Mon, 20 Dec 2021 at 17:37, <andrey.konovalov@linux.dev> wrote:
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
> ---
>  mm/kasan/quarantine.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index 587da8995f2d..2e50869fd8e2 100644
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
> +               memset(meta, 0, sizeof(*meta));

memzero_explicit()

although in this case it probably doesn't matter much, because AFAIK
memzero_explicit() only exists to prevent the compiler from eliding
the zeroing. Up to you.

> +
>         /*
>          * As the object now gets freed from the quarantine, assume that its
>          * free track is no longer valid.
> --
> 2.25.1
>
