Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0226D496584
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiAUTUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:20:55 -0500
Received: from foss.arm.com ([217.140.110.172]:59038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbiAUTUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:20:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FB156D;
        Fri, 21 Jan 2022 11:20:54 -0800 (PST)
Received: from [10.57.68.26] (unknown [10.57.68.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E48433F73D;
        Fri, 21 Jan 2022 11:20:52 -0800 (PST)
Message-ID: <f9a34680-58b0-c619-cb75-af7bc4439e54@arm.com>
Date:   Fri, 21 Jan 2022 19:20:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] iommu: Fix potential use-after-free during probe
Content-Language: en-GB
To:     Vijayanand Jitta <vjitta@codeaurora.org>,
        Vijayanand Jitta <quic_vjitta@quicinc.com>, joro@8bytes.org,
        will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com
References: <1641993184-1232-1-git-send-email-quic_vjitta@quicinc.com>
 <9913d026-fddd-c188-0873-0f7a66fb2c3c@arm.com>
 <5f923b2d-645c-a7df-e16b-e8526015db32@quicinc.com>
 <348bccb5-ae73-d8ea-8450-8c0de92ec497@codeaurora.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <348bccb5-ae73-d8ea-8450-8c0de92ec497@codeaurora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-21 07:16, Vijayanand Jitta wrote:
> 
> 
> On 1/18/2022 9:27 PM, Vijayanand Jitta wrote:
>>
>>
>> On 1/18/2022 7:19 PM, Robin Murphy wrote:
>>> On 2022-01-12 13:13, Vijayanand Jitta wrote:
>>>> Kasan has reported the following use after free on dev->iommu.
>>>> when a device probe fails and it is in process of freeing dev->iommu
>>>> in dev_iommu_free function, a deferred_probe_work_func runs in parallel
>>>> and tries to access dev->iommu->fwspec in of_iommu_configure path thus
>>>> causing use after free.
>>>>
>>>> BUG: KASAN: use-after-free in of_iommu_configure+0xb4/0x4a4
>>>> Read of size 8 at addr ffffff87a2f1acb8 by task kworker/u16:2/153
>>>>
>>>> Workqueue: events_unbound deferred_probe_work_func
>>>> Call trace:
>>>>    dump_backtrace+0x0/0x33c
>>>>    show_stack+0x18/0x24
>>>>    dump_stack_lvl+0x16c/0x1e0
>>>>    print_address_description+0x84/0x39c
>>>>    __kasan_report+0x184/0x308
>>>>    kasan_report+0x50/0x78
>>>>    __asan_load8+0xc0/0xc4
>>>>    of_iommu_configure+0xb4/0x4a4
>>>>    of_dma_configure_id+0x2fc/0x4d4
>>>>    platform_dma_configure+0x40/0x5c
>>>>    really_probe+0x1b4/0xb74
>>>>    driver_probe_device+0x11c/0x228
>>>>    __device_attach_driver+0x14c/0x304
>>>>    bus_for_each_drv+0x124/0x1b0
>>>>    __device_attach+0x25c/0x334
>>>>    device_initial_probe+0x24/0x34
>>>>    bus_probe_device+0x78/0x134
>>>>    deferred_probe_work_func+0x130/0x1a8
>>>>    process_one_work+0x4c8/0x970
>>>>    worker_thread+0x5c8/0xaec
>>>>    kthread+0x1f8/0x220
>>>>    ret_from_fork+0x10/0x18
>>>>
>>>> Allocated by task 1:
>>>>    ____kasan_kmalloc+0xd4/0x114
>>>>    __kasan_kmalloc+0x10/0x1c
>>>>    kmem_cache_alloc_trace+0xe4/0x3d4
>>>>    __iommu_probe_device+0x90/0x394
>>>>    probe_iommu_group+0x70/0x9c
>>>>    bus_for_each_dev+0x11c/0x19c
>>>>    bus_iommu_probe+0xb8/0x7d4
>>>>    bus_set_iommu+0xcc/0x13c
>>>>    arm_smmu_bus_init+0x44/0x130 [arm_smmu]
>>>>    arm_smmu_device_probe+0xb88/0xc54 [arm_smmu]
>>>>    platform_drv_probe+0xe4/0x13c
>>>>    really_probe+0x2c8/0xb74
>>>>    driver_probe_device+0x11c/0x228
>>>>    device_driver_attach+0xf0/0x16c
>>>>    __driver_attach+0x80/0x320
>>>>    bus_for_each_dev+0x11c/0x19c
>>>>    driver_attach+0x38/0x48
>>>>    bus_add_driver+0x1dc/0x3a4
>>>>    driver_register+0x18c/0x244
>>>>    __platform_driver_register+0x88/0x9c
>>>>    init_module+0x64/0xff4 [arm_smmu]
>>>>    do_one_initcall+0x17c/0x2f0
>>>>    do_init_module+0xe8/0x378
>>>>    load_module+0x3f80/0x4a40
>>>>    __se_sys_finit_module+0x1a0/0x1e4
>>>>    __arm64_sys_finit_module+0x44/0x58
>>>>    el0_svc_common+0x100/0x264
>>>>    do_el0_svc+0x38/0xa4
>>>>    el0_svc+0x20/0x30
>>>>    el0_sync_handler+0x68/0xac
>>>>    el0_sync+0x160/0x180
>>>>
>>>> Freed by task 1:
>>>>    kasan_set_track+0x4c/0x84
>>>>    kasan_set_free_info+0x28/0x4c
>>>>    ____kasan_slab_free+0x120/0x15c
>>>>    __kasan_slab_free+0x18/0x28
>>>>    slab_free_freelist_hook+0x204/0x2fc
>>>>    kfree+0xfc/0x3a4
>>>>    __iommu_probe_device+0x284/0x394
>>>>    probe_iommu_group+0x70/0x9c
>>>>    bus_for_each_dev+0x11c/0x19c
>>>>    bus_iommu_probe+0xb8/0x7d4
>>>>    bus_set_iommu+0xcc/0x13c
>>>>    arm_smmu_bus_init+0x44/0x130 [arm_smmu]
>>>>    arm_smmu_device_probe+0xb88/0xc54 [arm_smmu]
>>>>    platform_drv_probe+0xe4/0x13c
>>>>    really_probe+0x2c8/0xb74
>>>>    driver_probe_device+0x11c/0x228
>>>>    device_driver_attach+0xf0/0x16c
>>>>    __driver_attach+0x80/0x320
>>>>    bus_for_each_dev+0x11c/0x19c
>>>>    driver_attach+0x38/0x48
>>>>    bus_add_driver+0x1dc/0x3a4
>>>>    driver_register+0x18c/0x244
>>>>    __platform_driver_register+0x88/0x9c
>>>>    init_module+0x64/0xff4 [arm_smmu]
>>>>    do_one_initcall+0x17c/0x2f0
>>>>    do_init_module+0xe8/0x378
>>>>    load_module+0x3f80/0x4a40
>>>>    __se_sys_finit_module+0x1a0/0x1e4
>>>>    __arm64_sys_finit_module+0x44/0x58
>>>>    el0_svc_common+0x100/0x264
>>>>    do_el0_svc+0x38/0xa4
>>>>    el0_svc+0x20/0x30
>>>>    el0_sync_handler+0x68/0xac
>>>>    el0_sync+0x160/0x180
>>>>
>>>> Fix this by taking device_lock during probe_iommu_group.
>>>>
>>>> Signed-off-by: Vijayanand Jitta <quic_vjitta@quicinc.com>
>>>> ---
>>>>    drivers/iommu/iommu.c | 12 ++++++++----
>>>>    1 file changed, 8 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index dd7863e..261792d 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -1617,7 +1617,7 @@ static int probe_iommu_group(struct device *dev,
>>>> void *data)
>>>>    {
>>>>        struct list_head *group_list = data;
>>>>        struct iommu_group *group;
>>>> -    int ret;
>>>> +    int ret = 0;
>>>>          /* Device is probed already if in a group */
>>>>        group = iommu_group_get(dev);
>>>> @@ -1626,9 +1626,13 @@ static int probe_iommu_group(struct device
>>>> *dev, void *data)
>>>>            return 0;
>>>>        }
>>>>    -    ret = __iommu_probe_device(dev, group_list);
>>>> -    if (ret == -ENODEV)
>>>> -        ret = 0;
>>>> +    ret = device_trylock(dev);
>>>> +    if (ret) {
>>>
>>> This doesn't seem right - we can't have a non-deterministic situation
>>> where __iommu_probe_device() may or may not be called depending on what
>>> anyone else might be doing with the device at the same time.
>>>
>>> I don't fully understand how __iommu_probe_device() and
>>> of_iommu_configure() can be running for the same device at the same
>>> time, but if that's not a race which can be fixed in its own right, then
>>
>> Thanks for the review comments.
>>
>> During arm_smmu probe, bus_for_each_dev is called which calls
>> __iommu_probe_device for each all the devs on that bus.
>>
>>     __iommu_probe_device+0x90/0x394
>>     probe_iommu_group+0x70/0x9c
>>     bus_for_each_dev+0x11c/0x19c
>>     bus_iommu_probe+0xb8/0x7d4
>>     bus_set_iommu+0xcc/0x13c
>>     arm_smmu_bus_init+0x44/0x130 [arm_smmu]
>>     arm_smmu_device_probe+0xb88/0xc54 [arm_smmu]
>>
>> and the deferred probe function is calling of_iommu_configure on the
>> same dev which is currently in __iommu_probe_device path in this case
>> thus causing the race.
>>
>>> I think adding a refcount to dev_iommu would be a more sensible way to
>>> mitigate it.
>>
>> Right, Adding refcount for dev_iommu should help , I'll post a new patch
>> with it.
>>
> 
> I was seeing if refcount would help here, there is some issues if we add
> a refcount within struct dev_iommu
> 
> Here the race between below two functions
> 
> process 1:
> static void dev_iommu_free(struct device *dev)
> {
>           iommu_fwspec_free(dev);
>           kfree(dev->iommu);
>           dev->iommu = NULL;
> }
> 
> Process 2:
> static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
> {
>           if (dev->iommu)
>                   return dev->iommu->fwspec;
>           else
>                   return NULL;
> }
> 
> 
> when process1 is in kfree(dev->iommu) , process2 passes the check of
> if(dev->iommu) and later get the use after free error when it accesses
> dev->iomm->fwspec.
> 
> Even if we add a refcount within dev_iommu and then call dev_iommu_free
> when refcount reaches 0, we later can't check this refcount in
> dev_iommu_fwspec_get since its already freed with kfree.
> Another issue is iommu_fwspec_free which is called within dev_iommu_free
> calls dev_iommu_fwspec_get , so this again causes issue with refcount.
> 
> So, I was thinking of adding something like a bool var iommu_dev_set
> with in struct device itself and we initialize during dev_iommu_get and
> set it to zero in dev_iommu_free, rest of the places we just check it.
> 
> Any thoughts on this ?

Well, yeah... "adding a refcount to dev_iommu" doesn't mean literally 
just bodging an extra variable into code not designed for concurrency, 
it was meant to imply "thoroughly redesign the current dev_iommu 
interfaces to work in a reference-counted manner which actually 
acknowledges concurrent usage". The places that currently call 
dev_iommu_free() would still set dev->iommu to NULL, *then* drop the 
reference from iommu_probe_device(). There wouldn't even need to be an 
iommu_fwspec_free() any more, just an iommu_fwspec_put() that releases 
the reference from iommu_fwspec_get(), and so on. Having thought it 
through this far, though, there are some fiddly bits, and it worries me 
that it might be getting too complex for a quick fix, where the real 
problem is that the concurrency shouldn't exist in the first place.

Is just bodging dev_iommu_free() into a more sensible order enough to 
hide the problem for now? Strictly it might want a memory barrier in 
there, but memory ordering is not what I want to be thinking about at 
dinnertime on a Friday :)

Robin

----->8-----
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8b86406b7162..9d58a515709e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -207,9 +207,14 @@ static struct dev_iommu *dev_iommu_get(struct 
device *dev)

  static void dev_iommu_free(struct device *dev)
  {
-	iommu_fwspec_free(dev);
-	kfree(dev->iommu);
+	struct dev_iommu *param = dev->iommu;
+
  	dev->iommu = NULL;
+	if (param->fwspec) {
+		fwnode_handle_put(param->fwspec->iommu_fwnode);
+		kfree(param->fwspec);
+	}
+	kfree(param);
  }

  static int __iommu_probe_device(struct device *dev, struct list_head 
*group_list)
@@ -2901,13 +2906,7 @@ EXPORT_SYMBOL_GPL(iommu_fwspec_init);

  void iommu_fwspec_free(struct device *dev)
  {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	if (fwspec) {
-		fwnode_handle_put(fwspec->iommu_fwnode);
-		kfree(fwspec);
-		dev_iommu_fwspec_set(dev, NULL);
-	}
+	/*TODO: dev_iommu made this redundant */
  }
  EXPORT_SYMBOL_GPL(iommu_fwspec_free);

