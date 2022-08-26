Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4242B5A25ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343742AbiHZKfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiHZKfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:35:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BC3E6112D;
        Fri, 26 Aug 2022 03:35:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5921F23A;
        Fri, 26 Aug 2022 03:35:12 -0700 (PDT)
Received: from [10.57.46.92] (unknown [10.57.46.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EC363F93E;
        Fri, 26 Aug 2022 03:35:05 -0700 (PDT)
Message-ID: <42295bfc-136d-ebac-c44e-6bf46b0757f9@arm.com>
Date:   Fri, 26 Aug 2022 12:35:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] irqchip/gic-v3-its: Remove cpumask_var_t allocation
Content-Language: en-US
To:     Song Chen <chensong_2000@189.cn>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
References: <20220825152348.1634133-1-pierre.gondois@arm.com>
 <b946d81b-3777-51e1-8a01-e4ace99d829f@189.cn>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <b946d81b-3777-51e1-8a01-e4ace99d829f@189.cn>
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

Hello Song,

On 8/26/22 03:17, Song Chen wrote:
> hi,
> 
> 在 2022/8/25 23:23, Pierre Gondois 写道:
>> In KvmTool, on a ThunderX2, when running a preemp_rt kernel based on
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
>>
>> This patch:
>> - makes tmpmask a 'static struct cpumask'. This prevents storing it on
>>     the stack and having to dynamically allocate it
>> - protects tmpmask with a raw spinlock
>> - disables IRQs around the spinlock for the case its_select_cpu() is
>>     called with IRQs enabled
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>    drivers/irqchip/irq-gic-v3-its.c | 34 +++++++++++++++++---------------
>>    1 file changed, 18 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 5ff09de6c48f..3cf89e59b036 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1574,14 +1574,15 @@ static int its_select_cpu(struct irq_data *d,
>>    			  const struct cpumask *aff_mask)
>>    {
>>    	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>> -	cpumask_var_t tmpmask;
>> +	static DEFINE_RAW_SPINLOCK(tmpmask_lock);
>> +	static struct cpumask tmpmask;
>> +	unsigned long flags;
>>    	int cpu, node;
>> -
>> -	if (!alloc_cpumask_var(&tmpmask, GFP_ATOMIC))
>> -		return -ENOMEM;
>> -
>>    	node = its_dev->its->numa_node;
>>    
>> +	local_irq_save(flags);
>> +	raw_spin_lock(&tmpmask_lock);
>> +
> 
> why not call raw_spin_lock_irqsave and raw_spin_unlock_irqrestore?

Yes indeed, raw_spin_unlock_irqrestore() would fit perfectly,
this is a mistake.

Thanks for the review,
Pierre

> 
> Song
> 
>>    	if (!irqd_affinity_is_managed(d)) {
>>    		/* First try the NUMA node */
>>    		if (node != NUMA_NO_NODE) {
>> @@ -1589,8 +1590,8 @@ static int its_select_cpu(struct irq_data *d,
>>    			 * Try the intersection of the affinity mask and the
>>    			 * node mask (and the online mask, just to be safe).
>>    			 */
>> -			cpumask_and(tmpmask, cpumask_of_node(node), aff_mask);
>> -			cpumask_and(tmpmask, tmpmask, cpu_online_mask);
>> +			cpumask_and(&tmpmask, cpumask_of_node(node), aff_mask);
>> +			cpumask_and(&tmpmask, &tmpmask, cpu_online_mask);
>>    
>>    			/*
>>    			 * Ideally, we would check if the mask is empty, and
>> @@ -1604,7 +1605,7 @@ static int its_select_cpu(struct irq_data *d,
>>    			 * Instead, just fallback on the online mask. This
>>    			 * diverges from Thomas' suggestion above.
>>    			 */
>> -			cpu = cpumask_pick_least_loaded(d, tmpmask);
>> +			cpu = cpumask_pick_least_loaded(d, &tmpmask);
>>    			if (cpu < nr_cpu_ids)
>>    				goto out;
>>    
>> @@ -1616,25 +1617,26 @@ static int its_select_cpu(struct irq_data *d,
>>    		}
>>    
>>    		/* Try the intersection of the affinity and online masks */
>> -		cpumask_and(tmpmask, aff_mask, cpu_online_mask);
>> +		cpumask_and(&tmpmask, aff_mask, cpu_online_mask);
>>    
>>    		/* If that doesn't fly, the online mask is the last resort */
>> -		if (cpumask_empty(tmpmask))
>> -			cpumask_copy(tmpmask, cpu_online_mask);
>> +		if (cpumask_empty(&tmpmask))
>> +			cpumask_copy(&tmpmask, cpu_online_mask);
>>    
>> -		cpu = cpumask_pick_least_loaded(d, tmpmask);
>> +		cpu = cpumask_pick_least_loaded(d, &tmpmask);
>>    	} else {
>> -		cpumask_copy(tmpmask, aff_mask);
>> +		cpumask_copy(&tmpmask, aff_mask);
>>    
>>    		/* If we cannot cross sockets, limit the search to that node */
>>    		if ((its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) &&
>>    		    node != NUMA_NO_NODE)
>> -			cpumask_and(tmpmask, tmpmask, cpumask_of_node(node));
>> +			cpumask_and(&tmpmask, &tmpmask, cpumask_of_node(node));
>>    
>> -		cpu = cpumask_pick_least_loaded(d, tmpmask);
>> +		cpu = cpumask_pick_least_loaded(d, &tmpmask);
>>    	}
>>    out:
>> -	free_cpumask_var(tmpmask);
>> +	raw_spin_unlock(&tmpmask_lock);
>> +	local_irq_restore(flags);
>>    
>>    	pr_debug("IRQ%d -> %*pbl CPU%d\n", d->irq, cpumask_pr_args(aff_mask), cpu);
>>    	return cpu;
