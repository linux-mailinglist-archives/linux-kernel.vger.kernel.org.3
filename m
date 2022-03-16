Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245B54DAF68
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355587AbiCPMNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355585AbiCPMNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:13:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAB115F8E4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 05:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647432724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NFvT60sZqo3HaKmg6w6yCwx/Ub8DpG+qf8E82rYKcwc=;
        b=Z8pzVpgoNZeJZdm8CQJleeWr5aVlnycUvs4lW6rpq60n2JvYG2Xzkrz+fIvwXoPMV9QT9e
        +yZD++8V95IzMITqjz+rTBOKXaLmgg7dpeVThg7BBcxo8TKfvTsxl37SIEV1jJRFwDSmnw
        7rcEJmQwHi86zfgMvmqPMWaRQRqxHaM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638--jMse2_6PYW9ytbJubyphA-1; Wed, 16 Mar 2022 08:12:00 -0400
X-MC-Unique: -jMse2_6PYW9ytbJubyphA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07469892D28;
        Wed, 16 Mar 2022 12:11:52 +0000 (UTC)
Received: from localhost (ovpn-12-236.pek2.redhat.com [10.72.12.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1E90C44AEE;
        Wed, 16 Mar 2022 12:11:49 +0000 (UTC)
Date:   Wed, 16 Mar 2022 20:11:46 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH v21 3/5] arm64: kdump: reimplement crashkernel=X
Message-ID: <YjHUAi0xrUy+qk/L@MiWiFi-R3L-srv>
References: <20220227030717.1464-1-thunder.leizhen@huawei.com>
 <20220227030717.1464-4-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227030717.1464-4-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/22 at 11:07am, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> There are following issues in arm64 kdump:
> 1. We use crashkernel=X to reserve crashkernel below 4G, which
> will fail when there is no enough low memory.
> 2. If reserving crashkernel above 4G, in this case, crash dump
> kernel will boot failure because there is no low memory available
> for allocation.
> 
> To solve these issues, change the behavior of crashkernel=X and
> introduce crashkernel=X,[high,low]. crashkernel=X tries low allocation
> in DMA zone, and fall back to high allocation if it fails.
> We can also use "crashkernel=X,high" to select a region above DMA zone,
> which also tries to allocate at least 256M in DMA zone automatically.
> "crashkernel=Y,low" can be used to allocate specified size low memory.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Co-developed-by: Zhen Lei <thunder.leizhen@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm64/kernel/machine_kexec.c      |   9 ++-
>  arch/arm64/kernel/machine_kexec_file.c |  12 ++-
>  arch/arm64/mm/init.c                   | 106 +++++++++++++++++++++++--
>  3 files changed, 115 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index e16b248699d5c3c..19c2d487cb08feb 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -329,8 +329,13 @@ bool crash_is_nosave(unsigned long pfn)
>  
>  	/* in reserved memory? */
>  	addr = __pfn_to_phys(pfn);
> -	if ((addr < crashk_res.start) || (crashk_res.end < addr))
> -		return false;
> +	if ((addr < crashk_res.start) || (crashk_res.end < addr)) {
> +		if (!crashk_low_res.end)
> +			return false;
> +
> +		if ((addr < crashk_low_res.start) || (crashk_low_res.end < addr))
> +			return false;
> +	}
>  
>  	if (!kexec_crash_image)
>  		return true;
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 59c648d51848886..889951291cc0f9c 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -65,10 +65,18 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>  
>  	/* Exclude crashkernel region */
>  	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> +	if (ret)
> +		goto out;
> +
> +	if (crashk_low_res.end) {
> +		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
> +		if (ret)
> +			goto out;
> +	}
>  
> -	if (!ret)
> -		ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
> +	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
>  
> +out:
>  	kfree(cmem);
>  	return ret;
>  }
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 90f276d46b93bc6..30ae6638ff54c47 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -65,6 +65,44 @@ EXPORT_SYMBOL(memstart_addr);
>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
>  
>  #ifdef CONFIG_KEXEC_CORE
> +/* Current arm64 boot protocol requires 2MB alignment */
> +#define CRASH_ALIGN			SZ_2M
> +
> +#define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
> +#define CRASH_ADDR_HIGH_MAX		memblock.current_limit
> +
> +/*
> + * This is an empirical value in x86_64 and taken here directly. Please
> + * refer to the code comment in reserve_crashkernel_low() of x86_64 for more
> + * details.
> + */
> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE	\
> +	max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20)
> +
> +static int __init reserve_crashkernel_low(unsigned long long low_size)
> +{
> +	unsigned long long low_base;
> +
> +	/* passed with crashkernel=0,low ? */
> +	if (!low_size)
> +		return 0;
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
> @@ -75,30 +113,79 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>  static void __init reserve_crashkernel(void)
>  {
>  	unsigned long long crash_base, crash_size;
> -	unsigned long long crash_max = arm64_dma_phys_limit;
> +	unsigned long long crash_low_size;
> +	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>  	int ret;

Even though reverse xmas tree style is not enforced, this 'int ret;' is
really annoying to look at. Maybe move it down two lines.

> +	bool fixed_base, high = false;
> +	char *cmdline = boot_command_line;
>  
> -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> +	/* crashkernel=X[@offset] */
> +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
>  				&crash_size, &crash_base);
> -	/* no crashkernel= or invalid value specified */
> -	if (ret || !crash_size)
> -		return;
> +	if (ret || !crash_size) {
> +		/* crashkernel=X,high */
> +		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
> +		if (ret || !crash_size)
> +			return;
> +
> +		/* crashkernel=Y,low */
> +		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
> +		if (ret == -ENOENT)
> +			/*
> +			 * crashkernel=Y,low is not specified explicitly, use
> +			 * default size automatically.
> +			 */
> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> +		else if (ret)
> +			/* crashkernel=Y,low is specified but Y is invalid */
> +			return;
> +
> +		/* Mark crashkernel=X,high is specified */
> +		high = true;
> +		crash_max = CRASH_ADDR_HIGH_MAX;
> +	}
>  
> +	fixed_base = !!crash_base;
>  	crash_size = PAGE_ALIGN(crash_size);
>  
>  	/* User specifies base address explicitly. */
This is over commenting, can't see why it's needed.
> -	if (crash_base)
> +	if (fixed_base)
>  		crash_max = crash_base + crash_size;

Hi leizhen,

I made change on reserve_crashkenrel(), inline comment may be slow.
Please check and consider if they can be taken.

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 30ae6638ff54..f96351da1e3e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -109,38 +109,43 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
  * This function reserves memory area given in "crashkernel=" kernel command
  * line parameter. The memory reserved is used by dump capture kernel when
  * primary kernel is crashing.
+ *
+ * NOTE: Reservation of crashkernel,low is special since its existence
+ * is not independent, need rely on the existence of crashkernel,high.
+ * Hence there are different cases for crashkernel,low reservation:
+ * 1) crashkernel=Y,low is specified explicitly, crashkernel,low takes Y;
+ * 2) crashkernel=,low is not given, while crashkernel=,high is specified,
+ *    take the default crashkernel,low value;
+ * 3) crashkernel=X is specified, while fallback to get a memory region
+ *    in high memory, take the default crashkernel,low value;
+ * 4) crashkernel='invalid value',low is specified, failed the whole
+ *    crashkernel reservation and bail out.
  */
 static void __init reserve_crashkernel(void)
 {
 	unsigned long long crash_base, crash_size;
 	unsigned long long crash_low_size;
 	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
-	int ret;
 	bool fixed_base, high = false;
 	char *cmdline = boot_command_line;
+	int ret;
 
 	/* crashkernel=X[@offset] */
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
 				&crash_size, &crash_base);
 	if (ret || !crash_size) {
-		/* crashkernel=X,high */
 		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
 		if (ret || !crash_size)
 			return;
 
-		/* crashkernel=Y,low */
 		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
 		if (ret == -ENOENT)
-			/*
-			 * crashkernel=Y,low is not specified explicitly, use
-			 * default size automatically.
-			 */
+			/* case #2 of crashkernel,low reservation */
 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
 		else if (ret)
-			/* crashkernel=Y,low is specified but Y is invalid */
+			/* case #4 of crashkernel,low reservation */
 			return;
 
-		/* Mark crashkernel=X,high is specified */
 		high = true;
 		crash_max = CRASH_ADDR_HIGH_MAX;
 	}
@@ -148,7 +153,6 @@ static void __init reserve_crashkernel(void)
 	fixed_base = !!crash_base;
 	crash_size = PAGE_ALIGN(crash_size);
 
-	/* User specifies base address explicitly. */
 	if (fixed_base)
 		crash_max = crash_base + crash_size;
 
@@ -172,11 +176,7 @@ static void __init reserve_crashkernel(void)
 	}
 
 	if (crash_base >= SZ_4G) {
-		/*
-		 * For case crashkernel=X, low memory is not enough and fall
-		 * back to reserve specified size of memory above 4G, try to
-		 * allocate minimum required memory below 4G again.
-		 */
+		/* case #3 of crashkernel,low reservation */
 		if (!high)
 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
 

>  
> -	/* Current arm64 boot protocol requires 2MB alignment */
> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
> +retry:
> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>  					       crash_base, crash_max);
>  	if (!crash_base) {
> +		/*
> +		 * Attempt to fully allocate low memory failed, fall back
> +		 * to high memory, the minimum required low memory will be
> +		 * reserved later.
> +		 */
> +		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
> +			crash_max = CRASH_ADDR_HIGH_MAX;
> +			goto retry;
> +		}
> +
>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>  			crash_size);
>  		return;
>  	}
>  
> +	if (crash_base >= SZ_4G) {
> +		/*
> +		 * For case crashkernel=X, low memory is not enough and fall
> +		 * back to reserve specified size of memory above 4G, try to
> +		 * allocate minimum required memory below 4G again.
> +		 */
> +		if (!high)
> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> +
> +		if (reserve_crashkernel_low(crash_low_size)) {
> +			memblock_phys_free(crash_base, crash_size);
> +			return;
> +		}
> +	}
> +
>  	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
>  		crash_base, crash_base + crash_size, crash_size >> 20);
>  
> @@ -107,6 +194,9 @@ static void __init reserve_crashkernel(void)
>  	 * map. Inform kmemleak so that it won't try to access it.
>  	 */
>  	kmemleak_ignore_phys(crash_base);
> +	if (crashk_low_res.end)
> +		kmemleak_ignore_phys(crashk_low_res.start);
> +
>  	crashk_res.start = crash_base;
>  	crashk_res.end = crash_base + crash_size - 1;
>  	insert_resource(&iomem_resource, &crashk_res);
> -- 
> 2.25.1
> 

