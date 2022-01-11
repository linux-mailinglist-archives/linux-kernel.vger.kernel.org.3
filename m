Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42E048B405
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344957AbiAKRcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:32:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45368 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344379AbiAKRbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:31:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B75FEB81C34;
        Tue, 11 Jan 2022 17:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46330C36AEB;
        Tue, 11 Jan 2022 17:31:18 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1n7KzN-0032Gh-FI;
        Tue, 11 Jan 2022 12:31:17 -0500
Message-ID: <20220111173117.307241975@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 11 Jan 2022 12:30:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tao Zhou <tao.zhou@linux.dev>, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [for-next][PATCH 22/31] rtla/timerlat: Add timerlat hist mode
References: <20220111173030.999527342@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

The rtla hist hist mode displays a histogram of each tracer event
occurrence, both for IRQ and timer latencies. The tool also allows
many configurations of the timerlat tracer and the collection of
the tracer output.

Here is one example of the rtla timerlat hist mode output:
  ---------- %< ----------
 [root@alien ~]# rtla timerlat hist -c 0-3 -d 1M
 # RTLA timerlat histogram
 # Time unit is microseconds (us)
 # Duration:   0 00:01:00
 Index   IRQ-000   Thr-000   IRQ-001   Thr-001   IRQ-002   Thr-002   IRQ-003   Thr-003
 0         58572         0     59373         0     58691         0     58895         0
 1          1422     57021       628     57241      1310     56160      1102     56805
 2             6      2931         0      2695         0      3567         4      3031
 3             1        40         0        53         0       260         0       142
 4             0         7         0         5         0         6         0        17
 5             0         2         0         5         0         7         0         4
 6             0         0         0         2         0         1         0         1
 8             0         0         0         0         0         0         0         1
 over:         0         0         0         0         0         0         0         0
 count:    60001     60001     60001     60001     60001     60001     60001     60001
 min:          0         1         0         1         0         1         0         1
 avg:          0         1         0         1         0         1         0         1
 max:          3         5         1         6         1         6         2         8
  ---------- >% ----------

Running
 - rtla timerlat hist --help
provides information about the available options.

Link: https://lkml.kernel.org/r/eb486340cc983bd8f7f69fe6f99f8d2927fcd296.1638182284.git.bristot@kernel.org

Cc: Tao Zhou <tao.zhou@linux.dev>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: linux-rt-users@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/timerlat.c      |   6 +-
 tools/tracing/rtla/src/timerlat.h      |   2 +-
 tools/tracing/rtla/src/timerlat_hist.c | 820 +++++++++++++++++++++++++
 3 files changed, 826 insertions(+), 2 deletions(-)
 create mode 100644 tools/tracing/rtla/src/timerlat_hist.c

diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 29a51c01b084..97abbf494fee 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -25,7 +25,8 @@ static void timerlat_usage(void)
 		"  usage: [rtla] timerlat [MODE] ...",
 		"",
 		"  modes:",
-		"     top  - prints the summary from timerlat tracer",
+		"     top   - prints the summary from timerlat tracer",
+		"     hist  - prints a histogram of timer latencies",
 		"",
 		"if no MODE is given, the top mode is called, passing the arguments",
 		NULL,
@@ -60,6 +61,9 @@ int timerlat_main(int argc, char *argv[])
 	} else if (strcmp(argv[1], "top") == 0) {
 		timerlat_top_main(argc-1, &argv[1]);
 		exit(0);
+	} else if (strcmp(argv[1], "hist") == 0) {
+		timerlat_hist_main(argc-1, &argv[1]);
+		exit(0);
 	}
 
 usage:
diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
index 6f9d3925acd0..88561bfd14f3 100644
--- a/tools/tracing/rtla/src/timerlat.h
+++ b/tools/tracing/rtla/src/timerlat.h
@@ -1,4 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
+int timerlat_hist_main(int argc, char *argv[]);
 int timerlat_top_main(int argc, char *argv[]);
 int timerlat_main(int argc, char *argv[]);
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
new file mode 100644
index 000000000000..e1660bc61caf
--- /dev/null
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -0,0 +1,820 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
+ */
+
+#include <getopt.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <time.h>
+
+#include "utils.h"
+#include "osnoise.h"
+#include "timerlat.h"
+
+struct timerlat_hist_params {
+	char			*cpus;
+	char			*monitored_cpus;
+	char			*trace_output;
+	unsigned long long	runtime;
+	long long		stop_us;
+	long long		stop_total_us;
+	long long		timerlat_period_us;
+	long long		print_stack;
+	int			sleep_time;
+	int			output_divisor;
+	int			duration;
+	int			set_sched;
+	struct sched_attr	sched_param;
+
+	char			no_irq;
+	char			no_thread;
+	char			no_header;
+	char			no_summary;
+	char			no_index;
+	char			with_zeros;
+	int			bucket_size;
+	int			entries;
+};
+
+struct timerlat_hist_cpu {
+	int			*irq;
+	int			*thread;
+
+	int			irq_count;
+	int			thread_count;
+
+	unsigned long long	min_irq;
+	unsigned long long	sum_irq;
+	unsigned long long	max_irq;
+
+	unsigned long long	min_thread;
+	unsigned long long	sum_thread;
+	unsigned long long	max_thread;
+};
+
+struct timerlat_hist_data {
+	struct timerlat_hist_cpu	*hist;
+	int				entries;
+	int				bucket_size;
+	int				nr_cpus;
+};
+
+/*
+ * timerlat_free_histogram - free runtime data
+ */
+static void
+timerlat_free_histogram(struct timerlat_hist_data *data)
+{
+	int cpu;
+
+	/* one histogram for IRQ and one for thread, per CPU */
+	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
+		if (data->hist[cpu].irq)
+			free(data->hist[cpu].irq);
+
+		if (data->hist[cpu].thread)
+			free(data->hist[cpu].thread);
+	}
+
+	/* one set of histograms per CPU */
+	if (data->hist)
+		free(data->hist);
+
+	free(data);
+}
+
+/*
+ * timerlat_alloc_histogram - alloc runtime data
+ */
+static struct timerlat_hist_data
+*timerlat_alloc_histogram(int nr_cpus, int entries, int bucket_size)
+{
+	struct timerlat_hist_data *data;
+	int cpu;
+
+	data = calloc(1, sizeof(*data));
+	if (!data)
+		return NULL;
+
+	data->entries = entries;
+	data->bucket_size = bucket_size;
+	data->nr_cpus = nr_cpus;
+
+	/* one set of histograms per CPU */
+	data->hist = calloc(1, sizeof(*data->hist) * nr_cpus);
+	if (!data->hist)
+		goto cleanup;
+
+	/* one histogram for IRQ and one for thread, per cpu */
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		data->hist[cpu].irq = calloc(1, sizeof(*data->hist->irq) * (entries + 1));
+		if (!data->hist[cpu].irq)
+			goto cleanup;
+		data->hist[cpu].thread = calloc(1, sizeof(*data->hist->thread) * (entries + 1));
+		if (!data->hist[cpu].thread)
+			goto cleanup;
+	}
+
+	/* set the min to max */
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		data->hist[cpu].min_irq = ~0;
+		data->hist[cpu].min_thread = ~0;
+	}
+
+	return data;
+
+cleanup:
+	timerlat_free_histogram(data);
+	return NULL;
+}
+
+/*
+ * timerlat_hist_update - record a new timerlat occurent on cpu, updating data
+ */
+static void
+timerlat_hist_update(struct osnoise_tool *tool, int cpu,
+		     unsigned long long thread,
+		     unsigned long long latency)
+{
+	struct timerlat_hist_params *params = tool->params;
+	struct timerlat_hist_data *data = tool->data;
+	int entries = data->entries;
+	int bucket;
+	int *hist;
+
+	if (params->output_divisor)
+		latency = latency / params->output_divisor;
+
+	if (data->bucket_size)
+		bucket = latency / data->bucket_size;
+
+	if (!thread) {
+		hist = data->hist[cpu].irq;
+		data->hist[cpu].irq_count++;
+		update_min(&data->hist[cpu].min_irq, &latency);
+		update_sum(&data->hist[cpu].sum_irq, &latency);
+		update_max(&data->hist[cpu].max_irq, &latency);
+	} else {
+		hist = data->hist[cpu].thread;
+		data->hist[cpu].thread_count++;
+		update_min(&data->hist[cpu].min_thread, &latency);
+		update_sum(&data->hist[cpu].sum_thread, &latency);
+		update_max(&data->hist[cpu].max_thread, &latency);
+	}
+
+	if (bucket < entries)
+		hist[bucket]++;
+	else
+		hist[entries]++;
+}
+
+/*
+ * timerlat_hist_handler - this is the handler for timerlat tracer events
+ */
+static int
+timerlat_hist_handler(struct trace_seq *s, struct tep_record *record,
+		     struct tep_event *event, void *data)
+{
+	struct trace_instance *trace = data;
+	unsigned long long thread, latency;
+	struct osnoise_tool *tool;
+	int cpu = record->cpu;
+
+	tool = container_of(trace, struct osnoise_tool, trace);
+
+	tep_get_field_val(s, event, "context", record, &thread, 1);
+	tep_get_field_val(s, event, "timer_latency", record, &latency, 1);
+
+	timerlat_hist_update(tool, cpu, thread, latency);
+
+	return 0;
+}
+
+/*
+ * timerlat_hist_header - print the header of the tracer to the output
+ */
+static void timerlat_hist_header(struct osnoise_tool *tool)
+{
+	struct timerlat_hist_params *params = tool->params;
+	struct timerlat_hist_data *data = tool->data;
+	struct trace_seq *s = tool->trace.seq;
+	char duration[26];
+	int cpu;
+
+	if (params->no_header)
+		return;
+
+	get_duration(tool->start_time, duration, sizeof(duration));
+	trace_seq_printf(s, "# RTLA timerlat histogram\n");
+	trace_seq_printf(s, "# Time unit is %s (%s)\n",
+			params->output_divisor == 1 ? "nanoseconds" : "microseconds",
+			params->output_divisor == 1 ? "ns" : "us");
+
+	trace_seq_printf(s, "# Duration: %s\n", duration);
+
+	if (!params->no_index)
+		trace_seq_printf(s, "Index");
+
+	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
+		if (params->cpus && !params->monitored_cpus[cpu])
+			continue;
+
+		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
+			continue;
+
+		if (!params->no_irq)
+			trace_seq_printf(s, "   IRQ-%03d", cpu);
+
+		if (!params->no_thread)
+			trace_seq_printf(s, "   Thr-%03d", cpu);
+	}
+	trace_seq_printf(s, "\n");
+
+
+	trace_seq_do_printf(s);
+	trace_seq_reset(s);
+}
+
+/*
+ * timerlat_print_summary - print the summary of the hist data to the output
+ */
+static void
+timerlat_print_summary(struct timerlat_hist_params *params,
+		       struct trace_instance *trace,
+		       struct timerlat_hist_data *data)
+{
+	int cpu;
+
+	if (params->no_summary)
+		return;
+
+	if (!params->no_index)
+		trace_seq_printf(trace->seq, "count:");
+
+	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
+		if (params->cpus && !params->monitored_cpus[cpu])
+			continue;
+
+		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
+			continue;
+
+		if (!params->no_irq)
+			trace_seq_printf(trace->seq, "%9d ",
+					data->hist[cpu].irq_count);
+
+		if (!params->no_thread)
+			trace_seq_printf(trace->seq, "%9d ",
+					data->hist[cpu].thread_count);
+	}
+	trace_seq_printf(trace->seq, "\n");
+
+	if (!params->no_index)
+		trace_seq_printf(trace->seq, "min:  ");
+
+	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
+		if (params->cpus && !params->monitored_cpus[cpu])
+			continue;
+
+		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
+			continue;
+
+		if (!params->no_irq)
+			trace_seq_printf(trace->seq, "%9llu ",
+					data->hist[cpu].min_irq);
+
+		if (!params->no_thread)
+			trace_seq_printf(trace->seq, "%9llu ",
+					data->hist[cpu].min_thread);
+	}
+	trace_seq_printf(trace->seq, "\n");
+
+	if (!params->no_index)
+		trace_seq_printf(trace->seq, "avg:  ");
+
+	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
+		if (params->cpus && !params->monitored_cpus[cpu])
+			continue;
+
+		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
+			continue;
+
+		if (!params->no_irq) {
+			if (data->hist[cpu].irq_count)
+				trace_seq_printf(trace->seq, "%9llu ",
+						 data->hist[cpu].sum_irq / data->hist[cpu].irq_count);
+			else
+				trace_seq_printf(trace->seq, "        - ");
+		}
+
+		if (!params->no_thread) {
+			if (data->hist[cpu].thread_count)
+				trace_seq_printf(trace->seq, "%9llu ",
+						data->hist[cpu].sum_thread / data->hist[cpu].thread_count);
+			else
+				trace_seq_printf(trace->seq, "        - ");
+		}
+	}
+	trace_seq_printf(trace->seq, "\n");
+
+	if (!params->no_index)
+		trace_seq_printf(trace->seq, "max:  ");
+
+	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
+		if (params->cpus && !params->monitored_cpus[cpu])
+			continue;
+
+		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
+			continue;
+
+		if (!params->no_irq)
+			trace_seq_printf(trace->seq, "%9llu ",
+					data->hist[cpu].max_irq);
+
+		if (!params->no_thread)
+			trace_seq_printf(trace->seq, "%9llu ",
+					data->hist[cpu].max_thread);
+	}
+	trace_seq_printf(trace->seq, "\n");
+	trace_seq_do_printf(trace->seq);
+	trace_seq_reset(trace->seq);
+}
+
+/*
+ * timerlat_print_stats - print data for all CPUs
+ */
+static void
+timerlat_print_stats(struct timerlat_hist_params *params, struct osnoise_tool *tool)
+{
+	struct timerlat_hist_data *data = tool->data;
+	struct trace_instance *trace = &tool->trace;
+	int bucket, cpu;
+	int total;
+
+	timerlat_hist_header(tool);
+
+	for (bucket = 0; bucket < data->entries; bucket++) {
+		total = 0;
+
+		if (!params->no_index)
+			trace_seq_printf(trace->seq, "%-6d",
+					 bucket * data->bucket_size);
+
+		for (cpu = 0; cpu < data->nr_cpus; cpu++) {
+			if (params->cpus && !params->monitored_cpus[cpu])
+				continue;
+
+			if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
+				continue;
+
+			if (!params->no_irq) {
+				total += data->hist[cpu].irq[bucket];
+				trace_seq_printf(trace->seq, "%9d ",
+						data->hist[cpu].irq[bucket]);
+			}
+
+			if (!params->no_thread) {
+				total += data->hist[cpu].thread[bucket];
+				trace_seq_printf(trace->seq, "%9d ",
+						data->hist[cpu].thread[bucket]);
+			}
+
+		}
+
+		if (total == 0 && !params->with_zeros) {
+			trace_seq_reset(trace->seq);
+			continue;
+		}
+
+		trace_seq_printf(trace->seq, "\n");
+		trace_seq_do_printf(trace->seq);
+		trace_seq_reset(trace->seq);
+	}
+
+	if (!params->no_index)
+		trace_seq_printf(trace->seq, "over: ");
+
+	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
+		if (params->cpus && !params->monitored_cpus[cpu])
+			continue;
+
+		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
+			continue;
+
+		if (!params->no_irq)
+			trace_seq_printf(trace->seq, "%9d ",
+					 data->hist[cpu].irq[data->entries]);
+
+		if (!params->no_thread)
+			trace_seq_printf(trace->seq, "%9d ",
+					 data->hist[cpu].thread[data->entries]);
+	}
+	trace_seq_printf(trace->seq, "\n");
+	trace_seq_do_printf(trace->seq);
+	trace_seq_reset(trace->seq);
+
+	timerlat_print_summary(params, trace, data);
+}
+
+/*
+ * timerlat_hist_usage - prints timerlat top usage message
+ */
+static void timerlat_hist_usage(char *usage)
+{
+	int i;
+
+	char *msg[] = {
+		"",
+		"  usage: [rtla] timerlat hist [-h] [-q] [-p us] [-i us] [-t us] [-s us] [-T[=file]] \\",
+		"         [-c cpu-list] [-P priority] [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
+		"         [--no-index] [--with-zeros]",
+		"",
+		"	  -h/--help: print this menu",
+		"	  -p/--period us: timerlat period in us",
+		"	  -i/--irq us: stop trace if the irq latency is higher than the argument in us",
+		"	  -T/--thread us: stop trace if the thread latency is higher than the argument in us",
+		"	  -s/--stack us: save the stack trace at the IRQ if a thread latency is higher than the argument in us",
+		"	  -c/--cpus cpus: run the tracer only on the given cpus",
+		"	  -d/--duration time[m|h|d]: duration of the session in seconds",
+		"	  -T/--trace[=file]: save the stopped trace to [file|timerlat_trace.txt]",
+		"	  -n/--nano: display data in nanoseconds",
+		"	  -b/--bucket-size N: set the histogram bucket size (default 1)",
+		"	  -e/--entries N: set the number of entries of the histogram (default 256)",
+		"	     --no-irq: ignore IRQ latencies",
+		"	     --no-thread: ignore thread latencies",
+		"	     --no-header: do not print header",
+		"	     --no-summary: do not print summary",
+		"	     --no-index: do not print index",
+		"	     --with-zeros: print zero only entries",
+		"	  -P/--priority o:prio|r:prio|f:prio|d:runtime:period : set scheduling parameters",
+		"		o:prio - use SCHED_OTHER with prio",
+		"		r:prio - use SCHED_RR with prio",
+		"		f:prio - use SCHED_FIFO with prio",
+		"		d:runtime[us|ms|s]:period[us|ms|s] - use SCHED_DEADLINE with runtime and period",
+		"						       in nanoseconds",
+		NULL,
+	};
+
+	if (usage)
+		fprintf(stderr, "%s\n", usage);
+
+	fprintf(stderr, "rtla timerlat hist: a per-cpu histogram of the timer latency (version %s)\n",
+			VERSION);
+
+	for (i = 0; msg[i]; i++)
+		fprintf(stderr, "%s\n", msg[i]);
+	exit(1);
+}
+
+/*
+ * timerlat_hist_parse_args - allocs, parse and fill the cmd line parameters
+ */
+static struct timerlat_hist_params
+*timerlat_hist_parse_args(int argc, char *argv[])
+{
+	struct timerlat_hist_params *params;
+	int retval;
+	int c;
+
+	params = calloc(1, sizeof(*params));
+	if (!params)
+		exit(1);
+
+	/* display data in microseconds */
+	params->output_divisor = 1000;
+	params->bucket_size = 1;
+	params->entries = 256;
+
+	while (1) {
+		static struct option long_options[] = {
+			{"cpus",		required_argument,	0, 'c'},
+			{"bucket-size",		required_argument,	0, 'b'},
+			{"debug",		no_argument,		0, 'D'},
+			{"entries",		required_argument,	0, 'e'},
+			{"duration",		required_argument,	0, 'd'},
+			{"help",		no_argument,		0, 'h'},
+			{"irq",			required_argument,	0, 'i'},
+			{"nano",		no_argument,		0, 'n'},
+			{"period",		required_argument,	0, 'p'},
+			{"priority",		required_argument,	0, 'P'},
+			{"stack",		required_argument,	0, 's'},
+			{"thread",		required_argument,	0, 'T'},
+			{"trace",		optional_argument,	0, 't'},
+			{"no-irq",		no_argument,		0, '0'},
+			{"no-thread",		no_argument,		0, '1'},
+			{"no-header",		no_argument,		0, '2'},
+			{"no-summary",		no_argument,		0, '3'},
+			{"no-index",		no_argument,		0, '4'},
+			{"with-zeros",		no_argument,		0, '5'},
+			{0, 0, 0, 0}
+		};
+
+		/* getopt_long stores the option index here. */
+		int option_index = 0;
+
+		c = getopt_long(argc, argv, "c:b:d:e:Dhi:np:P:s:t::T:012345",
+				 long_options, &option_index);
+
+		/* detect the end of the options. */
+		if (c == -1)
+			break;
+
+		switch (c) {
+		case 'c':
+			retval = parse_cpu_list(optarg, &params->monitored_cpus);
+			if (retval)
+				timerlat_hist_usage("\nInvalid -c cpu list\n");
+			params->cpus = optarg;
+			debug_msg("-c for %s\n", params->cpus);
+			break;
+		case 'b':
+			params->bucket_size = get_llong_from_str(optarg);
+			if ((params->bucket_size == 0) || (params->bucket_size >= 1000000))
+				timerlat_hist_usage("Bucket size needs to be > 0 and <= 1000000\n");
+			break;
+		case 'D':
+			config_debug = 1;
+			break;
+		case 'd':
+			params->duration = parse_seconds_duration(optarg);
+			if (!params->duration)
+				timerlat_hist_usage("Invalid -D duration\n");
+			break;
+		case 'e':
+			params->entries = get_llong_from_str(optarg);
+			if ((params->entries < 10) || (params->entries > 9999999))
+					timerlat_hist_usage("Entries must be > 10 and < 9999999\n");
+			break;
+		case 'h':
+		case '?':
+			timerlat_hist_usage(NULL);
+			break;
+		case 'i':
+			params->stop_us = get_llong_from_str(optarg);
+			break;
+		case 'n':
+			params->output_divisor = 1;
+			break;
+		case 'p':
+			params->timerlat_period_us = get_llong_from_str(optarg);
+			if (params->timerlat_period_us > 1000000)
+				timerlat_hist_usage("Period longer than 1 s\n");
+			break;
+		case 'P':
+			retval = parse_prio(optarg, &params->sched_param);
+			if (retval == -1)
+				timerlat_hist_usage("Invalid -P priority");
+			params->set_sched = 1;
+			break;
+		case 's':
+			params->print_stack = get_llong_from_str(optarg);
+			break;
+		case 'T':
+			params->stop_total_us = get_llong_from_str(optarg);
+			break;
+		case 't':
+			if (optarg)
+				/* skip = */
+				params->trace_output = &optarg[1];
+			else
+				params->trace_output = "timerlat_trace.txt";
+			break;
+		case '0': /* no irq */
+			params->no_irq = 1;
+			break;
+		case '1': /* no thread */
+			params->no_thread = 1;
+			break;
+		case '2': /* no header */
+			params->no_header = 1;
+			break;
+		case '3': /* no summary */
+			params->no_summary = 1;
+			break;
+		case '4': /* no index */
+			params->no_index = 1;
+			break;
+		case '5': /* with zeros */
+			params->with_zeros = 1;
+			break;
+		default:
+			timerlat_hist_usage("Invalid option");
+		}
+	}
+
+	if (geteuid()) {
+		err_msg("rtla needs root permission\n");
+		exit(EXIT_FAILURE);
+	}
+
+	if (params->no_irq && params->no_thread)
+		timerlat_hist_usage("no-irq and no-thread set, there is nothing to do here");
+
+	if (params->no_index && !params->with_zeros)
+		timerlat_hist_usage("no-index set with with-zeros is not set - it does not make sense");
+
+	return params;
+}
+
+/*
+ * timerlat_hist_apply_config - apply the hist configs to the initialized tool
+ */
+static int
+timerlat_hist_apply_config(struct osnoise_tool *tool, struct timerlat_hist_params *params)
+{
+	int retval;
+
+	if (!params->sleep_time)
+		params->sleep_time = 1;
+
+	if (params->cpus) {
+		retval = osnoise_set_cpus(tool->context, params->cpus);
+		if (retval) {
+			err_msg("Failed to apply CPUs config\n");
+			goto out_err;
+		}
+	}
+
+	if (params->stop_us) {
+		retval = osnoise_set_stop_us(tool->context, params->stop_us);
+		if (retval) {
+			err_msg("Failed to set stop us\n");
+			goto out_err;
+		}
+	}
+
+	if (params->stop_total_us) {
+		retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
+		if (retval) {
+			err_msg("Failed to set stop total us\n");
+			goto out_err;
+		}
+	}
+
+	if (params->timerlat_period_us) {
+		retval = osnoise_set_timerlat_period_us(tool->context, params->timerlat_period_us);
+		if (retval) {
+			err_msg("Failed to set timerlat period\n");
+			goto out_err;
+		}
+	}
+
+	if (params->print_stack) {
+		retval = osnoise_set_print_stack(tool->context, params->print_stack);
+		if (retval) {
+			err_msg("Failed to set print stack\n");
+			goto out_err;
+		}
+	}
+
+	return 0;
+
+out_err:
+	return -1;
+}
+
+/*
+ * timerlat_init_hist - initialize a timerlat hist tool with parameters
+ */
+static struct osnoise_tool
+*timerlat_init_hist(struct timerlat_hist_params *params)
+{
+	struct osnoise_tool *tool;
+	int nr_cpus;
+
+	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+
+	tool = osnoise_init_tool("timerlat_hist");
+	if (!tool)
+		return NULL;
+
+	tool->data = timerlat_alloc_histogram(nr_cpus, params->entries, params->bucket_size);
+	if (!tool->data)
+		goto out_err;
+
+	tool->params = params;
+
+	tep_register_event_handler(tool->trace.tep, -1, "ftrace", "timerlat",
+				   timerlat_hist_handler, tool);
+
+	return tool;
+
+out_err:
+	osnoise_destroy_tool(tool);
+	return NULL;
+}
+
+static int stop_tracing;
+static void stop_hist(int sig)
+{
+	stop_tracing = 1;
+}
+
+/*
+ * timerlat_hist_set_signals - handles the signal to stop the tool
+ */
+static void
+timerlat_hist_set_signals(struct timerlat_hist_params *params)
+{
+	signal(SIGINT, stop_hist);
+	if (params->duration) {
+		signal(SIGALRM, stop_hist);
+		alarm(params->duration);
+	}
+}
+
+int timerlat_hist_main(int argc, char *argv[])
+{
+	struct timerlat_hist_params *params;
+	struct trace_instance *trace;
+	struct osnoise_tool *record;
+	struct osnoise_tool *tool;
+	int return_value = 1;
+	int retval;
+
+	params = timerlat_hist_parse_args(argc, argv);
+	if (!params)
+		exit(1);
+
+	tool = timerlat_init_hist(params);
+	if (!tool) {
+		err_msg("Could not init osnoise hist\n");
+		goto out_exit;
+	}
+
+	retval = timerlat_hist_apply_config(tool, params);
+	if (retval) {
+		err_msg("Could not apply config\n");
+		goto out_hist;
+	}
+
+	trace = &tool->trace;
+
+	retval = enable_timerlat(trace);
+	if (retval) {
+		err_msg("Failed to enable timerlat tracer\n");
+		goto out_hist;
+	}
+
+	if (params->set_sched) {
+		retval = set_comm_sched_attr("timerlat/", &params->sched_param);
+		if (retval)
+			timerlat_hist_usage("Failed to set sched parameters\n");
+	}
+
+	trace_instance_start(trace);
+
+	if (params->trace_output) {
+		record = osnoise_init_trace_tool("timerlat");
+		if (!record) {
+			err_msg("Failed to enable the trace instance\n");
+			goto out_hist;
+		}
+		trace_instance_start(&record->trace);
+	}
+
+	tool->start_time = time(NULL);
+	timerlat_hist_set_signals(params);
+
+	while (!stop_tracing) {
+		sleep(params->sleep_time);
+
+		retval = tracefs_iterate_raw_events(trace->tep,
+						    trace->inst,
+						    NULL,
+						    0,
+						    collect_registered_events,
+						    trace);
+		if (retval < 0) {
+			err_msg("Error iterating on events\n");
+			goto out_hist;
+		}
+
+		if (!tracefs_trace_is_on(trace->inst))
+			break;
+	};
+
+	timerlat_print_stats(params, tool);
+
+	return_value = 0;
+
+	if (!tracefs_trace_is_on(trace->inst)) {
+		printf("rtla timelat hit stop tracing\n");
+		if (params->trace_output) {
+			printf("  Saving trace to %s\n", params->trace_output);
+			save_trace_to_file(record->trace.inst, params->trace_output);
+		}
+	}
+
+out_hist:
+	timerlat_free_histogram(tool->data);
+	osnoise_destroy_tool(tool);
+	if (params->trace_output)
+		osnoise_destroy_tool(record);
+	free(params);
+out_exit:
+	exit(return_value);
+}
-- 
2.33.0
