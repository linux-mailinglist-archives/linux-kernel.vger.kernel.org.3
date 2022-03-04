Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF66B4CD977
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240835AbiCDQvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbiCDQvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:51:03 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B071B50E7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:50:15 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id u61so17973729ybi.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 08:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=87HcgX5krbNKK727vBqyS9uN6dtf5rxlszdjfz9xwn8=;
        b=LpExxzmSWtzN9qF7NCuj4vu9c5OBuvYrdpkPSi12GIjwIm3S98rFFacBT/vE52Xoiq
         QHmbkE+qvGhG0LDXUxNKhXX6ufdGW/bxaxeVGyv0TbeHFhLiJITdt5N/qliN2Q3eX3HH
         cVMezKrKyLIxiTMjKsXKPmWeOTeIw7u29TREx/qWsJ16QtSL0+b14H5NQzvgJ8p7+Lbp
         02ABtrn8S+MoM516p5cAySMcnkhHqmJbpv6JM9YrmUPg/TiZQGzRplsjWn9e6MO/xR2B
         YzoIa75ynkpoENc5U/ya1JJUqd3LBCG4UPwAhkL58jShJuTA9m+HPtttZS1e1DkvNedL
         i0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87HcgX5krbNKK727vBqyS9uN6dtf5rxlszdjfz9xwn8=;
        b=KNQjDtUI8WgN2U+FBwmVnE9U4BhptBASAJe63JRnxZk0+8H8KeTbGOYfcjoSh9pAHV
         yyBBDSa8DdrUnzOex4AWJ7+WOqMN4oqYOCkCxT0o6Deig4pLuisouzxQdlHN/ilRIuRr
         IQk6x2EPf3KAk6rlFWNMKPaT638t+KXQRRWNU425kKESdrfwwLvyVHOEQvNLn/BK4Xtg
         nYtxsyZ+JyGhOnH6NY0/MwvsuZ5lO/l3SC9jgH5GBH8AfAEBUnk2C3LtNLaI8aq00a0o
         C/Gi44gs/q9k3VuQM8GgHZlBgUS1bVkj5SqzENv0bDFK3aCEnfssBfcsvNeGjJhTJzjn
         fG+A==
X-Gm-Message-State: AOAM5328EM+SQ9hwF1UWTqNXNNipIApCDN4fpi2r5AFpDO79UQDxQBZe
        OnUK71kgouP573lGQbl4G5IcNBXi1gF/T6giki3S+A==
X-Google-Smtp-Source: ABdhPJx6wbk02EeTE0O/O579xvp0pc0DRV+wS1ymdclyb4UZsckZz5/mcc5j2+MLjmrJiHmD0fz3WXhy3YnicpnzzWE=
X-Received: by 2002:a25:d188:0:b0:628:ba86:ee68 with SMTP id
 i130-20020a25d188000000b00628ba86ee68mr10111227ybg.427.1646412614327; Fri, 04
 Mar 2022 08:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20220304015941.1704249-1-eric.dumazet@gmail.com>
 <CANn89iJgaSDucfvTusWDKVU4vraqku3pw1BBPjNVj5cZt2U7vg@mail.gmail.com> <deae2ce6-8a43-5720-319e-cab25ee3bdb6@suse.cz>
In-Reply-To: <deae2ce6-8a43-5720-319e-cab25ee3bdb6@suse.cz>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 4 Mar 2022 08:50:03 -0800
Message-ID: <CANn89iJOAnSz3h36A_gAoog1xRjkaR=3i1L6iz8C_E6DC8TwUw@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: call check_new_pages() while zone spinlock
 is not held
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>,
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

On Fri, Mar 4, 2022 at 12:32 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
>
> Ah, you found out already. Well maybe it could simply be moved inside the
> loop under the locked section and always done when page != NULL? I mean if
> check_new_pages() fails we just leak the problematic pages anyway so they
> are no longer free to allocate anymore and we should not count them as such.
>

Yes, and I guess that calling __mod_zone_freepage_state() for the page
about to be leaked
is just fine.

This means we can call check_newpages() without holding zone spinlock
or hard irqs being masked.

I will test something like:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3589febc6d31928f850ebe5a4015ddc40e0469f3..1804287c1b792b8aa0e964b17eb002b6b1115258
100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3706,10 +3706,10 @@ struct page *rmqueue(struct zone *preferred_zone,
         * allocate greater than order-1 page units with __GFP_NOFAIL.
         */
        WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
-       spin_lock_irqsave(&zone->lock, flags);

        do {
                page = NULL;
+               spin_lock_irqsave(&zone->lock, flags);
                /*
                 * order-0 request can reach here when the pcplist is skipped
                 * due to non-CMA allocation context. HIGHATOMIC area is
@@ -3721,15 +3721,15 @@ struct page *rmqueue(struct zone *preferred_zone,
                        if (page)
                                trace_mm_page_alloc_zone_locked(page,
order, migratetype);
                }
-               if (!page)
+               if (!page) {
                        page = __rmqueue(zone, order, migratetype, alloc_flags);
-       } while (page && check_new_pages(page, order));
-       if (!page)
-               goto failed;
-
-       __mod_zone_freepage_state(zone, -(1 << order),
-                                 get_pcppage_migratetype(page));
-       spin_unlock_irqrestore(&zone->lock, flags);
+                       if (!page)
+                               goto failed;
+               }
+               __mod_zone_freepage_state(zone, -(1 << order),
+                                         get_pcppage_migratetype(page));
+               spin_unlock_irqrestore(&zone->lock, flags);
+       } while (check_new_pages(page, order));

        __count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
        zone_statistics(preferred_zone, zone, 1);
