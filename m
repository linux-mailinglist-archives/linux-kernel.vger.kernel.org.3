Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5AC5A25E8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245350AbiHZKdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343752AbiHZKdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:33:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4BD8D34CD;
        Fri, 26 Aug 2022 03:33:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7961823A;
        Fri, 26 Aug 2022 03:33:52 -0700 (PDT)
Received: from [10.57.46.92] (unknown [10.57.46.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E2FA3F93E;
        Fri, 26 Aug 2022 03:33:46 -0700 (PDT)
Message-ID: <0e676355-25fa-8527-a425-18c7f72c0215@arm.com>
Date:   Fri, 26 Aug 2022 12:33:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] irqchip/gic-v3-its: Remove cpumask_var_t allocation
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220825152348.1634133-1-pierre.gondois@arm.com>
 <875yigw64n.wl-maz@kernel.org>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <875yigw64n.wl-maz@kernel.org>
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

Hello Mark,

On 8/25/22 20:05, Marc Zyngier wrote:
> On Thu, 25 Aug 2022 16:23:48 +0100,
> Pierre Gondois <pierre.gondois@arm.com> wrote:
>>
>> In KvmTool, on a ThunderX2, when running a preemp_rt kernel based on
> 
> How is this specific to kvmtool? Or to running as a guest?

This is not specific to KvmTool/running as a guest. This can be reproduced
on an Ampere Altra for instance. KvmTool is mentioned here because this
was used as the test environment.

> 
>> v5.19-rc3-rt4, the following happens:
>> [    4.070739] [ BUG: Invalid wait context ]
>> [    4.070740] 5.19.0-rc3-rt4-00001-g1a6597c0bdcf #153 Not tainted
>> [    4.070742] -----------------------------
>> [    4.070743] swapper/0/1 is trying to lock:
>> [    4.070744] ffff0000ab7405d8 ((&c->lock)){+.+.}-{3:3}, at: ___slab_alloc (mm/slub.c:2954)
>> [    4.070757] other info that might help us debug this:
>> [    4.070758] context-{5:5}
>> [    4.070759] 5 locks held by swapper/0/1:
>> [    4.070760] #0: ffff0000811491e0 (&dev->mutex){....}-{4:4}, at: __device_driver_lock (drivers/base/dd.c:1055)
>> [    4.070769] #1: ffff0000846c5670 (&desc->request_mutex){+.+.}-{4:4}, at: __setup_irq (kernel/irq/internals.h:147)
>> [    4.070778] #2: ffff0000846c54c8 (&irq_desc_lock_class){....}-{2:2}, at: __setup_irq (kernel/irq/manage.c:1612)
>> [    4.070784] #3: ffff80000b23ea78 (mask_lock){....}-{2:2}, at: irq_setup_affinity (./include/linux/irq.h:381)
>> [    4.070791] #4: ffff80000b23ea38 (tmp_mask_lock){....}-{2:2}, at: irq_do_set_affinity (./include/linux/irq.h:381)
>> [    4.070797] stack backtrace:
>> [    4.070801] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc3-rt4-00001-g1a6597c0bdcf #153
>> [    4.070805] Call trace:
>> [    4.070806] dump_backtrace (arch/arm64/kernel/stacktrace.c:200)
>> [    4.070811] show_stack (arch/arm64/kernel/stacktrace.c:207)
>> [    4.070813] dump_stack_lvl (lib/dump_stack.c:107)
>> [    4.070818] dump_stack (lib/dump_stack.c:114)
>> [    4.070820] __lock_acquire (kernel/locking/lockdep.c:4707)
>> [    4.070823] lock_acquire (kernel/locking/lockdep.c:466)
>> [    4.070825] rt_spin_lock (./arch/arm64/include/asm/current.h:19 (discriminator 4))
>> [    4.070830] ___slab_alloc (mm/slub.c:2954)
>> [    4.070832] __slab_alloc.isra.0 (mm/slub.c:3116)
>> [    4.070835] __kmalloc_node (mm/slub.c:3207)
>> [    4.070837] alloc_cpumask_var_node (lib/cpumask.c:115)
>> [    4.070843] alloc_cpumask_var (lib/cpumask.c:147)
>> [    4.070846] its_select_cpu (drivers/irqchip/irq-gic-v3-its.c:1580)
>> [    4.070850] its_set_affinity (drivers/irqchip/irq-gic-v3-its.c:1659)
>> [    4.070853] msi_domain_set_affinity (kernel/irq/msi.c:501)
>> [    4.070857] irq_do_set_affinity (kernel/irq/manage.c:276)
>> [    4.070860] irq_setup_affinity (kernel/irq/manage.c:633)
>> [    4.070863] irq_startup (kernel/irq/chip.c:280)
>> [    4.070865] __setup_irq (kernel/irq/manage.c:1777)
>> [    4.070869] request_threaded_irq (kernel/irq/manage.c:2206)
>> [    4.070872] vp_find_vqs_msix (./include/linux/interrupt.h:168)
>> [    4.070876] vp_find_vqs (drivers/virtio/virtio_pci_common.c:400)
>> [    4.070878] vp_modern_find_vqs (drivers/virtio/virtio_pci_modern.c:259)
>> [    4.070880] init_vq (./include/linux/virtio_config.h:213)
>> [    4.070885] virtblk_probe (drivers/block/virtio_blk.c:936)
>> [    4.070887] virtio_dev_probe (drivers/virtio/virtio.c:303)
>> [    4.070892] really_probe (drivers/base/dd.c:555)
>> [    4.070895] __driver_probe_device (drivers/base/dd.c:764)
>> [    4.070897] driver_probe_device (drivers/base/dd.c:794)
>> [    4.070899] __driver_attach (drivers/base/dd.c:1164)
>> [    4.070901] bus_for_each_dev (drivers/base/bus.c:301)
>> [    4.070904] driver_attach (drivers/base/dd.c:1181)
>> [    4.070906] bus_add_driver (drivers/base/bus.c:618)
>> [    4.070908] driver_register (drivers/base/driver.c:240)
>> [    4.070910] register_virtio_driver (drivers/virtio/virtio.c:356 (discriminator 4))
>> [    4.070913] virtio_blk_init (drivers/block/virtio_blk.c:1218)
>> [    4.070918] do_one_initcall (init/main.c:1295)
>> [    4.070921] kernel_init_freeable (init/main.c:1367)
>> [    4.070924] kernel_init (init/main.c:1503)
>> [    4.070927] ret_from_fork (arch/arm64/kernel/entry.S:868)
> 
> Consider trimming the trace to the useful part.

Yes sure.

> 
>>
>> commit cba4235e6031e ("genirq: Remove mask argument from
>> setup_affinity()")
>> and
>> commit 11ea68f553e24 ("genirq, sched/isolation: Isolate from handling
>> managed interrupts")
>> overcome this issue by defining a static struct cpumask and protecting
>> it by a raw spinlock. The code in these commits is executed with IRQs
>> disabled.
>> its_select_cpu() can be executed with IRQs enabled or disabled. Thus
>> disabling IRQs is necesserary to avoid deadlocking.
> 
> Only if this code can be preempted by an interrupt and subsequently
> called from interrupt context. Can you describe this code path?

I'm putting the debug log at the end of the mail.

> 
>>
>> This patch:
> 
> Please refer to the documentation and the section about avoiding
> things like "this patch" in a commit message.

Yes sure.

> 
>> - makes tmpmask a 'static struct cpumask'. This prevents storing it on
>>    the stack and having to dynamically allocate it
>> - protects tmpmask with a raw spinlock
>> - disables IRQs around the spinlock for the case its_select_cpu() is
>>    called with IRQs enabled
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 34 +++++++++++++++++---------------
>>   1 file changed, 18 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 5ff09de6c48f..3cf89e59b036 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1574,14 +1574,15 @@ static int its_select_cpu(struct irq_data *d,
>>   			  const struct cpumask *aff_mask)
>>   {
>>   	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>> -	cpumask_var_t tmpmask;
>> +	static DEFINE_RAW_SPINLOCK(tmpmask_lock);
>> +	static struct cpumask tmpmask;
>> +	unsigned long flags;
>>   	int cpu, node;
>> -
>> -	if (!alloc_cpumask_var(&tmpmask, GFP_ATOMIC))
>> -		return -ENOMEM;
>> -
>>   	node = its_dev->its->numa_node;
>>   
>> +	local_irq_save(flags);
>> +	raw_spin_lock(&tmpmask_lock);
> 
> Why is this done in two steps? What is wrong with raw_spin_lock_irqsave()?

This is a mistake. raw_spin_lock_irqsave() would fit perfectly.

> 
> More importantly, a number of call paths reaching its_set_affinity()
> already execute under a raw spinlock, with interrupts disabled. Is it
> worth not hitting this lock at all times?

I think this is necessary to avoid 'possible irq lock inversion' at the
end of the message.

> 
>> +
>>   	if (!irqd_affinity_is_managed(d)) {
>>   		/* First try the NUMA node */
>>   		if (node != NUMA_NO_NODE) {
>> @@ -1589,8 +1590,8 @@ static int its_select_cpu(struct irq_data *d,
>>   			 * Try the intersection of the affinity mask and the
>>   			 * node mask (and the online mask, just to be safe).
>>   			 */
>> -			cpumask_and(tmpmask, cpumask_of_node(node), aff_mask);
>> -			cpumask_and(tmpmask, tmpmask, cpu_online_mask);
>> +			cpumask_and(&tmpmask, cpumask_of_node(node), aff_mask);
>> +			cpumask_and(&tmpmask, &tmpmask, cpu_online_mask);
> 
> Consider reducing the churn by writing something like:
> 
> 	static struct cpumask __tmpmask;
> 	struct cpumask *tmpmask = &__tmpmask;
> 
> which is strictly equivalent, and makes the patch much smaller.

Yes sure.

> 
> Thanks,
> 
> 	M.
> 

Thanks for the fast review,

Regards,
Pierre


The debug log:


[    2.935093] ========================================================
[    2.935094] WARNING: possible irq lock inversion dependency detected
[    2.935096] 5.19.0-rc3-rt4-00062-g6c393ee20e4e #37 Not tainted
[    2.935098] --------------------------------------------------------
[    2.935099] swapper/0/1 just changed the state of lock:
[    2.935101] ffff0000029534c8 (&irq_desc_lock_class){-...}-{2:2}, at: handle_fasteoi_irq (linux/kernel/irq/chip.c:693)
[    2.935116] but this lock took another, HARDIRQ-unsafe lock in the past:
[    2.935117]  (tmpmask_lock){+.+.}-{2:2}
[    2.935119]
[    2.935119]
[    2.935119] and interrupts could create inverse lock ordering between them.
[    2.935119]
[    2.935120]
[    2.935120] other info that might help us debug this:
[    2.935121] Chain exists of:
[    2.935121]   &irq_desc_lock_class --> tmp_mask_lock --> tmpmask_lock
[    2.935121]
[    2.935125]  Possible interrupt unsafe locking scenario:
[    2.935125]
[    2.935126]        CPU0                    CPU1
[    2.935126]        ----                    ----
[    2.935127]   lock(tmpmask_lock);
[    2.935129]                                local_irq_disable();
[    2.935129]                                lock(&irq_desc_lock_class);
[    2.935131]                                lock(tmp_mask_lock);
[    2.935133]   <Interrupt>
[    2.935133]     lock(&irq_desc_lock_class);
[    2.935135]
[    2.935135]  *** DEADLOCK ***
[    2.935135]
[    2.935136] 3 locks held by swapper/0/1:
[    2.935137] #0: ffff000000e621e0 (&dev->mutex){....}-{4:4}, at: __device_driver_lock (linux/drivers/base/dd.c:1055)
[    2.935147] #1: ffff000002951548 (&disk->open_mutex){+.+.}-{4:4}, at: blkdev_get_by_dev (linux/./include/linux/blkdev.h:177)
[    2.935155] #2: ffff80000b0e4778 (&folio_wait_table[i]){+.+.}-{3:3}, at: folio_wait_bit_common (linux/./arch/arm64/include/asm/jump_label.h:38)

[snip]

[    2.935446] ... key at: tmpmask_lock.56732+0x18/0x40
[    2.935451]    ... acquired at:
[    2.935452] _raw_spin_lock (linux/./include/linux/spinlock_api_smp.h:134)
[    2.935454] its_select_cpu (linux/drivers/irqchip/irq-gic-v3-its.c:1584)
[    2.935457] its_set_affinity (linux/drivers/irqchip/irq-gic-v3-its.c:1661)
[    2.935460] msi_domain_set_affinity (linux/kernel/irq/msi.c:501)
[    2.935463] irq_do_set_affinity (linux/kernel/irq/manage.c:276)
[    2.935468] irq_setup_affinity (linux/kernel/irq/manage.c:633)
[    2.935471] irq_startup (linux/kernel/irq/chip.c:280)
[    2.935473] __setup_irq (linux/kernel/irq/manage.c:1777)
[    2.935476] request_threaded_irq (linux/kernel/irq/manage.c:2206)
[    2.935479] vp_find_vqs_msix (linux/./include/linux/interrupt.h:168)
[    2.935481] vp_find_vqs (linux/drivers/virtio/virtio_pci_common.c:400)
[    2.935483] vp_modern_find_vqs (linux/drivers/virtio/virtio_pci_modern.c:259)
[    2.935485] init_vq (linux/./include/linux/virtio_config.h:213)
[    2.935487] virtblk_probe (linux/drivers/block/virtio_blk.c:936)
[    2.935489] virtio_dev_probe (linux/drivers/virtio/virtio.c:303)

[snip]

[    2.935592] ... key at: tmp_mask_lock.40873+0x18/0x40
[    2.935598]   ... acquired at:
[    2.935598] _raw_spin_lock (linux/./include/linux/spinlock_api_smp.h:134)
[    2.935600] irq_do_set_affinity (linux/./include/linux/irq.h:381)
[    2.935603] irq_startup (linux/kernel/irq/chip.c:273)
[    2.935605] __setup_irq (linux/kernel/irq/manage.c:1777)
[    2.935608] request_threaded_irq (linux/kernel/irq/manage.c:2206)
[    2.935611] vp_find_vqs_msix (linux/drivers/virtio/virtio_pci_common.c:342)
[    2.935613] vp_find_vqs (linux/drivers/virtio/virtio_pci_common.c:400)
[    2.935615] vp_modern_find_vqs (linux/drivers/virtio/virtio_pci_modern.c:259)
[    2.935617] init_vq (linux/./include/linux/virtio_config.h:213)
[    2.935619] virtblk_probe (linux/drivers/block/virtio_blk.c:936)
[    2.935622] virtio_dev_probe (linux/drivers/virtio/virtio.c:303)
[    2.935625] really_probe (linux/drivers/base/dd.c:555)
[    2.935627] __driver_probe_device (linux/drivers/base/dd.c:764)
[    2.935629] driver_probe_device (linux/drivers/base/dd.c:794)

[snip]

[    2.935812] ... key at: irq_desc_lock_class+0x0/0x10
[    2.935819]  ... acquired at:
[    2.935820] __lock_acquire (linux/kernel/locking/lockdep.c:4524)
[    2.935822] lock_acquire (linux/kernel/locking/lockdep.c:466)
[    2.935823] _raw_spin_lock (linux/./include/linux/spinlock_api_smp.h:134)
[    2.935825] handle_fasteoi_irq (linux/kernel/irq/chip.c:693)
[    2.935827] generic_handle_domain_irq (linux/kernel/irq/irqdesc.c:649)
[    2.935830] gic_handle_irq (linux/drivers/irqchip/irq-gic-v3.c:736)
[    2.935832] call_on_irq_stack (linux/arch/arm64/kernel/entry.S:902)
[    2.935834] do_interrupt_handler (linux/arch/arm64/kernel/entry-common.c:274)

[snip]
