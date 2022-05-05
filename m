Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3D251B602
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239651AbiEECjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239426AbiEECjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:39:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A273DDD8
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:36:01 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w5-20020a17090aaf8500b001d74c754128so6814986pjq.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 19:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vfI9dRRrbRWZEeFgPNImhpqkxo6j6rN6qd6JDTcnQxw=;
        b=Ha469BA+EztXs1J5u+pIVSs9eibLGz9Cmo3ynM9BCj+IvH/ogfVI5HiaZYE6en2nvj
         WTAUcGDra+crky6JsFdF693+Ef8DC0OXTDEBkRjFLd5sYWq1yHOlxugnagLhfcv077BF
         l0YKa3jrch2i4MEGHCrQAeIetCXo93xRSF3YdvD3dG1pdBH2707IiA1UPL73kwrKPK/H
         qwpihjYhgqoNAOaFBLDzteJKxuoD8bRelG7Dpb3dIZVT2/jc+6Hlu4d2jy7gWb8FZBax
         jDmiqHRVtuYtIj1lR1bJJemgu60ttLw9WmZymLxKMK6xkIOKB8qvkYeFezmuJ5P8broo
         P8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vfI9dRRrbRWZEeFgPNImhpqkxo6j6rN6qd6JDTcnQxw=;
        b=oTIRCXvQrYGLu9SNn5Brg5/EhWiFtkvKLSBkXBeYa6zt9zWkye7Ii3VcLLEc9/5Qlv
         C4KCsmDgOq7FXeNO13opXIrKu3Y8gsDz37ew1NSqO6ZzeHAp/nzEUNFPoHAXvjvwrV9k
         X8T6KIdCAbI9fkYqK/Gb1bNKdak8opuyIUd/Y0j4hDZ3VgrCr0egIlSqhApJguDugA43
         KsDgHAnwXKNTa/e6PYXs2nXVb689t8TTyKPeBYvvddBeqb8FXjuVKMNHaPZ89nABunMf
         aisxgLE/FQW8n1z3619UDq+waKO1LxTiI85q1HuuJ379vGngMtQE14W+Er6iLqYO1jLo
         5YfA==
X-Gm-Message-State: AOAM531XR4GTtb0+/3NMGoGeyAjcfSBvNSpQxt7ijPLY71o9eV8j90cv
        dB7oy4Z3nH5K+Xvte1OCq7sqFA==
X-Google-Smtp-Source: ABdhPJx2E2xMRskXq0h26rr/xhvddkVY2w5PvONji5NxAbW+D8aGP8lPvgzDzp8vCw+ivYJmTaJNDw==
X-Received: by 2002:a17:90b:3ec7:b0:1dc:b008:3cd3 with SMTP id rm7-20020a17090b3ec700b001dcb0083cd3mr3325056pjb.226.1651718160754;
        Wed, 04 May 2022 19:36:00 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902edc500b0015e8d4eb2cfsm177398plk.281.2022.05.04.19.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 19:36:00 -0700 (PDT)
Date:   Thu, 5 May 2022 10:35:57 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v9 4/4] mm: hugetlb_vmemmap: add hugetlb_optimize_vmemmap
 sysctl
Message-ID: <YnM4DRFhdD6iZIs1@FVFYT0MHHV2J.googleapis.com>
References: <20220429121816.37541-1-songmuchun@bytedance.com>
 <20220429121816.37541-5-songmuchun@bytedance.com>
 <eadec7de-2e1a-2fb3-3317-c7b492a84e2b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eadec7de-2e1a-2fb3-3317-c7b492a84e2b@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 03:12:39PM -0700, Mike Kravetz wrote:
> On 4/29/22 05:18, Muchun Song wrote:
> > We must add hugetlb_free_vmemmap=on (or "off") to the boot cmdline and
> > reboot the server to enable or disable the feature of optimizing vmemmap
> > pages associated with HugeTLB pages.  However, rebooting usually takes a
> > long time.  So add a sysctl to enable or disable the feature at runtime
> > without rebooting.  Why we need this?  There are 3 use cases.
> > 
> > 1) The feature of minimizing overhead of struct page associated with each
> > HugeTLB is disabled by default without passing "hugetlb_free_vmemmap=on"
> > to the boot cmdline. When we (ByteDance) deliver the servers to the
> > users who want to enable this feature, they have to configure the grub
> > (change boot cmdline) and reboot the servers, whereas rebooting usually
> > takes a long time (we have thousands of servers).  It's a very bad
> > experience for the users.  So we need a approach to enable this feature
> > after rebooting. This is a use case in our practical environment.
> > 
> > 2) Some use cases are that HugeTLB pages are allocated 'on the fly'
> > instead of being pulled from the HugeTLB pool, those workloads would be
> > affected with this feature enabled.  Those workloads could be identified
> > by the characteristics of they never explicitly allocating huge pages
> > with 'nr_hugepages' but only set 'nr_overcommit_hugepages' and then let
> > the pages be allocated from the buddy allocator at fault time.  We can
> > confirm it is a real use case from the commit 099730d67417.  For those
> > workloads, the page fault time could be ~2x slower than before. We
> > suspect those users want to disable this feature if the system has enabled
> > this before and they don't think the memory savings benefit is enough to
> > make up for the performance drop.
> > 
> > 3) If the workload which wants vmemmap pages to be optimized and the
> > workload which wants to set 'nr_overcommit_hugepages' and does not want
> > the extera overhead at fault time when the overcommitted pages be
> > allocated from the buddy allocator are deployed in the same server.
> > The user could enable this feature and set 'nr_hugepages' and
> > 'nr_overcommit_hugepages', then disable the feature.  In this case,
> > the overcommited HugeTLB pages will not encounter the extra overhead
> > at fault time.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  Documentation/admin-guide/sysctl/vm.rst | 30 +++++++++++
> >  include/linux/memory_hotplug.h          |  9 ++++
> >  mm/hugetlb_vmemmap.c                    | 92 +++++++++++++++++++++++++++++----
> >  mm/hugetlb_vmemmap.h                    |  4 +-
> >  mm/memory_hotplug.c                     |  7 +--
> >  5 files changed, 126 insertions(+), 16 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> > index 747e325ebcd0..00434789cf26 100644
> > --- a/Documentation/admin-guide/sysctl/vm.rst
> > +++ b/Documentation/admin-guide/sysctl/vm.rst
> > @@ -562,6 +562,36 @@ Change the minimum size of the hugepage pool.
> >  See Documentation/admin-guide/mm/hugetlbpage.rst
> >  
> >  
> > +hugetlb_optimize_vmemmap
> > +========================
> > +
> > +Enable (set to 1) or disable (set to 0) the feature of optimizing vmemmap pages
> > +associated with each HugeTLB page.
> 
> Should we mention that "memory_hotplug.memmap_on_memory" or an unusual system
> config that results in struct page not being a power of 2 will prevent
> enabling?
>

Good question. I think maybe it is better to clarify that this knob exists when
memory_hotplug.memmap_on_memory (kernel parameter) is disabled and the size of
"struct page" must be power of 2 (an unusual system config that could results
in this).
 
> > +
> > +Once enabled, the vmemmap pages of subsequent allocation of HugeTLB pages from
> > +buddy allocator will be optimized (7 pages per 2MB HugeTLB page and 4095 pages
> > +per 1GB HugeTLB page), whereas already allocated HugeTLB pages will not be
> > +optimized.  When those optimized HugeTLB pages are freed from the HugeTLB pool
> > +to the buddy allocator, the vmemmap pages representing that range needs to be
> > +remapped again and the vmemmap pages discarded earlier need to be rellocated
> > +again.  If your use case is that HugeTLB pages are allocated 'on the fly' (e.g.
> > +never explicitly allocating HugeTLB pages with 'nr_hugepages' but only set
> > +'nr_overcommit_hugepages', those overcommitted HugeTLB pages are allocated 'on
> > +the fly') instead of being pulled from the HugeTLB pool, you should weigh the
> > +benefits of memory savings against the more overhead (~2x slower than before)
> > +of allocation or freeing HugeTLB pages between the HugeTLB pool and the buddy
> > +allocator.  Another behavior to note is that if the system is under heavy memory
> > +pressure, it could prevent the user from freeing HugeTLB pages from the HugeTLB
> > +pool to the buddy allocator since the allocation of vmemmap pages could be
> > +failed, you have to retry later if your system encounter this situation.
> > +
> > +Once disabled, the vmemmap pages of subsequent allocation of HugeTLB pages from
> > +buddy allocator will not be optimized meaning the extra overhead at allocation
> > +time from buddy allocator disappears, whereas already optimized HugeTLB pages
> > +will not be affected.  If you want to make sure there is no optimized HugeTLB
> > +pages, you can set "nr_hugepages" to 0 first and then disable this.
> 
> Thank you for adding this documentation.
> 
> We may want to clarify that last statement about making sure there are no
> optimized HugeTLB pages.  Writing 0 to nr_hugepages will make any "in use"
> HugeTLB pages become surplus pages.  So, those surplus pages are still
> optimized until they are no longer in use.  You would need to wait for
> those surplus pages to be released before there are no optimized pages in
> the system.
>

I didn't realize this, I'll add this into documentation, Thanks.
 
> > +
> > +
> >  nr_hugepages_mempolicy
> >  ======================
> >  
> > diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> > index 029fb7e26504..917112661b5c 100644
> > --- a/include/linux/memory_hotplug.h
> > +++ b/include/linux/memory_hotplug.h
> > @@ -351,4 +351,13 @@ void arch_remove_linear_mapping(u64 start, u64 size);
> >  extern bool mhp_supports_memmap_on_memory(unsigned long size);
> >  #endif /* CONFIG_MEMORY_HOTPLUG */
> >  
> > +#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
> > +bool mhp_memmap_on_memory(void);
> > +#else
> > +static inline bool mhp_memmap_on_memory(void)
> > +{
> > +	return false;
> > +}
> > +#endif
> > +
> >  #endif /* __LINUX_MEMORY_HOTPLUG_H */
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index cc4ec752ec16..5820a681a724 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -10,6 +10,7 @@
> >   */
> >  #define pr_fmt(fmt)	"HugeTLB: " fmt
> >  
> > +#include <linux/memory_hotplug.h>
> >  #include "hugetlb_vmemmap.h"
> >  
> >  /*
> > @@ -22,21 +23,40 @@
> >  #define RESERVE_VMEMMAP_NR		1U
> >  #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
> >  
> > +enum vmemmap_optimize_mode {
> > +	VMEMMAP_OPTIMIZE_OFF,
> > +	VMEMMAP_OPTIMIZE_ON,
> > +};
> > +
> >  DEFINE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
> >  			hugetlb_optimize_vmemmap_key);
> >  EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
> >  
> > +static enum vmemmap_optimize_mode vmemmap_optimize_mode =
> > +	IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON);
> > +
> > +static void vmemmap_optimize_mode_switch(enum vmemmap_optimize_mode to)
> > +{
> > +	if (vmemmap_optimize_mode == to)
> > +		return;
> > +
> > +	if (to == VMEMMAP_OPTIMIZE_OFF)
> > +		static_branch_dec(&hugetlb_optimize_vmemmap_key);
> > +	else
> > +		static_branch_inc(&hugetlb_optimize_vmemmap_key);
> > +	vmemmap_optimize_mode = to;
> > +}
> > +
> >  static int __init hugetlb_vmemmap_early_param(char *buf)
> >  {
> >  	bool enable;
> > +	enum vmemmap_optimize_mode mode;
> >  
> >  	if (kstrtobool(buf, &enable))
> >  		return -EINVAL;
> >  
> > -	if (enable)
> > -		static_branch_enable(&hugetlb_optimize_vmemmap_key);
> > -	else
> > -		static_branch_disable(&hugetlb_optimize_vmemmap_key);
> > +	mode = enable ? VMEMMAP_OPTIMIZE_ON : VMEMMAP_OPTIMIZE_OFF;
> > +	vmemmap_optimize_mode_switch(mode);
> >  
> >  	return 0;
> >  }
> > @@ -60,6 +80,8 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
> >  	vmemmap_end	= vmemmap_addr + (vmemmap_pages << PAGE_SHIFT);
> >  	vmemmap_reuse	= vmemmap_addr - PAGE_SIZE;
> >  
> > +	VM_BUG_ON_PAGE(!vmemmap_pages, head);
> > +
> >  	/*
> >  	 * The pages which the vmemmap virtual address range [@vmemmap_addr,
> >  	 * @vmemmap_end) are mapped to are freed to the buddy allocator, and
> > @@ -69,8 +91,10 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
> >  	 */
> >  	ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
> >  				  GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
> > -	if (!ret)
> > +	if (!ret) {
> >  		ClearHPageVmemmapOptimized(head);
> > +		static_branch_dec(&hugetlb_optimize_vmemmap_key);
> > +	}
> >  
> >  	return ret;
> >  }
> > @@ -84,6 +108,8 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
> >  	if (!vmemmap_pages)
> >  		return;
> >  
> > +	static_branch_inc(&hugetlb_optimize_vmemmap_key);
> 
> Can you explain the reasoning behind doing the static_branch_inc here in free,
> and static_branch_dec in alloc?
> IIUC, they may not be absolutely necessary but you could use the count to
> know how many optimized pages are in use?  Or, I may just be missing
> something.
>

Partly right. One 'count' is not enough. I have implemented this with similar
approach in v6 [1]. Except the 'count', we also need a lock to do synchronization.
However, both count and synchronization are included in static_key_inc/dec
infrastructure. It is simpler to use static_key_inc/dec directly, right? 

[1] https://lore.kernel.org/all/20220330153745.20465-5-songmuchun@bytedance.com/

Thanks.
