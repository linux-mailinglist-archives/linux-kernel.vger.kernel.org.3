Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F76F5093B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356513AbiDTXro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiDTXrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:47:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535A3E9C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:44:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0DCF61B45
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E660C385A0;
        Wed, 20 Apr 2022 23:44:53 +0000 (UTC)
Date:   Wed, 20 Apr 2022 19:44:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com
Subject: Re: [PATCH] arch_topology: Trace the update thermal pressure
Message-ID: <20220420194451.6b9661a0@gandalf.local.home>
In-Reply-To: <20220419164801.29078-1-lukasz.luba@arm.com>
References: <20220419164801.29078-1-lukasz.luba@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 17:48:01 +0100
Lukasz Luba <lukasz.luba@arm.com> wrote:

> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 1d6636ebaac5..4f0392de3081 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -19,6 +19,8 @@
>  #include <linux/rcupdate.h>
>  #include <linux/sched.h>
>  
> +#include <trace/events/thermal.h>
> +
>  static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
>  static struct cpumask scale_freq_counters_mask;
>  static bool scale_freq_invariant;
> @@ -195,6 +197,8 @@ void topology_update_thermal_pressure(const struct cpumask *cpus,
>  
>  	th_pressure = max_capacity - capacity;
>  
> +	trace_thermal_pressure_update(cpu, th_pressure);
> +
>  	for_each_cpu(cpu, cpus)
>  		WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
>  }
> diff --git a/include/trace/events/thermal.h b/include/trace/events/thermal.h
> index 8a5f04888abd..1bf08ee1a25b 100644
> --- a/include/trace/events/thermal.h
> +++ b/include/trace/events/thermal.h
> @@ -65,6 +65,25 @@ TRACE_EVENT(cdev_update,
>  	TP_printk("type=%s target=%lu", __get_str(type), __entry->target)
>  );
>  
> +TRACE_EVENT(thermal_pressure_update,
> +
> +	TP_PROTO(int cpu, unsigned long thermal_pressure),
> +
> +	TP_ARGS(cpu, thermal_pressure),
> +
> +	TP_STRUCT__entry(
> +		__field(int, cpu)
> +		__field(unsigned long, thermal_pressure)

Note, it is always best to place the bigger object before the smaller one
(when not properly aligned), as that will help to prevent structure
"holes". That is:

		__field(unsigned long, thermal_pressure)
		__field(int, cpu)


Otherwise, you are pretty much guaranteed to have a 4 byte hole between cpu
and thermal_pressure on 64 bit machines.

Also, for the warning you got from the test robot, if you are using this in
a module and defining it in the core kernel, you need to add:

EXPORT_TRACEPOINT_SYMBOL_GPL(thermal_pressure_update);

Somewhere in the C file that includes this file and defines
CREATE_TRACE_POINTS.

-- Steve



> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu = cpu;
> +		__entry->thermal_pressure = thermal_pressure;
> +	),
> +
> +	TP_printk("cpu=%d thermal_pressure=%lu", __entry->cpu, __entry->thermal_pressure)
> +);
> +
>  TRACE_EVENT(thermal_zone_trip,
>  
>  	TP_PROTO(struct thermal_zone_device *tz, int trip,

