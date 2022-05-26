Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85639534F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347236AbiEZM3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbiEZM3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:29:22 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2552E3B3EB
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:29:20 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id AF45A24010A
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 14:29:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1653568158; bh=ZvHFDTJj3PDcLCu6uRttdmWEtz7RZGQPjet07o2/DX4=;
        h=Subject:To:Cc:From:Date:From;
        b=JTIz56tSGdyhulQAlPkbExH0g+nj+KlpHq+qBLBo0h30EeDINwLS0Q2NSlx2Thnhd
         7+IPc6qGqY0kP3/Dzl+9TU1mLb8cU6Fr8ZcLDCPHyjS9KvadWmPJMjczR8NfyjnM8U
         +Gy4/mXQmTCF1N0E20qWZ6sWmwy7XD/d6DLsJTLu7XQ0JSlPaoY1sD6kUmtzi5kclV
         gS+lU8hV1WYVozM/2JKT3jM4LbA8Y8sju8pU63LFkar38TB9RQF/yCfnLfJeu5Wl/N
         bbFapeV8q23K7dz4X8S9/tRjxqLQR+CyXVh3FN/xKvfEUf4htJGy09KT5gGArRaRpW
         rbPpJg8uQNyVg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L86gc4tLhz6tmR;
        Thu, 26 May 2022 14:29:16 +0200 (CEST)
Subject: Re: [PATCH v2] cpu/hotplug: Do not bail-out in DYING/STARTING
 sections
To:     Vincent Donnefort <vdonnefort@google.com>, peterz@infradead.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, vschneid@redhat.com,
        kernel-team@android.com
References: <20220523160536.2889162-1-vdonnefort@google.com>
From:   Derek Dolney <z23@posteo.net>
Message-ID: <77d0ed9b-8521-c4a9-69c4-ec82cba81e61@posteo.net>
Date:   Thu, 26 May 2022 12:27:26 +0000
MIME-Version: 1.0
In-Reply-To: <20220523160536.2889162-1-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested by: Derek Dolney <z23@posteo.net>

Suspend and resume with tboot are working again with this patch. Tested
on 5.12 broken commit and latest git 5.18.

On 5/23/22 12:05 PM, Vincent Donnefort wrote:
> The DYING/STARTING callbacks are not expected to fail. However, as reported
> by Derek, drivers such as tboot are still free to return errors within
> those sections. In that case, there's nothing the hotplug machinery can do,
> so let's just proceed and log the failures.
> 
> Fixes: 453e41085183 (cpu/hotplug: Add cpuhp_invoke_callback_range())
> Reported-by: Derek Dolney <z23@posteo.net>
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> ---
> 
> v1 -> v2: 
>    - Commit message rewording.
>    - More details in the warnings.
>    - Some variable renaming
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index bbad5e375d3b..c3617683459e 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -663,21 +663,51 @@ static bool cpuhp_next_state(bool bringup,
>  	return true;
>  }
>  
> -static int cpuhp_invoke_callback_range(bool bringup,
> -				       unsigned int cpu,
> -				       struct cpuhp_cpu_state *st,
> -				       enum cpuhp_state target)
> +static int _cpuhp_invoke_callback_range(bool bringup,
> +					unsigned int cpu,
> +					struct cpuhp_cpu_state *st,
> +					enum cpuhp_state target,
> +					bool nofail)
>  {
>  	enum cpuhp_state state;
> -	int err = 0;
> +	int ret = 0;
>  
>  	while (cpuhp_next_state(bringup, &state, st, target)) {
> +		int err;
> +
>  		err = cpuhp_invoke_callback(cpu, state, bringup, NULL, NULL);
> -		if (err)
> +		if (!err)
> +			continue;
> +
> +		if (nofail) {
> +			pr_warn("CPU %u %s state %s (%d) failed (%d)\n",
> +				cpu, bringup ? "UP" : "DOWN",
> +				cpuhp_get_step(st->state)->name,
> +				st->state, err);
> +			ret = -1;
> +		} else {
> +			ret = err;
>  			break;
> +		}
>  	}
>  
> -	return err;
> +	return ret;
> +}
> +
> +static inline int cpuhp_invoke_callback_range(bool bringup,
> +					      unsigned int cpu,
> +					      struct cpuhp_cpu_state *st,
> +					      enum cpuhp_state target)
> +{
> +	return _cpuhp_invoke_callback_range(bringup, cpu, st, target, false);
> +}
> +
> +static inline void cpuhp_invoke_callback_range_nofail(bool bringup,
> +						      unsigned int cpu,
> +						      struct cpuhp_cpu_state *st,
> +						      enum cpuhp_state target)
> +{
> +	WARN_ON_ONCE(_cpuhp_invoke_callback_range(bringup, cpu, st, target, true));
>  }
>  
>  static inline bool can_rollback_cpu(struct cpuhp_cpu_state *st)
> @@ -999,7 +1029,6 @@ static int take_cpu_down(void *_param)
>  	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
>  	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
>  	int err, cpu = smp_processor_id();
> -	int ret;
>  
>  	/* Ensure this CPU doesn't handle any more interrupts. */
>  	err = __cpu_disable();
> @@ -1012,13 +1041,11 @@ static int take_cpu_down(void *_param)
>  	 */
>  	WARN_ON(st->state != (CPUHP_TEARDOWN_CPU - 1));
>  
> -	/* Invoke the former CPU_DYING callbacks */
> -	ret = cpuhp_invoke_callback_range(false, cpu, st, target);
> -
>  	/*
> +	 * Invoke the former CPU_DYING callbacks
>  	 * DYING must not fail!
>  	 */
> -	WARN_ON_ONCE(ret);
> +	cpuhp_invoke_callback_range_nofail(false, cpu, st, target);
>  
>  	/* Give up timekeeping duties */
>  	tick_handover_do_timer();
> @@ -1296,16 +1323,14 @@ void notify_cpu_starting(unsigned int cpu)
>  {
>  	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
>  	enum cpuhp_state target = min((int)st->target, CPUHP_AP_ONLINE);
> -	int ret;
>  
>  	rcu_cpu_starting(cpu);	/* Enables RCU usage on this CPU. */
>  	cpumask_set_cpu(cpu, &cpus_booted_once_mask);
> -	ret = cpuhp_invoke_callback_range(true, cpu, st, target);
>  
>  	/*
>  	 * STARTING must not fail!
>  	 */
> -	WARN_ON_ONCE(ret);
> +	cpuhp_invoke_callback_range_nofail(true, cpu, st, target);
>  }
>  
>  /*
> 
