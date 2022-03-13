Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A274D7854
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 22:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbiCMVLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 17:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiCMVLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 17:11:32 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D311D0DD
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 14:10:24 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2db2add4516so144124197b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 14:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7BcrhjiAUP2vD6MkcaltfQ6gzbMYeWrrnPqDFWPSb7o=;
        b=HyMlGeHVYZt5dRa71d44WLx/Uiv+k8VOexRZ6IXTBqjbcYXOqER6FVM/s85ZEBzLqE
         GdC2amBwxzgLU+6rdnKiS87gem+827830aRBqCk60Ae+YPwjfjCM8IgPc8FNGDsTVdPM
         oBQm2BvYNIrjsIhjNemkmBddnFR/rZCH1hXlGoXAiZ5mH824z+lWvRFtFgKQuynC4tkC
         Hcb1xSDKI3JP3+57bP7YVLDjA+7Oar9sq+PFTtyBA9fPmhIVrk4Xzs1PtOJXeZdgpwkc
         DJDBGylaNIusfZK3npj7WOf/LDPNzsilZ/WlcZRGir1SQ8Sw+qyoMFkZk6XEpzpoViwL
         D4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7BcrhjiAUP2vD6MkcaltfQ6gzbMYeWrrnPqDFWPSb7o=;
        b=YvDHzE/LZFeFdt7/VNkBRZjHSJXrYO/oH6PcjxHMj6vqNznwLdB8ZSw9rBsx/g52OH
         2LCugjB5fC5pGaM3nEBrT21C+gENMBA+I276ZcbWgzYBixIDg8YJJ7uAt+Zk2SiUeQbE
         h78F+9TcCKNOsmkhbg3QqdaU0BfopYvye+xZykvwxh2y4zlGk2P1+VRh/DwBonrm+dEa
         kwMqSqQRxtd3ztViLhf6uXzjGj6WXCtjfEb9TUMeEYxqx6eGtXX4jh5Y9j76ODqADqhW
         ZCl6xdSl0f7xjsmROL1XSPpM+eaDHVFVx1PoXNp2q+Qdapvd2wnvI8U3P84Owb9Fbv/K
         q4Xg==
X-Gm-Message-State: AOAM533L+Gpd6GLr8MLEd18K/i/FiZd5BDINGLfvQUvLa6K3g67vx9UU
        FCcxsG4oFvvGkapdD87XVGRBga29aS9+Xsy3HSxf6Q==
X-Google-Smtp-Source: ABdhPJxOyrsjv4TuZBvhsFdZvWfIQV7f1ePeaVk/xFg+n8dE+Ox8SomDLoLm3ByGnMEHOlZnf6dy0GO5ep3B6k2/4lo=
X-Received: by 2002:a81:af57:0:b0:2dc:40d0:1380 with SMTP id
 x23-20020a81af57000000b002dc40d01380mr15998588ywj.255.1647205823423; Sun, 13
 Mar 2022 14:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220312154321.GC1189@xsang-OptiPlex-9020> <15307f8a-c202-75d8-1361-dae0146df734@suse.cz>
 <CANn89i+fM0k+=Qw0M0fso1f-Ya8--5+==gtcWqCpo=Gu-ca1Ow@mail.gmail.com> <8f499c76-68cb-a2c3-01fd-c8759e2fd317@suse.cz>
In-Reply-To: <8f499c76-68cb-a2c3-01fd-c8759e2fd317@suse.cz>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 13 Mar 2022 14:10:12 -0700
Message-ID: <CANn89iJwBe4+C8KP--c_9O6QE_Tou+1Z0+ugtuniG-06nzxPmg@mail.gmail.com>
Subject: Re: [mm/page_alloc] 8212a964ee: vm-scalability.throughput 30.5% improvement
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        0day robot <lkp@intel.com>, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        "Huang, Ying" <ying.huang@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, Eric Dumazet <eric.dumazet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
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

On Sun, Mar 13, 2022 at 1:29 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 3/13/22 00:26, Eric Dumazet wrote:
> > On Sat, Mar 12, 2022 at 10:59 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >> On 3/12/22 16:43, kernel test robot wrote:
> >>>
> >>>
> >>> Greeting,
> >>>
> >>> FYI, we noticed a 30.5% improvement of vm-scalability.throughput due to commit:
> >>>
> >>>
> >>> commit: 8212a964ee020471104e34dce7029dec33c218a9 ("Re: [PATCH v2] mm/page_alloc: call check_new_pages() while zone spinlock is not held")
> >>> url: https://github.com/0day-ci/linux/commits/Mel-Gorman/Re-PATCH-v2-mm-page_alloc-call-check_new_pages-while-zone-spinlock-is-not-held/20220309-203504
> >>> patch link: https://lore.kernel.org/lkml/20220309123245.GI15701@techsingularity.net
> >>
> >> Heh, that's weird. I would expect some improvement from Eric's patch,
> >> but this seems to be actually about Mel's "mm/page_alloc: check
> >> high-order pages for corruption during PCP operations" applied directly
> >> on 5.17-rc7 per the github url above. This was rather expected to make
> >> performance worse if anything, so maybe the improvement is due to some
> >> unexpected side-effect of different inlining decisions or cache alignment...
> >>
> >
> > I doubt this has anything to do with inlining or cache alignment.
> >
> > I am not familiar with the benchmark, but its name
> > (anon-w-rand-hugetlb) hints at hugetlb ?
> >
> > After Mel fix, we go over 512 'struct page' to perform sanity checks,
> > thus loading into cpu caches the 512 cache lines.
>
> Ah, that's true.
>
> > This caching is done while no lock is held.
>
> But I don't think this is. The test was AFAICS done without your patch,
> so the lock is still held in rmqueue(). And it's also held in
> rmqueue_bulk() -> check_pcp_refill().

Note that Mel patch  touches both check_pcp_refill() and check_new_pcp()

__rmqueue_pcplist() definitely calls check_new_pcp() while the zone
spinlock is _not_ held.

Note that it is possible to defer calls to check_pcp_refill after the
spinlock is released.

Untested patch:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1804287c1b792b8aa0e964b17eb002b6b1115258..3c504b4c068a5dbeeaf8f386bb09b673236f7a11
100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3024,6 +3024,7 @@ static int rmqueue_bulk(struct zone *zone,
unsigned int order,
                        unsigned long count, struct list_head *list,
                        int migratetype, unsigned int alloc_flags)
 {
+       struct page *page, *tmp;
        int i, allocated = 0;

        /*
@@ -3032,14 +3033,10 @@ static int rmqueue_bulk(struct zone *zone,
unsigned int order,
         */
        spin_lock(&zone->lock);
        for (i = 0; i < count; ++i) {
-               struct page *page = __rmqueue(zone, order, migratetype,
-                                                               alloc_flags);
+               page = __rmqueue(zone, order, migratetype, alloc_flags);
                if (unlikely(page == NULL))
                        break;

-               if (unlikely(check_pcp_refill(page)))
-                       continue;
-
                /*
                 * Split buddy pages returned by expand() are received here in
                 * physical page order. The page is added to the tail of
@@ -3065,6 +3062,12 @@ static int rmqueue_bulk(struct zone *zone,
unsigned int order,
         */
        __mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
        spin_unlock(&zone->lock);
+       list_for_each_entry_safe(page, tmp, list, lru) {
+               if (unlikely(check_pcp_refill(page))) {
+                       list_del(&page->lru);
+                       allocated--;
+               }
+       }
        return allocated;
 }
