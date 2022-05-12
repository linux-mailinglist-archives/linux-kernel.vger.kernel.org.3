Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0CB52569D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358447AbiELUy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241316AbiELUyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:54:55 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63580644C4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:54:53 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id g184so5660017pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fgMpaknKQTL/YDwGcAjGRJjLANeCgoFIWM8w8VosUm8=;
        b=bKpsa0uSMKH9cKFZPdYlk+UrZykGpIXypdbdvD7uVyvrmdFEb72DetHIPcQi+/L5oX
         wQCKZN98KPUd63WexE4AKzrGaRNITCd9Y/2qX1q88NaLqU4R8op4R0Wf2K2c7FGe1UNV
         si9xLT0A+ICf9lYktfIbEXK5udUsakhMlHhTRq+9xcR1Pshcz1xMZpA1lAgvzk8xwOKq
         f51cZqZe5ZHQVplSZhDau3+KYMbk7sH686yCo7xRTbPo/eLe2NPUWDdMEP4Rapgo1Nzn
         NcDRjDhDqxSbduWcfrwRHR3RPpbLW4tA+hbnvgGbLhH9xiS7FPkFq/oZ8ZGA1640GO6h
         G0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fgMpaknKQTL/YDwGcAjGRJjLANeCgoFIWM8w8VosUm8=;
        b=hQX5/uRgq4Zzmu4aSMOAZ5E64ACpuUC5YkPDKdVUuDVdGAjOeLAzZoLRgWTs/yXWkt
         +w7RkPd1+wApfz9xLTAHoA+5ZF/wR1oi6oJ/AJRG4xKX3QH9MRSv/Q+xdZwkIk/vse8d
         d7XZ2IIfKlfH7XNFN98d0eiXRLDLQ3YWhSrfRuHSp7aSheG156inEDMZDCdo0s+YjKcq
         2A+V54KA1Fx+92a0HHKQf+H0NCcgL9NwLfDLZ9WO7g3ZoB12QAtvjD4HRBSmEUPNumGi
         q5RKflN5Ys8yr9wO4ouU/BoU/NWORfF4VkPVy0BaIa3xESYF/pauSnjxL9Cey4JHTevn
         vO7Q==
X-Gm-Message-State: AOAM532hVofyDhZv8DqrabjP9pMJqO4RHFDUpi2qTK/+z0HwtC7U+c78
        AX9Y6oY6M5iwIny5Nhkj78s=
X-Google-Smtp-Source: ABdhPJzHg0YPs9U5kJNFjbNV59KxzItUAZ+++S4QsjDlng5KSrRKNRdq1GjRM/ghF5ZDyJBptSdj3g==
X-Received: by 2002:a05:6a00:b85:b0:510:4275:2c71 with SMTP id g5-20020a056a000b8500b0051042752c71mr1483312pfj.31.1652388892837;
        Thu, 12 May 2022 13:54:52 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:872f:bbca:8e23:fae5])
        by smtp.gmail.com with ESMTPSA id n10-20020a62970a000000b0050dc762817asm248839pfe.84.2022.05.12.13.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 13:54:52 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 12 May 2022 13:54:50 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v5] mm: fix is_pinnable_page against on cma page
Message-ID: <Yn10GkInyZNtqASa@google.com>
References: <20220512204143.3961150-1-minchan@kernel.org>
 <5d9eb30e-6e0e-81a3-2b2c-47adc4e85470@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d9eb30e-6e0e-81a3-2b2c-47adc4e85470@nvidia.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 01:51:47PM -0700, John Hubbard wrote:
> On 5/12/22 13:41, Minchan Kim wrote:
> > Pages on CMA area could have MIGRATE_ISOLATE as well as MIGRATE_CMA
> > so current is_pinnable_page could miss CMA pages which has MIGRATE_
> > ISOLATE. It ends up pinning CMA pages as longterm at pin_user_pages
> > APIs so CMA allocation keep failed until the pin is released.
> > 
> >       CPU 0                                   CPU 1 - Task B
> > 
> > cma_alloc
> > alloc_contig_range
> >                                          pin_user_pages_fast(FOLL_LONGTERM)
> > change pageblock as MIGRATE_ISOLATE
> >                                          internal_get_user_pages_fast
> >                                          lockless_pages_from_mm
> >                                          gup_pte_range
> >                                          try_grab_folio
> >                                          is_pinnable_page
> >                                            return true;
> >                                          So, pinned the page successfully.
> > page migration failure with pinned page
> >                                          ..
> >                                          .. After 30 sec
> >                                          unpin_user_page(page)
> > 
> > CMA allocation succeeded after 30 sec.
> > 
> > The CMA allocation path protects the migration type change race
> > using zone->lock but what GUP path need to know is just whether the
> > page is on CMA area or not rather than exact migration type.
> > Thus, we don't need zone->lock but just checks migration type in
> > either of (MIGRATE_ISOLATE and MIGRATE_CMA).
> > 
> > Adding the MIGRATE_ISOLATE check in is_pinnable_page could cause
> > rejecting of pinning pages on MIGRATE_ISOLATE pageblocks even
> > though it's neither CMA nor movable zone if the page is temporarily
> > unmovable. However, such a migration failure by unexpected temporal
> > refcount holding is general issue, not only come from MIGRATE_ISOLATE
> > and the MIGRATE_ISOLATE is also transient state like other temporal
> > elevated refcount problem.
> > 
> > Cc: "Paul E . McKenney" <paulmck@kernel.org>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> > * from v4 - https://lore.kernel.org/all/20220510211743.95831-1-minchan@kernel.org/
> >    * clarification why we need READ_ONCE - Paul
> >    * Adding a comment about READ_ONCE - John
> > 
> > * from v3 - https://lore.kernel.org/all/20220509153430.4125710-1-minchan@kernel.org/
> >    * Fix typo and adding more description - akpm
> > 
> > * from v2 - https://lore.kernel.org/all/20220505064429.2818496-1-minchan@kernel.org/
> >    * Use __READ_ONCE instead of volatile - akpm
> > 
> > * from v1 - https://lore.kernel.org/all/20220502173558.2510641-1-minchan@kernel.org/
> >    * fix build warning - lkp
> >    * fix refetching issue of migration type
> >    * add side effect on !ZONE_MOVABLE and !MIGRATE_CMA in description - david
> > 
> >   include/linux/mm.h | 16 ++++++++++++++--
> >   1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 6acca5cecbc5..2d7a5d87decd 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1625,8 +1625,20 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
> >   #ifdef CONFIG_MIGRATION
> >   static inline bool is_pinnable_page(struct page *page)
> >   {
> > -	return !(is_zone_movable_page(page) || is_migrate_cma_page(page)) ||
> > -		is_zero_pfn(page_to_pfn(page));
> > +#ifdef CONFIG_CMA
> > +	/*
> > +	 * Defend against future compiler LTO features, or code refactoring
> > +	 * that inlines the above function, by forcing a single read. Because,
> > +	 * this routine races with set_pageblock_migratetype(), and we want to
> > +	 * avoid reading zero, when actually one or the other flags was set.
> > +	 */
> 
> The most interesting line got dropped in this version. :)
> 
> This is missing:
> 
> 	int __mt = get_pageblock_migratetype(page);
> 
> Assuming that that is restored, please feel free to add:
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Just caught after clicked the button with my fat finger :(

Thanks, John!

Andrew, Could you pick this up?

From 90ad049d48f5c36075f17ac996dfe3c33127aeb6 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Mon, 2 May 2022 10:03:48 -0700
Subject: [PATCH v5] mm: fix is_pinnable_page against on cma page

Pages on CMA area could have MIGRATE_ISOLATE as well as MIGRATE_CMA
so current is_pinnable_page could miss CMA pages which has MIGRATE_
ISOLATE. It ends up pinning CMA pages as longterm at pin_user_pages
APIs so CMA allocation keep failed until the pin is released.

     CPU 0                                   CPU 1 - Task B

cma_alloc
alloc_contig_range
                                        pin_user_pages_fast(FOLL_LONGTERM)
change pageblock as MIGRATE_ISOLATE
                                        internal_get_user_pages_fast
                                        lockless_pages_from_mm
                                        gup_pte_range
                                        try_grab_folio
                                        is_pinnable_page
                                          return true;
                                        So, pinned the page successfully.
page migration failure with pinned page
                                        ..
                                        .. After 30 sec
                                        unpin_user_page(page)

CMA allocation succeeded after 30 sec.

The CMA allocation path protects the migration type change race
using zone->lock but what GUP path need to know is just whether the
page is on CMA area or not rather than exact migration type.
Thus, we don't need zone->lock but just checks migration type in
either of (MIGRATE_ISOLATE and MIGRATE_CMA).

Adding the MIGRATE_ISOLATE check in is_pinnable_page could cause
rejecting of pinning pages on MIGRATE_ISOLATE pageblocks even
though it's neither CMA nor movable zone if the page is temporarily
unmovable. However, such a migration failure by unexpected temporal
refcount holding is general issue, not only come from MIGRATE_ISOLATE
and the MIGRATE_ISOLATE is also transient state like other temporal
elevated refcount problem.

Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
* from v4 - https://lore.kernel.org/all/20220510211743.95831-1-minchan@kernel.org/
  * clarification why we need READ_ONCE - Paul
  * Adding a comment about READ_ONCE - John

* from v3 - https://lore.kernel.org/all/20220509153430.4125710-1-minchan@kernel.org/
  * Fix typo and adding more description - akpm

* from v2 - https://lore.kernel.org/all/20220505064429.2818496-1-minchan@kernel.org/
  * Use __READ_ONCE instead of volatile - akpm

* from v1 - https://lore.kernel.org/all/20220502173558.2510641-1-minchan@kernel.org/
  * fix build warning - lkp
  * fix refetching issue of migration type
  * add side effect on !ZONE_MOVABLE and !MIGRATE_CMA in description - david

 include/linux/mm.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6acca5cecbc5..b23c6f1b90b5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1625,8 +1625,21 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
 #ifdef CONFIG_MIGRATION
 static inline bool is_pinnable_page(struct page *page)
 {
-	return !(is_zone_movable_page(page) || is_migrate_cma_page(page)) ||
-		is_zero_pfn(page_to_pfn(page));
+#ifdef CONFIG_CMA
+	/*
+	 * Defend against future compiler LTO features, or code refactoring
+	 * that inlines the above function, by forcing a single read. Because,
+	 * this routine races with set_pageblock_migratetype(), and we want to
+	 * avoid reading zero, when actually one or the other flags was set.
+	 */
+	int __mt = get_pageblock_migratetype(page);
+	int mt = __READ_ONCE(__mt);
+
+	if (mt & (MIGRATE_CMA | MIGRATE_ISOLATE))
+		return false;
+#endif
+
+	return !(is_zone_movable_page(page) || is_zero_pfn(page_to_pfn(page)));
 }
 #else
 static inline bool is_pinnable_page(struct page *page)
-- 
2.36.0.550.gb090851708-goog

