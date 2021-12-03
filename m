Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3254673C0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379456AbhLCJRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:17:34 -0500
Received: from out0.migadu.com ([94.23.1.103]:49807 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235878AbhLCJRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:17:21 -0500
Date:   Fri, 3 Dec 2021 17:13:45 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638522834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ICMG0LM6TFIIWQIAmCvfzGsYfsWrQwKywGFcd5J2Yoc=;
        b=PRHNgjfipvE8tCskvL+0W732G6JccAiCmGDRX5VIdqhXXbzU79nD4enKfQOYqfHnRIAFJJ
        yJL0ZGwp/jE2P0dhjaka7vQFY2pg4cT+1k3hsYKOz1C3Oa8hzNSM4iqVzWzgHF4OnvilqE
        GTB4lGr1xBPdRn33mLovUGbH95O5SA0=
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
Subject: Re: [PATCH V8 06/14] rtla: Add timerlat tool and timelart top mode
Message-ID: <YanfyfUgMW6KWpxS@geo.homenetwork>
References: <cover.1638182284.git.bristot@kernel.org>
 <e65a6899bbde6ecb129cfaf55e402d785ad124eb.1638182284.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e65a6899bbde6ecb129cfaf55e402d785ad124eb.1638182284.git.bristot@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 12:07:44PM +0100,
Daniel Bristot de Oliveira wrote:

> The rtla timerlat tool is an interface for the timerlat tracer.
> The timerlat tracer dispatches a kernel thread per-cpu. These threads set a
> periodic timer to wake themselves up and go back to sleep. After the
> wakeup, they collect and generate useful information for the debugging of
> operating system timer latency.
> 
> The timerlat tracer outputs information in two ways. It periodically
> prints the timer latency at the timer IRQ handler and the Thread handler.
> It also provides information for each noise via the osnoise tracepoints.
> 
> The rtla timerlat top mode displays a summary of the periodic output from
> the timerlat tracer.
> 
> Here is one example of the rtla timerlat tool output:
>  ---------- %< ----------
> [root@alien ~]# rtla timerlat top -c 0-3 -d 1m
>                                      Timer Latency
>   0 00:01:00   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
> CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
>   0 #60001     |        0         0         0         3 |        1         1         1         6
>   1 #60001     |        0         0         0         3 |        2         1         1         5
>   2 #60001     |        0         0         1         6 |        1         1         2         7
>   3 #60001     |        0         0         0         7 |        1         1         1        11
>  ---------- >% ----------
> 
> Running:
>   # rtla timerlat --help
>   # rtla timerlat top --help
> provides information about the available options.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Tom Zanussi <zanussi@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> Cc: linux-rt-users@vger.kernel.org
> Cc: linux-trace-devel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  tools/tracing/rtla/Makefile           |   2 +
>  tools/tracing/rtla/src/rtla.c         |   5 +
>  tools/tracing/rtla/src/timerlat.c     |  68 +++
>  tools/tracing/rtla/src/timerlat.h     |   4 +
>  tools/tracing/rtla/src/timerlat_top.c | 615 ++++++++++++++++++++++++++
>  5 files changed, 694 insertions(+)
>  create mode 100644 tools/tracing/rtla/src/timerlat.c
>  create mode 100644 tools/tracing/rtla/src/timerlat.h
>  create mode 100644 tools/tracing/rtla/src/timerlat_top.c
> 
> diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> index ba6f327e815a..f254cfbe4fa3 100644
> --- a/tools/tracing/rtla/Makefile
> +++ b/tools/tracing/rtla/Makefile
> @@ -62,6 +62,8 @@ install:
>  	$(STRIP) $(DESTDIR)$(BINDIR)/rtla
>  	@test ! -f $(DESTDIR)$(BINDIR)/osnoise || rm $(DESTDIR)$(BINDIR)/osnoise
>  	ln -s $(DESTDIR)$(BINDIR)/rtla $(DESTDIR)$(BINDIR)/osnoise
> +	@test ! -f $(DESTDIR)$(BINDIR)/timerlat || rm $(DESTDIR)$(BINDIR)/timerlat
> +	ln -s $(DESTDIR)$(BINDIR)/rtla $(DESTDIR)$(BINDIR)/timerlat
>  
>  .PHONY: clean tarball
>  clean:
> diff --git a/tools/tracing/rtla/src/rtla.c b/tools/tracing/rtla/src/rtla.c
> index 669b9750b3b3..09bd21b8af81 100644
> --- a/tools/tracing/rtla/src/rtla.c
> +++ b/tools/tracing/rtla/src/rtla.c
> @@ -9,6 +9,7 @@
>  #include <stdio.h>
>  
>  #include "osnoise.h"
> +#include "timerlat.h"
>  
>  /*
>   * rtla_usage - print rtla usage
> @@ -25,6 +26,7 @@ static void rtla_usage(void)
>  		"",
>  		"  commands:",
>  		"     osnoise  - gives information about the operating system noise (osnoise)",
> +		"     timerlat - measures the timer irq and thread latency",
>  		"",
>  		NULL,
>  	};
> @@ -45,6 +47,9 @@ int run_command(int argc, char **argv, int start_position)
>  	if (strcmp(argv[start_position], "osnoise") == 0) {
>  		osnoise_main(argc-start_position, &argv[start_position]);
>  		goto ran;
> +	} else if (strcmp(argv[start_position], "timerlat") == 0) {
> +		timerlat_main(argc-start_position, &argv[start_position]);
> +		goto ran;
>  	}
>  
>  	return 0;
> diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
> new file mode 100644
> index 000000000000..29a51c01b084
> --- /dev/null
> +++ b/tools/tracing/rtla/src/timerlat.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
> + */
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <pthread.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +
> +#include "timerlat.h"
> +
> +static void timerlat_usage(void)
> +{
> +	int i;
> +
> +	static const char * const msg[] = {
> +		"",
> +		"timerlat version " VERSION,
> +		"",
> +		"  usage: [rtla] timerlat [MODE] ...",
> +		"",
> +		"  modes:",
> +		"     top  - prints the summary from timerlat tracer",
> +		"",
> +		"if no MODE is given, the top mode is called, passing the arguments",
> +		NULL,
> +	};
> +
> +	for (i = 0; msg[i]; i++)
> +		fprintf(stderr, "%s\n", msg[i]);
> +	exit(1);
> +}
> +
> +int timerlat_main(int argc, char *argv[])
> +{
> +	if (argc == 0)
> +		goto usage;
> +
> +	/*
> +	 * if timerlat was called without any argument, run the
> +	 * default cmdline.
> +	 */
> +	if (argc == 1) {
> +		timerlat_top_main(argc, argv);
> +		exit(0);
> +	}
> +
> +	if ((strcmp(argv[1], "-h") == 0) || (strcmp(argv[1], "--help") == 0)) {
> +		timerlat_usage();
> +		exit(0);
> +	} else if (strncmp(argv[1], "-", 1) == 0) {
> +		/* the user skipped the tool, call the default one */
> +		timerlat_top_main(argc, argv);
> +		exit(0);
> +	} else if (strcmp(argv[1], "top") == 0) {
> +		timerlat_top_main(argc-1, &argv[1]);
> +		exit(0);
> +	}
> +
> +usage:
> +	timerlat_usage();
> +	exit(1);
> +}
> diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
> new file mode 100644
> index 000000000000..6f9d3925acd0
> --- /dev/null
> +++ b/tools/tracing/rtla/src/timerlat.h
> @@ -0,0 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +int timerlat_top_main(int argc, char *argv[]);
> +int timerlat_main(int argc, char *argv[]);
> diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
> new file mode 100644
> index 000000000000..9764681ad8b1
> --- /dev/null
> +++ b/tools/tracing/rtla/src/timerlat_top.c
> @@ -0,0 +1,615 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
> + */
> +
> +#include <getopt.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <signal.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <time.h>
> +
> +#include "utils.h"
> +#include "osnoise.h"
> +#include "timerlat.h"
> +
> +struct timerlat_top_params {
> +	char			*cpus;
> +	char			*monitored_cpus;
> +	char			*trace_output;
> +	unsigned long long	runtime;
> +	long long		stop_us;
> +	long long		stop_total_us;
> +	long long		timerlat_period_us;
> +	long long		print_stack;
> +	int			sleep_time;
> +	int			output_divisor;
> +	int			duration;
> +	int			quiet;
> +	int			set_sched;
> +	struct sched_attr	sched_param;
> +};
> +
> +struct timerlat_top_cpu {
> +	int			irq_count;
> +	int			thread_count;
> +
> +	unsigned long long	cur_irq;
> +	unsigned long long	min_irq;
> +	unsigned long long	sum_irq;
> +	unsigned long long	max_irq;
> +
> +	unsigned long long	cur_thread;
> +	unsigned long long	min_thread;
> +	unsigned long long	sum_thread;
> +	unsigned long long	max_thread;
> +};
> +
> +struct timerlat_top_data {
> +	struct timerlat_top_cpu	*cpu_data;
> +	int			nr_cpus;
> +};
> +
> +/*
> + * timerlat_free_top - free runtime data
> + */
> +static void
> +timerlat_free_top(struct timerlat_top_data *data)
> +{
> +	free(data->cpu_data);
> +	free(data);
> +}
> +
> +/*
> + * timerlat_alloc_histogram - alloc runtime data
> + */
> +static struct timerlat_top_data *timerlat_alloc_top(int nr_cpus)
> +{
> +	struct timerlat_top_data *data;
> +	int cpu;
> +
> +	data = calloc(1, sizeof(*data));
> +	if (!data)
> +		return NULL;
> +
> +	data->nr_cpus = nr_cpus;
> +
> +	/* one set of histograms per CPU */
> +	data->cpu_data = calloc(1, sizeof(*data->cpu_data) * nr_cpus);
> +	if (!data->cpu_data)
> +		goto cleanup;
> +
> +	/* set the min to max */
> +	for (cpu = 0; cpu < nr_cpus; cpu++) {
> +		data->cpu_data[cpu].min_irq = ~0;
> +		data->cpu_data[cpu].min_thread = ~0;
> +	}
> +
> +	return data;
> +
> +cleanup:
> +	timerlat_free_top(data);
> +	return NULL;
> +}
> +
> +/*
> + * timerlat_hist_update - record a new timerlat occurent on cpu, updating data
> + */
> +static void
> +timerlat_top_update(struct osnoise_tool *tool, int cpu,
> +		    unsigned long long thread,
> +		    unsigned long long latency)
> +{
> +	struct timerlat_top_data *data = tool->data;
> +	struct timerlat_top_cpu *cpu_data = &data->cpu_data[cpu];
> +
> +	if (!thread) {
> +		cpu_data->irq_count++;
> +		cpu_data->cur_irq = latency;
> +		update_min(&cpu_data->min_irq, &latency);
> +		update_sum(&cpu_data->sum_irq, &latency);
> +		update_max(&cpu_data->max_irq, &latency);
> +	} else {
> +		cpu_data->thread_count++;
> +		cpu_data->cur_thread = latency;
> +		update_min(&cpu_data->min_thread, &latency);
> +		update_sum(&cpu_data->sum_thread, &latency);
> +		update_max(&cpu_data->max_thread, &latency);
> +	}
> +}
> +
> +/*
> + * timerlat_top_handler - this is the handler for timerlat tracer events
> + */
> +static int
> +timerlat_top_handler(struct trace_seq *s, struct tep_record *record,
> +		     struct tep_event *event, void *context)
> +{
> +	struct trace_instance *trace = context;
> +	unsigned long long latency, thread;
> +	struct osnoise_tool *top;
> +	int cpu = record->cpu;
> +
> +	top = container_of(trace, struct osnoise_tool, trace);
> +
> +	tep_get_field_val(s, event, "context", record, &thread, 1);
> +	tep_get_field_val(s, event, "timer_latency", record, &latency, 1);
> +
> +	timerlat_top_update(top, cpu, thread, latency);
> +
> +	return 0;
> +}
> +
> +/*
> + * timerlat_top_header - print the header of the tool output
> + */
> +static void timerlat_top_header(struct osnoise_tool *top)
> +{
> +	struct timerlat_top_params *params = top->params;
> +	struct trace_seq *s = top->trace.seq;
> +	char duration[26];
> +
> +	get_duration(top->start_time, duration, sizeof(duration));
> +
> +	trace_seq_printf(s, "\033[2;37;40m");
> +	trace_seq_printf(s, "                                     Timer Latency                                              ");
> +	trace_seq_printf(s, "\033[0;0;0m");
> +	trace_seq_printf(s, "\n");
> +
> +	trace_seq_printf(s, "%-6s   |          IRQ Timer Latency (%s)        |         Thread Timer Latency (%s)\n", duration,
> +			params->output_divisor == 1 ? "ns" : "us",
> +			params->output_divisor == 1 ? "ns" : "us");
> +
> +	trace_seq_printf(s, "\033[2;30;47m");
> +	trace_seq_printf(s, "CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max");
> +	trace_seq_printf(s, "\033[0;0;0m");
> +	trace_seq_printf(s, "\n");
> +}
> +
> +/*
> + * timerlat_top_print - prints the output of a given CPU
> + */
> +static void timerlat_top_print(struct osnoise_tool *top, int cpu)
> +{
> +
> +	struct timerlat_top_params *params = top->params;
> +	struct timerlat_top_data *data = top->data;
> +	struct timerlat_top_cpu *cpu_data = &data->cpu_data[cpu];
> +	int divisor = params->output_divisor;
> +	struct trace_seq *s = top->trace.seq;
> +
> +	if (divisor == 0)
> +		return;
> +
> +	/*
> +	 * Skip if no data is available: is this cpu offline?
> +	 */
> +	if (!cpu_data->irq_count && !cpu_data->thread_count)
> +		return;
> +
> +	/*
> +	 * Unless trace is being lost, IRQ counter is always the max.
> +	 */
> +	trace_seq_printf(s, "%3d #%-9d |", cpu, cpu_data->irq_count);
> +
> +	if (!cpu_data->irq_count) {
> +		trace_seq_printf(s, "        - ");
> +		trace_seq_printf(s, "        - ");
> +		trace_seq_printf(s, "        - ");
> +		trace_seq_printf(s, "        - |");
> +	} else {
> +		trace_seq_printf(s, "%9llu ", cpu_data->cur_irq / params->output_divisor);
> +		trace_seq_printf(s, "%9llu ", cpu_data->min_irq / params->output_divisor);
> +		trace_seq_printf(s, "%9llu ", (cpu_data->sum_irq / cpu_data->irq_count) / divisor);
> +		trace_seq_printf(s, "%9llu |", cpu_data->max_irq / divisor);
> +	}
> +
> +	if (!cpu_data->thread_count) {
> +		trace_seq_printf(s, "        - ");
> +		trace_seq_printf(s, "        - ");
> +		trace_seq_printf(s, "        - ");
> +		trace_seq_printf(s, "        -\n");
> +	} else {
> +		trace_seq_printf(s, "%9llu ", cpu_data->cur_thread / divisor);
> +		trace_seq_printf(s, "%9llu ", cpu_data->min_thread / divisor);
> +		trace_seq_printf(s, "%9llu ",
> +				(cpu_data->sum_thread / cpu_data->thread_count) / divisor);
> +		trace_seq_printf(s, "%9llu\n", cpu_data->max_thread / divisor);
> +	}
> +}
> +
> +/*
> + * clear_terminal - clears the output terminal
> + */
> +static void clear_terminal(struct trace_seq *seq)
> +{
> +	if (!config_debug)
> +		trace_seq_printf(seq, "\033c");
> +}
> +
> +/*
> + * timerlat_print_stats - print data for all cpus
> + */
> +static void
> +timerlat_print_stats(struct timerlat_top_params *params, struct osnoise_tool *top)
> +{
> +	struct trace_instance *trace = &top->trace;
> +	static int nr_cpus = -1;
> +	int i;
> +
> +	if (nr_cpus == -1)
> +		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
> +
> +	if (!params->quiet)
> +		clear_terminal(trace->seq);
> +
> +	timerlat_top_header(top);
> +
> +	for (i = 0; i < nr_cpus; i++) {
> +		if (params->cpus && !params->monitored_cpus[i])
> +			continue;
> +		timerlat_top_print(top, i);
> +	}
> +
> +	trace_seq_do_printf(trace->seq);
> +	trace_seq_reset(trace->seq);
> +}
> +
> +/*
> + * timerlat_top_usage - prints timerlat top usage message
> + */
> +static void timerlat_top_usage(char *usage)
> +{
> +	int i;
> +
> +	static const char *const msg[] = {
> +		"",
> +		"  usage: rtla timerlat [top] [-h] [-q] [-p us] [-i us] [-t us] [-s us] [-T[=file]] \\",
> +		"	  [-c cpu-list] [-P priority]",
> +		"",
> +		"	  -h/--help: print this menu",
> +		"	  -p/--period us: timerlat period in us",
> +		"	  -i/--irq us: stop trace if the irq latency is higher than the argument in us",
> +		"	  -T/--thread us: stop trace if the thread latency is higher than the argument in us",
> +		"	  -s/--stack us: save the stack trace at the IRQ if a thread latency is higher than the argument in us",
> +		"	  -c/--cpus cpus: run the tracer only on the given cpus	  -d/--duration time[m|h|d]: duration of the session in seconds",
> +		"	  -t/--trace[=file]: save the stopped trace to [file|timerlat_trace.txt]",
> +		"	  -n/--nano: display data in nanoseconds",
> +		"	  -q/--quiet print only a summary at the end",
> +		"	  -P/--priority o:prio|r:prio|f:prio|d:runtime:period : set scheduling parameters",
> +		"		o:prio - use SCHED_OTHER with prio",
> +		"		r:prio - use SCHED_RR with prio",
> +		"		f:prio - use SCHED_FIFO with prio",
> +		"		d:runtime[us|ms|s]:period[us|ms|s] - use SCHED_DEADLINE with runtime and period",
> +		"						       in nanoseconds",
> +		NULL,
> +	};

About help usage msg.

[-t us] --> [-T us]
[-T=[file]] --> [-t[=file]]

[-d] [-D] [-n] lack in the head usage info 'usage: ...'

> +
> +	if (usage)
> +		fprintf(stderr, "%s\n", usage);
> +
> +	fprintf(stderr, "rtla timerlat top: a per-cpu summary of the timer latency (version %s)\n",
> +			VERSION);
> +
> +	for (i = 0; msg[i]; i++)
> +		fprintf(stderr, "%s\n", msg[i]);
> +	exit(1);
> +}
> +
