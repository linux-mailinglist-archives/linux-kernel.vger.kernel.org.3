Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681105665D1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiGEJGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiGEJGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:06:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C5BC6459
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 02:06:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1563152B;
        Tue,  5 Jul 2022 02:06:32 -0700 (PDT)
Received: from [10.57.86.91] (unknown [10.57.86.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF36E3F792;
        Tue,  5 Jul 2022 02:06:30 -0700 (PDT)
Message-ID: <d36c80e3-2b04-b83b-3eb6-0f1d66d68fcf@arm.com>
Date:   Tue, 5 Jul 2022 10:06:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 03/14] iommu: Move bus setup to IOMMU device
 registration
Content-Language: en-GB
To:     Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org
Cc:     jean-philippe@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
        gerald.schaefer@linux.ibm.com
References: <cover.1650890638.git.robin.murphy@arm.com>
 <1faba5b5c094379df3d99b8fec924ab50ad75482.1650890638.git.robin.murphy@arm.com>
 <0e459e6e-f236-7a58-970a-a47677a23b44@linux.intel.com>
 <fa0d0663-5393-c533-105a-85bd2e9e0649@arm.com>
 <1322706e-5905-433b-5bc5-ed44f881b510@arm.com>
 <fc0ddc34-e289-d225-f9ae-bf629e834a6b@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <fc0ddc34-e289-d225-f9ae-bf629e834a6b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-05 05:51, Baolu Lu wrote:
> Hi Robin,
> 
> On 2022/4/30 02:06, Robin Murphy wrote:
>> On 29/04/2022 9:50 am, Robin Murphy wrote:
>>> On 2022-04-29 07:57, Baolu Lu wrote:
>>>> Hi Robin,
>>>>
>>>> On 2022/4/28 21:18, Robin Murphy wrote:
>>>>> Move the bus setup to iommu_device_register(). This should allow
>>>>> bus_iommu_probe() to be correctly replayed for multiple IOMMU 
>>>>> instances,
>>>>> and leaves bus_set_iommu() as a glorified no-op to be cleaned up next.
>>>>
>>>> I re-fetched the latest patches on
>>>>
>>>> https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu/bus
>>>>
>>>> and rolled back the head to "iommu: Cleanup bus_set_iommu".
>>>>
>>>> The test machine still hangs during boot.
>>>>
>>>> I went through the code. It seems that the .probe_device for Intel 
>>>> IOMMU
>>>> driver can't handle the probe replay well. It always assumes that the
>>>> device has never been probed.
>>>
>>> Hmm, but probe_iommu_group() is supposed to prevent the 
>>> __iommu_probe_device() call even happening if the device *has* 
>>> already been probed before :/
>>>
>>> I've still got an old Intel box spare in the office so I'll rig that 
>>> up and see if I can see what might be going on here...
>>
>> OK, on a Xeon with two DMAR units, this seems to boot OK with or 
>> without patch #1, so it doesn't seem to be a general problem with 
>> replaying in iommu_device_register(), or with platform devices. Not 
>> sure where to go from here... :/
> 
> The kernel boot panic message:
> 
> [    6.639432] BUG: kernel NULL pointer dereference, address: 
> 0000000000000028
> [    6.743829] #PF: supervisor read access in kernel mode
> [    6.743829] #PF: error_code(0x0000) - not-present page
> [    6.743829] PGD 0
> [    6.743829] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [    6.743829] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G          I 
>   5.19.0-rc3+ #182
> [    6.743829] RIP: 0010:__iommu_probe_device+0x115/0x200
> [    6.743829] Code: 89 ff e8 3e e1 ff ff 48 85 c0 0f 85 47 ff ff ff 41 
> bd f4 ff ff ff eb 83 48 8b 83 d8 02 00 00 48 89 df 48 8b 40 38 48 8b 40 
> 10 <48> 8b 40 28 ff d0 0f 1f 00 48 89 c1 48 85 c0 0f 84 b7 00 00 00 48
> [    6.743829] RSP: 0000:ff30605c00063d40 EFLAGS: 00010246
> [    6.743829] RAX: 0000000000000000 RBX: ff128b9c5fdc90d0 RCX: 
> 0000000000000000
> [    6.743829] RDX: 0000000080000001 RSI: 0000000000000246 RDI: 
> ff128b9c5fdc90d0
> [    6.743829] RBP: ffffffffb60c34e0 R08: ffffffffb68664d0 R09: 
> ff128b9501d4ce40
> [    6.743829] R10: ffffffffb6267096 R11: ff128b950014c267 R12: 
> ff30605c00063de0
> [    6.743829] R13: 00000000001b9d28 R14: ff128b95001b9d28 R15: 
> ff128b9c5fdc93a8
> [    6.743829] FS:  0000000000000000(0000) GS:ff128b9c5fc00000(0000) 
> knlGS:0000000000000000
> [    6.743829] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    6.743829] CR2: 0000000000000028 CR3: 0000000149210001 CR4: 
> 0000000000771ef0
> [    6.743829] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [    6.743829] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 
> 0000000000000400
> [    6.743829] PKRU: 55555554
> [    6.743829] Call Trace:
> [    6.743829]  <TASK>
> [    6.743829]  ? _raw_spin_lock_irqsave+0x17/0x40
> [    6.743829]  ? __iommu_probe_device+0x200/0x200
> [    6.743829]  probe_iommu_group+0x2d/0x40
> [    6.743829]  bus_for_each_dev+0x74/0xc0
> [    6.743829]  bus_iommu_probe+0x48/0x2d0
> [    6.743829]  iommu_device_register+0xde/0x120
> [    6.743829]  intel_iommu_init+0x35f/0x5f2
> [    6.743829]  ? iommu_setup+0x27d/0x27d
> [    6.743829]  ? rdinit_setup+0x2c/0x2c
> [    6.743829]  pci_iommu_init+0xe/0x32
> [    6.743829]  do_one_initcall+0x41/0x200
> [    6.743829]  kernel_init_freeable+0x1de/0x228
> [    6.743829]  ? rest_init+0xc0/0xc0
> [    6.743829]  kernel_init+0x16/0x120
> [    6.743829]  ret_from_fork+0x1f/0x30
> [    6.743829]  </TASK>
> [    6.743829] Modules linked in:
> [    6.743829] CR2: 0000000000000028
> [    6.743829] ---[ end trace 0000000000000000 ]---
> [    6.743829] RIP: 0010:__iommu_probe_device+0x115/0x200
> [    6.743829] Code: 89 ff e8 3e e1 ff ff 48 85 c0 0f 85 47 ff ff ff 41 
> bd f4 ff ff ff eb 83 48 8b 83 d8 02 00 00 48 89 df 48 8b 40 38 48 8b 40 
> 10 <48> 8b 40 28 ff d0 0f 1f 00 48 89 c1 48 85 c0 0f 84 b7 00 00 00 48
> [    6.743829] RSP: 0000:ff30605c00063d40 EFLAGS: 00010246
> [    6.743829] RAX: 0000000000000000 RBX: ff128b9c5fdc90d0 RCX: 
> 0000000000000000
> [    6.743829] RDX: 0000000080000001 RSI: 0000000000000246 RDI: 
> ff128b9c5fdc90d0
> [    6.743829] RBP: ffffffffb60c34e0 R08: ffffffffb68664d0 R09: 
> ff128b9501d4ce40
> [    6.743829] R10: ffffffffb6267096 R11: ff128b950014c267 R12: 
> ff30605c00063de0
> [    6.743829] R13: 00000000001b9d28 R14: ff128b95001b9d28 R15: 
> ff128b9c5fdc93a8
> [    6.743829] FS:  0000000000000000(0000) GS:ff128b9c5fc00000(0000) 
> knlGS:0000000000000000
> [    6.743829] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    6.743829] CR2: 0000000000000028 CR3: 0000000149210001 CR4: 
> 0000000000771ef0
> [    6.743829] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [    6.743829] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 
> 0000000000000400
> [    6.743829] PKRU: 55555554
> [    6.743829] Kernel panic - not syncing: Fatal exception
> [    6.743829] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> The "NULL pointer dereference" happens at line 1620 of below code.
> 
> 1610 static struct iommu_group *iommu_group_get_for_dev(struct device *dev)
> 1611 {
> 1612         const struct iommu_ops *ops = dev_iommu_ops(dev);
> 1613         struct iommu_group *group;
> 1614         int ret;
> 1615
> 1616         group = iommu_group_get(dev);
> 1617         if (group)
> 1618                 return group;
> 1619
> 1620         group = ops->device_group(dev);
> 1621         if (WARN_ON_ONCE(group == NULL))
> 1622                 return ERR_PTR(-EINVAL);
> 1623
> 1624         if (IS_ERR(group))
> 1625                 return group;
> 
> This platform has multiple IOMMU units, each serving different PCI
> devices. The ops field of each iommu_device is initialized in
> iommu_device_register(), hence when the first IOMMU device gets
> registered, ops fields of other iommu_devices are NULL.
> 
> Unfortunately bus_iommu_probe() called in iommu_device_register() probes
> *all* PCI devices. This probably leads to above NULL pointer dereference
> issue.
> 
> Please correct me if I overlooked anything.

Ha, as it happens I also just figured this out yesterday (after 
remembering the important detail of "intel_iommu=on", trying the lockdep 
test), so it's good to have confirmation, thanks! I'll test a fix today 
and send v3 soon.

Cheers,
Robin.
