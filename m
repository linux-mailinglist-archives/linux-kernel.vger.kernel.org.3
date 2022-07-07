Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7687756A3B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbiGGNby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbiGGNbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:31:52 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F6E31906;
        Thu,  7 Jul 2022 06:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IbZ1yvXv8VTRh+Cr01Welmi1nR57tc4pZ0SSCJyULWo=; b=NbHuJxvgBdQ8dXCzCdWU+1naC/
        s+l/L0niWCcqQpKbBPSkpbWceoUktXST7cZsfhrnpdSPiiaUQiNQdY7DwBaHH9XR1XszrGaqvwcg8
        W6zrQDo5d09a8PRuF3PLdHiJFWdzGDcjDnaeyP1EQq/1yh7qrOskcW/7sCZPnXnGjOY0qkPCYKq0i
        IBYteaQOJG7hsMBn9BBdi0Ccjbuazs5CFzBvCUk5mVXykfxBhHVFA9GWyghPI7vip+D5tFdp/0ZQs
        veZ5+Jq5RHfviOY68oT4nsnMlqvp+zRFEyDtPamPpHkBxAMHzEGyLJLfZQOOiqf2kTn9xZYT5RU6x
        t6z27Qgg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o9Rbc-0099vg-9K;
        Thu, 07 Jul 2022 13:31:44 +0000
Date:   Thu, 7 Jul 2022 14:31:44 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 1/1] s390/crash: allow multi-segment iterators
Message-ID: <YsbgQLNXbHH30phb@ZenIV>
References: <cover.1657172539.git.agordeev@linux.ibm.com>
 <613f63d652bb4fa6fb3d2bb38762de6bb066b35a.1657172539.git.agordeev@linux.ibm.com>
 <YsbXfh3e2rDEKSNw@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsbXfh3e2rDEKSNw@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 01:54:22PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 07, 2022 at 08:01:15AM +0200, Alexander Gordeev wrote:
> > Rework copy_oldmem_page() to allow multi-segment iterators.
> > Reuse existing iterate_iovec macro as is and only relevant
> > bits from __iterate_and_advance macro.
> 
> Or do it properly?

Or that...

> You should probably put a mutex around all of this because if you have two
> threads accessing the hsa at the same time, they'll use the same buffer.
> But that's a pre-existing problem.  I also fixed the pre-existing bug
> where you were using 'count' when you meant to use 'len'.
> 
> Uncompiled.  You might need to include <linux/uio.h> somewhere.
> 
> diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
> index 236b34b75ddb..d8b4c526e0f0 100644
> --- a/arch/s390/include/asm/sclp.h
> +++ b/arch/s390/include/asm/sclp.h
> @@ -143,7 +143,7 @@ int sclp_ap_configure(u32 apid);
>  int sclp_ap_deconfigure(u32 apid);
>  int sclp_pci_report(struct zpci_report_error_header *report, u32 fh, u32 fid);
>  int memcpy_hsa_kernel(void *dest, unsigned long src, size_t count);
> -int memcpy_hsa_user(void __user *dest, unsigned long src, size_t count);
> +int memcpy_hsa_iter(struct iov_iter *iter, unsigned long src, size_t count);
>  void sclp_ocf_cpc_name_copy(char *dst);
>  
>  static inline int sclp_get_core_info(struct sclp_core_info *info, int early)
> diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
> index 28124d0fa1d5..6e4dde377f8e 100644
> --- a/arch/s390/kernel/crash_dump.c
> +++ b/arch/s390/kernel/crash_dump.c
> @@ -130,53 +130,11 @@ static inline void *load_real_addr(void *addr)
>  	return (void *)real_addr;
>  }
>  
> -/*
> - * Copy memory of the old, dumped system to a kernel space virtual address
> - */
> -int copy_oldmem_kernel(void *dst, unsigned long src, size_t count)
> -{
> -	unsigned long len;
> -	void *ra;
> -	int rc;
> -
> -	while (count) {
> -		if (!oldmem_data.start && src < sclp.hsa_size) {
> -			/* Copy from zfcp/nvme dump HSA area */
> -			len = min(count, sclp.hsa_size - src);
> -			rc = memcpy_hsa_kernel(dst, src, len);
> -			if (rc)
> -				return rc;
> -		} else {
> -			/* Check for swapped kdump oldmem areas */
> -			if (oldmem_data.start && src - oldmem_data.start < oldmem_data.size) {
> -				src -= oldmem_data.start;
> -				len = min(count, oldmem_data.size - src);
> -			} else if (oldmem_data.start && src < oldmem_data.size) {
> -				len = min(count, oldmem_data.size - src);
> -				src += oldmem_data.start;
> -			} else {
> -				len = count;
> -			}
> -			if (is_vmalloc_or_module_addr(dst)) {
> -				ra = load_real_addr(dst);
> -				len = min(PAGE_SIZE - offset_in_page(ra), len);
> -			} else {
> -				ra = dst;
> -			}
> -			if (memcpy_real(ra, src, len))
> -				return -EFAULT;
> -		}
> -		dst += len;
> -		src += len;
> -		count -= len;
> -	}
> -	return 0;
> -}
> -
>  /*
>   * Copy memory of the old, dumped system to a user space virtual address
>   */
> -static int copy_oldmem_user(void __user *dst, unsigned long src, size_t count)
> +static int copy_oldmem_iter(struct iov_iter *iter, unsigned long src,
> +		size_t count)
>  {
>  	unsigned long len;
>  	int rc;
> @@ -185,7 +143,7 @@ static int copy_oldmem_user(void __user *dst, unsigned long src, size_t count)
>  		if (!oldmem_data.start && src < sclp.hsa_size) {
>  			/* Copy from zfcp/nvme dump HSA area */
>  			len = min(count, sclp.hsa_size - src);
> -			rc = memcpy_hsa_user(dst, src, len);
> +			rc = memcpy_hsa_iter(iter, src, len);
>  			if (rc)
>  				return rc;
>  		} else {
> @@ -199,8 +157,8 @@ static int copy_oldmem_user(void __user *dst, unsigned long src, size_t count)
>  			} else {
>  				len = count;
>  			}
> -			rc = copy_to_user_real(dst, src, count);
> -			if (rc)
> +			rc = copy_to_iter(iter, src, len);
> +			if (rc != len)
>  				return rc;
>  		}
>  		dst += len;
> @@ -219,23 +177,13 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn, size_t csize,
>  	unsigned long src;
>  	int rc;
>  
> -	if (!(iter_is_iovec(iter) || iov_iter_is_kvec(iter)))
> -		return -EINVAL;
> -	/* Multi-segment iterators are not supported */
> -	if (iter->nr_segs > 1)
> -		return -EINVAL;
>  	if (!csize)
>  		return 0;
>  	src = pfn_to_phys(pfn) + offset;
>  
> -	/* XXX: pass the iov_iter down to a common function */
> -	if (iter_is_iovec(iter))
> -		rc = copy_oldmem_user(iter->iov->iov_base, src, csize);
> -	else
> -		rc = copy_oldmem_kernel(iter->kvec->iov_base, src, csize);
> +	rc = copy_oldmem_iter(iter, src, csize);
>  	if (rc < 0)
>  		return rc;
> -	iov_iter_advance(iter, csize);
>  	return csize;
>  }
>  
> diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
> index 516783ba950f..26125718f3e0 100644
> --- a/drivers/s390/char/zcore.c
> +++ b/drivers/s390/char/zcore.c
> @@ -59,7 +59,7 @@ static char hsa_buf[PAGE_SIZE] __aligned(PAGE_SIZE);
>   * @src:   Start address within HSA where data should be copied
>   * @count: Size of buffer, which should be copied
>   */
> -int memcpy_hsa_user(void __user *dest, unsigned long src, size_t count)
> +int memcpy_hsa_iter(struct iov_iter *iter, unsigned long src, size_t count)
>  {
>  	unsigned long offset, bytes;
>  
> @@ -73,10 +73,9 @@ int memcpy_hsa_user(void __user *dest, unsigned long src, size_t count)
>  		}
>  		offset = src % PAGE_SIZE;
>  		bytes = min(PAGE_SIZE - offset, count);
> -		if (copy_to_user(dest, hsa_buf + offset, bytes))
> +		if (copy_to_iter(hsa_buf + offset, bytes, iter) != bytes)
>  			return -EFAULT;

Umm...  Then you want iov_iter_revert() on short copy...
