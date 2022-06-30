Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36925561287
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiF3GfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 02:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiF3GfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 02:35:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B063D2CE19
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:35:08 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q140so17569703pgq.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xmM2f2rapjoPPYWDw1Pv9ityiNIArvGkT1HaitAHUVo=;
        b=W6PsrYE4qyTmiL3MHdoj8cc/aafp8f/yTGnBGn2EKnyxOd29EgK57VoNILGZGEthAk
         EGZ3Oj/coCqdLpAq7C0c2NgN4vJh6OD37OIzOelEEvL23uXubjEVjkEL9/IWX3/gtDk2
         SFhB2Kz5o8Q+1Ow4Q8YlXWKT6YgbhV7jVfkjfOs/puMG/fo5x+KNcVR+NPCCR9yW+twE
         nu8q7F2LlvDlC8UvlUslHzso6nQYAC8ihMGyw8erd9AMAqhTqU3mzct7JXWp1V+aNi0O
         MOy0uTr3ZYT1KtDam2Rbp5CR8pXbSmVfEdK64PMRchRXAx7o9VMAMazI+jjzhMkBDecH
         jJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xmM2f2rapjoPPYWDw1Pv9ityiNIArvGkT1HaitAHUVo=;
        b=PqsZl525wWQYJXnHjZ2B1ywH99g+hmyNh5kWNgZTAHH4Un2j7RXzX3xwFsSmW344V9
         isaBKDvTWurn7N33hwA/kvh43yh2ns6UA/5TInlR797ooN9kTCV12jijqOXUvCfHfC2C
         qyaqJRfvFwUbfXeWfP57POD23M+1H1MxquhwaLN6glRy4nBmVUFjGfNpv3emyxtaAwKi
         tRiUBIjqX8cy1BTRb997aKhpE0uq/eYmx8HmEuiFaR6hPj22R5Ue6W+FNkNChwwTZI3i
         XYnrQbozGvMfwDowV8vywwRrpp60zq8ebyW/rKyJT2kr86AXyrmIrnavw9aayynhy6mh
         MIjw==
X-Gm-Message-State: AJIora9OffqiI5848GqHgsW3aT0R5wAuqxQtALAkgvffs/BmW4+EYXag
        RxfSzqL4YkuLSXqLP5dhv3zBgw==
X-Google-Smtp-Source: AGRyM1uvVszNKn7r5g7xsuDpjZzVRPfKZ5STT5XybY39MDSE2u5aVHmzL5+s6N6yS0NZx4R4+dXQ/Q==
X-Received: by 2002:a63:7741:0:b0:40c:c3cb:d9bd with SMTP id s62-20020a637741000000b0040cc3cbd9bdmr6137741pgc.581.1656570908151;
        Wed, 29 Jun 2022 23:35:08 -0700 (PDT)
Received: from [10.55.0.6] ([199.101.192.64])
        by smtp.gmail.com with ESMTPSA id x12-20020a17090300cc00b001624dab05edsm12610217plc.8.2022.06.29.23.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 23:35:07 -0700 (PDT)
Subject: Re: [PATCH v2] srcu: Reduce blocking agressiveness of expedited grace
 periods further
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>, paulmck@kernel.org,
        frederic@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        urezki@gmail.com, shameerali.kolothum.thodi@huawei.com,
        pbonzini@redhat.com, mtosatti@redhat.com, eric.auger@redhat.com,
        chenxiang66@hisilicon.com, maz@kernel.org
References: <20220630041201.18301-1-quic_neeraju@quicinc.com>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <6c7abde7-da75-1145-2fd8-2f49372c39ad@linaro.org>
Date:   Thu, 30 Jun 2022 14:34:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220630041201.18301-1-quic_neeraju@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/30 下午12:12, Neeraj Upadhyay wrote:
> Commit 640a7d37c3f4 ("srcu: Block less aggressively for expedited
> grace periods") highlights a problem where aggressively blocking
> SRCU expedited grace periods, as was introduced in commit
> 282d8998e997 ("srcu: Prevent expedited GPs and blocking readers
> from consuming CPU"), introduces ~2 minutes delay to the overall
> ~3.5 minutes boot time, when starting VMs with "-bios QEMU_EFI.fd"
> cmdline on qemu, which results in very high rate of memslots
> add/remove, which causes > ~6000 synchronize_srcu() calls for
> kvm->srcu SRCU instance.
>
> Below table captures the experiments done by Zhangfei Gao and Shameer
> to measure the boottime impact with various values of non-sleeping
> per phase counts, with HZ_250 and preemption enabled:
>
> +──────────────────────────+────────────────+
> | SRCU_MAX_NODELAY_PHASE   | Boot time (s)  |
> +──────────────────────────+────────────────+
> | 100                      | 30.053         |
> | 150                      | 25.151         |
> | 200                      | 20.704         |
> | 250                      | 15.748         |
> | 500                      | 11.401         |
> | 1000                     | 11.443         |
> | 10000                    | 11.258         |
> | 1000000                  | 11.154         |
> +──────────────────────────+────────────────+
>
> Analysis on the experiment results showed improved boot time
> with non blocking delays close to one jiffy duration. This
> was also seen when number of per-phase iterations were scaled
> to one jiffy.
>
> So, this change scales per-grace-period phase number of non-sleeping
> polls, such that, non-sleeping polls are done for one jiffy. In addition
> to this, srcu_get_delay() call in srcu_gp_end(), which is used to calculate
> the delay used for scheduling callbacks, is replaced with the check for
> expedited grace period. This is done, to schedule cbs for completed expedited
> grace periods immediately, which results in improved boot time seen in
> experiments.
>
> In addition to the changes to default per phase delays, this change
> adds 3 new kernel parameters - srcutree.srcu_max_nodelay,
> srcutree.srcu_max_nodelay_phase, srcutree.srcu_retry_check_delay.
> This allows users to configure the srcu grace period scanning delays,
> depending on their system configuration requirements.
>
> Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Tested-by: Marc Zyngier <maz@kernel.org>

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Test on arm64, defconfig(CONFIG_HZ_250=y)
qemu boot Image with -bios QEMU_EFI.fd


With this patch
real	0m9.739s
user	0m3.270s
sys	0m0.969s


Without this patch
real	2m40.361s
user	0m3.034s
sys	0m1.162s

5.18-rc6
real    0m8.402s
user    0m3.015s
sys     0m1.102s

Thanks

> ---
>
> Change in v2:
>
>    - Change srcu_max_nodelay default value to consider phase delay
>      iterations
>    - Apply Pauls' feedback
>    - Add Marc's Tested-by
>
>   .../admin-guide/kernel-parameters.txt         | 18 ++++
>   kernel/rcu/srcutree.c                         | 82 ++++++++++++++-----
>   2 files changed, 81 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index af647714c113..7e34086c64f5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5805,6 +5805,24 @@
>   			expediting.  Set to zero to disable automatic
>   			expediting.
>   
> +	srcutree.srcu_max_nodelay [KNL]
> +			Specifies the number of no-delay instances
> +			per jiffy for which the SRCU grace period
> +			worker thread will be rescheduled with zero
> +			delay. Beyond this limit, worker thread will
> +			be rescheduled with a sleep delay of one jiffy.
> +
> +	srcutree.srcu_max_nodelay_phase [KNL]
> +			Specifies the per-grace-period phase, number of
> +			non-sleeping polls of readers. Beyond this limit,
> +			grace period worker thread will be rescheduled
> +			with a sleep delay of one jiffy, between each
> +			rescan of the readers, for a grace period phase.
> +
> +	srcutree.srcu_retry_check_delay [KNL]
> +			Specifies number of microseconds of non-sleeping
> +			delay between each non-sleeping poll of readers.
> +
>   	srcutree.small_contention_lim [KNL]
>   			Specifies the number of update-side contention
>   			events per jiffy will be tolerated before
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 0db7873f4e95..1c304fec89c0 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -511,10 +511,52 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
>   	return sum;
>   }
>   
> -#define SRCU_INTERVAL		1	// Base delay if no expedited GPs pending.
> -#define SRCU_MAX_INTERVAL	10	// Maximum incremental delay from slow readers.
> -#define SRCU_MAX_NODELAY_PHASE	3	// Maximum per-GP-phase consecutive no-delay instances.
> -#define SRCU_MAX_NODELAY	100	// Maximum consecutive no-delay instances.
> +/*
> + * We use an adaptive strategy for synchronize_srcu() and especially for
> + * synchronize_srcu_expedited().  We spin for a fixed time period
> + * (defined below, boot time configurable) to allow SRCU readers to exit
> + * their read-side critical sections.  If there are still some readers
> + * after one jiffy, we repeatedly block for one jiffy time periods.
> + * The blocking time is increased as the grace-period age increases,
> + * with max blocking time capped at 10 jiffies.
> + */
> +#define SRCU_DEFAULT_RETRY_CHECK_DELAY		5
> +
> +static ulong srcu_retry_check_delay = SRCU_DEFAULT_RETRY_CHECK_DELAY;
> +module_param(srcu_retry_check_delay, ulong, 0444);
> +
> +#define SRCU_INTERVAL		1		// Base delay if no expedited GPs pending.
> +#define SRCU_MAX_INTERVAL	10		// Maximum incremental delay from slow readers.
> +
> +#define SRCU_DEFAULT_MAX_NODELAY_PHASE_LO	3UL	// Lowmark on default per-GP-phase
> +							// no-delay instances.
> +#define SRCU_DEFAULT_MAX_NODELAY_PHASE_HI	1000UL	// Highmark on default per-GP-phase
> +							// no-delay instances.
> +
> +#define SRCU_UL_CLAMP_LO(val, low)	((val) > (low) ? (val) : (low))
> +#define SRCU_UL_CLAMP_HI(val, high)	((val) < (high) ? (val) : (high))
> +#define SRCU_UL_CLAMP(val, low, high)	SRCU_UL_CLAMP_HI(SRCU_UL_CLAMP_LO((val), (low)), (high))
> +// per-GP-phase no-delay instances adjusted to allow non-sleeping poll upto
> +// one jiffies time duration. Mult by 2 is done to factor in the srcu_get_delay()
> +// called from process_srcu().
> +#define SRCU_DEFAULT_MAX_NODELAY_PHASE_ADJUSTED	\
> +	(2UL * USEC_PER_SEC / HZ / SRCU_DEFAULT_RETRY_CHECK_DELAY)
> +
> +// Maximum per-GP-phase consecutive no-delay instances.
> +#define SRCU_DEFAULT_MAX_NODELAY_PHASE	\
> +	SRCU_UL_CLAMP(SRCU_DEFAULT_MAX_NODELAY_PHASE_ADJUSTED,	\
> +		      SRCU_DEFAULT_MAX_NODELAY_PHASE_LO,	\
> +		      SRCU_DEFAULT_MAX_NODELAY_PHASE_HI)
> +
> +static ulong srcu_max_nodelay_phase = SRCU_DEFAULT_MAX_NODELAY_PHASE;
> +module_param(srcu_max_nodelay_phase, ulong, 0444);
> +
> +// Maximum consecutive no-delay instances.
> +#define SRCU_DEFAULT_MAX_NODELAY	(SRCU_DEFAULT_MAX_NODELAY_PHASE > 100 ?	\
> +					 SRCU_DEFAULT_MAX_NODELAY_PHASE : 100)
> +
> +static ulong srcu_max_nodelay = SRCU_DEFAULT_MAX_NODELAY;
> +module_param(srcu_max_nodelay, ulong, 0444);
>   
>   /*
>    * Return grace-period delay, zero if there are expedited grace
> @@ -535,7 +577,7 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
>   			jbase += j - gpstart;
>   		if (!jbase) {
>   			WRITE_ONCE(ssp->srcu_n_exp_nodelay, READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
> -			if (READ_ONCE(ssp->srcu_n_exp_nodelay) > SRCU_MAX_NODELAY_PHASE)
> +			if (READ_ONCE(ssp->srcu_n_exp_nodelay) > srcu_max_nodelay_phase)
>   				jbase = 1;
>   		}
>   	}
> @@ -612,15 +654,6 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
>   }
>   EXPORT_SYMBOL_GPL(__srcu_read_unlock);
>   
> -/*
> - * We use an adaptive strategy for synchronize_srcu() and especially for
> - * synchronize_srcu_expedited().  We spin for a fixed time period
> - * (defined below) to allow SRCU readers to exit their read-side critical
> - * sections.  If there are still some readers after a few microseconds,
> - * we repeatedly block for 1-millisecond time periods.
> - */
> -#define SRCU_RETRY_CHECK_DELAY		5
> -
>   /*
>    * Start an SRCU grace period.
>    */
> @@ -706,7 +739,7 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
>    */
>   static void srcu_gp_end(struct srcu_struct *ssp)
>   {
> -	unsigned long cbdelay;
> +	unsigned long cbdelay = 1;
>   	bool cbs;
>   	bool last_lvl;
>   	int cpu;
> @@ -726,7 +759,9 @@ static void srcu_gp_end(struct srcu_struct *ssp)
>   	spin_lock_irq_rcu_node(ssp);
>   	idx = rcu_seq_state(ssp->srcu_gp_seq);
>   	WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
> -	cbdelay = !!srcu_get_delay(ssp);
> +	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq), READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
> +		cbdelay = 0;
> +
>   	WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());
>   	rcu_seq_end(&ssp->srcu_gp_seq);
>   	gpseq = rcu_seq_current(&ssp->srcu_gp_seq);
> @@ -927,12 +962,16 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
>    */
>   static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
>   {
> +	unsigned long curdelay;
> +
> +	curdelay = !srcu_get_delay(ssp);
> +
>   	for (;;) {
>   		if (srcu_readers_active_idx_check(ssp, idx))
>   			return true;
> -		if (--trycount + !srcu_get_delay(ssp) <= 0)
> +		if ((--trycount + curdelay) <= 0)
>   			return false;
> -		udelay(SRCU_RETRY_CHECK_DELAY);
> +		udelay(srcu_retry_check_delay);
>   	}
>   }
>   
> @@ -1588,7 +1627,7 @@ static void process_srcu(struct work_struct *work)
>   		j = jiffies;
>   		if (READ_ONCE(ssp->reschedule_jiffies) == j) {
>   			WRITE_ONCE(ssp->reschedule_count, READ_ONCE(ssp->reschedule_count) + 1);
> -			if (READ_ONCE(ssp->reschedule_count) > SRCU_MAX_NODELAY)
> +			if (READ_ONCE(ssp->reschedule_count) > srcu_max_nodelay)
>   				curdelay = 1;
>   		} else {
>   			WRITE_ONCE(ssp->reschedule_count, 1);
> @@ -1680,6 +1719,11 @@ static int __init srcu_bootup_announce(void)
>   	pr_info("Hierarchical SRCU implementation.\n");
>   	if (exp_holdoff != DEFAULT_SRCU_EXP_HOLDOFF)
>   		pr_info("\tNon-default auto-expedite holdoff of %lu ns.\n", exp_holdoff);
> +	if (srcu_retry_check_delay != SRCU_DEFAULT_RETRY_CHECK_DELAY)
> +		pr_info("\tNon-default retry check delay of %lu us.\n", srcu_retry_check_delay);
> +	if (srcu_max_nodelay != SRCU_DEFAULT_MAX_NODELAY)
> +		pr_info("\tNon-default max no-delay of %lu.\n", srcu_max_nodelay);
> +	pr_info("\tMax phase no-delay instances is %lu.\n", srcu_max_nodelay_phase);
>   	return 0;
>   }
>   early_initcall(srcu_bootup_announce);

