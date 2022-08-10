Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BC358E755
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 08:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiHJGdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 02:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiHJGdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 02:33:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3326E2CF
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 23:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660113188; x=1691649188;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=QIhNWhaFzPd7M69D/251lZz3jAISvGoccdRGMCoXT6o=;
  b=UZPi+eDL2EK8hr4siEBDDeIRykc1tqGFUDOuBZbJSnVbp2pNrqeIh2lJ
   zQ15eluFEd4/ojjsroNOCiywyTjWtAZMzrqF67uRzzcudmApmpEQ1rmTI
   DLOynHnG3UXSP6ZbzHpiovjmaCCz88iNtV29I3zzxRVqITYlgQFnL060R
   r3Wm6BvDP+RTz2kntjqYWyqwBautdov/rpbbmOlBI9ISy7SrPUH+kkUx3
   TQcjhcKJYbIue1qBPZfWhKsdJwQWp2FItACpH2bgEahEnwcWt2dhw9vw8
   rBQRBZQ6GWQkuxQcJjW23kEZo8zUdVHorWDIHTE60oimKi2mtjm5OwT8j
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="270785306"
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="270785306"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 23:33:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="932771834"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 23:33:05 -0700
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
Subject: Re: [PATCH v3 6/7] mm/swap: Cache maximum swapfile size when init swap
References: <20220809220100.20033-1-peterx@redhat.com>
        <20220809220100.20033-7-peterx@redhat.com>
Date:   Wed, 10 Aug 2022 14:33:02 +0800
In-Reply-To: <20220809220100.20033-7-peterx@redhat.com> (Peter Xu's message of
        "Tue, 9 Aug 2022 18:00:59 -0400")
Message-ID: <87y1vwehgh.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
> major arch to look after is x86, which defines the max size based on L1TF
> mitigation.
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
> "arch_" as its prefix.  At the meantime, keep the swapfile_maximum_size()
> function to fetch the value from the cache initialized in swapfile_init().
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/x86/mm/init.c |  2 +-
>  mm/swapfile.c      | 10 +++++++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
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
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 1fdccd2f1422..794fa37bd0c3 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -63,6 +63,7 @@ EXPORT_SYMBOL_GPL(nr_swap_pages);
>  /* protected with swap_lock. reading in vm_swap_full() doesn't need lock */
>  long total_swap_pages;
>  static int least_priority = -1;
> +static unsigned long swapfile_maximum_size;
>  
>  static const char Bad_file[] = "Bad swap file entry ";
>  static const char Unused_file[] = "Unused swap file entry ";
> @@ -2816,11 +2817,16 @@ unsigned long generic_max_swapfile_size(void)
>  }
>  
>  /* Can be overridden by an architecture for additional checks. */
> -__weak unsigned long max_swapfile_size(void)
> +__weak unsigned long arch_max_swapfile_size(void)
>  {
>  	return generic_max_swapfile_size();
>  }
>  
> +unsigned long max_swapfile_size(void)
> +{
> +	return swapfile_maximum_size;
> +}
> +

It appears unnecessary to hide a variable with a function.  Why not just
use the variable directly.

Best Regards,
Huang, Ying

>  static unsigned long read_swap_header(struct swap_info_struct *p,
>  					union swap_header *swap_header,
>  					struct inode *inode)
> @@ -3677,6 +3683,8 @@ static int __init swapfile_init(void)
>  	for_each_node(nid)
>  		plist_head_init(&swap_avail_heads[nid]);
>  
> +	swapfile_maximum_size = arch_max_swapfile_size();
> +
>  	return 0;
>  }
>  subsys_initcall(swapfile_init);
