Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05CD5761D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbiGOMhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 08:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbiGOMhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:37:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80AB682FAC;
        Fri, 15 Jul 2022 05:37:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B22081474;
        Fri, 15 Jul 2022 05:37:24 -0700 (PDT)
Received: from [10.57.86.139] (unknown [10.57.86.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 712783F73D;
        Fri, 15 Jul 2022 05:37:22 -0700 (PDT)
Message-ID: <6557623d-3e4e-9f3e-e735-fd9654305f65@arm.com>
Date:   Fri, 15 Jul 2022 13:37:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 01/15] iommu/vt-d: Handle race between registration and
 device probe
Content-Language: en-GB
To:     Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1657034827.git.robin.murphy@arm.com>
 <894db0ccae854b35c73814485569b634237b5538.1657034828.git.robin.murphy@arm.com>
 <903a1677-4217-d793-6295-3927143d98fb@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <903a1677-4217-d793-6295-3927143d98fb@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-08 08:52, Baolu Lu wrote:
> On 2022/7/6 01:08, Robin Murphy wrote:
>> That also highlights an issue with intel_iommu_get_resv_regions() taking
>> dmar_global_lock from within a section where intel_iommu_init() already
>> holds it, which already exists via probe_acpi_namespace_devices() when
>> an ANDD device is probed, but gets more obvious with the upcoming change
>> to iommu_device_register(). Since they are both read locks it manages
>> not to deadlock in practice, so I'm leaving it here for someone with
>> more confidence to tackle a larger rework of the locking.
> 
> I am trying to reproduce this problem. Strangely, even if I selected
> CONFIG_LOCKDEP=y, the kernel didn't complain anything. :-)

FWIW, see below for the full report I get with this series applied (my 
machine doesn't have any ANDD entries to trigger the existing case).

> In fact the rmrr list in the Intel IOMMU driver is always static after
> parsing the ACPI/DMAR tables. There's no need to protect it with a lock.
> Hence we can safely remove below down/up_read().

IIRC that leads to RCU warnings via for_each_dev_scope(), though. I did 
try replacing this down_read() with rcu_read_lock(), but then it doesn't 
like the GFP_KERNEL allocation in iommu_alloc_resv_region(), and that's 
where I gave up :)

I'm mostly left wondering whether the dmar_drhd_units list really needs 
to be RCU protected at all, as that seems to be the root of most of the 
problems here.

Cheers,
Robin.

> 4512 static void intel_iommu_get_resv_regions(struct device *device,
> 4513                                          struct list_head *head)
> 4514 {
> 4515         int prot = DMA_PTE_READ | DMA_PTE_WRITE;
> 4516         struct iommu_resv_region *reg;
> 4517         struct dmar_rmrr_unit *rmrr;
> 4518         struct device *i_dev;
> 4519         int i;
> 4520
> 4521         down_read(&dmar_global_lock);
> 4522         for_each_rmrr_units(rmrr) {
> 4523                 for_each_active_dev_scope(rmrr->devices, 
> rmrr->devices_cnt,
> 4524                                           i, i_dev) {
> 
> Best regards,
> baolu


---->8-----

[   11.421712] pci 0000:00:1b.0: Adding to iommu group 0
[   11.421977]
[   11.421978] ============================================
[   11.421979] WARNING: possible recursive locking detected
[   11.421981] 5.19.0-rc3-00015-gdc44a2269276 #32 Not tainted
[   11.421984] --------------------------------------------
[   11.421985] swapper/0/1 is trying to acquire lock:
[   11.421986] ffffffffb987b770 (dmar_global_lock){++++}-{3:3}, at: 
intel_iommu_get_resv_regions+0x28/0x3a0
[   11.422000]
[   11.422000] but task is already holding lock:
[   11.422001] ffffffffb987b770 (dmar_global_lock){++++}-{3:3}, at: 
intel_iommu_init+0x1638/0x1a08
[   11.422011]
[   11.422011] other info that might help us debug this:
[   11.422013]  Possible unsafe locking scenario:
[   11.422013]
[   11.422013]        CPU0
[   11.422014]        ----
[   11.422015]   lock(dmar_global_lock);
[   11.422018]   lock(dmar_global_lock);
[   11.422020]
[   11.422020]  *** DEADLOCK ***
[   11.422020]
[   11.422021]  May be due to missing lock nesting notation
[   11.422021]
[   11.422022] 2 locks held by swapper/0/1:
[   11.422024]  #0: ffffffffb987b770 (dmar_global_lock){++++}-{3:3}, at: 
intel_iommu_init+0x1638/0x1a08
[   11.422033]  #1: ffff8881077a10c0 (&group->mutex){+.+.}-{3:3}, at: 
bus_iommu_probe+0x139/0x4c0
[   11.422044]
[   11.422044] stack backtrace:
[   11.422046] CPU: 8 PID: 1 Comm: swapper/0 Not tainted 
5.19.0-rc3-00015-gdc44a2269276 #32
[   11.422050] Hardware name: LENOVO 30B6S08J03/1030, BIOS S01KT29A 
06/20/2016
[   11.422052] Call Trace:
[   11.422054]  <TASK>
[   11.422056]  dump_stack_lvl+0x45/0x59
[   11.422064]  __lock_acquire.cold+0x131/0x305
[   11.422075]  ? lockdep_hardirqs_on_prepare+0x220/0x220
[   11.422082]  ? lock_is_held_type+0xd7/0x130
[   11.422090]  ? rcu_read_lock_sched_held+0x9c/0xd0
[   11.422098]  lock_acquire+0x165/0x410
[   11.422102]  ? intel_iommu_get_resv_regions+0x28/0x3a0
[   11.422108]  ? lock_release+0x410/0x410
[   11.422112]  ? __iommu_domain_alloc+0xc5/0x130
[   11.422116]  ? iommu_group_alloc_default_domain+0x16/0x90
[   11.422121]  ? bus_iommu_probe+0x26d/0x4c0
[   11.422126]  ? iommu_device_register+0x11e/0x160
[   11.422130]  ? intel_iommu_init+0x16e0/0x1a08
[   11.422135]  ? do_one_initcall+0xb6/0x3c0
[   11.422140]  ? lock_is_held_type+0xd7/0x130
[   11.422147]  down_read+0x97/0x2f0
[   11.422152]  ? intel_iommu_get_resv_regions+0x28/0x3a0
[   11.422156]  ? rcu_read_lock_bh_held+0xb0/0xb0
[   11.422161]  ? rwsem_down_read_slowpath+0xa10/0xa10
[   11.422166]  ? find_held_lock+0x85/0xa0
[   11.422173]  intel_iommu_get_resv_regions+0x28/0x3a0
[   11.422178]  ? rcu_read_lock_sched_held+0x9c/0xd0
[   11.422185]  iommu_create_device_direct_mappings.isra.0+0x11a/0x330
[   11.422193]  ? iommu_map+0x50/0x50
[   11.422198]  ? __iommu_domain_alloc+0xc5/0x130
[   11.422205]  bus_iommu_probe+0x2bc/0x4c0
[   11.422210]  ? iommu_device_register+0xba/0x160
[   11.422216]  ? iommu_group_default_domain+0x20/0x20
[   11.422221]  ? do_raw_spin_lock+0x114/0x1d0
[   11.422226]  ? rwlock_bug.part.0+0x50/0x50
[   11.422231]  ? rwsem_down_read_slowpath+0xa10/0xa10
[   11.422239]  iommu_device_register+0x11e/0x160
[   11.422244]  intel_iommu_init+0x16e0/0x1a08
[   11.422249]  ? rcu_read_lock_bh_held+0xb0/0xb0
[   11.422254]  ? _raw_spin_unlock_irqrestore+0x28/0x50
[   11.422261]  ? lock_release+0x240/0x410
[   11.422265]  ? populate_rootfs+0x26/0x37
[   11.422272]  ? lock_downgrade+0x3a0/0x3a0
[   11.422277]  ? dmar_parse_one_rmrr+0x203/0x203
[   11.422281]  ? lock_is_held_type+0xd7/0x130
[   11.422286]  ? iommu_setup+0x282/0x282
[   11.422291]  ? rcu_read_lock_sched_held+0x9c/0xd0
[   11.422296]  ? rcu_read_lock_bh_held+0xb0/0xb0
[   11.422301]  ? up_write+0xd3/0x260
[   11.422305]  ? iommu_setup+0x282/0x282
[   11.422309]  pci_iommu_init+0x15/0x39
[   11.422313]  do_one_initcall+0xb6/0x3c0
[   11.422317]  ? initcall_blacklisted+0x120/0x120
[   11.422322]  ? rcu_read_lock_sched_held+0x9c/0xd0
[   11.422327]  ? rcu_read_lock_bh_held+0xb0/0xb0
[   11.422331]  ? kasan_unpoison+0x23/0x50
[   11.422337]  ? __kasan_slab_alloc+0x2c/0x80
[   11.422344]  kernel_init_freeable+0x330/0x389
[   11.422349]  ? rest_init+0x1b0/0x1b0
[   11.422354]  kernel_init+0x14/0x130
[   11.422359]  ret_from_fork+0x22/0x30
[   11.422367]  </TASK>

