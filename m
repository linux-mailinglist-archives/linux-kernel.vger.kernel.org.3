Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1094FE42A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356762AbiDLOwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbiDLOwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:52:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DAE63B3E0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 07:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649774997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VKOQn1/FjV6OBQG9CHLr0msOL3BwmLHbKM+lIKFhPk8=;
        b=bp+HpKWlrywbjyPRVLaKN+yrYTpNi5Btn1qGehYLdaQwow1yMT+80BnPL2PTjJ0NDItmrY
        8gFheddxjn/36q8rtHci4I1JYKjjdGBN0G/GvQPDQl/KJ1f2p14NImzZAHhRLuRg1+w+r7
        FarT9i/SLAPFQ2izN97XN6l21P3ujOA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-LDK7LcxsMuuTOyzuwrGMMw-1; Tue, 12 Apr 2022 10:49:54 -0400
X-MC-Unique: LDK7LcxsMuuTOyzuwrGMMw-1
Received: by mail-ej1-f71.google.com with SMTP id sg40-20020a170907a42800b006e8be1ab258so374624ejc.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 07:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=VKOQn1/FjV6OBQG9CHLr0msOL3BwmLHbKM+lIKFhPk8=;
        b=UQY7HDf+jr8gd2hBDB0pY9runMoG4F2a71txykHjgTI0GMEeFtkdYuGpi5KJcGogVa
         /8o8rFTc9T83hLOt/iGcXv3ngq04gwJxwIxquD+fOry+JiCi2O7ysIjCbzAo1hswIyYK
         KKc9D80U0PYUqXJae2gZ9g59XPEBnjfEKnpw2k/355leCKpK7i4Mp/TR66jbKSbOvat8
         haApri7ZPSRqVJEQYVSg1hcsXTck3QhUg0NtxqlPqwOJxKsq8PDynRavsG1481hLp3kQ
         GdYtfrYIbWQyGbcjbud0r5bVVEaU1gadTQQ+VvORcukUeg8vv+qAqxitOSCIe3kXKHmj
         IRAA==
X-Gm-Message-State: AOAM533RbXOW+U8Hcezmoxsq3vjkzvVCyEm7epu9RQzkzdr9qsnAfl+6
        OntcvjiOFYG4bldOz2z7Ibe0Qa+htNX6IrzgAck9p3vL5PEeP2UI1d3pklr6syihaOY2zhYNu00
        5pdsp0bnOff8LU1eihFdI4z4f
X-Received: by 2002:a17:907:c28:b0:6e8:80f5:31d1 with SMTP id ga40-20020a1709070c2800b006e880f531d1mr12126494ejc.646.1649774992879;
        Tue, 12 Apr 2022 07:49:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznhEYT/MptHRlWdQXpZgqAfMvJl696YnuPqf67aZX5HJresVoeklYmU522U/R5j5Wx9SJlPA==
X-Received: by 2002:a17:907:c28:b0:6e8:80f5:31d1 with SMTP id ga40-20020a1709070c2800b006e880f531d1mr12126472ejc.646.1649774992546;
        Tue, 12 Apr 2022 07:49:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:1800:7c14:16cc:5291:a9f3? (p200300cbc70718007c1416cc5291a9f3.dip0.t-ipconnect.de. [2003:cb:c707:1800:7c14:16cc:5291:a9f3])
        by smtp.gmail.com with ESMTPSA id c13-20020a17090654cd00b006e0db351d01sm13270658ejp.124.2022.04.12.07.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 07:49:52 -0700 (PDT)
Message-ID: <428828e1-6b59-8db7-62e0-1429863cb13f@redhat.com>
Date:   Tue, 12 Apr 2022 16:49:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v10 2/5] mm: page_isolation: check specified range for
 unmovable pages
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20220406151858.3149821-1-zi.yan@sent.com>
 <20220406151858.3149821-3-zi.yan@sent.com>
 <ccae12f9-a452-95a8-f404-3398dcdf5bdf@redhat.com>
 <039317AF-985C-43D7-BB99-714DD6022B5C@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <039317AF-985C-43D7-BB99-714DD6022B5C@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.22 16:07, Zi Yan wrote:
> On 12 Apr 2022, at 9:10, David Hildenbrand wrote:
> 
>> On 06.04.22 17:18, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> Enable set_migratetype_isolate() to check specified sub-range for
>>> unmovable pages during isolation. Page isolation is done
>>> at MAX_ORDER_NR_PAEGS granularity, but not all pages within that
>>> granularity are intended to be isolated. For example,
>>> alloc_contig_range(), which uses page isolation, allows ranges without
>>> alignment. This commit makes unmovable page check only look for
>>> interesting pages, so that page isolation can succeed for any
>>> non-overlapping ranges.
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>
>> [...]
>>
>>>  /*
>>> - * This function checks whether pageblock includes unmovable pages or not.
>>> + * This function checks whether the range [start_pfn, end_pfn) includes
>>> + * unmovable pages or not. The range must fall into a single pageblock and
>>> + * consequently belong to a single zone.
>>>   *
>>>   * PageLRU check without isolation or lru_lock could race so that
>>>   * MIGRATE_MOVABLE block might include unmovable pages. And __PageMovable
>>> @@ -28,12 +30,14 @@
>>>   * cannot get removed (e.g., via memory unplug) concurrently.
>>>   *
>>>   */
>>> -static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>>> -				 int migratetype, int flags)
>>> +static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long end_pfn,
>>> +				int migratetype, int flags)
>>>  {
>>> -	unsigned long iter = 0;
>>> -	unsigned long pfn = page_to_pfn(page);
>>> -	unsigned long offset = pfn % pageblock_nr_pages;
>>> +	unsigned long pfn = start_pfn;
>>> +	struct page *page = pfn_to_page(pfn);
>>
>>
>> Just do
>>
>> struct page *page = pfn_to_page(start_pfn);
>> struct zone *zone = page_zone(page);
>>
>> here. No need to lookup the zone again in the loop because, as you
>> document "must ... belong to a single zone.".
>>
>> Then, there is also no need to initialize "pfn" here. In the loop header
>> is sufficient.
>>
> 
> Sure.
> 
>>> +
>>> +	VM_BUG_ON(ALIGN_DOWN(start_pfn, pageblock_nr_pages) !=
>>> +		  ALIGN_DOWN(end_pfn - 1, pageblock_nr_pages));
>>>
>>>  	if (is_migrate_cma_page(page)) {
>>>  		/*
>>> @@ -47,8 +51,11 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>>>  		return page;
>>>  	}
>>>
>>> -	for (; iter < pageblock_nr_pages - offset; iter++) {
>>> -		page = pfn_to_page(pfn + iter);
>>> +	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>>> +		struct zone *zone;
>>> +
>>> +		page = pfn_to_page(pfn);
>>> +		zone = page_zone(page);
>>>
>>>  		/*
>>>  		 * Both, bootmem allocations and memory holes are marked
>>> @@ -85,7 +92,7 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>>>  			}
>>>
>>>  			skip_pages = compound_nr(head) - (page - head);
>>> -			iter += skip_pages - 1;
>>> +			pfn += skip_pages - 1;
>>>  			continue;
>>>  		}
>>>
>>> @@ -97,7 +104,7 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>>>  		 */
>>>  		if (!page_ref_count(page)) {
>>>  			if (PageBuddy(page))
>>> -				iter += (1 << buddy_order(page)) - 1;
>>> +				pfn += (1 << buddy_order(page)) - 1;
>>>  			continue;
>>>  		}
>>>
>>> @@ -134,11 +141,18 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>>>  	return NULL;
>>>  }
>>>
>>> -static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags)
>>> +/*
>>> + * This function set pageblock migratetype to isolate if no unmovable page is
>>> + * present in [start_pfn, end_pfn). The pageblock must intersect with
>>> + * [start_pfn, end_pfn).
>>> + */
>>> +static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags,
>>> +			unsigned long start_pfn, unsigned long end_pfn)
>>
>> I think we might be able do better, eventually not passing start_pfn at
>> all. Hmm.
> 
> IMHO, having start_pfn and end_pfn in the parameter list would make the
> interface easier to understand. Otherwise if we remove start_pfn,
> the caller needs to adjust @page to be within the range of [start_pfn,
> end_pfn)
> 
>>
>> I think we want to pull out the
>> start_isolate_page_range()/undo_isolate_page_range() interface change
>> into a separate patch.
> 
> You mean a patch just adding
> 
> unsigned long isolate_start = pfn_max_align_down(start_pfn);
> unsigned long isolate_end = pfn_max_align_up(end_pfn);
> 
> in start_isolate_page_range()/undo_isolate_page_range()?
> 
> Yes I can do that.

I think we have to be careful with memory onlining/offlining. There are
corner cases where we get called with only pageblock alignment and
must not adjust the range.


Something like this as a base for the next cleanups/extensions:


From 18d29b53600d6d0d6ac87cdc6b7517e989fa3dac Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Tue, 12 Apr 2022 15:51:50 +0200
Subject: [PATCH] mm: page-isolation: Move alignment logic into
 start_isolate_page_range()/undo_isolate_page_range()

For ordinary range allocations, we actually have to isolate all pageblocks
in a MAX_ORDER - 1 range. Only memory onlining/offlining is special: it
knows exactly which pageblocks to isolate/unisolate and we must not mess
with the pageblocks to isolate (memory onlining/offlining alwayes passed
MAX_ORDER - 1 - aligned ranges, unless we're dealing with vmemmap
located on hotplugged memory, whereby the start pfn might only be
pageblock aligned).

Further, for ordinary allcoations, we'll want to know the exact range
we want to allocate -- to check only that range for unmovable pages.
Right now we lose that information.

So let's move the alignment logic into start_isolate_page_range() /
undo_isolate_page_range(), such that we have the actual range of
interest available and the alignment logic contained in there.

Provide start_isolate_pageblocks()/undo_isolate_pageblocks() for memory
onlining/offlining.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-isolation.h | 23 ++++-----
 mm/memory_hotplug.c            |  8 ++--
 mm/page_alloc.c                | 15 +-----
 mm/page_isolation.c            | 85 ++++++++++++++++++++++++++--------
 4 files changed, 81 insertions(+), 50 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index e14eddf6741a..8e9e9e80ba67 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -37,20 +37,15 @@ void set_pageblock_migratetype(struct page *page, int migratetype);
 int move_freepages_block(struct zone *zone, struct page *page,
 				int migratetype, int *num_movable);
 
-/*
- * Changes migrate type in [start_pfn, end_pfn) to be MIGRATE_ISOLATE.
- */
-int
-start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			 unsigned migratetype, int flags);
-
-/*
- * Changes MIGRATE_ISOLATE to MIGRATE_MOVABLE.
- * target range is [start_pfn, end_pfn)
- */
-void
-undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			unsigned migratetype);
+int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
+			     unsigned migratetype, int flags);
+int start_isolate_pageblocks(unsigned long start_pfn, unsigned long end_pfn,
+			     unsigned migratetype, int flags);
+
+void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
+			     unsigned migratetype);
+void undo_isolate_pageblocks(unsigned long start_pfn, unsigned long end_pfn,
+			     unsigned migratetype);
 
 /*
  * Test all pages in [start_pfn, end_pfn) are isolated or not.
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 416b38ca8def..fb7f63c800d1 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1089,7 +1089,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 
 	/*
 	 * Fixup the number of isolated pageblocks before marking the sections
-	 * onlining, such that undo_isolate_page_range() works correctly.
+	 * onlining, such that undo_isolate_pageblocks() works correctly.
 	 */
 	spin_lock_irqsave(&zone->lock, flags);
 	zone->nr_isolate_pageblock += nr_pages / pageblock_nr_pages;
@@ -1113,7 +1113,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 		build_all_zonelists(NULL);
 
 	/* Basic onlining is complete, allow allocation of onlined pages. */
-	undo_isolate_page_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
+	undo_isolate_pageblocks(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
 
 	/*
 	 * Freshly onlined pages aren't shuffled (e.g., all pages are placed to
@@ -1834,7 +1834,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	lru_cache_disable();
 
 	/* set above range as isolated */
-	ret = start_isolate_page_range(start_pfn, end_pfn,
+	ret = start_isolate_pageblocks(start_pfn, end_pfn,
 				       MIGRATE_MOVABLE,
 				       MEMORY_OFFLINE | REPORT_FAILURE);
 	if (ret) {
@@ -1937,7 +1937,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 
 failed_removal_isolated:
 	/* pushback to free area */
-	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
+	undo_isolate_pageblocks(start_pfn, end_pfn, MIGRATE_MOVABLE);
 	memory_notify(MEM_CANCEL_OFFLINE, &arg);
 failed_removal_pcplists_disabled:
 	lru_cache_enable();
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index badc05fc1b2f..76f8c19e37a2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8950,15 +8950,6 @@ void *__init alloc_large_system_hash(const char *tablename,
 }
 
 #ifdef CONFIG_CONTIG_ALLOC
-static unsigned long pfn_max_align_down(unsigned long pfn)
-{
-	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
-}
-
-static unsigned long pfn_max_align_up(unsigned long pfn)
-{
-	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
-}
 
 #if defined(CONFIG_DYNAMIC_DEBUG) || \
 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
@@ -9104,8 +9095,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * put back to page allocator so that buddy can use them.
 	 */
 
-	ret = start_isolate_page_range(pfn_max_align_down(start),
-				       pfn_max_align_up(end), migratetype, 0);
+	ret = start_isolate_page_range(start, end, migratetype, 0);
 	if (ret)
 		return ret;
 
@@ -9186,8 +9176,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 		free_contig_range(end, outer_end - end);
 
 done:
-	undo_isolate_page_range(pfn_max_align_down(start),
-				pfn_max_align_up(end), migratetype);
+	undo_isolate_page_range(start, end, migratetype);
 	return ret;
 }
 EXPORT_SYMBOL(alloc_contig_range);
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index b34f1310aeaa..7c1f7724c5bb 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -15,6 +15,16 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/page_isolation.h>
 
+static unsigned long pfn_max_align_down(unsigned long pfn)
+{
+	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
+}
+
+static unsigned long pfn_max_align_up(unsigned long pfn)
+{
+	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
+}
+
 /*
  * This function checks whether pageblock includes unmovable pages or not.
  *
@@ -262,12 +272,40 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
 	return NULL;
 }
 
+/*
+ * Make page-allocation-type of pageblocks to be MIGRATE_ISOLATE.
+ *
+ * Most users should actually use start_isolate_page_range(). Only memory
+ * onlining/offlining that knows exactly what it's doing in regard to
+ * isolating only some pageblocks of MAX_ORDER - 1 pages (for the vmemmap)
+ * should use this interface.
+ */
+int start_isolate_pageblocks(unsigned long start_pfn, unsigned long end_pfn,
+			     unsigned migratetype, int flags)
+{
+	unsigned long pfn;
+	struct page *page;
+
+	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
+	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
+
+	for (pfn = start_pfn;
+	     pfn < end_pfn;
+	     pfn += pageblock_nr_pages) {
+		page = __first_valid_page(pfn, pageblock_nr_pages);
+		if (page && set_migratetype_isolate(page, migratetype, flags)) {
+			undo_isolate_pageblocks(start_pfn, pfn, migratetype);
+			return -EBUSY;
+		}
+	}
+	return 0;
+}
+
 /**
  * start_isolate_page_range() - make page-allocation-type of range of pages to
  * be MIGRATE_ISOLATE.
  * @start_pfn:		The lower PFN of the range to be isolated.
  * @end_pfn:		The upper PFN of the range to be isolated.
- *			start_pfn/end_pfn must be aligned to pageblock_order.
  * @migratetype:	Migrate type to set in error recovery.
  * @flags:		The following flags are allowed (they can be combined in
  *			a bit mask)
@@ -306,29 +344,23 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 			     unsigned migratetype, int flags)
 {
-	unsigned long pfn;
-	struct page *page;
-
-	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
-	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
+	start_pfn = = pfn_max_align_down(start_pfn);
+	end_pfn = pfn_max_align_up(end_pfn);
 
-	for (pfn = start_pfn;
-	     pfn < end_pfn;
-	     pfn += pageblock_nr_pages) {
-		page = __first_valid_page(pfn, pageblock_nr_pages);
-		if (page && set_migratetype_isolate(page, migratetype, flags)) {
-			undo_isolate_page_range(start_pfn, pfn, migratetype);
-			return -EBUSY;
-		}
-	}
-	return 0;
+	return start_isolate_pageblocks(start_pfn, end_pfn, migratetype, flags);
 }
 
 /*
- * Make isolated pages available again.
+ * Make isolated pageblocks, isolated via start_isolate_pageblocks, available
+ * again.
+ *
+ * Most users should actually use undo_isolate_page_range(). Only memory
+ * onlining/offlining that knows exactly what it's doing in regard to
+ * isolating only some pageblocks of MAX_ORDER - 1 pages (for the vmemmap)
+ * should use this interface.
  */
-void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			    unsigned migratetype)
+void undo_isolate_pageblocks(unsigned long start_pfn, unsigned long end_pfn,
+			     unsigned migratetype)
 {
 	unsigned long pfn;
 	struct page *page;
@@ -345,6 +377,21 @@ void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 		unset_migratetype_isolate(page, migratetype);
 	}
 }
+
+/*
+ * Make isolated pageblocks, isolated via start_isolate_page_range(), available
+ * again. The pageblock isolation range will be extended just like for
+ * start_isolate_page_range().
+ */
+void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
+			     unsigned migratetype)
+{
+	start_pfn = = pfn_max_align_down(start_pfn);
+	end_pfn = pfn_max_align_up(end_pfn);
+
+	return undo_isolate_pageblocks(start_pfn, end_pfn, migratetype);
+}
+
 /*
  * Test all pages in the range is free(means isolated) or not.
  * all pages in [start_pfn...end_pfn) must be in the same zone.
-- 
2.35.1



-- 
Thanks,

David / dhildenb

