Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB54547B06
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 18:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiFLQUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 12:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiFLQUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 12:20:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2515DBD9;
        Sun, 12 Jun 2022 09:20:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFCF260F59;
        Sun, 12 Jun 2022 16:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F91C34115;
        Sun, 12 Jun 2022 16:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655050830;
        bh=DY2JWl1uYBk45Ei2/fftA3R17HfTpBj9Q3PUtJLiOxs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VHIWAEHQQbkaoDfNJiFq0MiwDPrytZIFM8xfJsoduK7BQfVs4IHnJz5d+IWyq59/X
         yf2xwnywcYnj1yWwjBpAPEKZotUYaK2In8x6nT82hKgaMs/SbJ84QiBKgNjZ5THPS4
         LcnxBH8zQZcfo7Ys1MTQ5tqL1v4CFXCBF4hqt2JSl8cEWLwmw0lUHaQhfK7qKR6De0
         V0uUJWdYQeu0dh+KJoZfGIz4IeA/PWzsBfFamPvMne5Id3LWj6xvroiNNUZrh6tIIR
         DbBNlJ1CWRzVp+Fu7xjBFgtK1NPIhb3LOs29ZjR9VmHS7M7thH1PRgyQQfWF4oacE5
         VfmwGNDhUZmfQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B508A5C02F9; Sun, 12 Jun 2022 09:20:29 -0700 (PDT)
Date:   Sun, 12 Jun 2022 09:20:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking
 readers from consuming CPU) cause qemu boot slow
Message-ID: <20220612162029.GR1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20615615-0013-5adc-584f-2b1d5c03ebfc@linaro.org>
 <20220611165956.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_80D2801BC03B7006BB2230B6A1D5C69B9209@qq.com>
 <20220612133631.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_2B7B5B8DBE69330DA041AEE36C1029826905@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_2B7B5B8DBE69330DA041AEE36C1029826905@qq.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 10:59:30PM +0800, zhangfei.gao@foxmail.com wrote:
> Hi, Paul
> 
> On 2022/6/12 下午9:36, Paul E. McKenney wrote:
> > On Sun, Jun 12, 2022 at 03:40:30PM +0800, zhangfei.gao@foxmail.com wrote:
> > > Hi, Paul
> > > 
> > > On 2022/6/12 上午12:59, Paul E. McKenney wrote:
> > > > On Sun, Jun 12, 2022 at 12:32:59AM +0800, Zhangfei Gao wrote:
> > > > > Hi, Paul
> > > > > 
> > > > > When verifying qemu with acpi rmr feature on v5.19-rc1, the guest kernel
> > > > > stuck for several minutes.
> > > > Stuck for several minutes but then continues normally?  Or stuck for
> > > > several minutes before you kill qemu?
> > > qemu boot stuck for several minutes, then guest can bootup normally, just
> > > slower.
> > > > And I have to ask...  What happened without the ACPI RMR feature?
> > > If no ACPI, qemu boot quickly without stuck.
> > > build/aarch64-softmmu/qemu-system-aarch64 -machine
> > > virt,gic-version=3,iommu=smmuv3 \
> > > -enable-kvm -cpu host -m 1024 \
> > > -kernel Image -initrd mini-rootfs.cpio.gz -nographic -append \
> > > "rdinit=init console=ttyAMA0 earlycon=pl011,0x9000000 kpti=off"
> > > 
> > > Adding acpi=force & -bios QEMU_EFI.fd, qemu boot stuck for several minutes.
> > > 
> > > By the way, my hardware platform is aarch64.
> > Thank you for the information!  The problem is excessive delay rather
> > than a hang, and it is configuration-dependent.  Good to know!
> > 
> > > Only change this can solve the stuck issue.
> > > 
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -524,6 +524,10 @@ static unsigned long srcu_get_delay(struct srcu_struct
> > > *ssp)
> > >   {
> > >          unsigned long jbase = SRCU_INTERVAL;
> > > 
> > > +       if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq),
> > > READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
> > > +               return 0;
> > > +       return SRCU_INTERVAL;
> > I am glad that you have a workaround for this problem, but this change
> > would re-introduce the problem that commit 282d8998e997 ("srcu: Prevent
> > expedited GPs and blocking readers from consuming CPU") was intended
> > to fix.  For one example, your change can prevent kernel live patching
> > from applying a patch.  So something else is needed.
> Understand, it is just debug where has issue.
> > 
> > Does changing the value of SRCU_MAX_INTERVAL to (say) 3 decrease the delay
> > significantly?  (This is not a fix, either, but instead a debug check.)
> No use.

OK, that indicates that you have a very large number of invocations
of synchronize_srcu() or synchronize_srcu_expedited() instead of only
a few that take a very long time each.

> > Your change always returns zero if another SRCU grace period is needed.
> > Let's look at the callers of srcu_get_delay():
> > 
> > o	cleanup_srcu_struct() uses it to check whether there is an
> > 	expedited grace period pending, leaking the srcu_struct if so.
> > 	This should not affect boot delay.  (Unless you are invoking
> > 	init_srcu_struct() and cleanup_srcu_struct() really really
> > 	often.)
> > 
> > o	srcu_gp_end() uses it to determine whether or not to allow
> > 	a one-jiffy delay before invoking callbacks at the end of
> > 	a grace period.
> > 
> > o	srcu_funnel_gp_start() uses it to determine whether or not to
> > 	allow a one-jiffy delay before starting the process of checking
> > 	for the end of an SRCU grace period.
> > 
> > o	try_check_zero() uses it to add an additional short delay
> > 	(instead of a long delay) between checks of reader state.
> > 
> > o	process_srcu() uses it to calculate the long delay between
> > 	checks of reader state.
> > 
> > These add one-jiffy delays, except for process_srcu(), which adds a delay
> > of up to 10 jiffies.  Even given HZ=100 (as opposed to the HZ=1000 that
> > I normally use), this requires thousands of such delays to add up to the
> > several minutes that you are seeing.  (In theory, the delays could also
> > be due to SRCU readers, except that in that case adjusting timeouts in
> > the grace-period processing would not make things go faster.)
> > 
> > So, does acpi=force & -bios QEMU_EFI.fd add SRCU grace periods?  If so,
> > it would be very good make sure that this code is using SRCU efficiently.
> > One way to check would be to put a printk() into synchronize_srcu(),
> > though maintaining a counter and printing (say) every 1000th invocation
> > might be easier on the console output.
> 
> good idea.

Glad you like it.  ;-)

> > > > > And on 5.18, there is no such problem.
> > > > > 
> > > > > After revert this patch, the issue solved.
> > > > > Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking readers from
> > > > > consuming CPU)
> > > > > 
> > > > > 
> > > > > qemu cmd:
> > > > > build/aarch64-softmmu/qemu-system-aarch64 -machine
> > > > > virt,gic-version=3,iommu=smmuv3 \
> > > > > -enable-kvm -cpu host -m 1024 \
> > > > > -kernel Image -initrd mini-rootfs.cpio.gz -nographic -append \
> > > > > "rdinit=init console=ttyAMA0 earlycon=pl011,0x9000000 kpti=off acpi=force" \
> > > > > -bios QEMU_EFI.fd
> > > > > 
> > > > > log:
> > > > > InstallProtocolInterface: 5B1B31A1-9562-11D2-8E3F-00A0C969723B 7AA4D040
> > > > > add-symbol-file /home/linaro/work/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC48/AARCH64/NetworkPkg/IScsiDxe/IScsiDxe/DEBUG/IScsiDxe.dll
> > > > > 0x75459000
> > > > > Loading driver at 0x00075458000 EntryPoint=0x00075459058 IScsiDxe.efi
> > > > > InstallProtocolInterface: BC62157E-3E33-4FEC-9920-2D3B36D750DF 7AA4DE98
> > > > > ProtectUefiImageCommon - 0x7AA4D040
> > > > >     - 0x0000000075458000 - 0x000000000003F000
> > > > > SetUefiImageMemoryAttributes - 0x0000000075458000 - 0x0000000000001000
> > > > > (0x0000000000004008)
> > > > > SetUefiImageMemoryAttributes - 0x0000000075459000 - 0x000000000003B000
> > > > > (0x0000000000020008)
> > > > > SetUefiImageMemoryAttributes - 0x0000000075494000 - 0x0000000000003000
> > > > > (0x0000000000004008)
> > > > > InstallProtocolInterface: 18A031AB-B443-4D1A-A5C0-0C09261E9F71 754952C8
> > > > > InstallProtocolInterface: 107A772C-D5E1-11D4-9A46-0090273FC14D 75495358
> > > > > InstallProtocolInterface: 6A7A5CFF-E8D9-4F70-BADA-75AB3025CE14 75495370
> > > > > InstallProtocolInterface: 18A031AB-B443-4D1A-A5C0-0C09261E9F71 754952F8
> > > > > InstallProtocolInterface: 107A772C-D5E1-11D4-9A46-0090273FC14D 75495358
> > > > > InstallProtocolInterface: 6A7A5CFF-E8D9-4F70-BADA-75AB3025CE14 75495370
> > > > > InstallProtocolInterface: 59324945-EC44-4C0D-B1CD-9DB139DF070C 75495348
> > > > > InstallProtocolInterface: 09576E91-6D3F-11D2-8E39-00A0C969723B 754953E8
> > > > > InstallProtocolInterface: 330D4706-F2A0-4E4F-A369-B66FA8D54385 7AA4D728
> > > > > 
> > > > > 
> > > > > Not sure it is either reported or solved.
> > > > This is the first I have heard of it, so thank you for reporting it.
> > > > 
> > > > Do you have a way of collecting something sysrq-t output?
> > > Do you mean "echo t > /proc/sysrq-trigger",
> > > There are too much output and kernel dump can not stop.
> > OK.  What other tools do you have to work out what is happening during
> > temporary hangs such as this one?
> > 
> > The question to be answered: "Is there usually at least one task waiting
> > in synchronize_srcu() during these hangs, and if so, which srcu_struct
> > is passed to those synchronize_srcu() calls?"
> 
> As you suggested, add print in __synchronize_srcu, 1000 times print once.
> 
> With acpi=force & -bios QEMU_EFI.fd
> 
> When qemu stuck in
> InstallProtocolInterface: 5B1B31A1-9562-11D2-8E3F-00A0C969723B 7AA4D040
> add-symbol-file /home/linaro/work/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC48/AARCH64/NetworkPkg/IScsiDxe/IScsiDxe/DEBUG/IScsiDxe.dll
> 0x75459000
> 
> The print in  __synchronize_srcu is print from 0 t0 9001.

Now that is what I call a large number of calls!

> [   94.271350] gzf __synchronize_srcu loop=1001
> ....
> 
> [  222.621659]  __synchronize_srcu loop=9001
> [  222.621664] CPU: 96 PID: 2294 Comm: qemu-system-aar Not tainted
> 5.19.0-rc1-15071-g697f40b5235f-dirty #615
> [  222.621666] Hardware name: Huawei TaiShan 200 (Model 2280)/BC82AMDD, BIOS
> 2280-V2 CS V5.B133.01 03/25/2021
> [  222.621667] Call trace:
> [  222.621668]  dump_backtrace+0xe4/0xf0
> [  222.621670] show_stack+0x20/0x70
> [  222.621672] dump_stack_lvl+0x8c/0xb8
> [  222.621674]  dump_stack+0x18/0x34
> [  222.621676] __synchronize_srcu+0x120/0x128
> [  222.621678] synchronize_srcu_expedited+0x2c/0x40
> [  222.621680] kvm_swap_active_memslots+0x130/0x198
> [  222.621683] kvm_activate_memslot+0x40/0x68
> [  222.621684]  kvm_set_memslot+0x184/0x3b0
> [  222.621686]  __kvm_set_memory_region+0x288/0x438
> [  222.621688] kvm_set_memory_region+0x3c/0x60

This is KVM setting up one mapping in your IORT RMR memory, correct?
(As in I/O remapping table reserved memory regions.)

> [  222.621689]  kvm_vm_ioctl+0x5a0/0x13e0

And this ioctl() is qemu telling KVM to do so, correct?

> [  222.621691]  __arm64_sys_ioctl+0xb0/0xf8
> [  222.621693]  invoke_syscall+0x4c/0x110
> [  222.621696] el0_svc_common.constprop.0+0x68/0x128
> [  222.621698]  do_el0_svc+0x34/0xc0
> [  222.621701]  el0_svc+0x30/0x98
> [  222.621704]  el0t_64_sync_handler+0xb8/0xc0
> [  222.621706]  el0t_64_sync+0x18c/0x190
> 
> 
> If no acpi=force, no print at all, 1000 times one print.

OK, this certainly explains the slowdown, both from adding the IORT RMR
and from the commit that you bisected to.  The answers to a few questions
might help illuminate a path towards a fix:

Do these reserved memory regions really need to be allocated separately?
(For example, are they really all non-contiguous?  If not, that is, if
there are a lot of contiguous memory regions, could you sort the IORT
by address and do one ioctl() for each set of contiguous memory regions?)

Are all of these reserved memory regions set up before init is spawned?

Are all of these reserved memory regions set up while there is only a
single vCPU up and running?

Is the SRCU grace period really needed in this case?  (I freely confess
to not being all that familiar with KVM.)

							Thanx, Paul
