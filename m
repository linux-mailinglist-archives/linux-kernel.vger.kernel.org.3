Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D484CD91D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbiCDQ2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbiCDQ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:28:50 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB471567A2;
        Fri,  4 Mar 2022 08:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646411282; x=1677947282;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=jhSjXwtdTfTBwcwN4SBTx9W7ueMs98igpHWtpw1dvgU=;
  b=dxXNQO5sKTuDcmLTY4PwVAjWmGqzPOfIAxEG1qWmYjeAVTdgVTbaYURh
   +TPMErsy7U6h9/E7dnT7XmWtgHM+kd2qAZ3N+gZ9ysKWDNoSJglEAjxWT
   vEdFyMldr8fgVLx6UCwkr06rgUhACAWBL2WSwcKPvy/d/zOIr0NjtRn4J
   ZeuO3NsmFi1bBFkTprVxHPQ0WDKRs+W2q9UhMuUDa9VyzKIRUVXkCX4pE
   lKXdAv8qxGUSpRu1+8G3GoKR8nswIvpD7Wb77v1Lxgtobs9Huuf1jQ+9m
   /jyTspbuNr6P6imZBLxrUL3l34M9AEsrTPCHsantoNdIWQuJppZs5bU6D
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="254201104"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="254201104"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 08:28:02 -0800
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="552276508"
Received: from hhuan26-mobl1.amr.corp.intel.com (HELO hhuan26-mobl1.mshome.net) ([10.255.33.72])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 04 Mar 2022 08:28:00 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     linux-sgx@vger.kernel.org, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     "Reinette Chatre" <reinette.chatre@intel.com>,
        "Nathaniel McCallum" <nathaniel@profian.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86: Add SGX_IOC_ENCLAVE_AUGMENT_PAGES
References: <20220304122852.563475-1-jarkko@kernel.org>
Date:   Fri, 04 Mar 2022 10:27:58 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel Corp
Message-ID: <op.1iilcwhywjvjmi@hhuan26-mobl1.mshome.net>
In-Reply-To: <20220304122852.563475-1-jarkko@kernel.org>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Mar 2022 06:28:52 -0600, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> With SGX1 an enclave needs to be created with its maximum memory demands
> allocated. Pages cannot be added to an enclave after it is initialized.
> SGX2 introduces a new function, ENCLS[EAUG], that can be used to add  
> pages
> to an initialized enclave. With SGX2 the enclave still needs to set aside
> address space for its maximum memory demands during enclave creation, but
> all pages need not be added before enclave initialization. Pages can be
> added during enclave runtime.
>
> Add support for dynamically adding pages to an initialized enclave with
> SGX_IOC_ENCLAVE_AUGMENT_PAGES, which performs EAUG's to a given range of
> pages. Do not enforce any particular permissions from kernel, like is  
> done
> for the pages added during the pre-initialization phase, as enclave
> controls the final permissions and content for these pages by issuing
> either ENCLU[EACCEPT] (empty RW) or ENCLU[EACCEPTCOPY] (arbitrary data  
> and
> permissions).
>
> Explicit EAUG ioctl is a better choice than an implicit EAUG from a page
> fault handler because it allows to have O(1) number of kernel-enclave  
> round
> trips for EAUG-EACCEPT{COPY} process, instead of O(n), as it is in the  
> case
> when a page fault handler EAUG single page at a time.
>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Nathaniel McCallum <nathaniel@profian.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> Is contained in sgx2-v2.1 branch of  
> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-sgx.git
> ---
>  arch/x86/include/uapi/asm/sgx.h |  14 +++
>  arch/x86/kernel/cpu/sgx/ioctl.c | 159 ++++++++++++++++++++++++++++++++
>  2 files changed, 173 insertions(+)
>
> diff --git a/arch/x86/include/uapi/asm/sgx.h  
> b/arch/x86/include/uapi/asm/sgx.h
> index c4e0326d281d..2b3a606e78fe 100644
> --- a/arch/x86/include/uapi/asm/sgx.h
> +++ b/arch/x86/include/uapi/asm/sgx.h
> @@ -35,6 +35,8 @@ enum sgx_page_flags {
>  	_IOWR(SGX_MAGIC, 0x06, struct sgx_enclave_modt)
>  #define SGX_IOC_ENCLAVE_REMOVE_PAGES \
>  	_IOWR(SGX_MAGIC, 0x08, struct sgx_enclave_remove_pages)
> +#define SGX_IOC_ENCLAVE_AUGMENT_PAGES \
> +	_IOWR(SGX_MAGIC, 0x09, struct sgx_enclave_augment_pages)
> /**
>   * struct sgx_enclave_create - parameter structure for the
> @@ -138,6 +140,18 @@ struct sgx_enclave_remove_pages {
>  	__u64 count;
>  };
> +/**
> + * struct sgx_enclave_augment_pages - parameter structure for the  
> %SGX_IOC_ENCLAVE_ADD_PAGE ioctl
> + * @offset:	starting page offset
> + * @length:	length of the data (multiple of the page size)
> + * @count:	number of bytes added (multiple of the page size)
> + */
> +struct sgx_enclave_augment_pages {
> +	__u64 offset;
> +	__u64 length;
> +	__u64 count;
> +};
> +

As I stated in another thread, we need a mechanism to allow EAUG page  
lazily, e.g., on #PF. Can we add a field here to indicate that?

>  struct sgx_enclave_run;
> /**
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c  
> b/arch/x86/kernel/cpu/sgx/ioctl.c
> index 3ad4320ff6ae..1cb410d97ac7 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -1320,6 +1320,162 @@ static long sgx_ioc_enclave_remove_pages(struct  
> sgx_encl *encl,
>  	return ret;
>  }
> +/*
> + * Performa EAUG operation for an enclave.
> + */
> +static int sgx_encl_augment_page(struct sgx_encl *encl, unsigned long  
> offset)
> +{
> +	struct sgx_pageinfo pginfo = {0};
> +	struct sgx_encl_page *encl_page;
> +	struct sgx_epc_page *epc_page;
> +	struct sgx_va_page *va_page;
> +	u64 secinfo_flags;
> +	int ret;
> +
> +	/*
> +	 * Ignore internal permission checking for dynamically added pages.
> +	 * They matter only for data added during the pre-initialization phase.
> +	 * The enclave decides the permissions by the means of EACCEPT,
> +	 * EACCEPTCOPY and EMODPE.
> +	 */
> +	secinfo_flags = SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_X;
> +	encl_page = sgx_encl_page_alloc(encl, offset, secinfo_flags);
> +	if (IS_ERR(encl_page))
> +		return PTR_ERR(encl_page);
> +
> +	epc_page = sgx_alloc_epc_page(encl_page, true);
> +	if (IS_ERR(epc_page)) {
> +		ret = PTR_ERR(epc_page);
> +		goto err_alloc_epc_page;
> +	}
> +
> +	va_page = sgx_encl_grow(encl);
> +	if (IS_ERR(va_page)) {
> +		ret = PTR_ERR(va_page);
> +		goto err_grow;
> +	}
> +
> +	mutex_lock(&encl->lock);
> +
> +	/*
> +	 * Adding to encl->va_pages must be done under encl->lock.  Ditto for
> +	 * deleting (via sgx_encl_shrink()) in the error path.
> +	 */
> +	if (va_page)
> +		list_add(&va_page->list, &encl->va_pages);
> +
> +	/*
> +	 * Insert prior to EADD in case of OOM.  EADD modifies MRENCLAVE, i.e.
> +	 * can't be gracefully unwound, while failure on EADD/EXTEND is limited
> +	 * to userspace errors (or kernel/hardware bugs).
> +	 */
> +	ret = xa_insert(&encl->page_array, PFN_DOWN(encl_page->desc),
> +			encl_page, GFP_KERNEL);
> +
> +	/*
> +	 * If ret == -EBUSY then page was created in another flow while
> +	 * running without encl->lock
> +	 */
> +	if (ret)
> +		goto err_xa_insert;
> +
> +	pginfo.secs = (unsigned  
> long)sgx_get_epc_virt_addr(encl->secs.epc_page);
> +	pginfo.addr = encl_page->desc & PAGE_MASK;
> +	pginfo.metadata = 0;
> +
> +	ret = __eaug(&pginfo, sgx_get_epc_virt_addr(epc_page));
> +	if (ret)
> +		goto err_eaug;
> +
> +	encl_page->encl = encl;
> +	encl_page->epc_page = epc_page;
> +	encl_page->type = SGX_PAGE_TYPE_REG;
> +	encl->secs_child_cnt++;
> +
> +	sgx_mark_page_reclaimable(encl_page->epc_page);
> +
> +	mutex_unlock(&encl->lock);
> +
> +	return 0;
> +
> +err_eaug:
> +	xa_erase(&encl->page_array, PFN_DOWN(encl_page->desc));
> +
> +err_xa_insert:
> +	sgx_encl_shrink(encl, va_page);
> +	mutex_unlock(&encl->lock);
> +
> +err_grow:
> +	sgx_encl_free_epc_page(epc_page);
> +
> +err_alloc_epc_page:
> +	kfree(encl_page);
> +
> +	return VM_FAULT_SIGBUS;
> +}
> +
> +/**
> + * sgx_ioc_enclave_augment_pages() - The handler for  
> %SGX_IOC_ENCLAVE_AUGMENT_PAGES
> + * @encl:       an enclave pointer
> + * @arg:	a user pointer to a struct sgx_enclave_augment_pages instance
> + *
> + * Request to augment pages to an initialized enclave. The pages must be
> + * acknowledged by the enclave by issuing either ENCLU[EACCEPT] (for a
> + * trivial empty data page) or ENCLU[EACCEPTCOPY] (for a page with  
> arbitrary
> + * permissions and user provided data).
> + *
> + * mmap() protection bits for augmented pages can be arbitrary, i.e.  
> their
> + * permissions are only capped by the VMA, not by EPCM permissions.  
> This is
> + * a constraint because enclave can internally control the final EPCM  
> versions,
> + * for which the kernel has no say.
> + *
> + * Return:
> + * - 0:		Success.
> + * - -EACCES:	The source page is located in a noexec partition.
> + * - -ENOMEM:	Out of EPC pages.
> + * - -EINTR:	The call was interrupted before data was processed.
> + * - -EIO:	EAUG failed.
> + * - -errno:	POSIX error.
> + */
> +static long sgx_ioc_enclave_augment_pages(struct sgx_encl *encl, void  
> __user *user_arg)
> +{
> +	struct sgx_enclave_augment_pages arg;
> +	unsigned long c;
> +	int ret;
> +
> +	if (!test_bit(SGX_ENCL_INITIALIZED, &encl->flags))
> +		return -EINVAL;
> +
> +	if (copy_from_user(&arg, user_arg, sizeof(arg)))
> +		return -EFAULT;
> +
> +	if (sgx_validate_offset_length(encl, arg.offset, arg.length))
> +		return -EINVAL;
> +
> +	for (c = 0 ; c < arg.length; c += PAGE_SIZE) {
> +		if (signal_pending(current)) {
> +			if (!c)
> +				ret = -ERESTARTSYS;
> +
> +			break;
> +		}
> +
> +		if (need_resched())
> +			cond_resched();
> +
> +		ret = sgx_encl_augment_page(encl, arg.offset + c);
> +		if (ret)
> +			break;
> +	}
> +
> +	arg.count = c;
> +
> +	if (copy_to_user(user_arg, &arg, sizeof(arg)))
> +		return -EFAULT;
> +
> +	return ret;
> +}
> +
>  long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>  {
>  	struct sgx_encl *encl = filep->private_data;
> @@ -1350,6 +1506,9 @@ long sgx_ioctl(struct file *filep, unsigned int  
> cmd, unsigned long arg)
>  	case SGX_IOC_ENCLAVE_REMOVE_PAGES:
>  		ret = sgx_ioc_enclave_remove_pages(encl, (void __user *)arg);
>  		break;
> +	case SGX_IOC_ENCLAVE_AUGMENT_PAGES:
> +		ret = sgx_ioc_enclave_augment_pages(encl, (void __user *)arg);
> +		break;
>  	default:
>  		ret = -ENOIOCTLCMD;
>  		break;
