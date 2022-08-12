Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C9F590A52
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 04:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbiHLCen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 22:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbiHLCej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 22:34:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC840A261F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 19:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660271678; x=1691807678;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=qh40Lm/37pv5tGRPKccggrBuhhWLRJDlyqjgNjVAxKo=;
  b=m+3y7tXIzbNOHbPacVIktyG/252XThgwedku/XdAe0jgvXZG7/5tg/Sg
   JJpmQGaNT6V/EJtHJZfz0X/cExuPN65BP5T2yj5/GpNMoVPkICqTFXmfQ
   KjU79LXrX8g33S8UBaAAlMQIvGjcbuXKXJxkHyS2bphOqUoX2UmUfXKNR
   8ugvNDcbJtz594C7LdrOMXU+SqlJ8O0qEun3B+LV06CZOOQfKtRXDEbfT
   5+VhnIV6EzYCA3+0J0JpIMyJBhVakl/FNCnqQzliAv30O/neg5If0vG0M
   TEF2gYQ08KiOghEYK/98kKUwfMHbKI4EOIAdAetARp5Uvq3DsPRu3gdDV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="292769699"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="292769699"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 19:34:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="851419826"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 19:34:35 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 6/7] mm/swap: Cache maximum swapfile size when init swap
References: <20220811161331.37055-1-peterx@redhat.com>
        <20220811161331.37055-7-peterx@redhat.com>
Date:   Fri, 12 Aug 2022 10:34:32 +0800
In-Reply-To: <20220811161331.37055-7-peterx@redhat.com> (Peter Xu's message of
        "Thu, 11 Aug 2022 12:13:30 -0400")
Message-ID: <87h72idwav.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> We used to have swapfile_maximum_size() fetching a maximum value of
> swapfile size per-arch.
>
> As the caller of max_swapfile_size() grows, this patch introduce a variable
> "swapfile_maximum_size" and cache the value of old max_swapfile_size(), so
> that we don't need to calculate the value every time.
>
> Caching the value in swapfile_init() is safe because when reaching the
> phase we should have initialized all the relevant information.  Here the
> major arch to take care of is x86, which defines the max swapfile size
> based on L1TF mitigation.
>
> Here both X86_BUG_L1TF or l1tf_mitigation should have been setup properly
> when reaching swapfile_init(). As a reference, the code path looks like
> this for x86:
>
> - start_kernel
>   - setup_arch
>     - early_cpu_init
>       - early_identify_cpu --> setup X86_BUG_L1TF
>   - parse_early_param
>     - l1tf_cmdline --> set l1tf_mitigation
>   - check_bugs
>     - l1tf_select_mitigation --> set l1tf_mitigation
>   - arch_call_rest_init
>     - rest_init
>       - kernel_init
>         - kernel_init_freeable
>           - do_basic_setup
>             - do_initcalls --> calls swapfile_init() (initcall level 4)
>
> The swapfile size only depends on swp pte format on non-x86 archs, so
> caching it is safe too.
>
> Since at it, rename max_swapfile_size() to arch_max_swapfile_size() because
> arch can define its own function, so it's more straightforward to have
> "arch_" as its prefix.  At the meantime, export swapfile_maximum_size to
> replace the old usages of max_swapfile_size().
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

LGTM.

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Best Regards,
Huang, Ying

> ---
>  arch/x86/mm/init.c       | 2 +-
>  include/linux/swapfile.h | 3 ++-
>  include/linux/swapops.h  | 2 +-
>  mm/swapfile.c            | 7 +++++--
>  4 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index 82a042c03824..9121bc1b9453 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -1054,7 +1054,7 @@ void update_cache_mode_entry(unsigned entry, enum page_cache_mode cache)
>  }
>  
>  #ifdef CONFIG_SWAP
> -unsigned long max_swapfile_size(void)
> +unsigned long arch_max_swapfile_size(void)
>  {
>  	unsigned long pages;
>  
> diff --git a/include/linux/swapfile.h b/include/linux/swapfile.h
> index 54078542134c..165e0bd04862 100644
> --- a/include/linux/swapfile.h
> +++ b/include/linux/swapfile.h
> @@ -8,6 +8,7 @@
>   */
>  extern struct swap_info_struct *swap_info[];
>  extern unsigned long generic_max_swapfile_size(void);
> -extern unsigned long max_swapfile_size(void);
> +/* Maximum swapfile size supported for the arch (not inclusive). */
> +extern unsigned long swapfile_maximum_size;
>  
>  #endif /* _LINUX_SWAPFILE_H */
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index 36e462e116af..f25b566643f1 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -307,7 +307,7 @@ static inline bool migration_entry_supports_ad(void)
>  	 * the offset large enough to cover all of them (PFN, A & D bits).
>  	 */
>  #ifdef CONFIG_SWAP
> -	return max_swapfile_size() >= (1UL << SWP_MIG_TOTAL_BITS);
> +	return swapfile_maximum_size >= (1UL << SWP_MIG_TOTAL_BITS);
>  #else  /* CONFIG_SWAP */
>  	return false;
>  #endif	/* CONFIG_SWAP */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 1fdccd2f1422..3cc64399df44 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -63,6 +63,7 @@ EXPORT_SYMBOL_GPL(nr_swap_pages);
>  /* protected with swap_lock. reading in vm_swap_full() doesn't need lock */
>  long total_swap_pages;
>  static int least_priority = -1;
> +unsigned long swapfile_maximum_size;
>  
>  static const char Bad_file[] = "Bad swap file entry ";
>  static const char Unused_file[] = "Unused swap file entry ";
> @@ -2816,7 +2817,7 @@ unsigned long generic_max_swapfile_size(void)
>  }
>  
>  /* Can be overridden by an architecture for additional checks. */
> -__weak unsigned long max_swapfile_size(void)
> +__weak unsigned long arch_max_swapfile_size(void)
>  {
>  	return generic_max_swapfile_size();
>  }
> @@ -2856,7 +2857,7 @@ static unsigned long read_swap_header(struct swap_info_struct *p,
>  	p->cluster_next = 1;
>  	p->cluster_nr = 0;
>  
> -	maxpages = max_swapfile_size();
> +	maxpages = swapfile_maximum_size;
>  	last_page = swap_header->info.last_page;
>  	if (!last_page) {
>  		pr_warn("Empty swap-file\n");
> @@ -3677,6 +3678,8 @@ static int __init swapfile_init(void)
>  	for_each_node(nid)
>  		plist_head_init(&swap_avail_heads[nid]);
>  
> +	swapfile_maximum_size = arch_max_swapfile_size();
> +
>  	return 0;
>  }
>  subsys_initcall(swapfile_init);
