Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D60549B053
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574160AbiAYJc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:32:28 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37470 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573411AbiAYJXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:23:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 41CCB1F381;
        Tue, 25 Jan 2022 09:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643102594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IHLfqC26/ZySpJ9o3h2r57QMCxwt9mzMwoe0dLzT+l4=;
        b=fNpDwIzNQmpJcHrAmeo5BdlQH9uBbrKEITzB9n96768XwfQ/D0ML9HSalSbl7tbYiMNB/R
        CsmgzS2jvwybMB7QdmMJ6cSasmzpVrAbeZ+JI9rstx59nPhpuZC5ACRMi4VWroMLUGJgzi
        QQ3wFiVabi1M5UOuW7Ys3QuTwkiIj48=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F21FCA3B81;
        Tue, 25 Jan 2022 09:23:13 +0000 (UTC)
Date:   Tue, 25 Jan 2022 10:23:13 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [RESEND][PATCH v2] mm: don't call lru draining in the nested
 lru_cache_disable
Message-ID: <Ye/Bgc1bH979cXwy@dhcp22.suse.cz>
References: <YeVzWlrojI1+buQx@dhcp22.suse.cz>
 <YedXhpwURNTkW1Z3@google.com>
 <YefX1t4owjlx/m5I@dhcp22.suse.cz>
 <YejkUlnnYeED1pC5@google.com>
 <YekcNmBqcpO9BYWv@dhcp22.suse.cz>
 <YenPK/JVNOhbxjtr@google.com>
 <YeqEBAKJ6NUjLQhr@dhcp22.suse.cz>
 <YessDywpsnCyrfIy@google.com>
 <Ye54ELlNBpeHoXsj@dhcp22.suse.cz>
 <Ye8mi80ObVZvLdS1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye8mi80ObVZvLdS1@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24-01-22 14:22:03, Minchan Kim wrote:
[...]
>  CPU 0                               CPU 1
> 
>  lru_cache_disable                  lru_cache_disable
>    ret = atomic_inc_return;(ret = 1)
>                                      
>                                     ret = atomic_inc_return;(ret = 2)
>                                     
>    lru_add_drain_all(true);         
>                                     lru_add_drain_all(false)
>                                     mutex_lock() is holding
>    mutex_lock() is waiting
> 
>                                     IPI with !force_all_cpus
>                                     ...
>                                     ...
>                                     IPI done but it skipped some CPUs
>                
>      ..
>      ..
>  
> 
> Thus, lru_cache_disable on CPU 1 doesn't run with every CPUs so it
> introduces race of lru_disable_count so some pages on cores
> which didn't run the IPI could accept upcoming pages into per-cpu
> cache.

Yes, that is certainly possible but the question is whether it really
matters all that much. The race would require also another racer to be
adding a page to an _empty_ pcp list at the same time.

pagevec_add_and_need_flush
  1) pagevec_add # add to pcp list
  2) lru_cache_disabled
    atomic_read(lru_disable_count) = 0
  # no flush but the page is on pcp

There is no strong memory ordering between 1 and 2 and that is why we
need an IPI to enforce it in general IIRC.

But lru_cache_disable is not a strong synchronization primitive. It aims
at providing a best effort means to reduce false positives, right? IMHO
it doesn't make much sense to aim for perfection because all users of
this interface already have to live with temporary failures and pcp
caches is not the only reason to fail - e.g. short lived page pins.

That being said, I would rather live with a best effort and simpler
implementation approach rather than aim for perfection in this case.
The scheme is already quite complex and another lock in the mix doesn't
make it any easier to follow. If others believe that another lock makes
the implementation more straightforward I will not object but I would go
with the following.

diff --git a/mm/swap.c b/mm/swap.c
index ae8d56848602..c140c3743b9e 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -922,7 +922,8 @@ atomic_t lru_disable_count = ATOMIC_INIT(0);
  */
 void lru_cache_disable(void)
 {
-	atomic_inc(&lru_disable_count);
+	int count = atomic_inc_return(&lru_disable_count);
+
 #ifdef CONFIG_SMP
 	/*
 	 * lru_add_drain_all in the force mode will schedule draining on
@@ -931,8 +932,28 @@ void lru_cache_disable(void)
 	 * The atomic operation doesn't need to have stronger ordering
 	 * requirements because that is enforeced by the scheduling
 	 * guarantees.
+	 * Please note that there is a potential for a race condition:
+	 * CPU0				CPU1			CPU2
+	 * pagevec_add_and_need_flush
+	 *   pagevec_add # to the empty list
+	 *   lru_cache_disabled
+	 *     atomic_read # 0
+	 *   				lru_cache_disable	lru_cache_disable
+	 *				  atomic_inc_return (1)
+	 *				  			  atomic_inc_return (2)
+	 *				  __lru_add_drain_all(true)
+	 *				  			  __lru_add_drain_all(false)
+	 *				  			    mutex_lock
+	 *				    mutex_lock
+	 *				    			    # skip cpu0 (pagevec_add not visible yet)
+	 *				    			    mutex_unlock
+	 *				    			 # fail because of pcp(0) pin
+	 *				    queue_work_on(0)
+	 *
+	 * but the scheme is a best effort and the above race quite unlikely
+	 * to matter in real life.
 	 */
-	__lru_add_drain_all(true);
+	__lru_add_drain_all(count == 1);
 #else
 	lru_add_and_bh_lrus_drain();
 #endif
-- 
Michal Hocko
SUSE Labs
