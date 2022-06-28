Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013BC55D9F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242965AbiF1CO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241842AbiF1COX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:14:23 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CE023147
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 19:14:17 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q140so10794022pgq.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 19:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rj+i53ukRoXYJ2yY0Wlz4YVCqD422Ml65Ygb9bzAtfo=;
        b=AxVIKtzsr58FgsiTMN7WMSxshG3ZMcc2TWCq9Ef1QhZnUnJBJnC7arwBEEoPbhG4nf
         NFX7Wo571pGo22u+sWTluXcfqfDMC6uiDARfERvCV1aRkF+HppLxzK7wQ7OurDACILBu
         hdL8QkkMuygHe3bKLlpDYKBgdaf2fsZ6fWojIkjO71QaUL11Tm7fRqMawuJkZQVATMc9
         GmMg+lUnUHNK4eXCIY1NKM3a6Fqc1zk+d7ny1W+buDb++HeziFLqKqB7ZNcNqEDkPRU/
         l1vEFoLA6FIJ/+PktWrNMNI4xHKbcXL0iZS2LO8oxSPiR3tYUDNTGC7e21xwGehzahBr
         e22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rj+i53ukRoXYJ2yY0Wlz4YVCqD422Ml65Ygb9bzAtfo=;
        b=4gXT+8UV5s/MbW/vM6tWwH9UtD4UmCS2Qn+tr+5mIvl4vXKMIYZ9fqfld61akx3S8q
         QG6f2xqR5ITR6IbmO2uk1te/bOv9hiPg5jdsZ66bW2E9Pw4NWkdzMaZE8s9Wr3n8Gwo0
         yZdO+aZecadlfZF1zoCEkPmZ1qUaEDxeow3d0KOCiKoaolzBfJ1U7iL83QqgmbtTWWXN
         Tbf/l5nYCoprGKzwoKcqLzRfS4CkM5TqkdXM1+tUKbTtpipwG9Gz/0tHR6VL9O2fvQUM
         SMD8UmCypmChkU3Gn5HP+KhO2MtA6Gsw8yc8Qkn3lRQWmAg3sFw4ibhet7vyOGJApEvc
         On0A==
X-Gm-Message-State: AJIora/4twNqoNF8HmcMj3QiJuUniOldZtNXaUDVQmOuRiKHFB7GhGO+
        5r2ZfmRQ26FOPkO+nJDo5OU7uw==
X-Google-Smtp-Source: AGRyM1vFioeCZnGMMnERj0UQq7qwR7guHROOoLErrxiPr2HuoxMTXh+DBs1VAniq8g0O16u0kNC6dA==
X-Received: by 2002:a05:6a00:174f:b0:525:518e:71d6 with SMTP id j15-20020a056a00174f00b00525518e71d6mr1019892pfc.68.1656382457018;
        Mon, 27 Jun 2022 19:14:17 -0700 (PDT)
Received: from [10.31.0.6] ([199.101.192.39])
        by smtp.gmail.com with ESMTPSA id 11-20020a63164b000000b0040d4c8e335csm7742026pgw.75.2022.06.27.19.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 19:14:16 -0700 (PDT)
Subject: Re: [PATCH] srcu: Reduce blocking agressiveness of expedited grace
 periods further
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>, paulmck@kernel.org,
        frederic@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        urezki@gmail.com, shameerali.kolothum.thodi@huawei.com,
        pbonzini@redhat.com, mtosatti@redhat.com, eric.auger@redhat.com,
        chenxiang66@hisilicon.com, maz@kernel.org
References: <20220627123706.20187-1-quic_neeraju@quicinc.com>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <60336a5f-e7ab-48e6-2076-8db4ceb0561a@linaro.org>
Date:   Tue, 28 Jun 2022 10:14:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220627123706.20187-1-quic_neeraju@quicinc.com>
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



On 2022/6/27 下午8:37, Neeraj Upadhyay wrote:
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
> Below table captures the experiments done by Zhangfei Gao, Shameer,
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
> polls, soiuch that, non-sleeping polls are done for one jiffy. In addition
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

Test on arm64
git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
5.19-rc3

arch/arm64/configs/defconfig make defconfig CONFIG_PREEMPTION=y 
CONFIG_HZ_250=y

real    0m11.498s
user    0m2.911s
sys    0m1.171s


As comparison (Since can not directly revert on linux-rcu.git dev, so 
use rc1 instead)

5.19-rc1 + Revert "srcu: Prevent expedited GPs and blocking readers from 
consuming CPU"

real    0m8.173s
user    0m3.024s
sys    0m0.959s

5.19-rc1
real    2m41.433s
  user    0m3.097s
sys     0m1.177s

Thanks

> ---
>   .../admin-guide/kernel-parameters.txt         | 18 +++++
>   kernel/rcu/srcutree.c                         | 79 ++++++++++++++-----
>   2 files changed, 78 insertions(+), 19 deletions(-)
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
> index 0db7873f4e95..006828b9c41a 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -511,10 +511,49 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
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
> +// per-GP-phase no-delay instances adjusted to allow non-sleeping poll upto
> +// one jiffies time duration. Mult by 2 is done to factor in the srcu_get_delay()
> +// called from process_srcu().
> +#define SRCU_DEFAULT_MAX_NODELAY_PHASE_ADJUSTED	\
> +	(2UL * USEC_PER_SEC / HZ / SRCU_DEFAULT_RETRY_CHECK_DELAY)
> +
> +// Maximum per-GP-phase consecutive no-delay instances.
> +#define SRCU_DEFAULT_MAX_NODELAY_PHASE	(	\
> +	SRCU_UL_CLAMP_HI(SRCU_UL_CLAMP_LO(SRCU_DEFAULT_MAX_NODELAY_PHASE_ADJUSTED,	\
> +					  SRCU_DEFAULT_MAX_NODELAY_PHASE_LO),	\
> +			 SRCU_DEFAULT_MAX_NODELAY_PHASE_HI))
> +
> +static ulong srcu_max_nodelay_phase = SRCU_DEFAULT_MAX_NODELAY_PHASE;
> +module_param(srcu_max_nodelay_phase, ulong, 0444);
> +
> +#define SRCU_DEFAULT_MAX_NODELAY	100	// Maximum consecutive no-delay instances.
> +
> +static ulong srcu_max_nodelay = SRCU_DEFAULT_MAX_NODELAY;
> +module_param(srcu_max_nodelay, ulong, 0444);
>   
>   /*
>    * Return grace-period delay, zero if there are expedited grace
> @@ -535,7 +574,7 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
>   			jbase += j - gpstart;
>   		if (!jbase) {
>   			WRITE_ONCE(ssp->srcu_n_exp_nodelay, READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
> -			if (READ_ONCE(ssp->srcu_n_exp_nodelay) > SRCU_MAX_NODELAY_PHASE)
> +			if (READ_ONCE(ssp->srcu_n_exp_nodelay) > srcu_max_nodelay_phase)
>   				jbase = 1;
>   		}
>   	}
> @@ -612,15 +651,6 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
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
> @@ -706,7 +736,7 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
>    */
>   static void srcu_gp_end(struct srcu_struct *ssp)
>   {
> -	unsigned long cbdelay;
> +	unsigned long cbdelay = 1;
>   	bool cbs;
>   	bool last_lvl;
>   	int cpu;
> @@ -726,7 +756,9 @@ static void srcu_gp_end(struct srcu_struct *ssp)
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
> @@ -927,12 +959,16 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
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
> @@ -1588,7 +1624,7 @@ static void process_srcu(struct work_struct *work)
>   		j = jiffies;
>   		if (READ_ONCE(ssp->reschedule_jiffies) == j) {
>   			WRITE_ONCE(ssp->reschedule_count, READ_ONCE(ssp->reschedule_count) + 1);
> -			if (READ_ONCE(ssp->reschedule_count) > SRCU_MAX_NODELAY)
> +			if (READ_ONCE(ssp->reschedule_count) > srcu_max_nodelay)
>   				curdelay = 1;
>   		} else {
>   			WRITE_ONCE(ssp->reschedule_count, 1);
> @@ -1680,6 +1716,11 @@ static int __init srcu_bootup_announce(void)
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

