Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB18D4CCB8F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbiCDCKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbiCDCKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:10:49 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE97F17C43E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 18:10:02 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2d07ae0b1c4so76167727b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 18:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rnG5WBQ/Gs7SLjN1hqytWS42GBxY8jULmGy8SUTJD2s=;
        b=IbLD9g9h3PR1EhH8ea9D20iLgHbTwKw1RBM2dD7BXZz865t+8L+qWw1rWheobur1rw
         zMmJpYaxzfANDGccNe3ysTfP8pMcJ975N5+njgjexrSD+5l8Wh2T13HTO85KbjFOoxHp
         M/SY/ugObnLgZGTVK2Hi9eGpp4wV7ZBbEur3LjUB0gnOqIxAebUpkzuNX+PUHp8nAPX+
         k8+9wXhAlXcp6qcltB/ZS9pmXrhydXFNKZkehF3RCslSBhQcpJPIrEaO2O/gvet7GApm
         mVTP4bv/tKImJh4U/Yr1Xciqckf9geWSLQAEpYVf2LhhTamJGDSKQprwrF+hlEqZUuxy
         Hl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rnG5WBQ/Gs7SLjN1hqytWS42GBxY8jULmGy8SUTJD2s=;
        b=zPgZl4DSGzaTJ8dbcndkOL0YfYgVOLuxHZY+qXuXknqPIFIiGHfRKGzXOuCibn91rE
         N6rE4tqIcgeFMZHE9LA+FLfCjdZxAROKdn5lyEnqh5WkLrXkubUVoJy4FKjTuKMfCixR
         OA1mXyCbRZTBraYPBhZ6Hk3DboM70S7sL2Ii4j83pPeuXjxHK1X4PFygAdWuX2NJM4Gi
         LvpyrIikes4/FJjADL4zo3dn7HlQdP3HeuXr6eQ2gSGFinppR3+lcn6gcwrptlkkbA8d
         PuyyYOxufqE2WB0pz7DiahOyJMxUt2mfrzIYfjmz166jvn2y9Q8SYiIVqeOgcYUm9+JF
         K/ag==
X-Gm-Message-State: AOAM5328+DnhzPeMiabG0imLPpSPtyVSE9OJlo66MzAJWfjx+de6II7q
        3D3mP7HNn2QrDXJ3buGoxAv3/IErk8hUkK1cakTsWQ==
X-Google-Smtp-Source: ABdhPJxET4cE7o6CZKbyv/IOZkAA7iwgIItMd/EQyaifJbnUDfsQwsQSgl3ngCglvnRHGdhLP1XijVqMK68/YI76iw0=
X-Received: by 2002:a81:6a0a:0:b0:2d0:c144:4be4 with SMTP id
 f10-20020a816a0a000000b002d0c1444be4mr39232834ywc.332.1646359800882; Thu, 03
 Mar 2022 18:10:00 -0800 (PST)
MIME-Version: 1.0
References: <20220304015941.1704249-1-eric.dumazet@gmail.com>
In-Reply-To: <20220304015941.1704249-1-eric.dumazet@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 3 Mar 2022 18:09:47 -0800
Message-ID: <CANn89iJgaSDucfvTusWDKVU4vraqku3pw1BBPjNVj5cZt2U7vg@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: call check_new_pages() while zone spinlock
 is not held
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 3, 2022 at 5:59 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
>
> For high order pages not using pcp, rmqueue() is currently calling
> the costly check_new_pages() while zone spinlock is held.
>
> This is not needed, we can release the spinlock sooner to reduce
> zone spinlock contention.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: David Rientjes <rientjes@google.com>
> ---
>  mm/page_alloc.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3589febc6d31928f850ebe5a4015ddc40e0469f3..0890a65f8cc2259e82bc1f5ba95a592fb30f9fb8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3685,7 +3685,6 @@ struct page *rmqueue(struct zone *preferred_zone,
>                         gfp_t gfp_flags, unsigned int alloc_flags,
>                         int migratetype)
>  {
> -       unsigned long flags;
>         struct page *page;
>
>         if (likely(pcp_allowed_order(order))) {
> @@ -3706,10 +3705,12 @@ struct page *rmqueue(struct zone *preferred_zone,
>          * allocate greater than order-1 page units with __GFP_NOFAIL.
>          */
>         WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> -       spin_lock_irqsave(&zone->lock, flags);
>
>         do {
> +               unsigned long flags;
> +
>                 page = NULL;
> +               spin_lock_irqsave(&zone->lock, flags);
>                 /*
>                  * order-0 request can reach here when the pcplist is skipped
>                  * due to non-CMA allocation context. HIGHATOMIC area is
> @@ -3723,13 +3724,13 @@ struct page *rmqueue(struct zone *preferred_zone,
>                 }
>                 if (!page)
>                         page = __rmqueue(zone, order, migratetype, alloc_flags);
> -       } while (page && check_new_pages(page, order));
> -       if (!page)
> -               goto failed;
> +               spin_unlock_irqrestore(&zone->lock, flags);
> +               if (!page)
> +                       return NULL;
> +       } while (check_new_pages(page, order));
>

Oh well, it seems hard irqs have to be disabled when calling the
following function.

I will send a V2.

>         __mod_zone_freepage_state(zone, -(1 << order),
>                                   get_pcppage_migratetype(page));
> -       spin_unlock_irqrestore(&zone->lock, flags);
>
>         __count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
>         zone_statistics(preferred_zone, zone, 1);
> @@ -3743,10 +3744,6 @@ struct page *rmqueue(struct zone *preferred_zone,
>
>         VM_BUG_ON_PAGE(page && bad_range(zone, page), page);
>         return page;
> -
> -failed:
> -       spin_unlock_irqrestore(&zone->lock, flags);
> -       return NULL;
>  }
>
>  #ifdef CONFIG_FAIL_PAGE_ALLOC
> --
> 2.35.1.616.g0bdcbb4464-goog
>
