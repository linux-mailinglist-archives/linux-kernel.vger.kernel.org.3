Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450634BD2F7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 02:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245387AbiBUAtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 19:49:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiBUAtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 19:49:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF3A4B40F;
        Sun, 20 Feb 2022 16:49:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C047CB80E3B;
        Mon, 21 Feb 2022 00:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CBAC340E8;
        Mon, 21 Feb 2022 00:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645404538;
        bh=/hU9LCEy9Xh76wJHv7y7iqAA/IAFwAHzGXM7HlVd6XQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dry2Dm4RVlmZlUQev2PbOKFZBcu3WinyGMuwOJDGPpcq+Jer8tcoX4NoTdAjspsFT
         4Yt/7yOe4Ms1stqztNdswWvF6nsGw4j97eZrGFPrmZdhYUc69hvYCYnXfNEE7wKkFu
         DeNx9diu0Lwb1ddSL2TgNwGMrogykxLWTRovwZcWOCA7hi0f8MjExE391szunG4qGS
         dV3feOXCc/SabygdSXujWbvv0l73KdDniQP9O3bHJgtEJPRsJE51U+9eYdxucqsI6Q
         PYoV7ryGIm4VIlIacdzGykZsIfvUf+ROaj56C5ywgZ7WUNJneZ8GXQ2WlibY5IO6w+
         aB6jbYB4+SjPA==
Date:   Mon, 21 Feb 2022 01:49:36 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Message-ID: <YhLhoMFPyOFZ2fsX@iki.fi>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 04:45:38PM -0800, Reinette Chatre wrote:
> In the initial (SGX1) version of SGX, pages in an enclave need to be
> created with permissions that support all usages of the pages, from the
> time the enclave is initialized until it is unloaded. For example,
> pages used by a JIT compiler or when code needs to otherwise be
> relocated need to always have RWX permissions.
> 
> SGX2 includes a new function ENCLS[EMODPR] that is run from the kernel
> and can be used to restrict the EPCM permissions of regular enclave
> pages within an initialized enclave.
> 
> Introduce ioctl() SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS to support
> restricting EPCM permissions. With this ioctl() the user specifies
> a page range and the permissions to be applied to all pages in
> the provided range. After checking the new permissions (more detail
> below) the page table entries are reset and any new page
> table entries will contain the new, restricted, permissions.
> ENCLS[EMODPR] is run to restrict the EPCM permissions followed by
> the ENCLS[ETRACK] flow that will ensure no cached
> linear-to-physical address mappings to the changed pages remain.
> 
> It is possible for the permission change request to fail on any
> page within the provided range, either with an error encountered
> by the kernel or by the SGX hardware while running
> ENCLS[EMODPR]. To support partial success the ioctl() returns an
> error code based on failures encountered by the kernel as well
> as two result output parameters: one for the number of pages
> that were successfully changed and one for the SGX return code.
> 
> Checking user provided new permissions
> ======================================
> 
> Enclave page permission changes need to be approached with care and
> for this reason permission changes are only allowed if the new
> permissions are the same or more restrictive that the vetted
> permissions. No additional checking is done to ensure that the
> permissions are actually being restricted. This is because the
> enclave may have relaxed the EPCM permissions from within
> the enclave without letting the kernel know. An attempt to relax
> permissions using this call will be ignored by the hardware.
> 
> For example, together with the support for relaxing of EPCM permissions,
> enclave pages added with the vetted permissions in brackets below
> are allowed to have permissions as follows:
> * (RWX) => RW => R => RX => RWX
> * (RW) => R => RW
> * (RX) => R => RX
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V1:
> - Change terminology to use "relax" instead of "extend" to refer to
>   the case when enclave page permissions are added (Dave).
> - Use ioctl() in commit message (Dave).
> - Add examples on what permissions would be allowed (Dave).
> - Split enclave page permission changes into two ioctl()s, one for
>   permission restricting (SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS)
>   and one for permission relaxing (SGX_IOC_ENCLAVE_RELAX_PERMISSIONS)
>   (Jarkko).
> - In support of the ioctl() name change the following names have been
>   changed:
>   struct sgx_page_modp -> struct sgx_enclave_restrict_perm
>   sgx_ioc_page_modp() -> sgx_ioc_enclave_restrict_perm()
>   sgx_page_modp() -> sgx_enclave_restrict_perm()
> - ioctl() takes entire secinfo as input instead of
>   page permissions only (Jarkko).
> - Fix kernel-doc to include () in function name.
> - Create and use utility for the ETRACK flow.
> - Fixups in comments
> - Move kernel-doc to function that provides documentation for
>   Documentation/x86/sgx.rst.
> - Remove redundant comment.
> - Make explicit which members of struct sgx_enclave_restrict_perm
>   are for output (Dave).
> 
>  arch/x86/include/uapi/asm/sgx.h |  21 +++
>  arch/x86/kernel/cpu/sgx/encl.c  |   4 +-
>  arch/x86/kernel/cpu/sgx/encl.h  |   3 +
>  arch/x86/kernel/cpu/sgx/ioctl.c | 229 ++++++++++++++++++++++++++++++++
>  4 files changed, 255 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
> index 5c678b27bb72..b0ffb80bc67f 100644
> --- a/arch/x86/include/uapi/asm/sgx.h
> +++ b/arch/x86/include/uapi/asm/sgx.h
> @@ -31,6 +31,8 @@ enum sgx_page_flags {
>  	_IO(SGX_MAGIC, 0x04)
>  #define SGX_IOC_ENCLAVE_RELAX_PERMISSIONS \
>  	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_relax_perm)
> +#define SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS \
> +	_IOWR(SGX_MAGIC, 0x06, struct sgx_enclave_restrict_perm)
>  
>  /**
>   * struct sgx_enclave_create - parameter structure for the
> @@ -95,6 +97,25 @@ struct sgx_enclave_relax_perm {
>  	__u64 count;
>  };
>  
> +/**
> + * struct sgx_enclave_restrict_perm - parameters for ioctl
> + *                                    %SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
> + * @offset:	starting page offset (page aligned relative to enclave base
> + *		address defined in SECS)
> + * @length:	length of memory (multiple of the page size)
> + * @secinfo:	address for the SECINFO data containing the new permission bits
> + *		for pages in range described by @offset and @length
> + * @result:	(output) SGX result code of ENCLS[EMODPR] function
> + * @count:	(output) bytes successfully changed (multiple of page size)
> + */
> +struct sgx_enclave_restrict_perm {
> +	__u64 offset;
> +	__u64 length;
> +	__u64 secinfo;
> +	__u64 result;
> +	__u64 count;
> +};
> +
>  struct sgx_enclave_run;
>  
>  /**
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index 8da813504249..a5d4a7efb986 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -90,8 +90,8 @@ static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
>  	return epc_page;
>  }
>  
> -static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
> -						unsigned long addr)
> +struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
> +					 unsigned long addr)
>  {
>  	struct sgx_epc_page *epc_page;
>  	struct sgx_encl_page *entry;
> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
> index cb9f16d457ac..848a28d28d3d 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.h
> +++ b/arch/x86/kernel/cpu/sgx/encl.h
> @@ -120,4 +120,7 @@ void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
>  bool sgx_va_page_full(struct sgx_va_page *va_page);
>  void sgx_encl_free_epc_page(struct sgx_epc_page *page);
>  
> +struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
> +					 unsigned long addr);
> +
>  #endif /* _X86_ENCL_H */
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index 9cc6af404bf6..23bdf558b231 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -894,6 +894,232 @@ static long sgx_ioc_enclave_relax_perm(struct sgx_encl *encl, void __user *arg)
>  	return ret;
>  }
>  
> +/*
> + * Some SGX functions require that no cached linear-to-physical address
> + * mappings are present before they can succeed. Collaborate with
> + * hardware via ENCLS[ETRACK] to ensure that all cached
> + * linear-to-physical address mappings belonging to all threads of
> + * the enclave are cleared. See sgx_encl_cpumask() for details.
> + */
> +static int sgx_enclave_etrack(struct sgx_encl *encl)
> +{
> +	void *epc_virt;
> +	int ret;
> +
> +	epc_virt = sgx_get_epc_virt_addr(encl->secs.epc_page);
> +	ret = __etrack(epc_virt);
> +	if (ret) {
> +		/*
> +		 * ETRACK only fails when there is an OS issue. For
> +		 * example, two consecutive ETRACK was sent without
> +		 * completed IPI between.
> +		 */
> +		pr_err_once("ETRACK returned %d (0x%x)", ret, ret);
> +		/*
> +		 * Send IPIs to kick CPUs out of the enclave and
> +		 * try ETRACK again.
> +		 */
> +		on_each_cpu_mask(sgx_encl_cpumask(encl), sgx_ipi_cb, NULL, 1);
> +		ret = __etrack(epc_virt);
> +		if (ret) {
> +			pr_err_once("ETRACK repeat returned %d (0x%x)",
> +				    ret, ret);
> +			return -EFAULT;
> +		}
> +	}
> +	on_each_cpu_mask(sgx_encl_cpumask(encl), sgx_ipi_cb, NULL, 1);
> +
> +	return 0;
> +}
> +
> +/**
> + * sgx_enclave_restrict_perm() - Restrict EPCM permissions and align OS view
> + * @encl:	Enclave to which the pages belong.
> + * @modp:	Checked parameters from user on which pages need modifying.
> + * @secinfo_perm: New (validated) permission bits.
> + *
> + * Return:
> + * - 0:		Success.
> + * - -errno:	Otherwise.
> + */
> +static long sgx_enclave_restrict_perm(struct sgx_encl *encl,
> +				      struct sgx_enclave_restrict_perm *modp,
> +				      u64 secinfo_perm)
> +{
> +	unsigned long vm_prot, run_prot_restore;
> +	struct sgx_encl_page *entry;
> +	struct sgx_secinfo secinfo;
> +	unsigned long addr;
> +	unsigned long c;
> +	void *epc_virt;
> +	int ret;
> +
> +	memset(&secinfo, 0, sizeof(secinfo));
> +	secinfo.flags = secinfo_perm;
> +
> +	vm_prot = vm_prot_from_secinfo(secinfo_perm);
> +
> +	for (c = 0 ; c < modp->length; c += PAGE_SIZE) {
> +		addr = encl->base + modp->offset + c;
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
> +		 * Changing EPCM permissions is only supported on regular
> +		 * SGX pages. Attempting this change on other pages will
> +		 * result in #PF.
> +		 */
> +		if (entry->type != SGX_PAGE_TYPE_REG) {
> +			ret = -EINVAL;
> +			goto out_unlock;
> +		}
> +
> +		/*
> +		 * Do not verify if current runtime protection bits are what
> +		 * is being requested. The enclave may have relaxed EPCM
> +		 * permissions calls without letting the kernel know and
> +		 * thus permission restriction may still be needed even if
> +		 * from the kernel's perspective the permissions are unchanged.
> +		 */
> +
> +		/* New permissions should never exceed vetted permissions. */
> +		if ((entry->vm_max_prot_bits & vm_prot) != vm_prot) {
> +			ret = -EPERM;
> +			goto out_unlock;
> +		}
> +
> +		/* Make sure page stays around while releasing mutex. */
> +		if (sgx_unmark_page_reclaimable(entry->epc_page)) {
> +			ret = -EAGAIN;
> +			goto out_unlock;
> +		}
> +
> +		/*
> +		 * Change runtime protection before zapping PTEs to ensure
> +		 * any new #PF uses new permissions. EPCM permissions (if
> +		 * needed) not changed yet.
> +		 */
> +		run_prot_restore = entry->vm_run_prot_bits;
> +		entry->vm_run_prot_bits = vm_prot;
> +
> +		mutex_unlock(&encl->lock);
> +		/*
> +		 * Do not keep encl->lock because of dependency on
> +		 * mmap_lock acquired in sgx_zap_enclave_ptes().
> +		 */
> +		sgx_zap_enclave_ptes(encl, addr);
> +
> +		mutex_lock(&encl->lock);
> +
> +		/* Change EPCM permissions. */
> +		epc_virt = sgx_get_epc_virt_addr(entry->epc_page);
> +		ret = __emodpr(&secinfo, epc_virt);
> +		if (encls_faulted(ret)) {
> +			/*
> +			 * All possible faults should be avoidable:
> +			 * parameters have been checked, will only change
> +			 * permissions of a regular page, and no concurrent
> +			 * SGX1/SGX2 ENCLS instructions since these
> +			 * are protected with mutex.
> +			 */
> +			pr_err_once("EMODPR encountered exception %d\n",
> +				    ENCLS_TRAPNR(ret));
> +			ret = -EFAULT;
> +			goto out_prot_restore;
> +		}
> +		if (encls_failed(ret)) {
> +			modp->result = ret;
> +			ret = -EFAULT;
> +			goto out_prot_restore;
> +		}
> +
> +		ret = sgx_enclave_etrack(encl);
> +		if (ret) {
> +			ret = -EFAULT;
> +			goto out_reclaim;
> +		}
> +
> +		sgx_mark_page_reclaimable(entry->epc_page);
> +		mutex_unlock(&encl->lock);
> +	}
> +
> +	ret = 0;
> +	goto out;
> +
> +out_prot_restore:
> +	entry->vm_run_prot_bits = run_prot_restore;
> +out_reclaim:
> +	sgx_mark_page_reclaimable(entry->epc_page);
> +out_unlock:
> +	mutex_unlock(&encl->lock);
> +out:
> +	modp->count = c;
> +
> +	return ret;
> +}
> +
> +/**
> + * sgx_ioc_enclave_restrict_perm() - handler for
> + *                                   %SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
> + * @encl:	an enclave pointer
> + * @arg:	userspace pointer to a &struct sgx_enclave_restrict_perm
> + *		instance
> + *
> + * SGX2 distinguishes between relaxing and restricting the enclave page
> + * permissions maintained by the hardware (EPCM permissions) of pages
> + * belonging to an initialized enclave (after SGX_IOC_ENCLAVE_INIT).
> + *
> + * EPCM permissions cannot be restricted from within the enclave, the enclave
> + * requires the kernel to run the privileged level 0 instructions ENCLS[EMODPR]
> + * and ENCLS[ETRACK]. An attempt to relax EPCM permissions with this call
> + * will be ignored by the hardware.
> + *
> + * Enclave page permissions are not allowed to exceed the maximum vetted
> + * permissions maintained in &struct sgx_encl_page->vm_max_prot_bits.
> + *
> + * Return:
> + * - 0:		Success
> + * - -errno:	Otherwise
> + */
> +static long sgx_ioc_enclave_restrict_perm(struct sgx_encl *encl,
> +					  void __user *arg)
> +{
> +	struct sgx_enclave_restrict_perm params;
> +	u64 secinfo_perm;
> +	long ret;
> +
> +	ret = sgx_ioc_sgx2_ready(encl);
> +	if (ret)
> +		return ret;
> +
> +	if (copy_from_user(&params, arg, sizeof(params)))
> +		return -EFAULT;
> +
> +	if (sgx_validate_offset_length(encl, params.offset, params.length))
> +		return -EINVAL;
> +
> +	ret = sgx_perm_from_user_secinfo((void __user *)params.secinfo,
> +					 &secinfo_perm);
> +	if (ret)
> +		return ret;
> +
> +	if (params.result || params.count)
> +		return -EINVAL;
> +
> +	ret = sgx_enclave_restrict_perm(encl, &params, secinfo_perm);
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
> @@ -918,6 +1144,9 @@ long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>  	case SGX_IOC_ENCLAVE_RELAX_PERMISSIONS:
>  		ret = sgx_ioc_enclave_relax_perm(encl, (void __user *)arg);
>  		break;
> +	case SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS:
> +		ret = sgx_ioc_enclave_restrict_perm(encl, (void __user *)arg);
> +		break;
>  	default:
>  		ret = -ENOIOCTLCMD;
>  		break;
> -- 
> 2.25.1
> 

Just a suggestion but these might be a bit less cluttered explanations of
the fields:

/// SGX_IOC_ENCLAVE_RELAX_PERMISSIONS parameter structure
#[repr(C)]
pub struct RelaxPermissions {
    /// In: starting page offset
    offset: u64,
    /// In: length of the address range (multiple of the page size)
    length: u64,
    /// In: SECINFO containing the relaxed permissions
    secinfo: u64,
    /// Out: length of the address range successfully changed
    count: u64,
};

/// SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS parameter structure
#[repr(C)]
pub struct RestrictPermissions {
    /// In: starting page offset
    offset: u64,
    /// In: length of the address range (multiple of the page size)
    length: u64,
    /// In: SECINFO containing the restricted permissions
    secinfo: u64,
    /// In: ENCLU[EMODPR] return value
    result: u64,
    /// Out: length of the address range successfully changed
    count: u64,
};

I can live with the current ones too but I rewrote them so that I can
quickly make sense of the fields later. It's Rust code but the point is
the documentation...

Also, it should not be too much trouble to use the struct in user space
code even if the struct names are struct sgx_enclave_relax_permissions and
struct sgx_enclave_restrict_permissions, given that you most likely have
exactly single call-site in the run-time.

Other than that, looks quite good.

BR, Jarkko
