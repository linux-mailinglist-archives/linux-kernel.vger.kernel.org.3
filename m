Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3496C4C7A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 21:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiB1UZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 15:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiB1UZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 15:25:43 -0500
X-Greylist: delayed 1345 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Feb 2022 12:25:03 PST
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com [192.185.180.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16A256C15
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 12:25:03 -0800 (PST)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 0E9D9B239
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:02:38 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id OmC6nxGp022u3OmC7nw2sw; Mon, 28 Feb 2022 14:00:33 -0600
X-Authority-Reason: nr=8
Received: from host-95-232-30-176.retail.telecomitalia.it ([95.232.30.176]:40014 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nOmC5-004Kdt-G2; Mon, 28 Feb 2022 14:00:29 -0600
Message-ID: <137d3573-051f-5374-70d6-cc99b44d00da@kernel.org>
Date:   Mon, 28 Feb 2022 21:00:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
Content-Language: en-US
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>, rostedt@goodmis.org,
        paulmck@kernel.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, mtosatti@redhat.com
References: <20220228141423.259691-1-nsaenzju@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220228141423.259691-1-nsaenzju@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 95.232.30.176
X-Source-L: No
X-Exim-ID: 1nOmC5-004Kdt-G2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-95-232-30-176.retail.telecomitalia.it ([10.0.0.45]) [95.232.30.176]:40014
X-Source-Auth: kernel@bristot.me
X-Email-Count: 2
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/22 15:14, Nicolas Saenz Julienne wrote:
> At the moment running osnoise on an isolated CPU and a PREEMPT_RCU
> kernel might have the side effect of extending grace periods too much.
> This will eventually entice RCU to schedule a task on the isolated CPU
> to end the overly extended grace period, adding unwarranted noise to the
> CPU being traced in the process.
> 
> So, check if we're the only ones running on this isolated CPU and that
> we're on a PREEMPT_RCU setup. If so, let's force quiescent states in
> between measurements.
> 
> Non-PREEMPT_RCU setups don't need to worry about this as osnoise main
> loop's cond_resched() will go though a quiescent state for them.
> 
> Note that this same exact problem is what extended quiescent states were
> created for. But adapting them to this specific use-case isn't trivial
> as it'll imply reworking entry/exit and dynticks/context tracking code.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> ---
>  kernel/trace/trace_osnoise.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 870a08da5b48..4928358f6e88 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -21,7 +21,9 @@
>  #include <linux/uaccess.h>
>  #include <linux/cpumask.h>
>  #include <linux/delay.h>
> +#include <linux/tick.h>
>  #include <linux/sched/clock.h>
> +#include <linux/sched/isolation.h>
>  #include <uapi/linux/sched/types.h>
>  #include <linux/sched.h>
>  #include "trace.h"
> @@ -1295,6 +1297,7 @@ static int run_osnoise(void)
>  	struct osnoise_sample s;
>  	unsigned int threshold;
>  	u64 runtime, stop_in;
> +	unsigned long flags;
>  	u64 sum_noise = 0;
>  	int hw_count = 0;
>  	int ret = -1;
> @@ -1386,6 +1389,22 @@ static int run_osnoise(void)
>  					osnoise_stop_tracing();
>  		}
>  
> +		/*
> +		 * Check if we're the only ones running on this nohz_full CPU
> +		 * and that we're on a PREEMPT_RCU setup. If so, let's fake a
> +		 * QS since there is no way for RCU to know we're not making
> +		 * use of it.
> +		 *
> +		 * Otherwise it'll be done through cond_resched().
> +		 */
> +		if (IS_ENABLED(CONFIG_PREEMPT_RCU) &&
> +		    !housekeeping_cpu(raw_smp_processor_id(), HK_FLAG_MISC) &&

Does this restrict to only isolcpus cpus? what if this CPU was isolated via
other methods?

> +		    tick_nohz_tick_stopped()) {
> +			local_irq_save(flags);

This code is always with interrupts enabled, so local_irq_disable()/enable()
should be enough (and faster).

> +			rcu_momentary_dyntick_idle();
> +			local_irq_restore(flags);
> +		}

Question, if we set this once, we could avoid setting it on every loop unless we
have a preemption from another thread, right?

>  		/*
>  		 * For the non-preemptive kernel config: let threads runs, if
>  		 * they so wish.

/me keeps playing with this patch.

-- Daniel
