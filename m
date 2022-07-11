Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABBE570C24
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiGKUoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiGKUn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:43:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240E9E26;
        Mon, 11 Jul 2022 13:43:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEAE1B81208;
        Mon, 11 Jul 2022 20:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5BBC341C0;
        Mon, 11 Jul 2022 20:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657572232;
        bh=cp41t+VP5zpzqWweFhXlDmnM1wrue4Oj0YaNSsnkppo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aRG3qlu8UFv6GCt770R2iC1Nn/k2d2ZZkq8YVXrKOSkRIGx/97W21I2Zdpp2kvQZZ
         KuyKHJSCwX7fmQ/aRk1bnlNJ8KyGBKAIf6wfLoaj+ZGY/r7YC8F4ZXLbCSIXay8S3U
         KO1cCVQmcGHIuoeCVWpgDm8SLn2+onrydiOidsSYmIF+WPeB57GMcSRa0c2AOerTEx
         8wJNGlnRymBpEln9x5KoLhRbmS/nGaKmk+GXs/cnV0NfNmMTv8Jcr5e9ZRfkzStYWA
         a4l5nSOt+INBze/1hqe2LjRwOeBcCIZslW2jmgjdP8uyldi4q1iH8r9vF36qh/SNmy
         6vhOBCbduXcxQ==
Message-ID: <88328a82-7275-608e-46f2-4203df9d9fe6@kernel.org>
Date:   Mon, 11 Jul 2022 15:43:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V7 15/26] nios2/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     hch@infradead.org, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        x86@kernel.org, openrisc@lists.librecores.org,
        linux-xtensa@linux-xtensa.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-um@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220711070600.2378316-1-anshuman.khandual@arm.com>
 <20220711070600.2378316-16-anshuman.khandual@arm.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220711070600.2378316-16-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/22 02:05, Anshuman Khandual wrote:
> This enables ARCH_HAS_VM_GET_PAGE_PROT on the platform and exports standard
> vm_get_page_prot() implementation via DECLARE_VM_GET_PAGE_PROT, which looks
> up a private and static protection_map[] array. Subsequently all __SXXX and
> __PXXX macros can be dropped which are no longer needed.
> 
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   arch/nios2/Kconfig               |  1 +
>   arch/nios2/include/asm/pgtable.h | 16 ----------------
>   arch/nios2/mm/init.c             | 20 ++++++++++++++++++++
>   3 files changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
> index 4167f1eb4cd8..e0459dffd218 100644
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
> index 262d0609268c..470516d4555e 100644
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
> index 613fcaa5988a..ae24687d12ad 100644
> --- a/arch/nios2/mm/init.c
> +++ b/arch/nios2/mm/init.c
> @@ -124,3 +124,23 @@ const char *arch_vma_name(struct vm_area_struct *vma)
>   {
>   	return (vma->vm_start == KUSER_BASE) ? "[kuser]" : NULL;
>   }
> +
> +static const pgprot_t protection_map[16] = {
> +	[VM_NONE]					= MKP(0, 0, 0),
> +	[VM_READ]					= MKP(0, 0, 1),
> +	[VM_WRITE]					= MKP(0, 0, 0),
> +	[VM_WRITE | VM_READ]				= MKP(0, 0, 1),
> +	[VM_EXEC]					= MKP(1, 0, 0),
> +	[VM_EXEC | VM_READ]				= MKP(1, 0, 1),
> +	[VM_EXEC | VM_WRITE]				= MKP(1, 0, 0),
> +	[VM_EXEC | VM_WRITE | VM_READ]			= MKP(1, 0, 1),
> +	[VM_SHARED]					= MKP(0, 0, 0),
> +	[VM_SHARED | VM_READ]				= MKP(0, 0, 1),
> +	[VM_SHARED | VM_WRITE]				= MKP(0, 1, 0),
> +	[VM_SHARED | VM_WRITE | VM_READ]		= MKP(0, 1, 1),
> +	[VM_SHARED | VM_EXEC]				= MKP(1, 0, 0),
> +	[VM_SHARED | VM_EXEC | VM_READ]			= MKP(1, 0, 1),
> +	[VM_SHARED | VM_EXEC | VM_WRITE]		= MKP(1, 1, 0),
> +	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= MKP(1, 1, 1)
> +};
> +DECLARE_VM_GET_PAGE_PROT

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
