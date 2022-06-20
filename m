Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECB7551EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243913AbiFTOUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350608AbiFTOSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:18:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F326455;
        Mon, 20 Jun 2022 06:33:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0998F1F9DB;
        Mon, 20 Jun 2022 13:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655731176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rKZZMpkhatWAwsf4c5mQXHZM6KStBRfdpbKIoOzCjNo=;
        b=XUGGVD06djaqIk0wf2BqotBUNOdYGy3zLVs480Zb5gxOSoCYeWs96BM8sBnoYC3Lumcxef
        FRMLO0iS10W7pzm035bWr8qA15R2So00DdpPC9vNtcFsKHVd3d9Klm4fSQWy80fNhNvx4a
        yDhr9az7W/2329yZ+bfccf6GFKyJXX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655731176;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rKZZMpkhatWAwsf4c5mQXHZM6KStBRfdpbKIoOzCjNo=;
        b=UsuD+8zEjzbab09OqIpifsvUIMlX7T4enyXE00gR71/1P9juGvQ8M+rMdNqEVg3M15C8Ra
        J8S2OmNMI+7BcoAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FB7E13638;
        Mon, 20 Jun 2022 13:19:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f8GjFOdzsGJ6OwAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 20 Jun 2022 13:19:35 +0000
Date:   Mon, 20 Jun 2022 15:19:33 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, corbet@lwn.net, david@redhat.com,
        mike.kravetz@oracle.com, paulmck@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v5 2/2] mm: memory_hotplug: make hugetlb_optimize_vmemmap
 compatible with memmap_on_memory
Message-ID: <YrBz5dBpb3XTZm5c@localhost.localdomain>
References: <20220620110616.12056-1-songmuchun@bytedance.com>
 <20220620110616.12056-3-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620110616.12056-3-songmuchun@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 07:06:16PM +0800, Muchun Song wrote:
> +		/*
> +		 * The READ_ONCE() is used to stabilize *pmdp in a register or
> +		 * on the stack so that it will stop changing under the code.
> +		 * The only concurrent operation where it can be changed is
> +		 * split_vmemmap_huge_pmd() (*pmdp will be stable after this
> +		 * operation).
> +		 */
> +		pmd = READ_ONCE(*pmdp);
> +		if (pmd_leaf(pmd))
> +			vmemmap_page = pmd_page(pmd) + pte_index(vaddr);
> +		else
> +			vmemmap_page = pte_page(*pte_offset_kernel(pmdp, vaddr));

I was about to suggest to get rid of the else branch because on x86_64
we can only allocate PMD_SIZE chunks when using an alternative allocator,
meaning that anything which is not a pmd_leaf can't be a PageVmemmapSelfHosted.

But then I went to check the other platform that supports memmap_on_memory (arm64),
and in there I can see that we fallback to populate basepages with altmap should
we fail to allocate a PMD_SIZE chunk.



> +		/*
> +		 * Due to HugeTLB alignment requirements and the vmemmap pages
> +		 * being at the start of the hotplugged memory region in
> +		 * memory_hotplug.memmap_on_memory case. Checking any vmemmap
> +		 * page's vmemmap page if it is marked as VmemmapSelfHosted is
> +		 * sufficient.
> +		 *
> +		 * [                  hotplugged memory                  ]
> +		 * [        section        ][...][        section        ]
> +		 * [ vmemmap ][              usable memory               ]
> +		 *   ^   |     |                                        |
> +		 *   +---+     |                                        |
> +		 *     ^       |                                        |
> +		 *     +-------+                                        |
> +		 *          ^                                           |
> +		 *          +-------------------------------------------+
> +		 */
> +		if (PageVmemmapSelfHosted(vmemmap_page))
> +			return 0;
> +	}
> +
> +	return hugetlb_optimize_vmemmap_pages(h);
> +}
> +
>  void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
>  {
>  	unsigned long vmemmap_addr = (unsigned long)head;
>  	unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;
>  
> -	vmemmap_pages = hugetlb_optimize_vmemmap_pages(h);
> +	vmemmap_pages = vmemmap_optimizable_pages(h, head);
>  	if (!vmemmap_pages)
>  		return;
>  
> -	if (READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
> -		return;
> -
>  	static_branch_inc(&hugetlb_optimize_vmemmap_key);
>  
>  	vmemmap_addr	+= RESERVE_VMEMMAP_SIZE;
> @@ -199,10 +249,10 @@ static struct ctl_table hugetlb_vmemmap_sysctls[] = {
>  static __init int hugetlb_vmemmap_sysctls_init(void)
>  {
>  	/*
> -	 * If "memory_hotplug.memmap_on_memory" is enabled or "struct page"
> -	 * crosses page boundaries, the vmemmap pages cannot be optimized.
> +	 * If "struct page" crosses page boundaries, the vmemmap pages cannot
> +	 * be optimized.
>  	 */
> -	if (!mhp_memmap_on_memory() && is_power_of_2(sizeof(struct page)))
> +	if (is_power_of_2(sizeof(struct page)))
>  		register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
>  
>  	return 0;
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 6662b86e9e64..3a59d4e97c03 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -43,30 +43,22 @@
>  #include "shuffle.h"
>  
>  #ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
> -static int memmap_on_memory_set(const char *val, const struct kernel_param *kp)
> -{
> -	if (hugetlb_optimize_vmemmap_enabled())
> -		return 0;
> -	return param_set_bool(val, kp);
> -}
> -
> -static const struct kernel_param_ops memmap_on_memory_ops = {
> -	.flags	= KERNEL_PARAM_OPS_FL_NOARG,
> -	.set	= memmap_on_memory_set,
> -	.get	= param_get_bool,
> -};
> -
>  /*
>   * memory_hotplug.memmap_on_memory parameter
>   */
>  static bool memmap_on_memory __ro_after_init;
> -module_param_cb(memmap_on_memory, &memmap_on_memory_ops, &memmap_on_memory, 0444);
> +module_param(memmap_on_memory, bool, 0444);
>  MODULE_PARM_DESC(memmap_on_memory, "Enable memmap on memory for memory hotplug");
>  
> -bool mhp_memmap_on_memory(void)
> +static inline bool mhp_memmap_on_memory(void)
>  {
>  	return memmap_on_memory;
>  }
> +#else
> +static inline bool mhp_memmap_on_memory(void)
> +{
> +	return false;
> +}
>  #endif
>  
>  enum {
> @@ -1035,7 +1027,7 @@ int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
>  			      struct zone *zone)
>  {
>  	unsigned long end_pfn = pfn + nr_pages;
> -	int ret;
> +	int ret, i;
>  
>  	ret = kasan_add_zero_shadow(__va(PFN_PHYS(pfn)), PFN_PHYS(nr_pages));
>  	if (ret)
> @@ -1043,6 +1035,9 @@ int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
>  
>  	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_UNMOVABLE);
>  
> +	for (i = 0; i < nr_pages; i++)
> +		SetPageVmemmapSelfHosted(pfn_to_page(pfn + i));
> +
>  	/*
>  	 * It might be that the vmemmap_pages fully span sections. If that is
>  	 * the case, mark those sections online here as otherwise they will be
> -- 
> 2.11.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
