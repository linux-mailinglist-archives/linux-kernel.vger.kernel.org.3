Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DF04B7FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 06:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344579AbiBPFPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 00:15:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238207AbiBPFPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 00:15:10 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D611C27B2D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:14:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CEFA113E;
        Tue, 15 Feb 2022 21:14:58 -0800 (PST)
Received: from [10.163.47.182] (unknown [10.163.47.182])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 696843F66F;
        Tue, 15 Feb 2022 21:14:57 -0800 (PST)
Subject: Re: [PATCH] arm64/mm: Drop use_1G_block()
To:     linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <1644988012-25455-1-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <fbf2d9f5-2226-dbd8-af3b-096fa2020381@arm.com>
Date:   Wed, 16 Feb 2022 10:44:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1644988012-25455-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/16/22 10:36 AM, Anshuman Khandual wrote:
> pud_sect_supported() already checks for PUD level block mapping support i.e
> on ARM64_4K_PAGES config. Hence pud_sect_supported(), along with some other
> required alignment checks can help completely drop use_1G_block().
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v5.17-rc4
> 
>  arch/arm64/mm/mmu.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index acfae9b41cc8..5a7954c9e6ec 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -294,18 +294,6 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>  	} while (addr = next, addr != end);
>  }
>  
> -static inline bool use_1G_block(unsigned long addr, unsigned long next,
> -			unsigned long phys)
> -{
> -	if (PAGE_SHIFT != 12)
> -		return false;
> -
> -	if (((addr | next | phys) & ~PUD_MASK) != 0)
> -		return false;
> -
> -	return true;
> -}
> -
>  static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  			   phys_addr_t phys, pgprot_t prot,
>  			   phys_addr_t (*pgtable_alloc)(int),
> @@ -338,7 +326,8 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  		/*
>  		 * For 4K granule only, attempt to put down a 1GB block
>  		 */
> -		if (use_1G_block(addr, next, phys) &&
> +		if (pud_sect_supported() &&
> +		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
>  		    (flags & NO_BLOCK_MAPPINGS) == 0) {

This is now very similar to init_pmd() block mapping check.

>  			pud_set_huge(pudp, phys, prot);
>  
> 
