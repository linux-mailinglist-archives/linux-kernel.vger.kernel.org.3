Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7CE549C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345507AbiFMS4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345487AbiFMSzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF29B4D9D3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655136090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mst+XIUPiZy/+7AqlJFILYkc8pwFunN3qQzNo3sARX8=;
        b=aZwkH5iPUg9jHHWlPTl7WHvRbv+pT5d3tVQQXOZcBlp8TnhjGPDj0GE0MiQhEhbtUDvwdP
        cBiawjRxZ9ayiR0aJzpcTAvd/zciBTSSQ/00VRPkzPudq7ooMh2IqqBOwS+u417LlvxK6K
        H/8yOOCAY78uC+ebuLo44B9GpsHXH74=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-uu7oK4JhMvyVf4K2uPgLvg-1; Mon, 13 Jun 2022 12:01:26 -0400
X-MC-Unique: uu7oK4JhMvyVf4K2uPgLvg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C77B185A7A4;
        Mon, 13 Jun 2022 16:01:25 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FB39492CA2;
        Mon, 13 Jun 2022 16:01:25 +0000 (UTC)
Message-ID: <5aae210e-2553-57ca-e4d5-0b0f20ec92cd@redhat.com>
Date:   Mon, 13 Jun 2022 12:01:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] rcu-tasks: Delay rcu_tasks_verify_self_tests() to avoid
 missed callbacks
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
References: <20220610184212.822113-1-longman@redhat.com>
 <20220610205814.GK1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220610205814.GK1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/22 16:58, Paul E. McKenney wrote:
> On Fri, Jun 10, 2022 at 02:42:12PM -0400, Waiman Long wrote:
>> Even though rcu_tasks selftest is initiated early in the boot process,
>> the verification done at late initcall time may not be late enough to
>> catch all the callbacks especially on systems with just a few cpus and
>> small memory.
>>
>> After 12 bootup's On a s390x system, 1 of them had failed rcu_tasks
>> verification test.
>>
>> [    8.183013] call_rcu_tasks() has been failed.
>> [    8.183041] WARNING: CPU: 0 PID: 1 at kernel/rcu/tasks.h:1696 rcu_tasks_verify_self_tests+0x64/0xd0
>> [    8.203246] Callback from call_rcu_tasks() invoked.
>>
>> In this particular case, the callback missed the check by about
>> 20ms. Similar rcu_tasks selftest failures are also seen in ppc64le
>> systems.
>>
>> [    0.313391] call_rcu_tasks() has been failed.
>> [    0.313407] WARNING: CPU: 0 PID: 1 at kernel/rcu/tasks.h:1696 rcu_tasks_verify_self_tests+0x5c/0xa0
>> [    0.335569] Callback from call_rcu_tasks() invoked.
>>
>> Avoid this missed callback by delaying the verification using
>> delayed_work. The delay is set to be about 0.1s which hopefully will
>> be long enough to catch all the callbacks on systems with few cpus and
>> small memory.
>>
>> Fixes: bfba7ed084f8 ("rcu-tasks: Add RCU-tasks self tests")
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Good catch, thank you!
>
> A few days ago, I queued this:
>
> 2585014188d5 ("rcu-tasks: Be more patient for RCU Tasks boot-time testing")
>
> This is shown in full at the end of this email.  Does this fix this
> problem for you?

I think your patch should fix the false positive warning and it give 
plenty of time for this to happen.

I do have one question though. rcu_tasks_verify_selft_tests() is called 
from do_initcalls(). Since it may not be the last late initcall, does 
that mean other late initcalls queued after that may be delayed by a 
second or more?

Thanks,
Longman

> 							Thanx, Paul
>
>> ---
>>   kernel/rcu/tasks.h | 19 ++++++++++++++++---
>>   1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>> index 3925e32159b5..25f964a671ba 100644s
>> --- a/kernel/rcu/tasks.h
>> +++ b/kernel/rcu/tasks.h
>> @@ -1735,7 +1735,7 @@ static void rcu_tasks_initiate_self_tests(void)
>>   #endif
>>   }
>>   
>> -static int rcu_tasks_verify_self_tests(void)
>> +static void rcu_tasks_verify_self_tests(struct work_struct *work __maybe_unused)
>>   {
>>   	int ret = 0;
>>   	int i;
>> @@ -1749,10 +1749,23 @@ static int rcu_tasks_verify_self_tests(void)
>>   
>>   	if (ret)
>>   		WARN_ON(1);
>> +}
>> +
>> +static struct delayed_work rcu_tasks_verify_work;
>>   
>> -	return ret;
>> +/*
>> + * The rcu_tasks verification is done indirectly via the work queue to
>> + * introduce an additional 0.1s delay to catch all the callbacks before
>> + * the verification is done as late_initcall time may not be late enough
>> + * to have all the callbacks fired.
>> + */
>> +static int rcu_tasks_verify_schedule_work(void)
>> +{
>> +	INIT_DELAYED_WORK(&rcu_tasks_verify_work, rcu_tasks_verify_self_tests);
>> +	schedule_delayed_work(&rcu_tasks_verify_work, HZ/10);
>> +	return 0;
>>   }
>> -late_initcall(rcu_tasks_verify_self_tests);
>> +late_initcall(rcu_tasks_verify_schedule_work);
>>   #else /* #ifdef CONFIG_PROVE_RCU */
>>   static void rcu_tasks_initiate_self_tests(void) { }
>>   #endif /* #else #ifdef CONFIG_PROVE_RCU */
>> -- 
>> 2.31.1
> ------------------------------------------------------------------------
>
> commit 2585014188d5e66052b4226b42602b6f3d921389
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Jun 7 15:23:52 2022 -0700
>
>      rcu-tasks: Be more patient for RCU Tasks boot-time testing
>      
>      The RCU-Tasks family of grace-period primitives can take some time to
>      complete, and the amount of time can depend on the exact hardware and
>      software configuration.  Some configurations boot up fast enough that the
>      RCU-Tasks verification process gets false-positive failures.  This commit
>      therefore allows up to 30 seconds for the grace periods to complete, with
>      this value adjustable downwards using the rcupdate.rcu_task_stall_timeout
>      kernel boot parameter.
>      
>      Reported-by: Matthew Wilcox <willy@infradead.org>
>      Reported-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>      Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index df6b2cb2f205d..fcbd0ec33c866 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -145,6 +145,7 @@ static int rcu_task_ipi_delay __read_mostly = RCU_TASK_IPI_DELAY;
>   module_param(rcu_task_ipi_delay, int, 0644);
>   
>   /* Control stall timeouts.  Disable with <= 0, otherwise jiffies till stall. */
> +#define RCU_TASK_BOOT_STALL_TIMEOUT (HZ * 30)
>   #define RCU_TASK_STALL_TIMEOUT (HZ * 60 * 10)
>   static int rcu_task_stall_timeout __read_mostly = RCU_TASK_STALL_TIMEOUT;
>   module_param(rcu_task_stall_timeout, int, 0644);
> @@ -1776,23 +1777,24 @@ struct rcu_tasks_test_desc {
>   	struct rcu_head rh;
>   	const char *name;
>   	bool notrun;
> +	unsigned long runstart;
>   };
>   
>   static struct rcu_tasks_test_desc tests[] = {
>   	{
>   		.name = "call_rcu_tasks()",
>   		/* If not defined, the test is skipped. */
> -		.notrun = !IS_ENABLED(CONFIG_TASKS_RCU),
> +		.notrun = IS_ENABLED(CONFIG_TASKS_RCU),
>   	},
>   	{
>   		.name = "call_rcu_tasks_rude()",
>   		/* If not defined, the test is skipped. */
> -		.notrun = !IS_ENABLED(CONFIG_TASKS_RUDE_RCU),
> +		.notrun = IS_ENABLED(CONFIG_TASKS_RUDE_RCU),
>   	},
>   	{
>   		.name = "call_rcu_tasks_trace()",
>   		/* If not defined, the test is skipped. */
> -		.notrun = !IS_ENABLED(CONFIG_TASKS_TRACE_RCU)
> +		.notrun = IS_ENABLED(CONFIG_TASKS_TRACE_RCU)
>   	}
>   };
>   
> @@ -1803,23 +1805,28 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
>   
>   	pr_info("Callback from %s invoked.\n", rttd->name);
>   
> -	rttd->notrun = true;
> +	rttd->notrun = false;
>   }
>   
>   static void rcu_tasks_initiate_self_tests(void)
>   {
> +	unsigned long j = jiffies;
> +
>   	pr_info("Running RCU-tasks wait API self tests\n");
>   #ifdef CONFIG_TASKS_RCU
> +	tests[0].runstart = j;
>   	synchronize_rcu_tasks();
>   	call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
>   #endif
>   
>   #ifdef CONFIG_TASKS_RUDE_RCU
> +	tests[1].runstart = j;
>   	synchronize_rcu_tasks_rude();
>   	call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
>   #endif
>   
>   #ifdef CONFIG_TASKS_TRACE_RCU
> +	tests[2].runstart = j;
>   	synchronize_rcu_tasks_trace();
>   	call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
>   #endif
> @@ -1829,11 +1836,18 @@ static int rcu_tasks_verify_self_tests(void)
>   {
>   	int ret = 0;
>   	int i;
> +	unsigned long bst = rcu_task_stall_timeout;
>   
> +	if (bst <= 0 || bst > RCU_TASK_BOOT_STALL_TIMEOUT)
> +		bst = RCU_TASK_BOOT_STALL_TIMEOUT;
>   	for (i = 0; i < ARRAY_SIZE(tests); i++) {
> -		if (!tests[i].notrun) {		// still hanging.
> -			pr_err("%s has been failed.\n", tests[i].name);
> -			ret = -1;
> +		while (tests[i].notrun) {		// still hanging.
> +			if (time_after(jiffies, tests[i].runstart + bst)) {
> +				pr_err("%s has failed boot-time tests.\n", tests[i].name);
> +				ret = -1;
> +				break;
> +			}
> +			schedule_timeout_uninterruptible(1);
>   		}
>   	}
>   
>

