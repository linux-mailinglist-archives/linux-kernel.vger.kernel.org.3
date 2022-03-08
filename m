Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A504D11E3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344890AbiCHIQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344768AbiCHIQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:16:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06BF3E5F6;
        Tue,  8 Mar 2022 00:15:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0512C60DF5;
        Tue,  8 Mar 2022 08:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E34C340EB;
        Tue,  8 Mar 2022 08:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646727320;
        bh=fpLw6ilHy2qEpnDqYsR0iJI6vOZ2X8zIBp7Wd8WlrrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EVR82PQ1COHTKSh8NRb4JwxMMH24tt4iPACFs9L1F8bfh6q+Zt7Sqcl6WB6Yspe9Z
         i69kqqJ7PaetLKRuELaiiDkFSbR3xqBf6WETEWwqJcQ8pQRnzLj+AZiEWKiyHURCoE
         GOxj3qqMcv4d1lU8u70X0ansg5u6yXK7RBBzJIrjUDhtgfRty3mR9tNJIYSnDkQkYK
         CBuBYUjsCdg+6QjGW1NFEsFoOGaoSvahkeuhtoTodqNcNzqTH6aOeQYv9LMP7f9pHe
         mrhrtAvOZG8rNx1kCbNvDMZwNtBqpXYQhY3yoO5UwCnTWwl6B4nWX8uXY49zw/UkUK
         QVOE8m/VM7E0Q==
Date:   Tue, 8 Mar 2022 10:14:39 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 06/32] x86/sgx: Support VMA permissions more relaxed
 than enclave permissions
Message-ID: <YicQbzR1o1qZUGbw@iki.fi>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <0555a4b4a5e8879eb8f879ab3d9908302000f11c.1644274683.git.reinette.chatre@intel.com>
 <YiY8bD/QcmcHH8dz@iki.fi>
 <774e906c-53fc-279c-1fb7-0922557a9da5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <774e906c-53fc-279c-1fb7-0922557a9da5@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 09:36:36AM -0800, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 3/7/2022 9:10 AM, Jarkko Sakkinen wrote:
> > On Mon, Feb 07, 2022 at 04:45:28PM -0800, Reinette Chatre wrote:
> >> === Summary ===
> >>
> >> An SGX VMA can only be created if its permissions are the same or
> >> weaker than the Enclave Page Cache Map (EPCM) permissions. After VMA
> >> creation this same rule is again enforced by the page fault handler:
> >> faulted enclave pages are required to have equal or more relaxed
> >> EPCM permissions than the VMA permissions.
> >>
> >> On SGX1 systems the additional enforcement in the page fault handler
> >> is redundant and on SGX2 systems it incorrectly prevents access.
> >> On SGX1 systems it is unnecessary to repeat the enforcement of the
> >> permission rule. The rule used during original VMA creation will
> >> ensure that any access attempt will use correct permissions.
> >> With SGX2 the EPCM permissions of a page can change after VMA
> >> creation resulting in the VMA permissions potentially being more
> >> relaxed than the EPCM permissions and the page fault handler
> >> incorrectly blocking valid access attempts.
> >>
> >> Enable the VMA's pages to remain accessible while ensuring that
> >> the PTEs are installed to match the EPCM permissions but not be
> >> more relaxed than the VMA permissions.
> >>
> >> === Full Changelog ===
> >>
> >> An SGX enclave is an area of memory where parts of an application
> >> can reside. First an enclave is created and loaded (from
> >> non-enclave memory) with the code and data of an application,
> >> then user space can map (mmap()) the enclave memory to
> >> be able to enter the enclave at its defined entry points for
> >> execution within it.
> >>
> >> The hardware maintains a secure structure, the Enclave Page Cache Map
> >> (EPCM), that tracks the contents of the enclave. Of interest here is
> >> its tracking of the enclave page permissions. When a page is loaded
> >> into the enclave its permissions are specified and recorded in the
> >> EPCM. In parallel the kernel maintains permissions within the
> >> page table entries (PTEs) and the rule is that PTE permissions
> >> are not allowed to be more relaxed than the EPCM permissions.
> >>
> >> A new mapping (mmap()) of enclave memory can only succeed if the
> >> mapping has the same or weaker permissions than the permissions that
> >> were vetted during enclave creation. This is enforced by
> >> sgx_encl_may_map() that is called on the mmap() as well as mprotect()
> >> paths. This rule remains.
> >>
> >> One feature of SGX2 is to support the modification of EPCM permissions
> >> after enclave initialization. Enclave pages may thus already be part
> >> of a VMA at the time their EPCM permissions are changed resulting
> >> in the VMA's permissions potentially being more relaxed than the EPCM
> >> permissions.
> >>
> >> Allow permissions of existing VMAs to be more relaxed than EPCM
> >> permissions in preparation for dynamic EPCM permission changes
> >> made possible in SGX2.  New VMAs that attempt to have more relaxed
> >> permissions than EPCM permissions continue to be unsupported.
> >>
> >> Reasons why permissions of existing VMAs are allowed to be more relaxed
> >> than EPCM permissions instead of dynamically changing VMA permissions
> >> when EPCM permissions change are:
> >> 1) Changing VMA permissions involve splitting VMAs which is an
> >>    operation that can fail. Additionally changing EPCM permissions of
> >>    a range of pages could also fail on any of the pages involved.
> >>    Handling these error cases causes problems. For example, if an
> >>    EPCM permission change fails and the VMA has already been split
> >>    then it is not possible to undo the VMA split nor possible to
> >>    undo the EPCM permission changes that did succeed before the
> >>    failure.
> >> 2) The kernel has little insight into the user space where EPCM
> >>    permissions are controlled from. For example, a RW page may
> >>    be made RO just before it is made RX and splitting the VMAs
> >>    while the VMAs may change soon is unnecessary.
> >>
> >> Remove the extra permission check called on a page fault
> >> (vm_operations_struct->fault) or during debugging
> >> (vm_operations_struct->access) when loading the enclave page from swap
> >> that ensures that the VMA permissions are not more relaxed than the
> >> EPCM permissions. Since a VMA could only exist if it passed the
> >> original permission checks during mmap() and a VMA may indeed
> >> have more relaxed permissions than the EPCM permissions this extra
> >> permission check is no longer appropriate.
> >>
> >> With the permission check removed, ensure that PTEs do
> >> not blindly inherit the VMA permissions but instead the permissions
> >> that the VMA and EPCM agree on. PTEs for writable pages (from VMA
> >> and enclave perspective) are installed with the writable bit set,
> >> reducing the need for this additional flow to the permission mismatch
> >> cases handled next.
> >>
> >> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> >> ---
> >> Changes since V1:
> >> - Reword commit message (Jarkko).
> >> - Use "relax" instead of "exceed" when referring to permissions (Dave).
> >> - Add snippet to Documentation/x86/sgx.rst that highlights the
> >>   relationship between VMA, EPCM, and PTE permissions on SGX
> >>   systems (Andy).
> >>
> >>  Documentation/x86/sgx.rst      | 10 +++++++++
> >>  arch/x86/kernel/cpu/sgx/encl.c | 38 ++++++++++++++++++----------------
> >>  2 files changed, 30 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
> >> index 89ff924b1480..5659932728a5 100644
> >> --- a/Documentation/x86/sgx.rst
> >> +++ b/Documentation/x86/sgx.rst
> >> @@ -99,6 +99,16 @@ The relationships between the different permission masks are:
> >>  * PTEs are installed to match the EPCM permissions, but not be more
> >>    relaxed than the VMA permissions.
> >>  
> >> +On systems supporting SGX2 EPCM permissions may change while the
> >> +enclave page belongs to a VMA without impacting the VMA permissions.
> >> +This means that a running VMA may appear to allow access to an enclave
> >> +page that is not allowed by its EPCM permissions. For example, when an
> >> +enclave page with RW EPCM permissions is mapped by a RW VMA but is
> >> +subsequently changed to have read-only EPCM permissions. The kernel
> >> +continues to maintain correct access to the enclave page through the
> >> +PTE that will ensure that only access allowed by both the VMA
> >> +and EPCM permissions are permitted.
> >> +
> >>  Application interface
> >>  =====================
> >>  
> >> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> >> index 48afe96ae0f0..b6105d9e7c46 100644
> >> --- a/arch/x86/kernel/cpu/sgx/encl.c
> >> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> >> @@ -91,10 +91,8 @@ static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
> >>  }
> >>  
> >>  static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
> >> -						unsigned long addr,
> >> -						unsigned long vm_flags)
> >> +						unsigned long addr)
> >>  {
> >> -	unsigned long vm_prot_bits = vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
> >>  	struct sgx_epc_page *epc_page;
> >>  	struct sgx_encl_page *entry;
> >>  
> >> @@ -102,14 +100,6 @@ static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
> >>  	if (!entry)
> >>  		return ERR_PTR(-EFAULT);
> >>  
> >> -	/*
> >> -	 * Verify that the faulted page has equal or higher build time
> >> -	 * permissions than the VMA permissions (i.e. the subset of {VM_READ,
> >> -	 * VM_WRITE, VM_EXECUTE} in vma->vm_flags).
> >> -	 */
> >> -	if ((entry->vm_max_prot_bits & vm_prot_bits) != vm_prot_bits)
> >> -		return ERR_PTR(-EFAULT);
> >> -
> >>  	/* Entry successfully located. */
> >>  	if (entry->epc_page) {
> >>  		if (entry->desc & SGX_ENCL_PAGE_BEING_RECLAIMED)
> >> @@ -138,7 +128,9 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
> >>  {
> >>  	unsigned long addr = (unsigned long)vmf->address;
> >>  	struct vm_area_struct *vma = vmf->vma;
> >> +	unsigned long page_prot_bits;
> >>  	struct sgx_encl_page *entry;
> >> +	unsigned long vm_prot_bits;
> >>  	unsigned long phys_addr;
> >>  	struct sgx_encl *encl;
> >>  	vm_fault_t ret;
> >> @@ -155,7 +147,7 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
> >>  
> >>  	mutex_lock(&encl->lock);
> >>  
> >> -	entry = sgx_encl_load_page(encl, addr, vma->vm_flags);
> >> +	entry = sgx_encl_load_page(encl, addr);
> >>  	if (IS_ERR(entry)) {
> >>  		mutex_unlock(&encl->lock);
> >   
> >> @@ -167,7 +159,19 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
> >>  
> >>  	phys_addr = sgx_get_epc_phys_addr(entry->epc_page);
> >>  
> >> -	ret = vmf_insert_pfn(vma, addr, PFN_DOWN(phys_addr));
> >> +	/*
> >> +	 * Insert PTE to match the EPCM page permissions ensured to not
> >> +	 * exceed the VMA permissions.
> >> +	 */
> >> +	vm_prot_bits = vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
> >> +	page_prot_bits = entry->vm_max_prot_bits & vm_prot_bits;
> >> +	/*
> >> +	 * Add VM_SHARED so that PTE is made writable right away if VMA
> >> +	 * and EPCM are writable (no COW in SGX).
> >> +	 */
> >> +	page_prot_bits |= (vma->vm_flags & VM_SHARED);
> >> +	ret = vmf_insert_pfn_prot(vma, addr, PFN_DOWN(phys_addr),
> >> +				  vm_get_page_prot(page_prot_bits));
> >>  	if (ret != VM_FAULT_NOPAGE) {
> >>  		mutex_unlock(&encl->lock);
> >>  
> >> @@ -295,15 +299,14 @@ static int sgx_encl_debug_write(struct sgx_encl *encl, struct sgx_encl_page *pag
> >>   * Load an enclave page to EPC if required, and take encl->lock.
> >>   */
> >>  static struct sgx_encl_page *sgx_encl_reserve_page(struct sgx_encl *encl,
> >> -						   unsigned long addr,
> >> -						   unsigned long vm_flags)
> >> +						   unsigned long addr)
> >>  {
> >>  	struct sgx_encl_page *entry;
> >>  
> >>  	for ( ; ; ) {
> >>  		mutex_lock(&encl->lock);
> >>  
> >> -		entry = sgx_encl_load_page(encl, addr, vm_flags);
> >> +		entry = sgx_encl_load_page(encl, addr);
> >>  		if (PTR_ERR(entry) != -EBUSY)
> >>  			break;
> >>  
> >> @@ -339,8 +342,7 @@ static int sgx_vma_access(struct vm_area_struct *vma, unsigned long addr,
> >>  		return -EFAULT;
> >>  
> >>  	for (i = 0; i < len; i += cnt) {
> >> -		entry = sgx_encl_reserve_page(encl, (addr + i) & PAGE_MASK,
> >> -					      vma->vm_flags);
> >> +		entry = sgx_encl_reserve_page(encl, (addr + i) & PAGE_MASK);
> >>  		if (IS_ERR(entry)) {
> >>  			ret = PTR_ERR(entry);
> >>  			break;
> >> -- 
> >> 2.25.1
> >>
> > 
> > If you unconditionally set vm_max_prot_bits to RWX for dynamically created
> > pags, you would not need to do this.
> > 
> > These patches could be then safely dropped then:
> > 
> > - [PATCH V2 06/32] x86/sgx: Support VMA permissions more relaxed than enclave permissions 
> > - [PATCH V2 08/32] x86/sgx: x86/sgx: Add sgx_encl_page->vm_run_prot_bits for dynamic permission changes
> > - [PATCH V2 15/32] x86/sgx: Support relaxing of enclave page permissions
> > 
> > And that would also keep full ABI compatibility without exceptions to the
> > existing mainline code.
> > 
> 
> Dropping these changes do not just impact dynamically created pages. Dropping
> these patches would result in EPCM page permission restriction being supported
> for all pages, those added before enclave initialization as well as dynamically
> added pages, but their PTEs will not be impacted.
> 
> For example, if a RW enclave page is added via SGX_IOC_ENCLAVE_ADD_PAGES and
> then later made read-only via SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS then Linux
> would keep allowing and installing RW PTEs to this page.

I think that would be perfectly fine, if someone wants to do that. There is
no corrateral damage on doing that. Kernel does not get messed because of
that. It's a use case that does not make sense in the first place, so it'd
be stupid to build anything extensive around it to the kernel.

Shooting yourself to the foot is something that kernel does and should not
protect user space from unless there is a risk of messing the state of the
kernel itself.

Much worse is that we have e.g. completely artificial ioctl
SGX_IOC_ENCLAVE_RELAX_PERMISSIONS to support this scheme, which could e.g.
cause extra roundtrips for simple EMODPE.

Also this means not having to include 06/32, which keeps 100% backwards
compatibility in run-time behaviour to the mainline while not restricting
at all dynamically created pages. And we get rid of complex book keeping
of vm_run_prot_bits.

And generally the whole model is then very easy to understand and explain.
If I had to keep presentation of the current mess in the patch set in a
conference, I can honestly say that I would be in serious trouble. It's
not clean and clear security model, which is a risk by itself.

BR, Jarkko
