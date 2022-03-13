Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F254D7876
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 22:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbiCMVha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 17:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbiCMVh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 17:37:28 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40DA75C0D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 14:36:19 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2dbc48104beso144207087b3.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 14:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u07J4CAvfW2rxku6j2NiK/WFDWA9v2JFm0VitAGxtws=;
        b=d41V6mfhx2i6Yg04udiAe+jr0Xg8XKiB03eFBYem3zFdpWq5wbChkfHU2TjDCXW6Ek
         XyhQaRT61am4M/j3WEnD0t2sympFmHpcAapHq5mEw7BBvTtY1UguJyoUFWzDXxUKJs+E
         1FWaIRfkCOjQLEFgGxCmsOQccQykdeS+RAsyfW76mbAXjn3+wrWKbPUdcrDqa/PGUKGB
         7gwz5QxX99co85P2fUG/TAVX8HSuD44rZpuWkwHcG1noWWZ6QWUaAHDhX+JxQXMcTtah
         ONkjo8jvMnmHhRilLayuP76mnaaSCTkztf5xI/ffyZLCe6DlhY/fRh3TiOGzgU5wpqb/
         7K/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u07J4CAvfW2rxku6j2NiK/WFDWA9v2JFm0VitAGxtws=;
        b=PC2MoyLAtDFrNiIavh7ir80mJA3C2RnOIhJNpLIiDZutYUgeD7F6k/7E8QLXfjPVOu
         HqgzET1RSzgWfh1oFkqlILe8Nt0+ERNFiRKeVkmR98aLlTJ+dP4A/63OT4WrgWdLLBWq
         5ToDTq1OpiMaKPJEwYHNktSOFYv8f+tiHcavnMKqi168idmfFhi4MF1bA/OW1rgLELA0
         sRo2JXySdy8U+PRymGtE9d+0poqubEBnz17tilBnewHdRMNtTnyJC47LU7PQ9H+fGbmk
         rJioCNzAxGsChZPQuIUt4K9v/xQhGC4eXnRtMrM2TBNyHI2E2US2fWI8Ha9GwrlMCOlP
         6XBA==
X-Gm-Message-State: AOAM5323JiHbJkk8xdJyjTZc8VctruaT8e4A6Nlt9rykU/+7cJ9y8B3/
        +Baj7lVUQxgNCKcL5kEhJe4UAfzhK7oKwy7yG+pWSQ==
X-Google-Smtp-Source: ABdhPJx1CMwmPasmuVNQGeM2vLJuWikCar73Gmd03DWO1azBNeiNK7psPr5k/Gqv6vM/euPfIwTcKFy36rWx23UurRM=
X-Received: by 2002:a81:a743:0:b0:2dc:6eab:469a with SMTP id
 e64-20020a81a743000000b002dc6eab469amr16626636ywh.332.1647207378575; Sun, 13
 Mar 2022 14:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220312154321.GC1189@xsang-OptiPlex-9020> <15307f8a-c202-75d8-1361-dae0146df734@suse.cz>
 <CANn89i+fM0k+=Qw0M0fso1f-Ya8--5+==gtcWqCpo=Gu-ca1Ow@mail.gmail.com>
 <8f499c76-68cb-a2c3-01fd-c8759e2fd317@suse.cz> <CANn89iJwBe4+C8KP--c_9O6QE_Tou+1Z0+ugtuniG-06nzxPmg@mail.gmail.com>
 <Yi5ftFbykAZLLCwf@casper.infradead.org> <CANn89iL9u-dWpgNF7YGrQ4RQ5M_BwmS8Hqq3DPeWJunKRbu-PA@mail.gmail.com>
In-Reply-To: <CANn89iL9u-dWpgNF7YGrQ4RQ5M_BwmS8Hqq3DPeWJunKRbu-PA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 13 Mar 2022 14:36:07 -0700
Message-ID: <CANn89iKKgT0BdQgBwZSbNNwyiOJELr7kdbPyCxMQUDxTeUL8-Q@mail.gmail.com>
Subject: Re: [mm/page_alloc] 8212a964ee: vm-scalability.throughput 30.5% improvement
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        kernel test robot <oliver.sang@intel.com>,
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

On Sun, Mar 13, 2022 at 2:27 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Sun, Mar 13, 2022 at 2:18 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sun, Mar 13, 2022 at 02:10:12PM -0700, Eric Dumazet wrote:
> > > @@ -3065,6 +3062,12 @@ static int rmqueue_bulk(struct zone *zone,
> > > unsigned int order,
> > >          */
> > >         __mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
> > >         spin_unlock(&zone->lock);
> > > +       list_for_each_entry_safe(page, tmp, list, lru) {
> > > +               if (unlikely(check_pcp_refill(page))) {
> > > +                       list_del(&page->lru);
> > > +                       allocated--;
> > > +               }
> > > +       }
> >
> > ... you'd need to adjust __mod_zone_page_state() too, right?
>
> Probably !
> This was only to show the basic idea, as I said, not even compiled or tested :)

I can test the following:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1804287c1b792b8aa0e964b17eb002b6b1115258..30a1abf40ea7e9104bfd24a42d9e0c8ebb152fc4
100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3024,7 +3024,9 @@ static int rmqueue_bulk(struct zone *zone,
unsigned int order,
                        unsigned long count, struct list_head *list,
                        int migratetype, unsigned int alloc_flags)
 {
+       struct page *page, *tmp;
        int i, allocated = 0;
+       int free_cma_pages = 0;

        /*
         * local_lock_irq held so equivalent to spin_lock_irqsave for
@@ -3032,14 +3034,10 @@ static int rmqueue_bulk(struct zone *zone,
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
@@ -3052,9 +3050,6 @@ static int rmqueue_bulk(struct zone *zone,
unsigned int order,
                 */
                list_add_tail(&page->lru, list);
                allocated++;
-               if (is_migrate_cma(get_pcppage_migratetype(page)))
-                       __mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
-                                             -(1 << order));
        }

        /*
@@ -3065,6 +3060,16 @@ static int rmqueue_bulk(struct zone *zone,
unsigned int order,
         */
        __mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
        spin_unlock(&zone->lock);
+       list_for_each_entry_safe(page, tmp, list, lru) {
+               if (unlikely(check_pcp_refill(page))) {
+                       list_del(&page->lru);
+                       allocated--;
+               } else if (is_migrate_cma(get_pcppage_migratetype(page))) {
+                       free_cma_pages++;
+               }
+       }
+       if (free_cma_pages)
+               __mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
-(free_cma_pages << order));
        return allocated;
 }
