Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2995776FC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 17:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiGQPTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 11:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiGQPTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 11:19:07 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D8B10EC;
        Sun, 17 Jul 2022 08:19:05 -0700 (PDT)
Date:   Sun, 17 Jul 2022 23:18:56 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658071143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OrwXwKD43N3afALmDJfVtospo3o+KUj8Q8T3PqpTIdI=;
        b=PwWdGAZUAqlNQNmt9bh4yBuDdI4n67Jwd2p3OMBcU7F61MKKx4JDBZYaq7e/YQsaJM5LCz
        TskmIE+myQY/B68XaYdaI51sJy6jo/bBNollNBt/gdn0FukJWuuX4+IH+nC6kNkpW9yCdH
        fecyxTcn0Bj14pz7i6inE3ryULknNwc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH V5 04/16] rv/include: Add deterministic automata monitor
 definition via C macros
Message-ID: <YtQoYMLHgvTV0lea@geo.homenetwork>
References: <cover.1657745645.git.bristot@kernel.org>
 <5e0447aa9d114c52fd2bc335de036c61d9625f1c.1657745645.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e0447aa9d114c52fd2bc335de036c61d9625f1c.1657745645.git.bristot@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 11:17:20PM +0200, Daniel Bristot de Oliveira wrote:
> In Linux terms, the runtime verification monitors are encapsulated
> inside the "RV monitor" abstraction. The "RV monitor" includes a set
> of instances of the monitor (per-cpu monitor, per-task monitor, and
> so on), the helper functions that glue the monitor to the system
> reference model, and the trace output as a reaction for event parsing
> and exceptions, as depicted below:
> 
> Linux  +----- RV Monitor ----------------------------------+ Formal
>  Realm |                                                   |  Realm
>  +-------------------+     +----------------+     +-----------------+
>  |   Linux kernel    |     |     Monitor    |     |     Reference   |
>  |     Tracing       |  -> |   Instance(s)  | <-  |       Model     |
>  | (instrumentation) |     | (verification) |     | (specification) |
>  +-------------------+     +----------------+     +-----------------+
>         |                          |                       |
>         |                          V                       |
>         |                     +----------+                 |
>         |                     | Reaction |                 |
>         |                     +--+--+--+-+                 |
>         |                        |  |  |                   |
>         |                        |  |  +-> trace output ?  |
>         +------------------------|--|----------------------+
>                                  |  +----> panic ?
>                                  +-------> <user-specified>
> 
> Add the rv/da_monitor.h, enabling automatic code generation for the
> *Monitor Instance(s)* using C macros, and code to support it.
> 
> The benefits of the usage of macro for monitor synthesis are 3-fold as it:
> 
> - Reduces the code duplication;
> - Facilitates the bug fix/improvement;
> - Avoids the case of developers changing the core of the monitor code
>   to manipulate the model in a (let's say) non-standard way.
> 
> This initial implementation presents three different types of monitor
> instances:
> 
> - DECLARE_DA_MON_GLOBAL(name, type)
> - DECLARE_DA_MON_PER_CPU(name, type)
> - DECLARE_DA_MON_PER_TASK(name, type)
> 
> The first declares the functions for a global deterministic automata monitor,
> the second for monitors with per-cpu instances, and the third with per-task
> instances.
> 
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Gabriele Paoloni <gpaoloni@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: Tao Zhou <tao.zhou@linux.dev>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-trace-devel@vger.kernel.org
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  include/linux/rv.h        |   2 +
>  include/rv/da_monitor.h   | 521 ++++++++++++++++++++++++++++++++++++++
>  include/rv/rv.h           |   9 +
>  include/trace/events/rv.h | 120 +++++++++
>  kernel/fork.c             |  14 +
>  kernel/trace/rv/Kconfig   |  14 +
>  kernel/trace/rv/rv.c      |   5 +
>  7 files changed, 685 insertions(+)
>  create mode 100644 include/rv/da_monitor.h
>  create mode 100644 include/trace/events/rv.h
> 
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 88d28d207f3a..bdefdff12a1f 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -7,6 +7,8 @@
>  #ifndef _LINUX_RV_H
>  #define _LINUX_RV_H
>  
> +#define MAX_DA_NAME_LEN         24
> +
>  struct rv_reactor {
>  	char			*name;
>  	char			*description;
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> new file mode 100644
> index 000000000000..d21045e6c5fc
> --- /dev/null
> +++ b/include/rv/da_monitor.h
> @@ -0,0 +1,521 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
> + *
> + * Deterministic automata (DA) monitor functions, to be used together
> + * with automata models in C generated by the dot2k tool.
> + *
> + * The dot2k tool is available at tools/verification/dot2k/
> + */
> +
> +#include <rv/automata.h>
> +#include <linux/rv.h>
> +
> +/*
> + * Generic helpers for all types of deterministic automata monitors.
> + */
> +#define DECLARE_DA_MON_GENERIC_HELPERS(name, type)				\
> +static char REACT_MSG[1024];							\
> +										\
> +static inline char *format_react_msg(type curr_state, type event)		\
> +{										\
> +	snprintf(REACT_MSG, 1024,						\
> +		 "rv: monitor %s does not allow event %s on state %s\n",	\
> +		 #name,								\
> +		 model_get_event_name_##name(event),				\
> +		 model_get_state_name_##name(curr_state));			\
> +	return REACT_MSG;							\
> +}										\
> +										\
> +static void cond_react(char *msg)						\
> +{										\
> +	if (rv_##name.react)							\
> +		rv_##name.react(msg);						\
> +}										\
> +										\
> +/*										\
> + * da_monitor_reset_##name - reset a monitor and setting it to init state	\
> + */										\
> +static inline void da_monitor_reset_##name(struct da_monitor *da_mon)		\
> +{										\
> +	da_mon->monitoring = 0;							\
> +	da_mon->curr_state = model_get_init_state_##name();			\
> +}										\
> +										\
> +/*										\
> + * da_monitor_curr_state_##name - return the current state			\
> + */										\
> +static inline type da_monitor_curr_state_##name(struct da_monitor *da_mon)	\
> +{										\
> +	return da_mon->curr_state;						\
> +}										\
> +										\
> +/*										\
> + * da_monitor_set_state_##name - set the new current state			\
> + */										\
> +static inline void								\
> +da_monitor_set_state_##name(struct da_monitor *da_mon, enum states_##name state)\
> +{										\
> +	da_mon->curr_state = state;						\
> +}										\
> +										\
> +/*										\
> + * da_monitor_start_##name - start monitoring					\
> + *										\
> + * The monitor will ignore all events until monitoring is set to true. This	\
> + * function needs to be called to tell the monitor to start monitoring.		\
> + */										\
> +static inline void da_monitor_start_##name(struct da_monitor *da_mon)		\
> +{										\
> +	da_mon->monitoring = 1;							\
> +}										\
> +										\
> +/*										\
> + * da_monitoring_##name - returns true if the monitor is processing events	\
> + */										\
> +static inline bool da_monitoring_##name(struct da_monitor *da_mon)		\
> +{										\
> +	return da_mon->monitoring;						\
> +}
> +
> +
> +/*
> + * Event handler for implicit monitors. Implicit monitor is the one which the
> + * handler does not need to specify which da_monitor to manipulate. Examples
> + * of implicit monitor are the per_cpu or the global ones.
> + */
> +#define DECLARE_DA_MON_MODEL_HANDLER_IMPLICIT(name, type)			\
> +static inline bool								\
> +da_event_##name(struct da_monitor *da_mon, enum events_##name event)		\
> +{										\
> +	type curr_state = da_monitor_curr_state_##name(da_mon);			\
> +	type next_state = model_get_next_state_##name(curr_state, event);	\
> +										\
> +	if (next_state != INVALID_STATE) {					\
> +		da_monitor_set_state_##name(da_mon, next_state);		\
> +										\
> +		trace_event_##name(model_get_state_name_##name(curr_state),	\
> +				model_get_event_name_##name(event),		\
> +				model_get_state_name_##name(next_state),	\
> +				model_is_final_state_##name(next_state));	\
> +										\
> +		return true;							\
> +	}									\
> +										\
> +	if (reacting_on)							\
> +		cond_react(format_react_msg(curr_state, event));		\
> +										\
> +	trace_error_##name(model_get_state_name_##name(curr_state),		\
> +			   model_get_event_name_##name(event));			\
> +										\
> +	return false;								\
> +}										\
> +
> +/*
> + * Event handler for per_task monitors.
> + */
> +#define DECLARE_DA_MON_MODEL_HANDLER_PER_TASK(name, type)			\
> +static inline type								\
> +da_event_##name(struct da_monitor *da_mon, struct task_struct *tsk,		\
> +		enum events_##name event)					\
> +{										\
> +	type curr_state = da_monitor_curr_state_##name(da_mon);			\
> +	type next_state = model_get_next_state_##name(curr_state, event);	\
> +										\
> +	if (next_state != INVALID_STATE) {					\
> +		da_monitor_set_state_##name(da_mon, next_state);		\
> +										\
> +		trace_event_##name(tsk->pid,					\
> +				   model_get_state_name_##name(curr_state),	\
> +				   model_get_event_name_##name(event),		\
> +				   model_get_state_name_##name(next_state),	\
> +				   model_is_final_state_##name(next_state));	\
> +										\
> +		return true;							\
> +	}									\
> +										\
> +	if (reacting_on)							\
> +		cond_react(format_react_msg(curr_state, event));		\
> +										\
> +	trace_error_##name(tsk->pid,						\
> +			   model_get_state_name_##name(curr_state),		\
> +			   model_get_event_name_##name(event));			\
> +										\
> +	return false;								\
> +}
> +
> +/*
> + * Functions to define, init and get a global monitor.
> + */
> +#define DECLARE_DA_MON_INIT_GLOBAL(name, type)					\
> +										\
> +/*										\
> + * global monitor (a single variable)						\
> + */										\
> +static struct da_monitor da_mon_##name;						\
> +										\
> +/*										\
> + * da_get_monitor_##name - return the global monitor address			\
> + */										\
> +static struct da_monitor *da_get_monitor_##name(void)				\
> +{										\
> +	return &da_mon_##name;							\
> +}										\
> +										\
> +/*										\
> + * da_monitor_reset_all_##name - reset the single monitor			\
> + */										\
> +static void da_monitor_reset_all_##name(void)					\
> +{										\
> +	da_monitor_reset_##name(&da_mon_##name);				\
> +}										\
> +										\
> +/*										\
> + * da_monitor_init_##name - initialize a monitor				\
> + */										\
> +static inline int da_monitor_init_##name(void)					\
> +{										\
> +	struct da_monitor *da_mon = &da_mon_##name;				\
> +	da_mon->curr_state = model_get_init_state_##name();			\
> +	da_mon->monitoring = 0;							\
> +	return 0;								\
> +}										\
> +										\
> +/*										\
> + * da_monitor_destroy_##name - destroy the monitor				\
> + */										\
> +static inline void da_monitor_destroy_##name(void)				\
> +{										\
> +	return;									\
> +}
> +
> +/*
> + * Functions to define, init and get a per-cpu monitor.
> + */
> +#define DECLARE_DA_MON_INIT_PER_CPU(name, type)					\
> +										\
> +/*										\
> + * per-cpu monitor variables							\
> + */										\
> +DEFINE_PER_CPU(struct da_monitor, da_mon_##name);				\
> +										\
> +/*										\
> + * da_get_monitor_##name - return current CPU monitor address			\
> + */										\
> +static struct da_monitor *da_get_monitor_##name(void)				\
> +{										\
> +	return this_cpu_ptr(&da_mon_##name);					\
> +}										\
> +										\
> +/*										\
> + * da_monitor_reset_all_##name - reset all CPUs' monitor			\
> + */										\
> +static void da_monitor_reset_all_##name(void)					\
> +{										\
> +	struct da_monitor *da_mon;						\
> +	int cpu;								\
> +	for_each_cpu(cpu, cpu_online_mask) {					\
> +		da_mon = per_cpu_ptr(&da_mon_##name, cpu);			\
> +		da_monitor_reset_##name(da_mon);				\
> +	}									\
> +}										\
> +										\
> +/*										\
> + * da_monitor_init_##name - initialize all CPUs' monitor			\
> + */										\
> +static inline int da_monitor_init_##name(void)					\
> +{										\
> +	struct da_monitor *da_mon;						\
> +	int cpu;								\
> +	for_each_cpu(cpu, cpu_online_mask) {					\
> +		da_mon = per_cpu_ptr(&da_mon_##name, cpu);			\
> +		da_mon->curr_state = model_get_init_state_##name();		\
> +		da_mon->monitoring = 0;						\
> +	}									\
> +	return 0;								\
> +}										\
> +										\
> +/*										\
> + * da_monitor_destroy_##name - destroy the monitor				\
> + */										\
> +static inline void da_monitor_destroy_##name(void)				\
> +{										\
> +	return;									\
> +}
> +
> +/*
> + * Functions to define, init and get a per-task monitor.
> + */
> +#define DECLARE_DA_MON_INIT_PER_TASK(name, type)				\
> +										\
> +/*										\
> + * The per-task monitor is stored a vector in the task struct. This variable	\
> + * stores the position on the vector reserved for this monitor.			\
> + */										\
> +static int task_mon_slot_##name = RV_PER_TASK_MONITOR_INIT;			\

In patch1, RV_PER_TASK_MONITOR_INIT is defined as:

#define RV_PER_TASK_MONITORS           1
#define RV_PER_TASK_MONITOR_INIT	  (RV_PER_TASK_MONITORS)

RV_PER_TASK_MONITOR_INIT is 1 now, seems not the index of the first only
element in vector. Now no map here, one task has one monitor though if I
am not wrong.
So task_mon_slot_##name must be defined to the index of first element.
Modify the macro definition of RV_PER_TASK_MONITOR_INIT to the index of
first element in vector.

#define RV_PER_TASK_MONITOR_INIT	  (RV_PER_TASK_MONITORS) - 1

If there are more monitors per task in the furture, like you say, dynamic
allocation and mapping should be used. But I don't know.
