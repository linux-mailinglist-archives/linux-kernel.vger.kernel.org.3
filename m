Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD40454C048
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242046AbiFODrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiFODrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:47:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154231260B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 20:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655264853; x=1686800853;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7+KaXy+Ck+yPVdZA+JXKuDsVDGPUO+xDK8yDgUwh2fM=;
  b=HxQyecLtEmyeRNHjN4yhIdJbIc+ZBG1EwNMPblAs+w/xSW/n1ahGa8tn
   telqAW9RvuVzqb5iBj6wXt/Snea1tPr+KPV67pVuAOzDJm7aFIwOnWNeG
   wQrN1xswgGadMbktgOrWhjBZJdJ1CRX6104hGXwkN2MbQUV1f7G04JtG7
   jStLxWeuJdyAli2qF9diPDXOi44uPOArgKM1jWcylyrnlMxjhEY6SjTQ/
   rlPIDbeVwOGIv6j3QN0J5sqj6lITLxtXlcCSZJZqJ6tUOZSCEyvji1cV0
   3v33+J6Jj2Najccfwn9qubp2RpqeUKM+DtWsNN1N41siYWSFHOZfXUZol
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="276395580"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="276395580"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 20:47:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="640754148"
Received: from yutang-mobl.ccr.corp.intel.com ([10.254.214.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 20:47:29 -0700
Message-ID: <98651df913231327d5167116b65de26c7d390a2c.camel@intel.com>
Subject: Re: [PATCH -V3 0/3] memory tiering: hot page selection
From:   Ying Huang <ying.huang@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Zhong Jiang <zhongjiang-ali@linux.alibaba.com>
Date:   Wed, 15 Jun 2022 11:47:23 +0800
In-Reply-To: <YqipqdGwNqQDxb/6@cmpxchg.org>
References: <20220614081635.194014-1-ying.huang@intel.com>
         <YqipqdGwNqQDxb/6@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-14 at 11:30 -0400, Johannes Weiner wrote:
> Hi Huang,

Hi, Johannes,

> Have you had a chance to look at our hot page detection patch that
> Hasan has sent out some time ago? [1]

Yes.  I have seen that patch before.

> It hooks into page reclaim to determine what is and isn't hot. Reclaim
> is an existing, well-tested mechanism to do just that. It's just 13
> lines of code: set active bit on the first hint fault; promote on the
> second one if the active bit is still set. This promotes only pages
> hot enough that they can compete with toptier access frequencies.

In general, I think that patch is good.  And it can work with the hot
page selection patchset (this series) together.  That is, if
!PageActive(), then activate the page; otherwise, promote the page if
the hint page fault latency is short too.

In a system with swap device configured, and with continuous memory
pressure on all memory types (including PMEM), the NUMA balancing hint
page fault can help the page reclaiming, the page accesses can be
detected much earlier.  And page reclaiming can help page promotion
via keeping recently-not-accessed pages in inactive list and
recently-accessed pages in active list.

In a system without swap device configured and continuous memory
pressure on slow tier memory (e.g., PMEM), page reclaiming doesn't
help much because the active/inactive list aren't scanned regularly.
This is true for some users.  And the method in this series still
helps.

> It's not just convenient, it's also essential to link tier promotion
> rate to page aging. Tiered NUMA balancing is about establishing a
> global LRU order across two (or more) nodes. LRU promotions *within* a
> node require multiple LRU cycles with references.

IMHO, LRU algorithm is good for page reclaiming.  It isn't sufficient
for page promoting by itself.  Because it can identify cold pages
well, but its accuracy of identifying hot pages isn't enough.  That
is, it's hard to distinguish between warm pages and hot pages with
LRU/MRU itself.  The hint page fault latency introduced in this series
is to help on that.

> LRU promotions
> *between* nodes must follow the same rules, and be subject to the same
> aging pressure, or you can get much colder pages promoted into a very
> hot workingset and wreak havoc.
> 
> We've hammered this patch quite extensively with several Meta
> production workloads and it's been working reliably at keeping
> reasonable promotion rates.

Sounds good.  Do you have some data to share?

> @@ -4202,6 +4202,19 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  
> 
>  	last_cpupid = page_cpupid_last(page);
>  	page_nid = page_to_nid(page);
> +
> +	/* Only migrate pages that are active on non-toptier node */
> +	if (numa_promotion_tiered_enabled &&
> +		!node_is_toptier(page_nid) &&
> +		!PageActive(page)) {
> +		count_vm_numa_event(NUMA_HINT_FAULTS);
> +		if (page_nid == numa_node_id())
> +			count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
> +		mark_page_accessed(page);
> +		pte_unmap_unlock(vmf->pte, vmf->ptl);
> +		goto out;
> +	}
> +
>  	target_nid = numa_migrate_prep(page, vma, vmf->address, page_nid,
>  			&flags);
>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
> 
> [1] https://lore.kernel.org/all/20211130003634.35468-1-hasanalmaruf@fb.com/t/#m85b95624622f175ca17a00cc8cc0fc9cc4eeb6d2

Best Regards,
Huang, Ying

