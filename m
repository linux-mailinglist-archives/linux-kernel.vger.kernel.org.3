Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D90C4EBD9C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244803AbiC3J0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240935AbiC3J0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:26:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3872B269
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:24:59 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KT1Dh3wM3zDq9j;
        Wed, 30 Mar 2022 17:22:44 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 17:24:57 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 17:24:57 +0800
Message-ID: <bff5ccf2-d748-6e72-79b7-9d211a9ad21e@huawei.com>
Date:   Wed, 30 Mar 2022 17:24:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/2] arm64: mm: Do not defer reserve_crashkernel() if only
 ZONE_DMA32
Content-Language: en-US
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20220325055315.25671-1-wangkefeng.wang@huawei.com>
 <9e8f32c4-1198-dca5-915f-0b31ce1436b4@linux.microsoft.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <9e8f32c4-1198-dca5-915f-0b31ce1436b4@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/3/30 6:29, Vijay Balakrishna wrote:
>
>
> On 3/24/2022 10:53 PM, Kefeng Wang wrote:
>> The kernel could be benifit due to BLOCK_MAPPINGS, see commit
>> 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
>> platforms with no DMA memory zones"), if there is only with
>> ZONE_DMA32, we could set arm64_dma_phys_limit to max_zone_phys(32)
>> earlier in arm64_memblock_init(), then we will benifit too.
>
> Thanks for noticing platforms with just ZONE_DMA32 config can also 
> benefit BLOCK_MAPPINGS.  I assume you have access to one where you 
> notice the difference with proposed changes and able to test.  I did 
> test proposed changes on SoC we use with IOMMU (no ZONE_DMA configs 
> enabled).
>
> Nits --
> - benifit -> benefit
> - consider making commit message clear, "then we will.." seems you are 
> referring to platforms with just ZONE_DMA32 config enabled
> - to reflect new change consider updating comment added in commit 
> 031495635b46
>
One more question, could we add new cmdline(eg, dma_force_32bit) to let 
the arm64 using

32bit dma  by default?  I think most platforms are not with small DMA 
bit(only found 20bit in Raspberry Pi 4?),

Here is a draft(based on this patch) to do it, if the kernel boot with 
this cmdline and even ZONE_DMA

is enabled, the kernel allows linear creation of block mapping, not sure 
this is the right way, any suggestion? Thanks.

diff --git a/arch/arm64/include/asm/processor.h 
b/arch/arm64/include/asm/processor.h
index 73e38d9a540c..8febed26aeed 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -100,6 +100,7 @@
                                         base)
  #endif /* CONFIG_ARM64_FORCE_52BIT */

+extern bool arm64_dma_force_32bit;
  extern phys_addr_t arm64_dma_phys_limit;
  #define ARCH_LOW_ADDRESS_LIMIT (arm64_dma_phys_limit - 1)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index d6f64819ef89..86aab5db735b 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -92,6 +92,16 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
  phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
  #endif

+bool __ro_after_init arm64_dma_force_32bit;
+static int __init arm64_dma_force_32bit_setup(char *p)
+{
+       arm64_dma_force_32bit = true;
+       zone_dma_bits = 32;
+
+       return 0;
+}
+early_param("dma_force_32bit", arm64_dma_force_32bit_setup);
+
  /*
   * reserve_crashkernel() - reserves memory for crash kernel
   *
@@ -165,10 +175,11 @@ static void __init zone_sizes_init(void)
  #ifdef CONFIG_ZONE_DMA
         unsigned int acpi_zone_dma_bits;
         unsigned int dt_zone_dma_bits;
-
-       acpi_zone_dma_bits = fls64(acpi_iort_dma_get_max_cpu_address());
-       dt_zone_dma_bits = fls64(of_dma_get_max_cpu_address(NULL));
-       zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits);
+       if (!arm64_dma_force_32bit) {
+               acpi_zone_dma_bits = 
fls64(acpi_iort_dma_get_max_cpu_address());
+               dt_zone_dma_bits = fls64(of_dma_get_max_cpu_address(NULL));
+               zone_dma_bits = min3(32U, dt_zone_dma_bits, 
acpi_zone_dma_bits);
+       }
         arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
         max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
  #endif
@@ -336,7 +347,7 @@ void __init arm64_memblock_init(void)
         early_init_fdt_scan_reserved_mem();

         dma32_phys_limit = max_zone_phys(32);
-       if (!IS_ENABLED(CONFIG_ZONE_DMA)) {
+       if (!IS_ENABLED(CONFIG_ZONE_DMA) || arm64_dma_force_32bit) {
                 if (IS_ENABLED(CONFIG_ZONE_DMA32))
                         arm64_dma_phys_limit = dma32_phys_limit;
                 reserve_crashkernel();
@@ -388,7 +399,7 @@ void __init bootmem_init(void)
          * request_standard_resources() depends on crashkernel's memory 
being
          * reserved, so do it here.
          */
-       if (IS_ENABLED(CONFIG_ZONE_DMA))
+       if (IS_ENABLED(CONFIG_ZONE_DMA) && !arm64_dma_force_32bit)
                 reserve_crashkernel();

         memblock_dump_all();
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 23734481318a..9431ad581927 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -529,7 +529,7 @@ static void __init map_mem(pgd_t *pgdp)

  #ifdef CONFIG_KEXEC_CORE
         if (crash_mem_map) {
-               if (IS_ENABLED(CONFIG_ZONE_DMA))
+               if (IS_ENABLED(CONFIG_ZONE_DMA) && !arm64_dma_force_32bit)
                         flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
                 else if (crashk_res.end)
                         memblock_mark_nomap(crashk_res.start,
@@ -570,7 +570,7 @@ static void __init map_mem(pgd_t *pgdp)
          * through /sys/kernel/kexec_crash_size interface.
          */
  #ifdef CONFIG_KEXEC_CORE
-       if (crash_mem_map && !IS_ENABLED(CONFIG_ZONE_DMA)) {
+       if (crash_mem_map && (!IS_ENABLED(CONFIG_ZONE_DMA) || 
arm64_dma_force_32bit)) {
                 if (crashk_res.end) {
                         __map_memblock(pgdp, crashk_res.start,
                                        crashk_res.end + 1,


