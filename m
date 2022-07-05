Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37E2566282
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 06:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiGEEvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 00:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGEEvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 00:51:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63125101C0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 21:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656996665; x=1688532665;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ct9HkUkrnk5nhlxXQ8iJ0J2EEXFdvdkjBbdBFA1gdng=;
  b=PyGqGXb69YJPggx7hbgIPMGCvHWjsVp2Wzo3fOHlz5KNAobKOidL01ME
   qhWDm+bOWlhf01lT1wJQ0CjUzKea1lAdr5MbdCd8xCESnVYmSXOrtaJRv
   o5aAQong+wMQ3daz7XNdHOCis93bYPiiodfo7yLzSG4qDI4pH29UpaeLP
   Dnc9gJz3Nyam0GPBG+tqNIPhOW63x9KsAVziMTnSW+M+6uUfbVxoAS69W
   +Y+sIhWEFmk62floOtf6w1GG/4EzXF9ad8oCW0VmIP82vc/ohpfn64Qxu
   WKW89E0vrEBh7f0RHw4SxlcekR9JKM317y4FMtnotuv6gl0CHSXvCHBmf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="283277725"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="283277725"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 21:51:04 -0700
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="649920196"
Received: from peiwenzx-mobl.ccr.corp.intel.com (HELO [10.249.173.7]) ([10.249.173.7])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 21:51:02 -0700
Message-ID: <fc0ddc34-e289-d225-f9ae-bf629e834a6b@linux.intel.com>
Date:   Tue, 5 Jul 2022 12:51:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, jean-philippe@linaro.org,
        zhang.lyra@gmail.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, thierry.reding@gmail.com,
        linux-arm-kernel@lists.infradead.org, gerald.schaefer@linux.ibm.com
Subject: Re: [PATCH v2 03/14] iommu: Move bus setup to IOMMU device
 registration
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1650890638.git.robin.murphy@arm.com>
 <1faba5b5c094379df3d99b8fec924ab50ad75482.1650890638.git.robin.murphy@arm.com>
 <0e459e6e-f236-7a58-970a-a47677a23b44@linux.intel.com>
 <fa0d0663-5393-c533-105a-85bd2e9e0649@arm.com>
 <1322706e-5905-433b-5bc5-ed44f881b510@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1322706e-5905-433b-5bc5-ed44f881b510@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 2022/4/30 02:06, Robin Murphy wrote:
> On 29/04/2022 9:50 am, Robin Murphy wrote:
>> On 2022-04-29 07:57, Baolu Lu wrote:
>>> Hi Robin,
>>>
>>> On 2022/4/28 21:18, Robin Murphy wrote:
>>>> Move the bus setup to iommu_device_register(). This should allow
>>>> bus_iommu_probe() to be correctly replayed for multiple IOMMU 
>>>> instances,
>>>> and leaves bus_set_iommu() as a glorified no-op to be cleaned up next.
>>>
>>> I re-fetched the latest patches on
>>>
>>> https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu/bus
>>>
>>> and rolled back the head to "iommu: Cleanup bus_set_iommu".
>>>
>>> The test machine still hangs during boot.
>>>
>>> I went through the code. It seems that the .probe_device for Intel IOMMU
>>> driver can't handle the probe replay well. It always assumes that the
>>> device has never been probed.
>>
>> Hmm, but probe_iommu_group() is supposed to prevent the 
>> __iommu_probe_device() call even happening if the device *has* already 
>> been probed before :/
>>
>> I've still got an old Intel box spare in the office so I'll rig that 
>> up and see if I can see what might be going on here...
> 
> OK, on a Xeon with two DMAR units, this seems to boot OK with or without 
> patch #1, so it doesn't seem to be a general problem with replaying in 
> iommu_device_register(), or with platform devices. Not sure where to go 
> from here... :/

The kernel boot panic message:

[    6.639432] BUG: kernel NULL pointer dereference, address: 
0000000000000028
[    6.743829] #PF: supervisor read access in kernel mode
[    6.743829] #PF: error_code(0x0000) - not-present page
[    6.743829] PGD 0
[    6.743829] Oops: 0000 [#1] PREEMPT SMP NOPTI
[    6.743829] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G          I 
  5.19.0-rc3+ #182
[    6.743829] RIP: 0010:__iommu_probe_device+0x115/0x200
[    6.743829] Code: 89 ff e8 3e e1 ff ff 48 85 c0 0f 85 47 ff ff ff 41 
bd f4 ff ff ff eb 83 48 8b 83 d8 02 00 00 48 89 df 48 8b 40 38 48 8b 40 
10 <48> 8b 40 28 ff d0 0f 1f 00 48 89 c1 48 85 c0 0f 84 b7 00 00 00 48
[    6.743829] RSP: 0000:ff30605c00063d40 EFLAGS: 00010246
[    6.743829] RAX: 0000000000000000 RBX: ff128b9c5fdc90d0 RCX: 
0000000000000000
[    6.743829] RDX: 0000000080000001 RSI: 0000000000000246 RDI: 
ff128b9c5fdc90d0
[    6.743829] RBP: ffffffffb60c34e0 R08: ffffffffb68664d0 R09: 
ff128b9501d4ce40
[    6.743829] R10: ffffffffb6267096 R11: ff128b950014c267 R12: 
ff30605c00063de0
[    6.743829] R13: 00000000001b9d28 R14: ff128b95001b9d28 R15: 
ff128b9c5fdc93a8
[    6.743829] FS:  0000000000000000(0000) GS:ff128b9c5fc00000(0000) 
knlGS:0000000000000000
[    6.743829] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.743829] CR2: 0000000000000028 CR3: 0000000149210001 CR4: 
0000000000771ef0
[    6.743829] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[    6.743829] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 
0000000000000400
[    6.743829] PKRU: 55555554
[    6.743829] Call Trace:
[    6.743829]  <TASK>
[    6.743829]  ? _raw_spin_lock_irqsave+0x17/0x40
[    6.743829]  ? __iommu_probe_device+0x200/0x200
[    6.743829]  probe_iommu_group+0x2d/0x40
[    6.743829]  bus_for_each_dev+0x74/0xc0
[    6.743829]  bus_iommu_probe+0x48/0x2d0
[    6.743829]  iommu_device_register+0xde/0x120
[    6.743829]  intel_iommu_init+0x35f/0x5f2
[    6.743829]  ? iommu_setup+0x27d/0x27d
[    6.743829]  ? rdinit_setup+0x2c/0x2c
[    6.743829]  pci_iommu_init+0xe/0x32
[    6.743829]  do_one_initcall+0x41/0x200
[    6.743829]  kernel_init_freeable+0x1de/0x228
[    6.743829]  ? rest_init+0xc0/0xc0
[    6.743829]  kernel_init+0x16/0x120
[    6.743829]  ret_from_fork+0x1f/0x30
[    6.743829]  </TASK>
[    6.743829] Modules linked in:
[    6.743829] CR2: 0000000000000028
[    6.743829] ---[ end trace 0000000000000000 ]---
[    6.743829] RIP: 0010:__iommu_probe_device+0x115/0x200
[    6.743829] Code: 89 ff e8 3e e1 ff ff 48 85 c0 0f 85 47 ff ff ff 41 
bd f4 ff ff ff eb 83 48 8b 83 d8 02 00 00 48 89 df 48 8b 40 38 48 8b 40 
10 <48> 8b 40 28 ff d0 0f 1f 00 48 89 c1 48 85 c0 0f 84 b7 00 00 00 48
[    6.743829] RSP: 0000:ff30605c00063d40 EFLAGS: 00010246
[    6.743829] RAX: 0000000000000000 RBX: ff128b9c5fdc90d0 RCX: 
0000000000000000
[    6.743829] RDX: 0000000080000001 RSI: 0000000000000246 RDI: 
ff128b9c5fdc90d0
[    6.743829] RBP: ffffffffb60c34e0 R08: ffffffffb68664d0 R09: 
ff128b9501d4ce40
[    6.743829] R10: ffffffffb6267096 R11: ff128b950014c267 R12: 
ff30605c00063de0
[    6.743829] R13: 00000000001b9d28 R14: ff128b95001b9d28 R15: 
ff128b9c5fdc93a8
[    6.743829] FS:  0000000000000000(0000) GS:ff128b9c5fc00000(0000) 
knlGS:0000000000000000
[    6.743829] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.743829] CR2: 0000000000000028 CR3: 0000000149210001 CR4: 
0000000000771ef0
[    6.743829] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[    6.743829] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 
0000000000000400
[    6.743829] PKRU: 55555554
[    6.743829] Kernel panic - not syncing: Fatal exception
[    6.743829] ---[ end Kernel panic - not syncing: Fatal exception ]---

The "NULL pointer dereference" happens at line 1620 of below code.

1610 static struct iommu_group *iommu_group_get_for_dev(struct device *dev)
1611 {
1612         const struct iommu_ops *ops = dev_iommu_ops(dev);
1613         struct iommu_group *group;
1614         int ret;
1615
1616         group = iommu_group_get(dev);
1617         if (group)
1618                 return group;
1619
1620         group = ops->device_group(dev);
1621         if (WARN_ON_ONCE(group == NULL))
1622                 return ERR_PTR(-EINVAL);
1623
1624         if (IS_ERR(group))
1625                 return group;

This platform has multiple IOMMU units, each serving different PCI
devices. The ops field of each iommu_device is initialized in
iommu_device_register(), hence when the first IOMMU device gets
registered, ops fields of other iommu_devices are NULL.

Unfortunately bus_iommu_probe() called in iommu_device_register() probes
*all* PCI devices. This probably leads to above NULL pointer dereference
issue.

Please correct me if I overlooked anything.

Best regards,
baolu
