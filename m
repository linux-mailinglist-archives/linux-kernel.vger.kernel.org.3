Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0668A4EF7EA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243382AbiDAQaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348557AbiDAQ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:27:58 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EB0E13F89
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 08:59:26 -0700 (PDT)
Received: from [192.168.4.54] (cpe-70-95-196-11.san.res.rr.com [70.95.196.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id 267D920DEEBF;
        Fri,  1 Apr 2022 08:59:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 267D920DEEBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1648828765;
        bh=4U2yibKauUx9VepxeUJ4omwk1df4H2DqEYX73pyN2jU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cJfgF5guqfuH2XAMLI4R332Jmgro/dAyFeCQw/usoUMHx5Tu/aaSgNhhP14UOAdv2
         nIpTkdNy0+ME3YhEd1tfhJRFWjGkYeEDbocixtfiWuGm4LFn+QVmvSUgK+PYlStRZV
         urQmxT+RTEHnW8ILrxgzj4iSgTp0Dyvo6WSYjlPA=
Message-ID: <69c1e722-33ea-95cf-de84-aed3022cb042@linux.microsoft.com>
Date:   Fri, 1 Apr 2022 08:59:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 resend 1/3] arm64: mm: Do not defer
 reserve_crashkernel() if only ZONE_DMA32
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, Pasha Tatashin <pasha.tatashin@soleen.com>
References: <20220331074055.125824-1-wangkefeng.wang@huawei.com>
 <20220331074055.125824-2-wangkefeng.wang@huawei.com>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
In-Reply-To: <20220331074055.125824-2-wangkefeng.wang@huawei.com>
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



On 3/31/2022 12:40 AM, Kefeng Wang wrote:
> The kernel could be benefit due to BLOCK_MAPPINGS, see commit
> 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
> platforms with no DMA memory zones"), if only with ZONE_DMA32,
> set arm64_dma_phys_limit to max_zone_phys(32) earlier in
> arm64_memblock_init(), so platforms with just ZONE_DMA32 config
> enabled will be benefit.

nit --
- "will be benefit" => will benefit

On further look I feel we can getaway without dma32_phys_limit static 
global and replace with two separate calls to max_zone_phys(32)?  Just a 
thought.  If you decide to keep it then a better location would be 
immediately above arm64_memblock_init() definition where it is 
initialized can improve code readability.

Thanks,
Vijay

> 
> Cc: Vijay Balakrishna <vijayb@linux.microsoft.com>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Will Deacon <will@kernel.org>
> Reviewed-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   arch/arm64/mm/init.c | 23 +++++++++++++----------
>   arch/arm64/mm/mmu.c  |  6 ++----
>   2 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 8ac25f19084e..fb01eb489fa9 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -65,8 +65,9 @@ EXPORT_SYMBOL(memstart_addr);
>    * Memory reservation for crash kernel either done early or deferred
>    * depending on DMA memory zones configs (ZONE_DMA) --
>    *
> - * In absence of ZONE_DMA configs arm64_dma_phys_limit initialized
> - * here instead of max_zone_phys().  This lets early reservation of
> + * In absence of ZONE_DMA and ZONE_DMA32 configs arm64_dma_phys_limit
> + * initialized here and if only with ZONE_DMA32 arm64_dma_phys_limit
> + * initialised to dma32_phys_limit. This lets early reservation of
>    * crash kernel memory which has a dependency on arm64_dma_phys_limit.
>    * Reserving memory early for crash kernel allows linear creation of block
>    * mappings (greater than page-granularity) for all the memory bank rangs.
> @@ -84,6 +85,7 @@ EXPORT_SYMBOL(memstart_addr);
>    * Note: Page-granularity mapppings are necessary for crash kernel memory
>    * range for shrinking its size via /sys/kernel/kexec_crash_size interface.
>    */
> +static phys_addr_t __ro_after_init dma32_phys_limit;


>   #if IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32)
>   phys_addr_t __ro_after_init arm64_dma_phys_limit;
>   #else
> @@ -160,11 +162,10 @@ static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
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
> @@ -173,8 +174,6 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>   #endif
>   #ifdef CONFIG_ZONE_DMA32
>   	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(dma32_phys_limit);
> -	if (!arm64_dma_phys_limit)
> -		arm64_dma_phys_limit = dma32_phys_limit;
>   #endif
>   	max_zone_pfns[ZONE_NORMAL] = max;
>   
> @@ -336,8 +335,12 @@ void __init arm64_memblock_init(void)
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
> @@ -385,7 +388,7 @@ void __init bootmem_init(void)
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
