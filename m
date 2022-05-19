Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFCF52CC9A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiESHMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbiESHM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:12:28 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1A860ABA
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:12:26 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id d137so7443553ybc.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FWAr/J4HmuD6FhHb4kDYBZ2K/uqMD4MgkdggSBZ6fPY=;
        b=eumPdvyYgagzbji2kuY9ZtyStkcXWG1yv4KJh/hoJN55IWpgZO1fkjYF7aDelTQegS
         dINXV3fLCza0Xg+Dakk5qmag+ZV+nh+GljaBQkvNEjIDr+hq4F50BStF3CRgHs75Socx
         SB2tMBmEmzyLbBNmuIlmCvqnogij2vbbCHp4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FWAr/J4HmuD6FhHb4kDYBZ2K/uqMD4MgkdggSBZ6fPY=;
        b=3CKF1dtW2kfWTaWvRqPXNyTeb6ONp/Ta6pjn4QqW3FAhlnuYrf34g1VIWyEvQr71qa
         BO1dkE4/Na/dy/NMs/ULR369tGI2ySws+yjUuyky3OfQAW91iyi+BwgX2/qTPDfV8wM6
         0Re2Nqlj/kxQrOhzPm+Dby9LqGSryGhvXn4DRfqasFn0Q8fBddZZd4obs8ezTo+AUMw9
         w1CLTi2vUdaE3OjJH0uNIQQHP3jsBBLe55DGDSDks4mP6QO/SE/UMTx+bVX4lVh2BYxl
         T5B0If+om/Knd6KlWPLWioI0mcvDk/OPPJcExidVpAsZ+fZVp0i8fVkQ4S2PGWDNpUI9
         6YbQ==
X-Gm-Message-State: AOAM531FjXZd92L5+v6+1w2mcM9m9c6cexooVqqr+DV2//BYTA6z/BgI
        bixuvjjqVKap/2cy4pDSfH6vbSNXcK51JFCZdxWkZb/q1IQ=
X-Google-Smtp-Source: ABdhPJymMQ0FDt9pyHOJfXPZaSal9k7mWPMALlyrlNV6GGHjRuKXDoHiG79Ft8KeONIbhbqf3h3mlHEb/OVG+WTNBx4=
X-Received: by 2002:a05:6902:703:b0:64f:47d2:2497 with SMTP id
 k3-20020a056902070300b0064f47d22497mr593ybt.451.1652944345946; Thu, 19 May
 2022 00:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220429064051.61552-1-linmiaohe@huawei.com> <20220429064051.61552-6-linmiaohe@huawei.com>
In-Reply-To: <20220429064051.61552-6-linmiaohe@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Thu, 19 May 2022 09:12:14 +0200
Message-ID: <CAM4kBBLC4Jo4TAC66XzJBgFZfF5ONgCNT5fPFQjwPJtug+5N8A@mail.gmail.com>
Subject: Re: [PATCH 5/9] revert "mm/z3fold.c: allow __GFP_HIGHMEM in z3fold_alloc"
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
> Revert commit f1549cb5ab2b ("mm/z3fold.c: allow __GFP_HIGHMEM in
> z3fold_alloc").
>
> z3fold can't support GFP_HIGHMEM page now. page_address is used
> directly at all places. Moreover, z3fold_header is on per cpu
> unbuddied list which could be access anytime. So we should rid
> the support of GFP_HIGHMEM allocation for z3fold.

Could you please clarify how kmem_cache is affected here?

Thanks,
Vitaly

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/z3fold.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index b3b4e65c107f..5f5d5f1556be 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -212,10 +212,8 @@ static int size_to_chunks(size_t size)
>  static inline struct z3fold_buddy_slots *alloc_slots(struct z3fold_pool *pool,
>                                                         gfp_t gfp)
>  {
> -       struct z3fold_buddy_slots *slots;
> -
> -       slots = kmem_cache_zalloc(pool->c_handle,
> -                                (gfp & ~(__GFP_HIGHMEM | __GFP_MOVABLE)));
> +       struct z3fold_buddy_slots *slots = kmem_cache_zalloc(pool->c_handle,
> +                                                            gfp);
>
>         if (slots) {
>                 /* It will be freed separately in free_handle(). */
> @@ -1075,7 +1073,7 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
>         enum buddy bud;
>         bool can_sleep = gfpflags_allow_blocking(gfp);
>
> -       if (!size)
> +       if (!size || (gfp & __GFP_HIGHMEM))
>                 return -EINVAL;
>
>         if (size > PAGE_SIZE)
> --
> 2.23.0
>
