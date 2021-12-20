Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E9F47B1DC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbhLTRIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbhLTRIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:08:52 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1F6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:08:52 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id b1-20020a4a8101000000b002c659ab1342so3275209oog.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fCui4qeVHQj0pbfWYsegbsAHNIi3Yc2XfX/ERhbLKTM=;
        b=qemlMel70nxeeXwVoJmXgUm5pDvpcQ2I0aezjxSgQEeg5pOlG2ncZg8zB6d4cn16ZB
         9u8kooreJ+71DCSNom26R0Lz6VRDIKB2iiw+FZakuugP3lr+FkRqIapKVJRn4N8jLujk
         DAQmSrKpfjYD8Gbf9ZQTSIXox42ViDjCQ667SsNnh9WyAdYwaJ/7p8gt3SP2etEupoUD
         bfcSh/Ku3gIn+xiYU2UZk+Y8l3IElcE0yDTISIeRXLkKCOhbYWnT102P+FKqUsR1vo5F
         1e22m529bfkAroV/6iaNW6aHoh8GyHWTNDL6mClMDuWiLdv4Uf5lpCTZYnXS7QPwRrYF
         NH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fCui4qeVHQj0pbfWYsegbsAHNIi3Yc2XfX/ERhbLKTM=;
        b=GKmjQs8gvU0YfqQV0nTm2zrGq7lqWwuSLLLYB1/gb8a7epQ//md9KF6wB00bf9vdwC
         dlCY5F+mpdmGgKW6ies9LJGklNw02I8VsTKl8SRvKGtRu/dONDPCAjO5X2qgINqe1Oua
         lmRNj3KeoYPSEN0eaaNZnUU4v0QWefsBe3VljeQVqixKpoC3LOhMUZVr1T3kOe4BQMqZ
         AXGjsWV0+h49Ga3aNlvsB64SbhWdGvaqzyhxWTB1YkPhXBL5t0o79K00H8H6YpSl5aCa
         w0gIzaPlKNpMsByBTrJ9110Y+tuikAYxPogcyfF57TiUSUBE2XWG3d/Bw2qISo8s2JrY
         Oefw==
X-Gm-Message-State: AOAM5327SK5FWourEu35MblRyfLavWZe4ofL/+DZdAiqSf+SbcqWwT1S
        kllbHMZIaqowwvyMmtWZEkykOH2hD6lOWOSf+7wpPg==
X-Google-Smtp-Source: ABdhPJyNJWFKkOIBkPJc552bmr2a4dVEwxBycNJiHRSED3m3Z/AVm3DoyEe94NY68p54lo7OS7VN9hwGG+kY3Cbni/w=
X-Received: by 2002:a4a:cf12:: with SMTP id l18mr10659018oos.25.1640020131872;
 Mon, 20 Dec 2021 09:08:51 -0800 (PST)
MIME-Version: 1.0
References: <aced20a94bf04159a139f0846e41d38a1537debb.1640018297.git.andreyknvl@google.com>
In-Reply-To: <aced20a94bf04159a139f0846e41d38a1537debb.1640018297.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Dec 2021 18:08:40 +0100
Message-ID: <CANpmjNP_ctXe8hZz0K2AHdSGsxr7OEYGXsdT5exk3mifHXzCmg@mail.gmail.com>
Subject: Re: [PATCH] lib/test_meminit: destroy cache in kmem_cache_alloc_bulk()
 test
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

On Mon, 20 Dec 2021 at 17:39, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Make do_kmem_cache_size_bulk() destroy the cache it creates.
>
> Fixes: 03a9349ac0e0 ("lib/test_meminit: add a kmem_cache_alloc_bulk() test")
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  lib/test_meminit.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/test_meminit.c b/lib/test_meminit.c
> index e4f706a404b3..3ca717f11397 100644
> --- a/lib/test_meminit.c
> +++ b/lib/test_meminit.c
> @@ -337,6 +337,7 @@ static int __init do_kmem_cache_size_bulk(int size, int *total_failures)
>                 if (num)
>                         kmem_cache_free_bulk(c, num, objects);
>         }
> +       kmem_cache_destroy(c);
>         *total_failures += fail;
>         return 1;
>  }
> --
> 2.25.1
>
