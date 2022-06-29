Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FD55600C1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbiF2NDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiF2NDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:03:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F3F012092
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:03:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27317152B;
        Wed, 29 Jun 2022 06:03:29 -0700 (PDT)
Received: from [10.57.85.71] (unknown [10.57.85.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AACC3F792;
        Wed, 29 Jun 2022 06:03:27 -0700 (PDT)
Message-ID: <f3619c80-14d3-d934-755a-4c3734bfde20@arm.com>
Date:   Wed, 29 Jun 2022 14:03:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 5/7] iommu/vt-d: Fix suspicious RCU usage in
 probe_acpi_namespace_devices()
Content-Language: en-GB
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     kevin.tian@intel.com, ashok.raj@intel.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        cai@lca.pw, jacob.jun.pan@intel.com
References: <20190612002851.17103-1-baolu.lu@linux.intel.com>
 <20190612002851.17103-6-baolu.lu@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20190612002851.17103-6-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-12 01:28, Lu Baolu wrote:
> The drhd and device scope list should be iterated with the
> iommu global lock held. Otherwise, a suspicious RCU usage
> message will be displayed.
> 
> [    3.695886] =============================
> [    3.695917] WARNING: suspicious RCU usage
> [    3.695950] 5.2.0-rc2+ #2467 Not tainted
> [    3.695981] -----------------------------
> [    3.696014] drivers/iommu/intel-iommu.c:4569 suspicious rcu_dereference_check() usage!
> [    3.696069]
>                 other info that might help us debug this:
> 
> [    3.696126]
>                 rcu_scheduler_active = 2, debug_locks = 1
> [    3.696173] no locks held by swapper/0/1.
> [    3.696204]
>                 stack backtrace:
> [    3.696241] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc2+ #2467
> [    3.696370] Call Trace:
> [    3.696404]  dump_stack+0x85/0xcb
> [    3.696441]  intel_iommu_init+0x128c/0x13ce
> [    3.696478]  ? kmem_cache_free+0x16b/0x2c0
> [    3.696516]  ? __fput+0x14b/0x270
> [    3.696550]  ? __call_rcu+0xb7/0x300
> [    3.696583]  ? get_max_files+0x10/0x10
> [    3.696631]  ? set_debug_rodata+0x11/0x11
> [    3.696668]  ? e820__memblock_setup+0x60/0x60
> [    3.696704]  ? pci_iommu_init+0x16/0x3f
> [    3.696737]  ? set_debug_rodata+0x11/0x11
> [    3.696770]  pci_iommu_init+0x16/0x3f
> [    3.696805]  do_one_initcall+0x5d/0x2e4
> [    3.696844]  ? set_debug_rodata+0x11/0x11
> [    3.696880]  ? rcu_read_lock_sched_held+0x6b/0x80
> [    3.696924]  kernel_init_freeable+0x1f0/0x27c
> [    3.696961]  ? rest_init+0x260/0x260
> [    3.696997]  kernel_init+0xa/0x110
> [    3.697028]  ret_from_fork+0x3a/0x50
> 
> Fixes: fa212a97f3a36 ("iommu/vt-d: Probe DMA-capable ACPI name space devices")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel-iommu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 19c4c387a3f6..84e650c6a46d 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4793,8 +4793,10 @@ int __init intel_iommu_init(void)
>   	cpuhp_setup_state(CPUHP_IOMMU_INTEL_DEAD, "iommu/intel:dead", NULL,
>   			  intel_iommu_cpu_dead);
>   
> +	down_read(&dmar_global_lock);
>   	if (probe_acpi_namespace_devices())
>   		pr_warn("ACPI name space devices didn't probe correctly\n");
> +	up_read(&dmar_global_lock);

Doing a bit of archaeology here, is this actually broken? If any ANDD 
entries exist, we'd end up doing:

   down_read(&dmar_global_lock)
   probe_acpi_namespace_devices()
   -> iommu_probe_device()
      -> iommu_create_device_direct_mappings()
         -> iommu_get_resv_regions()
            -> intel_iommu_get_resv_regions()
               -> down_read(&dmar_global_lock)

I'm wondering whether this might explain why my bus_set_iommu series 
prevented Baolu's machine from booting, since "iommu: Move bus setup to 
IOMMU device registration" creates the same condition where we end up in 
get_resv_regions (via bus_iommu_probe() this time) from the same task 
that already holds dmar_global_lock. Of course that leaves me wondering 
how it *did* manage to boot OK on my Xeon box, but maybe there's a 
config difference or dumb luck at play?

Robin.

>   
>   	/* Finally, we enable the DMA remapping hardware. */
>   	for_each_iommu(iommu, drhd) {
