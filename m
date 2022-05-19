Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D857D52CCF0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbiESHZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbiESHY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:24:59 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79488023C
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:24:58 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id e78so7506192ybc.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6QjAwwxwtAPBPx+OeTR5L/KL5q3yUlrIq0gFBmYE7r8=;
        b=MV73efXzQNZHid3RSq8DxrFnQffNHwbjltUA792xVO8th6yvXTPQ0021TSNky6MRS/
         ELvAlkVAq/K4PV7sXYbiseqyl9svMlpQf0l6Hrgzm7qkEFpPjpBiokBx0oFxJ9EMhIFi
         zFpRfgXtbZEDPYwRso06NoVufse1OzIx7R4Q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6QjAwwxwtAPBPx+OeTR5L/KL5q3yUlrIq0gFBmYE7r8=;
        b=Qp4RUYGOT0mGkF5sTioE/UuBgwKcfs5bQAgEOm3aucbe9BtEOh/M5MEv/+ldVX0J1G
         fGgMxiz/aCb9TwsWQnb320dOdTPTElf0F73hShgHJqyL9RoWVPH3is8jOG1TlaDd2rIN
         UqOSsQZdUVRAxvH3jz3RrETLZ04pe5dASwfbhSEzz1YQ/a0AEv8VIKqcQb6SHfP9KTKi
         5m8vd8auwX0lY/dro/mU2nLkN7XLYHasAw94Jv6gjlOCJTTZim+LNN5vf6ZxtAey69bG
         +zJPJMVB1Rb4yFFLt9SAcVkCrZHUi687MM3bh6xOZQO+0uVTh3MDkobN0iitqgRx5WdU
         DP1A==
X-Gm-Message-State: AOAM533cVdXJK5EHnpeC+/ewBYkiMmFhIkfw0taNa/nWw1risX7s8qBs
        kISDJ99YxXqgVvbksOKB6WKhV0G1nSYPp/GMrAmVPA==
X-Google-Smtp-Source: ABdhPJxo7X7HyndWjvS5Xv8GzWtggOsI1vFJxK7ql2rSaufrLJn2KFvOfhB3bkSKLj082fcG8X4a/8OhUocsP01ptDo=
X-Received: by 2002:a05:6902:f:b0:64d:84a6:2386 with SMTP id
 l15-20020a056902000f00b0064d84a62386mr2878273ybh.437.1652945097903; Thu, 19
 May 2022 00:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220429064051.61552-1-linmiaohe@huawei.com> <20220429064051.61552-9-linmiaohe@huawei.com>
In-Reply-To: <20220429064051.61552-9-linmiaohe@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Thu, 19 May 2022 09:24:46 +0200
Message-ID: <CAM4kBB+xqh0zUJDHUaSNoDUz6nUK11CkPL0XfwEPJMA7xXEKXQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] mm/z3fold: fix z3fold_reclaim_page races with z3fold_free
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
> Think about the below scene:
>
> CPU1                            CPU2
> z3fold_reclaim_page             z3fold_free
>  spin_lock(&pool->lock)          get_z3fold_header -- hold page_lock
>  kref_get_unless_zero
>                                  kref_put--zhdr->refcount can be 1 now
>  !z3fold_page_trylock
>   kref_put -- zhdr->refcount is 0 now
>    release_z3fold_page
>     WARN_ON(!list_empty(&zhdr->buddy)); -- we're on buddy now!
>     spin_lock(&pool->lock); -- deadlock here!
>
> z3fold_reclaim_page might race with z3fold_free and will lead to pool lock
> deadlock and zhdr buddy non-empty warning. To fix this, defer getting the
> refcount until page_lock is held just like what __z3fold_alloc does. Note
> this has the side effect that we won't break the reclaim if we meet a soon
> to be released z3fold page now.
>
> Fixes: dcf5aedb24f8 ("z3fold: stricter locking and more careful reclaim")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/z3fold.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 4a3cd2ff15b0..a7769befd74e 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -519,13 +519,6 @@ static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
>         atomic64_dec(&pool->pages_nr);
>  }
>
> -static void release_z3fold_page(struct kref *ref)
> -{
> -       struct z3fold_header *zhdr = container_of(ref, struct z3fold_header,
> -                                               refcount);
> -       __release_z3fold_page(zhdr, false);
> -}
> -
>  static void release_z3fold_page_locked(struct kref *ref)
>  {
>         struct z3fold_header *zhdr = container_of(ref, struct z3fold_header,
> @@ -1317,12 +1310,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
>                                 break;
>                         }
>
> -                       if (kref_get_unless_zero(&zhdr->refcount) == 0) {
> -                               zhdr = NULL;
> -                               break;
> -                       }
>                         if (!z3fold_page_trylock(zhdr)) {
> -                               kref_put(&zhdr->refcount, release_z3fold_page);
>                                 zhdr = NULL;
>                                 continue; /* can't evict at this point */
>                         }
> @@ -1333,14 +1321,14 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
>                          */
>                         if (zhdr->foreign_handles ||
>                             test_and_set_bit(PAGE_CLAIMED, &page->private)) {
> -                               if (!kref_put(&zhdr->refcount,
> -                                               release_z3fold_page_locked))
> -                                       z3fold_page_unlock(zhdr);
> +                               z3fold_page_unlock(zhdr);
>                                 zhdr = NULL;
>                                 continue; /* can't evict such page */
>                         }
>                         list_del_init(&zhdr->buddy);
>                         zhdr->cpu = -1;
> +                       /* See comment in __z3fold_alloc. */
> +                       kref_get(&zhdr->refcount);
>                         break;
>                 }
>

Reviewed-by: Vitaly Wool <vitaly.wool@konsulko.com>
> --
> 2.23.0
>
