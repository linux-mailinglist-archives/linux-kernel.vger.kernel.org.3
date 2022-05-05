Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AE351C5A5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356896AbiEERFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382496AbiEERFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:05:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4E05C840;
        Thu,  5 May 2022 10:01:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98ED961E8A;
        Thu,  5 May 2022 17:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A37C385A4;
        Thu,  5 May 2022 17:01:26 +0000 (UTC)
Date:   Thu, 5 May 2022 18:01:23 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH v23 3/6] arm64: kdump: Reimplement crashkernel=X
Message-ID: <YnQC44KVKirH0vyB@arm.com>
References: <20220505091845.167-1-thunder.leizhen@huawei.com>
 <20220505091845.167-4-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505091845.167-4-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 05:18:42PM +0800, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> There are following issues in arm64 kdump:
> 1. We use crashkernel=X to reserve crashkernel in DMA zone, which
> will fail when there is not enough low memory.
> 2. If reserving crashkernel above DMA zone, in this case, crash dump
> kernel will fail to boot because there is no low memory available
> for allocation.
> 
> To solve these issues, introduce crashkernel=X,[high,low].
> The "crashkernel=X,high" is used to select a region above DMA zone, and
> the "crashkernel=Y,low" is used to allocate specified size low memory.

Thanks for posting the simplified version, though the discussion with
Baoquan is still ongoing. AFAICT there is no fallback if crashkernel=
fails. The advantage with this series is cleaner code, we set the limits
during parsing and don't have to adjust them if some of the first
allocation failed.

> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 51863f1448c6989..11406f3e1443168 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -90,6 +90,32 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
>  phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
>  #endif
>  
> +/* Current arm64 boot protocol requires 2MB alignment */
> +#define CRASH_ALIGN			SZ_2M
> +
> +#define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
> +#define CRASH_ADDR_HIGH_MAX		memblock.current_limit

Better use memblock_get_current_limit() if you need to or just
MEMBLOCK_ALLOC_ANYWHERE, memblock.current_limit is just a memblock
internal. But I think we can go for (PHYS_MASK + 1) if you need
something other than MEMBLOCK_ALLOC_ANYWHERE, memblock knows what to
allocate anyway.

> +static int __init reserve_crashkernel_low(unsigned long long low_size)
> +{
> +	unsigned long long low_base;
> +
> +	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
> +	if (!low_base) {
> +		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
> +		return -ENOMEM;
> +	}
> +
> +	pr_info("crashkernel low memory reserved: 0x%08llx - 0x%08llx (%lld MB)\n",
> +		low_base, low_base + low_size, low_size >> 20);
> +
> +	crashk_low_res.start = low_base;
> +	crashk_low_res.end   = low_base + low_size - 1;
> +	insert_resource(&iomem_resource, &crashk_low_res);
> +
> +	return 0;
> +}
> +
>  /*
>   * reserve_crashkernel() - reserves memory for crash kernel
>   *
> @@ -100,17 +126,32 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
>  static void __init reserve_crashkernel(void)
>  {
>  	unsigned long long crash_base, crash_size;
> -	unsigned long long crash_max = arm64_dma_phys_limit;
> +	unsigned long long crash_low_size = 0;
> +	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> +	char *cmdline = boot_command_line;
>  	int ret;
>  
>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>  		return;
>  
> -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> +	/* crashkernel=X[@offset] */
> +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
>  				&crash_size, &crash_base);
> -	/* no crashkernel= or invalid value specified */
> -	if (ret || !crash_size)
> -		return;
> +	if (ret || !crash_size) {

I think we should check for ret == -ENOENT only. If the crashkernel=
exists but is malformed or the size is 0, we shouldn't bother with
high/low at all.

> +		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
> +		if (ret || !crash_size)
> +			return;
> +
> +		/*
> +		 * crashkernel=Y,low can be specified or not, but invalid value
> +		 * is not allowed.
> +		 */
> +		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
> +		if (ret && (ret != -ENOENT))
> +			return;
> +
> +		crash_max = CRASH_ADDR_HIGH_MAX;
> +	}
>  
>  	crash_size = PAGE_ALIGN(crash_size);
>  
> @@ -118,8 +159,7 @@ static void __init reserve_crashkernel(void)
>  	if (crash_base)
>  		crash_max = crash_base + crash_size;
>  
> -	/* Current arm64 boot protocol requires 2MB alignment */
> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>  					       crash_base, crash_max);
>  	if (!crash_base) {
>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",

I personally like this but let's see how the other thread goes. I guess
if we want a fallback, it would come just before the check the above:

	if (!crash_base && crash_max != CRASH_ADDR_HIGH_MAX) {
		/* attempt high allocation with default low */
		if (!crash_low_size)
			crash_low_size = some default;
		crash_max = CRASH_ADDR_LOW_MAX;
		crash_base = memblock_phys_alloc_range();
	}

Well, I guess we end up with your earlier proposal but I think I
understand it better now ;).

-- 
Catalin
