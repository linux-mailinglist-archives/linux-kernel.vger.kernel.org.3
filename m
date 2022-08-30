Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C475A6C97
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiH3SxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiH3SxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107D04D148
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661885592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ghkL3HWufEx19QvN7xz+8k8R4rKZfYVWdUF1YonDVk=;
        b=hptJfB/kOzF2NCivboJv/P4WzuaiAYj33e7U+XIfaMMgbEMDJSc1jutdN0yqSDOzX7eIQf
        hibglyeHsrkJ0Yl3L/w6fOwyoHyy3GzSyLMylVuUxxujxKNdIhB9ZIYkQKH7zNWe0mkPjM
        KGCyZANqqXWi+Tv86tw8QDUvXwkRuVc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-428-tThSsHwAP5644HQRa_mAyg-1; Tue, 30 Aug 2022 14:53:09 -0400
X-MC-Unique: tThSsHwAP5644HQRa_mAyg-1
Received: by mail-wm1-f72.google.com with SMTP id v3-20020a1cac03000000b003a7012c430dso7750884wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=3ghkL3HWufEx19QvN7xz+8k8R4rKZfYVWdUF1YonDVk=;
        b=os1L19bq5/zyBOYfOYbBxGbDSS3GUI1moUaKZGS5YinupF9m/647CwElXE9C7QVNSH
         lp3BgVS8veRV9FmrzreXJ1zTbiBIxplA12EY5k0cu57rAExL9MUabdxYo/M+jXnqf2K3
         r2I7ZKGQxJkUkPuoZa64kibRXsQsPkwJOuvi/m4JD8izPFvyDE1W+UDimwvbnHyfWA9U
         cigeNr7v3OjrgvumSJo0CavBQ/8oL3fhIRLa3rYWBqfrZRjA8xrH9v/j8CAG6VYRbQfa
         tWhVNKl2m6Ut97oIn+SMhqreVHl149/dmuiNoto0zny9yCpv4OqB/k2ssUYvSYd2/wPQ
         U+iQ==
X-Gm-Message-State: ACgBeo1lMpaPZbdMl8EaBpA8kF8brnr4sPivC3hePOVzmg2ZQ+Y/UdFp
        tCCkMIAlTT1YUbF2WHFN7bdsLKclR+xxUvfdgW3rbXKn/GiDqnHY28SI88yIS0ghC1Su9UO/CA0
        MVP86UN/oBo7iFKuFLPqSfb7t
X-Received: by 2002:a05:600c:4e49:b0:3a5:dd23:90d7 with SMTP id e9-20020a05600c4e4900b003a5dd2390d7mr10542412wmq.41.1661885588414;
        Tue, 30 Aug 2022 11:53:08 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6xPd1ofzTGAMjW/LlczuN37PG9NBD6QwEUuSCHZVsEQen/hctS0Csc6k5meeHh9wWVX8hZVA==
X-Received: by 2002:a05:600c:4e49:b0:3a5:dd23:90d7 with SMTP id e9-20020a05600c4e4900b003a5dd2390d7mr10542396wmq.41.1661885588108;
        Tue, 30 Aug 2022 11:53:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:1000:ecb4:919b:e3d3:e20b? (p200300cbc70a1000ecb4919be3d3e20b.dip0.t-ipconnect.de. [2003:cb:c70a:1000:ecb4:919b:e3d3:e20b])
        by smtp.gmail.com with ESMTPSA id i9-20020adfefc9000000b002251c75c09csm11972556wrp.90.2022.08.30.11.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 11:53:07 -0700 (PDT)
Message-ID: <9ce3aaaa-71a6-5a81-16a3-36e6763feb91@redhat.com>
Date:   Tue, 30 Aug 2022 20:53:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        John Hubbard <jhubbard@nvidia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>
References: <20220825164659.89824-1-david@redhat.com>
 <20220825164659.89824-3-david@redhat.com>
 <1892f6de-fd22-0e8b-3ff6-4c8641e1c68e@redhat.com>
 <2e20c90d-4d1f-dd83-aa63-9d8d17021263@redhat.com>
 <Yw5a1paQJ9MNdgmW@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 2/3] mm/gup: use gup_can_follow_protnone() also in
 GUP-fast
In-Reply-To: <Yw5a1paQJ9MNdgmW@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.22 20:45, Jason Gunthorpe wrote:
> On Tue, Aug 30, 2022 at 08:23:52PM +0200, David Hildenbrand wrote:
>> ... and looking into the details of TLB flush and GUP-fast interaction
>> nowadays, that case is no longer relevant. A TLB flush is no longer
>> sufficient to stop concurrent GUP-fast ever since we introduced generic
>> RCU GUP-fast.
> 
> Yes, we've had RCU GUP fast for a while, and it is more widely used
> now, IIRC.
> 
> It has been a bit, but if I remember, GUP fast in RCU mode worked on a
> few principles:
> 
>  - The PTE page must not be freed without RCU
>  - The PTE page content must be convertable to a struct page using the
>    usual rules (eg PTE Special)
>  - That struct page refcount may go from 0->1 inside the RCU
>  - In the case the refcount goes from 0->1 there must be sufficient
>    barriers such that GUP fast observing the refcount of 1 will also
>    observe the PTE entry has changed. ie before the refcount is
>    dropped in the zap it has to clear the PTE entry, the refcount
>    decr has to be a 'release' and the refcount incr in gup fast has be
>    to be an 'acquire'.
>  - The rest of the system must tolerate speculative refcount
>    increments from GUP on any random page
> > The basic idea being that if GUP fast obtains a valid reference on a
> page *and* the PTE entry has not changed then everything is fine.
> 
> The tricks with TLB invalidation are just a "poor mans" RCU, and
> arguably these days aren't really needed since I think we could make
> everything use real RCU always without penalty if we really wanted.
> 
> Today we can create a unique 'struct pagetable_page' as Matthew has
> been doing in other places that guarentees a rcu_head is always
> available for every page used in a page table. Using that we could
> drop the code in the TLB flusher that allocates memory for the
> rcu_head and hopes for the best. (Or even is the common struct page
> rcu_head already guarenteed to exist for pagetable pages now a days?)
> 
> IMHO that is the main reason we still have the non-RCU mode at all..


Good, I managed to attract the attention of someone who understands that machinery :)

While validating whether GUP-fast and PageAnonExclusive code work correctly,
I started looking at the whole RCU GUP-fast machinery. I do have a patch to
improve PageAnonExclusive clearing (I think we're missing memory barriers to
make it work as expected in any possible case), but I also stumbled eventually
over a more generic issue that might need memory barriers.

Any thoughts whether I am missing something or this is actually missing
memory barriers?


From ce8c941c11d1f60cea87a3e4d941041dc6b79900 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Mon, 29 Aug 2022 16:57:07 +0200
Subject: [PATCH] mm/gup: update refcount+pincount before testing if the PTE
 changed

mm/ksm.c:write_protect_page() has to make sure that no unknown
references to a mapped page exist and that no additional ones with write
permissions are possible -- unknown references could have write permissions
and modify the page afterwards.

Conceptually, mm/ksm.c:write_protect_page() consists of:
  (1) Clear/invalidate PTE
  (2) Check if there are unknown references; back off if so.
  (3) Update PTE (e.g., map it R/O)

Conceptually, GUP-fast code consists of:
  (1) Read the PTE
  (2) Increment refcount/pincount of the mapped page
  (3) Check if the PTE changed by re-reading it; back off if so.

To make sure GUP-fast won't be able to grab additional references after
clearing the PTE, but will properly detect the change and back off, we
need a memory barrier between updating the recount/pincount and checking
if it changed.

try_grab_folio() doesn't necessarily imply a memory barrier, so add an
explicit smp_mb__after_atomic() after the atomic RMW operation to
increment the refcount and pincount.

ptep_clear_flush() used to clear the PTE and flush the TLB should imply
a memory barrier for flushing the TLB, so don't add another one for now.

PageAnonExclusive handling requires further care and will be handled
separately.

Fixes: 2667f50e8b81 ("mm: introduce a general RCU get_user_pages_fast()")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 5abdaf487460..0008b808f484 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2392,6 +2392,14 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 			goto pte_unmap;
 		}
 
+		/*
+		 * Update refcount/pincount before testing for changed PTE. This
+		 * is required for code like mm/ksm.c:write_protect_page() that
+		 * wants to make sure that a page has no unknown references
+		 * after clearing the PTE.
+		 */
+		smp_mb__after_atomic();
+
 		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
 			gup_put_folio(folio, 1, flags);
 			goto pte_unmap;
@@ -2577,6 +2585,9 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	if (!folio)
 		return 0;
 
+	/* See gup_pte_range(). */
+	smp_mb__after_atomic();
+
 	if (unlikely(pte_val(pte) != pte_val(*ptep))) {
 		gup_put_folio(folio, refs, flags);
 		return 0;
@@ -2643,6 +2654,9 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	if (!folio)
 		return 0;
 
+	/* See gup_pte_range(). */
+	smp_mb__after_atomic();
+
 	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
 		gup_put_folio(folio, refs, flags);
 		return 0;
@@ -2683,6 +2697,9 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 	if (!folio)
 		return 0;
 
+	/* See gup_pte_range(). */
+	smp_mb__after_atomic();
+
 	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
 		gup_put_folio(folio, refs, flags);
 		return 0;
-- 
2.37.1




-- 
Thanks,

David / dhildenb

