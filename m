Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE824CB13D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245250AbiCBV0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbiCBV0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:26:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12BBBECE7;
        Wed,  2 Mar 2022 13:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lVF6m9QgZUAbOU/dXdGrVqsI+ZX3uNFQUVqEhiINOzw=; b=FZp4wIVLOfMGHVp9iDtJ2OT31l
        Oab4IOVWSCP+7godZvjIarWYkI3Esxn1Q7pNYAkEWk+tNQmpoHaUXZ9NNdAL0+vXN7JNzCpz0Asu0
        FVmJ5PzKyAg2XDlQIOlzvWwZLsfpMwhTqbYcTnx6h0/v9ACVnvBbMorjmMYWzz3xVYfSwQP+vAurD
        Ncegd6WOpALK14VFITyDKZ49XxDT5THrPkR35tTWT0gqTqZTXQm9YcC4joB6bBtDNt+6H+3O/d35k
        XXUCxQvxJNqKC/zFEha6pvzFrvJt+SoKBp1OLDuO1EsknCnVzaFwMUOJh3O6JmAcosjo4kok26CVL
        R7gi7ZrQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPWTg-004IP1-He; Wed, 02 Mar 2022 21:25:44 +0000
Date:   Wed, 2 Mar 2022 13:25:44 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        keescook@chromium.org, yzaikin@google.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Adam Manzanares <a.manzanares@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v2 3/3] mm: hugetlb: add hugetlb_free_vmemmap sysctl
Message-ID: <Yh/g2BRPZC3370mX@bombadil.infradead.org>
References: <20220302083758.32528-1-songmuchun@bytedance.com>
 <20220302083758.32528-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302083758.32528-4-songmuchun@bytedance.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 04:37:58PM +0800, Muchun Song wrote:
> We must add "hugetlb_free_vmemmap=on" to boot cmdline and reboot the
> server to enable the feature of freeing vmemmap pages of HugeTLB
> pages. Rebooting usually taske a long time. Add a sysctl to enable
> the feature at runtime and do not need to reboot.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  Documentation/admin-guide/sysctl/vm.rst | 13 ++++++++++
>  include/linux/memory_hotplug.h          |  9 +++++++
>  mm/hugetlb_vmemmap.c                    | 42 ++++++++++++++++++++++++++++-----
>  mm/hugetlb_vmemmap.h                    |  4 +++-
>  mm/memory_hotplug.c                     |  5 ++++
>  5 files changed, 66 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index f4804ce37c58..01f18e6cc227 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -561,6 +561,19 @@ Change the minimum size of the hugepage pool.
>  See Documentation/admin-guide/mm/hugetlbpage.rst
>  
>  
> +hugetlb_free_vmemmap
> +====================
> +
> +A toggle value indicating if vmemmap pages are allowed to be optimized.
> +If it is off (0), then it can be set true (1).  Once true, the vmemmap
> +pages associated with each HugeTLB page will be optimized, and the toggle
> +cannot be set back to false.  It only optimizes the subsequent allocation
> +of HugeTLB pages from buddy system, while already allocated HugeTLB pages
> +will not be optimized.

The commit log or documentation does not descrie why its safe to toggle
one way and not the other?

  Luis

> +
> +See Documentation/admin-guide/mm/hugetlbpage.rst
> +
> +
>  nr_hugepages_mempolicy
>  ======================
>  
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index e0b2209ab71c..20d7edf62a6a 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -351,4 +351,13 @@ void arch_remove_linear_mapping(u64 start, u64 size);
>  extern bool mhp_supports_memmap_on_memory(unsigned long size);
>  #endif /* CONFIG_MEMORY_HOTPLUG */
>  
> +#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
> +bool mhp_memmap_on_memory(void);
> +#else
> +static inline bool mhp_memmap_on_memory(void)
> +{
> +	return false;
> +}
> +#endif
> +
>  #endif /* __LINUX_MEMORY_HOTPLUG_H */
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 836d1117f08b..3bcc8f25bd50 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -10,6 +10,7 @@
>  
>  #define pr_fmt(fmt)	"HugeTLB: " fmt
>  
> +#include <linux/memory_hotplug.h>
>  #include "hugetlb_vmemmap.h"
>  
>  /*
> @@ -118,17 +119,14 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>  	BUILD_BUG_ON(__NR_USED_SUBPAGE >=
>  		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
>  
> -	if (!hugetlb_free_vmemmap_enabled())
> -		return;
> -
> -	if (IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON) &&
> -	    !is_power_of_2(sizeof(struct page))) {
> +	if (!is_power_of_2(sizeof(struct page))) {
>  		/*
>  		 * The hugetlb_free_vmemmap_enabled_key can be enabled when
>  		 * CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON. It should
>  		 * be disabled if "struct page" crosses page boundaries.
>  		 */
> -		static_branch_disable(&hugetlb_free_vmemmap_enabled_key);
> +		if (IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON))
> +			static_branch_disable(&hugetlb_free_vmemmap_enabled_key);
>  		return;
>  	}
>  
> @@ -147,3 +145,35 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>  	pr_info("can free %d vmemmap pages for %s\n", h->nr_free_vmemmap_pages,
>  		h->name);
>  }
> +
> +static struct ctl_table hugetlb_vmemmap_sysctls[] = {
> +	{
> +		.procname	= "hugetlb_free_vmemmap",
> +		.data		= &hugetlb_free_vmemmap_enabled_key.key,
> +		.mode		= 0644,
> +		/* only handle a transition from default "0" to "1" */
> +		.proc_handler	= proc_do_static_key,
> +		.extra1		= SYSCTL_ONE,
> +		.extra2		= SYSCTL_ONE,
> +	},
> +	{ }
> +};
> +
> +static __init int hugetlb_vmemmap_sysctls_init(void)
> +{
> +	/*
> +	 * The vmemmap pages cannot be optimized if
> +	 * "memory_hotplug.memmap_on_memory" is enabled unless
> +	 * "hugetlb_free_vmemmap" is enabled as well since
> +	 * "hugetlb_free_vmemmap" takes precedence over
> +	 * "memory_hotplug.memmap_on_memory".
> +	 */
> +	if (mhp_memmap_on_memory() && !hugetlb_free_vmemmap_enabled())
> +		return 0;
> +
> +	if (is_power_of_2(sizeof(struct page)))
> +		register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
> +
> +	return 0;
> +}
> +late_initcall(hugetlb_vmemmap_sysctls_init);
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index cb2bef8f9e73..b67a159027f4 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -21,7 +21,9 @@ void hugetlb_vmemmap_init(struct hstate *h);
>   */
>  static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
>  {
> -	return h->nr_free_vmemmap_pages;
> +	if (hugetlb_free_vmemmap_enabled())
> +		return h->nr_free_vmemmap_pages;
> +	return 0;
>  }
>  #else
>  static inline int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index c226a337c1ef..c2115e566abc 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -50,6 +50,11 @@ static bool memmap_on_memory __ro_after_init;
>  #ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
>  module_param(memmap_on_memory, bool, 0444);
>  MODULE_PARM_DESC(memmap_on_memory, "Enable memmap on memory for memory hotplug");
> +
> +bool mhp_memmap_on_memory(void)
> +{
> +	return memmap_on_memory;
> +}
>  #endif
>  
>  enum {
> -- 
> 2.11.0
> 
