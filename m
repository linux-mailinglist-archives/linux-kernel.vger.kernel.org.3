Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE10D4661AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 11:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356607AbhLBKtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:49:14 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16337 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbhLBKtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:49:10 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J4XfJ4YSTz91PY;
        Thu,  2 Dec 2021 18:45:12 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 18:45:46 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 18:45:45 +0800
Message-ID: <b641f1ea-6def-0fe4-d273-03c35c4aa7d6@huawei.com>
Date:   Thu, 2 Dec 2021 18:45:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] arm64: Enable KCSAN
Content-Language: en-US
To:     Marco Elver <elver@google.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <joey.gouly@arm.com>
References: <20211129145732.27000-1-wangkefeng.wang@huawei.com>
 <YadiUPpJ0gADbiHQ@FVFF77S0Q05N>
 <811af0bc-0c99-37f6-a39a-095418b10661@huawei.com>
 <Yaic31SbYFJ4zAl0@elver.google.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Yaic31SbYFJ4zAl0@elver.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/12/2 18:15, Marco Elver wrote:
> On Thu, Dec 02, 2021 at 09:35AM +0800, Kefeng Wang wrote:
>> On 2021/12/1 19:53, Mark Rutland wrote:
>>> Hi Kefeng,
>>>
>>> On Mon, Nov 29, 2021 at 10:57:32PM +0800, Kefeng Wang wrote:
>>>> This patch enables KCSAN for arm64, with updates to build rules
>>>> to not use KCSAN for several incompatible compilation units.
>>>>
>>>> Resent GCC version(at least GCC10) made outline-atomics as the
>>>> default option(unlike Clang), which will cause linker errors
>>>> for kernel/kcsan/core.o.
>>>>
>>>> Disables the out-of-line atomics by no-outline-atomics to fix
>>>> the linker errors.
>>>>
>>>> Tested selftest and kcsan_test(built with GCC11 and Clang 13),
>>>> and all passed.
>>> Nice!
>>>
>>> I think there are a few additional bits and pieces we'll need:
>>>
>>> * Prior to clang 12.0.0, KCSAN would produce warnings with BTI, as I found in:
>>>
>>>     https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/kcsan&id=2d67c39ae4f619ca94d9790e09186e77922fa826
>>>
>>>     Since BTI is in defconfig, I think arm64's Kconfig should require a minimum
>>>     of clang 12.0.0 to enable KCSAN.
>> I don't have different clang version to test,  when check KCSAN,
>>
>> commit eb32f9f990d9 ("kcsan: Improve some Kconfig comments") saids,
>>
>>
>>      The compiler instruments plain compound read-write operations
>>      differently (++, --, +=, -=, |=, &=, etc.), which allows KCSAN to
>>      distinguish them from other plain accesses. This is currently
>>      supported by Clang 12 or later.
>>
>> Should we add a  "depends on CLANG_VERSION >= 120000"
> KCSAN works just fine with Clang 11. Clang 12 merely improves some
> instrumentation, which is what this comment is about.
>
> What Mark meant is that there's a specific issue with arm64 and BTI that
> is fixed by Clang 12. Therefore, arm64's Kconfig will have to do
>
> 	select HAVE_ARCH_KCSAN if CC_IS_GCC || CLANG_VERSION >= 120000
>
>>> * In the past clang did not have an attribute to suppress tsan instrumenation
>>>     and would instrument noinstr regions. I'm not sure when clang gained the
>>>     relevant attribute to supress this, but we will need to depend on this
>>>     existing, either based on the clang version or with a test for the attribute.
>>>
>>>     (If we're lucky, clang 12.0.0 is sufficient, and we solve BTI and this in one
>>>     go).
>>>
>>>     I *think* GCC always had an attribute, but I'm not certain.
>>>
>>>     Marco, is there an existing dependency somewhere for this to work on x86? I
>>>     thought there was an objtool pass to NOP this out, but I couldn't find it in
>>>     mainline. If x86 is implicitly depending on a sufficiently recent version of
>>>     clang, we add something to the common KCSAN Kconfig for ARCH_WANTS_NO_INSTR?
>>>
>>> * There are some latent issues with some code (e.g. alternatives, patching, insn)
>>>     code being instrumentable even though this is unsound, and depending on
>>>     compiler choices this can happen to be fine or can result in boot-time
>>>     failures (I saw lockups when I started trying to add KCSAN for arm64).
>>>
>>>     While this isn't just a KCSAN problem, fixing that requires some fairly
>>>     significant rework to a bunch of code, and until that's done we're on very
>>>     shaky ground. So I'd like to make KCSAN depend on EXPERT for now.
>>>
>>>     I had an initial stab at fixing some of that, e.g.
>>>
>>>     https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/patching/rework
>>>     Joey has started looking into this too.
>> Thanks for your information,  I don't know about this. As your say, we could
>> add a depend on EXPERT
>>
>> for now and more explanation into changlog.
> So what I gather arm64's final select line may look like:
>
> 	select HAVE_ARCH_KCSAN if EXPERT && (CC_IS_GCC || CLANG_VERSION >= 120000)
Yes,  that's what we want now.
>
>>> * When I last tested, for simple boots I would get frequent KCSAN splats for a
>>>     few common issues, and those drowned out all other reports.
>>>
>>>     One case was manipulation of thread_info::flags, which Thomas Gleixner has
>>>     queued some fixes at:
>>>
>>>     https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=core/entry
>>>     There were some other common failures, e.g. accesses to task_struct::on_cpu,
>>>     and I hadn't had the chance to investigate/fix those, beyond a (likely
>>>     unsound) hack:
>>>
>>>     https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/kcsan&id=4fe9d6c2ef85257d80291086e4514eaaebd3504e
>>>
>>>     It would be good if we could identify the most frequent problems (e.g. those
>>>     that will occur when just booting) before we enable this generally, to avoid
>>>     everyone racing to report/fix those as soon as we enable the feature.
>>>
>>>     When you tested, did KCSAN flag anything beyond the selftests?
>> Yes, there are some KCSAN reports, but this is not only exist on arm64, I
>> saw  owner->on_cpu warning
>>
>> on x86 too, eg, we also hack to disable it via data_race.
>>
>> Reported by Kernel Concurrency Sanitizer on:
>> CPU: 7 PID: 2530 Comm: syz-executor.11 Not tainted 5.10.0+ #113
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.104/01/2014
>> ==================================================================
>> BUG: KCSAN: data-race in rwsem_spin_on_owner+0xf4/0x180
>>
>> race at unknown origin, with read to 0xffff9767d3becfac of 4 bytes by task 18119 on cpu 0:
>>   rwsem_spin_on_owner+0xf4/0x180
>>   rwsem_optimistic_spin+0x48/0x480
>>   rwsem_down_read_slowpath+0x4a0/0x670
>>   down_read+0x69/0x190
>>   process_vm_rw+0x41e/0x840
>>   __x64_sys_process_vm_writev+0x76/0x90
>>   do_syscall_64+0x37/0x50
>>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> I think fixing data races is not a pre-requisite for arch-enablement.
> Some are slowly being addressed (and others aren't -- syzbot has a list
> of >200 data races that I try to moderate and fix some or forward those
> that I think will get fixed). I expect the most frequent issues will be
> the same on arm64 as they are on x86.
>
> I actually have a "fix" for the data race in rwsem_spin_on_owner, that
> also shows where the other racing access comes from... which reminds me:
> https://lkml.kernel.org/r/20211202101238.33546-1-elver@google.com

There's a owner_on_cpu(),  we could reuse it,

diff --git a/include/linux/sched.h b/include/linux/sched.h
index aae991f511c3..f2e99e8f75bd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2171,6 +2171,15 @@ static inline bool vcpu_is_preempted(int cpu)
  }
  #endif

+static inline bool owner_on_cpu(struct task_struct *owner)
+{
+	/*
+	 * As lock holder preemption issue, we both skip spinning if
+	 * task is not on cpu or its cpu is preempted
+	 */
+	return READ_ONCE(owner->on_cpu) && !vcpu_is_preempted(task_cpu(owner));
+}
+
  extern long sched_setaffinity(pid_t pid, const struct cpumask *new_mask);
  extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
  
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 2fede72b6af5..29e0ac58259d 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -361,11 +361,7 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
  		 */
  		barrier();
  
-		/*
-		 * Use vcpu_is_preempted to detect lock holder preemption issue.
-		 */
-		if (!owner->on_cpu || need_resched() ||
-				vcpu_is_preempted(task_cpu(owner))) {
+		if (!owner_on_cpu(owner) || need_resched()) {
  			ret = false;
  			break;
  		}
@@ -396,12 +392,8 @@ static inline int mutex_can_spin_on_owner(struct mutex *lock)
  	rcu_read_lock();
  	owner = __mutex_owner(lock);
  
-	/*
-	 * As lock holder preemption issue, we both skip spinning if task is not
-	 * on cpu or its cpu is preempted
-	 */
  	if (owner)
-		retval = owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
+		retval = owner_on_cpu(owner);
  	rcu_read_unlock();
  
  	/*
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 000e8d5a2884..30d95a6717d2 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -596,15 +596,6 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
  	return false;
  }
  
-static inline bool owner_on_cpu(struct task_struct *owner)
-{
-	/*
-	 * As lock holder preemption issue, we both skip spinning if
-	 * task is not on cpu or its cpu is preempted
-	 */
-	return owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
-}
-


> Thanks,
> -- Marco
> .
