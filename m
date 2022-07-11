Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0148555D916
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiF1DQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiF1DP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:15:59 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2AF17046
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656386158; x=1687922158;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xrNhr5PJXv5rdi6BRf8BDvuNJlJWvhnN3MpDORuAQRU=;
  b=A5xt/hxh0hZPiYZqYa4ICzYHlMN5uUcaaIGmKNT5qSnACb8J2AcOvQBp
   zAHVs/I9E0ZgwBwCreI6dZO+O+7V1kixxi8YON62dQd3hqRfJma8T5x6U
   ScOcqN2TTMD/ZTWXZu7y9n5/DIqcxLkOpOZlLdhUI2WIWIvpX/BKlzq6H
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Jun 2022 20:15:57 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 20:15:57 -0700
Received: from [10.50.26.93] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 27 Jun
 2022 20:15:52 -0700
Message-ID: <937303f1-00fb-0e21-fcd3-0a8a3e827921@quicinc.com>
Date:   Tue, 28 Jun 2022 08:45:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] srcu: Reduce blocking agressiveness of expedited grace
 periods further
Content-Language: en-US
To:     <paulmck@kernel.org>
CC:     <frederic@kernel.org>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>, <zhangfei.gao@foxmail.com>,
        <boqun.feng@gmail.com>, <urezki@gmail.com>,
        <shameerali.kolothum.thodi@huawei.com>, <pbonzini@redhat.com>,
        <mtosatti@redhat.com>, <eric.auger@redhat.com>,
        <chenxiang66@hisilicon.com>, <maz@kernel.org>
References: <20220627123706.20187-1-quic_neeraju@quicinc.com>
 <20220627224558.GT1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20220627224558.GT1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/28/2022 4:15 AM, Paul E. McKenney wrote:
> On Mon, Jun 27, 2022 at 06:07:06PM +0530, Neeraj Upadhyay wrote:
>> Commit 640a7d37c3f4 ("srcu: Block less aggressively for expedited
>> grace periods") highlights a problem where aggressively blocking
>> SRCU expedited grace periods, as was introduced in commit
>> 282d8998e997 ("srcu: Prevent expedited GPs and blocking readers
>> from consuming CPU"), introduces ~2 minutes delay to the overall
>> ~3.5 minutes boot time, when starting VMs with "-bios QEMU_EFI.fd"
>> cmdline on qemu, which results in very high rate of memslots
>> add/remove, which causes > ~6000 synchronize_srcu() calls for
>> kvm->srcu SRCU instance.
>>
>> Below table captures the experiments done by Zhangfei Gao, Shameer,
> 
> Zhangfei Gao and Shameerali Kolothum without commas?
> 

Will fix in next version

>> to measure the boottime impact with various values of non-sleeping
>> per phase counts, with HZ_250 and preemption enabled:
>>
>> +──────────────────────────+────────────────+
>> | SRCU_MAX_NODELAY_PHASE   | Boot time (s)  |
>> +──────────────────────────+────────────────+
>> | 100                      | 30.053         |
>> | 150                      | 25.151         |
>> | 200                      | 20.704         |
>> | 250                      | 15.748         |
>> | 500                      | 11.401         |
>> | 1000                     | 11.443         |
>> | 10000                    | 11.258         |
>> | 1000000                  | 11.154         |
>> +──────────────────────────+────────────────+
>>
>> Analysis on the experiment results showed improved boot time
>> with non blocking delays close to one jiffy duration. This
>> was also seen when number of per-phase iterations were scaled
>> to one jiffy.
>>
>> So, this change scales per-grace-period phase number of non-sleeping
>> polls, soiuch that, non-sleeping polls are done for one jiffy. In addition
> 
> such that?
> 

oops, will fix.

>> to this, srcu_get_delay() call in srcu_gp_end(), which is used to calculate
>> the delay used for scheduling callbacks, is replaced with the check for
>> expedited grace period. This is done, to schedule cbs for completed expedited
>> grace periods immediately, which results in improved boot time seen in
>> experiments.
>>
>> In addition to the changes to default per phase delays, this change
>> adds 3 new kernel parameters - srcutree.srcu_max_nodelay,
>> srcutree.srcu_max_nodelay_phase, srcutree.srcu_retry_check_delay.
>> This allows users to configure the srcu grace period scanning delays,
>> depending on their system configuration requirements.
>>
>> Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> 
> I have queued this on an experimental branch quic_neeraju.2022.06.27a
> for testing purposes.  One question below.

Thanks!

> 
>> ---
>>   .../admin-guide/kernel-parameters.txt         | 18 +++++
>>   kernel/rcu/srcutree.c                         | 79 ++++++++++++++-----
>>   2 files changed, 78 insertions(+), 19 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index af647714c113..7e34086c64f5 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5805,6 +5805,24 @@
>>   			expediting.  Set to zero to disable automatic
>>   			expediting.
>>   
>> +	srcutree.srcu_max_nodelay [KNL]
>> +			Specifies the number of no-delay instances
>> +			per jiffy for which the SRCU grace period
>> +			worker thread will be rescheduled with zero
>> +			delay. Beyond this limit, worker thread will
>> +			be rescheduled with a sleep delay of one jiffy.
>> +
>> +	srcutree.srcu_max_nodelay_phase [KNL]
>> +			Specifies the per-grace-period phase, number of
>> +			non-sleeping polls of readers. Beyond this limit,
>> +			grace period worker thread will be rescheduled
>> +			with a sleep delay of one jiffy, between each
>> +			rescan of the readers, for a grace period phase.
>> +
>> +	srcutree.srcu_retry_check_delay [KNL]
>> +			Specifies number of microseconds of non-sleeping
>> +			delay between each non-sleeping poll of readers.
>> +
>>   	srcutree.small_contention_lim [KNL]
>>   			Specifies the number of update-side contention
>>   			events per jiffy will be tolerated before
>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>> index 0db7873f4e95..006828b9c41a 100644
>> --- a/kernel/rcu/srcutree.c
>> +++ b/kernel/rcu/srcutree.c
>> @@ -511,10 +511,49 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
>>   	return sum;
>>   }
>>   
>> -#define SRCU_INTERVAL		1	// Base delay if no expedited GPs pending.
>> -#define SRCU_MAX_INTERVAL	10	// Maximum incremental delay from slow readers.
>> -#define SRCU_MAX_NODELAY_PHASE	3	// Maximum per-GP-phase consecutive no-delay instances.
>> -#define SRCU_MAX_NODELAY	100	// Maximum consecutive no-delay instances.
>> +/*
>> + * We use an adaptive strategy for synchronize_srcu() and especially for
>> + * synchronize_srcu_expedited().  We spin for a fixed time period
>> + * (defined below, boot time configurable) to allow SRCU readers to exit
>> + * their read-side critical sections.  If there are still some readers
>> + * after one jiffy, we repeatedly block for one jiffy time periods.
>> + * The blocking time is increased as the grace-period age increases,
>> + * with max blocking time capped at 10 jiffies.
>> + */
>> +#define SRCU_DEFAULT_RETRY_CHECK_DELAY		5
>> +
>> +static ulong srcu_retry_check_delay = SRCU_DEFAULT_RETRY_CHECK_DELAY;
>> +module_param(srcu_retry_check_delay, ulong, 0444);
>> +
>> +#define SRCU_INTERVAL		1		// Base delay if no expedited GPs pending.
>> +#define SRCU_MAX_INTERVAL	10		// Maximum incremental delay from slow readers.
>> +
>> +#define SRCU_DEFAULT_MAX_NODELAY_PHASE_LO	3UL	// Lowmark on default per-GP-phase
>> +							// no-delay instances.
>> +#define SRCU_DEFAULT_MAX_NODELAY_PHASE_HI	1000UL	// Highmark on default per-GP-phase
>> +							// no-delay instances.
>> +
>> +#define SRCU_UL_CLAMP_LO(val, low)	((val) > (low) ? (val) : (low))
>> +#define SRCU_UL_CLAMP_HI(val, high)	((val) < (high) ? (val) : (high))
> 
> Can these just be clamp()?  Or does its type checking get in the way?
> 

When I use clamp() or clamp_t(), I get warning like below:


CC      kernel/rcu/srcutree.o
In file included from ./include/linux/kernel.h:26:0,
                  from ./arch/x86/include/asm/percpu.h:27,
                  from ./arch/x86/include/asm/current.h:6,
                  from ./include/linux/mutex.h:14,
                  from kernel/rcu/srcutree.c:19:
./include/linux/minmax.h:30:50: error: braced-group within expression 
allowed only inside a function
  #define __cmp_once(x, y, unique_x, unique_y, op) ({ \
                                                   ^
./include/linux/minmax.h:20:21: note: in definition of macro ‘__typecheck’
   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))


Which seems to be coming from braced usage in __cmp_once()
#define __cmp_once(x, y, unique_x, unique_y, op) ({     \
                 typeof(x) unique_x = (x);               \
                 typeof(y) unique_y = (y);               \
                 __cmp(unique_x, unique_y, op); })

... as I am using clamp() to initialize module param , which is outside 
of a function.

static ulong srcu_max_nodelay_phase = SRCU_DEFAULT_MAX_NODELAY_PHASE;



Thanks
Neeraj

> 							Thanx, Paul
> 
>> +// per-GP-phase no-delay instances adjusted to allow non-sleeping poll upto
>> +// one jiffies time duration. Mult by 2 is done to factor in the srcu_get_delay()
>> +// called from process_srcu().
>> +#define SRCU_DEFAULT_MAX_NODELAY_PHASE_ADJUSTED	\
>> +	(2UL * USEC_PER_SEC / HZ / SRCU_DEFAULT_RETRY_CHECK_DELAY)
>> +
>> +// Maximum per-GP-phase consecutive no-delay instances.
>> +#define SRCU_DEFAULT_MAX_NODELAY_PHASE	(	\
>> +	SRCU_UL_CLAMP_HI(SRCU_UL_CLAMP_LO(SRCU_DEFAULT_MAX_NODELAY_PHASE_ADJUSTED,	\
>> +					  SRCU_DEFAULT_MAX_NODELAY_PHASE_LO),	\
>> +			 SRCU_DEFAULT_MAX_NODELAY_PHASE_HI))
>> +
>> +static ulong srcu_max_nodelay_phase = SRCU_DEFAULT_MAX_NODELAY_PHASE;
>> +module_param(srcu_max_nodelay_phase, ulong, 0444);
>> +
>> +#define SRCU_DEFAULT_MAX_NODELAY	100	// Maximum consecutive no-delay instances.
>> +
>> +static ulong srcu_max_nodelay = SRCU_DEFAULT_MAX_NODELAY;
>> +module_param(srcu_max_nodelay, ulong, 0444);
>>   
>>   /*
>>    * Return grace-period delay, zero if there are expedited grace
>> @@ -535,7 +574,7 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
>>   			jbase += j - gpstart;
>>   		if (!jbase) {
>>   			WRITE_ONCE(ssp->srcu_n_exp_nodelay, READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
>> -			if (READ_ONCE(ssp->srcu_n_exp_nodelay) > SRCU_MAX_NODELAY_PHASE)
>> +			if (READ_ONCE(ssp->srcu_n_exp_nodelay) > srcu_max_nodelay_phase)
>>   				jbase = 1;
>>   		}
>>   	}
>> @@ -612,15 +651,6 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
>>   }
>>   EXPORT_SYMBOL_GPL(__srcu_read_unlock);
>>   
>> -/*
>> - * We use an adaptive strategy for synchronize_srcu() and especially for
>> - * synchronize_srcu_expedited().  We spin for a fixed time period
>> - * (defined below) to allow SRCU readers to exit their read-side critical
>> - * sections.  If there are still some readers after a few microseconds,
>> - * we repeatedly block for 1-millisecond time periods.
>> - */
>> -#define SRCU_RETRY_CHECK_DELAY		5
>> -
>>   /*
>>    * Start an SRCU grace period.
>>    */
>> @@ -706,7 +736,7 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
>>    */
>>   static void srcu_gp_end(struct srcu_struct *ssp)
>>   {
>> -	unsigned long cbdelay;
>> +	unsigned long cbdelay = 1;
>>   	bool cbs;
>>   	bool last_lvl;
>>   	int cpu;
>> @@ -726,7 +756,9 @@ static void srcu_gp_end(struct srcu_struct *ssp)
>>   	spin_lock_irq_rcu_node(ssp);
>>   	idx = rcu_seq_state(ssp->srcu_gp_seq);
>>   	WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
>> -	cbdelay = !!srcu_get_delay(ssp);
>> +	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq), READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
>> +		cbdelay = 0;
>> +
>>   	WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());
>>   	rcu_seq_end(&ssp->srcu_gp_seq);
>>   	gpseq = rcu_seq_current(&ssp->srcu_gp_seq);
>> @@ -927,12 +959,16 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
>>    */
>>   static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
>>   {
>> +	unsigned long curdelay;
>> +
>> +	curdelay = !srcu_get_delay(ssp);
>> +
>>   	for (;;) {
>>   		if (srcu_readers_active_idx_check(ssp, idx))
>>   			return true;
>> -		if (--trycount + !srcu_get_delay(ssp) <= 0)
>> +		if ((--trycount + curdelay) <= 0)
>>   			return false;
>> -		udelay(SRCU_RETRY_CHECK_DELAY);
>> +		udelay(srcu_retry_check_delay);
>>   	}
>>   }
>>   
>> @@ -1588,7 +1624,7 @@ static void process_srcu(struct work_struct *work)
>>   		j = jiffies;
>>   		if (READ_ONCE(ssp->reschedule_jiffies) == j) {
>>   			WRITE_ONCE(ssp->reschedule_count, READ_ONCE(ssp->reschedule_count) + 1);
>> -			if (READ_ONCE(ssp->reschedule_count) > SRCU_MAX_NODELAY)
>> +			if (READ_ONCE(ssp->reschedule_count) > srcu_max_nodelay)
>>   				curdelay = 1;
>>   		} else {
>>   			WRITE_ONCE(ssp->reschedule_count, 1);
>> @@ -1680,6 +1716,11 @@ static int __init srcu_bootup_announce(void)
>>   	pr_info("Hierarchical SRCU implementation.\n");
>>   	if (exp_holdoff != DEFAULT_SRCU_EXP_HOLDOFF)
>>   		pr_info("\tNon-default auto-expedite holdoff of %lu ns.\n", exp_holdoff);
>> +	if (srcu_retry_check_delay != SRCU_DEFAULT_RETRY_CHECK_DELAY)
>> +		pr_info("\tNon-default retry check delay of %lu us.\n", srcu_retry_check_delay);
>> +	if (srcu_max_nodelay != SRCU_DEFAULT_MAX_NODELAY)
>> +		pr_info("\tNon-default max no-delay of %lu.\n", srcu_max_nodelay);
>> +	pr_info("\tMax phase no-delay instances is %lu.\n", srcu_max_nodelay_phase);
>>   	return 0;
>>   }
>>   early_initcall(srcu_bootup_announce);
>> -- 
>> 2.17.1
>>
