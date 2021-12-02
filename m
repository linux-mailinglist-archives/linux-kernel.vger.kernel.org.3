Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F994666E9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359113AbhLBPoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:44:55 -0500
Received: from gateway36.websitewelcome.com ([192.185.198.13]:43967 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359098AbhLBPow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:44:52 -0500
X-Greylist: delayed 1335 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Dec 2021 10:44:52 EST
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 545FC401F7196
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 09:18:59 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id snrOmrE7WgC9EsnrOmYT6i; Thu, 02 Dec 2021 09:18:59 -0600
X-Authority-Reason: nr=8
Received: from host-79-34-250-122.business.telecomitalia.it ([79.34.250.122]:57870 helo=[10.0.0.161])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1msnrN-004BKV-Ad; Thu, 02 Dec 2021 09:18:57 -0600
Message-ID: <9944378d-456f-79a5-2dbf-30dbbbc94522@kernel.org>
Date:   Thu, 2 Dec 2021 16:18:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH V8 03/14] rtla: Add osnoise tool
Content-Language: en-US
To:     Tao Zhou <tao.zhou@linux.dev>
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
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1638182284.git.bristot@kernel.org>
 <ffb7f1b1e8cc42fc8ec52f1a89fdd2ca0d70c36e.1638182284.git.bristot@kernel.org>
 <YaZEzvzp5jkRyLEJ@geo.homenetwork>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <YaZEzvzp5jkRyLEJ@geo.homenetwork>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.34.250.122
X-Source-L: No
X-Exim-ID: 1msnrN-004BKV-Ad
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-34-250-122.business.telecomitalia.it ([10.0.0.161]) [79.34.250.122]:57870
X-Source-Auth: kernel@bristot.me
X-Email-Count: 1
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao

On 11/30/21 16:35, Tao Zhou wrote:
> Hi Daniel,
> 
> On Mon, Nov 29, 2021 at 12:07:41PM +0100, Daniel Bristot de Oliveira wrote:
>> +/*
>> + * osnoise_restore_cpus - restore the original "osnoise/cpus"
>> + *
>> + * osnoise_set_cpus() saves the original data for the "osnoise/cpus"
> 
> osnoise_set_cpus() --> osnoise_restore_cpus()

This comment is correct... osnoise_set_cpus saves the data (in the tool),
osnoise_restore_cpus() restores it.

>> + * file. This function restore the original config it was previously
>> + * modified.
>> + */
>> +void osnoise_restore_cpus(struct osnoise_context *context)
>> +{
>> +	int retval;
>> +
>> +	if (!context->orig_cpus)
>> +		return;
>> +
>> +	if (!context->curr_cpus)
>> +		return;
>> +
>> +	/* nothing to do? */
>> +	if (!strcmp(context->orig_cpus, context->curr_cpus))
>> +		goto out_done;
>> +
>> +	retval = write(context->cpus_fd, context->orig_cpus, strlen(context->orig_cpus));
> 
> 'strlen(context->orig_cpus) + 1' for write size;
> 
>> +	if (retval < strlen(context->orig_cpus))
> 
> Same here. Check 'strlen(context->orig_cpus) + 1'

Fixed in v9.

>> +		err_msg("could not restore original osnoise cpus\n");
>> +
>> +out_done:
>> +	free(context->curr_cpus);
>> +	context->curr_cpus = NULL;
>> +}
>> +
>> +/*
>> + * osnoise_get_runtime - return the original "osnoise/runtime_us" value
>> + *
>> + * It also saves the value to be restored.
>> + */
>> +unsigned long long osnoise_get_runtime(struct osnoise_context *context)
>> +{
>> +	char buffer[BUFF_U64_STR_SIZE];
>> +	long long runtime_us;
>> +	char *runtime_path;
>> +	int retval;
>> +
>> +	if (context->runtime_us != OSNOISE_TIME_INIT_VAL)
>> +		return context->runtime_us;
>> +
>> +	if (context->orig_runtime_us != OSNOISE_TIME_INIT_VAL)
>> +		return context->orig_runtime_us;
>> +
>> +	runtime_path = tracefs_get_tracing_file("osnoise/runtime_us");
>> +
>> +	context->runtime_fd = open(runtime_path, O_RDWR);
>> +	if (context->runtime_fd < 0)
>> +		goto out_err;
>> +
>> +	retval = read(context->runtime_fd, &buffer, sizeof(buffer));
>> +	if (retval <= 0)
>> +		goto out_close;
>> +
>> +	runtime_us = get_llong_from_str(buffer);
>> +	if (runtime_us < 0)
>> +		goto out_close;
>> +
>> +	tracefs_put_tracing_file(runtime_path);
>> +
>> +	context->orig_runtime_us = runtime_us;
>> +	return runtime_us;
>> +
>> +out_close:
>> +	close(context->runtime_fd);
>> +	context->runtime_fd = CLOSED_FD;
>> +out_err:
>> +	tracefs_put_tracing_file(runtime_path);
>> +	return 0;
>> +}
>> +/*
>> + * osnoise_get_period - return the original "osnoise/period_us" value
>> + *
>> + * It also saves the value to be restored.
>> + */
>> +unsigned long long osnoise_get_period(struct osnoise_context *context)
>> +{
>> +	char buffer[BUFF_U64_STR_SIZE];
>> +	char *period_path;
>> +	long long period_us;
>> +	int retval;
>> +
>> +	if (context->period_us != OSNOISE_TIME_INIT_VAL)
>> +		return context->period_us;
>> +
>> +	if (context->orig_period_us != OSNOISE_TIME_INIT_VAL)
>> +		return context->orig_period_us;
>> +
>> +	period_path = tracefs_get_tracing_file("osnoise/period_us");
>> +
>> +	context->period_fd = open(period_path, O_RDWR);
>> +	if (context->period_fd < 0)
>> +		goto out_err;
>> +
>> +	retval = read(context->period_fd, &buffer, sizeof(buffer));
>> +	if (retval <= 0)
>> +		goto out_close;
>> +
>> +	period_us = get_llong_from_str(buffer);
>> +	if (period_us < 0)
>> +		goto out_close;
>> +
>> +	tracefs_put_tracing_file(period_path);
>> +
>> +	context->orig_period_us = period_us;
>> +	return period_us;
>> +
>> +out_close:
>> +	close(context->period_fd);
>> +	context->period_fd = CLOSED_FD;
>> +out_err:
>> +	tracefs_put_tracing_file(period_path);
>> +	return 0;
>> +}
> 
> osnoise_get_period() and osnoise_get_runtime() almost the same.
> Use macro to generate code. Some thing also not sure now. Shame
> 
> 
> #define osnoise_get_period osnoise_get(period)
> #define osnoise_get_runtime osnoise_get(runtime)
> 
> #define osnoise_get(x)	\
> unsigned long long osnoise_get_##x(struct osnoise_context *context) \ 
> {              \
> 	char buffer[BUFF_U64_STR_SIZE];             \
> 	char * x##_path;             \ 
> 	long long x##_us;            \
> 	if (context->x##_us != OSNOISE_TIME_INIT_VAL)                   \
> 		return context->x##_us;           \
> 	if (context->orig_##x##_us != OSNOISE_TIME_INIT_VAL)            \
> 		return context->orig_##x##_us;          \
> 	x##_path = tracefs_get_tracing_file("osnoise/x##_us");        \
> 	context->x##_fd = open(x##_path, O_RDWR);               \
> 	if (context->x##_fd < 0)                        \
> 		goto out_err;                 \
> 	retval = read(context->x##_fd, &buffer, sizeof(buffer));        \
> 	if (retval <= 0)                  \
> 		goto out_close;               \
> 	x##_us = get_llong_from_str(buffer);            \
> 	if (x##_us < 0)                   \
> 		goto out_close;               \
> 	tracefs_put_tracing_file(x##_path);             \
> 	context->orig_##x##_us = x##_us;                \
> 	return x##_us;                    \
> out_close:                            \
> 	close(context->x##_fd);           \
> 	context->x##_fd = CLOSED_FD;                    \
> out_err:                              \
> 	tracefs_put_tracing_file(x##_path);             \
> 	return 0;                         \
> }


I am not sure if it is worth to trade the readability for just two functions. I
will keep this as is foe now, and think about it in a second moment.

[...]
>> +
>> +/*
>> + * osnoise_set_runtime_period - set osnoise runtime and period
>> + *
>> + * Osnoise's runtime and period are related as runtime <= period.
>> + * Thus, this function saves the original values, and then tries
>> + * to set the runtime and period if they are != 0.
>> + */
>> +int osnoise_set_runtime_period(struct osnoise_context *context,
>> +			       unsigned long long runtime,
>> +			       unsigned long long period)
>> +{
>> +	unsigned long long curr_runtime_us;
>> +	unsigned long long curr_period_us;
>> +	int retval;
>> +
>> +	if (!period && !runtime)
>> +		return 0;
>> +
>> +	curr_runtime_us = osnoise_get_runtime(context);
>> +	curr_period_us = osnoise_get_period(context);
>> +
>> +	/* error getting any value? */
>> +	if (curr_period_us == -1 || curr_runtime_us == -1)
>> +		return -1;
> 
> 'curr_period_us' and 'curr_runtime_us' error value should be
> 0(OSNOISE_TIME_INIT_VAL).
> 


Right, I am now (in v9) returning the *_INIT_VAL on all errors, and using the
macro to check for errors.

[...]

>> +static long long
>> +osnoise_get_timerlat_period_us(struct osnoise_context *context)
>> +{
>> +	char buffer[BUFF_U64_STR_SIZE];
>> +	long long timerlat_period_us;
>> +	char *stop_path;
>> +	int retval;
>> +
>> +	if (context->timerlat_period_us != OSNOISE_TIME_INIT_VAL)
>> +		return context->timerlat_period_us;
>> +
>> +	if (context->orig_timerlat_period_us != OSNOISE_TIME_INIT_VAL)
>> +		return context->orig_timerlat_period_us;
>> +
>> +	stop_path = tracefs_get_tracing_file("osnoise/timerlat_period_us");
> 
> Using timerlat_period_path seems to be straightforward.
> 

I am using config_path for all variables like this.


[...]

>> +/*
>> + * osnoise_context_alloc - alloc an osnoise_context
>> + *
>> + * The osnoise context contains the information of the "osnoise/" configs.
>> + * It is used to set and restore the config.
>> + */
>> +struct osnoise_context *osnoise_context_alloc(void)
>> +{
>> +	struct osnoise_context *context;
>> +
>> +	context = calloc(1, sizeof(*context));
>> +	if (!context)
>> +		goto out_err;
>> +
>> +	context->cpus_fd 		= CLOSED_FD;
>> +	context->runtime_fd		= CLOSED_FD;
>> +	context->period_fd		= CLOSED_FD;
>> +	context->stop_us_fd		= CLOSED_FD;
>> +	context->stop_total_us_fd	= CLOSED_FD;
>> +	context->timerlat_period_us_fd	= CLOSED_FD;
>> +	context->print_stack_fd		= CLOSED_FD;
>> +
>> +	context->orig_stop_us		= OSNOISE_OPTION_INIT_VAL;
>> +	context->stop_us		= OSNOISE_OPTION_INIT_VAL;
>> +
>> +	context->orig_stop_total_us	= OSNOISE_OPTION_INIT_VAL;
>> +	context->stop_total_us		= OSNOISE_OPTION_INIT_VAL;
>> +
>> +	context->orig_print_stack	= OSNOISE_OPTION_INIT_VAL;
>> +	context->print_stack		= OSNOISE_OPTION_INIT_VAL;
>> +
>> +	osnoise_get_context(context);
>> +
>> +	return context;
>> +out_err:
>> +	if (context)
>> +		free(context);
> 
> context is NULL here, so no need the check. Just directly return NULL
> when 'if(!context)' is enough.
> 
>> +	return NULL;
>> +}

In v9, I am removing the goto, returning NULL if (!context).

> Sorry for my slow and not complete reply.. and leave not sure here.
> 
> Thanks,
> Tao

Thanks Tao
-- Daniel

