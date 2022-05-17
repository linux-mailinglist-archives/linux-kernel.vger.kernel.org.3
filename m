Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81681529BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbiEQIHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbiEQIG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:06:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7C03A1B9;
        Tue, 17 May 2022 01:06:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 560B6220EA;
        Tue, 17 May 2022 08:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652774814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5F+aPyH3Gd8cJunxSwAhNocJOxxfM5+XN2unB6PBMpw=;
        b=J2ahlJDur7mj94MqXcrTXveWrdwUxnp9IpuioHjzGOAwggkJMbu4Z1gEna/6kZ+tpeAfeL
        G5K2am0TDt8Ke1WouOZ67PWQNeoRxH7o9Ip4MZAbahCqru2ISrO+JLz/DAebNiGCNdQsv4
        C6XSlYjBdw+M0lB9h8baHw+ajekvup0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652774814;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5F+aPyH3Gd8cJunxSwAhNocJOxxfM5+XN2unB6PBMpw=;
        b=kXXh7rwpYziBdC4r17l/rnn64bs7NUowGKuwMCl96t8ZFzPuztFPR9kifKLrp92eAxJc0U
        lm15Us7noaH6tkDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8BAD13305;
        Tue, 17 May 2022 08:06:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nRurNJxXg2KLCQAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 17 May 2022 08:06:52 +0000
Date:   Tue, 17 May 2022 10:06:51 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v12 7/7] mm: hugetlb_vmemmap: add
 hugetlb_optimize_vmemmap sysctl
Message-ID: <YoNXm2c5fJq8luqf@localhost.localdomain>
References: <20220516102211.41557-1-songmuchun@bytedance.com>
 <20220516102211.41557-8-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516102211.41557-8-songmuchun@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 06:22:11PM +0800, Muchun Song wrote:
> We must add hugetlb_free_vmemmap=on (or "off") to the boot cmdline and
> reboot the server to enable or disable the feature of optimizing vmemmap
> pages associated with HugeTLB pages.  However, rebooting usually takes a
> long time.  So add a sysctl to enable or disable the feature at runtime
> without rebooting.  Why we need this?  There are 3 use cases.
> 
> 1) The feature of minimizing overhead of struct page associated with each
> HugeTLB is disabled by default without passing "hugetlb_free_vmemmap=on"
> to the boot cmdline. When we (ByteDance) deliver the servers to the
> users who want to enable this feature, they have to configure the grub
> (change boot cmdline) and reboot the servers, whereas rebooting usually
> takes a long time (we have thousands of servers).  It's a very bad
> experience for the users.  So we need a approach to enable this feature
> after rebooting. This is a use case in our practical environment.
> 
> 2) Some use cases are that HugeTLB pages are allocated 'on the fly'
> instead of being pulled from the HugeTLB pool, those workloads would be
> affected with this feature enabled.  Those workloads could be identified
> by the characteristics of they never explicitly allocating huge pages
> with 'nr_hugepages' but only set 'nr_overcommit_hugepages' and then let
> the pages be allocated from the buddy allocator at fault time.  We can
> confirm it is a real use case from the commit 099730d67417.  For those
> workloads, the page fault time could be ~2x slower than before. We
> suspect those users want to disable this feature if the system has enabled
> this before and they don't think the memory savings benefit is enough to
> make up for the performance drop.
> 
> 3) If the workload which wants vmemmap pages to be optimized and the
> workload which wants to set 'nr_overcommit_hugepages' and does not want
> the extera overhead at fault time when the overcommitted pages be
> allocated from the buddy allocator are deployed in the same server.
> The user could enable this feature and set 'nr_hugepages' and
> 'nr_overcommit_hugepages', then disable the feature.  In this case,
> the overcommited HugeTLB pages will not encounter the extra overhead
> at fault time.

I am having issues parsing point 3), specially the first part.
IIUC, you are saying we have two kind of different workloads:

- one that wants to have hugetlb vmemmap pages optimized
- one that wants to allocate hugetlb pages at fault time rather than
  allocating them via /proc/..., but does not want to suffer the
  overhead of optimizing the vmemmap pages when faulting them

Then you say the user could enable the optimization and allocate
those pages via nr_hugepages, and then disable the feature.
So, when we fault in those pages, the pages are already in the
pool, right? And are already optimized.

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  Documentation/admin-guide/sysctl/vm.rst | 38 ++++++++++++++++++++
>  include/linux/page-flags.h              |  6 ++--
>  mm/hugetlb_vmemmap.c                    | 61 ++++++++++++++++++++++-----------
>  3 files changed, 81 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index 747e325ebcd0..d7374a1e8ac9 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -562,6 +562,44 @@ Change the minimum size of the hugepage pool.
>  See Documentation/admin-guide/mm/hugetlbpage.rst
>  
>  
> +hugetlb_optimize_vmemmap
> +========================
> +
> +This knob is not available when the size of 'struct page' (a structure defined
> +in include/linux/mm_types.h) is not power of two (an unusual system config could
> +result in this).
> +
> +Enable (set to 1) or disable (set to 0) the feature of optimizing vmemmap pages
> +associated with each HugeTLB page.
> +
> +Once enabled, the vmemmap pages of subsequent allocation of HugeTLB pages from
> +buddy allocator will be optimized (7 pages per 2MB HugeTLB page and 4095 pages
> +per 1GB HugeTLB page), whereas already allocated HugeTLB pages will not be
> +optimized.  When those optimized HugeTLB pages are freed from the HugeTLB pool
> +to the buddy allocator, the vmemmap pages representing that range needs to be
> +remapped again and the vmemmap pages discarded earlier need to be rellocated
> +again.  If your use case is that HugeTLB pages are allocated 'on the fly' (e.g.
> +never explicitly allocating HugeTLB pages with 'nr_hugepages' but only set
> +'nr_overcommit_hugepages', those overcommitted HugeTLB pages are allocated 'on
> +the fly') instead of being pulled from the HugeTLB pool, you should weigh the
> +benefits of memory savings against the more overhead (~2x slower than before)
> +of allocation or freeing HugeTLB pages between the HugeTLB pool and the buddy
> +allocator.  Another behavior to note is that if the system is under heavy memory
> +pressure, it could prevent the user from freeing HugeTLB pages from the HugeTLB
> +pool to the buddy allocator since the allocation of vmemmap pages could be
> +failed, you have to retry later if your system encounter this situation.
> +
> +Once disabled, the vmemmap pages of subsequent allocation of HugeTLB pages from
> +buddy allocator will not be optimized meaning the extra overhead at allocation
> +time from buddy allocator disappears, whereas already optimized HugeTLB pages
> +will not be affected.  If you want to make sure there are no optimized HugeTLB
> +pages, you can set "nr_hugepages" to 0 first and then disable this.  Note that
> +writing 0 to nr_hugepages will make any "in use" HugeTLB pages become surplus
> +pages.  So, those surplus pages are still optimized until they are no longer
> +in use.  You would need to wait for those surplus pages to be released before
> +there are no optimized pages in the system.
> +
> +
>  nr_hugepages_mempolicy
>  ======================
>  
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 404f4ede17f5..07d8d444d9f1 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -200,8 +200,7 @@ enum pageflags {
>  #ifndef __GENERATING_BOUNDS_H
>  
>  #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> -DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
> -			 hugetlb_optimize_vmemmap_key);
> +DECLARE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
>  
>  /*
>   * If the feature of optimizing vmemmap pages associated with each HugeTLB
> @@ -221,8 +220,7 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
>   */
>  static __always_inline const struct page *page_fixed_fake_head(const struct page *page)
>  {
> -	if (!static_branch_maybe(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
> -				 &hugetlb_optimize_vmemmap_key))
> +	if (!static_branch_unlikely(&hugetlb_optimize_vmemmap_key))
>  		return page;
>  
>  	/*
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index d1fea65fec98..02862f117c2b 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -22,23 +22,15 @@
>  #define RESERVE_VMEMMAP_NR		1U
>  #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
>  
> -DEFINE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
> -			hugetlb_optimize_vmemmap_key);
> +DEFINE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
>  EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
>  
> +static bool optimize_vmemmap_enabled =
> +	IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON);
> +
>  static int __init hugetlb_vmemmap_early_param(char *buf)
>  {
> -	bool enable;
> -
> -	if (kstrtobool(buf, &enable))
> -		return -EINVAL;
> -
> -	if (enable)
> -		static_branch_enable(&hugetlb_optimize_vmemmap_key);
> -	else
> -		static_branch_disable(&hugetlb_optimize_vmemmap_key);
> -
> -	return 0;
> +	return kstrtobool(buf, &optimize_vmemmap_enabled);
>  }
>  early_param("hugetlb_free_vmemmap", hugetlb_vmemmap_early_param);
>  
> @@ -69,8 +61,10 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
>  	 */
>  	ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
>  				  GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
> -	if (!ret)
> +	if (!ret) {
>  		ClearHPageVmemmapOptimized(head);
> +		static_branch_dec(&hugetlb_optimize_vmemmap_key);
> +	}
>  
>  	return ret;
>  }
> @@ -81,6 +75,9 @@ static unsigned int optimizable_vmemmap_pages(struct hstate *h,
>  	unsigned long pfn = page_to_pfn(head);
>  	unsigned long end = pfn + pages_per_huge_page(h);
>  
> +	if (!READ_ONCE(optimize_vmemmap_enabled))
> +		return 0;
> +
>  	for (; pfn < end; pfn += PAGES_PER_SECTION) {
>  		if (section_cannot_optimize_vmemmap(__pfn_to_section(pfn)))
>  			return 0;
> @@ -98,6 +95,8 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
>  	if (!vmemmap_pages)
>  		return;
>  
> +	static_branch_inc(&hugetlb_optimize_vmemmap_key);
> +
>  	vmemmap_addr	+= RESERVE_VMEMMAP_SIZE;
>  	vmemmap_end	= vmemmap_addr + (vmemmap_pages << PAGE_SHIFT);
>  	vmemmap_reuse	= vmemmap_addr - PAGE_SIZE;
> @@ -107,7 +106,9 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
>  	 * to the page which @vmemmap_reuse is mapped to, then free the pages
>  	 * which the range [@vmemmap_addr, @vmemmap_end] is mapped to.
>  	 */
> -	if (!vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse))
> +	if (vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse))
> +		static_branch_dec(&hugetlb_optimize_vmemmap_key);
> +	else
>  		SetHPageVmemmapOptimized(head);
>  }
>  
> @@ -124,13 +125,8 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>  	BUILD_BUG_ON(__NR_USED_SUBPAGE >=
>  		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
>  
> -	if (!static_branch_maybe(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
> -				 &hugetlb_optimize_vmemmap_key))
> -		return;
> -
>  	if (!is_power_of_2(sizeof(struct page))) {
>  		pr_warn_once("cannot optimize vmemmap pages because \"struct page\" crosses page boundaries\n");
> -		static_branch_disable(&hugetlb_optimize_vmemmap_key);
>  		return;
>  	}
>  
> @@ -149,3 +145,28 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>  	pr_info("can optimize %d vmemmap pages for %s\n",
>  		h->optimize_vmemmap_pages, h->name);
>  }
> +
> +#ifdef CONFIG_PROC_SYSCTL
> +static struct ctl_table hugetlb_vmemmap_sysctls[] = {
> +	{
> +		.procname	= "hugetlb_optimize_vmemmap",
> +		.data		= &optimize_vmemmap_enabled,
> +		.maxlen		= sizeof(optimize_vmemmap_enabled),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dobool,
> +	},
> +	{ }
> +};
> +
> +static int __init hugetlb_vmemmap_sysctls_init(void)
> +{
> +	/*
> +	 * If "struct page" crosses page boundaries, the vmemmap pages cannot
> +	 * be optimized.
> +	 */
> +	if (is_power_of_2(sizeof(struct page)))
> +		register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
> +	return 0;
> +}
> +late_initcall(hugetlb_vmemmap_sysctls_init);
> +#endif /* CONFIG_PROC_SYSCTL */
> -- 
> 2.11.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
