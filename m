Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A5C577AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbiGRGSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 02:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbiGRGSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:18:12 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4576EE083
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 23:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658125091; x=1689661091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eG2wLKtE7ob+1Kxa4ilGbg0ocyZHYcoie/+7T0DieRM=;
  b=wL4K749J3UdVSHTrB7yyYkCvELPt/rfMLw762k3pvJ9dbzu225uAbOK1
   Zc+H2xkz5Xaump0ilpg9wgRWhe8XKsBGV4Q/nimsoHfN2WSocPlq4/Uw2
   i5Kun/dZB/PELMwe52FFbUQvhA/lhiUPB60qbn7TaK2PvfgcKBMp7soxK
   g=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 17 Jul 2022 23:18:11 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 23:18:10 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 17 Jul 2022 23:18:10 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 17 Jul 2022 23:11:24 -0700
Date:   Mon, 18 Jul 2022 11:41:20 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
CC:     <akpm@linux-foundation.org>, <pasha.tatashin@soleen.com>,
        <sjpark@amazon.de>, <sieberf@amazon.com>, <shakeelb@google.com>,
        <dhowells@redhat.com>, <willy@infradead.org>, <mhocko@suse.com>,
        <vbabka@suse.cz>, <david@redhat.com>, <minchan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: fix use-after free of page_ext after race with
 memory-offline
Message-ID: <20220718061120.GA8922@hu-pkondeti-hyd.qualcomm.com>
References: <1657810063-28938-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1657810063-28938-1-git-send-email-quic_charante@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charan,

On Thu, Jul 14, 2022 at 08:17:43PM +0530, Charan Teja Kalla wrote:
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
> 
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
> 
> Thanks to David Hildenbrand for his views/suggestions on the initial
> discussion[1].
> 
> [1] https://lore.kernel.org/linux-mm/59edde13-4167-8550-86f0-11fc67882107@quicinc.com/
> 
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> ---
>  include/linux/page_ext.h  | 19 +++++++++++++++++++
>  include/linux/page_idle.h | 40 ++++++++++++++++++++++++++++++----------
>  mm/page_ext.c             |  3 ++-
>  mm/page_owner.c           | 18 +++++++++++++++---
>  mm/page_table_check.c     | 10 +++++++---
>  5 files changed, 73 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
> index fabb2e1..df5d353 100644
> --- a/include/linux/page_ext.h
> +++ b/include/linux/page_ext.h
> @@ -64,6 +64,25 @@ static inline struct page_ext *page_ext_next(struct page_ext *curr)
>  	return next;
>  }
>  
> +static inline struct page_ext *get_page_ext(struct page *page)
> +{
> +	struct page_ext *page_ext;
> +
> +	rcu_read_lock();
> +	page_ext = lookup_page_ext(page);
> +	if (!page_ext) {
> +		rcu_read_unlock();
> +		return NULL;
> +	}
> +
> +	return page_ext;
> +}
> +
> +static inline void put_page_ext(void)
> +{
> +	rcu_read_unlock();
> +}
> +
Would it be a harm if we make lookup_page_ext() completely a private function?
Or is there any codepath that have the benefit of calling lookup_page_ext()
without going through get_page_ext()? If that is the case, we should add
RCU lockdep check inside lookup_page_ext() to make sure that this function is
called with RCUs.

Thanks,
Pavan
