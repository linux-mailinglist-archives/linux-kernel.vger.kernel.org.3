Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5D2463A39
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbhK3PkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238118AbhK3PkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:40:05 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3787C061574;
        Tue, 30 Nov 2021 07:36:45 -0800 (PST)
Date:   Tue, 30 Nov 2021 23:35:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638286603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w1Ij5M2h6zsOyJ/iJYNaHxRAyIC26zD6JY58l7LwMAk=;
        b=ZyMGzVFj+dIqrS3WgilKcp5CHj934oeHcD+xx7kPqyFKoioB22sKAn/QmyzMm4ElPT4pbt
        Mgm94S/0DTq9axWKrGfjY2wGGyGzBwd2y9aWNAvSdWaUFPyd+EWcgRxH2EZvdcsl7dUsPx
        kCVrJ7boIPO1BfqoYELrNn8crCMh3fs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tao Zhou <tao.zhou@linux.dev>, linux-rt-users@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 03/14] rtla: Add osnoise tool
Message-ID: <YaZEzvzp5jkRyLEJ@geo.homenetwork>
References: <cover.1638182284.git.bristot@kernel.org>
 <ffb7f1b1e8cc42fc8ec52f1a89fdd2ca0d70c36e.1638182284.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffb7f1b1e8cc42fc8ec52f1a89fdd2ca0d70c36e.1638182284.git.bristot@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, Nov 29, 2021 at 12:07:41PM +0100, Daniel Bristot de Oliveira wrote:
> +/*
> + * osnoise_restore_cpus - restore the original "osnoise/cpus"
> + *
> + * osnoise_set_cpus() saves the original data for the "osnoise/cpus"

osnoise_set_cpus() --> osnoise_restore_cpus()

> + * file. This function restore the original config it was previously
> + * modified.
> + */
> +void osnoise_restore_cpus(struct osnoise_context *context)
> +{
> +	int retval;
> +
> +	if (!context->orig_cpus)
> +		return;
> +
> +	if (!context->curr_cpus)
> +		return;
> +
> +	/* nothing to do? */
> +	if (!strcmp(context->orig_cpus, context->curr_cpus))
> +		goto out_done;
> +
> +	retval = write(context->cpus_fd, context->orig_cpus, strlen(context->orig_cpus));

'strlen(context->orig_cpus) + 1' for write size;

> +	if (retval < strlen(context->orig_cpus))

Same here. Check 'strlen(context->orig_cpus) + 1'

> +		err_msg("could not restore original osnoise cpus\n");
> +
> +out_done:
> +	free(context->curr_cpus);
> +	context->curr_cpus = NULL;
> +}
> +
> +/*
> + * osnoise_get_runtime - return the original "osnoise/runtime_us" value
> + *
> + * It also saves the value to be restored.
> + */
> +unsigned long long osnoise_get_runtime(struct osnoise_context *context)
> +{
> +	char buffer[BUFF_U64_STR_SIZE];
> +	long long runtime_us;
> +	char *runtime_path;
> +	int retval;
> +
> +	if (context->runtime_us != OSNOISE_TIME_INIT_VAL)
> +		return context->runtime_us;
> +
> +	if (context->orig_runtime_us != OSNOISE_TIME_INIT_VAL)
> +		return context->orig_runtime_us;
> +
> +	runtime_path = tracefs_get_tracing_file("osnoise/runtime_us");
> +
> +	context->runtime_fd = open(runtime_path, O_RDWR);
> +	if (context->runtime_fd < 0)
> +		goto out_err;
> +
> +	retval = read(context->runtime_fd, &buffer, sizeof(buffer));
> +	if (retval <= 0)
> +		goto out_close;
> +
> +	runtime_us = get_llong_from_str(buffer);
> +	if (runtime_us < 0)
> +		goto out_close;
> +
> +	tracefs_put_tracing_file(runtime_path);
> +
> +	context->orig_runtime_us = runtime_us;
> +	return runtime_us;
> +
> +out_close:
> +	close(context->runtime_fd);
> +	context->runtime_fd = CLOSED_FD;
> +out_err:
> +	tracefs_put_tracing_file(runtime_path);
> +	return 0;
> +}
> +/*
> + * osnoise_get_period - return the original "osnoise/period_us" value
> + *
> + * It also saves the value to be restored.
> + */
> +unsigned long long osnoise_get_period(struct osnoise_context *context)
> +{
> +	char buffer[BUFF_U64_STR_SIZE];
> +	char *period_path;
> +	long long period_us;
> +	int retval;
> +
> +	if (context->period_us != OSNOISE_TIME_INIT_VAL)
> +		return context->period_us;
> +
> +	if (context->orig_period_us != OSNOISE_TIME_INIT_VAL)
> +		return context->orig_period_us;
> +
> +	period_path = tracefs_get_tracing_file("osnoise/period_us");
> +
> +	context->period_fd = open(period_path, O_RDWR);
> +	if (context->period_fd < 0)
> +		goto out_err;
> +
> +	retval = read(context->period_fd, &buffer, sizeof(buffer));
> +	if (retval <= 0)
> +		goto out_close;
> +
> +	period_us = get_llong_from_str(buffer);
> +	if (period_us < 0)
> +		goto out_close;
> +
> +	tracefs_put_tracing_file(period_path);
> +
> +	context->orig_period_us = period_us;
> +	return period_us;
> +
> +out_close:
> +	close(context->period_fd);
> +	context->period_fd = CLOSED_FD;
> +out_err:
> +	tracefs_put_tracing_file(period_path);
> +	return 0;
> +}

osnoise_get_period() and osnoise_get_runtime() almost the same.
Use macro to generate code. Some thing also not sure now. Shame


#define osnoise_get_period osnoise_get(period)
#define osnoise_get_runtime osnoise_get(runtime)

#define osnoise_get(x)	\
unsigned long long osnoise_get_##x(struct osnoise_context *context) \ 
{              \
	char buffer[BUFF_U64_STR_SIZE];             \
	char * x##_path;             \ 
	long long x##_us;            \
	if (context->x##_us != OSNOISE_TIME_INIT_VAL)                   \
		return context->x##_us;           \
	if (context->orig_##x##_us != OSNOISE_TIME_INIT_VAL)            \
		return context->orig_##x##_us;          \
	x##_path = tracefs_get_tracing_file("osnoise/x##_us");        \
	context->x##_fd = open(x##_path, O_RDWR);               \
	if (context->x##_fd < 0)                        \
		goto out_err;                 \
	retval = read(context->x##_fd, &buffer, sizeof(buffer));        \
	if (retval <= 0)                  \
		goto out_close;               \
	x##_us = get_llong_from_str(buffer);            \
	if (x##_us < 0)                   \
		goto out_close;               \
	tracefs_put_tracing_file(x##_path);             \
	context->orig_##x##_us = x##_us;                \
	return x##_us;                    \
out_close:                            \
	close(context->x##_fd);           \
	context->x##_fd = CLOSED_FD;                    \
out_err:                              \
	tracefs_put_tracing_file(x##_path);             \
	return 0;                         \
}


> +
> +static int __osnoise_write_runtime(struct osnoise_context *context,
> +				   unsigned long long runtime)
> +{
> +	char buffer[BUFF_U64_STR_SIZE];
> +	int retval;
> +
> +	if (context->orig_runtime_us == OSNOISE_TIME_INIT_VAL)
> +		return -1;
> +
> +	snprintf(buffer, sizeof(buffer), "%llu\n", runtime);
> +
> +	retval = write(context->runtime_fd, buffer, strlen(buffer) + 1);
> +	if (retval < (strlen(buffer) + 1))
> +		return -1;
> +
> +	context->runtime_us = runtime;
> +	return 0;
> +}
> +
> +static int __osnoise_write_period(struct osnoise_context *context,
> +				  unsigned long long period)
> +{
> +	char buffer[BUFF_U64_STR_SIZE];
> +	int retval;
> +
> +	if (context->orig_period_us == OSNOISE_TIME_INIT_VAL)
> +		return -1;
> +
> +	snprintf(buffer, sizeof(buffer), "%llu\n", period);
> +
> +	retval = write(context->period_fd, buffer, strlen(buffer) + 1);
> +	if (retval < (strlen(buffer) + 1))
> +		return -1;
> +
> +	context->period_us = period;
> +	return 0;
> +}

__osnoise_write_period() and __osnoise_write_runtime() share
almost the same code. Macro also use in here. Not sure it is
right. Shame.

#define __osnoise_write(x) \
static int __osnoise_write_##x(struct osnoise_context *context,    \
				  unsigned long long period)    \
{     \
	char buffer[BUFF_U64_STR_SIZE];     \
	int retval;     \
	if (context->orig_##x##_us == OSNOISE_TIME_INIT_VAL)   \
		return -1;    \
	snprintf(buffer, sizeof(buffer), "%llu\n", period);    \
	retval = write(context->x##_fd, buffer, strlen(buffer) + 1);   \
	if (retval < (strlen(buffer) + 1))    \
		return -1;    \
	context->x##_us = period;    \
	return 0;    \
}

#define __osnoise_write_period __osnoise_write(period)
#define __osnoise_write_runtime __osnoise_write(runtime)

> +
> +/*
> + * osnoise_set_runtime_period - set osnoise runtime and period
> + *
> + * Osnoise's runtime and period are related as runtime <= period.
> + * Thus, this function saves the original values, and then tries
> + * to set the runtime and period if they are != 0.
> + */
> +int osnoise_set_runtime_period(struct osnoise_context *context,
> +			       unsigned long long runtime,
> +			       unsigned long long period)
> +{
> +	unsigned long long curr_runtime_us;
> +	unsigned long long curr_period_us;
> +	int retval;
> +
> +	if (!period && !runtime)
> +		return 0;
> +
> +	curr_runtime_us = osnoise_get_runtime(context);
> +	curr_period_us = osnoise_get_period(context);
> +
> +	/* error getting any value? */
> +	if (curr_period_us == -1 || curr_runtime_us == -1)
> +		return -1;

'curr_period_us' and 'curr_runtime_us' error value should be
0(OSNOISE_TIME_INIT_VAL).

> +
> +	if (!period) {
> +		if (runtime > curr_period_us)
> +			return -1;
> +		return __osnoise_write_runtime(context, runtime);
> +	} else if (!runtime) {
> +		if (period < curr_runtime_us)
> +			return -1;
> +		return __osnoise_write_period(context, period);
> +	}
> +
> +	if (runtime > curr_period_us) {
> +		retval = __osnoise_write_period(context, period);
> +		if (retval)
> +			return -1;
> +		retval = __osnoise_write_runtime(context, runtime);
> +		if (retval)
> +			return -1;
> +	} else {
> +		retval = __osnoise_write_runtime(context, runtime);
> +		if (retval)
> +			return -1;
> +		retval = __osnoise_write_period(context, period);
> +		if (retval)
> +			return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * osnoise_get_timerlat_period_us - read and save the original "timerlat_period_us"
> + */
> +static long long
> +osnoise_get_timerlat_period_us(struct osnoise_context *context)
> +{
> +	char buffer[BUFF_U64_STR_SIZE];
> +	long long timerlat_period_us;
> +	char *stop_path;
> +	int retval;
> +
> +	if (context->timerlat_period_us != OSNOISE_TIME_INIT_VAL)
> +		return context->timerlat_period_us;
> +
> +	if (context->orig_timerlat_period_us != OSNOISE_TIME_INIT_VAL)
> +		return context->orig_timerlat_period_us;
> +
> +	stop_path = tracefs_get_tracing_file("osnoise/timerlat_period_us");

Using timerlat_period_path seems to be straightforward.

> +
> +	context->timerlat_period_us_fd = open(stop_path, O_RDWR);
> +	if (context->timerlat_period_us_fd < 0)
> +		goto out_err;
> +
> +	retval = read(context->timerlat_period_us_fd, &buffer, sizeof(buffer));
> +	if (retval <= 0)
> +		goto out_close;
> +
> +	timerlat_period_us = get_llong_from_str(buffer);
> +	if (timerlat_period_us < 0)
> +		goto out_close;
> +
> +	tracefs_put_tracing_file(stop_path);
> +
> +	context->orig_timerlat_period_us = timerlat_period_us;
> +	return timerlat_period_us;
> +
> +out_close:
> +	close(context->timerlat_period_us_fd);
> +	context->timerlat_period_us_fd = CLOSED_FD;
> +out_err:
> +	tracefs_put_tracing_file(stop_path);
> +	return -1;

Should return 0 or OSNOISE_TIME_INIT_VAL and the return type
can be unsigned long long.

> +}
> +
> +/*
> + * osnoise_get_stop_us - read and save the original "stop_tracing_us"
> + */
> +static long long
> +osnoise_get_stop_us(struct osnoise_context *context)
> +{
> +	char buffer[BUFF_U64_STR_SIZE];
> +	long long stop_us;
> +	char *stop_path;
> +	int retval;
> +
> +	if (context->stop_us != OSNOISE_OPTION_INIT_VAL)
> +		return context->stop_us;
> +
> +	if (context->orig_stop_us != OSNOISE_OPTION_INIT_VAL)
> +		return context->orig_stop_us;
> +
> +	stop_path = tracefs_get_tracing_file("osnoise/stop_tracing_us");
> +
> +	context->stop_us_fd = open(stop_path, O_RDWR);
> +	if (context->stop_us_fd < 0)
> +		goto out_err;
> +
> +	retval = read(context->stop_us_fd, &buffer, sizeof(buffer));
> +	if (retval <= 0)
> +		goto out_close;
> +
> +	stop_us = get_llong_from_str(buffer);
> +	if (stop_us < 0)
> +		goto out_close;
> +
> +	tracefs_put_tracing_file(stop_path);
> +
> +	context->orig_stop_us = stop_us;
> +	return stop_us;
> +
> +out_close:
> +	close(context->stop_us_fd);
> +	context->stop_us_fd = CLOSED_FD;
> +out_err:
> +	tracefs_put_tracing_file(stop_path);
> +	return -1;

The same.

> +}
> +
> +/*
> + * osnoise_get_stop_total_us - read and save the original "stop_tracing_total_us"
> + */
> +static long long
> +osnoise_get_stop_total_us(struct osnoise_context *context)
> +{
> +	char buffer[BUFF_U64_STR_SIZE];
> +	long long stop_total_us;
> +	char *stop_path;

Use stop_total_path to differentiate with stop_path used in
osnoise_get_stop_us().

> +	int retval;
> +
> +	if (context->stop_total_us != OSNOISE_OPTION_INIT_VAL)
> +		return context->stop_total_us;
> +
> +	if (context->orig_stop_total_us != OSNOISE_OPTION_INIT_VAL)
> +		return context->orig_stop_total_us;
> +
> +	stop_path = tracefs_get_tracing_file("osnoise/stop_tracing_total_us");
> +
> +	context->stop_total_us_fd = open(stop_path, O_RDWR);
> +	if (context->stop_total_us_fd < 0)
> +		goto out_err;
> +
> +	retval = read(context->stop_total_us_fd, &buffer, sizeof(buffer));
> +	if (retval <= 0)
> +		goto out_close;
> +
> +	stop_total_us = get_llong_from_str(buffer);
> +	if (stop_total_us < 0)
> +		goto out_close;
> +
> +	tracefs_put_tracing_file(stop_path);
> +
> +	context->orig_stop_total_us = stop_total_us;
> +	return stop_total_us;
> +
> +out_close:
> +	close(context->stop_total_us_fd);
> +	context->stop_total_us_fd = CLOSED_FD;
> +out_err:
> +	tracefs_put_tracing_file(stop_path);
> +	return -1;

The same.

> +}
> +
> +/*
> + * osnoise_get_print_stack - read and save the original "print_stack"
> + */
> +static long long
> +osnoise_get_print_stack(struct osnoise_context *context)
> +{
> +	char buffer[BUFF_U64_STR_SIZE];
> +	long long print_stack;
> +	char *stop_path;

This is print_stack_path.

> +	int retval;
> +
> +	if (context->print_stack != OSNOISE_OPTION_INIT_VAL)
> +		return context->print_stack;
> +
> +	if (context->orig_print_stack != OSNOISE_OPTION_INIT_VAL)
> +		return context->orig_print_stack;
> +
> +	stop_path = tracefs_get_tracing_file("osnoise/print_stack");
> +
> +	context->print_stack_fd = open(stop_path, O_RDWR);
> +	if (context->print_stack_fd < 0)
> +		goto out_err;
> +
> +	retval = read(context->print_stack_fd, &buffer, sizeof(buffer));
> +	if (retval <= 0)
> +		goto out_close;
> +
> +	print_stack = get_llong_from_str(buffer);
> +	if (print_stack < 0)
> +		goto out_close;
> +
> +	tracefs_put_tracing_file(stop_path);
> +
> +	context->orig_print_stack = print_stack;
> +	return print_stack;
> +
> +out_close:
> +	close(context->print_stack_fd);
> +	context->print_stack_fd = CLOSED_FD;
> +out_err:
> +	tracefs_put_tracing_file(stop_path);
> +	return -1;

The same.

> +}
> +/*
> + * osnoise_context_alloc - alloc an osnoise_context
> + *
> + * The osnoise context contains the information of the "osnoise/" configs.
> + * It is used to set and restore the config.
> + */
> +struct osnoise_context *osnoise_context_alloc(void)
> +{
> +	struct osnoise_context *context;
> +
> +	context = calloc(1, sizeof(*context));
> +	if (!context)
> +		goto out_err;
> +
> +	context->cpus_fd 		= CLOSED_FD;
> +	context->runtime_fd		= CLOSED_FD;
> +	context->period_fd		= CLOSED_FD;
> +	context->stop_us_fd		= CLOSED_FD;
> +	context->stop_total_us_fd	= CLOSED_FD;
> +	context->timerlat_period_us_fd	= CLOSED_FD;
> +	context->print_stack_fd		= CLOSED_FD;
> +
> +	context->orig_stop_us		= OSNOISE_OPTION_INIT_VAL;
> +	context->stop_us		= OSNOISE_OPTION_INIT_VAL;
> +
> +	context->orig_stop_total_us	= OSNOISE_OPTION_INIT_VAL;
> +	context->stop_total_us		= OSNOISE_OPTION_INIT_VAL;
> +
> +	context->orig_print_stack	= OSNOISE_OPTION_INIT_VAL;
> +	context->print_stack		= OSNOISE_OPTION_INIT_VAL;
> +
> +	osnoise_get_context(context);
> +
> +	return context;
> +out_err:
> +	if (context)
> +		free(context);

context is NULL here, so no need the check. Just directly return NULL
when 'if(!context)' is enough.

> +	return NULL;
> +}

Sorry for my slow and not complete reply.. and leave not sure here.

Thanks,
Tao
