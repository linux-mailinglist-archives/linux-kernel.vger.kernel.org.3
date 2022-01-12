Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01ED048CCC2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357656AbiALUC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:02:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44042 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357232AbiALUAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:00:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BFADB82090;
        Wed, 12 Jan 2022 20:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA088C36AED;
        Wed, 12 Jan 2022 20:00:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1n7jnN-003ENZ-M2;
        Wed, 12 Jan 2022 15:00:33 -0500
Message-ID: <20220112200033.512573061@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 12 Jan 2022 14:58:45 -0500
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
Subject: [for-next][PATCH 02/14] rtla: Helper functions for rtla
References: <20220112195843.098894945@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

This is a set of utils and tracer helper functions. They are used by
rtla mostly to parse config, display data and some trace operations that
are not part of libtracefs (because they are only useful it for this
case).

Link: https://lkml.kernel.org/r/a94c128aba9e6e66d502b7094f2e8c7ac95b12e5.1639158831.git.bristot@kernel.org

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
 tools/tracing/rtla/src/trace.c | 192 +++++++++++++++
 tools/tracing/rtla/src/trace.h |  27 ++
 tools/tracing/rtla/src/utils.c | 433 +++++++++++++++++++++++++++++++++
 tools/tracing/rtla/src/utils.h |  56 +++++
 4 files changed, 708 insertions(+)
 create mode 100644 tools/tracing/rtla/src/trace.c
 create mode 100644 tools/tracing/rtla/src/trace.h
 create mode 100644 tools/tracing/rtla/src/utils.c
 create mode 100644 tools/tracing/rtla/src/utils.h

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
new file mode 100644
index 000000000000..107a0c6387f7
--- /dev/null
+++ b/tools/tracing/rtla/src/trace.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sys/sendfile.h>
+#include <tracefs.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include "trace.h"
+#include "utils.h"
+
+/*
+ * enable_tracer_by_name - enable a tracer on the given instance
+ */
+int enable_tracer_by_name(struct tracefs_instance *inst, const char *tracer_name)
+{
+	enum tracefs_tracers tracer;
+	int retval;
+
+	tracer = TRACEFS_TRACER_CUSTOM;
+
+	debug_msg("enabling %s tracer\n", tracer_name);
+
+	retval = tracefs_tracer_set(inst, tracer, tracer_name);
+	if (retval < 0) {
+		if (errno == ENODEV)
+			err_msg("tracer %s not found!\n", tracer_name);
+
+		err_msg("failed to enable the tracer %s\n", tracer_name);
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * disable_tracer - set nop tracer to the insta
+ */
+void disable_tracer(struct tracefs_instance *inst)
+{
+	enum tracefs_tracers t = TRACEFS_TRACER_NOP;
+	int retval;
+
+	retval = tracefs_tracer_set(inst, t);
+	if (retval < 0)
+		err_msg("oops, error disabling tracer\n");
+}
+
+/*
+ * create_instance - create a trace instance with *instance_name
+ */
+struct tracefs_instance *create_instance(char *instance_name)
+{
+	return tracefs_instance_create(instance_name);
+}
+
+/*
+ * destroy_instance - remove a trace instance and free the data
+ */
+void destroy_instance(struct tracefs_instance *inst)
+{
+	tracefs_instance_destroy(inst);
+	tracefs_instance_free(inst);
+}
+
+/*
+ * save_trace_to_file - save the trace output of the instance to the file
+ */
+int save_trace_to_file(struct tracefs_instance *inst, const char *filename)
+{
+	const char *file = "trace";
+	mode_t mode = 0644;
+	char buffer[4096];
+	int out_fd, in_fd;
+	int retval = -1;
+
+	in_fd = tracefs_instance_file_open(inst, file, O_RDONLY);
+	if (in_fd < 0) {
+		err_msg("Failed to open trace file\n");
+		return -1;
+	}
+
+	out_fd = creat(filename, mode);
+	if (out_fd < 0) {
+		err_msg("Failed to create output file %s\n", filename);
+		goto out_close_in;
+	}
+
+	do {
+		retval = read(in_fd, buffer, sizeof(buffer));
+		if (retval <= 0)
+			goto out_close;
+
+		retval = write(out_fd, buffer, retval);
+		if (retval < 0)
+			goto out_close;
+	} while (retval > 0);
+
+	retval = 0;
+out_close:
+	close(out_fd);
+out_close_in:
+	close(in_fd);
+	return retval;
+}
+
+/*
+ * collect_registered_events - call the existing callback function for the event
+ *
+ * If an event has a registered callback function, call it.
+ * Otherwise, ignore the event.
+ */
+int
+collect_registered_events(struct tep_event *event, struct tep_record *record,
+			  int cpu, void *context)
+{
+	struct trace_instance *trace = context;
+	struct trace_seq *s = trace->seq;
+
+	if (!event->handler)
+		return 0;
+
+	event->handler(s, record, event, context);
+
+	return 0;
+}
+
+/*
+ * trace_instance_destroy - destroy and free a rtla trace instance
+ */
+void trace_instance_destroy(struct trace_instance *trace)
+{
+	if (trace->inst) {
+		disable_tracer(trace->inst);
+		destroy_instance(trace->inst);
+	}
+
+	if (trace->seq)
+		free(trace->seq);
+
+	if (trace->tep)
+		tep_free(trace->tep);
+}
+
+/*
+ * trace_instance_init - create an rtla trace instance
+ *
+ * It is more than the tracefs instance, as it contains other
+ * things required for the tracing, such as the local events and
+ * a seq file.
+ *
+ * Note that the trace instance is returned disabled. This allows
+ * the tool to apply some other configs, like setting priority
+ * to the kernel threads, before starting generating trace entries.
+ */
+int trace_instance_init(struct trace_instance *trace, char *tool_name)
+{
+	trace->seq = calloc(1, sizeof(*trace->seq));
+	if (!trace->seq)
+		goto out_err;
+
+	trace_seq_init(trace->seq);
+
+	trace->inst = create_instance(tool_name);
+	if (!trace->inst)
+		goto out_err;
+
+	trace->tep = tracefs_local_events(NULL);
+	if (!trace->tep)
+		goto out_err;
+
+	/*
+	 * Let the main enable the record after setting some other
+	 * things such as the priority of the tracer's threads.
+	 */
+	tracefs_trace_off(trace->inst);
+
+	return 0;
+
+out_err:
+	trace_instance_destroy(trace);
+	return 1;
+}
+
+/*
+ * trace_instance_start - start tracing a given rtla instance
+ */
+int trace_instance_start(struct trace_instance *trace)
+{
+	return tracefs_trace_on(trace->inst);
+}
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
new file mode 100644
index 000000000000..0ea1df0ad9a7
--- /dev/null
+++ b/tools/tracing/rtla/src/trace.h
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <tracefs.h>
+#include <stddef.h>
+
+struct trace_instance {
+	struct tracefs_instance		*inst;
+	struct tep_handle		*tep;
+	struct trace_seq		*seq;
+};
+
+int trace_instance_init(struct trace_instance *trace, char *tool_name);
+int trace_instance_start(struct trace_instance *trace);
+void trace_instance_destroy(struct trace_instance *trace);
+
+struct trace_seq *get_trace_seq(void);
+int enable_tracer_by_name(struct tracefs_instance *inst, const char *tracer_name);
+void disable_tracer(struct tracefs_instance *inst);
+
+int enable_osnoise(struct trace_instance *trace);
+int enable_timerlat(struct trace_instance *trace);
+
+struct tracefs_instance *create_instance(char *instance_name);
+void destroy_instance(struct tracefs_instance *inst);
+
+int save_trace_to_file(struct tracefs_instance *inst, const char *filename);
+int collect_registered_events(struct tep_event *tep, struct tep_record *record,
+			      int cpu, void *context);
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
new file mode 100644
index 000000000000..1c9f0eea6166
--- /dev/null
+++ b/tools/tracing/rtla/src/utils.c
@@ -0,0 +1,433 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
+ */
+
+#include <proc/readproc.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <ctype.h>
+#include <errno.h>
+#include <sched.h>
+#include <stdio.h>
+
+#include "utils.h"
+
+#define MAX_MSG_LENGTH	1024
+int config_debug;
+
+/*
+ * err_msg - print an error message to the stderr
+ */
+void err_msg(const char *fmt, ...)
+{
+	char message[MAX_MSG_LENGTH];
+	va_list ap;
+
+	va_start(ap, fmt);
+	vsnprintf(message, sizeof(message), fmt, ap);
+	va_end(ap);
+
+	fprintf(stderr, "%s", message);
+}
+
+/*
+ * debug_msg - print a debug message to stderr if debug is set
+ */
+void debug_msg(const char *fmt, ...)
+{
+	char message[MAX_MSG_LENGTH];
+	va_list ap;
+
+	if (!config_debug)
+		return;
+
+	va_start(ap, fmt);
+	vsnprintf(message, sizeof(message), fmt, ap);
+	va_end(ap);
+
+	fprintf(stderr, "%s", message);
+}
+
+/*
+ * get_llong_from_str - get a long long int from a string
+ */
+long long get_llong_from_str(char *start)
+{
+	long long value;
+	char *end;
+
+	errno = 0;
+	value = strtoll(start, &end, 10);
+	if (errno || start == end)
+		return -1;
+
+	return value;
+}
+
+/*
+ * get_duration - fill output with a human readable duration since start_time
+ */
+void get_duration(time_t start_time, char *output, int output_size)
+{
+	time_t now = time(NULL);
+	struct tm *tm_info;
+	time_t duration;
+
+	duration = difftime(now, start_time);
+	tm_info = localtime(&duration);
+
+	snprintf(output, output_size, "%3d %02d:%02d:%02d",
+			tm_info->tm_yday,
+			tm_info->tm_hour - 1,
+			tm_info->tm_min,
+			tm_info->tm_sec);
+}
+
+/*
+ * parse_cpu_list - parse a cpu_list filling a char vector with cpus set
+ *
+ * Receives a cpu list, like 1-3,5 (cpus 1, 2, 3, 5), and then set the char
+ * in the monitored_cpus.
+ *
+ * XXX: convert to a bitmask.
+ */
+int parse_cpu_list(char *cpu_list, char **monitored_cpus)
+{
+	char *mon_cpus;
+	const char *p;
+	int end_cpu;
+	int nr_cpus;
+	int cpu;
+	int i;
+
+	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+
+	mon_cpus = malloc(nr_cpus * sizeof(char));
+	memset(mon_cpus, 0, (nr_cpus * sizeof(char)));
+
+	for (p = cpu_list; *p; ) {
+		cpu = atoi(p);
+		if (cpu < 0 || (!cpu && *p != '0') || cpu >= nr_cpus)
+			goto err;
+
+		while (isdigit(*p))
+			p++;
+		if (*p == '-') {
+			p++;
+			end_cpu = atoi(p);
+			if (end_cpu < cpu || (!end_cpu && *p != '0') || end_cpu >= nr_cpus)
+				goto err;
+			while (isdigit(*p))
+				p++;
+		} else
+			end_cpu = cpu;
+
+		if (cpu == end_cpu) {
+			debug_msg("cpu_list: adding cpu %d\n", cpu);
+			mon_cpus[cpu] = 1;
+		} else {
+			for (i = cpu; i <= end_cpu; i++) {
+				debug_msg("cpu_list: adding cpu %d\n", i);
+				mon_cpus[i] = 1;
+			}
+		}
+
+		if (*p == ',')
+			p++;
+	}
+
+	*monitored_cpus = mon_cpus;
+
+	return 0;
+
+err:
+	debug_msg("Error parsing the cpu list %s", cpu_list);
+	return 1;
+}
+
+/*
+ * parse_duration - parse duration with s/m/h/d suffix converting it to seconds
+ */
+long parse_seconds_duration(char *val)
+{
+	char *end;
+	long t;
+
+	t = strtol(val, &end, 10);
+
+	if (end) {
+		switch (*end) {
+		case 's':
+		case 'S':
+			break;
+		case 'm':
+		case 'M':
+			t *= 60;
+			break;
+		case 'h':
+		case 'H':
+			t *= 60 * 60;
+			break;
+
+		case 'd':
+		case 'D':
+			t *= 24 * 60 * 60;
+			break;
+		}
+	}
+
+	return t;
+}
+
+/*
+ * parse_ns_duration - parse duration with ns/us/ms/s converting it to nanoseconds
+ */
+long parse_ns_duration(char *val)
+{
+	char *end;
+	long t;
+
+	t = strtol(val, &end, 10);
+
+	if (end) {
+		if (!strncmp(end, "ns", 2)) {
+			return t;
+		} else if (!strncmp(end, "us", 2)) {
+			t *= 1000;
+			return t;
+		} else if (!strncmp(end, "ms", 2)) {
+			t *= 1000 * 1000;
+			return t;
+		} else if (!strncmp(end, "s", 1)) {
+			t *= 1000 * 1000 * 1000;
+			return t;
+		}
+		return -1;
+	}
+
+	return t;
+}
+
+/*
+ * This is a set of helper functions to use SCHED_DEADLINE.
+ */
+#ifdef __x86_64__
+# define __NR_sched_setattr	314
+# define __NR_sched_getattr	315
+#elif __i386__
+# define __NR_sched_setattr	351
+# define __NR_sched_getattr	352
+#elif __arm__
+# define __NR_sched_setattr	380
+# define __NR_sched_getattr	381
+#elif __aarch64__
+# define __NR_sched_setattr	274
+# define __NR_sched_getattr	275
+#elif __powerpc__
+# define __NR_sched_setattr	355
+# define __NR_sched_getattr	356
+#elif __s390x__
+# define __NR_sched_setattr	345
+# define __NR_sched_getattr	346
+#endif
+
+#define SCHED_DEADLINE		6
+
+static inline int sched_setattr(pid_t pid, const struct sched_attr *attr,
+				unsigned int flags) {
+	return syscall(__NR_sched_setattr, pid, attr, flags);
+}
+
+static inline int sched_getattr(pid_t pid, struct sched_attr *attr,
+				unsigned int size, unsigned int flags)
+{
+	return syscall(__NR_sched_getattr, pid, attr, size, flags);
+}
+
+int __set_sched_attr(int pid, struct sched_attr *attr)
+{
+	int flags = 0;
+	int retval;
+
+	retval = sched_setattr(pid, attr, flags);
+	if (retval < 0) {
+		err_msg("boost_with_deadline failed to boost pid %d: %s\n",
+			pid, strerror(errno));
+		return 1;
+	}
+
+	return 0;
+}
+/*
+ * set_comm_sched_attr - set sched params to threads starting with char *comm
+ *
+ * This function uses procps to list the currently running threads and then
+ * set the sched_attr *attr to the threads that start with char *comm. It is
+ * mainly used to set the priority to the kernel threads created by the
+ * tracers.
+ */
+int set_comm_sched_attr(const char *comm, struct sched_attr *attr)
+{
+	int flags = PROC_FILLCOM | PROC_FILLSTAT;
+	PROCTAB *ptp;
+	proc_t task;
+	int retval;
+
+	ptp = openproc(flags);
+	if (!ptp) {
+		err_msg("error openproc()\n");
+		return -ENOENT;
+	}
+
+	memset(&task, 0, sizeof(task));
+
+	while (readproc(ptp, &task)) {
+		retval = strncmp(comm, task.cmd, strlen(comm));
+		if (retval)
+			continue;
+		retval = __set_sched_attr(task.tid, attr);
+		if (retval)
+			goto out_err;
+	}
+
+	closeproc(ptp);
+	return 0;
+
+out_err:
+	closeproc(ptp);
+	return 1;
+}
+
+#define INVALID_VAL	(~0L)
+static long get_long_ns_after_colon(char *start)
+{
+	long val = INVALID_VAL;
+
+	/* find the ":" */
+	start = strstr(start, ":");
+	if (!start)
+		return -1;
+
+	/* skip ":" */
+	start++;
+	val = parse_ns_duration(start);
+
+	return val;
+}
+
+static long get_long_after_colon(char *start)
+{
+	long val = INVALID_VAL;
+
+	/* find the ":" */
+	start = strstr(start, ":");
+	if (!start)
+		return -1;
+
+	/* skip ":" */
+	start++;
+	val = get_llong_from_str(start);
+
+	return val;
+}
+
+/*
+ * parse priority in the format:
+ * SCHED_OTHER:
+ *		o:<prio>
+ *		O:<prio>
+ * SCHED_RR:
+ *		r:<prio>
+ *		R:<prio>
+ * SCHED_FIFO:
+ *		f:<prio>
+ *		F:<prio>
+ * SCHED_DEADLINE:
+ *		d:runtime:period
+ *		D:runtime:period
+ */
+int parse_prio(char *arg, struct sched_attr *sched_param)
+{
+	long prio;
+	long runtime;
+	long period;
+
+	memset(sched_param, 0, sizeof(*sched_param));
+	sched_param->size = sizeof(*sched_param);
+
+	switch (arg[0]) {
+	case 'd':
+	case 'D':
+		/* d:runtime:period */
+		if (strlen(arg) < 4)
+			return -1;
+
+		runtime = get_long_ns_after_colon(arg);
+		if (runtime == INVALID_VAL)
+			return -1;
+
+		period = get_long_ns_after_colon(&arg[2]);
+		if (period == INVALID_VAL)
+			return -1;
+
+		if (runtime > period)
+			return -1;
+
+		sched_param->sched_policy   = SCHED_DEADLINE;
+		sched_param->sched_runtime  = runtime;
+		sched_param->sched_deadline = period;
+		sched_param->sched_period   = period;
+		break;
+	case 'f':
+	case 'F':
+		/* f:prio */
+		prio = get_long_after_colon(arg);
+		if (prio == INVALID_VAL)
+			return -1;
+
+		if (prio < sched_get_priority_min(SCHED_FIFO))
+			return -1;
+		if (prio > sched_get_priority_max(SCHED_FIFO))
+			return -1;
+
+		sched_param->sched_policy   = SCHED_FIFO;
+		sched_param->sched_priority = prio;
+		break;
+	case 'r':
+	case 'R':
+		/* r:prio */
+		prio = get_long_after_colon(arg);
+		if (prio == INVALID_VAL)
+			return -1;
+
+		if (prio < sched_get_priority_min(SCHED_RR))
+			return -1;
+		if (prio > sched_get_priority_max(SCHED_RR))
+			return -1;
+
+		sched_param->sched_policy   = SCHED_RR;
+		sched_param->sched_priority = prio;
+		break;
+	case 'o':
+	case 'O':
+		/* o:prio */
+		prio = get_long_after_colon(arg);
+		if (prio == INVALID_VAL)
+			return -1;
+
+		if (prio < sched_get_priority_min(SCHED_OTHER))
+			return -1;
+		if (prio > sched_get_priority_max(SCHED_OTHER))
+			return -1;
+
+		sched_param->sched_policy   = SCHED_OTHER;
+		sched_param->sched_priority = prio;
+		break;
+	default:
+		return -1;
+	}
+	return 0;
+}
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
new file mode 100644
index 000000000000..9aa962319ca2
--- /dev/null
+++ b/tools/tracing/rtla/src/utils.h
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdint.h>
+#include <time.h>
+
+/*
+ * '18446744073709551615\0'
+ */
+#define BUFF_U64_STR_SIZE	24
+
+#define container_of(ptr, type, member)({			\
+	const typeof(((type *)0)->member) *__mptr = (ptr);	\
+	(type *)((char *)__mptr - offsetof(type, member)) ; })
+
+extern int config_debug;
+void debug_msg(const char *fmt, ...);
+void err_msg(const char *fmt, ...);
+
+long parse_seconds_duration(char *val);
+void get_duration(time_t start_time, char *output, int output_size);
+
+int parse_cpu_list(char *cpu_list, char **monitored_cpus);
+long long get_llong_from_str(char *start);
+
+static inline void
+update_min(unsigned long long *a, unsigned long long *b)
+{
+	if (*a > *b)
+		*a = *b;
+}
+
+static inline void
+update_max(unsigned long long *a, unsigned long long *b)
+{
+	if (*a < *b)
+		*a = *b;
+}
+
+static inline void
+update_sum(unsigned long long *a, unsigned long long *b)
+{
+	*a += *b;
+}
+
+struct sched_attr {
+	uint32_t size;
+	uint32_t sched_policy;
+	uint64_t sched_flags;
+	int32_t sched_nice;
+	uint32_t sched_priority;
+	uint64_t sched_runtime;
+	uint64_t sched_deadline;
+	uint64_t sched_period;
+};
+
+int parse_prio(char *arg, struct sched_attr *sched_param);
+int set_comm_sched_attr(const char *comm, struct sched_attr *attr);
-- 
2.33.0
