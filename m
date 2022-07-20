Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E7957B15B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbiGTHFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiGTHFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:05:43 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFCA6159
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:05:42 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x91so22602990ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WppMfwLGRwNjAXO/HIfr6DsSf5LAYKkxw8k/p1IhbYM=;
        b=G9HmqzHBvZa1Om+TbiEeBvH1jSF+eJbCzVp7lP5rG86jZeslmEnyRszVWd8TyvlG4p
         rBXwJwE+AF/kqxB0zwuvpKY3Ug5KnoEEWXOx0olyk3ZpdPBxXhYEkB8o6MpfHjvPmYZJ
         LkXD4JJxB/4C2mX1l2szTrY6QjfpGR3I0OwnnJ73rHy8FkIN+tDC+6KPShaoLoeD851c
         ZvUN36/9YNMSrR3euNyXrgngS6kg/5ncBXp0qGdF866GspYN0g0e5AYaUiWpIscRka5e
         nBxHCWwmVZd+HcRMNoljVxvalB0QwvXUJQBLJM7W9KEjF2MTq4mjGXduT8mBgMGlTsor
         RgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WppMfwLGRwNjAXO/HIfr6DsSf5LAYKkxw8k/p1IhbYM=;
        b=PJ9/GMWpSPF6s33BVR+JP+rCHA9vy1FCWRCGqtQI7iNSuEKELm0FyJWz8kONdPdF7D
         rfFKk9yj5jdevLQpu7bSZm6s2mP3njPw5Z8LZcf47oODOL9j5CKgJURj8j78hUwlhB5+
         lM7dAWHcOS+EKQRzmq68Ck1wXgBkHG+d9kxTJn4Chc7zpafuFq1YgOg1LJqcy4+XO1ld
         qZv81GqkRE3KDjP+zJoipZjqMZcZ6VRZyKVQZtBDc3URifaSbJoLh1Mo0zbHgz4ZAFId
         keDMw/H1Y4ePoQkdnBk4BQ99VeNXK3/37kGvyYRvFowfSrhbpGBa52LdJBDM1W9KyOv2
         LI+A==
X-Gm-Message-State: AJIora8tjW+MUgSf9C+2rK0sPSWVfvEvmSWtjo0MTbv9+LAVFuwF8N92
        JJMkUuV4xCPvoxEZy8DnCRqmoNda9FnyelCbIJs=
X-Google-Smtp-Source: AGRyM1tkhyZ5VNKIW8xVpDaMC8fdp953QHSFStl/BwCZKIWB/gTwzRb8b2h365Kdi3o9aObYTS+YuCUcVcL1qUZMF5s=
X-Received: by 2002:a05:6402:2816:b0:434:ed38:16f3 with SMTP id
 h22-20020a056402281600b00434ed3816f3mr49082161ede.116.1658300741078; Wed, 20
 Jul 2022 00:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220720065744.1006305-1-zengjx95@gmail.com>
In-Reply-To: <20220720065744.1006305-1-zengjx95@gmail.com>
From:   jingxiang zeng <zengjx95@gmail.com>
Date:   Wed, 20 Jul 2022 15:05:30 +0800
Message-ID: <CAPp=jc_J7fO74ygbZJV0SqDQ3=Zj8j7VW+OAoo6wvcgAT-Y2pg@mail.gmail.com>
Subject: Re: [PATCH] mm/z3fold: do not unlock in z3fold_page_putback()
To:     vitaly.wool@konsulko.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<zengjx95@gmail.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=8820=E6=97=A5=E5=91=A8=
=E4=B8=89 14:58=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Zeng Jingxiang <linuszeng@tencent.com>
>
> z3fold_page_lock() will lock zhdr->page_lock
> 1630    z3fold_page_lock(zhdr);
>
> return without unlocking zhdr->page_lock
> 1634    if (kref_put(&zhdr->refcount, release_z3fold_page_locked))
> 1635            return;
>
> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> ---
>  mm/z3fold.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index f41f8b0d9e9a..03785832ad47 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -1632,13 +1632,14 @@ static void z3fold_page_putback(struct page *page=
)
>                 list_del_init(&zhdr->buddy);
>         INIT_LIST_HEAD(&page->lru);
>         if (kref_put(&zhdr->refcount, release_z3fold_page_locked))
> -               return;
> +               goto ret;
>         spin_lock(&pool->lock);
>         list_add(&page->lru, &pool->lru);
>         spin_unlock(&pool->lock);
>         if (list_empty(&zhdr->buddy))
>                 add_to_unbuddied(pool, zhdr);
>         clear_bit(PAGE_CLAIMED, &page->private);
> +ret:
>         z3fold_page_unlock(zhdr);
>  }
>
> --
> 2.27.0
>
Sorry, I just misunderstood the code logic, please ignore this patch.
