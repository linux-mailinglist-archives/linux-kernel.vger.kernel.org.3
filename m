Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CFF4DCE15
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237720AbiCQSzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237693AbiCQSzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:55:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2DB126F87;
        Thu, 17 Mar 2022 11:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAB15B81EF7;
        Thu, 17 Mar 2022 18:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8E5C340E9;
        Thu, 17 Mar 2022 18:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647543225;
        bh=edELrLrtgzTsaIwv3UMBkt3LdCzkTQnb46WYbn3cLSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gb51jGzu7Bie3TdApB4vScQYeBAtu2aHyjj+oAJvAvjYZCmqiDy/hfF5aauP2OrZ9
         dyWKOrrvjF/t2vQ+J8hIxiFVhOmNQPdEPw26dFbgczPPAI30MGA6DfNNOQfG5b4pu1
         shOgBI8Ac1oTxw/9qJZGq9PM7SLeGX3H0sufNF6tYOFjNkov9e3uX6NUnkzrd4/hjq
         V3iPQUwJa9ZbF+Z9oxAYLC5nJCsuC1cmi9hBKIn5SHJlUe28TuyP6JhxleGAZFDThf
         Xv9HkfBnhyN/6wpx7YAUdtmJY9gggMSOp64zlMw/53w7Q4LBzckBkLg93TfdZgLbtk
         B/xumN0lupL2w==
Date:   Thu, 17 Mar 2022 20:52:54 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Zhang, Cathy" <cathy.zhang@intel.com>
Cc:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [RFC PATCH v2 01/10] x86/sgx: Introduce mechanism to prevent new
 initializations of EPC pages
Message-ID: <YjODhqZZjAkXuScd@iki.fi>
References: <20220315010300.10199-1-cathy.zhang@intel.com>
 <20220315010300.10199-2-cathy.zhang@intel.com>
 <YjK1PtnutmiSgE6f@kernel.org>
 <86c945969e674be18abfb6c2a5f16701@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86c945969e674be18abfb6c2a5f16701@intel.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 02:08:21PM +0000, Zhang, Cathy wrote:
> Hi Jarkko,
> 
> > -----Original Message-----
> > From: Jarkko Sakkinen <jarkko@kernel.org>
> > Sent: Thursday, March 17, 2022 12:13 PM
> > To: Zhang, Cathy <cathy.zhang@intel.com>
> > Cc: linux-sgx@vger.kernel.org; linux-kernel@vger.kernel.org; Hansen, Dave
> > <dave.hansen@intel.com>; Raj, Ashok <ashok.raj@intel.com>
> > Subject: Re: [RFC PATCH v2 01/10] x86/sgx: Introduce mechanism to prevent
> > new initializations of EPC pages
> > 
> > On Tue, Mar 15, 2022 at 09:02:51AM +0800, Cathy Zhang wrote:
> > > == Background ==
> > >
> > > EUPDATESVN is a new SGX instruction which allows enclave attestation
> > > to include information about updated microcode without a reboot.
> > >
> > > The SGX hardware maintains metadata for each enclave page to help
> > > enforce its security guarantees. This includes things like a record of
> > > the enclave to which the page belongs and the type of the page:
> > > SGX metadata like "VA" or "SECS" pages, or regular enclave pages like
> > > those that store user data.
> > >
> > > Before an EUPDATESVN operation can be successful, all SGX memory (aka.
> > > EPC) must be marked as "unused" in the SGX hardware metadata (aka,
> > > EPCM). The SGX microcode now maintains a reference count of pages
> > > which are unused to aid in determining when all pages reach the
> > > "unused" state.
> > >
> > > Both bare-metal and KVM guest EPC must be made unused. To increase the
> > > chance of a successful EUPDATESVN, the kernel prevents existing
> > > enclaves from creating new, valid pages and prevents new enclave
> > > creation (creating an enclave involves initializing a "SECS" page).
> > >
> > > The entire EUPDATESVN process is very slow since it potentially
> > > affects gigabytes of enclave memory. It can potentially take seconds
> > > or minutes to complete. Userspace may encounter -EBUSY errors during
> > > the update and is expected to retry.
> > >
> > > == Patch contents ==
> > >
> > > Introduce mechanism to prevent new initializations of EPC pages.
> > >
> > > Use a flag to indicate when SGX EPC pages are "locked", which means
> > > it's not allowed to allocate new EPC page for use. Check it in all
> > > paths that can initialize an EPC page. Use SRCU to ensure that the
> > > flag is visible across the system before proceeding with an update.
> > >
> > > Add checks to all sites that call SGX instructions that can transition
> > > pages from unused to initialized to ensure that the SRCU lock is held.
> > >
> > > Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>
> > > ---
> > >  arch/x86/kernel/cpu/sgx/encls.h | 10 +++++++
> > >  arch/x86/kernel/cpu/sgx/sgx.h   |  3 ++
> > >  arch/x86/kernel/cpu/sgx/encl.c  | 25 +++++++++++++++--
> > > arch/x86/kernel/cpu/sgx/ioctl.c | 50
> > ++++++++++++++++++++++++++++++++-
> > > arch/x86/kernel/cpu/sgx/main.c  | 37 ++++++++++++++++++++++++
> > > arch/x86/kernel/cpu/sgx/virt.c  | 20 +++++++++++++
> > >  6 files changed, 142 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/x86/kernel/cpu/sgx/encls.h
> > > b/arch/x86/kernel/cpu/sgx/encls.h index 99004b02e2ed..3f1797ec2445
> > > 100644
> > > --- a/arch/x86/kernel/cpu/sgx/encls.h
> > > +++ b/arch/x86/kernel/cpu/sgx/encls.h
> > > @@ -139,6 +139,8 @@ static inline bool encls_failed(int ret)
> > >  /* Initialize an EPC page into an SGX Enclave Control Structure
> > > (SECS) page. */  static inline int __ecreate(struct sgx_pageinfo
> > > *pginfo, void *secs)  {
> > > +	lockdep_assert_held(&sgx_lock_epc_srcu);
> > > +
> > >  	return __encls_2(ECREATE, pginfo, secs);  }
> > >
> > > @@ -154,6 +156,8 @@ static inline int __eextend(void *secs, void *addr)
> > >   */
> > >  static inline int __eadd(struct sgx_pageinfo *pginfo, void *addr)  {
> > > +	lockdep_assert_held(&sgx_lock_epc_srcu);
> > > +
> > >  	return __encls_2(EADD, pginfo, addr);  }
> > >
> > > @@ -191,6 +195,8 @@ static inline int __etrack(void *addr)  static
> > > inline int __eldu(struct sgx_pageinfo *pginfo, void *addr,
> > >  			 void *va)
> > >  {
> > > +	lockdep_assert_held(&sgx_lock_epc_srcu);
> > > +
> > >  	return __encls_ret_3(ELDU, pginfo, addr, va);  }
> > >
> > > @@ -205,6 +211,8 @@ static inline int __epa(void *addr)  {
> > >  	unsigned long rbx = SGX_PAGE_TYPE_VA;
> > >
> > > +	lockdep_assert_held(&sgx_lock_epc_srcu);
> > > +
> > >  	return __encls_2(EPA, rbx, addr);
> > >  }
> > >
> > > @@ -230,6 +238,8 @@ static inline int __emodt(struct sgx_secinfo
> > > *secinfo, void *addr)
> > >  /* Zero a page of EPC memory and add it to an initialized enclave. */
> > > static inline int __eaug(struct sgx_pageinfo *pginfo, void *addr)  {
> > > +	lockdep_assert_held(&sgx_lock_epc_srcu);
> > > +
> > >  	return __encls_2(EAUG, pginfo, addr);  }
> > >
> > > diff --git a/arch/x86/kernel/cpu/sgx/sgx.h
> > > b/arch/x86/kernel/cpu/sgx/sgx.h index 85cbf103b0dd..dc8cb58100e3
> > > 100644
> > > --- a/arch/x86/kernel/cpu/sgx/sgx.h
> > > +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> > > @@ -104,4 +104,7 @@ static inline int __init sgx_vepc_init(void)
> > >
> > >  void sgx_update_lepubkeyhash(u64 *lepubkeyhash);
> > >
> > > +extern struct srcu_struct sgx_lock_epc_srcu; bool
> > > +sgx_epc_is_locked(void);
> > > +
> > >  #endif /* _X86_SGX_H */
> > > diff --git a/arch/x86/kernel/cpu/sgx/encl.c
> > > b/arch/x86/kernel/cpu/sgx/encl.c index a0255d41e075..d2b428992910
> > > 100644
> > > --- a/arch/x86/kernel/cpu/sgx/encl.c
> > > +++ b/arch/x86/kernel/cpu/sgx/encl.c
> > > @@ -264,6 +264,7 @@ static vm_fault_t sgx_vma_fault(struct vm_fault
> > *vmf)
> > >  	unsigned long phys_addr;
> > >  	struct sgx_encl *encl;
> > >  	vm_fault_t ret;
> > > +	int srcu_idx;
> > >
> > >  	encl = vma->vm_private_data;
> > >
> > > @@ -275,6 +276,12 @@ static vm_fault_t sgx_vma_fault(struct vm_fault
> > *vmf)
> > >  	if (unlikely(!encl))
> > >  		return VM_FAULT_SIGBUS;
> > >
> > > +	srcu_idx = srcu_read_lock(&sgx_lock_epc_srcu);
> > > +	if (sgx_epc_is_locked()) {
> > > +		srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > > +		return VM_FAULT_SIGBUS;
> > > +	}
> > > +
> > >  	/*
> > >  	 * The page_array keeps track of all enclave pages, whether they
> > >  	 * are swapped out or not. If there is no entry for this page and @@
> > > -283,14 +290,18 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
> > >  	 * enclave that will be checked for right away.
> > >  	 */
> > >  	if (cpu_feature_enabled(X86_FEATURE_SGX2) &&
> > > -	    (!xa_load(&encl->page_array, PFN_DOWN(addr))))
> > > -		return sgx_encl_eaug_page(vma, encl, addr);
> > > +	    (!xa_load(&encl->page_array, PFN_DOWN(addr)))) {
> > > +		ret = sgx_encl_eaug_page(vma, encl, addr);
> > > +		srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > > +		return ret;
> > > +	}
> > >
> > >  	mutex_lock(&encl->lock);
> > >
> > >  	entry = sgx_encl_load_page(encl, addr);
> > >  	if (IS_ERR(entry)) {
> > >  		mutex_unlock(&encl->lock);
> > > +		srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > >
> > >  		if (PTR_ERR(entry) == -EBUSY)
> > >  			return VM_FAULT_NOPAGE;
> > > @@ -315,12 +326,14 @@ static vm_fault_t sgx_vma_fault(struct vm_fault
> > *vmf)
> > >  				  vm_get_page_prot(page_prot_bits));
> > >  	if (ret != VM_FAULT_NOPAGE) {
> > >  		mutex_unlock(&encl->lock);
> > > +		srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > >
> > >  		return VM_FAULT_SIGBUS;
> > >  	}
> > >
> > >  	sgx_encl_test_and_clear_young(vma->vm_mm, entry);
> > >  	mutex_unlock(&encl->lock);
> > > +	srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > >
> > >  	return VM_FAULT_NOPAGE;
> > >  }
> > > @@ -513,6 +526,7 @@ static int sgx_vma_access(struct vm_area_struct
> > *vma, unsigned long addr,
> > >  	struct sgx_encl_page *entry = NULL;
> > >  	char data[sizeof(unsigned long)];
> > >  	unsigned long align;
> > > +	int srcu_idx;
> > >  	int offset;
> > >  	int cnt;
> > >  	int ret = 0;
> > > @@ -529,6 +543,12 @@ static int sgx_vma_access(struct vm_area_struct
> > *vma, unsigned long addr,
> > >  		return -EFAULT;
> > >
> > >  	for (i = 0; i < len; i += cnt) {
> > > +		srcu_idx = srcu_read_lock(&sgx_lock_epc_srcu);
> > > +		if (sgx_epc_is_locked()) {
> > > +			ret = -EBUSY;
> > > +			goto out;
> > > +		}
> > > +
> > >  		entry = sgx_encl_reserve_page(encl, (addr + i) &
> > PAGE_MASK);
> > >  		if (IS_ERR(entry)) {
> > >  			ret = PTR_ERR(entry);
> > > @@ -555,6 +575,7 @@ static int sgx_vma_access(struct vm_area_struct
> > > *vma, unsigned long addr,
> > >
> > >  out:
> > >  		mutex_unlock(&encl->lock);
> > > +		srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > >
> > >  		if (ret)
> > >  			break;
> > > diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c
> > > b/arch/x86/kernel/cpu/sgx/ioctl.c index d8c3c07badb3..da3b569a10bd
> > > 100644
> > > --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> > > +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> > > @@ -147,6 +147,7 @@ static int sgx_encl_create(struct sgx_encl *encl,
> > > struct sgx_secs *secs)  static long sgx_ioc_enclave_create(struct
> > > sgx_encl *encl, void __user *arg)  {
> > >  	struct sgx_enclave_create create_arg;
> > > +	int srcu_idx;
> > >  	void *secs;
> > >  	int ret;
> > >
> > > @@ -162,9 +163,18 @@ static long sgx_ioc_enclave_create(struct
> > > sgx_encl *encl, void __user *arg)
> > >
> > >  	if (copy_from_user(secs, (void __user *)create_arg.src, PAGE_SIZE))
> > >  		ret = -EFAULT;
> > > -	else
> > > +	else {
> > > +		srcu_idx = srcu_read_lock(&sgx_lock_epc_srcu);
> > > +		if (sgx_epc_is_locked()) {
> > > +			srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > > +			return -EBUSY;
> > > +		}
> > > +
> > >  		ret = sgx_encl_create(encl, secs);
> > >
> > > +		srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > > +	}
> > > +
> > >  	kfree(secs);
> > >  	return ret;
> > >  }
> > > @@ -444,6 +454,7 @@ static long sgx_ioc_enclave_add_pages(struct
> > sgx_encl *encl, void __user *arg)
> > >  	struct sgx_enclave_add_pages add_arg;
> > >  	struct sgx_secinfo secinfo;
> > >  	unsigned long c;
> > > +	int srcu_idx;
> > >  	int ret;
> > >
> > >  	if (!test_bit(SGX_ENCL_CREATED, &encl->flags) || @@ -477,8 +488,18
> > > @@ static long sgx_ioc_enclave_add_pages(struct sgx_encl *encl, void
> > __user *arg)
> > >  		if (need_resched())
> > >  			cond_resched();
> > >
> > > +		srcu_idx = srcu_read_lock(&sgx_lock_epc_srcu);
> > > +		if (sgx_epc_is_locked()) {
> > > +			ret = -EBUSY;
> > > +			srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > > +			break;
> > > +		}
> > > +
> > >  		ret = sgx_encl_add_page(encl, add_arg.src + c,
> > add_arg.offset + c,
> > >  					&secinfo, add_arg.flags);
> > > +
> > > +		srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > > +
> > >  		if (ret)
> > >  			break;
> > >  	}
> > > @@ -952,6 +973,7 @@ static long sgx_enclave_restrict_perm(struct
> > sgx_encl *encl,
> > >  	unsigned long addr;
> > >  	unsigned long c;
> > >  	void *epc_virt;
> > > +	int srcu_idx;
> > >  	int ret;
> > >
> > >  	memset(&secinfo, 0, sizeof(secinfo)); @@ -960,6 +982,12 @@ static
> > > long sgx_enclave_restrict_perm(struct sgx_encl *encl,
> > >  	vm_prot = vm_prot_from_secinfo(secinfo_perm);
> > >
> > >  	for (c = 0 ; c < modp->length; c += PAGE_SIZE) {
> > > +		srcu_idx = srcu_read_lock(&sgx_lock_epc_srcu);
> > > +		if (sgx_epc_is_locked()) {
> > > +			srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > > +			return -EBUSY;
> > > +		}
> > > +
> > >  		addr = encl->base + modp->offset + c;
> > >
> > >  		sgx_direct_reclaim();
> > > @@ -1049,6 +1077,7 @@ static long sgx_enclave_restrict_perm(struct
> > > sgx_encl *encl,
> > >
> > >  		sgx_mark_page_reclaimable(entry->epc_page);
> > >  		mutex_unlock(&encl->lock);
> > > +		srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > >  	}
> > >
> > >  	ret = 0;
> > > @@ -1060,6 +1089,7 @@ static long sgx_enclave_restrict_perm(struct
> > sgx_encl *encl,
> > >  	sgx_mark_page_reclaimable(entry->epc_page);
> > >  out_unlock:
> > >  	mutex_unlock(&encl->lock);
> > > +	srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > >  out:
> > >  	modp->count = c;
> > >
> > > @@ -1143,6 +1173,7 @@ static long sgx_enclave_modt(struct sgx_encl
> > *encl,
> > >  	unsigned long addr;
> > >  	unsigned long c;
> > >  	void *epc_virt;
> > > +	int srcu_idx;
> > >  	int ret;
> > >
> > >  	/*
> > > @@ -1156,6 +1187,12 @@ static long sgx_enclave_modt(struct sgx_encl
> > *encl,
> > >  	secinfo.flags = page_type << 8;
> > >
> > >  	for (c = 0 ; c < modt->length; c += PAGE_SIZE) {
> > > +		srcu_idx = srcu_read_lock(&sgx_lock_epc_srcu);
> > > +		if (sgx_epc_is_locked()) {
> > > +			srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > > +			return -EBUSY;
> > > +		}
> > > +
> > >  		addr = encl->base + modt->offset + c;
> > >
> > >  		sgx_direct_reclaim();
> > > @@ -1255,6 +1292,7 @@ static long sgx_enclave_modt(struct sgx_encl
> > *encl,
> > >  		entry->type = page_type;
> > >
> > >  		mutex_unlock(&encl->lock);
> > > +		srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > >  	}
> > >
> > >  	ret = 0;
> > > @@ -1265,6 +1303,7 @@ static long sgx_enclave_modt(struct sgx_encl
> > *encl,
> > >  	entry->vm_run_prot_bits = run_prot_restore;
> > >  out_unlock:
> > >  	mutex_unlock(&encl->lock);
> > > +	srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > >  out:
> > >  	modt->count = c;
> > >
> > > @@ -1350,12 +1389,19 @@ static long sgx_encl_remove_pages(struct
> > sgx_encl *encl,
> > >  	unsigned long addr;
> > >  	unsigned long c;
> > >  	void *epc_virt;
> > > +	int srcu_idx;
> > >  	int ret;
> > >
> > >  	memset(&secinfo, 0, sizeof(secinfo));
> > >  	secinfo.flags = SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_X;
> > >
> > >  	for (c = 0 ; c < params->length; c += PAGE_SIZE) {
> > > +		srcu_idx = srcu_read_lock(&sgx_lock_epc_srcu);
> > > +		if (sgx_epc_is_locked()) {
> > > +			srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > > +			return -EBUSY;
> > > +		}
> > > +
> > >  		addr = encl->base + params->offset + c;
> > >
> > >  		sgx_direct_reclaim();
> > > @@ -1411,6 +1457,7 @@ static long sgx_encl_remove_pages(struct
> > sgx_encl *encl,
> > >  		kfree(entry);
> > >
> > >  		mutex_unlock(&encl->lock);
> > > +		srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > >  	}
> > >
> > >  	ret = 0;
> > > @@ -1418,6 +1465,7 @@ static long sgx_encl_remove_pages(struct
> > > sgx_encl *encl,
> > >
> > >  out_unlock:
> > >  	mutex_unlock(&encl->lock);
> > > +	srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > >  out:
> > >  	params->count = c;
> > >
> > > diff --git a/arch/x86/kernel/cpu/sgx/main.c
> > > b/arch/x86/kernel/cpu/sgx/main.c index 545da16bb3ea..99c86b77ca8f
> > > 100644
> > > --- a/arch/x86/kernel/cpu/sgx/main.c
> > > +++ b/arch/x86/kernel/cpu/sgx/main.c
> > > @@ -23,6 +23,17 @@ static int sgx_nr_epc_sections;  static struct
> > > task_struct *ksgxd_tsk;  static DECLARE_WAIT_QUEUE_HEAD(ksgxd_waitq);
> > >  static DEFINE_XARRAY(sgx_epc_address_space);
> > > +/*
> > > + * The flag sgx_epc_locked prevents any new SGX flows that
> > > + * may attempt to allocate a new EPC page.
> > > + */
> > > +static bool __rcu sgx_epc_locked;
> > > +/*
> > > + * By synchronizing around sgx_epc_locked SRCU ensures that any
> > > +executing
> > > + * SGX flows have completed before proceeding with an SVN update. New
> > > +SGX flows
> > > + * will be prevented from starting during an SVN update.
> > > + */
> > > +DEFINE_SRCU(sgx_lock_epc_srcu);
> > >
> > >  /*
> > >   * These variables are part of the state of the reclaimer, and must
> > > be accessed @@ -378,6 +389,8 @@ void sgx_direct_reclaim(void)
> > >
> > >  static int ksgxd(void *p)
> > >  {
> > > +	int srcu_idx;
> > > +
> > >  	set_freezable();
> > >
> > >  	/*
> > > @@ -398,9 +411,15 @@ static int ksgxd(void *p)
> > >  				     kthread_should_stop() ||
> > >
> > sgx_should_reclaim(SGX_NR_HIGH_PAGES));
> > >
> > > +		srcu_idx = srcu_read_lock(&sgx_lock_epc_srcu);
> > > +		if (sgx_epc_is_locked())
> > > +			goto maybe_resched;
> > > +
> > >  		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
> > >  			sgx_reclaim_pages();
> > >
> > > +maybe_resched:
> > > +		srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > >  		cond_resched();
> > >  	}
> > >
> > > @@ -943,3 +962,21 @@ static int __init sgx_init(void)  }
> > >
> > >  device_initcall(sgx_init);
> > > +
> > > +static void sgx_lock_epc(void)
> > > +{
> > > +	sgx_epc_locked = true;
> > > +	synchronize_srcu(&sgx_lock_epc_srcu);
> > > +}
> > > +
> > > +static void sgx_unlock_epc(void)
> > > +{
> > > +	sgx_epc_locked = false;
> > > +	synchronize_srcu(&sgx_lock_epc_srcu);
> > > +}
> > > +
> > > +bool sgx_epc_is_locked(void)
> > > +{
> > > +	lockdep_assert_held(&sgx_lock_epc_srcu);
> > > +	return sgx_epc_locked;
> > > +}
> > > diff --git a/arch/x86/kernel/cpu/sgx/virt.c
> > > b/arch/x86/kernel/cpu/sgx/virt.c index 6a77a14eee38..e953816d7c8b
> > > 100644
> > > --- a/arch/x86/kernel/cpu/sgx/virt.c
> > > +++ b/arch/x86/kernel/cpu/sgx/virt.c
> > > @@ -75,10 +75,21 @@ static vm_fault_t sgx_vepc_fault(struct vm_fault
> > > *vmf)  {
> > >  	struct vm_area_struct *vma = vmf->vma;
> > >  	struct sgx_vepc *vepc = vma->vm_private_data;
> > > +	int srcu_idx;
> > >  	int ret;
> > >
> > >  	mutex_lock(&vepc->lock);
> > > +	srcu_idx = srcu_read_lock(&sgx_lock_epc_srcu);
> > > +
> > > +	if (sgx_epc_is_locked()) {
> > > +		ret = -EBUSY;
> > > +		goto out_unlock;
> > > +	}
> > > +
> > >  	ret = __sgx_vepc_fault(vepc, vma, vmf->address);
> > > +
> > > +out_unlock:
> > > +	srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > >  	mutex_unlock(&vepc->lock);
> > >
> > >  	if (!ret)
> > > @@ -331,6 +342,7 @@ int __init sgx_vepc_init(void)  int
> > > sgx_virt_ecreate(struct sgx_pageinfo *pageinfo, void __user *secs,
> > >  		     int *trapnr)
> > >  {
> > > +	int srcu_idx;
> > >  	int ret;
> > >
> > >  	/*
> > > @@ -347,6 +359,12 @@ int sgx_virt_ecreate(struct sgx_pageinfo *pageinfo,
> > void __user *secs,
> > >  	if (WARN_ON_ONCE(!access_ok(secs, PAGE_SIZE)))
> > >  		return -EINVAL;
> > >
> > > +	srcu_idx = srcu_read_lock(&sgx_lock_epc_srcu);
> > > +	if (sgx_epc_is_locked()) {
> > > +		srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > > +		return -EBUSY;
> > > +	}
> > > +
> > >  	__uaccess_begin();
> > >  	ret = __ecreate(pageinfo, (void *)secs);
> > >  	__uaccess_end();
> > > @@ -356,6 +374,8 @@ int sgx_virt_ecreate(struct sgx_pageinfo *pageinfo,
> > void __user *secs,
> > >  		return -EFAULT;
> > >  	}
> > >
> > > +	srcu_read_unlock(&sgx_lock_epc_srcu, srcu_idx);
> > > +
> > >  	/* ECREATE doesn't return an error code, it faults or succeeds. */
> > >  	WARN_ON_ONCE(ret);
> > >  	return 0;
> > > --
> > > 2.17.1
> > >
> > 
> > This series is broken. It does not apply on top of tip/x86/sgx. Also you
> > forgot CC to me.
> 
> I'm sincerely sorry for not cc to you, I'm aware of that after sending out :- )

Apologies, I did not mean it like that. Just mentioning that I can look
into this :-)

> Yes, it requires to apply the following SGX2 v2 patches to tip/x86/sgx, prior to
> this series. As I mentioned in cover letter, SGX2 introduces new SGX instructions
> and flows, which should be handled during SVN update.
> 
> The v2 of SGX2 support patch set, with 32 patches in total, refer to the cover letter:
> https://lore.kernel.org/lkml/cover.1644274683.git.reinette.chatre@intel.com/
> The two additional patches SGX2 support requires:
> "x86/sgx: Add poison handling to reclaimer"
>  https://lore.kernel.org/linux-sgx/dcc95eb2aaefb042527ac50d0a50738c7c160dac.1643830353.git.reinette.chatre@intel.com/
> "x86/sgx: Silence softlockup detection when releasing large enclaves"
>  https://lore.kernel.org/linux-sgx/b5e9f218064aa76e3026f778e1ad0a1d823e3db8.1643133224.git.reinette.chatre@intel.com/

Why don't you pick the dependent patches from that patch set and put them
to this one? It does not matter if two patch sets contain same patches. If
this gets merged first, then Reinette's job will be easier, and vice versa.
Tags make sure that everyone gets what they deserve from their
contribution.

Otherwise for instance giving a tested-by is impossible. You have to root
this to the mainline, or at least to x86 tip.git.

BR, Jarkko
