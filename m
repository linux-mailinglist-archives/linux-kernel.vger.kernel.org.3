Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB774613A2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377604AbhK2LOu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Nov 2021 06:14:50 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:35886 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235669AbhK2LMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:12:17 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-9YI-QdXfNNOWiq1XKukqTg-1; Mon, 29 Nov 2021 06:08:56 -0500
X-MC-Unique: 9YI-QdXfNNOWiq1XKukqTg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAC681054F90;
        Mon, 29 Nov 2021 11:08:54 +0000 (UTC)
Received: from x1.com (unknown [10.22.8.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF1AB5DF21;
        Mon, 29 Nov 2021 11:08:51 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tao Zhou <tao.zhou@linux.dev>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
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
Subject: [PATCH V8 06/14] rtla: Add timerlat tool and timelart top mode
Date:   Mon, 29 Nov 2021 12:07:44 +0100
Message-Id: <e65a6899bbde6ecb129cfaf55e402d785ad124eb.1638182284.git.bristot@kernel.org>
In-Reply-To: <cover.1638182284.git.bristot@kernel.org>
References: <cover.1638182284.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtla timerlat tool is an interface for the timerlat tracer.
The timerlat tracer dispatches a kernel thread per-cpu. These threads set a
periodic timer to wake themselves up and go back to sleep. After the
wakeup, they collect and generate useful information for the debugging of
operating system timer latency.

The timerlat tracer outputs information in two ways. It periodically
prints the timer latency at the timer IRQ handler and the Thread handler.
It also provides information for each noise via the osnoise tracepoints.

The rtla timerlat top mode displays a summary of the periodic output from
the timerlat tracer.

Here is one example of the rtla timerlat tool output:
 ---------- %< ----------
[root@alien ~]# rtla timerlat top -c 0-3 -d 1m
                                     Timer Latency
  0 00:01:00   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
  0 #60001     |        0         0         0         3 |        1         1         1         6
  1 #60001     |        0         0         0         3 |        2         1         1         5
  2 #60001     |        0         0         1         6 |        1         1         2         7
  3 #60001     |        0         0         0         7 |        1         1         1        11
 ---------- >% ----------

Running:
  # rtla timerlat --help
  # rtla timerlat top --help
provides information about the available options.

Cc: Steven Rostedt <rostedt@goodmis.org>
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
---
 tools/tracing/rtla/Makefile           |   2 +
 tools/tracing/rtla/src/rtla.c         |   5 +
 tools/tracing/rtla/src/timerlat.c     |  68 +++
 tools/tracing/rtla/src/timerlat.h     |   4 +
 tools/tracing/rtla/src/timerlat_top.c | 615 ++++++++++++++++++++++++++
 5 files changed, 694 insertions(+)
 create mode 100644 tools/tracing/rtla/src/timerlat.c
 create mode 100644 tools/tracing/rtla/src/timerlat.h
 create mode 100644 tools/tracing/rtla/src/timerlat_top.c

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index ba6f327e815a..f254cfbe4fa3 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -62,6 +62,8 @@ install:
 	$(STRIP) $(DESTDIR)$(BINDIR)/rtla
 	@test ! -f $(DESTDIR)$(BINDIR)/osnoise || rm $(DESTDIR)$(BINDIR)/osnoise
 	ln -s $(DESTDIR)$(BINDIR)/rtla $(DESTDIR)$(BINDIR)/osnoise
+	@test ! -f $(DESTDIR)$(BINDIR)/timerlat || rm $(DESTDIR)$(BINDIR)/timerlat
+	ln -s $(DESTDIR)$(BINDIR)/rtla $(DESTDIR)$(BINDIR)/timerlat
 
 .PHONY: clean tarball
 clean:
diff --git a/tools/tracing/rtla/src/rtla.c b/tools/tracing/rtla/src/rtla.c
index 669b9750b3b3..09bd21b8af81 100644
--- a/tools/tracing/rtla/src/rtla.c
+++ b/tools/tracing/rtla/src/rtla.c
@@ -9,6 +9,7 @@
 #include <stdio.h>
 
 #include "osnoise.h"
+#include "timerlat.h"
 
 /*
  * rtla_usage - print rtla usage
@@ -25,6 +26,7 @@ static void rtla_usage(void)
 		"",
 		"  commands:",
 		"     osnoise  - gives information about the operating system noise (osnoise)",
+		"     timerlat - measures the timer irq and thread latency",
 		"",
 		NULL,
 	};
@@ -45,6 +47,9 @@ int run_command(int argc, char **argv, int start_position)
 	if (strcmp(argv[start_position], "osnoise") == 0) {
 		osnoise_main(argc-start_position, &argv[start_position]);
 		goto ran;
+	} else if (strcmp(argv[start_position], "timerlat") == 0) {
+		timerlat_main(argc-start_position, &argv[start_position]);
+		goto ran;
 	}
 
 	return 0;
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
new file mode 100644
index 000000000000..29a51c01b084
--- /dev/null
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
+ */
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <pthread.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+
+#include "timerlat.h"
+
+static void timerlat_usage(void)
+{
+	int i;
+
+	static const char * const msg[] = {
+		"",
+		"timerlat version " VERSION,
+		"",
+		"  usage: [rtla] timerlat [MODE] ...",
+		"",
+		"  modes:",
+		"     top  - prints the summary from timerlat tracer",
+		"",
+		"if no MODE is given, the top mode is called, passing the arguments",
+		NULL,
+	};
+
+	for (i = 0; msg[i]; i++)
+		fprintf(stderr, "%s\n", msg[i]);
+	exit(1);
+}
+
+int timerlat_main(int argc, char *argv[])
+{
+	if (argc == 0)
+		goto usage;
+
+	/*
+	 * if timerlat was called without any argument, run the
+	 * default cmdline.
+	 */
+	if (argc == 1) {
+		timerlat_top_main(argc, argv);
+		exit(0);
+	}
+
+	if ((strcmp(argv[1], "-h") == 0) || (strcmp(argv[1], "--help") == 0)) {
+		timerlat_usage();
+		exit(0);
+	} else if (strncmp(argv[1], "-", 1) == 0) {
+		/* the user skipped the tool, call the default one */
+		timerlat_top_main(argc, argv);
+		exit(0);
+	} else if (strcmp(argv[1], "top") == 0) {
+		timerlat_top_main(argc-1, &argv[1]);
+		exit(0);
+	}
+
+usage:
+	timerlat_usage();
+	exit(1);
+}
diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
new file mode 100644
index 000000000000..6f9d3925acd0
--- /dev/null
+++ b/tools/tracing/rtla/src/timerlat.h
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+
+int timerlat_top_main(int argc, char *argv[]);
+int timerlat_main(int argc, char *argv[]);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
new file mode 100644
index 000000000000..9764681ad8b1
--- /dev/null
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -0,0 +1,615 @@
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
+struct timerlat_top_params {
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
+	int			quiet;
+	int			set_sched;
+	struct sched_attr	sched_param;
+};
+
+struct timerlat_top_cpu {
+	int			irq_count;
+	int			thread_count;
+
+	unsigned long long	cur_irq;
+	unsigned long long	min_irq;
+	unsigned long long	sum_irq;
+	unsigned long long	max_irq;
+
+	unsigned long long	cur_thread;
+	unsigned long long	min_thread;
+	unsigned long long	sum_thread;
+	unsigned long long	max_thread;
+};
+
+struct timerlat_top_data {
+	struct timerlat_top_cpu	*cpu_data;
+	int			nr_cpus;
+};
+
+/*
+ * timerlat_free_top - free runtime data
+ */
+static void
+timerlat_free_top(struct timerlat_top_data *data)
+{
+	free(data->cpu_data);
+	free(data);
+}
+
+/*
+ * timerlat_alloc_histogram - alloc runtime data
+ */
+static struct timerlat_top_data *timerlat_alloc_top(int nr_cpus)
+{
+	struct timerlat_top_data *data;
+	int cpu;
+
+	data = calloc(1, sizeof(*data));
+	if (!data)
+		return NULL;
+
+	data->nr_cpus = nr_cpus;
+
+	/* one set of histograms per CPU */
+	data->cpu_data = calloc(1, sizeof(*data->cpu_data) * nr_cpus);
+	if (!data->cpu_data)
+		goto cleanup;
+
+	/* set the min to max */
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		data->cpu_data[cpu].min_irq = ~0;
+		data->cpu_data[cpu].min_thread = ~0;
+	}
+
+	return data;
+
+cleanup:
+	timerlat_free_top(data);
+	return NULL;
+}
+
+/*
+ * timerlat_hist_update - record a new timerlat occurent on cpu, updating data
+ */
+static void
+timerlat_top_update(struct osnoise_tool *tool, int cpu,
+		    unsigned long long thread,
+		    unsigned long long latency)
+{
+	struct timerlat_top_data *data = tool->data;
+	struct timerlat_top_cpu *cpu_data = &data->cpu_data[cpu];
+
+	if (!thread) {
+		cpu_data->irq_count++;
+		cpu_data->cur_irq = latency;
+		update_min(&cpu_data->min_irq, &latency);
+		update_sum(&cpu_data->sum_irq, &latency);
+		update_max(&cpu_data->max_irq, &latency);
+	} else {
+		cpu_data->thread_count++;
+		cpu_data->cur_thread = latency;
+		update_min(&cpu_data->min_thread, &latency);
+		update_sum(&cpu_data->sum_thread, &latency);
+		update_max(&cpu_data->max_thread, &latency);
+	}
+}
+
+/*
+ * timerlat_top_handler - this is the handler for timerlat tracer events
+ */
+static int
+timerlat_top_handler(struct trace_seq *s, struct tep_record *record,
+		     struct tep_event *event, void *context)
+{
+	struct trace_instance *trace = context;
+	unsigned long long latency, thread;
+	struct osnoise_tool *top;
+	int cpu = record->cpu;
+
+	top = container_of(trace, struct osnoise_tool, trace);
+
+	tep_get_field_val(s, event, "context", record, &thread, 1);
+	tep_get_field_val(s, event, "timer_latency", record, &latency, 1);
+
+	timerlat_top_update(top, cpu, thread, latency);
+
+	return 0;
+}
+
+/*
+ * timerlat_top_header - print the header of the tool output
+ */
+static void timerlat_top_header(struct osnoise_tool *top)
+{
+	struct timerlat_top_params *params = top->params;
+	struct trace_seq *s = top->trace.seq;
+	char duration[26];
+
+	get_duration(top->start_time, duration, sizeof(duration));
+
+	trace_seq_printf(s, "\033[2;37;40m");
+	trace_seq_printf(s, "                                     Timer Latency                                              ");
+	trace_seq_printf(s, "\033[0;0;0m");
+	trace_seq_printf(s, "\n");
+
+	trace_seq_printf(s, "%-6s   |          IRQ Timer Latency (%s)        |         Thread Timer Latency (%s)\n", duration,
+			params->output_divisor == 1 ? "ns" : "us",
+			params->output_divisor == 1 ? "ns" : "us");
+
+	trace_seq_printf(s, "\033[2;30;47m");
+	trace_seq_printf(s, "CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max");
+	trace_seq_printf(s, "\033[0;0;0m");
+	trace_seq_printf(s, "\n");
+}
+
+/*
+ * timerlat_top_print - prints the output of a given CPU
+ */
+static void timerlat_top_print(struct osnoise_tool *top, int cpu)
+{
+
+	struct timerlat_top_params *params = top->params;
+	struct timerlat_top_data *data = top->data;
+	struct timerlat_top_cpu *cpu_data = &data->cpu_data[cpu];
+	int divisor = params->output_divisor;
+	struct trace_seq *s = top->trace.seq;
+
+	if (divisor == 0)
+		return;
+
+	/*
+	 * Skip if no data is available: is this cpu offline?
+	 */
+	if (!cpu_data->irq_count && !cpu_data->thread_count)
+		return;
+
+	/*
+	 * Unless trace is being lost, IRQ counter is always the max.
+	 */
+	trace_seq_printf(s, "%3d #%-9d |", cpu, cpu_data->irq_count);
+
+	if (!cpu_data->irq_count) {
+		trace_seq_printf(s, "        - ");
+		trace_seq_printf(s, "        - ");
+		trace_seq_printf(s, "        - ");
+		trace_seq_printf(s, "        - |");
+	} else {
+		trace_seq_printf(s, "%9llu ", cpu_data->cur_irq / params->output_divisor);
+		trace_seq_printf(s, "%9llu ", cpu_data->min_irq / params->output_divisor);
+		trace_seq_printf(s, "%9llu ", (cpu_data->sum_irq / cpu_data->irq_count) / divisor);
+		trace_seq_printf(s, "%9llu |", cpu_data->max_irq / divisor);
+	}
+
+	if (!cpu_data->thread_count) {
+		trace_seq_printf(s, "        - ");
+		trace_seq_printf(s, "        - ");
+		trace_seq_printf(s, "        - ");
+		trace_seq_printf(s, "        -\n");
+	} else {
+		trace_seq_printf(s, "%9llu ", cpu_data->cur_thread / divisor);
+		trace_seq_printf(s, "%9llu ", cpu_data->min_thread / divisor);
+		trace_seq_printf(s, "%9llu ",
+				(cpu_data->sum_thread / cpu_data->thread_count) / divisor);
+		trace_seq_printf(s, "%9llu\n", cpu_data->max_thread / divisor);
+	}
+}
+
+/*
+ * clear_terminal - clears the output terminal
+ */
+static void clear_terminal(struct trace_seq *seq)
+{
+	if (!config_debug)
+		trace_seq_printf(seq, "\033c");
+}
+
+/*
+ * timerlat_print_stats - print data for all cpus
+ */
+static void
+timerlat_print_stats(struct timerlat_top_params *params, struct osnoise_tool *top)
+{
+	struct trace_instance *trace = &top->trace;
+	static int nr_cpus = -1;
+	int i;
+
+	if (nr_cpus == -1)
+		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+
+	if (!params->quiet)
+		clear_terminal(trace->seq);
+
+	timerlat_top_header(top);
+
+	for (i = 0; i < nr_cpus; i++) {
+		if (params->cpus && !params->monitored_cpus[i])
+			continue;
+		timerlat_top_print(top, i);
+	}
+
+	trace_seq_do_printf(trace->seq);
+	trace_seq_reset(trace->seq);
+}
+
+/*
+ * timerlat_top_usage - prints timerlat top usage message
+ */
+static void timerlat_top_usage(char *usage)
+{
+	int i;
+
+	static const char *const msg[] = {
+		"",
+		"  usage: rtla timerlat [top] [-h] [-q] [-p us] [-i us] [-t us] [-s us] [-T[=file]] \\",
+		"	  [-c cpu-list] [-P priority]",
+		"",
+		"	  -h/--help: print this menu",
+		"	  -p/--period us: timerlat period in us",
+		"	  -i/--irq us: stop trace if the irq latency is higher than the argument in us",
+		"	  -T/--thread us: stop trace if the thread latency is higher than the argument in us",
+		"	  -s/--stack us: save the stack trace at the IRQ if a thread latency is higher than the argument in us",
+		"	  -c/--cpus cpus: run the tracer only on the given cpus	  -d/--duration time[m|h|d]: duration of the session in seconds",
+		"	  -t/--trace[=file]: save the stopped trace to [file|timerlat_trace.txt]",
+		"	  -n/--nano: display data in nanoseconds",
+		"	  -q/--quiet print only a summary at the end",
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
+	fprintf(stderr, "rtla timerlat top: a per-cpu summary of the timer latency (version %s)\n",
+			VERSION);
+
+	for (i = 0; msg[i]; i++)
+		fprintf(stderr, "%s\n", msg[i]);
+	exit(1);
+}
+
+/*
+ * timerlat_top_parse_args - allocs, parse and fill the cmd line parameters
+ */
+static struct timerlat_top_params
+*timerlat_top_parse_args(int argc, char **argv)
+{
+	struct timerlat_top_params *params;
+	int retval;
+	int c;
+
+	params = calloc(1, sizeof(*params));
+	if (!params)
+		exit(1);
+
+	/* display data in microseconds */
+	params->output_divisor = 1000;
+
+	while (1) {
+		static struct option long_options[] = {
+			{"cpus",		required_argument,	0, 'c'},
+			{"debug",		no_argument,		0, 'D'},
+			{"duration",		required_argument,	0, 'd'},
+			{"help",		no_argument,		0, 'h'},
+			{"irq",			required_argument,	0, 'i'},
+			{"nano",		no_argument,		0, 'n'},
+			{"period",		required_argument,	0, 'p'},
+			{"priority",		required_argument,	0, 'P'},
+			{"quiet",		no_argument,		0, 'q'},
+			{"stack",		required_argument,	0, 's'},
+			{"thread",		required_argument,	0, 'T'},
+			{"trace",		optional_argument,	0, 't'},
+			{0, 0, 0, 0}
+		};
+
+		/* getopt_long stores the option index here. */
+		int option_index = 0;
+
+		c = getopt_long(argc, argv, "c:d:Dhi:np:P:qs:t::T:",
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
+				timerlat_top_usage("\nInvalid -c cpu list\n");
+			params->cpus = optarg;
+			debug_msg("-c for %s\n", params->cpus);
+			break;
+		case 'D':
+			config_debug = 1;
+			break;
+		case 'd':
+			params->duration = parse_seconds_duration(optarg);
+			if (!params->duration)
+				timerlat_top_usage("Invalid -D duration\n");
+			break;
+		case 'h':
+		case '?':
+			timerlat_top_usage(NULL);
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
+				timerlat_top_usage("Period longer than 1 s\n");
+			break;
+		case 'P':
+			retval = parse_prio(optarg, &params->sched_param);
+			if (retval == -1)
+				timerlat_top_usage("Invalid -P priority");
+			params->set_sched = 1;
+			break;
+		case 'q':
+			params->quiet = 1;
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
+		default:
+			timerlat_top_usage("Invalid option");
+		}
+	}
+
+	if (geteuid()) {
+		err_msg("rtla needs root permission\n");
+		exit(EXIT_FAILURE);
+	}
+
+	return params;
+}
+
+/*
+ * timerlat_top_apply_config - apply the top configs to the initialized tool
+ */
+static int
+timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_top_params *params)
+{
+	int retval;
+
+	if (!params->sleep_time)
+		params->sleep_time = 1;
+
+	if (params->cpus) {
+		retval = osnoise_set_cpus(top->context, params->cpus);
+		if (retval) {
+			err_msg("Failed to apply CPUs config\n");
+			goto out_err;
+		}
+	}
+
+	if (params->stop_us) {
+		retval = osnoise_set_stop_us(top->context, params->stop_us);
+		if (retval) {
+			err_msg("Failed to set stop us\n");
+			goto out_err;
+		}
+	}
+
+	if (params->stop_total_us) {
+		retval = osnoise_set_stop_total_us(top->context, params->stop_total_us);
+		if (retval) {
+			err_msg("Failed to set stop total us\n");
+			goto out_err;
+		}
+	}
+
+
+	if (params->timerlat_period_us) {
+		retval = osnoise_set_timerlat_period_us(top->context, params->timerlat_period_us);
+		if (retval) {
+			err_msg("Failed to set timerlat period\n");
+			goto out_err;
+		}
+	}
+
+
+	if (params->print_stack) {
+		retval = osnoise_set_print_stack(top->context, params->print_stack);
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
+ * timerlat_init_top - initialize a timerlat top tool with parameters
+ */
+static struct osnoise_tool
+*timerlat_init_top(struct timerlat_top_params *params)
+{
+	struct osnoise_tool *top;
+	int nr_cpus;
+
+	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+
+	top = osnoise_init_tool("timerlat_top");
+	if (!top)
+		return NULL;
+
+	top->data = timerlat_alloc_top(nr_cpus);
+	if (!top->data)
+		goto out_err;
+
+	top->params = params;
+
+	tep_register_event_handler(top->trace.tep, -1, "ftrace", "timerlat",
+				   timerlat_top_handler, top);
+
+	return top;
+
+out_err:
+	osnoise_destroy_tool(top);
+	return NULL;
+}
+
+static int stop_tracing;
+static void stop_top(int sig)
+{
+	stop_tracing = 1;
+}
+
+/*
+ * timerlat_top_set_signals - handles the signal to stop the tool
+ */
+static void
+timerlat_top_set_signals(struct timerlat_top_params *params)
+{
+	signal(SIGINT, stop_top);
+	if (params->duration) {
+		signal(SIGALRM, stop_top);
+		alarm(params->duration);
+	}
+}
+
+int timerlat_top_main(int argc, char *argv[])
+{
+	struct timerlat_top_params *params;
+	struct trace_instance *trace;
+	struct osnoise_tool *record;
+	struct osnoise_tool *top;
+	int return_value = 1;
+	int retval;
+
+	params = timerlat_top_parse_args(argc, argv);
+	if (!params)
+		exit(1);
+
+	top = timerlat_init_top(params);
+	if (!top) {
+		err_msg("Could not init osnoise top\n");
+		goto out_exit;
+	}
+
+	retval = timerlat_top_apply_config(top, params);
+	if (retval) {
+		err_msg("Could not apply config\n");
+		goto out_top;
+	}
+
+	trace = &top->trace;
+
+	retval = enable_timerlat(trace);
+	if (retval) {
+		err_msg("Failed to enable timerlat tracer\n");
+		goto out_top;
+	}
+
+	if (params->set_sched) {
+		retval = set_comm_sched_attr("timerlat/", &params->sched_param);
+		if (retval)
+			timerlat_top_usage("Failed to set sched parameters\n");
+	}
+
+	trace_instance_start(trace);
+
+	if (params->trace_output) {
+		record = osnoise_init_trace_tool("timerlat");
+		if (!record) {
+			err_msg("Failed to enable the trace instance\n");
+			goto out_top;
+		}
+		trace_instance_start(&record->trace);
+	}
+
+	top->start_time = time(NULL);
+	timerlat_top_set_signals(params);
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
+			goto out_top;
+		}
+
+		if (!params->quiet)
+			timerlat_print_stats(params, top);
+
+		if (!tracefs_trace_is_on(trace->inst))
+			break;
+
+	};
+
+	timerlat_print_stats(params, top);
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
+out_top:
+	timerlat_free_top(top->data);
+	osnoise_destroy_tool(top);
+	if (params->trace_output)
+		osnoise_destroy_tool(record);
+	free(params);
+out_exit:
+	exit(return_value);
+}
-- 
2.31.1

