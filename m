Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0BB551DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347814AbiFTOYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351057AbiFTOYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:24:07 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29FF1FA6D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:40:02 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id l11so18987771ybu.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WS4VFRwLCNQ3Gv6onv6Grnwt8jHHc1O3704ajv1HwX8=;
        b=oe3RFUCFtQsf2C6GbVuLT4H9zsB2uSOBU8ynW0d58tLz9eliKUvPOnd7yGRq8ujcgj
         bQEYRUlPrSOo51iJQlpJvSxpxQ3NW5hhBldbwTnE/1cHebxP6baEdZoUlcfKnPC7hA+D
         ItrLiJO0KmnQCCN4GpecieYlpdTU5X+JyGAdi06uXyJA68eQnMEtAPDwqXeC7qw7x9CL
         DH7/GUHyMf2n/Okv3gqxzoJ8M9p35Lk+Nvyj1OYHvn3XtR8EJ3EVwIlh93wnrX0ufJjy
         dSx7vAqQTl7KhADa5j36BnlSMSoazoQtyrN1iTgjB6TAXwv2f/IVdtHQwUDhiXtB/OpE
         xQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WS4VFRwLCNQ3Gv6onv6Grnwt8jHHc1O3704ajv1HwX8=;
        b=ZFDDxSYJtANTndM1NixHGOshNfn0ncrL0aSNz0NZ0jxVZvM2ky0NShGggZm8aaURuK
         kOSx3jDYWdVeAhHQpkg/EyoISOBriouAUBptMd2kyznsUUE1L0MIYLU5vC79m8r7ynYy
         RvyNeFVFyxl667CPbVNpAGhJpf2jnu/rMHhfw1bxNdKvHoJHkepEBI57xg5uAGTf4WoX
         oVxGkdWA4d6zogf8eeMxWt9dPHhaElnaK9ConnbcqEKwbqWSbbROynBSN70VcqwoEB2+
         5v5qye3djxouoKnTjjHZcG/UScIX/GYLTOPX9K5ZDbtVuehBMgs4KJz1tzJzE+eTd8Mp
         E/fw==
X-Gm-Message-State: AJIora/NFMi78Btnfo16TsgNRfaXxNIsF7zpk1MePWL+zbsoHTyqQtTP
        ATPC00/sWifAJNdvWypTIG3gi3d05VsDcebP+ndvqg==
X-Google-Smtp-Source: AGRyM1vRcYVHrLrEyrWcPlNUihQGx+K0o4UAIjdcz+oIlc3j+a6xk8wSBx8O7GIO95PC80xMSGoFy4rwkBtYrU3IeMI=
X-Received: by 2002:a25:94a:0:b0:668:df94:fdf4 with SMTP id
 u10-20020a25094a000000b00668df94fdf4mr10943765ybm.425.1655732401678; Mon, 20
 Jun 2022 06:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655150842.git.andreyknvl@google.com> <91406e5f2a1c0a1fddfc4e7f17df22fda852591c.1655150842.git.andreyknvl@google.com>
In-Reply-To: <91406e5f2a1c0a1fddfc4e7f17df22fda852591c.1655150842.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Jun 2022 15:39:25 +0200
Message-ID: <CANpmjNMB6gJjqXuXBOnDtnEncNoKHcZKxsUU_Mc_y8=KFg=W2g@mail.gmail.com>
Subject: Re: [PATCH 01/32] kasan: check KASAN_NO_FREE_META in __kasan_metadata_size
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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

On Mon, 13 Jun 2022 at 22:15, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> __kasan_metadata_size() calculates the size of the redzone for objects
> in a slab cache.
>
> When accounting for presence of kasan_free_meta in the redzone, this
> function only compares free_meta_offset with 0. But free_meta_offset could
> also be equal to KASAN_NO_FREE_META, which indicates that kasan_free_meta
> is not present at all.
>
> Add a comparison with KASAN_NO_FREE_META into __kasan_metadata_size().
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>
> This is a minor fix that only affects slub_debug runs, so it is probably
> not worth backporting.
> ---
>  mm/kasan/common.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index c40c0e7b3b5f..968d2365d8c1 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -223,8 +223,9 @@ size_t __kasan_metadata_size(struct kmem_cache *cache)
>                 return 0;
>         return (cache->kasan_info.alloc_meta_offset ?
>                 sizeof(struct kasan_alloc_meta) : 0) +
> -               (cache->kasan_info.free_meta_offset ?
> -               sizeof(struct kasan_free_meta) : 0);
> +               ((cache->kasan_info.free_meta_offset &&
> +                 cache->kasan_info.free_meta_offset != KASAN_NO_FREE_META) ?
> +                sizeof(struct kasan_free_meta) : 0);
>  }
>
>  struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/91406e5f2a1c0a1fddfc4e7f17df22fda852591c.1655150842.git.andreyknvl%40google.com.
