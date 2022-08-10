Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E3F58E75C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 08:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiHJGhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 02:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiHJGhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 02:37:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3A26F54C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 23:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660113466; x=1691649466;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=jpMMurK2r5aGrIEqqTp26B7FiPZGYquqiydq85QQvEY=;
  b=Tla+vySPIXvfjWYQmNC5oOSBPLV2tdTpXQ57jH/n8RETj/doNIn057nN
   x5NTrisn5ExLdP2bLLQbb0lpmht2oqgOmSinwYntHQhlYNBvgv+LRtk2L
   DaowpLOS9OJfcat+jPRINU2VjR4bMLi/NXeMtylKW870nlDSOl/kzvQFC
   jjY8M/v5GH7KHY/DFrPVY1NiDejND1AmDZn1ArcmMtDEyFnA39X/qACHh
   bGWsDfIflFd2xkBIq1Mcf4gquV2Gfjw/dnHt6/iiLwPSozYvvKF75X3Nj
   og/vLqPZyWGF/25OTXEUapuTZUJhLN/LzYXgQi5EE7T+AI8pVZmFhYAOd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="289766167"
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="289766167"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 23:37:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="932773651"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 23:37:44 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 7/7] mm/swap: Cache swap migration A/D bits support
References: <20220809220100.20033-1-peterx@redhat.com>
        <20220809220100.20033-8-peterx@redhat.com>
Date:   Wed, 10 Aug 2022 14:37:40 +0800
In-Reply-To: <20220809220100.20033-8-peterx@redhat.com> (Peter Xu's message of
        "Tue, 9 Aug 2022 18:01:00 -0400")
Message-ID: <87tu6keh8r.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> Introduce a variable swap_migration_ad_supported to cache whether the arch
> supports swap migration A/D bits.
>
> Here one thing to mention is that SWP_MIG_TOTAL_BITS will internally
> reference the other macro MAX_PHYSMEM_BITS, which is a function call on
> x86 (constant on all the rest of archs).
>
> It's safe to reference it in swapfile_init() because when reaching here
> we're already during initcalls level 4 so we must have initialized 5-level
> pgtable for x86_64 (right after early_identify_cpu() finishes).
>
> - start_kernel
>   - setup_arch
>     - early_cpu_init
>       - get_cpu_cap --> fetch from CPUID (including X86_FEATURE_LA57)
>       - early_identify_cpu --> clear X86_FEATURE_LA57 (if early lvl5 not enabled (USE_EARLY_PGTABLE_L5))
>   - arch_call_rest_init
>     - rest_init
>       - kernel_init
>         - kernel_init_freeable
>           - do_basic_setup
>             - do_initcalls --> calls swapfile_init() (initcall level 4)
>
> This should slightly speed up the migration swap entry handlings.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/swapfile.h | 1 +
>  include/linux/swapops.h  | 7 +------
>  mm/swapfile.c            | 8 ++++++++
>  3 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/swapfile.h b/include/linux/swapfile.h
> index 54078542134c..87ec5e2cdb02 100644
> --- a/include/linux/swapfile.h
> +++ b/include/linux/swapfile.h
> @@ -9,5 +9,6 @@
>  extern struct swap_info_struct *swap_info[];
>  extern unsigned long generic_max_swapfile_size(void);
>  extern unsigned long max_swapfile_size(void);
> +extern bool swap_migration_ad_supported;
>  
>  #endif /* _LINUX_SWAPFILE_H */
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index 0e9579b90659..e6afc77c51ad 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -301,13 +301,8 @@ static inline swp_entry_t make_writable_migration_entry(pgoff_t offset)
>   */
>  static inline bool migration_entry_supports_ad(void)
>  {
> -	/*
> -	 * max_swapfile_size() returns the max supported swp-offset plus 1.
> -	 * We can support the migration A/D bits iff the pfn swap entry has
> -	 * the offset large enough to cover all of them (PFN, A & D bits).
> -	 */
>  #ifdef CONFIG_SWAP
> -	return max_swapfile_size() >= (1UL << SWP_MIG_TOTAL_BITS);
> +	return swap_migration_ad_supported;
>  #else  /* CONFIG_SWAP */
>  	return false;
>  #endif	/* CONFIG_SWAP */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 794fa37bd0c3..c49cf25f0d08 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -64,6 +64,9 @@ EXPORT_SYMBOL_GPL(nr_swap_pages);
>  long total_swap_pages;
>  static int least_priority = -1;
>  static unsigned long swapfile_maximum_size;
> +#ifdef CONFIG_MIGRATION
> +bool swap_migration_ad_supported;
> +#endif	/* CONFIG_MIGRATION */
>  
>  static const char Bad_file[] = "Bad swap file entry ";
>  static const char Unused_file[] = "Unused swap file entry ";
> @@ -3685,6 +3688,11 @@ static int __init swapfile_init(void)
>  
>  	swapfile_maximum_size = arch_max_swapfile_size();
>  
> +#ifdef CONFIG_MIGRATION
> +	if (swapfile_maximum_size >= (1UL << SWP_MIG_TOTAL_BITS))
> +		swap_migration_ad_supported = true;
> +#endif	/* CONFIG_MIGRATION */
> +
>  	return 0;
>  }
>  subsys_initcall(swapfile_init);

I don't think it's necessary to add a variable for such a simple
function and it's not a super hot path.  But I don't have strong
opinions here.

Best Regards,
Huang, Ying
