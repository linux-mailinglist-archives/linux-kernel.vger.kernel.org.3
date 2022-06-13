Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3621154842D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbiFMJsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241123AbiFMJsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:48:08 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5C4193C7;
        Mon, 13 Jun 2022 02:48:06 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LM6Dr370XzDqtc;
        Mon, 13 Jun 2022 17:47:40 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:04 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:03 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [RFC 01/13] perf kwork: New tool
Date:   Mon, 13 Jun 2022 17:45:53 +0800
Message-ID: <20220613094605.208401-2-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20220613094605.208401-1-yangjihong1@huawei.com>
References: <20220613094605.208401-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf-kwork tool is used to trace time properties of kernel work
(such as irq, softirq, and workqueue), including runtime, latency,
and timehist, using the infrastructure in the perf tools to allow
tracing extra targets:

  # perf kwork -h

   Usage: perf kwork [<options>] {record|report|latency|timehist}

      -D, --dump-raw-trace  dump raw trace in ASCII
      -f, --force           don't complain, do it
      -k, --kwork <kwork>   list of kwork to profile (irq, softirq, workqueue etc)
      -v, --verbose         be more verbose (show symbol address, etc)

  # perf kwork record -- sleep 1
  [ perf record: Woken up 0 times to write data ]
  [ perf record: Captured and wrote 1.696 MB perf.data ]

  # perf kwork report -h

   Usage: perf kwork report [<options>]

      -C, --cpu <cpu>       list of cpus to profile
      -i, --input <file>    input file name
      -n, --name <name>     event name to profile
      -s, --sort <key[,key2...]>
                            sort by key(s): runtime, max, freq
      -S, --with-summary    Show summary with statistics
          --time <str>      Time span for analysis (start,stop)

  # perf kwork latency -h

   Usage: perf kwork latency [<options>]

      -C, --cpu <cpu>       list of cpus to profile
      -i, --input <file>    input file name
      -n, --name <name>     event name to profile
      -s, --sort <key[,key2...]>
                            sort by key(s): avg, max, freq
          --time <str>      Time span for analysis (start,stop)

  # perf kwork timehist -h

   Usage: perf kwork timehist [<options>]

      -C, --cpu <cpu>       list of cpus to profile
      -g, --call-graph      Display call chains if present
      -i, --input <file>    input file name
      -k, --vmlinux <file>  vmlinux pathname
      -n, --name <name>     event name to profile
          --kallsyms <file>
                            kallsyms pathname
          --max-stack <n>   Maximum number of functions to display backtrace.
          --symfs <directory>
                            Look for files with symbols relative to this directory
          --time <str>      Time span for analysis (start,stop)

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/Build                        |   1 +
 tools/perf/Documentation/perf-kwork.txt | 173 ++++++++++++++
 tools/perf/builtin-kwork.c              | 291 ++++++++++++++++++++++++
 tools/perf/builtin.h                    |   1 +
 tools/perf/command-list.txt             |   1 +
 tools/perf/perf.c                       |   1 +
 6 files changed, 468 insertions(+)
 create mode 100644 tools/perf/Documentation/perf-kwork.txt
 create mode 100644 tools/perf/builtin-kwork.c

diff --git a/tools/perf/Build b/tools/perf/Build
index db61dbe2b543..496b096153bb 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -25,6 +25,7 @@ perf-y += builtin-data.o
 perf-y += builtin-version.o
 perf-y += builtin-c2c.o
 perf-y += builtin-daemon.o
+perf-y += builtin-kwork.o
 
 perf-$(CONFIG_TRACE) += builtin-trace.o
 perf-$(CONFIG_LIBELF) += builtin-probe.o
diff --git a/tools/perf/Documentation/perf-kwork.txt b/tools/perf/Documentation/perf-kwork.txt
new file mode 100644
index 000000000000..59e0a36c527d
--- /dev/null
+++ b/tools/perf/Documentation/perf-kwork.txt
@@ -0,0 +1,173 @@
+perf-kwork(1)
+=============
+
+NAME
+----
+perf-kwork - Tool to trace/measure kernel work properties (latencies)
+
+SYNOPSIS
+--------
+[verse]
+'perf kwork' {record|report|latency|timehist}
+
+DESCRIPTION
+-----------
+There are several variants of 'perf kwork':
+
+  'perf kwork record <command>' to record the kernel work
+  of an arbitrary workload.
+
+  'perf kwork report' to report the per kwork runtime.
+
+  'perf kwork latency' to report the per kwork latencies.
+
+  'perf kwork script' to see a detailed trace of the workload that
+   was recorded (aliased to 'perf script' for now).
+
+  'perf kwork timehist' provides an analysis of kernel work events.
+
+    Example usage:
+        perf kwork record -- sleep 1
+        perf kwork report
+        perf kwork latency
+        perf kwork timehist
+
+   By default it shows the individual work events such as irq, workqeueu,
+   including the run time and delay (time between raise and actually entry):
+
+      Runtime start      Runtime end        Cpu     Kwork name                 Runtime     Delaytime
+                                                 (TYPE)NAME:NUM             (msec)      (msec)
+   -----------------  -----------------  ------  -------------------------  ----------  ----------
+      1811186.976062     1811186.976327  [0000]  (s)RCU:9                        0.266       0.114
+      1811186.978452     1811186.978547  [0000]  (s)SCHED:7                      0.095       0.171
+      1811186.980327     1811186.980490  [0000]  (s)SCHED:7                      0.162       0.083
+      1811186.981221     1811186.981271  [0000]  (s)SCHED:7                      0.050       0.077
+      1811186.984267     1811186.984318  [0000]  (s)SCHED:7                      0.051       0.075
+      1811186.987252     1811186.987315  [0000]  (s)SCHED:7                      0.063       0.081
+      1811186.987785     1811186.987843  [0006]  (s)RCU:9                        0.058       0.645
+      1811186.988319     1811186.988383  [0000]  (s)SCHED:7                      0.064       0.143
+      1811186.989404     1811186.989607  [0002]  (s)TIMER:1                      0.203       0.111
+      1811186.989660     1811186.989732  [0002]  (s)SCHED:7                      0.072       0.310
+      1811186.991295     1811186.991407  [0002]  eth0:10                         0.112
+      1811186.991639     1811186.991734  [0002]  (s)NET_RX:3                     0.095       0.277
+      1811186.989860     1811186.991826  [0002]  (w)0xffff888102fc14a0           1.966       0.345
+    ...
+
+   Times are in msec.usec.
+
+OPTIONS
+-------
+-D::
+--dump-raw-trace=::
+        Display verbose dump of the trace data.
+
+-f::
+--force::
+        Don't complain, do it.
+
+-k::
+--kwork::
+        list of kwork to profile (irq, softirq, workqueue etc)
+
+-v::
+--verbose::
+        Be more verbose. (show symbol address, etc)
+
+OPTIONS for 'perf kwork report'
+----------------------------
+
+-C::
+--cpu::
+        Only show events for the given CPU(s) (comma separated list).
+
+-i::
+--input::
+        Input file name. (default: perf.data unless stdin is a fifo)
+
+-n::
+--name::
+        Only show events for the given name.
+
+-s::
+--sort::
+        sort by key(s): runtime, max, freq
+
+-S::
+--with-summary::
+        Show summary with statistics
+
+--time::
+        Only analyze samples within given time window: <start>,<stop>. Times
+        have the format seconds.microseconds. If start is not given (i.e., time
+        string is ',x.y') then analysis starts at the beginning of the file. If
+        stop time is not given (i.e, time string is 'x.y,') then analysis goes
+        to end of file.
+
+OPTIONS for 'perf kwork latency'
+----------------------------
+
+-C::
+--cpu::
+        Only show events for the given CPU(s) (comma separated list).
+
+-i::
+--input::
+        Input file name. (default: perf.data unless stdin is a fifo)
+
+-n::
+--name::
+        Only show events for the given name.
+
+-s::
+--sort::
+        sort by key(s): avg, max, freq
+
+--time::
+        Only analyze samples within given time window: <start>,<stop>. Times
+        have the format seconds.microseconds. If start is not given (i.e., time
+        string is ',x.y') then analysis starts at the beginning of the file. If
+        stop time is not given (i.e, time string is 'x.y,') then analysis goes
+        to end of file.
+
+OPTIONS for 'perf kwork timehist'
+---------------------------------
+
+-C::
+--cpu::
+        Only show events for the given CPU(s) (comma separated list).
+
+-g::
+--call-graph::
+        Display call chains if present (default off).
+
+-i::
+--input::
+        Input file name. (default: perf.data unless stdin is a fifo)
+
+-k::
+--vmlinux=<file>::
+    vmlinux pathname
+
+-n::
+--name::
+        Only show events for the given name.
+
+--kallsyms=<file>::
+    kallsyms pathname
+
+--max-stack::
+        Maximum number of functions to display in backtrace, default 5.
+
+--symfs=<directory>::
+    Look for files with symbols relative to this directory.
+
+--time::
+        Only analyze samples within given time window: <start>,<stop>. Times
+        have the format seconds.microseconds. If start is not given (i.e., time
+        string is ',x.y') then analysis starts at the beginning of the file. If
+        stop time is not given (i.e, time string is 'x.y,') then analysis goes
+        to end of file.
+
+SEE ALSO
+--------
+linkperf:perf-record[1]
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
new file mode 100644
index 000000000000..b89e41fcc568
--- /dev/null
+++ b/tools/perf/builtin-kwork.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "builtin.h"
+#include "perf.h"
+
+#include "util/data.h"
+#include "util/tool.h"
+#include "util/debug.h"
+#include "util/event.h"
+#include "util/evlist.h"
+#include "util/symbol.h"
+#include "util/thread.h"
+#include "util/session.h"
+#include "util/string2.h"
+#include "util/callchain.h"
+#include "util/time-utils.h"
+#include "util/evsel_fprintf.h"
+
+#include <subcmd/pager.h>
+#include <subcmd/parse-options.h>
+
+#include <errno.h>
+#include <inttypes.h>
+#include <linux/err.h>
+#include <linux/time64.h>
+#include <linux/zalloc.h>
+
+enum kwork_class_type {
+	KWORK_CLASS_MAX,
+};
+
+struct kwork_class {
+	struct list_head list;
+	const char *name;
+
+	unsigned int nr_tracepoints;
+	const struct evsel_str_handler *tp_handlers;
+};
+
+struct perf_kwork {
+	/*
+	 * metadata
+	 */
+	struct list_head class_list;
+
+	/*
+	 * profile filters
+	 */
+	const char *profile_name;
+
+	const char *cpu_list;
+	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
+
+	const char *time_str;
+	struct perf_time_interval ptime;
+
+	/*
+	 * options for command
+	 */
+	bool force;
+	const char *event_list_str;
+
+	/*
+	 * options for subcommand
+	 */
+	bool summary;
+	bool show_callchain;
+	unsigned int max_stack;
+	const char *sort_order;
+};
+
+static struct kwork_class *kwork_class_supported_list[KWORK_CLASS_MAX] = {
+};
+
+static void setup_event_list(struct perf_kwork *kwork,
+			     const struct option *options,
+			     const char * const usage_msg[])
+{
+	int i;
+	struct kwork_class *class;
+	char *tmp, *tok, *str;
+
+	if (kwork->event_list_str == NULL)
+		goto null_event_list_str;
+
+	str = strdup(kwork->event_list_str);
+	for (tok = strtok_r(str, ", ", &tmp);
+	     tok; tok = strtok_r(NULL, ", ", &tmp)) {
+		for (i = 0; i < KWORK_CLASS_MAX; i++) {
+			class = kwork_class_supported_list[i];
+			if (strcmp(tok, class->name) == 0) {
+				list_add_tail(&class->list, &kwork->class_list);
+				break;
+			}
+		}
+		if (i == KWORK_CLASS_MAX)
+			usage_with_options_msg(usage_msg, options,
+					       "Unknown --event key: `%s'", tok);
+	}
+	free(str);
+
+null_event_list_str:
+	/*
+	 * config all kwork events if not specified
+	 */
+	if (list_empty(&kwork->class_list))
+		for (i = 0; i < KWORK_CLASS_MAX; i++)
+			list_add_tail(&kwork_class_supported_list[i]->list,
+				      &kwork->class_list);
+
+	pr_debug("Config event list:");
+	list_for_each_entry(class, &kwork->class_list, list)
+		pr_debug(" %s", class->name);
+	pr_debug("\n");
+}
+
+static int perf_kwork__record(struct perf_kwork *kwork,
+			      int argc, const char **argv)
+{
+	const char **rec_argv;
+	unsigned int rec_argc, i, j;
+	struct kwork_class *class;
+
+	const char *const record_args[] = {
+		"record",
+		"-a",
+		"-R",
+		"-m", "1024",
+		"-c", "1",
+	};
+
+	rec_argc = ARRAY_SIZE(record_args) + argc - 1;
+
+	list_for_each_entry(class, &kwork->class_list, list)
+		rec_argc += 2 * class->nr_tracepoints;
+
+	rec_argv = calloc(rec_argc + 1, sizeof(char *));
+	if (rec_argv == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(record_args); i++)
+		rec_argv[i] = strdup(record_args[i]);
+
+	list_for_each_entry(class, &kwork->class_list, list) {
+		for (j = 0; j < class->nr_tracepoints; j++) {
+			rec_argv[i++] = strdup("-e");
+			rec_argv[i++] = strdup(class->tp_handlers[j].name);
+		}
+	}
+
+	for (j = 1; j < (unsigned int)argc; j++, i++)
+		rec_argv[i] = argv[j];
+
+	BUG_ON(i != rec_argc);
+
+	pr_debug("record comm: ");
+	for (j = 0; j < rec_argc; j++)
+		pr_debug("%s ", rec_argv[j]);
+	pr_debug("\n");
+
+	return cmd_record(i, rec_argv);
+}
+
+int cmd_kwork(int argc, const char **argv)
+{
+	static struct perf_kwork kwork = {
+		.class_list          = LIST_HEAD_INIT(kwork.class_list),
+
+		.profile_name        = NULL,
+		.cpu_list            = NULL,
+		.time_str            = NULL,
+		.force               = false,
+		.event_list_str      = NULL,
+		.summary             = false,
+		.show_callchain      = false,
+		.max_stack           = 5,
+		.sort_order          = NULL,
+	};
+
+	const struct option kwork_options[] = {
+	OPT_INCR('v', "verbose", &verbose,
+		 "be more verbose (show symbol address, etc)"),
+	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
+		    "dump raw trace in ASCII"),
+	OPT_STRING('k', "kwork", &kwork.event_list_str, "kwork",
+		   "list of kwork to profile (irq, softirq, workqueue etc)"),
+	OPT_BOOLEAN('f', "force", &kwork.force, "don't complain, do it"),
+	OPT_END()
+	};
+	const struct option latency_options[] = {
+	OPT_STRING('s', "sort", &kwork.sort_order, "key[,key2...]",
+		   "sort by key(s): avg, max, freq"),
+	OPT_STRING('C', "cpu", &kwork.cpu_list, "cpu",
+		   "list of cpus to profile"),
+	OPT_STRING('n', "name", &kwork.profile_name, "name",
+		   "event name to profile"),
+	OPT_STRING(0, "time", &kwork.time_str, "str",
+		   "Time span for analysis (start,stop)"),
+	OPT_STRING('i', "input", &input_name, "file",
+		   "input file name"),
+	OPT_PARENT(kwork_options)
+	};
+	const struct option report_options[] = {
+	OPT_STRING('s', "sort", &kwork.sort_order, "key[,key2...]",
+		   "sort by key(s): runtime, max, freq"),
+	OPT_STRING('C', "cpu", &kwork.cpu_list, "cpu",
+		   "list of cpus to profile"),
+	OPT_STRING('n', "name", &kwork.profile_name, "name",
+		   "event name to profile"),
+	OPT_STRING(0, "time", &kwork.time_str, "str",
+		   "Time span for analysis (start,stop)"),
+	OPT_STRING('i', "input", &input_name, "file",
+		   "input file name"),
+	OPT_BOOLEAN('S', "with-summary", &kwork.summary,
+		    "Show summary with statistics"),
+	OPT_PARENT(kwork_options)
+	};
+	const struct option timehist_options[] = {
+	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
+		   "file", "vmlinux pathname"),
+	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
+		   "file", "kallsyms pathname"),
+	OPT_BOOLEAN('g', "call-graph", &kwork.show_callchain,
+		    "Display call chains if present"),
+	OPT_UINTEGER(0, "max-stack", &kwork.max_stack,
+		   "Maximum number of functions to display backtrace."),
+	OPT_STRING(0, "symfs", &symbol_conf.symfs, "directory",
+		    "Look for files with symbols relative to this directory"),
+	OPT_STRING(0, "time", &kwork.time_str, "str",
+		   "Time span for analysis (start,stop)"),
+	OPT_STRING('C', "cpu", &kwork.cpu_list, "cpu",
+		   "list of cpus to profile"),
+	OPT_STRING('n', "name", &kwork.profile_name, "name",
+		   "event name to profile"),
+	OPT_STRING('i', "input", &input_name, "file",
+		   "input file name"),
+	OPT_PARENT(kwork_options)
+	};
+
+	const char *kwork_usage[] = {
+		NULL,
+		NULL
+	};
+	const char * const latency_usage[] = {
+		"perf kwork latency [<options>]",
+		NULL
+	};
+	const char * const report_usage[] = {
+		"perf kwork report [<options>]",
+		NULL
+	};
+	const char * const timehist_usage[] = {
+		"perf kwork timehist [<options>]",
+		NULL
+	};
+	const char *const kwork_subcommands[] = {
+		"record", "report", "latency", "timehist", NULL
+	};
+
+	argc = parse_options_subcommand(argc, argv, kwork_options,
+					kwork_subcommands, kwork_usage,
+					PARSE_OPT_STOP_AT_NON_OPTION);
+	if (!argc)
+		usage_with_options(kwork_usage, kwork_options);
+
+	setup_event_list(&kwork, kwork_options, kwork_usage);
+
+	if (strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
+		return perf_kwork__record(&kwork, argc, argv);
+	} else if (strlen(argv[0]) > 2 && strstarts("report", argv[0])) {
+		if (argc > 1) {
+			argc = parse_options(argc, argv, report_options, report_usage, 0);
+			if (argc)
+				usage_with_options(report_usage, report_options);
+		}
+	} else if (strlen(argv[0]) > 2 && strstarts("latency", argv[0])) {
+		if (argc > 1) {
+			argc = parse_options(argc, argv, latency_options, latency_usage, 0);
+			if (argc)
+				usage_with_options(latency_usage, latency_options);
+		}
+	} else if (strlen(argv[0]) > 2 && strstarts("timehist", argv[0])) {
+		if (argc > 1) {
+			argc = parse_options(argc, argv, timehist_options, timehist_usage, 0);
+			if (argc)
+				usage_with_options(timehist_usage, timehist_options);
+		}
+	} else
+		usage_with_options(kwork_usage, kwork_options);
+
+	return 0;
+}
diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
index 7303e80a639c..d03afea86217 100644
--- a/tools/perf/builtin.h
+++ b/tools/perf/builtin.h
@@ -38,6 +38,7 @@ int cmd_mem(int argc, const char **argv);
 int cmd_data(int argc, const char **argv);
 int cmd_ftrace(int argc, const char **argv);
 int cmd_daemon(int argc, const char **argv);
+int cmd_kwork(int argc, const char **argv);
 
 int find_scripts(char **scripts_array, char **scripts_path_array, int num,
 		 int pathlen);
diff --git a/tools/perf/command-list.txt b/tools/perf/command-list.txt
index 4aa034aefa33..295418840426 100644
--- a/tools/perf/command-list.txt
+++ b/tools/perf/command-list.txt
@@ -18,6 +18,7 @@ perf-iostat			mainporcelain common
 perf-kallsyms			mainporcelain common
 perf-kmem			mainporcelain common
 perf-kvm			mainporcelain common
+perf-kwork                      mainporcelain common
 perf-list			mainporcelain common
 perf-lock			mainporcelain common
 perf-mem			mainporcelain common
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 0170cb0819d6..c21b3973641a 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -91,6 +91,7 @@ static struct cmd_struct commands[] = {
 	{ "data",	cmd_data,	0 },
 	{ "ftrace",	cmd_ftrace,	0 },
 	{ "daemon",	cmd_daemon,	0 },
+	{ "kwork",	cmd_kwork,	0 },
 };
 
 struct pager_config {
-- 
2.30.GIT

