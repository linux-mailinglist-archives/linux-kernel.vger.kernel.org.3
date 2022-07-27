Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DF15829A5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiG0P3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiG0P3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:29:51 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45A543E46;
        Wed, 27 Jul 2022 08:29:48 -0700 (PDT)
Date:   Wed, 27 Jul 2022 23:29:30 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658935786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XQrejTaMYuUHoomdqjHX2mOE0j2mTbj/6H4sN0Zrsqw=;
        b=BDLGgqLijSSSZxT6bO95BcJxqoGAdzhHhq076epoxblFTz57dpT680fRFihm/k6DRVmQn+
        k64E9CrW4YAR7xvhae+LO1EruFcoctTRLGaoFNn6DR9nI3mKl9/6Ae85IV1PlTc+CLZufn
        1EoRHMBJkOFzXiTNXGD/+imhcw+EHK8=
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
Subject: Re: [PATCH V7 04/16] rv/include: Add deterministic automata monitor
 definition via C macros
Message-ID: <YuFZ2scVb658mhoq@geo.homenetwork>
References: <cover.1658778484.git.bristot@kernel.org>
 <75d14829c5234c2ff43aff744ac41f246b970ed8.1658778484.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75d14829c5234c2ff43aff744ac41f246b970ed8.1658778484.git.bristot@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 10:11:16PM +0200, Daniel Bristot de Oliveira wrote:

> +/*
> + * Event handler for per_task monitors.
> + */
> +#define DECLARE_DA_MON_MODEL_HANDLER_PER_TASK(name, type)					\
> +												\
> +static inline type da_event_##name(struct da_monitor *da_mon, struct task_struct *tsk,		\

Not sure here the type `type` why not the bool. The return value is ture/false.
I checked the caller of this function, the return value is stored on `int`.

> +				   enum events_##name event)					\
> +{												\
> +	type curr_state = da_monitor_curr_state_##name(da_mon);					\
> +	type next_state = model_get_next_state_##name(curr_state, event);			\
> +												\
> +	if (next_state != INVALID_STATE) {							\
> +		da_monitor_set_state_##name(da_mon, next_state);				\
> +												\
> +		trace_event_##name(tsk->pid,							\
> +				   model_get_state_name_##name(curr_state),			\
> +				   model_get_event_name_##name(event),				\
> +				   model_get_state_name_##name(next_state),			\
> +				   model_is_final_state_##name(next_state));			\
> +												\
> +		return true;									\
> +	}											\
> +												\
> +	if (rv_reacting_on_##name())								\
> +		cond_react_##name(format_react_msg_##name(curr_state, event));			\
> +												\
> +	trace_error_##name(tsk->pid,								\
> +			   model_get_state_name_##name(curr_state),				\
> +			   model_get_event_name_##name(event));					\
> +												\
> +	return false;										\
> +}

[snip]

> +/*
> + * Handle event for implicit monitor: da_get_monitor_##name() will figure out
> + * the monitor.
> + */
> +#define DECLARE_DA_MON_MONITOR_HANDLER_IMPLICIT(name, type)					\
> +												\
> +static inline void __da_handle_event_##name(struct da_monitor *da_mon,				\
> +					    enum events_##name event)				\
> +{												\
> +	int retval;										\
> +												\
> +	retval = da_monitor_handling_event_##name(da_mon);					\
> +	if (!retval)										\
> +		return;										\

I checked the callers of __da_handle_event_##name():
da_handle_event_##name() for all cases need the above check.
da_handle_start_event_##name() for all cases may not need this check.
(this function checked the enable first and the da_monitoring later and if
it is not monitoring it will start monitoring and return, the later event
handler will not be called. Otherwise enable is enabled, da_monitoring is
monitoring)
da_handle_start_run_event_##name() for implicit case may not need this check.
(almost the same with the above, the difference is if da-monitor is not
monitoring, it will start monitoring and not return and do the event handler,
here enable is enabled and da_monitoring is monitoring, if I am not wrong)
So after another(v7) looking at this patch, I realized that this check can
be omited in two cases(all three cases). Just in fuction da_handle_event_##name()
we need to do da_monitor_handling_event_##name().
So I'd write like this:
static inline void __da_handle_event_##name(struct da_monitor *da_mon,				\
					    enum events_##name event)				\
{												\
	int retval;										\
                                                    \
    retval = da_event_##name(da_mon, event);						\
    if (!retval)										\
        da_monitor_reset_##name(da_mon);						\
}												\

static inline void da_handle_event_##name(enum events_##name event)				\
{												\
    struct da_monitor *da_mon = da_get_monitor_##name();					\
	int retval;										\
                                                    \
    retval = da_monitor_handling_event_##name(da_mon);					\
    if (!retval)										\
        return;										\
                                                    \
    __da_handle_event_##name(da_mon, event);						\

}												\

> +												\
> +	retval = da_event_##name(da_mon, event);						\
> +	if (!retval)										\
> +		da_monitor_reset_##name(da_mon);						\
> +}												\
> +												\
> +/*												\
> + * da_handle_event_##name - handle an event							\
> + */												\
> +static inline void da_handle_event_##name(enum events_##name event)				\
> +{												\
> +	struct da_monitor *da_mon = da_get_monitor_##name();					\
> +	__da_handle_event_##name(da_mon, event);						\
> +}												\
> +												\
> +/*												\
> + * da_handle_start_event_##name - start monitoring or handle event				\
> + *												\
> + * This function is used notify the monitor that the system is returning			\

/used/used to/ :-) My wording is not well, sorry for not convenience, Thanks,

> + * to the initial state, so the monitor can start monitoring in the next event.			\
> + * Thus:											\
> + *												\
> + * If the monitor already started, handle the event.						\
> + * If the monitor did not start yet, start the monitor but skip the event.			\
> + */												\
> +static inline bool da_handle_start_event_##name(enum events_##name event)			\
> +{												\
> +	struct da_monitor *da_mon;								\
> +												\
> +	if (!da_monitor_enabled_##name())							\
> +		return 0;									\
> +												\
> +	da_mon = da_get_monitor_##name();							\
> +												\
> +	if (unlikely(!da_monitoring_##name(da_mon))) {						\
> +		da_monitor_start_##name(da_mon);						\
> +		return 0;									\
> +	}											\
> +												\
> +	__da_handle_event_##name(da_mon, event);						\
> +												\
> +	return 1;										\
> +}												\
> +												\
> +/*												\
> + * da_handle_start_run_event_##name - start monitoring and handle event				\
> + *												\
> + * This function is used notify the monitor that the system is in the				\
> + * initial state, so the monitor can start monitoring and handling event.			\
> + */												\
> +static inline bool da_handle_start_run_event_##name(enum events_##name event)			\
> +{												\
> +	struct da_monitor *da_mon;								\
> +												\
> +	if (!da_monitor_enabled_##name())							\
> +		return 0;									\
> +												\
> +	da_mon = da_get_monitor_##name();							\
> +												\
> +	if (unlikely(!da_monitoring_##name(da_mon)))						\
> +		da_monitor_start_##name(da_mon);						\
> +												\
> +	__da_handle_event_##name(da_mon, event);						\
> +												\
> +	return 1;										\
> +}
> +
> +/*
> + * Handle event for per task.
> + */
> +#define DECLARE_DA_MON_MONITOR_HANDLER_PER_TASK(name, type)					\
> +												\
> +static inline void										\
> +__da_handle_event_##name(struct da_monitor *da_mon, struct task_struct *tsk,			\
> +			 enum events_##name event)						\
> +{												\
> +	int retval;										\
> +												\
> +	retval = da_monitor_handling_event_##name(da_mon);					\
> +	if (!retval)										\
> +		return;										\
> +												\
> +	retval = da_event_##name(da_mon, tsk, event);						\
> +	if (!retval)										\
> +		da_monitor_reset_##name(da_mon);						\
> +}												\
> +												\
> +/*												\
> + * da_handle_event_##name - handle an event							\
> + */												\
> +static inline void										\
> +da_handle_event_##name(struct task_struct *tsk, enum events_##name event)			\
> +{												\
> +	struct da_monitor *da_mon = da_get_monitor_##name(tsk);					\
> +	__da_handle_event_##name(da_mon, tsk, event);						\
> +}												\
> +												\
> +/*												\
> + * da_handle_start_event_##name - start monitoring or handle event				\
> + *												\
> + * This function is used notify the monitor that the system is returning			\
> + * to the initial state, so the monitor can start monitoring in the next event.			\
> + * Thus:											\
> + *												\
> + * If the monitor already started, handle the event.						\
> + * If the monitor did not start yet, start the monitor but skip the event.			\
> + */												\
> +static inline bool										\
> +da_handle_start_event_##name(struct task_struct *tsk, enum events_##name event)			\
> +{												\
> +	struct da_monitor *da_mon;								\
> +												\
> +	if (!da_monitor_enabled_##name())							\
> +		return 0;									\
> +												\
> +	da_mon = da_get_monitor_##name(tsk);							\
> +												\
> +	if (unlikely(!da_monitoring_##name(da_mon))) {						\
> +		da_monitor_start_##name(da_mon);						\
> +		return 0;									\
> +	}											\
> +												\
> +	__da_handle_event_##name(da_mon, tsk, event);						\
> +												\
> +	return 1;										\
> +}
