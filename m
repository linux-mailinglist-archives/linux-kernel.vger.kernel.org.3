Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6454649CFDB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243230AbiAZQjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:39:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51088 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243213AbiAZQjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:39:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27948B81D54
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78731C340E6;
        Wed, 26 Jan 2022 16:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643215142;
        bh=XxbcKZbcM8QxtlzSo1DZMk0LZUuyDy0wc7VbuEr2m8A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VJeSu0auBkYgiXXSmSpZH1MBB0nTZCb7fNWufFf8iZ6Y0pC2Tun62Xffn0oQr/t6M
         W1GgANWgna7dsFDf2JVo/rpuNoiiY25jhyOJzh+d2sFoiut7ROO2KQxVIGVZGEy2ys
         XzulNmY6CC6nnAnV4JuhNCYjxTwA4p6f01IHf8GyK9lKZ+1sO492obj7Uh2yWCHx68
         b7MvcjodjuHn0RYUt9GApS2vPvzWAUYX5iUfORkodr1RHPrxnwWnkbNCFSVBlkefh+
         rIDLC7wlA0iz1A96CmHqnXcIveenbJtwU/4svDtwk5BeHp1jWihfl6qCj5+0GBSdqs
         5m7tqgzHXDPYw==
Message-ID: <34fa3a27-d9b8-a898-82f5-b1452006a7b9@kernel.org>
Date:   Wed, 26 Jan 2022 10:38:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC V1 25/31] nios2/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        akpm@linux-foundation.org
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
 <1643029028-12710-26-git-send-email-anshuman.khandual@arm.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <1643029028-12710-26-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/22 06:57, Anshuman Khandual wrote:
> This defines and exports a platform specific custom vm_get_page_prot() via
> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
> macros can be dropped which are no longer needed.
> 
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   arch/nios2/Kconfig               |  1 +
>   arch/nios2/include/asm/pgtable.h | 16 -------------
>   arch/nios2/mm/init.c             | 41 ++++++++++++++++++++++++++++++++
>   3 files changed, 42 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
> index 33fd06f5fa41..85a58a357a3b 100644
> --- a/arch/nios2/Kconfig
> +++ b/arch/nios2/Kconfig
> @@ -6,6 +6,7 @@ config NIOS2
>   	select ARCH_HAS_SYNC_DMA_FOR_CPU
>   	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>   	select ARCH_HAS_DMA_SET_UNCACHED
> +	select ARCH_HAS_VM_GET_PAGE_PROT
>   	select ARCH_NO_SWAP
>   	select COMMON_CLK
>   	select TIMER_OF
> diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
> index 4a995fa628ee..2678dad58a63 100644
> --- a/arch/nios2/include/asm/pgtable.h
> +++ b/arch/nios2/include/asm/pgtable.h
> @@ -40,24 +40,8 @@ struct mm_struct;
>    */
>   
>   /* Remove W bit on private pages for COW support */
> -#define __P000	MKP(0, 0, 0)
> -#define __P001	MKP(0, 0, 1)
> -#define __P010	MKP(0, 0, 0)	/* COW */
> -#define __P011	MKP(0, 0, 1)	/* COW */
> -#define __P100	MKP(1, 0, 0)
> -#define __P101	MKP(1, 0, 1)
> -#define __P110	MKP(1, 0, 0)	/* COW */
> -#define __P111	MKP(1, 0, 1)	/* COW */
>   
>   /* Shared pages can have exact HW mapping */
> -#define __S000	MKP(0, 0, 0)
> -#define __S001	MKP(0, 0, 1)
> -#define __S010	MKP(0, 1, 0)
> -#define __S011	MKP(0, 1, 1)
> -#define __S100	MKP(1, 0, 0)
> -#define __S101	MKP(1, 0, 1)
> -#define __S110	MKP(1, 1, 0)
> -#define __S111	MKP(1, 1, 1)
>   
>   /* Used all over the kernel */
>   #define PAGE_KERNEL __pgprot(_PAGE_PRESENT | _PAGE_CACHED | _PAGE_READ | \
> diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
> index 613fcaa5988a..4f8251e62f31 100644
> --- a/arch/nios2/mm/init.c
> +++ b/arch/nios2/mm/init.c
> @@ -124,3 +124,44 @@ const char *arch_vma_name(struct vm_area_struct *vma)
>   {
>   	return (vma->vm_start == KUSER_BASE) ? "[kuser]" : NULL;
>   }
> +
> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
> +{
> +	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
> +	case VM_NONE:
> +		return MKP(0, 0, 0);
> +	case VM_READ:
> +		return MKP(0, 0, 1);
> +	case VM_WRITE:
> +		return MKP(0, 0, 0);
> +	case VM_READ | VM_WRITE:
> +		return MKP(0, 0, 1);
> +	case VM_EXEC:
> +		return MKP(1, 0, 0);
> +	case VM_EXEC | VM_READ:
> +		return MKP(1, 0, 1);
> +	case VM_EXEC | VM_WRITE:
> +		return MKP(1, 0, 0);
> +	case VM_EXEC | VM_READ | VM_WRITE:
> +		return MKP(1, 0, 1);
> +	case VM_SHARED:
> +		return MKP(0, 0, 0);
> +	case VM_SHARED | VM_READ:
> +		return MKP(0, 0, 1);
> +	case VM_SHARED | VM_WRITE:
> +		return MKP(0, 1, 0);
> +	case VM_SHARED | VM_READ | VM_WRITE:
> +		return MKP(0, 1, 1);
> +	case VM_SHARED | VM_EXEC:
> +		return MKP(1, 0, 0);
> +	case VM_SHARED | VM_EXEC | VM_READ:
> +		return MKP(1, 0, 1);
> +	case VM_SHARED | VM_EXEC | VM_WRITE:
> +		return MKP(1, 1, 0);
> +	case VM_SHARED | VM_EXEC | VM_READ | VM_WRITE:
> +		return MKP(1, 1, 1);
> +	default:
> +		BUILD_BUG();
> +	}
> +}
> +EXPORT_SYMBOL(vm_get_page_prot);


Acked-by: Dinh Nguyen <dinguyen@kernel.org>
