Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924E85797AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbiGSK3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbiGSK3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:29:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02CBA65CB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:29:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AF101424;
        Tue, 19 Jul 2022 03:29:21 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 377333F766;
        Tue, 19 Jul 2022 03:29:19 -0700 (PDT)
Date:   Tue, 19 Jul 2022 11:29:16 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor.Dooley@microchip.com
Cc:     linux@roeck-us.net, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH -next] arch_topology: Fix cache attributes detection in
 the CPU hotplug path
Message-ID: <20220719102916.xixnvzxnnn5kslnd@bogus>
References: <20220713133344.1201247-1-sudeep.holla@arm.com>
 <20220718174151.GA462603@roeck-us.net>
 <0744c97a-bb4e-0985-7f86-f98965b5d3c1@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0744c97a-bb4e-0985-7f86-f98965b5d3c1@microchip.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 05:57:33PM +0000, Conor.Dooley@microchip.com wrote:
> On 18/07/2022 18:41, Guenter Roeck wrote:
> > On Wed, Jul 13, 2022 at 02:33:44PM +0100, Sudeep Holla wrote:
> >> init_cpu_topology() is called only once at the boot and all the cache
> >> attributes are detected early for all the possible CPUs. However when
> >> the CPUs are hotplugged out, the cacheinfo gets removed. While the
> >> attributes are added back when the CPUs are hotplugged back in as part
> >> of CPU hotplug state machine, it ends up called quite late after the
> >> update_siblings_masks() are called in the secondary_start_kernel()
> >> resulting in wrong llc_sibling_masks.
> >>
> >> Move the call to detect_cache_attributes() inside update_siblings_masks()
> >> to ensure the cacheinfo is updated before the LLC sibling masks are
> >> updated. This will fix the incorrect LLC sibling masks generated when
> >> the CPUs are hotplugged out and hotplugged back in again.
> >>
> >> Reported-by: Ionela Voinescu <ionela.voinescu@arm.com>
> >> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >> ---
> >>  drivers/base/arch_topology.c | 16 ++++++----------
> >>  1 file changed, 6 insertions(+), 10 deletions(-)
> >>
> >> Hi Conor,
> >>
> >> Ionela reported an issue with the CPU hotplug and as a fix I need to
> >> move the call to detect_cache_attributes() which I had thought to keep
> >> it there from first but for no reason had moved it to init_cpu_topology().
> >>
> >> Wonder if this fixes the -ENOMEM on RISC-V as this one is called on the
> >> cpu in the secondary CPUs init path while init_cpu_topology executed
> >> detect_cache_attributes() for all possible CPUs much earlier. I think
> >> this might help as the percpu memory might be initialised in this case.
> >>
> >> Anyways give this a try, also test the CPU hotplug and check if nothing
> >> is broken on RISC-V. We noticed this bug only on one platform while
> >>
> > 
> > arm64, with next-20220718:
> > 
> > ...
> > [    0.823405] Detected PIPT I-cache on CPU1
> > [    0.824456] BUG: sleeping function called from invalid context at kernel/locking/semaphore.c:164
> > [    0.824550] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/1
> > [    0.824600] preempt_count: 1, expected: 0
> > [    0.824633] RCU nest depth: 0, expected: 0
> > [    0.824899] no locks held by swapper/1/0.
> > [    0.825035] irq event stamp: 0
> > [    0.825072] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> > [    0.826017] hardirqs last disabled at (0): [<ffff800008158870>] copy_process+0x5e0/0x18e4
> > [    0.826123] softirqs last  enabled at (0): [<ffff800008158870>] copy_process+0x5e0/0x18e4
> > [    0.826191] softirqs last disabled at (0): [<0000000000000000>] 0x0
> > [    0.826764] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.19.0-rc7-next-20220718 #1
> > [    0.827397] Call trace:
> > [    0.827456]  dump_backtrace.part.0+0xd4/0xe0
> > [    0.827574]  show_stack+0x18/0x50
> > [    0.827625]  dump_stack_lvl+0x9c/0xd8
> > [    0.827678]  dump_stack+0x18/0x34
> > [    0.827722]  __might_resched+0x178/0x220
> > [    0.827778]  __might_sleep+0x48/0x80
> > [    0.827833]  down_timeout+0x2c/0xa0
> > [    0.827896]  acpi_os_wait_semaphore+0x68/0x9c
> > [    0.827952]  acpi_ut_acquire_mutex+0x4c/0xb8
> > [    0.828008]  acpi_get_table+0x38/0xbc
> > [    0.828059]  acpi_find_last_cache_level+0x44/0x130
> > [    0.828112]  init_cache_level+0xb8/0xcc
> > [    0.828165]  detect_cache_attributes+0x240/0x580
> > [    0.828217]  update_siblings_masks+0x28/0x270
> > [    0.828270]  store_cpu_topology+0x64/0x74
> > [    0.828326]  secondary_start_kernel+0xd0/0x150
> > [    0.828386]  __secondary_switched+0xb0/0xb4
> > 
> > I know the problem has already been reported, but I think the backtrace
> > above is slightly different.
>

Thanks for the report, I forgot to run with lockdep on ACPI system. This is
trickier. I will take a look at it.

> Aye, I got a different BT on RISC-V + DT - but that should be fixed in
> next-20220718. This is a different problem unfortunately.

Yes, ACPI is bit different flow.

--
Regards,
Sudeep
