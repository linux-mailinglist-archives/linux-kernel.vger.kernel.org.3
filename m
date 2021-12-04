Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466C846885A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 00:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbhLDXsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 18:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhLDXsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 18:48:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE1AC061751;
        Sat,  4 Dec 2021 15:45:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9758AB80CF7;
        Sat,  4 Dec 2021 23:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF02C341C0;
        Sat,  4 Dec 2021 23:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638661511;
        bh=nuNTOL1BaBExRZs/3S98jw5aqPpl8wKDRzZX9Wt+JP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LRKm2CoKuJlPiVj33ejBMciSIT25rJSrH6P2M+iJwNvzh1Sw5Oa2zPkyfSj3GBSu3
         XmBAB+ON3P5tcxyDyh1MLwXQn1aawG8JxFLHsnvLqQmPFUcJf9JsvN8ENNLiM4psCk
         Dhxw8IzG8fgrZjFc3TRB5FqRCILegxu+vqEoV6Ix70uPGgGAgqMffvtoyfgiEoeRcU
         h1QGJOq0PtcDy2xEnsTVq3x66vcg0O1Ptpd5tGwkII4Vp8fi7QM85tEd4cFv10Itxs
         erCG7lU/0Nhc+dz9e/ROka9b7uoUhbDhtuZSMdnIA/DJ91ZtBD6qB0bW1ZvJMH2ipC
         cXzwqtsP1pe3Q==
Date:   Sun, 5 Dec 2021 01:45:07 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/25] x86/sgx: Support modifying SGX page type
Message-ID: <Yav9g4+L8zg48DRf@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <c0f04a8f7e1afd9e9319bb9f283db9a3187f7abc.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0f04a8f7e1afd9e9319bb9f283db9a3187f7abc.1638381245.git.reinette.chatre@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 11:23:14AM -0800, Reinette Chatre wrote:
> Every enclave contains one or more Thread Control Structures (TCS). The
> TCS contains meta-data used by the hardware to save and restore thread
> specific information when entering/exiting the enclave. With SGX1 an
> enclave needs to be created with enough TCSs to support the largest
> number of threads expecting to use the enclave and enough enclave pages
> to meet all its anticipated memory demands. In SGX1 all pages remain in
> the enclave until the enclave is unloaded.
> 
> Earlier changes added support for the SGX2 feature where pages can be
> added dynamically to an initialized enclave.

Please remove this paragraph, i.e. do not tie the commit order like
this.
> 
> SGX2 introduces a new function, ENCLS[EMODT], that is used to change
> the type of an enclave page from a regular (SGX_PAGE_TYPE_REG) enclave
> page to a TCS (SGX_PAGE_TYPE_TCS) page or change the type from a
> regular (SGX_PAGE_TYPE_REG) or TCS (SGX_PAGE_TYPE_TCS)
> page to a trimmed (SGX_PAGE_TYPE_TRIM) page (setting it up for later
> removal).
> 
> With the existing support of dynamically adding regular enclave pages
> to an initialized enclave and changing the page type to TCS it is
> possible to dynamically increase the number of threads supported by an
> enclave.
> 
> Changing the enclave page type to SGX_PAGE_TYPE_TRIM is the first step
> of dynamically removing pages from an initialized enclave. The complete
> page removal flow is:
> 1) Change the type of the pages to be removed to SGX_PAGE_TYPE_TRIM
>    using the ioctl introduced here.
> 2) Approve the page removal by running ENCLU[EACCEPT] from within
>    the enclave.
> 3) Initiate actual page removal using the new ioctl introduced in the
>    following patch.
> 
> Support changing SGX enclave page types with a new ioctl. With this

What is "a new ioctl"? Why not just write "Add <ioctl name>""?

> ioctl the user specifies a page range and the enclave page type to be
> applied to all pages in the provided range. The ioctl itself can return
> an error code based on failures encountered by the OS. It is also
> possible for SGX specific failures to be encountered.  Add a result
> output parameter to communicate the SGX return code. It is
> possible for the enclave page type change request to fail on any page
> within the provided range. Support partial success by returning
> the number of pages that were successfully changed.
> 
> After the page type is changed to SGX_PAGE_TYPE_TRIM the page continues
> to be accessible from the OS perspective with page table entries and
> internal state. The page may be moved to swap. Any invalid access
> (any access except ENCLU[EACCEPT]) will encounter a page fault with
> SGX flag set in error code until the page is removed. Removal of
> trimmed enclave pages on user request will be supported in following
> patch. Trimmed enclave pages are also removed when enclave is unloaded.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

This is lacking discussion of EPCM interaction, most importanly
.MODIFY field of an EPCM entry.

> ---
>  arch/x86/include/uapi/asm/sgx.h |  19 +++
>  arch/x86/kernel/cpu/sgx/ioctl.c | 235 ++++++++++++++++++++++++++++++++
>  2 files changed, 254 insertions(+)
> 
> diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
> index 24bebc31e336..f70caccd166c 100644
> --- a/arch/x86/include/uapi/asm/sgx.h
> +++ b/arch/x86/include/uapi/asm/sgx.h
> @@ -31,6 +31,8 @@ enum sgx_page_flags {
>  	_IO(SGX_MAGIC, 0x04)
>  #define SGX_IOC_PAGE_MODP \
>  	_IOWR(SGX_MAGIC, 0x05, struct sgx_page_modp)
> +#define SGX_IOC_PAGE_MODT \
> +	_IOWR(SGX_MAGIC, 0x06, struct sgx_page_modt)

I'd suggest to change this as SGX_IOC_ENCLAVE_MODIFY_TYPE.

>  
>  /**
>   * struct sgx_enclave_create - parameter structure for the
> @@ -96,6 +98,23 @@ struct sgx_page_modp {
>  	__u64 count;
>  };
>  
> +/**
> + * struct sgx_page_modt - parameter structure for the %SGX_IOC_PAGE_MODT ioctl
> + * @offset:	starting page offset (page aligned relative to enclave base
> + *		address defined in SECS)
> + * @length:	length of memory (multiple of the page size)
> + * @type:	new type of pages in range described by @offset and @length
> + * @result:	SGX result code of ENCLS[EMODT] function
> + * @count:	bytes successfully changed (multiple of page size)
> + */
> +struct sgx_page_modt {
> +	__u64 offset;
> +	__u64 length;
> +	__u64 type;
> +	__u64 result;
> +	__u64 count;
> +};
> +
>  struct sgx_enclave_run;
>  
>  /**
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index de0bf68ee842..a952d608ab35 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -914,6 +914,238 @@ static long sgx_ioc_page_modp(struct sgx_encl *encl, void __user *arg)
>  	return ret;
>  }
>  
> +/**
> + * sgx_page_modt - Modify type of SGX enclave pages
> + * @encl:	Enclave to which the pages belong.
> + * @modt:	Checked parameters from user about which pages need modifying
> + *		and their new type.
> + *
> + * Ability to change the enclave page type supports the following use cases:
> + * * It is possible to add TCS pages to enclave by changing the type of
> + * regular pages (SGX_PAGE_TYPE_REG) to TCS (SGX_PAGE_TYPE_TCS) pages. With
> + * this support the number of threads supported by an initialized enclave
> + * can be increased dynamically.
> + * * Regular or TCS pages can dynamically be removed from an initialized
> + * enclave by changing the page type to SGX_PAGE_TYPE_TRIM. Changing the
> + * page type to SGX_PAGE_TYPE_TRIM marks the page for removal with actual
> + * removal done by handler of %SGX_IOC_PAGE_REMOVE ioctl called after
> + * ENCLU[EACCEPT] is run on SGX_PAGE_TYPE_TRIM page from within the enclave.
> + *
> + * Return:
> + * - 0:		Success
> + * - -errno:	Otherwise
> + */
> +static long sgx_page_modt(struct sgx_encl *encl, struct sgx_page_modt *modt)
> +{
> +	unsigned long max_prot_restore, run_prot_restore;
> +	enum sgx_page_type page_type;
> +	struct sgx_encl_page *entry;
> +	struct sgx_secinfo secinfo;
> +	unsigned long prot;
> +	unsigned long addr;
> +	unsigned long c;
> +	void *epc_virt;
> +	int ret;
> +
> +	page_type = modt->type & SGX_PAGE_TYPE_MASK;
> +
> +	/*
> +	 * The only new page types allowed by hardware are PT_TCS and PT_TRIM.
> +	 */
> +	if (page_type != SGX_PAGE_TYPE_TCS && page_type != SGX_PAGE_TYPE_TRIM)
> +		return -EINVAL;
> +
> +	memset(&secinfo, 0, sizeof(secinfo));
> +
> +	secinfo.flags = page_type << 8;
> +
> +	for (c = 0 ; c < modt->length; c += PAGE_SIZE) {
> +		addr = encl->base + modt->offset + c;
> +
> +		mutex_lock(&encl->lock);
> +
> +		entry = sgx_encl_load_page(encl, addr);
> +		if (IS_ERR(entry)) {
> +			ret = PTR_ERR(entry) == -EBUSY ? -EAGAIN : -EFAULT;
> +			goto out_unlock;
> +		}
> +
> +		/*
> +		 * Borrow the logic from the Intel SDM. Regular pages
> +		 * (SGX_PAGE_TYPE_REG) can change type to SGX_PAGE_TYPE_TCS
> +		 * or SGX_PAGE_TYPE_TRIM but TCS pages can only be trimmed.
> +		 * CET pages not supported yet.
> +		 */
> +		if (!(entry->type == SGX_PAGE_TYPE_REG ||
> +		      (entry->type == SGX_PAGE_TYPE_TCS &&
> +		       page_type == SGX_PAGE_TYPE_TRIM))) {
> +			ret = -EINVAL;
> +			goto out_unlock;
> +		}
> +
> +		max_prot_restore = entry->vm_max_prot_bits;
> +		run_prot_restore = entry->vm_run_prot_bits;
> +
> +		/*
> +		 * Once a regular page becomes a TCS page it cannot be
> +		 * changed back. So the maximum allowed protection reflects
> +		 * the TCS page that is always RW from OS perspective but
> +		 * will be inaccessible from within enclave. Before doing
> +		 * so, do make sure that the new page type continues to
> +		 * respect the originally vetted page permissions.
> +		 */
> +		if (entry->type == SGX_PAGE_TYPE_REG &&
> +		    page_type == SGX_PAGE_TYPE_TCS) {
> +			if (~entry->vm_max_prot_bits & (VM_READ | VM_WRITE)) {
> +				ret = -EPERM;
> +				goto out_unlock;
> +			}
> +			prot = PROT_READ | PROT_WRITE;
> +			entry->vm_max_prot_bits = calc_vm_prot_bits(prot, 0);
> +			entry->vm_run_prot_bits = entry->vm_max_prot_bits;
> +
> +			/*
> +			 * Prevent page from being reclaimed while mutex
> +			 * is released.
> +			 */
> +			if (sgx_unmark_page_reclaimable(entry->epc_page)) {
> +				ret = -EAGAIN;
> +				goto out_entry_changed;
> +			}
> +
> +			/*
> +			 * Do not keep encl->lock because of dependency on
> +			 * mmap_lock acquired in sgx_zap_enclave_ptes().
> +			 */
> +			mutex_unlock(&encl->lock);
> +
> +			sgx_zap_enclave_ptes(encl, addr);
> +
> +			mutex_lock(&encl->lock);
> +
> +			sgx_mark_page_reclaimable(entry->epc_page);
> +		}
> +
> +		/* Change EPC type */
> +		epc_virt = sgx_get_epc_virt_addr(entry->epc_page);
> +		ret = __emodt(&secinfo, epc_virt);
> +		if (encls_faulted(ret)) {
> +			/*
> +			 * All possible faults should be avoidable:
> +			 * parameters have been checked, will only change
> +			 * valid page types, and no concurrent
> +			 * SGX1/SGX2 ENCLS instructions since these are
> +			 * protected with mutex.
> +			 */
> +			pr_err_once("EMODT encountered exception %d\n",
> +				    ENCLS_TRAPNR(ret));
> +			ret = -EFAULT;
> +			goto out_entry_changed;
> +		}
> +		if (encls_failed(ret)) {
> +			modt->result = ret;
> +			ret = -EFAULT;
> +			goto out_entry_changed;
> +		}
> +
> +		epc_virt = sgx_get_epc_virt_addr(encl->secs.epc_page);
> +		ret = __etrack(epc_virt);
> +		if (ret) {
> +			/*
> +			 * ETRACK only fails when there is an OS issue. For
> +			 * example, two consecutive ETRACK was sent without
> +			 * completed IPI between.
> +			 */
> +			pr_err_once("ETRACK returned %d (0x%x)", ret, ret);
> +			/*
> +			 * Send IPIs to kick CPUs out of the enclave and
> +			 * try ETRACK again.
> +			 */
> +			on_each_cpu_mask(sgx_encl_cpumask(encl),
> +					 sgx_ipi_cb, NULL, 1);
> +			ret = __etrack(epc_virt);
> +			if (ret) {
> +				pr_err_once("ETRACK repeat returned %d (0x%x)",
> +					    ret, ret);
> +				ret = -EFAULT;
> +				goto out_unlock;
> +			}
> +		}
> +		on_each_cpu_mask(sgx_encl_cpumask(encl), sgx_ipi_cb, NULL, 1);
> +
> +		entry->type = page_type;
> +
> +		mutex_unlock(&encl->lock);
> +	}
> +
> +	ret = 0;
> +	goto out;
> +
> +out_entry_changed:
> +	entry->vm_max_prot_bits = max_prot_restore;
> +	entry->vm_run_prot_bits = run_prot_restore;
> +out_unlock:
> +	mutex_unlock(&encl->lock);
> +out:
> +	modt->count = c;
> +
> +	return ret;
> +}
> +
> +/**
> + * sgx_ioc_page_modt() - handler for %SGX_IOC_PAGE_MODT
> + * @encl:	an enclave pointer
> + * @arg:	userspace pointer to a &struct sgx_page_modt instance
> + *
> + * Return:
> + * - 0:		Success
> + * - -errno:	Otherwise
> + */
> +static long sgx_ioc_page_modt(struct sgx_encl *encl, void __user *arg)
> +{
> +	struct sgx_page_modt params;
> +	long ret;
> +
> +	/*
> +	 * Ensure that there is a chance the request could succeed:
> +	 * (1) SGX2 is required.
> +	 * (2) Only pages in an initialized enclave could be modified.
> +	 */
> +	if (!(cpu_feature_enabled(X86_FEATURE_SGX2)))
> +		return -ENODEV;
> +
> +	if (!test_bit(SGX_ENCL_INITIALIZED, &encl->flags))
> +		return -EINVAL;
> +
> +	/*
> +	 * Obtain parameters from user and perform sanity checks.
> +	 */
> +	if (copy_from_user(&params, arg, sizeof(params)))
> +		return -EFAULT;
> +
> +	if (!IS_ALIGNED(params.offset, PAGE_SIZE))
> +		return -EINVAL;
> +
> +	if (!params.length || params.length & (PAGE_SIZE - 1))
> +		return -EINVAL;
> +
> +	if (params.offset + params.length - PAGE_SIZE >= encl->size)
> +		return -EINVAL;
> +
> +	if (params.type & ~SGX_PAGE_TYPE_MASK)
> +		return -EINVAL;
> +
> +	if (params.result || params.count)
> +		return -EINVAL;
> +
> +	ret = sgx_page_modt(encl, &params);
> +
> +	if (copy_to_user(arg, &params, sizeof(params)))
> +		return -EFAULT;
> +
> +	return ret;
> +}
> +
>  long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>  {
>  	struct sgx_encl *encl = filep->private_data;
> @@ -938,6 +1170,9 @@ long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>  	case SGX_IOC_PAGE_MODP:
>  		ret = sgx_ioc_page_modp(encl, (void __user *)arg);
>  		break;
> +	case SGX_IOC_PAGE_MODT:
> +		ret = sgx_ioc_page_modt(encl, (void __user *)arg);
> +		break;
>  	default:
>  		ret = -ENOIOCTLCMD;
>  		break;
> -- 
> 2.25.1
> 

/Jarkko
