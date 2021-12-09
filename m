Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89DD46F2B0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 19:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243157AbhLISEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 13:04:45 -0500
Received: from gateway30.websitewelcome.com ([192.185.180.41]:43696 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229803AbhLISEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 13:04:44 -0500
X-Greylist: delayed 1827 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2021 13:04:44 EST
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 51A8D31A145;
        Thu,  9 Dec 2021 10:33:56 -0600 (CST)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id vMA6mOdU74teEvMAqmJDC9; Thu, 09 Dec 2021 10:21:39 -0600
X-Authority-Reason: nr=8
Received: from host-87-6-201-63.retail.telecomitalia.it ([87.6.201.63]:45012 helo=[10.0.0.193])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1mvM4m-000oFe-Lq; Thu, 09 Dec 2021 10:15:20 -0600
Message-ID: <c451b79f-e6c4-1dbf-8556-c497ae32b058@kernel.org>
Date:   Thu, 9 Dec 2021 17:15:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH V8 03/14] rtla: Add osnoise tool
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tao Zhou <tao.zhou@linux.dev>, Ingo Molnar <mingo@redhat.com>,
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
 <20211208171311.5f1ad94f@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20211208171311.5f1ad94f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 87.6.201.63
X-Source-L: No
X-Exim-ID: 1mvM4m-000oFe-Lq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-87-6-201-63.retail.telecomitalia.it ([10.0.0.193]) [87.6.201.63]:45012
X-Source-Auth: kernel@bristot.me
X-Email-Count: 14
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/21 23:13, Steven Rostedt wrote:
> On Mon, 29 Nov 2021 12:07:41 +0100
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
>> The osnoise tool is the interface for the osnoise tracer. The osnoise
>> tool will have multiple "modes" with different outputs. At this point,
>> no mode is included.
>>
>> The osnoise.c includes the osnoise_context abstraction. It serves to
>> read-save-change-restore the default values from tracing/osnoise/
>> directory. When the context is deleted, the default values are restored.
>>
>> It also includes some other helper functions for managing osnoise
>> tracer sessions.
>>
>> With these bits and pieces in place, we can start adding some
>> functionality to rtla.
>>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Tom Zanussi <zanussi@kernel.org>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Clark Williams <williams@redhat.com>
>> Cc: John Kacur <jkacur@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
>> Cc: linux-rt-users@vger.kernel.org
>> Cc: linux-trace-devel@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
>> ---
>>  tools/tracing/rtla/Makefile      |    2 +
>>  tools/tracing/rtla/src/osnoise.c | 1013 ++++++++++++++++++++++++++++++
>>  tools/tracing/rtla/src/osnoise.h |   95 +++
>>  tools/tracing/rtla/src/rtla.c    |   10 +
>>  4 files changed, 1120 insertions(+)
>>  create mode 100644 tools/tracing/rtla/src/osnoise.c
>>  create mode 100644 tools/tracing/rtla/src/osnoise.h
>>
>> diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
>> index d99ea2d8b87e..ba6f327e815a 100644
>> --- a/tools/tracing/rtla/Makefile
>> +++ b/tools/tracing/rtla/Makefile
>> @@ -60,6 +60,8 @@ install:
>>  	$(INSTALL) -d -m 755 $(DESTDIR)$(BINDIR)
>>  	$(INSTALL) rtla -m 755 $(DESTDIR)$(BINDIR)
>>  	$(STRIP) $(DESTDIR)$(BINDIR)/rtla
>> +	@test ! -f $(DESTDIR)$(BINDIR)/osnoise || rm $(DESTDIR)$(BINDIR)/osnoise
>> +	ln -s $(DESTDIR)$(BINDIR)/rtla $(DESTDIR)$(BINDIR)/osnoise
>>  
>>  .PHONY: clean tarball
>>  clean:
>> diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
>> new file mode 100644
>> index 000000000000..7ef686dddc09
>> --- /dev/null
>> +++ b/tools/tracing/rtla/src/osnoise.c
>> @@ -0,0 +1,1013 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2021 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
>> + */
>> +
>> +#include <sys/types.h>
>> +#include <sys/stat.h>
>> +#include <pthread.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <unistd.h>
>> +#include <errno.h>
>> +#include <fcntl.h>
>> +#include <stdio.h>
>> +
>> +#include "osnoise.h"
>> +#include "utils.h"
>> +
>> +/*
>> + * osnoise_get_cpus - return the original "osnoise/cpus" content
>> + *
>> + * It also saves the value to be restored.
>> + */
>> +char *osnoise_get_cpus(struct osnoise_context *context)
>> +{
>> +	char buffer[1024];
>> +	char *cpus_path;
>> +	int retval;
>> +
>> +	if (context->curr_cpus)
>> +		return context->curr_cpus;
>> +
>> +	if (context->orig_cpus)
>> +		return context->orig_cpus;
>> +
>> +	cpus_path = tracefs_get_tracing_file("osnoise/cpus");
>> +
>> +	context->cpus_fd = open(cpus_path, O_RDWR);
>> +	if (context->cpus_fd < 0)
>> +		goto out_err;
>> +
>> +	retval = read(context->cpus_fd, &buffer, sizeof(buffer));
>> +	if (retval <= 0)
>> +		goto out_close;
>> +
>> +	context->orig_cpus = strdup(buffer);
> 
> 
> Or you could have done:
> 
> 	context->orig_cpus = tracefs_instance_read(NULL, "osnoise/cpus");


Yep, that would be better.

> as I doubt that reading and writing the cpus file you really care about
> keeping around the file descriptor.

Yep, I do not necessarly need it.... (do not ask me why I am not using, it is
obviosly better... I might have just missed it).

It's not something likely to be done
> where you care about "disrupting" the system. But if you really do care:
> 
> 	context->cpus_fd = tracefs_instance_file_open(NULL, "osnoise/cpus",
> 				O_RDWR);

I will use tracefs helpers to read/write files, and remove the file descriptor
variables.

[...]

>> +	snprintf(buffer, sizeof(buffer), "%llu\n", runtime);
>> +
>> +	retval = write(context->runtime_fd, buffer, strlen(buffer) + 1);
> 
> Again, how important is it to have the fd?
> 

it is not...

[...]

>> +/*
>> + * osnoise_set_stop_total_us - set "stop_tracing_total_us"
>> + */
>> +int osnoise_set_stop_total_us(struct osnoise_context *context, long long stop_total_us)
>> +{
>> +	long long curr_stop_total_us = osnoise_get_stop_total_us(context);
>> +	char buffer[BUFF_U64_STR_SIZE];
>> +	int retval;
>> +
>> +	if (curr_stop_total_us == OSNOISE_OPTION_INIT_VAL)
>> +		return -1;
>> +
>> +	snprintf(buffer, BUFF_U64_STR_SIZE, "%lld\n", stop_total_us);
>> +
>> +	retval = write(context->stop_total_us_fd, buffer, strlen(buffer) + 1);
> 
> And here.
> 
> Hmm, we should add a helper:
> 
> 	tracefs_instance_file_printf(instance, fmt, ...)
> 
> Where the above could be:
> 
> 	tracefs_instance_file_printf(NULL, "%lld\n", stop_total_us);
> 
> Of course, for now, you could just add a helper function that does that.

sounds good to me.

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
> 
> You could save a lot of code by using the tracefs_instance_file_*()
> helpers. And do you really need to keep around the file descriptors?

I will use the helpers in v9, I am convincede... :-)

Thanks Steve
-- Daniel
