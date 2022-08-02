Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277EC587565
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 04:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbiHBCGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 22:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiHBCGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 22:06:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C763D18E32;
        Mon,  1 Aug 2022 19:06:09 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LxdZ10bhGzlW8N;
        Tue,  2 Aug 2022 10:03:21 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 10:06:02 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 10:06:01 +0800
Subject: Re: [PATCH v3 1/3] rcu/exp: Use NMI to get the backtrace of
 cpu_curr(other_cpu) first
To:     <paulmck@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>
References: <20220730102330.1255-1-thunder.leizhen@huawei.com>
 <20220730102330.1255-2-thunder.leizhen@huawei.com>
 <20220801231415.GC2860372@paulmck-ThinkPad-P17-Gen-1>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <1fd08a9a-fd2b-2608-da55-5bc526515131@huawei.com>
Date:   Tue, 2 Aug 2022 10:06:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20220801231415.GC2860372@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/2 7:14, Paul E. McKenney wrote:
> On Sat, Jul 30, 2022 at 06:23:28PM +0800, Zhen Lei wrote:
>> The backtrace of cpu_curr(other_cpu) is unwinded based on the 'fp' saved
>> during its last switch-out. For the most part, it's out of date. So try
>> to use NMI to get the backtrace first, just like those functions in
>> "tree_stall.h" did. Such as rcu_dump_cpu_stacks().
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Much better, thank you!
> 
>> ---
>>  kernel/rcu/tree_exp.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
>> index 0f70f62039a9090..21381697de23f0b 100644
>> --- a/kernel/rcu/tree_exp.h
>> +++ b/kernel/rcu/tree_exp.h
>> @@ -665,7 +665,8 @@ static void synchronize_rcu_expedited_wait(void)
>>  				mask = leaf_node_cpu_bit(rnp, cpu);
>>  				if (!(READ_ONCE(rnp->expmask) & mask))
>>  					continue;
>> -				dump_cpu_task(cpu);
>> +				if (!trigger_single_cpu_backtrace(cpu))
>> +					dump_cpu_task(cpu);
> 
> But why not just leave this unchanged, rather than adding the call to
> trigger_single_cpu_backtrace() in this patch and then removing it in
> the next patch?

To make the patch clear and easy to describe. Otherwise, I need to
give an additional description of it in the next patch, because I
searched all dump_cpu_task(). This seems to make the next patch
less simple.

Some of the patch sets I've seen have been done step by step like
this. But I can't find it now.

On the other hand, this patch is a small fix. Earlier versions may
only backport it, not the next cleanup patch.

> 
> 							Thanx, Paul
> 
>>  			}
>>  		}
>>  		jiffies_stall = 3 * rcu_exp_jiffies_till_stall_check() + 3;
>> -- 
>> 2.25.1
>>
> .
> 

-- 
Regards,
  Zhen Lei
