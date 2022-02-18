Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3044E4BBE7A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbiBRRds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:33:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238638AbiBRRdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:33:45 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54322B4D9A;
        Fri, 18 Feb 2022 09:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645205608; x=1676741608;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7VcMIjzFAlbXIka1xHuVOCoWaCPdmJ8L+FS+cLBlhpQ=;
  b=Lg9MSRABCdY9hHJFQYU6LEdAy8+fEsiPvgUZzo9rozXwhzKAseGLvi/C
   VoDCu6ziEgrKp580fj2ObtChPO13Q1dkvutG9YM1/aFp8+mxT5njxc19L
   lgHT2vYRAQMKTEPIVDa3g2lkm8AtK/L3KlVhBj+30mlRQ3Ms8x4trS99t
   U=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 18 Feb 2022 09:33:27 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 09:33:27 -0800
Received: from [10.216.39.162] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Fri, 18 Feb
 2022 09:33:23 -0800
Message-ID: <ca0cac53-68ec-7df4-e617-2a4cd9710491@quicinc.com>
Date:   Fri, 18 Feb 2022 23:03:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH rcu 3/3] rcu: Allow expedited RCU grace periods on
 incoming CPUs
Content-Language: en-US
To:     <paulmck@kernel.org>
CC:     <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        <rcu@vger.kernel.org>, <rostedt@goodmis.org>, <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220209233811.GC557593@lothringen>
 <20220214164435.GA2805255@paulmck-ThinkPad-P17-Gen-1>
 <f8cff19c-5e8f-a7ed-c2ff-49a264b4e342@quicinc.com>
 <20220215173951.GH4285@paulmck-ThinkPad-P17-Gen-1>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220215173951.GH4285@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/15/2022 11:09 PM, Paul E. McKenney wrote:
> On Tue, Feb 15, 2022 at 07:53:10PM +0530, Mukesh Ojha wrote:
>> On 2/14/2022 10:14 PM, Paul E. McKenney wrote:
>>> On Thu, Feb 10, 2022 at 12:38:11AM +0100, Frederic Weisbecker wrote:
>>>> On Fri, Feb 04, 2022 at 02:55:07PM -0800, Paul E. McKenney wrote:
>>>>> Although it is usually safe to invoke synchronize_rcu_expedited() from a
>>>>> preemption-enabled CPU-hotplug notifier, if it is invoked from a notifier
>>>>> between CPUHP_AP_RCUTREE_ONLINE and CPUHP_AP_ACTIVE, its attempts to
>>>>> invoke a workqueue handler will hang due to RCU waiting on a CPU that
>>>>> the scheduler is not paying attention to.  This commit therefore expands
>>>>> use of the existing workqueue-independent synchronize_rcu_expedited()
>>>>> from early boot to also include CPUs that are being hotplugged.
>>>>>
>>>>> Link:https://lore.kernel.org/lkml/7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com/
>>>>> Reported-by: Mukesh Ojha<quic_mojha@quicinc.com>
>>>>> Cc: Tejun Heo<tj@kernel.org>
>>>>> Signed-off-by: Paul E. McKenney<paulmck@kernel.org>
>>>> I'm surprised by this scheduler behaviour.
>>>>
>>>> Since sched_cpu_activate() hasn't been called yet,
>>>> rq->balance_callback = balance_push_callback. As a result, balance_push() should
>>>> be called at the end of schedule() when the workqueue is picked as the next task.
>>>> Then eventually the workqueue should be immediately preempted by the stop task to
>>>> be migrated elsewhere.
>>>>
>>>> So I must be missing something. For the fun, I booted the following and it
>>>> didn't produce any issue:
>>>>
>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>> index 80faf2273ce9..b1e74a508881 100644
>>>> --- a/kernel/rcu/tree.c
>>>> +++ b/kernel/rcu/tree.c
>>>> @@ -4234,6 +4234,8 @@ int rcutree_online_cpu(unsigned int cpu)
>>>>    	// Stop-machine done, so allow nohz_full to disable tick.
>>>>    	tick_dep_clear(TICK_DEP_BIT_RCU);
>>>> +	if (cpu != 0)
>>>> +		synchronize_rcu_expedited();
>>>>    	return 0;
>>>>    }
>>> That does seem compelling.  And others have argued that the workqueue
>>> system's handling of offline CPUs should deal with this.
>>>
>>> Mukesh, was this a theoretical bug, or did you actually make it happen?
>>> If you made it happen, as seems to have been the case given your original
>>> email [1], could you please post your reproducer?
>> No, it was not theoretical one. We saw this issue only once in our testing
>> and i don't think it is easy to reproduce otherwise
>> it would been fixed by now.
>>
>> When one of thread calling synchronize_expedite_rcu with timer of 20s but it
>> did not get the exp funnel
>> lock for 20s and there we crash it with panic() on timeout.
>>
>> The other thread cpuhp which was having the lock got stuck at the point
>> mentioned at the below link.
>>
>> https://lore.kernel.org/lkml/7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com/
> OK.  Are you able to create an in-kernel reproducer, perhaps similar to
> Frederic's change above?
>
> I am worried that the patch that I am carrying might be fixing some
> other bug by accident...

Just for information, we are running on 5.10 kernel and after numerous 
attempt, i was not able to reproduce the issue:-)

Thanks,
-Mukesh

>
> 							Thanx, Paul
>
>> e.g Below sample test in combination of many other test in parallel
>>
>> :loop
>>
>> adb shell "echo 0 > /sys/devices/system/cpu/cpu0/online"
>>
>> adb shell "echo 1 > /sys/devices/system/cpu/cpu0/online"
>>
>> adb shell "echo 0 > /sys/devices/system/cpu/cpu1/online"
>>
>> adb shell "echo 1 > /sys/devices/system/cpu/cpu1/online"
>>
>> adb shell "echo 0 > /sys/devices/system/cpu/cpu2/online"
>>
>> adb shell "echo 1 > /sys/devices/system/cpu/cpu2/online"
>>
>> adb shell "echo 0 > /sys/devices/system/cpu/cpu3/online"
>>
>> adb shell "echo 1 > /sys/devices/system/cpu/cpu3/online"
>>
>> adb shell "echo 0 > /sys/devices/system/cpu/cpu4/online"
>>
>> adb shell "echo 1 > /sys/devices/system/cpu/cpu4/online"
>>
>> adb shell "echo 0 > /sys/devices/system/cpu/cpu5/online"
>>
>> adb shell "echo 1 > /sys/devices/system/cpu/cpu5/online"
>>
>> adb shell "echo 0 > /sys/devices/system/cpu/cpu6/online"
>>
>> adb shell "echo 1 > /sys/devices/system/cpu/cpu6/online"
>>
>> adb shell "echo 0 > /sys/devices/system/cpu/cpu7/online"
>>
>> adb shell "echo 1 > /sys/devices/system/cpu/cpu7/online"
>>
>> goto loop
>>
>>
>>
>> Thanks, Mukesh
>>
>>> 							Thanx, Paul
>>>
>>> [1]https://lore.kernel.org/lkml/7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com/
