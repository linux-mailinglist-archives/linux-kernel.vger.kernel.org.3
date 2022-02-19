Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91494BC856
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 12:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242198AbiBSL5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 06:57:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiBSL5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 06:57:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888C53917F;
        Sat, 19 Feb 2022 03:56:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17A94B80ACB;
        Sat, 19 Feb 2022 11:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1F8C004E1;
        Sat, 19 Feb 2022 11:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645271799;
        bh=6ukygHv4UtLRocoen7y8EIy2j+ikEwPHcV0RUA7w3HQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S2FbKswiZOe22RNrkiXm6NxfqL5VY+qBGcaa5faTTgLHCE1WPCi9DU/Cqh6EcJPx7
         eFMKYRUZ3+vasRx4J5x8tp3dmrIY3uSfPbSFRnGM/+RYsItsqezMXD+8PrJOcdzrG0
         wAhDVCEYZuXzqC8GTiXE79dd1rpukoODNew51bdltk6SiYZVNsE0PsESkZ789FzEOa
         ltowJM9yXq2v06VvGWZ5scAhB3DF5KVw/yjYVgZKV1IFvMHow423lTCgpT5NPfbF8U
         KS96Ph1maCk9E+IKTO71OlQBrRe2DCoybUDSKQxgUyB7YdlAuuMx3dc1X6nujXL8VS
         Xq7Ix5eOjo/aA==
Date:   Sat, 19 Feb 2022 12:57:13 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 19/32] x86/sgx: Support adding of pages to an
 initialized enclave
Message-ID: <YhDbGfzGWQ5RtwTU@iki.fi>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <fcbde9c3e67289eaff9cd8b34989919629fe823c.1644274683.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcbde9c3e67289eaff9cd8b34989919629fe823c.1644274683.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 04:45:41PM -0800, Reinette Chatre wrote:
> With SGX1 an enclave needs to be created with its maximum memory demands
> allocated. Pages cannot be added to an enclave after it is initialized.
> SGX2 introduces a new function, ENCLS[EAUG], that can be used to add
> pages to an initialized enclave. With SGX2 the enclave still needs to
> set aside address space for its maximum memory demands during enclave
> creation, but all pages need not be added before enclave initialization.
> Pages can be added during enclave runtime.
> 
> Add support for dynamically adding pages to an initialized enclave,
> architecturally limited to RW permission. Add pages via the page fault
> handler at the time an enclave address without a backing enclave page
> is accessed, potentially directly reclaiming pages if no free pages
> are available.
> 
> The enclave is still required to run ENCLU[EACCEPT] on the page before
> it can be used. A useful flow is for the enclave to run ENCLU[EACCEPT]
> on an uninitialized address. This will trigger the page fault handler
> that will add the enclave page and return execution to the enclave to
> repeat the ENCLU[EACCEPT] instruction, this time successful.
> 
> If the enclave accesses an uninitialized address in another way, for
> example by expanding the enclave stack to a page that has not yet been
> added, then the page fault handler would add the page on the first
> write but upon returning to the enclave the instruction that triggered
> the page fault would be repeated and since ENCLU[EACCEPT] was not run
> yet it would trigger a second page fault, this time with the SGX flag
> set in the page fault error code. This can only be recovered by entering
> the enclave again and directly running the ENCLU[EACCEPT] instruction on
> the now initialized address.
> 
> Accessing an uninitialized address from outside the enclave also
> triggers this flow but the page will remain inaccessible (access will
> result in #PF) until accepted from within the enclave via
> ENCLU[EACCEPT].
> 
> The page is added with the architecturally constrained RW permissions
> as runtime as well as maximum allowed permissions. It is understood that
> there are some use cases, for example code relocation, that requires RWX
> maximum permissions. Supporting these use cases require guidance from
> user space policy before such maximum permissions can be allowed.
> Integration with user policy is deferred.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V1:
> - Fix subject line "to initialized" -> "to an initialized" (Jarkko).
> - Move text about hardware's PENDING state to the patch that introduces
>   the ENCLS[EAUG] wrapper (Jarkko).
> - Ensure kernel-doc uses brackets when referring to function.
> 
>  arch/x86/kernel/cpu/sgx/encl.c  | 133 ++++++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/sgx/encl.h  |   2 +
>  arch/x86/kernel/cpu/sgx/ioctl.c |   4 +-
>  3 files changed, 137 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index a5d4a7efb986..d1e3ea86b902 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -124,6 +124,128 @@ struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
>  	return entry;
>  }
>  
> +/**
> + * sgx_encl_eaug_page() - Dynamically add page to initialized enclave
> + * @vma:	VMA obtained from fault info from where page is accessed
> + * @encl:	enclave accessing the page
> + * @addr:	address that triggered the page fault
> + *
> + * When an initialized enclave accesses a page with no backing EPC page
> + * on a SGX2 system then the EPC can be added dynamically via the SGX2
> + * ENCLS[EAUG] instruction.
> + *
> + * Returns: Appropriate vm_fault_t: VM_FAULT_NOPAGE when PTE was installed
> + * successfully, VM_FAULT_SIGBUS or VM_FAULT_OOM as error otherwise.
> + */
> +static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
> +				     struct sgx_encl *encl, unsigned long addr)
> +{
> +	struct sgx_pageinfo pginfo = {0};
> +	struct sgx_encl_page *encl_page;
> +	struct sgx_epc_page *epc_page;
> +	struct sgx_va_page *va_page;
> +	unsigned long phys_addr;
> +	unsigned long prot;
> +	vm_fault_t vmret;
> +	int ret;
> +
> +	if (!test_bit(SGX_ENCL_INITIALIZED, &encl->flags))
> +		return VM_FAULT_SIGBUS;
> +
> +	encl_page = kzalloc(sizeof(*encl_page), GFP_KERNEL);
> +	if (!encl_page)
> +		return VM_FAULT_OOM;
> +
> +	encl_page->desc = addr;
> +	encl_page->encl = encl;
> +
> +	/*
> +	 * Adding a regular page that is architecturally allowed to only
> +	 * be created with RW permissions.
> +	 * TBD: Interface with user space policy to support max permissions
> +	 * of RWX.
> +	 */
> +	prot = PROT_READ | PROT_WRITE;
> +	encl_page->vm_run_prot_bits = calc_vm_prot_bits(prot, 0);
> +	encl_page->vm_max_prot_bits = encl_page->vm_run_prot_bits;
> +
> +	epc_page = sgx_alloc_epc_page(encl_page, true);
> +	if (IS_ERR(epc_page)) {
> +		kfree(encl_page);
> +		return VM_FAULT_SIGBUS;
> +	}
> +
> +	va_page = sgx_encl_grow(encl);
> +	if (IS_ERR(va_page)) {
> +		ret = PTR_ERR(va_page);
> +		goto err_out_free;
> +	}
> +
> +	mutex_lock(&encl->lock);
> +
> +	/*
> +	 * Copy comment from sgx_encl_add_page() to maintain guidance in
> +	 * this similar flow:
> +	 * Adding to encl->va_pages must be done under encl->lock.  Ditto for
> +	 * deleting (via sgx_encl_shrink()) in the error path.
> +	 */
> +	if (va_page)
> +		list_add(&va_page->list, &encl->va_pages);
> +
> +	ret = xa_insert(&encl->page_array, PFN_DOWN(encl_page->desc),
> +			encl_page, GFP_KERNEL);
> +	/*
> +	 * If ret == -EBUSY then page was created in another flow while
> +	 * running without encl->lock
> +	 */
> +	if (ret)
> +		goto err_out_unlock;
> +
> +	pginfo.secs = (unsigned long)sgx_get_epc_virt_addr(encl->secs.epc_page);
> +	pginfo.addr = encl_page->desc & PAGE_MASK;
> +	pginfo.metadata = 0;
> +
> +	ret = __eaug(&pginfo, sgx_get_epc_virt_addr(epc_page));
> +	if (ret)
> +		goto err_out;
> +
> +	encl_page->encl = encl;
> +	encl_page->epc_page = epc_page;
> +	encl_page->type = SGX_PAGE_TYPE_REG;
> +	encl->secs_child_cnt++;
> +
> +	sgx_mark_page_reclaimable(encl_page->epc_page);
> +
> +	phys_addr = sgx_get_epc_phys_addr(epc_page);
> +	/*
> +	 * Do not undo everything when creating PTE entry fails - next #PF
> +	 * would find page ready for a PTE.
> +	 * PAGE_SHARED because protection is forced to be RW above and COW
> +	 * is not supported.
> +	 */
> +	vmret = vmf_insert_pfn_prot(vma, addr, PFN_DOWN(phys_addr),
> +				    PAGE_SHARED);
> +	if (vmret != VM_FAULT_NOPAGE) {
> +		mutex_unlock(&encl->lock);
> +		return VM_FAULT_SIGBUS;
> +	}
> +	mutex_unlock(&encl->lock);
> +	return VM_FAULT_NOPAGE;
> +
> +err_out:
> +	xa_erase(&encl->page_array, PFN_DOWN(encl_page->desc));
> +
> +err_out_unlock:
> +	sgx_encl_shrink(encl, va_page);
> +	mutex_unlock(&encl->lock);
> +
> +err_out_free:
> +	sgx_encl_free_epc_page(epc_page);
> +	kfree(encl_page);
> +
> +	return VM_FAULT_SIGBUS;
> +}
> +
>  static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
>  {
>  	unsigned long addr = (unsigned long)vmf->address;
> @@ -145,6 +267,17 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
>  	if (unlikely(!encl))
>  		return VM_FAULT_SIGBUS;
>  
> +	/*
> +	 * The page_array keeps track of all enclave pages, whether they
> +	 * are swapped out or not. If there is no entry for this page and
> +	 * the system supports SGX2 then it is possible to dynamically add
> +	 * a new enclave page. This is only possible for an initialized
> +	 * enclave that will be checked for right away.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_SGX2) &&
> +	    (!xa_load(&encl->page_array, PFN_DOWN(addr))))
> +		return sgx_encl_eaug_page(vma, encl, addr);
> +
>  	mutex_lock(&encl->lock);
>  
>  	entry = sgx_encl_load_page(encl, addr);
> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
> index 848a28d28d3d..1b6ce1da7c92 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.h
> +++ b/arch/x86/kernel/cpu/sgx/encl.h
> @@ -123,4 +123,6 @@ void sgx_encl_free_epc_page(struct sgx_epc_page *page);
>  struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
>  					 unsigned long addr);
>  
> +struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl);
> +void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page);
>  #endif /* _X86_ENCL_H */
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index 23bdf558b231..58ff62a1fb00 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -17,7 +17,7 @@
>  #include "encl.h"
>  #include "encls.h"
>  
> -static struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
> +struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
>  {
>  	struct sgx_va_page *va_page = NULL;
>  	void *err;
> @@ -43,7 +43,7 @@ static struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
>  	return va_page;
>  }
>  
> -static void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page)
> +void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page)
>  {
>  	encl->page_cnt--;
>  
> -- 
> 2.25.1
> 

Quickly looking through also this sequence is possible:

1. Enclave's run-time flow ignores the whole EACCEPT but instead a memory
   dereference will initialize the sequence.
2. This causes #PF handler to do EAUG and after the enclave is re-entered
   the vDSO exists because the page is not EACCEPT'd.
2. Enclave host enter in-enclave exception handler, which does EACCEPT.

Can you confirm this? I'm planning to test this patch by implementing EAUG
support in Rust for Enarx. At this point I'm not yet sure whether I choose
EACCEPT initiated or memory deference initiated code path but I think it is
good if the kernel implementation is good enough to support both.

Other than that, this looks super solid!

BR, Jarkko
