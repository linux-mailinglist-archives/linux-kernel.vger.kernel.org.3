Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B9E51CA8B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 22:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384858AbiEEU3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385817AbiEEU27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:28:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873FBDC2;
        Thu,  5 May 2022 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g9KS680sylr141Y7EFEPAHf/H7cuGajRNWijrXb2NGk=; b=ABt4kLuOw6w/JeQBMYDB1HqmPh
        7LsM4idgjz8oEiH/lY4uWKnQbA8np9cAnGRSKVNzlcsZkMbXq8JMvJn23/GczC3WY4ph+1yf4PiR9
        tl4PfCCQNTvpNKzM9gGyT7W5J8g39grZu8Q0P+yXo97p7YY7kD5bYctzi1BDZk8pu/YcsuLW3wVXi
        ZoOoplw8mH6uB2sSZGIudCJN9DfeCYKe6qSTFZnNAzgw1Z73dq69CM6uF1MQZgwuhCqDzX+t0c4rk
        RHk0ldr8EoeFvIq46Y550Rdbp/kG0p9RLHBlZBqO/cZqV4m49cVgPKOGRr4vRKi/MUcvV/FXDP2/7
        14S7i+8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmhz0-00BSux-7P; Thu, 05 May 2022 20:22:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68A7A980EF5; Thu,  5 May 2022 22:21:52 +0200 (CEST)
Date:   Thu, 5 May 2022 22:21:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, hdegoede@redhat.com,
        markgross@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v5 07/10] platform/x86/intel/ifs: Add scan test support
Message-ID: <20220505202152.GF2501@worktop.programming.kicks-ass.net>
References: <20220422200219.2843823-1-tony.luck@intel.com>
 <20220428153849.295779-1-tony.luck@intel.com>
 <20220428153849.295779-8-tony.luck@intel.com>
 <87r159jxaq.ffs@tglx>
 <YnLLekoripdY2oQU@agluck-desk3.sc.intel.com>
 <87tua4j3es.ffs@tglx>
 <20220505082824.GD2501@worktop.programming.kicks-ass.net>
 <87bkwcic9k.ffs@tglx>
 <YnQYJIVC0scuL7D7@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnQYJIVC0scuL7D7@agluck-desk3.sc.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 11:32:04AM -0700, Luck, Tony wrote:

> Patch now looks like this. Author credit to Peter ... are you willing
> to add a Signed-off-by to stop checkpatch from whining at me?

sure, see below.

> There isn't a "Something-similar-suggested-by:" tag to credit Thomas
> with this.  Perhaps "Inspired-by:"?

I'm all for creative one off tags, there's some marvelous ones in the
tree, but we always need more :-)

> -Tony
> 
> 
> From df5ca8024997d3d782978d154cfbff5147f451ad Mon Sep 17 00:00:00 2001
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu, 5 May 2022 08:55:09 -0700
> Subject: [PATCH] stop_machine: Add stop_core_cpuslocked() for per-core
>  operations
> 
> Hardware core level testing features require near simultaneous execution
> of WRMSR instructions on all threads of a core to initiate a test.
> 
> Provide a customized cut down version of stop_machine_cpuslocked() that
> just operates on the threads of a single core.
> 
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  include/linux/stop_machine.h | 16 ++++++++++++++++
>  kernel/stop_machine.c        | 19 +++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
> index 46fb3ebdd16e..ea7a74ea7389 100644
> --- a/include/linux/stop_machine.h
> +++ b/include/linux/stop_machine.h
> @@ -124,6 +124,22 @@ int stop_machine(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus);
>   */
>  int stop_machine_cpuslocked(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus);
>  
> +/**
> + * stop_core_cpuslocked: - stop all threads on just one core
> + * @cpu: any cpu in the targeted core
> + * @fn: the function to run
> + * @data: the data ptr for @fn()
> + *
> + * Same as above, but instead of every CPU, only the logical CPUs of a
> + * single core are affected.
> + *
> + * Context: Must be called from within a cpus_read_lock() protected region.
> + *
> + * Return: 0 if all executions of @fn returned 0, any non zero return
> + * value if any returned non zero.
> + */
> +int stop_core_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data);
> +
>  int stop_machine_from_inactive_cpu(cpu_stop_fn_t fn, void *data,
>  				   const struct cpumask *cpus);
>  #else	/* CONFIG_SMP || CONFIG_HOTPLUG_CPU */
> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index cbc30271ea4d..579761729836 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -633,6 +633,25 @@ int stop_machine(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus)
>  }
>  EXPORT_SYMBOL_GPL(stop_machine);
>  
> +int stop_core_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data)
> +{
> +	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
> +
> +	struct multi_stop_data msdata = {
> +		.fn = fn,
> +		.data = data,
> +		.num_threads = cpumask_weight(smt_mask),
> +		.active_cpus = smt_mask,
> +	};
> +
> +	lockdep_assert_cpus_held();
> +
> +	/* Set the initial state and stop all online cpus. */
> +	set_state(&msdata, MULTI_STOP_PREPARE);
> +	return stop_cpus(smt_mask, multi_cpu_stop, &msdata);
> +}
> +EXPORT_SYMBOL_GPL(stop_core_cpuslocked);
> +
>  /**
>   * stop_machine_from_inactive_cpu - stop_machine() from inactive CPU
>   * @fn: the function to run
> -- 
> 2.35.1
> 
