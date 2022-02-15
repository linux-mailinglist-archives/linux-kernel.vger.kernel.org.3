Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D6E4B6EE5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238600AbiBOO2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:28:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiBOO2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:28:20 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5895CD5C6;
        Tue, 15 Feb 2022 06:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644935291; x=1676471291;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=IxZPRn3PRww00HcXj8jTGAVMUoCeGo47bOY16z1HyQk=;
  b=idFyYX/mYcPvYsR9+X4ZRWH7iCr8HkQDGMTfs2GmY/MZ0Uh7N1wjIkr5
   0w8IvOgsxLo5dmUC5sL4ZYEVdMpoumGZIF1uB27qzMQuLNn9UwewXP6vH
   8As2FYJYZ0592X6Ox2i4N1cXCUWv2KJczwZrpqAfHMvXqMRoE0g4qhOeq
   c=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 15 Feb 2022 06:28:11 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 06:28:10 -0800
Received: from [10.216.42.218] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Tue, 15 Feb
 2022 06:28:07 -0800
Message-ID: <ea2984ff-b4b4-8814-15e8-78366def3ad1@quicinc.com>
Date:   Tue, 15 Feb 2022 19:58:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH rcu 3/3] rcu: Allow expedited RCU grace periods on
 incoming CPUs
Content-Language: en-US
To:     <paulmck@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>,
        <rostedt@goodmis.org>, <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220209233811.GC557593@lothringen>
 <20220214164435.GA2805255@paulmck-ThinkPad-P17-Gen-1>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220214164435.GA2805255@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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


On 2/14/2022 10:14 PM, Paul E. McKenney wrote:
> On Thu, Feb 10, 2022 at 12:38:11AM +0100, Frederic Weisbecker wrote:
>> On Fri, Feb 04, 2022 at 02:55:07PM -0800, Paul E. McKenney wrote:
>>> Although it is usually safe to invoke synchronize_rcu_expedited() from a
>>> preemption-enabled CPU-hotplug notifier, if it is invoked from a notifier
>>> between CPUHP_AP_RCUTREE_ONLINE and CPUHP_AP_ACTIVE, its attempts to
>>> invoke a workqueue handler will hang due to RCU waiting on a CPU that
>>> the scheduler is not paying attention to.  This commit therefore expands
>>> use of the existing workqueue-independent synchronize_rcu_expedited()
>>> from early boot to also include CPUs that are being hotplugged.
>>>
>>> Link: https://lore.kernel.org/lkml/7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com/
>>> Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>> Cc: Tejun Heo <tj@kernel.org>
>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>> I'm surprised by this scheduler behaviour.
>>
>> Since sched_cpu_activate() hasn't been called yet,
>> rq->balance_callback = balance_push_callback. As a result, balance_push() should
>> be called at the end of schedule() when the workqueue is picked as the next task.
>> Then eventually the workqueue should be immediately preempted by the stop task to
>> be migrated elsewhere.
>>
>> So I must be missing something. For the fun, I booted the following and it
>> didn't produce any issue:
>>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index 80faf2273ce9..b1e74a508881 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -4234,6 +4234,8 @@ int rcutree_online_cpu(unsigned int cpu)
>>   
>>   	// Stop-machine done, so allow nohz_full to disable tick.
>>   	tick_dep_clear(TICK_DEP_BIT_RCU);
>> +	if (cpu != 0)
>> +		synchronize_rcu_expedited();
>>   	return 0;
>>   }
> That does seem compelling.  And others have argued that the workqueue
> system's handling of offline CPUs should deal with this.
>
> Mukesh, was this a theoretical bug, or did you actually make it happen?
> If you made it happen, as seems to have been the case given your original
> email [1], could you please post your reproducer?
>
> 							Thanx, Paul


No, it was not theoretical one. We saw this issue only once in our 
testing and i don't think it is easy to reproduce otherwise
it would been fixed by now.

When one of thread calling synchronize_expedite_rcu with timer of 20s 
but it did not get the exp funnel
lock for 20s and there we crash it with panic() on timeout.

The other thread cpuhp which was having the lock got stuck at the point 
mentioned at the below link.

> [1] https://lore.kernel.org/lkml/7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com/

Below sample test in combination of many other tests

:loop
adb shell "echo 0 > /sys/devices/system/cpu/cpu0/online"
adb shell "echo 1 > /sys/devices/system/cpu/cpu0/online"
adb shell "echo 0 > /sys/devices/system/cpu/cpu1/online"
adb shell "echo 1 > /sys/devices/system/cpu/cpu1/online"
adb shell "echo 0 > /sys/devices/system/cpu/cpu2/online"
adb shell "echo 1 > /sys/devices/system/cpu/cpu2/online"
adb shell "echo 0 > /sys/devices/system/cpu/cpu3/online"
adb shell "echo 1 > /sys/devices/system/cpu/cpu3/online"
adb shell "echo 0 > /sys/devices/system/cpu/cpu4/online"
adb shell "echo 1 > /sys/devices/system/cpu/cpu4/online"
adb shell "echo 0 > /sys/devices/system/cpu/cpu5/online"
adb shell "echo 1 > /sys/devices/system/cpu/cpu5/online"
adb shell "echo 0 > /sys/devices/system/cpu/cpu6/online"
adb shell "echo 1 > /sys/devices/system/cpu/cpu6/online"
adb shell "echo 0 > /sys/devices/system/cpu/cpu7/online"
adb shell "echo 1 > /sys/devices/system/cpu/cpu7/online"
goto loop

-Mukesh
