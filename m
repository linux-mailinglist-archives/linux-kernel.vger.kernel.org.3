Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB9F54B06F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbiFNMTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiFNMTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:19:15 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D70122296;
        Tue, 14 Jun 2022 05:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655209154; x=1686745154;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X4+bHdGz3bcexdIQaARzWmVWlKdI1Vt0zd5jt5hVles=;
  b=ckc8M7Yrw26Xh0FKgy/DlParnmRv0yHjys4UX5GRuD9IUxMBFdRvMIg4
   7xDuZA4xODwMmupcxiPTGt94uwdEMKSjUfzy/EUIEqeoHO8VjmJy1LUmy
   ybMTKo2nSZ0qJK7+1XX3vximOvgzOcJ5RWf9VsUbyOqwPArH408XRjZw5
   s=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Jun 2022 05:19:13 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 05:19:13 -0700
Received: from [10.50.56.0] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 14 Jun
 2022 05:19:08 -0700
Message-ID: <f9684a69-5467-a440-abd1-7cf5ad3a81f7@quicinc.com>
Date:   Tue, 14 Jun 2022 17:49:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking
 readers from consuming CPU) cause qemu boot slow
Content-Language: en-US
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        Auger Eric <eric.auger@redhat.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>
References: <20220612162029.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220612164002.GA1242564@paulmck-ThinkPad-P17-Gen-1>
 <560f7d27-fe38-0db9-834a-50dda5fa6157@redhat.com>
 <20220612184944.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_E306F58EAEC1D188ED6D5F358A269F34C707@qq.com>
 <20220613035711.GY1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220613041652.GA3976000@paulmck-ThinkPad-P17-Gen-1>
 <tencent_F82250B6E3D51A9AC0D2BE1AE43A4E060909@qq.com>
 <20220613121831.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_65C7D0A04984EDB6A79A5E5379DA7E835206@qq.com>
 <20220613145900.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <7b6c983b21d44119b61716a66de397ed@huawei.com>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <7b6c983b21d44119b61716a66de397ed@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 6/14/2022 2:25 AM, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Paul E. McKenney [mailto:paulmck@kernel.org]
>> Sent: 13 June 2022 15:59
>> To: zhangfei.gao@foxmail.com
>> Cc: Paolo Bonzini <pbonzini@redhat.com>; Zhangfei Gao
>> <zhangfei.gao@linaro.org>; linux-kernel@vger.kernel.org;
>> rcu@vger.kernel.org; Lai Jiangshan <jiangshanlai@gmail.com>; Josh Triplett
>> <josh@joshtriplett.org>; Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com>; Matthew Wilcox <willy@infradead.org>;
>> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> mtosatti@redhat.com; Auger Eric <eric.auger@redhat.com>
>> Subject: Re: Commit 282d8998e997 (srcu: Prevent expedited GPs and
>> blocking readers from consuming CPU) cause qemu boot slow
>>
>> On Mon, Jun 13, 2022 at 09:23:50PM +0800, zhangfei.gao@foxmail.com
>> wrote:
>>>
>>>
>>> On 2022/6/13 下午8:18, Paul E. McKenney wrote:
>>>> On Mon, Jun 13, 2022 at 02:55:47PM +0800, zhangfei.gao@foxmail.com
>> wrote:
>>>>> Hi, Paul
>>>>>
>>>>> On 2022/6/13 下午12:16, Paul E. McKenney wrote:
>>>>>> On Sun, Jun 12, 2022 at 08:57:11PM -0700, Paul E. McKenney wrote:
>>>>>>> On Mon, Jun 13, 2022 at 11:04:39AM +0800,
>> zhangfei.gao@foxmail.com wrote:
>>>>>>>> Hi, Paul
>>>>>>>>
>>>>>>>> On 2022/6/13 上午2:49, Paul E. McKenney wrote:
>>>>>>>>> On Sun, Jun 12, 2022 at 07:29:30PM +0200, Paolo Bonzini
>> wrote:
>>>>>>>>>> On 6/12/22 18:40, Paul E. McKenney wrote:
>>>>>>>>>>>> Do these reserved memory regions really need to be
>> allocated separately?
>>>>>>>>>>>> (For example, are they really all non-contiguous?  If not,
>> that is, if
>>>>>>>>>>>> there are a lot of contiguous memory regions, could you
>> sort the IORT
>>>>>>>>>>>> by address and do one ioctl() for each set of contiguous
>> memory regions?)
>>>>>>>>>>>>
>>>>>>>>>>>> Are all of these reserved memory regions set up before init
>> is spawned?
>>>>>>>>>>>>
>>>>>>>>>>>> Are all of these reserved memory regions set up while
>> there is only a
>>>>>>>>>>>> single vCPU up and running?
>>>>>>>>>>>>
>>>>>>>>>>>> Is the SRCU grace period really needed in this case?  (I
>> freely confess
>>>>>>>>>>>> to not being all that familiar with KVM.)
>>>>>>>>>>> Oh, and there was a similar many-requests problem with
>> networking many
>>>>>>>>>>> years ago.  This was solved by adding a new
>> syscall/ioctl()/whatever
>>>>>>>>>>> that permitted many requests to be presented to the kernel
>> with a single
>>>>>>>>>>> system call.
>>>>>>>>>>>
>>>>>>>>>>> Could a new ioctl() be introduced that requested a large
>> number
>>>>>>>>>>> of these memory regions in one go so as to make each call to
>>>>>>>>>>> synchronize_rcu_expedited() cover a useful fraction of your
>> 9000+
>>>>>>>>>>> requests?  Adding a few of the KVM guys on CC for their
>> thoughts.
>>>>>>>>>> Unfortunately not.  Apart from this specific case, in general
>> the calls to
>>>>>>>>>> KVM_SET_USER_MEMORY_REGION are triggered by writes to
>> I/O registers in the
>>>>>>>>>> guest, and those writes then map to a ioctl.  Typically the
>> guest sets up a
>>>>>>>>>> device at a time, and each setup step causes a
>> synchronize_srcu()---and
>>>>>>>>>> expedited at that.
>>>>>>>>> I was afraid of something like that...
>>>>>>>>>
>>>>>>>>>> KVM has two SRCUs:
>>>>>>>>>>
>>>>>>>>>> 1) kvm->irq_srcu is hardly relying on the "sleepable" part; it
>> has readers
>>>>>>>>>> that are very very small, but it needs extremely fast detection
>> of grace
>>>>>>>>>> periods; see commit 719d93cd5f5c ("kvm/irqchip: Speed up
>>>>>>>>>> KVM_SET_GSI_ROUTING", 2014-05-05) which split it off
>> kvm->srcu.  Readers are
>>>>>>>>>> not so frequent.
>>>>>>>>>>
>>>>>>>>>> 2) kvm->srcu is nastier because there are readers all the time.
>> The
>>>>>>>>>> read-side critical section are still short-ish, but they need the
>> sleepable
>>>>>>>>>> part because they access user memory.
>>>>>>>>> Which one of these two is in play in this case?
>>>>>>>>>
>>>>>>>>>> Writers are not frequent per se; the problem is they come in
>> very large
>>>>>>>>>> bursts when a guest boots.  And while the whole boot path
>> overall can be
>>>>>>>>>> quadratic, O(n) expensive calls to synchronize_srcu() can have
>> a larger
>>>>>>>>>> impact on runtime than the O(n^2) parts, as demonstrated
>> here.
>>>>>>>>>>
>>>>>>>>>> Therefore, we operated on the assumption that the callers of
>>>>>>>>>> synchronized_srcu_expedited were _anyway_ busy running
>> CPU-bound guest code
>>>>>>>>>> and the desire was to get past the booting phase as fast as
>> possible.  If
>>>>>>>>>> the guest wants to eat host CPU it can "for(;;)" as much as it
>> wants;
>>>>>>>>>> therefore, as long as expedited GPs didn't eat CPU
>> *throughout the whole
>>>>>>>>>> system*, a preemptable busy wait in
>> synchronize_srcu_expedited() were not
>>>>>>>>>> problematic.
>>>>>>>>>>
>>>>>>>>>> This assumptions did match the SRCU code when kvm->srcu
>> and kvm->irq_srcu
>>>>>>>>>> were was introduced (respectively in 2009 and 2014).  But
>> perhaps they do
>>>>>>>>>> not hold anymore now that each SRCU is not as independent
>> as it used to be
>>>>>>>>>> in those years, and instead they use workqueues instead?
>>>>>>>>> The problem was not internal to SRCU, but rather due to the fact
>>>>>>>>> that kernel live patching (KLP) had problems with the
>> CPU-bound tasks
>>>>>>>>> resulting from repeated synchronize_rcu_expedited()
>> invocations.  So I
>>>>>>>>> added heuristics to get the occasional sleep in there for KLP's
>> benefit.
>>>>>>>>> Perhaps these heuristics need to be less aggressive about adding
>> sleep.
>>>>>>>>>
>>>>>>>>> These heuristics have these aspects:
>>>>>>>>>
>>>>>>>>> 1.	The longer readers persist in an expedited SRCU grace period,
>>>>>>>>> 	the longer the wait between successive checks of the reader
>>>>>>>>> 	state.  Roughly speaking, we wait as long as the grace period
>>>>>>>>> 	has currently been in effect, capped at ten jiffies.
>>>>>>>>>
>>>>>>>>> 2.	SRCU grace periods have several phases.  We reset so that
>> each
>>>>>>>>> 	phase starts by not waiting (new phase, new set of readers,
>>>>>>>>> 	so don't penalize this set for the sins of the previous set).
>>>>>>>>> 	But once we get to the point of adding delay, we add the
>>>>>>>>> 	delay based on the beginning of the full grace period.
>>>>>>>>>
>>>>>>>>> Right now, the checking for grace-period length does not allow
>> for the
>>>>>>>>> possibility that a grace period might start just before the jiffies
>>>>>>>>> counter gets incremented (because I didn't realize that anyone
>> cared),
>>>>>>>>> so that is one possible thing to change.  I can also allow more
>> no-delay
>>>>>>>>> checks per SRCU grace-period phase.
>>>>>>>>>
>>>>>>>>> Zhangfei, does something like the patch shown below help?
>>>>>>>>>
>>>>>>>>> Additional adjustments are likely needed to avoid re-breaking
>> KLP,
>>>>>>>>> but we have to start somewhere...
>>>>>>>>>
>>>>>>>>> 							Thanx, Paul
>>>>>>>>>
>>>>>>>>> ------------------------------------------------------------------------
>>>>>>>>>
>>>>>>>>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>>>>>>>>> index 50ba70f019dea..6a354368ac1d1 100644
>>>>>>>>> --- a/kernel/rcu/srcutree.c
>>>>>>>>> +++ b/kernel/rcu/srcutree.c
>>>>>>>>> @@ -513,7 +513,7 @@ static bool srcu_readers_active(struct
>> srcu_struct *ssp)
>>>>>>>>>      #define SRCU_INTERVAL		1	// Base delay if no
>> expedited GPs pending.
>>>>>>>>>      #define SRCU_MAX_INTERVAL	10	// Maximum
>> incremental delay from slow readers.
>>>>>>>>> -#define SRCU_MAX_NODELAY_PHASE	1	// Maximum
>> per-GP-phase consecutive no-delay instances.
>>>>>>>>> +#define SRCU_MAX_NODELAY_PHASE	3	// Maximum
>> per-GP-phase consecutive no-delay instances.
>>>>>>>>>      #define SRCU_MAX_NODELAY	100	// Maximum
>> consecutive no-delay instances.
>>>>>>>>>      /*
>>>>>>>>> @@ -522,12 +522,18 @@ static bool srcu_readers_active(struct
>> srcu_struct *ssp)
>>>>>>>>>       */
>>>>>>>>>      static unsigned long srcu_get_delay(struct srcu_struct
>> *ssp)
>>>>>>>>>      {
>>>>>>>>> +	unsigned long gpstart;
>>>>>>>>> +	unsigned long j;
>>>>>>>>>      	unsigned long jbase = SRCU_INTERVAL;
>>>>>>>>>      	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq),
>> READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
>>>>>>>>>      		jbase = 0;
>>>>>>>>> -	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)))
>>>>>>>>> -		jbase += jiffies - READ_ONCE(ssp->srcu_gp_start);
>>>>>>>>> +	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq))) {
>>>>>>>>> +		j = jiffies - 1;
>>>>>>>>> +		gpstart = READ_ONCE(ssp->srcu_gp_start);
>>>>>>>>> +		if (time_after(j, gpstart))
>>>>>>>>> +			jbase += j - gpstart;
>>>>>>>>> +	}
>>>>>>>>>      	if (!jbase) {
>>>>>>>>>      		WRITE_ONCE(ssp->srcu_n_exp_nodelay,
>> READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
>>>>>>>>>      		if (READ_ONCE(ssp->srcu_n_exp_nodelay) >
>> SRCU_MAX_NODELAY_PHASE)
>>>>>>>> Unfortunately, this patch does not helpful.
>>>>>>>>
>>>>>>>> Then re-add the debug info.
>>>>>>>>
>>>>>>>> During the qemu boot
>>>>>>>> [  232.997667]  __synchronize_srcu loop=1000
>>>>>>>>
>>>>>>>> [  361.094493]  __synchronize_srcu loop=9000
>>>>>>>> [  361.094501] Call trace:
>>>>>>>> [  361.094502]  dump_backtrace+0xe4/0xf0
>>>>>>>> [  361.094505]  show_stack+0x20/0x70
>>>>>>>> [  361.094507]  dump_stack_lvl+0x8c/0xb8
>>>>>>>> [  361.094509]  dump_stack+0x18/0x34
>>>>>>>> [  361.094511]  __synchronize_srcu+0x120/0x128
>>>>>>>> [  361.094514]  synchronize_srcu_expedited+0x2c/0x40
>>>>>>>> [  361.094515]  kvm_swap_active_memslots+0x130/0x198
>>>>>>>> [  361.094519]  kvm_activate_memslot+0x40/0x68
>>>>>>>> [  361.094520]  kvm_set_memslot+0x2f8/0x3b0
>>>>>>>> [  361.094523]  __kvm_set_memory_region+0x2e4/0x438
>>>>>>>> [  361.094524]  kvm_set_memory_region+0x78/0xb8
>>>>>>>> [  361.094526]  kvm_vm_ioctl+0x5a0/0x13e0
>>>>>>>> [  361.094528]  __arm64_sys_ioctl+0xb0/0xf8
>>>>>>>> [  361.094530]  invoke_syscall+0x4c/0x110
>>>>>>>> [  361.094533]  el0_svc_common.constprop.0+0x68/0x128
>>>>>>>> [  361.094536]  do_el0_svc+0x34/0xc0
>>>>>>>> [  361.094538]  el0_svc+0x30/0x98
>>>>>>>> [  361.094541]  el0t_64_sync_handler+0xb8/0xc0
>>>>>>>> [  361.094544]  el0t_64_sync+0x18c/0x190
>>>>>>>> [  363.942817]  kvm_set_memory_region loop=6000
>>>>>>> Huh.
>>>>>>>
>>>>>>> One possibility is that the "if (!jbase)" block needs to be nested
>>>>>>> within the "if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq))) {"
>> block.
>>>>> I test this diff and NO helpful
>>>>>
>>>>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>>>>> index 50ba70f019de..36286a4b74e6 100644
>>>>> --- a/kernel/rcu/srcutree.c
>>>>> +++ b/kernel/rcu/srcutree.c
>>>>> @@ -513,7 +513,7 @@ static bool srcu_readers_active(struct
>> srcu_struct *ssp)
>>>>>
>>>>>    #define SRCU_INTERVAL          1       // Base delay if no
>> expedited GPs
>>>>> pending.
>>>>>    #define SRCU_MAX_INTERVAL      10      // Maximum
>> incremental delay from
>>>>> slow readers.
>>>>> -#define SRCU_MAX_NODELAY_PHASE 1       // Maximum
>> per-GP-phase consecutive
>>>>> no-delay instances.
>>>>> +#define SRCU_MAX_NODELAY_PHASE 3       // Maximum
>> per-GP-phase consecutive
>>>>> no-delay instances.
>>>>>    #define SRCU_MAX_NODELAY       100     // Maximum
>> consecutive no-delay
>>>>> instances.
>>>>>
>>>>>    /*
>>>>> @@ -522,16 +522,23 @@ static bool srcu_readers_active(struct
>> srcu_struct
>>>>> *ssp)
>>>>>     */
>>>>>    static unsigned long srcu_get_delay(struct srcu_struct *ssp)
>>>>>    {
>>>>> +       unsigned long gpstart;
>>>>> +       unsigned long j;
>>>>>           unsigned long jbase = SRCU_INTERVAL;
>>>>>
>>>>>           if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq),
>>>>> READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
>>>>>                   jbase = 0;
>>>>> -       if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)))
>>>>> -               jbase += jiffies -
>> READ_ONCE(ssp->srcu_gp_start);
>>>>> -       if (!jbase) {
>>>>> -               WRITE_ONCE(ssp->srcu_n_exp_nodelay,
>>>>> READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
>>>>> -               if (READ_ONCE(ssp->srcu_n_exp_nodelay) >
>>>>> SRCU_MAX_NODELAY_PHASE)
>>>>> -                       jbase = 1;
>>>>> +       if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq))) {
>>>>> +               j = jiffies - 1;
>>>>> +               gpstart = READ_ONCE(ssp->srcu_gp_start);
>>>>> +               if (time_after(j, gpstart))
>>>>> +                       jbase += j - gpstart;
>>>>> +
>>>>> +               if (!jbase) {
>>>>>
>> +                       WRITE_ONCE(ssp->srcu_n_exp_nodelay,
>>>>> READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
>>>>> +                       if
>> (READ_ONCE(ssp->srcu_n_exp_nodelay) >
>>>>> SRCU_MAX_NODELAY_PHASE)
>>>>> +                               jbase = 1;
>>>>> +               }
>>>>>           }
>>>> That is in fact what I was intending you to test, thank you.  As you
>>>> say, unfortunately it did not help.
>>>>
>>>> Could you please test removing the "if (!jbase)" block entirely?
>>> Remove "if (!jbase)" block is much faster,
>>> not measure clearly, qemu (with debug version efi) boot seems normally.
>>>
>>>  From log timestamp:
>>> [  114.624713] __synchronize_srcu loop=1000
>>> [  124.157011]  __synchronize_srcu loop=9000
>>>
>>> Several method: timestamps are different.
>>>
>>> 5.19-rc1
>>> [   94.271350]  __synchronize_srcu loop=1001
>>> [  222.621659]  __synchronize_srcu loop=9001
>>>
>>>
>>> With your first diff:
>>> [  232.997667]  __synchronize_srcu loop=1000
>>> [  361.094493]  __synchronize_srcu loop=9000
>>>
>>> Remove "if (!jbase)" block
>>> [  114.624713] __synchronize_srcu loop=1000
>>> [  124.157011]  __synchronize_srcu loop=9000
>>>
>>>
>>> 5.18 method
>>> +       if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq),
>> READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
>>> +               return 0;
>>> +       return SRCU_INTERVAL;
>>>
>>> [   74.598480] __synchronize_srcu loop=9000
>>> [   68.938297] __synchronize_srcu loop=1000
>>
>> Thank you for the information!
>>
>> What happens if you keep the that "if (!jbase)" block", but set the
>> value of the SRCU_MAX_NODELAY_PHASE macro very large, say 1000000?
> 
>  From the setup I have, this is almost similar to that of the previous logic(without
> the "if(!jbase)"). In both cases, I think we are not close to 5.18, but definitely much
> better compared to 5.19-rc1.
> 
> The numbers from my test setup(CONFIG_HZ_250, CONFIG_PREEMPTION=y),
> 
>                         Guest boot time(using 'time'):
> 
> 5.18-rc4 based               ~8sec
> 
> 5.19-rc1                     ~2m43sec
> 
> 5.19-rc1+fix1                 ~19sec
> 
> 5.19-rc1-fix2                 ~19sec
> 

If you try below diff on top of either 5.19-rc1+fix1 or 5.19-rc1-fix2 ; 
does it show any difference in boot time?

--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -706,7 +706,7 @@ static void srcu_schedule_cbs_snp(struct srcu_struct 
*ssp, struct srcu_node *snp
   */
  static void srcu_gp_end(struct srcu_struct *ssp)
  {
-       unsigned long cbdelay;
+       unsigned long cbdelay = 1;
         bool cbs;
         bool last_lvl;
         int cpu;
@@ -726,7 +726,9 @@ static void srcu_gp_end(struct srcu_struct *ssp)
         spin_lock_irq_rcu_node(ssp);
         idx = rcu_seq_state(ssp->srcu_gp_seq);
         WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
-       cbdelay = !!srcu_get_delay(ssp);
+       if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq), 
READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
+               cbdelay = 0;
+
         WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());



Thanks
Neeraj


> I will wait for Zhangfei to confirm this on his setup, especially the difference
> compared to 5.18.
> 
> Thanks,
> Shameer
>   
>> This would be too large for KLP, but my hope is that there is a value
>> of SRCU_MAX_NODELAY_PHASE that works for everyone.  But first, does
>> this help at all?  ;-)
>>
>>>>>> And when I run 10,000 consecutive synchronize_rcu_expedited() calls,
>> the
>>>>>> above change reduces the overhead by more than an order of
>> magnitude.
>>>>>> Except that the overhead of the series is far less than one second,
>>>>>> not the several minutes that you are seeing.  So the per-call
>> overhead
>>>>>> decreases from about 17 microseconds to a bit more than one
>> microsecond.
>>>>>>
>>>>>> I could imagine an extra order of magnitude if you are running
>> HZ=100
>>>>>> instead of the HZ=1000 that I am running.  But that only gets up to a
>>>>>> few seconds.
>>>> One possible reason for the difference would be if your code has
>>>> SRCU readers.
>>>>
>>>> Could you please tell me the value of CONFIG_HZ on your system?
>>>> Also the value of CONFIG_PREEMPTION?
>>> I am using arch/arm64/configs/defconfig
>>> make defconfig
>>> CONFIG_PREEMPTION=y
>>> CONFIG_HZ_250=y
>>
>> Thank you again!
>>
>> And if there is a good value of SRCU_MAX_NODELAY_PHASE, it might
>> depend
>> on HZ.  And who knows what all else...
>>
>> 							Thanx, Paul
>>
>>> Thanks
>>>
>>>>
>>>>>>> One additional debug is to apply the patch below on top of the one
>> you
>>>>> apply the patch below?
>>>>>>> just now kindly tested, then use whatever debug technique you wish
>> to
>>>>>>> work out what fraction of the time during that critical interval that
>>>>>>> srcu_get_delay() returns non-zero.
>>>>> Sorry, I am confused, no patch right?
>>>> Apologies, my omission.
>>>>
>>>>> Just measure srcu_get_delay return to non-zero?
>>>> Exactly, please!
>>>>
>>>>> By the way, the issue should be only related with qemu apci. not related
>>>>> with rmr feature
>>>>> Test with: https://github.com/qemu/qemu/tree/stable-6.1
>>>>>
>>>>> Looks it caused by too many kvm_region_add & kvm_region_del if
>> acpi=force,
>>>>> If no acpi, no print kvm_region_add/del (1000 times print once)
>>>>>
>>>>> If with acpi=force,
>>>>> During qemu boot
>>>>> kvm_region_add region_add = 1000
>>>>> kvm_region_del region_del = 1000
>>>>> kvm_region_add region_add = 2000
>>>>> kvm_region_del region_del = 2000
>>>>> kvm_region_add region_add = 3000
>>>>> kvm_region_del region_del = 3000
>>>>> kvm_region_add region_add = 4000
>>>>> kvm_region_del region_del = 4000
>>>>> kvm_region_add region_add = 5000
>>>>> kvm_region_del region_del = 5000
>>>>> kvm_region_add region_add = 6000
>>>>> kvm_region_del region_del = 6000
>>>>>
>>>>> kvm_region_add/kvm_region_del ->
>>>>> kvm_set_phys_mem->
>>>>> kvm_set_user_memory_region->
>>>>> kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem)
>>>>>
>>>>> [  361.094493]  __synchronize_srcu loop=9000
>>>>> [  361.094501] Call trace:
>>>>> [  361.094502]  dump_backtrace+0xe4/0xf0
>>>>> [  361.094505]  show_stack+0x20/0x70
>>>>> [  361.094507]  dump_stack_lvl+0x8c/0xb8
>>>>> [  361.094509]  dump_stack+0x18/0x34
>>>>> [  361.094511]  __synchronize_srcu+0x120/0x128
>>>>> [  361.094514]  synchronize_srcu_expedited+0x2c/0x40
>>>>> [  361.094515]  kvm_swap_active_memslots+0x130/0x198
>>>>> [  361.094519]  kvm_activate_memslot+0x40/0x68
>>>>> [  361.094520]  kvm_set_memslot+0x2f8/0x3b0
>>>>> [  361.094523]  __kvm_set_memory_region+0x2e4/0x438
>>>>> [  361.094524]  kvm_set_memory_region+0x78/0xb8
>>>>> [  361.094526]  kvm_vm_ioctl+0x5a0/0x13e0
>>>>> [  361.094528]  __arm64_sys_ioctl+0xb0/0xf8
>>>>> [  361.094530]  invoke_syscall+0x4c/0x110
>>>>> [  361.094533]  el0_svc_common.constprop.0+0x68/0x128
>>>>> [  361.094536]  do_el0_svc+0x34/0xc0
>>>>> [  361.094538]  el0_svc+0x30/0x98
>>>>> [  361.094541]  el0t_64_sync_handler+0xb8/0xc0
>>>>> [  361.094544]  el0t_64_sync+0x18c/0x190
>>>>> [  363.942817]  kvm_set_memory_region loop=6000
>>>> Good to know, thank you!
>>>>
>>>> 							Thanx, Paul
>>>
