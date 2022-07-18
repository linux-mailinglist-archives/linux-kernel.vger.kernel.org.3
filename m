Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2366757813D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiGRLuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbiGRLuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:50:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BCE1D0E3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:50:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9ACDB1FAE3;
        Mon, 18 Jul 2022 11:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658145030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eKzpLVM2ghrjyx6usBgvoxGV0PT3wE1TbPP4tTz+nTY=;
        b=iq1q3Rl6+6ppxktg6X7qVZQ/OmPN24PXOfdWaYB58OLJtFKnYrUtm9agyJLsAdwI+ny8oQ
        2KLNXTi/0Uay0DyGjueWsKmagOJR5JrUH96ZETQvHlGxb8amYfUPNrEOsSmz+/IqmR1C+x
        sfNVmzOPGtob257IKFSLHCOvb9kAB24=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 561662C141;
        Mon, 18 Jul 2022 11:50:30 +0000 (UTC)
Date:   Mon, 18 Jul 2022 13:50:29 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, pasha.tatashin@soleen.com,
        sjpark@amazon.de, sieberf@amazon.com, shakeelb@google.com,
        dhowells@redhat.com, willy@infradead.org, vbabka@suse.cz,
        david@redhat.com, minchan@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: fix use-after free of page_ext after race with
 memory-offline
Message-ID: <YtVJBQ/ZOt22o8+B@dhcp22.suse.cz>
References: <1657810063-28938-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657810063-28938-1-git-send-email-quic_charante@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14-07-22 20:17:43, Charan Teja Kalla wrote:
> The below is one path where race between page_ext and  offline of the
> respective memory blocks will cause use-after-free on the access of
> page_ext structure.
> 
> process1		              process2
> ---------                             ---------
> a)doing /proc/page_owner           doing memory offline
> 			           through offline_pages.
> 
> b)PageBuddy check is failed
> thus proceed to get the
> page_owner information
> through page_ext access.
> page_ext = lookup_page_ext(page);
> 
> 				    migrate_pages();
> 				    .................
> 				Since all pages are successfully
> 				migrated as part of the offline
> 				operation,send MEM_OFFLINE notification
> 				where for page_ext it calls:
> 				offline_page_ext()-->
> 				__free_page_ext()-->
> 				   free_page_ext()-->
> 				     vfree(ms->page_ext)
> 			           mem_section->page_ext = NULL
> 
> c) Check for the PAGE_EXT flags
> in the page_ext->flags access
> results into the use-after-free(leading
> to the translation faults).
> 
> As mentioned above, there is really no synchronization between page_ext
> access and its freeing in the memory_offline.
> 
> The memory offline steps(roughly) on a memory block is as below:
> 1) Isolate all the pages
> 2) while(1)
>   try free the pages to buddy.(->free_list[MIGRATE_ISOLATE])
> 3) delete the pages from this buddy list.
> 4) Then free page_ext.(Note: The struct page is still alive as it is
> freed only during hot remove of the memory which frees the memmap, which
> steps the user might not perform).
> 
> This design leads to the state where struct page is alive but the struct
> page_ext is freed, where the later is ideally part of the former which
> just representing the page_flags. This seems to be a wrong design where
> 'struct page' as a whole is not accessible(Thanks to Minchan for
> pointing this out).

Nice description of the problem! Thanks!

> The above mentioned race is just one example __but the problem persists
> in the other paths too involving page_ext->flags access(eg:
> page_is_idle())__. Since offline waits till the last reference on the
> page goes down i.e. any path that took the refcount on the page can make
> the memory offline operation to wait. Eg: In the migrate_pages()
> operation, we do take the extra refcount on the pages that are under
> migration and then we do copy page_owner by accessing page_ext. For
> 
> Fix those paths where offline races with page_ext access by maintaining
> synchronization with rcu lock.

Please be much more specific about the synchronization. How does RCU
actually synchronize the offlining and access? Higher level description
of all the actors would be very helpful not only for the review but also
for future readers.

Also, more specifically
[...]
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 3dc715d..5ccd3ee 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -299,8 +299,9 @@ static void __free_page_ext(unsigned long pfn)
>  	if (!ms || !ms->page_ext)
>  		return;
>  	base = get_entry(ms->page_ext, pfn);
> -	free_page_ext(base);
>  	ms->page_ext = NULL;
> +	synchronize_rcu();
> +	free_page_ext(base);
>  }

So you are imposing the RCU grace period for each page_ext! This can get
really expensive. Have you tried to measure the effect?

Is there any reason why page_ext is freed during offlining rather when
it is hotremoved?

Thanks!
-- 
Michal Hocko
SUSE Labs
