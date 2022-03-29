Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82AE4EB5ED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbiC2Wb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237266AbiC2Wb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:31:27 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C776768987
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:29:41 -0700 (PDT)
Received: from [192.168.4.54] (cpe-70-95-196-11.san.res.rr.com [70.95.196.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2919F20DEDF6;
        Tue, 29 Mar 2022 15:29:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2919F20DEDF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1648592981;
        bh=iij0r/nUjujgqq3T5710JDnd1VMgPYhOYYBxSdc2+Q8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Uiejwv+LNnOg/dtgLhVagdkqjHFBAYCxmK+CTab8Bz9o/jKu54O2HwGHTCbL8hoMR
         o6S2HQ2J1n+oQQm0XItjgwZgR6za8rgUEQapT4+qspz3vX4Ii1Ddxb7uCQNA0lb4D1
         wV9WddlbfTeqVnWb5+DCR34Ah8W/BhaApJCnzoKk=
Message-ID: <9e8f32c4-1198-dca5-915f-0b31ce1436b4@linux.microsoft.com>
Date:   Tue, 29 Mar 2022 15:29:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] arm64: mm: Do not defer reserve_crashkernel() if only
 ZONE_DMA32
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Pasha Tatashin <pasha.tatashin@soleen.com>
References: <20220325055315.25671-1-wangkefeng.wang@huawei.com>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
In-Reply-To: <20220325055315.25671-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/2022 10:53 PM, Kefeng Wang wrote:
> The kernel could be benifit due to BLOCK_MAPPINGS, see commit
> 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
> platforms with no DMA memory zones"), if there is only with
> ZONE_DMA32, we could set arm64_dma_phys_limit to max_zone_phys(32)
> earlier in arm64_memblock_init(), then we will benifit too.

Thanks for noticing platforms with just ZONE_DMA32 config can also 
benefit BLOCK_MAPPINGS.  I assume you have access to one where you 
notice the difference with proposed changes and able to test.  I did 
test proposed changes on SoC we use with IOMMU (no ZONE_DMA configs 
enabled).

Nits --
- benifit -> benefit
- consider making commit message clear, "then we will.." seems you are 
referring to platforms with just ZONE_DMA32 config enabled
- to reflect new change consider updating comment added in commit 
031495635b46

> 
> Cc: Vijay Balakrishna <vijayb@linux.microsoft.com>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Vijay Balakrishna <vijayb@linux.microsoft.com>

> ---
>   arch/arm64/mm/init.c | 18 ++++++++++--------
>   arch/arm64/mm/mmu.c  |  6 ++----
>   2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 8ac25f19084e..9dded8779d72 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -157,14 +157,14 @@ static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
>   	return min(zone_mask, memblock_end_of_DRAM() - 1) + 1;
>   }
>   
> +phys_addr_t __ro_after_init dma32_phys_limit;
>   static void __init zone_sizes_init(unsigned long min, unsigned long max)
>   {
>   	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
> -	unsigned int __maybe_unused acpi_zone_dma_bits;
> -	unsigned int __maybe_unused dt_zone_dma_bits;
> -	phys_addr_t __maybe_unused dma32_phys_limit = max_zone_phys(32);
> -
>   #ifdef CONFIG_ZONE_DMA
> +	unsigned int acpi_zone_dma_bits;
> +	unsigned int dt_zone_dma_bits;
> +
>   	acpi_zone_dma_bits = fls64(acpi_iort_dma_get_max_cpu_address());
>   	dt_zone_dma_bits = fls64(of_dma_get_max_cpu_address(NULL));
>   	zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits);
> @@ -173,8 +173,6 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>   #endif
>   #ifdef CONFIG_ZONE_DMA32
>   	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(dma32_phys_limit);
> -	if (!arm64_dma_phys_limit)
> -		arm64_dma_phys_limit = dma32_phys_limit;
>   #endif
>   	max_zone_pfns[ZONE_NORMAL] = max;
>   
> @@ -336,8 +334,12 @@ void __init arm64_memblock_init(void)
>   
>   	early_init_fdt_scan_reserved_mem();
>   
> -	if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
> +	dma32_phys_limit = max_zone_phys(32);
> +	if (!IS_ENABLED(CONFIG_ZONE_DMA)) {
> +		if (IS_ENABLED(CONFIG_ZONE_DMA32))
> +			arm64_dma_phys_limit = dma32_phys_limit;
>   		reserve_crashkernel();
> +	}
>   
>   	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
>   }
> @@ -385,7 +387,7 @@ void __init bootmem_init(void)
>   	 * request_standard_resources() depends on crashkernel's memory being
>   	 * reserved, so do it here.
>   	 */
> -	if (IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32))
> +	if (IS_ENABLED(CONFIG_ZONE_DMA))
>   		reserve_crashkernel();
>   
>   	memblock_dump_all();
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 626ec32873c6..23734481318a 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -529,8 +529,7 @@ static void __init map_mem(pgd_t *pgdp)
>   
>   #ifdef CONFIG_KEXEC_CORE
>   	if (crash_mem_map) {
> -		if (IS_ENABLED(CONFIG_ZONE_DMA) ||
> -		    IS_ENABLED(CONFIG_ZONE_DMA32))
> +		if (IS_ENABLED(CONFIG_ZONE_DMA))
>   			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>   		else if (crashk_res.end)
>   			memblock_mark_nomap(crashk_res.start,
> @@ -571,8 +570,7 @@ static void __init map_mem(pgd_t *pgdp)
>   	 * through /sys/kernel/kexec_crash_size interface.
>   	 */
>   #ifdef CONFIG_KEXEC_CORE
> -	if (crash_mem_map &&
> -	    !IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) {
> +	if (crash_mem_map && !IS_ENABLED(CONFIG_ZONE_DMA)) {
>   		if (crashk_res.end) {
>   			__map_memblock(pgdp, crashk_res.start,
>   				       crashk_res.end + 1,
