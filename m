Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3044CD097
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbiCDJBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiCDJA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:00:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF70E123433;
        Fri,  4 Mar 2022 01:00:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CAAEB827B3;
        Fri,  4 Mar 2022 09:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C785FC340E9;
        Fri,  4 Mar 2022 09:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646384407;
        bh=MTRRZycgyX27cftet2AcMZPMA/KWOX/3CGZ18ZCkcpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q78AWocaanHuKbB8814KYZs3VFrtxn/0QsjKxU8QIE8QSD+RjFKk7WxY37KTgR8vh
         Y+F1xdTSrCMpNNi0CYpKHH/IQ+5KlQfDe+kQCT/V5E6UbVm1YtWr2Fs3Abvgrh9iBY
         7i1dbsPTpThfd2a27W5SU6qyBe5xmSCs9roTz3ao5SgjNnKUTnAwhFrfE6YftnvZiP
         uCwY77/pu+IKMgQ3Cac56ccJ2fB3BmpV0/N/bg8ICUHq8tAS8V25qw7wr+uwVDzS61
         ZcYH+FmY2qlErtY0GiDkf8i7sdMPxGuUl9Iu5ricacMaGio/3Jf0YzoXbSueSwIa5q
         Z6VRKg05giQbw==
Date:   Fri, 4 Mar 2022 10:59:26 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 15/32] x86/sgx: Support relaxing of enclave page
 permissions
Message-ID: <YiHU7kHM6IqUJl8n@iki.fi>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <f0029cda125be9eb4eb2e051ab41d500081c6e2c.1644274683.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0029cda125be9eb4eb2e051ab41d500081c6e2c.1644274683.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 04:45:37PM -0800, Reinette Chatre wrote:
> In the initial (SGX1) version of SGX, pages in an enclave need to be
> created with permissions that support all usages of the pages, from
> the time the enclave is initialized until it is unloaded. For example,
> pages used by a JIT compiler or when code needs to otherwise be
> relocated need to always have RWX permissions.
> 
> With the SGX2 function ENCLU[EMODPE] an enclave is able to relax
> the EPCM permissions of its pages after the enclave is initialized.
> Relaxing EPCM permissions is not possible from outside the enclave,
> including from the kernel. The kernel does control the PTEs though
> and the enclave still depends on the kernel to install PTEs with the
> new relaxed permissions before it (the enclave) can access the pages
> using the new permissions.
> 
> Introduce ioctl() SGX_IOC_ENCLAVE_RELAX_PERMISSIONS to support
> relaxing of EPCM permissions done from within the enclave. With
> this ioctl() the user specifies a page range and the permissions to
> be applied to all pages in the provided range. After checking
> the new permissions (more detail below) the PTEs are reset and
> it is ensured that any new PTEs will contain the new, relaxed,
> permissions.
> 
> The permission change request could fail on any page within the
> provided range. To support partial success the ioctl() returns
> an error code based on failures encountered by the kernel and
> the number of pages that were successfully changed.
> 
> Checking user provided new permissions
> ======================================
> 
> Enclave page permission changes need to be approached with care and
> for this reason permission changes are only allowed if
> the new permissions are the same or more restrictive that the
> vetted permissions. Thus, even though an enclave is able to relax
> the EPCM permissions of its pages beyond what was originally vetted,
> the kernel will not. The kernel will only install PTEs that respect
> the vetted enclave page permissions.
> 
> For example, enclave pages with vetted EPCM permissions in brackets
> below are allowed to have PTE permissions as follows:
> * (RWX) R => RW => RX => RWX
> * (RW) R => RW
> * (RX) R => RX
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
>   struct sgx_page_modp -> struct sgx_enclave_relax_perm
>   sgx_ioc_page_modp() -> sgx_ioc_enclave_relax_perm()
>   sgx_page_modp() -> sgx_enclave_relax_perm()
> - ioctl() takes entire secinfo as input instead of
>   page permissions only (Jarkko).
> - Fix kernel-doc to include () in function name.
> - Introduce small helper to check for SGX2 readiness instead of
>   duplicating the same two checks in every SGX2 supporting ioctl().
> - Fixups in comments
> - Move kernel-doc to function that provides documentation for
>   Documentation/x86/sgx.rst.
> - Remove redundant comment.
> - Make explicit which member of struct sgx_enclave_relax_perm is
>   for output (Dave).
> 
>  arch/x86/include/uapi/asm/sgx.h |  19 +++
>  arch/x86/kernel/cpu/sgx/ioctl.c | 199 ++++++++++++++++++++++++++++++++
>  2 files changed, 218 insertions(+)
> 
> diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
> index f4b81587e90b..5c678b27bb72 100644
> --- a/arch/x86/include/uapi/asm/sgx.h
> +++ b/arch/x86/include/uapi/asm/sgx.h
> @@ -29,6 +29,8 @@ enum sgx_page_flags {
>  	_IOW(SGX_MAGIC, 0x03, struct sgx_enclave_provision)
>  #define SGX_IOC_VEPC_REMOVE_ALL \
>  	_IO(SGX_MAGIC, 0x04)
> +#define SGX_IOC_ENCLAVE_RELAX_PERMISSIONS \
> +	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_relax_perm)
>  
>  /**
>   * struct sgx_enclave_create - parameter structure for the
> @@ -76,6 +78,23 @@ struct sgx_enclave_provision {
>  	__u64 fd;
>  };
>  
> +/**
> + * struct sgx_enclave_relax_perm - parameters for ioctl
> + *                                 %SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
> + * @offset:	starting page offset (page aligned relative to enclave base
> + *		address defined in SECS)
> + * @length:	length of memory (multiple of the page size)
> + * @secinfo:	address for the SECINFO data containing the new permission bits
> + *		for pages in range described by @offset and @length
> + * @count:	(output) bytes successfully changed (multiple of page size)
> + */
> +struct sgx_enclave_relax_perm {
> +	__u64 offset;
> +	__u64 length;
> +	__u64 secinfo;
> +	__u64 count;
> +};
> +
>  struct sgx_enclave_run;
>  
>  /**
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index b8336d5d9029..9cc6af404bf6 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -698,6 +698,202 @@ static long sgx_ioc_enclave_provision(struct sgx_encl *encl, void __user *arg)
>  	return sgx_set_attribute(&encl->attributes_mask, params.fd);
>  }
>  
> +static unsigned long vm_prot_from_secinfo(u64 secinfo_perm)
> +{
> +	unsigned long vm_prot;
> +
> +	vm_prot = _calc_vm_trans(secinfo_perm, SGX_SECINFO_R, PROT_READ)  |
> +		  _calc_vm_trans(secinfo_perm, SGX_SECINFO_W, PROT_WRITE) |
> +		  _calc_vm_trans(secinfo_perm, SGX_SECINFO_X, PROT_EXEC);
> +	vm_prot = calc_vm_prot_bits(vm_prot, 0);
> +
> +	return vm_prot;
> +}
> +
> +/**
> + * sgx_enclave_relax_perm() - Update OS after permissions relaxed by enclave
> + * @encl:	Enclave to which the pages belong.
> + * @modp:	Checked parameters from user on which pages need modifying.
> + * @secinfo_perm: New validated permission bits.
> + *
> + * Return:
> + * - 0:		Success.
> + * - -errno:	Otherwise.
> + */
> +static long sgx_enclave_relax_perm(struct sgx_encl *encl,
> +				   struct sgx_enclave_relax_perm *modp,
> +				   u64 secinfo_perm)
> +{
> +	struct sgx_encl_page *entry;
> +	unsigned long vm_prot;
> +	unsigned long addr;
> +	unsigned long c;
> +	int ret;
> +
> +	vm_prot = vm_prot_from_secinfo(secinfo_perm);
> +
> +	for (c = 0 ; c < modp->length; c += PAGE_SIZE) {
> +		addr = encl->base + modp->offset + c;
> +
> +		mutex_lock(&encl->lock);
> +
> +		entry = xa_load(&encl->page_array, PFN_DOWN(addr));
> +		if (!entry) {
> +			ret = -EFAULT;
> +			goto out_unlock;
> +		}
> +
> +		/*
> +		 * Changing EPCM permissions is only supported on regular
> +		 * SGX pages.
> +		 */
> +		if (entry->type != SGX_PAGE_TYPE_REG) {
> +			ret = -EINVAL;
> +			goto out_unlock;
> +		}
> +
> +		/*
> +		 * Do not accept permissions that are more relaxed
> +		 * than vetted permissions.
> +		 * If this check fails then EPCM permissions may be more
> +		 * relaxed that what would be allowed by the kernel via
> +		 * PTEs.
> +		 */
> +		if ((entry->vm_max_prot_bits & vm_prot) != vm_prot) {
> +			ret = -EPERM;
> +			goto out_unlock;
> +		}
> +
> +		/*
> +		 * Change runtime protection before zapping PTEs to ensure
> +		 * any new #PF uses new permissions.
> +		 */
> +		entry->vm_run_prot_bits = vm_prot;
> +
> +		mutex_unlock(&encl->lock);
> +		/*
> +		 * Do not keep encl->lock because of dependency on
> +		 * mmap_lock acquired in sgx_zap_enclave_ptes().
> +		 */
> +		sgx_zap_enclave_ptes(encl, addr);
> +	}
> +
> +	ret = 0;
> +	goto out;
> +
> +out_unlock:
> +	mutex_unlock(&encl->lock);
> +out:
> +	modp->count = c;
> +
> +	return ret;
> +}
> +
> +/*
> + * Ensure enclave is ready for SGX2 functions. Readiness is checked
> + * by ensuring the hardware supports SGX2 and the enclave is initialized
> + * and thus able to handle requests to modify pages within it.
> + */
> +static int sgx_ioc_sgx2_ready(struct sgx_encl *encl)
> +{
> +	if (!(cpu_feature_enabled(X86_FEATURE_SGX2)))
> +		return -ENODEV;
> +
> +	if (!test_bit(SGX_ENCL_INITIALIZED, &encl->flags))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/*
> + * Return valid permission fields from a secinfo structure provided by
> + * user space. The secinfo structure is required to only have bits in
> + * the permission fields set.
> + */
> +static int sgx_perm_from_user_secinfo(void __user *_secinfo, u64 *secinfo_perm)
> +{
> +	struct sgx_secinfo secinfo;
> +	u64 perm;
> +
> +	if (copy_from_user(&secinfo, (void __user *)_secinfo,
> +			   sizeof(secinfo)))
> +		return -EFAULT;
> +
> +	if (secinfo.flags & ~SGX_SECINFO_PERMISSION_MASK)
> +		return -EINVAL;
> +
> +	if (memchr_inv(secinfo.reserved, 0, sizeof(secinfo.reserved)))
> +		return -EINVAL;
> +
> +	perm = secinfo.flags & SGX_SECINFO_PERMISSION_MASK;
> +
> +	if ((perm & SGX_SECINFO_W) && !(perm & SGX_SECINFO_R))
> +		return -EINVAL;
> +
> +	*secinfo_perm = perm;
> +
> +	return 0;
> +}
> +
> +/**
> + * sgx_ioc_enclave_relax_perm() - handler for
> + *                                %SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
> + * @encl:	an enclave pointer
> + * @arg:	userspace pointer to a &struct sgx_enclave_relax_perm instance
> + *
> + * SGX2 distinguishes between relaxing and restricting the enclave page
> + * permissions maintained by the hardware (EPCM permissions) of pages
> + * belonging to an initialized enclave (after %SGX_IOC_ENCLAVE_INIT).
> + *
> + * EPCM permissions can be relaxed anytime directly from within the enclave
> + * with no visibility from the kernel. This is accomplished with
> + * ENCLU[EMODPE] run from within the enclave. Accessing pages with
> + * the new, relaxed permissions requires the kernel to update the PTE
> + * to handle the subsequent #PF correctly.
> + *
> + * Enclave page permissions are not allowed to exceed the
> + * maximum vetted permissions maintained in
> + * &struct sgx_encl_page->vm_max_prot_bits. If the enclave
> + * exceeds these permissions by running ENCLU[EMODPE] from within the enclave
> + * the kernel will prevent access to the pages via PTE and
> + * VMA permissions.
> + *
> + * Return:
> + * - 0:		Success
> + * - -errno:	Otherwise
> + */
> +static long sgx_ioc_enclave_relax_perm(struct sgx_encl *encl, void __user *arg)
> +{
> +	struct sgx_enclave_relax_perm params;
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
> +	if (params.count)
> +		return -EINVAL;
> +
> +	ret = sgx_enclave_relax_perm(encl, &params, secinfo_perm);
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
> @@ -719,6 +915,9 @@ long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>  	case SGX_IOC_ENCLAVE_PROVISION:
>  		ret = sgx_ioc_enclave_provision(encl, (void __user *)arg);
>  		break;
> +	case SGX_IOC_ENCLAVE_RELAX_PERMISSIONS:
> +		ret = sgx_ioc_enclave_relax_perm(encl, (void __user *)arg);
> +		break;
>  	default:
>  		ret = -ENOIOCTLCMD;
>  		break;
> -- 
> 2.25.1
> 

Definitive NAK.

Should be dropped from the next patch set version. We *do not* want to
artificially construct an extra round-trip to EMODPE flow.

BR, Jarkko
