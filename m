Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037E54F23C2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiDEG47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiDEG45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:56:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B81ED45;
        Mon,  4 Apr 2022 23:54:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC440615B2;
        Tue,  5 Apr 2022 06:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6AFC340F3;
        Tue,  5 Apr 2022 06:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649141698;
        bh=lAGRKXFyscFGIBfBF8/g5C+egdrJLMjHYOz7COxwDTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qb6sSCd/z2WkgKTxFL/W0crkdglAxSy/+jlEdiLzCJ2gwzJYgxa6iiejxO8rcYqGy
         1dD3xzfy+pW8roY4c4jJUDiGh1drNpoe2/WaK/NzhMLsSWDAautHIe42nlXPzT0Eol
         4cuSp15x8iFs86JDqA2CnoL0DN7tOw+UlhFcHQhYNve4Yk8M/SSKL0m3S2SalVZ1II
         2YSPvg1PqI3t/XAapVd6ScjzgZFcPZgCmaq7djMtiudgORts5+HIfQp/s+yTP0yBPX
         vezlzj9ia5GHguCnH22cVkocwZiO3+7308ugR0IQtG5nXgPEcq/dyQONoRhl6ZD6b3
         Iaubz5skOYmKg==
Date:   Tue, 5 Apr 2022 09:56:09 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 05/30] x86/sgx: Support loading enclave page without
 VMA permissions check
Message-ID: <YkvoCQ/P1qUJgpmt@kernel.org>
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <c9a81f8a2b3f582a906c750e2221f98ca36731e4.1648847675.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9a81f8a2b3f582a906c750e2221f98ca36731e4.1648847675.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 09:49:13AM -0700, Reinette Chatre wrote:
> sgx_encl_load_page() is used to find and load an enclave page into
> enclave (EPC) memory, potentially loading it from the backing storage.
> Both usages of sgx_encl_load_page() are during an access to the
> enclave page from a VMA and thus the permissions of the VMA are
> considered before the enclave page is loaded.
> 
> SGX2 functions operating on enclave pages belonging to an initialized
> enclave requiring the page to be in EPC. It is thus required to
> support loading enclave pages into the EPC independent from a VMA.
> 
> Split the current sgx_encl_load_page() to support the two usages:
> A new call, sgx_encl_load_page_in_vma(), behaves exactly like the
> current sgx_encl_load_page() that takes VMA permissions into account,
> while sgx_encl_load_page() just loads an enclave page into EPC.
> 
> VMA, PTE, and EPCM permissions would continue to dictate whether
> the pages can be accessed from within an enclave.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V2:
> - New patch
> 
>  arch/x86/kernel/cpu/sgx/encl.c | 57 ++++++++++++++++++++++------------
>  arch/x86/kernel/cpu/sgx/encl.h |  2 ++
>  2 files changed, 40 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index 7c63a1911fae..05ae1168391c 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -131,25 +131,10 @@ static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
>  	return epc_page;
>  }
>  
> -static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
> -						unsigned long addr,
> -						unsigned long vm_flags)
> +static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
> +						  struct sgx_encl_page *entry)
>  {
> -	unsigned long vm_prot_bits = vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
>  	struct sgx_epc_page *epc_page;
> -	struct sgx_encl_page *entry;
> -
> -	entry = xa_load(&encl->page_array, PFN_DOWN(addr));
> -	if (!entry)
> -		return ERR_PTR(-EFAULT);
> -
> -	/*
> -	 * Verify that the faulted page has equal or higher build time
> -	 * permissions than the VMA permissions (i.e. the subset of {VM_READ,
> -	 * VM_WRITE, VM_EXECUTE} in vma->vm_flags).
> -	 */
> -	if ((entry->vm_max_prot_bits & vm_prot_bits) != vm_prot_bits)
> -		return ERR_PTR(-EFAULT);
>  
>  	/* Entry successfully located. */
>  	if (entry->epc_page) {
> @@ -175,6 +160,40 @@ static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
>  	return entry;
>  }
>  
> +static struct sgx_encl_page *sgx_encl_load_page_in_vma(struct sgx_encl *encl,
> +						       unsigned long addr,
> +						       unsigned long vm_flags)
> +{
> +	unsigned long vm_prot_bits = vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
> +	struct sgx_encl_page *entry;
> +
> +	entry = xa_load(&encl->page_array, PFN_DOWN(addr));
> +	if (!entry)
> +		return ERR_PTR(-EFAULT);
> +
> +	/*
> +	 * Verify that the page has equal or higher build time
> +	 * permissions than the VMA permissions (i.e. the subset of {VM_READ,
> +	 * VM_WRITE, VM_EXECUTE} in vma->vm_flags).
> +	 */
> +	if ((entry->vm_max_prot_bits & vm_prot_bits) != vm_prot_bits)
> +		return ERR_PTR(-EFAULT);
> +
> +	return __sgx_encl_load_page(encl, entry);
> +}
> +
> +struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
> +					 unsigned long addr)
> +{
> +	struct sgx_encl_page *entry;
> +
> +	entry = xa_load(&encl->page_array, PFN_DOWN(addr));
> +	if (!entry)
> +		return ERR_PTR(-EFAULT);
> +
> +	return __sgx_encl_load_page(encl, entry);
> +}
> +
>  static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
>  {
>  	unsigned long addr = (unsigned long)vmf->address;
> @@ -196,7 +215,7 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
>  
>  	mutex_lock(&encl->lock);
>  
> -	entry = sgx_encl_load_page(encl, addr, vma->vm_flags);
> +	entry = sgx_encl_load_page_in_vma(encl, addr, vma->vm_flags);
>  	if (IS_ERR(entry)) {
>  		mutex_unlock(&encl->lock);
>  
> @@ -344,7 +363,7 @@ static struct sgx_encl_page *sgx_encl_reserve_page(struct sgx_encl *encl,
>  	for ( ; ; ) {
>  		mutex_lock(&encl->lock);
>  
> -		entry = sgx_encl_load_page(encl, addr, vm_flags);
> +		entry = sgx_encl_load_page_in_vma(encl, addr, vm_flags);
>  		if (PTR_ERR(entry) != -EBUSY)
>  			break;
>  
> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
> index fec43ca65065..6b34efba1602 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.h
> +++ b/arch/x86/kernel/cpu/sgx/encl.h
> @@ -116,5 +116,7 @@ unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
>  void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
>  bool sgx_va_page_full(struct sgx_va_page *va_page);
>  void sgx_encl_free_epc_page(struct sgx_epc_page *page);
> +struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
> +					 unsigned long addr);
>  
>  #endif /* _X86_ENCL_H */
> -- 
> 2.25.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
