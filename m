Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C10152CC79
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiESHGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiESHGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:06:30 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BEA62A15
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:06:29 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id p139so7436661ybc.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YwGdObx2rN49pGl6m0/GqaEWdkz1IZaGgAWMTIaY1MQ=;
        b=NL0wn/oE6V1itp4kAHF911Q1QFEhRcBt6i3r8skcUAkzgzmyPF2Og0z3erS3hnOqYa
         ckkoTrnqmPjfrf3xn5u3ZtvVxO9YWJN+kzy2QGXpnDFsoYuBpb4KDWg3YcPmNpw0wy3d
         2lv/Y5V5eacwcibq4WvyoqY3VtmsKFk1pk33c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YwGdObx2rN49pGl6m0/GqaEWdkz1IZaGgAWMTIaY1MQ=;
        b=oCbWUEbDSCZmyTEnj1ZqhKWVoB0JbEPGoCMwvhbcjvYyAeDetJT6GwGYtMf1McuBCd
         HFNB57m1o+UVSVAY/pf3QaKb4SwZ+VgBZ6z1uvBdL2dtod71IMyIh5Nb9kkl5qKffehN
         VAVfbc9KnTi7t7BtiyKXfTBBbN/Xm5RExEKWJ44JiqO+S0bvINV6rqpgn0X5VP2mYkvH
         s9fnt0Ea1thyVxtEHJI2e1Y99pTOlvFJTv0kth08MA4+bd8/MGH3Izm80qcPDydtqMTL
         D8CkYuwUYfS2+Lx780oakAQkf0CICBng4qUL3awvWjpRmXxevL1Jen/RTTaij1eFvOrF
         tFkg==
X-Gm-Message-State: AOAM5316WTsPloKQ3wG7s2QJo9U3T/pJy5zyI1ATuwOOQX13ZilB0hYz
        PtlwzltKaGDt+KEcLLzrJ6MaZe2RVEsv2Sy9Qj6cBg==
X-Google-Smtp-Source: ABdhPJwXMsrkDRDjElIr5XkTyARF49d8zBfzI8qyiCHp6sygr/oTHpLqiQm1O6srVsjnwmPN+S82fZZotEvF2OxlkfM=
X-Received: by 2002:a25:f506:0:b0:64d:f8a5:b2bd with SMTP id
 a6-20020a25f506000000b0064df8a5b2bdmr2819186ybe.610.1652943988678; Thu, 19
 May 2022 00:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220429064051.61552-1-linmiaohe@huawei.com> <20220429064051.61552-4-linmiaohe@huawei.com>
In-Reply-To: <20220429064051.61552-4-linmiaohe@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Thu, 19 May 2022 09:06:17 +0200
Message-ID: <CAM4kBBKfJPHP6u0cvtSo58BS9e6erQJA28=RxaTVopTn2Wt1wQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] mm/z3fold: remove buggy use of stale list for allocation
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

On Fri, Apr 29, 2022 at 8:41 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Currently if z3fold couldn't find an unbuddied page it would first try to
> pull a page off the stale list. But this approach is problematic. If init
> z3fold page fails later, the page should be freed via free_z3fold_page to
> clean up the relevant resource instead of using __free_page directly. And
> if page is successfully reused, it will BUG_ON later in __SetPageMovable
> because it's already non-lru movable page, i.e. PAGE_MAPPING_MOVABLE is
> already set in page->mapping. In order to fix all of these issues, we can
> simply remove the buggy use of stale list for allocation because can_sleep
> should always be false and we never really hit the reusing code path now.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/z3fold.c | 23 +----------------------
>  1 file changed, 1 insertion(+), 22 deletions(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 5d8c21f2bc59..4e6814c5694f 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -1102,28 +1102,7 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
>                 bud = FIRST;
>         }
>
> -       page = NULL;
> -       if (can_sleep) {
> -               spin_lock(&pool->stale_lock);
> -               zhdr = list_first_entry_or_null(&pool->stale,
> -                                               struct z3fold_header, buddy);
> -               /*
> -                * Before allocating a page, let's see if we can take one from
> -                * the stale pages list. cancel_work_sync() can sleep so we
> -                * limit this case to the contexts where we can sleep
> -                */
> -               if (zhdr) {
> -                       list_del(&zhdr->buddy);
> -                       spin_unlock(&pool->stale_lock);
> -                       cancel_work_sync(&zhdr->work);
> -                       page = virt_to_page(zhdr);
> -               } else {
> -                       spin_unlock(&pool->stale_lock);
> -               }
> -       }
> -       if (!page)
> -               page = alloc_page(gfp);
> -
> +       page = alloc_page(gfp);
>         if (!page)
>                 return -ENOMEM;

Reviewed-by: Vitaly Wool <vitaly.wool@konsulko.com>
> --
> 2.23.0
>
