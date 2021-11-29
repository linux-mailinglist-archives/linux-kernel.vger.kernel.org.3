Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663954613A0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377543AbhK2LOd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Nov 2021 06:14:33 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:56417 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377130AbhK2LMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:12:03 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-3cm0BxoONoSYN4XIDz90hg-1; Mon, 29 Nov 2021 06:08:44 -0500
X-MC-Unique: 3cm0BxoONoSYN4XIDz90hg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DD5C81CCB5;
        Mon, 29 Nov 2021 11:08:42 +0000 (UTC)
Received: from x1.com (unknown [10.22.8.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9EAA5D9DE;
        Mon, 29 Nov 2021 11:08:36 +0000 (UTC)
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
Subject: [PATCH V8 04/14] rtla/osnoise: Add osnoise top mode
Date:   Mon, 29 Nov 2021 12:07:42 +0100
Message-Id: <edbe1a4be48b5fd9d7fd224e819918cdb943db4a.1638182284.git.bristot@kernel.org>
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

The rtla osnoise tool is an interface for the osnoise tracer. The
osnoise tracer dispatches a kernel thread per-cpu. These threads read
the time in a loop while with preemption, softirqs and IRQs enabled,
thus allowing all the sources of osnoise during its execution. The
osnoise threads take note of the entry and exit point of any source
of interferences, increasing a per-cpu interference counter. The
osnoise tracer also saves an interference counter for each source
of interference.

The rtla osnoise top mode displays information about the periodic
summary from the osnoise tracer.

One example of rtla osnoise top output is:

[root@alien ~]# rtla osnoise top -c 0-3 -d 1m -q -r 900000 -P F:1
                                         Operating System Noise
duration:   0 00:01:00 | time is in us
CPU Period       Runtime        Noise  % CPU Aval   Max Noise   Max Single          HW          NMI          IRQ      Softirq       Thread
  0 #58         52200000         1031    99.99802          91           60           0            0        52285            0          101
  1 #59         53100000            5    99.99999           5            5           0            9        53122            0           18
  2 #59         53100000            7    99.99998           7            7           0            8        53115            0           18
  3 #59         53100000         8274    99.98441         277           23           0            9        53778            0          660

"rtla osnoise top --help" works and provide information about the
available options.

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
 tools/tracing/rtla/src/osnoise_top.c | 577 +++++++++++++++++++++++++++
 1 file changed, 577 insertions(+)
 create mode 100644 tools/tracing/rtla/src/osnoise_top.c

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
new file mode 100644
index 000000000000..e23bae8d9696
--- /dev/null
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -0,0 +1,577 @@
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
+#include "osnoise.h"
+#include "utils.h"
+
+/*
+ * osnoise top parameters
+ */
+struct osnoise_top_params {
+	char			*cpus;
+	char			*monitored_cpus;
+	char			*trace_output;
+	unsigned long long	runtime;
+	unsigned long long	period;
+	long long		stop_us;
+	long long		stop_total_us;
+	int			sleep_time;
+	int			duration;
+	int			quiet;
+	int			set_sched;
+	struct sched_attr	sched_param;
+};
+
+struct osnoise_top_cpu {
+	unsigned long long	sum_runtime;
+	unsigned long long	sum_noise;
+	unsigned long long	max_noise;
+	unsigned long long	max_sample;
+
+	unsigned long long	hw_count;
+	unsigned long long	nmi_count;
+	unsigned long long	irq_count;
+	unsigned long long	softirq_count;
+	unsigned long long	thread_count;
+
+	int			sum_cycles;
+};
+
+struct osnoise_top_data {
+	struct osnoise_top_cpu	*cpu_data;
+	int			nr_cpus;
+};
+
+/*
+ * osnoise_free_top - free runtime data
+ */
+static void
+osnoise_free_top(struct osnoise_top_data *data)
+{
+	free(data->cpu_data);
+	free(data);
+}
+
+/*
+ * osnoise_alloc_histogram - alloc runtime data
+ */
+static struct osnoise_top_data *osnoise_alloc_top(int nr_cpus)
+{
+	struct osnoise_top_data *data;
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
+	return data;
+
+cleanup:
+	osnoise_free_top(data);
+	return NULL;
+}
+
+/*
+ * osnoise_top_handler - this is the handler for osnoise tracer events
+ */
+static int
+osnoise_top_handler(struct trace_seq *s, struct tep_record *record,
+		    struct tep_event *event, void *context)
+{
+	struct trace_instance *trace = context;
+	struct osnoise_tool *tool;
+	unsigned long long val;
+	struct osnoise_top_cpu *cpu_data;
+	struct osnoise_top_data *data;
+	int cpu = record->cpu;
+
+	tool = container_of(trace, struct osnoise_tool, trace);
+
+	data = tool->data;
+	cpu_data = &data->cpu_data[cpu];
+
+	cpu_data->sum_cycles++;
+
+	tep_get_field_val(s, event, "runtime", record, &val, 1);
+	update_sum(&cpu_data->sum_runtime, &val);
+
+	tep_get_field_val(s, event, "noise", record, &val, 1);
+	update_max(&cpu_data->max_noise, &val);
+	update_sum(&cpu_data->sum_noise, &val);
+
+	tep_get_field_val(s, event, "max_sample", record, &val, 1);
+	update_max(&cpu_data->max_sample, &val);
+
+	tep_get_field_val(s, event, "hw_count", record, &val, 1);
+	update_sum(&cpu_data->hw_count, &val);
+
+	tep_get_field_val(s, event, "nmi_count", record, &val, 1);
+	update_sum(&cpu_data->nmi_count, &val);
+
+	tep_get_field_val(s, event, "irq_count", record, &val, 1);
+	update_sum(&cpu_data->irq_count, &val);
+
+	tep_get_field_val(s, event, "softirq_count", record, &val, 1);
+	update_sum(&cpu_data->softirq_count, &val);
+
+	tep_get_field_val(s, event, "thread_count", record, &val, 1);
+	update_sum(&cpu_data->thread_count, &val);
+
+	return 0;
+}
+
+/*
+ * osnoise_top_header - print the header of the tool output
+ */
+static void osnoise_top_header(struct osnoise_tool *top)
+{
+	struct trace_seq *s = top->trace.seq;
+	char duration[26];
+
+	get_duration(top->start_time, duration, sizeof(duration));
+
+	trace_seq_printf(s, "\033[2;37;40m");
+	trace_seq_printf(s, "                                          Operating System Noise");
+	trace_seq_printf(s, "                                     ");
+	trace_seq_printf(s, "                                     ");
+	trace_seq_printf(s, "\033[0;0;0m");
+	trace_seq_printf(s, "\n");
+
+	trace_seq_printf(s, "duration: %9s | time is in us\n", duration);
+
+	trace_seq_printf(s, "\033[2;30;47m");
+	trace_seq_printf(s, "CPU Period       Runtime ");
+	trace_seq_printf(s, "       Noise ");
+	trace_seq_printf(s, " %% CPU Aval ");
+	trace_seq_printf(s, "  Max Noise   Max Single ");
+	trace_seq_printf(s, "         HW          NMI          IRQ      Softirq       Thread");
+	trace_seq_printf(s, "\033[0;0;0m");
+	trace_seq_printf(s, "\n");
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
+ * osnoise_top_print - prints the output of a given CPU
+ */
+static void osnoise_top_print(struct osnoise_tool *tool, int cpu)
+{
+	struct trace_seq *s = tool->trace.seq;
+	struct osnoise_top_cpu *cpu_data;
+	struct osnoise_top_data *data;
+	int percentage;
+	int decimal;
+
+	data = tool->data;
+	cpu_data = &data->cpu_data[cpu];
+
+	if (!cpu_data->sum_runtime)
+		return;
+
+	percentage = ((cpu_data->sum_runtime - cpu_data->sum_noise) * 10000000)
+			/ cpu_data->sum_runtime;
+	decimal = percentage % 100000;
+	percentage = percentage / 100000;
+
+	trace_seq_printf(s, "%3d #%-6d %12llu ", cpu, cpu_data->sum_cycles, cpu_data->sum_runtime);
+	trace_seq_printf(s, "%12llu ", cpu_data->sum_noise);
+	trace_seq_printf(s, "  %3d.%05d", percentage, decimal);
+	trace_seq_printf(s, "%12llu %12llu", cpu_data->max_noise, cpu_data->max_sample);
+
+	trace_seq_printf(s, "%12llu ", cpu_data->hw_count);
+	trace_seq_printf(s, "%12llu ", cpu_data->nmi_count);
+	trace_seq_printf(s, "%12llu ", cpu_data->irq_count);
+	trace_seq_printf(s, "%12llu ", cpu_data->softirq_count);
+	trace_seq_printf(s, "%12llu\n", cpu_data->thread_count);
+}
+
+/*
+ * osnoise_print_stats - print data for all cpus
+ */
+static void
+osnoise_print_stats(struct osnoise_top_params *params, struct osnoise_tool *top)
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
+	osnoise_top_header(top);
+
+	for (i = 0; i < nr_cpus; i++) {
+		if (params->cpus && !params->monitored_cpus[i])
+			continue;
+		osnoise_top_print(top, i);
+	}
+
+	trace_seq_do_printf(trace->seq);
+	trace_seq_reset(trace->seq);
+}
+
+/*
+ * osnoise_top_usage - prints osnoise top usage message
+ */
+void osnoise_top_usage(char *usage)
+{
+	int i;
+
+	static const char * const msg[] = {
+		"  usage: rtla osnoise [top] [-h] [-q] [-p us] [-r us] [-s us] [-S us] [-T[=file]] \\",
+		"	  [-c cpu-list] -P priority",
+		"",
+		"	  -h/--help: print this menu",
+		"	  -p/--period us: osnoise period in us",
+		"	  -r/--runtime us: osnoise runtime in us",
+		"	  -s/--stop us: stop trace if a single sample is higher than the argument in us",
+		"	  -S/--stop-total us: stop trace if the total sample is higher than the argument in us",
+		"	  -c/--cpus cpu-list: list of cpus to run osnoise threads",
+		"	  -d/--duration time[s|m|h|d]: duration of the session",
+		"	  -t/--trace[=file]: save the stopped trace to [file|osnoise_trace.txt]",
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
+	fprintf(stderr, "rtla osnoise top: a per-cpu summary of the OS noise (version %s)\n",
+			VERSION);
+
+	for (i = 0; msg[i]; i++)
+		fprintf(stderr, "%s\n", msg[i]);
+	exit(1);
+}
+
+/*
+ * osnoise_top_parse_args - allocs, parse and fill the cmd line parameters
+ */
+struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
+{
+	struct osnoise_top_params *params;
+	int retval;
+	int c;
+
+	params = calloc(1, sizeof(*params));
+	if (!params)
+		exit(1);
+
+	while (1) {
+		static struct option long_options[] = {
+			{"cpus",		required_argument,	0, 'c'},
+			{"debug",		no_argument,		0, 'D'},
+			{"duration",		required_argument,	0, 'd'},
+			{"help",		no_argument,		0, 'h'},
+			{"period",		required_argument,	0, 'p'},
+			{"priority",		required_argument,	0, 'P'},
+			{"quiet",		no_argument,		0, 'q'},
+			{"runtime",		required_argument,	0, 'r'},
+			{"stop",		required_argument,	0, 's'},
+			{"stop-total",		required_argument,	0, 'S'},
+			{"trace",		optional_argument,	0, 't'},
+			{0, 0, 0, 0}
+		};
+
+		/* getopt_long stores the option index here. */
+		int option_index = 0;
+
+		c = getopt_long(argc, argv, "c:d:Dhp:P:qr:s:S:t::",
+				 long_options, &option_index);
+
+		/* Detect the end of the options. */
+		if (c == -1)
+			break;
+
+		switch (c) {
+		case 'c':
+			retval = parse_cpu_list(optarg, &params->monitored_cpus);
+			if (retval)
+				osnoise_top_usage("\nInvalid -c cpu list\n");
+			params->cpus = optarg;
+			debug_msg("-c for %s\n", params->cpus);
+			break;
+		case 'D':
+			config_debug = 1;
+			break;
+		case 'd':
+			params->duration = parse_seconds_duration(optarg);
+			if (!params->duration)
+				osnoise_top_usage("Invalid -D duration\n");
+			break;
+		case 'h':
+		case '?':
+			osnoise_top_usage(NULL);
+			break;
+		case 'p':
+			params->period = get_llong_from_str(optarg);
+			if (params->period > 10000000)
+				osnoise_top_usage("Period longer than 10 s\n");
+			break;
+		case 'P':
+			retval = parse_prio(optarg, &params->sched_param);
+			if (retval == -1)
+				osnoise_top_usage("Invalid -P priority");
+			params->set_sched = 1;
+			break;
+		case 'q':
+			params->quiet = 1;
+			break;
+		case 'r':
+			params->runtime = get_llong_from_str(optarg);
+			if (params->runtime < 100)
+				osnoise_top_usage("Runtime shorter than 100 us\n");
+			break;
+		case 's':
+			params->stop_us = get_llong_from_str(optarg);
+			break;
+		case 'S':
+			params->stop_total_us = get_llong_from_str(optarg);
+			break;
+		case 't':
+			if (optarg)
+				/* skip = */
+				params->trace_output = &optarg[1];
+			else
+				params->trace_output = "osnoise_trace.txt";
+			break;
+		default:
+			osnoise_top_usage("Invalid option");
+		}
+	}
+
+	if (geteuid()) {
+		err_msg("osnoise needs root permission\n");
+		exit(EXIT_FAILURE);
+	}
+
+	return params;
+}
+
+/*
+ * osnoise_top_apply_config - apply the top configs to the initialized tool
+ */
+static int
+osnoise_top_apply_config(struct osnoise_tool *tool, struct osnoise_top_params *params)
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
+	if (params->runtime || params->period) {
+		retval = osnoise_set_runtime_period(tool->context,
+						    params->runtime,
+						    params->period);
+		if (retval) {
+			err_msg("Failed to set runtime and/or period\n");
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
+	return 0;
+
+out_err:
+	return -1;
+}
+
+/*
+ * osnoise_init_top - initialize a osnoise top tool with parameters
+ */
+struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
+{
+	struct osnoise_tool *tool;
+	int nr_cpus;
+
+	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+
+	tool = osnoise_init_tool("osnoise_top");
+	if (!tool)
+		return NULL;
+
+	tool->data = osnoise_alloc_top(nr_cpus);
+	if (!tool->data)
+		goto out_err;
+
+	tool->params = params;
+
+	tep_register_event_handler(tool->trace.tep, -1, "ftrace", "osnoise",
+				   osnoise_top_handler, NULL);
+
+	return tool;
+
+out_err:
+	osnoise_free_top(tool->data);
+	osnoise_destroy_tool(tool);
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
+ * osnoise_top_set_signals - handles the signal to stop the tool
+ */
+static void osnoise_top_set_signals(struct osnoise_top_params *params)
+{
+	signal(SIGINT, stop_top);
+	if (params->duration) {
+		signal(SIGALRM, stop_top);
+		alarm(params->duration);
+	}
+}
+
+int osnoise_top_main(int argc, char **argv)
+{
+	struct osnoise_top_params *params;
+	struct trace_instance *trace;
+	struct osnoise_tool *record;
+	struct osnoise_tool *tool;
+	int return_value = 1;
+	int retval;
+
+	params = osnoise_top_parse_args(argc, argv);
+	if (!params)
+		exit(1);
+
+	tool = osnoise_init_top(params);
+	if (!tool) {
+		err_msg("Could not init osnoise top\n");
+		goto out_exit;
+	}
+
+	retval = osnoise_top_apply_config(tool, params);
+	if (retval) {
+		err_msg("Could not apply config\n");
+		goto out_top;
+	}
+
+	trace = &tool->trace;
+
+	retval = enable_osnoise(trace);
+	if (retval) {
+		err_msg("Failed to enable osnoise tracer\n");
+		goto out_top;
+	}
+
+	if (params->set_sched) {
+		retval = set_comm_sched_attr("osnoise/", &params->sched_param);
+		if (retval)
+			osnoise_top_usage("Failed to set sched parameters\n");
+	}
+
+	trace_instance_start(trace);
+
+	if (params->trace_output) {
+		record = osnoise_init_trace_tool("osnoise");
+		if (!record) {
+			err_msg("Failed to enable the trace instance\n");
+			goto out_top;
+		}
+		trace_instance_start(&record->trace);
+	}
+
+	tool->start_time = time(NULL);
+	osnoise_top_set_signals(params);
+
+	do {
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
+			osnoise_print_stats(params, tool);
+
+		if (!tracefs_trace_is_on(trace->inst))
+			break;
+
+	} while (!stop_tracing);
+
+	osnoise_print_stats(params, tool);
+
+	return_value = 0;
+
+	if (!tracefs_trace_is_on(trace->inst)) {
+		printf("osnoise hit stop tracing\n");
+		if (params->trace_output) {
+			printf("  Saving trace to %s\n", params->trace_output);
+			save_trace_to_file(record->trace.inst, params->trace_output);
+		}
+	}
+
+out_top:
+	osnoise_free_top(tool->data);
+	osnoise_destroy_tool(tool);
+	if (params->trace_output)
+		osnoise_destroy_tool(record);
+out_exit:
+	exit(return_value);
+}
-- 
2.31.1

