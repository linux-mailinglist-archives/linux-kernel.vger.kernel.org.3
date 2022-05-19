Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E8452CCA5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiESHOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiESHOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:14:31 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451E563F0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:14:30 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2ec42eae76bso47492497b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m4dkMUBjXmr29DvEu0d7QY2KaK3h+KI8JPQ8UIjV1nc=;
        b=ncHRyuryZDkR9T6KwBhdvmfTdnAe4BGbnp+zbgHgPV0y8KTH3fZACSGswVkNnuJNSO
         +cWvux3fhUOd+fQHIWJn1GlH3AkcQPDPHrylAV31iuD0QPxQwPV5E+wze30wY8Dd9/Bz
         jei+9+6NmzwObudOZpdcZ9+CK3gkUJ7EO4Arc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4dkMUBjXmr29DvEu0d7QY2KaK3h+KI8JPQ8UIjV1nc=;
        b=DlH6Q+s5oFd59MGzVGppjzRnG51LyWLo6Ak1KL5R6ea9+h3qDaXVs16QrEWF9MZS1R
         Krj0T70H9+95xk3BKz3c1qL76T50ksCMi8uCRoY5Ybxw2EoJpgSar1uPQevIqjrsCJFr
         k3dMzlpR43HKnd1PDC8IWmFbMPCXMJ4Kc6AaKzBf1/O2aXS30fgpNeFPZRzGwf/fs1TY
         9AYe719cNPknbmel1zmce20sZvIa7zEbPasLZlg6r2CL4wq5hW9dfVBbz1Rz6a25BKq9
         nYCOLRkoRRL0LOMWfgTzJ9gt6Arw4CgT0Sz2OsE3jmfUQjNrQlJj4SjEXV+CX3R879kS
         ONiQ==
X-Gm-Message-State: AOAM532R54fx5bOhW95yk+wsZXh5VMDZhjkmhTNpZgtX+dkZso+H3QDl
        64I8/oYt8kN9izLaI0CnNdGRG4PBykH9FV8v8lD+uw==
X-Google-Smtp-Source: ABdhPJwHCiCtOihK3wf0xQOM/tNKltnbYn/XzVurFQjmOkO9x7QCVrZKymk7KwDLe0/jLMrgd2fiZVlaLJi43mFdlc4=
X-Received: by 2002:a0d:ca82:0:b0:2ff:4451:7591 with SMTP id
 m124-20020a0dca82000000b002ff44517591mr3209343ywd.352.1652944469482; Thu, 19
 May 2022 00:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220429064051.61552-1-linmiaohe@huawei.com> <20220429064051.61552-8-linmiaohe@huawei.com>
In-Reply-To: <20220429064051.61552-8-linmiaohe@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Thu, 19 May 2022 09:14:18 +0200
Message-ID: <CAM4kBBJF0p2gtytL5NDx2Vovbokx0LJHsjdP45H6T=fnXUGZDQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] mm/z3fold: always clear PAGE_CLAIMED under z3fold
 page lock
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 8:40 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Think about the below race window:
>
> CPU1                            CPU2
> z3fold_reclaim_page             z3fold_free
>  test_and_set_bit PAGE_CLAIMED
>  failed to reclaim page
>  z3fold_page_lock(zhdr);
>  add back to the lru list;
>  z3fold_page_unlock(zhdr);
>                                  get_z3fold_header
>                                  page_claimed=test_and_set_bit PAGE_CLAIMED
>
>  clear_bit(PAGE_CLAIMED, &page->private);
>
>                                  if (!page_claimed) /* it's false true */
>                                   free_handle is not called
>
> free_handle won't be called in this case. So z3fold_buddy_slots will leak.
> Fix it by always clear PAGE_CLAIMED under z3fold page lock.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/z3fold.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index a1c150fc8def..4a3cd2ff15b0 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -1221,8 +1221,8 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
>                 return;
>         }
>         if (test_and_set_bit(NEEDS_COMPACTING, &page->private)) {
> -               put_z3fold_header(zhdr);
>                 clear_bit(PAGE_CLAIMED, &page->private);
> +               put_z3fold_header(zhdr);
>                 return;
>         }
>         if (zhdr->cpu < 0 || !cpu_online(zhdr->cpu)) {
> @@ -1424,8 +1424,8 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
>                         spin_unlock(&pool->lock);
>                         if (list_empty(&zhdr->buddy))
>                                 add_to_unbuddied(pool, zhdr);
> -                       z3fold_page_unlock(zhdr);
>                         clear_bit(PAGE_CLAIMED, &page->private);
> +                       z3fold_page_unlock(zhdr);
>                 }
>
>                 /* We started off locked to we need to lock the pool back */
> @@ -1577,8 +1577,8 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
>         if (!z3fold_page_trylock(zhdr))
>                 return -EAGAIN;
>         if (zhdr->mapped_count != 0 || zhdr->foreign_handles != 0) {
> -               z3fold_page_unlock(zhdr);
>                 clear_bit(PAGE_CLAIMED, &page->private);
> +               z3fold_page_unlock(zhdr);
>                 return -EBUSY;
>         }
>         if (work_pending(&zhdr->work)) {

Reviewed-by: Vitaly Wool <vitaly.wool@konsulko.com>
> --
> 2.23.0
>
