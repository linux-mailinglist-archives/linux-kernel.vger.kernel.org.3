Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EED5822C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiG0JH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiG0JGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:06:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5CE47BB0;
        Wed, 27 Jul 2022 02:06:25 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lt79V6kWpzjXXH;
        Wed, 27 Jul 2022 17:03:26 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 17:06:20 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 17:06:19 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <pc@us.ibm.com>, <yhs@fb.com>, <andrii.nakryiko@gmail.com>,
        <songliubraving@fb.com>, <yangjihong1@huawei.com>
Subject: [RFC v4 13/17] perf kwork: Implement perf kwork timehist
Date:   Wed, 27 Jul 2022 17:03:26 +0800
Message-ID: <20220727090330.107760-14-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20220727090330.107760-1-yangjihong1@huawei.com>
References: <20220727090330.107760-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implements framework of perf kwork timehist,
to provide an analysis of kernel work events.

Test cases:

  # perf kwork tim
   Runtime start      Runtime end        Cpu     Kwork name                      Runtime     Delaytime
                                                 (TYPE)NAME:NUM                  (msec)      (msec)
   -----------------  -----------------  ------  ------------------------------  ----------  ----------
        91576.060290       91576.060344  [0000]  (s)RCU:9                             0.055       0.111
        91576.061470       91576.061547  [0000]  (s)SCHED:7                           0.077       0.073
        91576.062604       91576.062697  [0001]  (s)RCU:9                             0.094       0.409
        91576.064443       91576.064517  [0002]  (s)RCU:9                             0.074       0.114
        91576.065144       91576.065211  [0000]  (s)SCHED:7                           0.067       0.058
        91576.066564       91576.066609  [0003]  (s)RCU:9                             0.045       0.110
        91576.068495       91576.068559  [0000]  (s)SCHED:7                           0.064       0.059
        91576.068900       91576.068996  [0004]  (s)RCU:9                             0.096       0.726
        91576.069364       91576.069420  [0002]  (s)RCU:9                             0.056       0.082
        91576.069649       91576.069701  [0004]  (s)RCU:9                             0.052       0.111
        91576.070147       91576.070206  [0000]  (s)SCHED:7                           0.060       0.057
        91576.073147       91576.073202  [0000]  (s)SCHED:7                           0.054       0.060
  <SNIP>

  # perf kwork tim --max-stack 2 -g
   Runtime start      Runtime end        Cpu     Kwork name                      Runtime     Delaytime
                                                 (TYPE)NAME:NUM                  (msec)      (msec)
   -----------------  -----------------  ------  ------------------------------  ----------  ----------
        91576.060290       91576.060344  [0000]  (s)RCU:9                             0.055       0.111   irq_exit_rcu <- sysvec_apic_timer_interrupt
        91576.061470       91576.061547  [0000]  (s)SCHED:7                           0.077       0.073   irq_exit_rcu <- sysvec_call_function_single
        91576.062604       91576.062697  [0001]  (s)RCU:9                             0.094       0.409   irq_exit_rcu <- sysvec_apic_timer_interrupt
        91576.064443       91576.064517  [0002]  (s)RCU:9                             0.074       0.114   irq_exit_rcu <- sysvec_apic_timer_interrupt
        91576.065144       91576.065211  [0000]  (s)SCHED:7                           0.067       0.058   irq_exit_rcu <- sysvec_call_function_single
        91576.066564       91576.066609  [0003]  (s)RCU:9                             0.045       0.110   irq_exit_rcu <- sysvec_apic_timer_interrupt
        91576.068495       91576.068559  [0000]  (s)SCHED:7                           0.064       0.059   irq_exit_rcu <- sysvec_call_function_single
        91576.068900       91576.068996  [0004]  (s)RCU:9                             0.096       0.726   irq_exit_rcu <- sysvec_apic_timer_interrupt
        91576.069364       91576.069420  [0002]  (s)RCU:9                             0.056       0.082   irq_exit_rcu <- sysvec_apic_timer_interrupt
        91576.069649       91576.069701  [0004]  (s)RCU:9                             0.052       0.111   irq_exit_rcu <- sysvec_apic_timer_interrupt
  <SNIP>

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/Documentation/perf-kwork.txt |  65 ++++++
 tools/perf/builtin-kwork.c              | 299 +++++++++++++++++++++++-
 tools/perf/util/kwork.h                 |   3 +
 3 files changed, 366 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-kwork.txt b/tools/perf/Documentation/perf-kwork.txt
index 069981457de1..51c1625bacae 100644
--- a/tools/perf/Documentation/perf-kwork.txt
+++ b/tools/perf/Documentation/perf-kwork.txt
@@ -21,10 +21,36 @@ There are several variants of 'perf kwork':
 
   'perf kwork latency' to report the per kwork latencies.
 
+  'perf kwork timehist' provides an analysis of kernel work events.
+
     Example usage:
         perf kwork record -- sleep 1
         perf kwork report
         perf kwork latency
+        perf kwork timehist
+
+   By default it shows the individual work events such as irq, workqeueu,
+   including the run time and delay (time between raise and actually entry):
+
+      Runtime start      Runtime end        Cpu     Kwork name                 Runtime     Delaytime
+                                                    (TYPE)NAME:NUM             (msec)      (msec)
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
+      1811186.989860     1811186.991826  [0002]  (w)vmstat_shepherd              1.966       0.345
+    ...
+
+   Times are in msec.usec.
 
 OPTIONS
 -------
@@ -100,6 +126,45 @@ OPTIONS for 'perf kwork latency'
 	stop time is not given (i.e, time string is 'x.y,') then analysis goes
 	to end of file.
 
+OPTIONS for 'perf kwork timehist'
+---------------------------------
+
+-C::
+--cpu::
+	Only show events for the given CPU(s) (comma separated list).
+
+-g::
+--call-graph::
+	Display call chains if present (default off).
+
+-i::
+--input::
+	Input file name. (default: perf.data unless stdin is a fifo)
+
+-k::
+--vmlinux=<file>::
+	Vmlinux pathname
+
+-n::
+--name::
+	Only show events for the given name.
+
+--kallsyms=<file>::
+	Kallsyms pathname
+
+--max-stack::
+	Maximum number of functions to display in backtrace, default 5.
+
+--symfs=<directory>::
+    Look for files with symbols relative to this directory.
+
+--time::
+	Only analyze samples within given time window: <start>,<stop>. Times
+	have the format seconds.microseconds. If start is not given (i.e., time
+	string is ',x.y') then analysis starts at the beginning of the file. If
+	stop time is not given (i.e, time string is 'x.y,') then analysis goes
+	to end of file.
+
 SEE ALSO
 --------
 linkperf:perf-record[1]
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 245e4aae258e..dc5fca1863f6 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -35,10 +35,12 @@
 #define PRINT_TIMESTAMP_WIDTH 17
 #define PRINT_KWORK_NAME_WIDTH 30
 #define RPINT_DECIMAL_WIDTH 3
+#define PRINT_BRACKETPAIR_WIDTH 2
 #define PRINT_TIME_UNIT_SEC_WIDTH 2
 #define PRINT_TIME_UNIT_MESC_WIDTH 3
 #define PRINT_RUNTIME_HEADER_WIDTH (PRINT_RUNTIME_WIDTH + PRINT_TIME_UNIT_MESC_WIDTH)
 #define PRINT_LATENCY_HEADER_WIDTH (PRINT_LATENCY_WIDTH + PRINT_TIME_UNIT_MESC_WIDTH)
+#define PRINT_TIMEHIST_CPU_WIDTH (PRINT_CPU_WIDTH + PRINT_BRACKETPAIR_WIDTH)
 #define PRINT_TIMESTAMP_HEADER_WIDTH (PRINT_TIMESTAMP_WIDTH + PRINT_TIME_UNIT_SEC_WIDTH)
 
 struct sort_dimension {
@@ -575,6 +577,185 @@ static int latency_entry_event(struct perf_kwork *kwork,
 	return 0;
 }
 
+static void timehist_save_callchain(struct perf_kwork *kwork,
+				    struct perf_sample *sample,
+				    struct evsel *evsel,
+				    struct machine *machine)
+{
+	struct symbol *sym;
+	struct thread *thread;
+	struct callchain_cursor_node *node;
+	struct callchain_cursor *cursor = &callchain_cursor;
+
+	if (!kwork->show_callchain || sample->callchain == NULL)
+		return;
+
+	/* want main thread for process - has maps */
+	thread = machine__findnew_thread(machine, sample->pid, sample->pid);
+	if (thread == NULL) {
+		pr_debug("Failed to get thread for pid %d\n", sample->pid);
+		return;
+	}
+
+	if (thread__resolve_callchain(thread, cursor, evsel, sample,
+				      NULL, NULL, kwork->max_stack + 2) != 0) {
+		pr_debug("Failed to resolve callchain, skipping\n");
+		goto out_put;
+	}
+
+	callchain_cursor_commit(cursor);
+
+	while (true) {
+		node = callchain_cursor_current(cursor);
+		if (node == NULL)
+			break;
+
+		sym = node->ms.sym;
+		if (sym) {
+			if (!strcmp(sym->name, "__softirqentry_text_start") ||
+			    !strcmp(sym->name, "__do_softirq"))
+				sym->ignore = 1;
+		}
+
+		callchain_cursor_advance(cursor);
+	}
+
+out_put:
+	thread__put(thread);
+}
+
+static void timehist_print_event(struct perf_kwork *kwork,
+				 struct kwork_work *work,
+				 struct kwork_atom *atom,
+				 struct perf_sample *sample,
+				 struct addr_location *al)
+{
+	char entrytime[32], exittime[32];
+	char kwork_name[PRINT_KWORK_NAME_WIDTH];
+
+	/*
+	 * runtime start
+	 */
+	timestamp__scnprintf_usec(atom->time,
+				  entrytime, sizeof(entrytime));
+	printf(" %*s ", PRINT_TIMESTAMP_WIDTH, entrytime);
+
+	/*
+	 * runtime end
+	 */
+	timestamp__scnprintf_usec(sample->time,
+				  exittime, sizeof(exittime));
+	printf(" %*s ", PRINT_TIMESTAMP_WIDTH, exittime);
+
+	/*
+	 * cpu
+	 */
+	printf(" [%0*d] ", PRINT_CPU_WIDTH, work->cpu);
+
+	/*
+	 * kwork name
+	 */
+	if (work->class && work->class->work_name) {
+		work->class->work_name(work, kwork_name,
+				       PRINT_KWORK_NAME_WIDTH);
+		printf(" %-*s ", PRINT_KWORK_NAME_WIDTH, kwork_name);
+	} else
+		printf(" %-*s ", PRINT_KWORK_NAME_WIDTH, "");
+
+	/*
+	 *runtime
+	 */
+	printf(" %*.*f ",
+	       PRINT_RUNTIME_WIDTH, RPINT_DECIMAL_WIDTH,
+	       (double)(sample->time - atom->time) / NSEC_PER_MSEC);
+
+	/*
+	 * delaytime
+	 */
+	if (atom->prev != NULL) {
+		printf(" %*.*f ", PRINT_LATENCY_WIDTH, RPINT_DECIMAL_WIDTH,
+		       (double)(atom->time - atom->prev->time) / NSEC_PER_MSEC);
+	} else
+		printf(" %*s ", PRINT_LATENCY_WIDTH, " ");
+
+	/*
+	 * callchain
+	 */
+	if (kwork->show_callchain) {
+		printf(" ");
+		sample__fprintf_sym(sample, al, 0,
+				    EVSEL__PRINT_SYM | EVSEL__PRINT_ONELINE |
+				    EVSEL__PRINT_CALLCHAIN_ARROW |
+				    EVSEL__PRINT_SKIP_IGNORED,
+				    &callchain_cursor, symbol_conf.bt_stop_list,
+				    stdout);
+	}
+
+	printf("\n");
+}
+
+static int timehist_raise_event(struct perf_kwork *kwork,
+				struct kwork_class *class,
+				struct evsel *evsel,
+				struct perf_sample *sample,
+				struct machine *machine)
+{
+	return work_push_atom(kwork, class, KWORK_TRACE_RAISE,
+			      KWORK_TRACE_MAX, evsel, sample,
+			      machine, NULL);
+}
+
+static int timehist_entry_event(struct perf_kwork *kwork,
+				struct kwork_class *class,
+				struct evsel *evsel,
+				struct perf_sample *sample,
+				struct machine *machine)
+{
+	int ret;
+	struct kwork_work *work = NULL;
+
+	ret = work_push_atom(kwork, class, KWORK_TRACE_ENTRY,
+			     KWORK_TRACE_RAISE, evsel, sample,
+			     machine, &work);
+	if (ret)
+		return ret;
+
+	if (work != NULL)
+		timehist_save_callchain(kwork, sample, evsel, machine);
+
+	return 0;
+}
+
+static int timehist_exit_event(struct perf_kwork *kwork,
+			       struct kwork_class *class,
+			       struct evsel *evsel,
+			       struct perf_sample *sample,
+			       struct machine *machine)
+{
+	struct kwork_atom *atom = NULL;
+	struct kwork_work *work = NULL;
+	struct addr_location al;
+
+	if (machine__resolve(machine, &al, sample) < 0) {
+		pr_debug("Problem processing event, skipping it\n");
+		return -1;
+	}
+
+	atom = work_pop_atom(kwork, class, KWORK_TRACE_EXIT,
+			     KWORK_TRACE_ENTRY, evsel, sample,
+			     machine, &work);
+	if (work == NULL)
+		return -1;
+
+	if (atom != NULL) {
+		work->nr_atoms++;
+		timehist_print_event(kwork, work, atom, sample, &al);
+		atom_del(atom);
+	}
+
+	return 0;
+}
+
 static struct kwork_class kwork_irq;
 static int process_irq_handler_entry_event(struct perf_tool *tool,
 					   struct evsel *evsel,
@@ -1006,6 +1187,42 @@ static int report_print_header(struct perf_kwork *kwork)
 	return ret;
 }
 
+static void timehist_print_header(void)
+{
+	/*
+	 * header row
+	 */
+	printf(" %-*s  %-*s  %-*s  %-*s  %-*s  %-*s\n",
+	       PRINT_TIMESTAMP_WIDTH, "Runtime start",
+	       PRINT_TIMESTAMP_WIDTH, "Runtime end",
+	       PRINT_TIMEHIST_CPU_WIDTH, "Cpu",
+	       PRINT_KWORK_NAME_WIDTH, "Kwork name",
+	       PRINT_RUNTIME_WIDTH, "Runtime",
+	       PRINT_RUNTIME_WIDTH, "Delaytime");
+
+	/*
+	 * units row
+	 */
+	printf(" %-*s  %-*s  %-*s  %-*s  %-*s  %-*s\n",
+	       PRINT_TIMESTAMP_WIDTH, "",
+	       PRINT_TIMESTAMP_WIDTH, "",
+	       PRINT_TIMEHIST_CPU_WIDTH, "",
+	       PRINT_KWORK_NAME_WIDTH, "(TYPE)NAME:NUM",
+	       PRINT_RUNTIME_WIDTH, "(msec)",
+	       PRINT_RUNTIME_WIDTH, "(msec)");
+
+	/*
+	 * separator
+	 */
+	printf(" %.*s  %.*s  %.*s  %.*s  %.*s  %.*s\n",
+	       PRINT_TIMESTAMP_WIDTH, graph_dotted_line,
+	       PRINT_TIMESTAMP_WIDTH, graph_dotted_line,
+	       PRINT_TIMEHIST_CPU_WIDTH, graph_dotted_line,
+	       PRINT_KWORK_NAME_WIDTH, graph_dotted_line,
+	       PRINT_RUNTIME_WIDTH, graph_dotted_line,
+	       PRINT_RUNTIME_WIDTH, graph_dotted_line);
+}
+
 static void print_summary(struct perf_kwork *kwork)
 {
 	u64 time = kwork->timeend - kwork->timestart;
@@ -1101,6 +1318,7 @@ static int perf_kwork__check_config(struct perf_kwork *kwork,
 				    struct perf_session *session)
 {
 	int ret;
+	struct evsel *evsel;
 	struct kwork_class *class;
 
 	static struct trace_kwork_handler report_ops = {
@@ -1111,6 +1329,11 @@ static int perf_kwork__check_config(struct perf_kwork *kwork,
 		.raise_event = latency_raise_event,
 		.entry_event = latency_entry_event,
 	};
+	static struct trace_kwork_handler timehist_ops = {
+		.raise_event = timehist_raise_event,
+		.entry_event = timehist_entry_event,
+		.exit_event  = timehist_exit_event,
+	};
 
 	switch (kwork->report) {
 	case KWORK_REPORT_RUNTIME:
@@ -1119,6 +1342,9 @@ static int perf_kwork__check_config(struct perf_kwork *kwork,
 	case KWORK_REPORT_LATENCY:
 		kwork->tp_handler = &latency_ops;
 		break;
+	case KWORK_REPORT_TIMEHIST:
+		kwork->tp_handler = &timehist_ops;
+		break;
 	default:
 		pr_debug("Invalid report type %d\n", kwork->report);
 		return -1;
@@ -1148,6 +1374,14 @@ static int perf_kwork__check_config(struct perf_kwork *kwork,
 		}
 	}
 
+	list_for_each_entry(evsel, &session->evlist->core.entries, core.node) {
+		if (kwork->show_callchain && !evsel__has_callchain(evsel)) {
+			pr_debug("Samples do not have callchains\n");
+			kwork->show_callchain = 0;
+			symbol_conf.use_callchain = 0;
+		}
+	}
+
 	return 0;
 }
 
@@ -1181,6 +1415,9 @@ static int perf_kwork__read_events(struct perf_kwork *kwork)
 		goto out_delete;
 	}
 
+	if (kwork->report == KWORK_REPORT_TIMEHIST)
+		timehist_print_header();
+
 	ret = perf_session__process_events(session);
 	if (ret) {
 		pr_debug("Failed to process events, error %d\n", ret);
@@ -1274,6 +1511,31 @@ static int perf_kwork__process_tracepoint_sample(struct perf_tool *tool,
 	return err;
 }
 
+static int perf_kwork__timehist(struct perf_kwork *kwork)
+{
+	/*
+	 * event handlers for timehist option
+	 */
+	kwork->tool.comm	 = perf_event__process_comm;
+	kwork->tool.exit	 = perf_event__process_exit;
+	kwork->tool.fork	 = perf_event__process_fork;
+	kwork->tool.attr	 = perf_event__process_attr;
+	kwork->tool.tracing_data = perf_event__process_tracing_data;
+	kwork->tool.build_id	 = perf_event__process_build_id;
+	kwork->tool.ordered_events = true;
+	kwork->tool.ordering_requires_timestamps = true;
+	symbol_conf.use_callchain = kwork->show_callchain;
+
+	if (symbol__validate_sym_arguments()) {
+		pr_err("Failed to validate sym arguments\n");
+		return -1;
+	}
+
+	setup_pager();
+
+	return perf_kwork__read_events(kwork);
+}
+
 static void setup_event_list(struct perf_kwork *kwork,
 			     const struct option *options,
 			     const char * const usage_msg[])
@@ -1391,6 +1653,8 @@ int cmd_kwork(int argc, const char **argv)
 		.event_list_str      = NULL,
 		.summary             = false,
 		.sort_order          = NULL,
+		.show_callchain      = false,
+		.max_stack           = 5,
 
 		.timestart           = 0,
 		.timeend             = 0,
@@ -1439,6 +1703,27 @@ int cmd_kwork(int argc, const char **argv)
 		   "input file name"),
 	OPT_PARENT(kwork_options)
 	};
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
 	const char *kwork_usage[] = {
 		NULL,
 		NULL
@@ -1451,8 +1736,12 @@ int cmd_kwork(int argc, const char **argv)
 		"perf kwork latency [<options>]",
 		NULL
 	};
+	const char * const timehist_usage[] = {
+		"perf kwork timehist [<options>]",
+		NULL
+	};
 	const char *const kwork_subcommands[] = {
-		"record", "report", "latency", NULL
+		"record", "report", "latency", "timehist", NULL
 	};
 
 	argc = parse_options_subcommand(argc, argv, kwork_options,
@@ -1486,6 +1775,14 @@ int cmd_kwork(int argc, const char **argv)
 		kwork.report = KWORK_REPORT_LATENCY;
 		setup_sorting(&kwork, latency_options, latency_usage);
 		return perf_kwork__report(&kwork);
+	} else if (strlen(argv[0]) > 2 && strstarts("timehist", argv[0])) {
+		if (argc > 1) {
+			argc = parse_options(argc, argv, timehist_options, timehist_usage, 0);
+			if (argc)
+				usage_with_options(timehist_usage, timehist_options);
+		}
+		kwork.report = KWORK_REPORT_TIMEHIST;
+		return perf_kwork__timehist(&kwork);
 	} else
 		usage_with_options(kwork_usage, kwork_options);
 
diff --git a/tools/perf/util/kwork.h b/tools/perf/util/kwork.h
index e540373ab14e..6a06194304b8 100644
--- a/tools/perf/util/kwork.h
+++ b/tools/perf/util/kwork.h
@@ -22,6 +22,7 @@ enum kwork_class_type {
 enum kwork_report_type {
 	KWORK_REPORT_RUNTIME,
 	KWORK_REPORT_LATENCY,
+	KWORK_REPORT_TIMEHIST,
 };
 
 enum kwork_trace_type {
@@ -200,6 +201,8 @@ struct perf_kwork {
 	 */
 	bool summary;
 	const char *sort_order;
+	bool show_callchain;
+	unsigned int max_stack;
 
 	/*
 	 * statistics
-- 
2.30.GIT

