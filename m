Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278525483E0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241390AbiFMJuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241148AbiFMJtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:49:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5895D1ADAC;
        Mon, 13 Jun 2022 02:49:22 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LM6F471YdzjXg7;
        Mon, 13 Jun 2022 17:47:52 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:09 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:08 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [RFC 13/13] perf kwork: Implement perf kwork timehist
Date:   Mon, 13 Jun 2022 17:46:05 +0800
Message-ID: <20220613094605.208401-14-yangjihong1@huawei.com>
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

Implements framework of perf kwork timehist, to provide an analysis of kernel work events.

test case:

  # perf kwork tim
   Runtime start      Runtime end        Cpu     Kwork name                 Runtime     Delaytime
                                                 (TYPE)NAME:NUM             (msec)      (msec)
   -----------------  -----------------  ------  -------------------------  ----------  ----------
      2072616.355256     2072616.355295  [0000]  (s)SCHED:7                      0.040       0.062
      2072616.356794     2072616.356865  [0001]  (s)RCU:9                        0.071       0.083
      2072616.358362     2072616.358406  [0002]  (s)RCU:9                        0.044       0.108
      2072616.360179     2072616.360211  [0000]  (s)SCHED:7                      0.032       0.032
      2072616.360608     2072616.360729  [0003]  (s)TIMER:1                      0.120       0.311
      2072616.360753     2072616.360803  [0003]  (s)SCHED:7                      0.050       0.199
      2072616.362232     2072616.362295  [0001]  (s)RCU:9                        0.063       0.071
      2072616.363177     2072616.363229  [0000]  (s)SCHED:7                      0.052       0.030
      2072616.365407     2072616.365502  [0003]  (s)TIMER:1                      0.096       0.106
      2072616.365527     2072616.365595  [0003]  (s)SCHED:7                      0.068       0.162
      2072616.365616     2072616.365670  [0003]  (s)RCU:9                        0.053       0.290
      2072616.366171     2072616.366211  [0000]  (s)SCHED:7                      0.040       0.029
      2072616.366372     2072616.366435  [0001]  (s)SCHED:7                      0.063       0.053
      2072616.369351     2072616.369434  [0003]  (s)TIMER:1                      0.083       0.060
      2072616.369937     2072616.369998  [0005]  (s)SCHED:7                      0.061       0.042
      2072616.370391     2072616.370440  [0006]  (s)SCHED:7                      0.049       0.081
      2072616.370461     2072616.370510  [0006]  (s)RCU:9                        0.049       1.338
      2072616.370020     2072616.372415  [0005]  (s)RCU:9                        2.395       1.757
      2072616.372624     2072616.372689  [0006]  (s)SCHED:7                      0.065       0.047
      2072616.373171     2072616.373226  [0000]  (s)SCHED:7                      0.055       0.029
      2072616.373589     2072616.373621  [0003]  (s)TIMER:1                      0.032       0.375
      2072616.375176     2072616.375353  [0000]  (s)SCHED:7                      0.177       0.031
      2072616.375539     2072616.375587  [0001]  (s)RCU:9                        0.048       0.082
      2072616.377183     2072616.377215  [0000]  (s)SCHED:7                      0.032       0.032
      2072616.379190     2072616.379222  [0000]  (s)SCHED:7                      0.033       0.032
      2072616.379475     2072616.379579  [0007]  (s)RCU:9                        0.105       0.288
      2072616.379832     2072616.379923  [0000]  virtio0-requests:25             0.090
      2072616.380339     2072616.380392  [0007]  (s)SCHED:7                      0.054       0.064
      2072616.382425     2072616.382486  [0007]  (s)RCU:9                        0.061       1.181
      2072616.383339     2072616.383387  [0002]  (s)RCU:9                        0.047       1.222
      2072616.384265     2072616.384314  [0003]  (s)SCHED:7                      0.050       0.082
      2072616.384824     2072616.384875  [0007]  (s)RCU:9                        0.051       1.506
      2072616.385319     2072616.385361  [0002]  (s)RCU:9                        0.042       1.088
      2072616.386321     2072616.386413  [0003]  (s)TIMER:1                      0.091       0.107
      2072616.386438     2072616.386515  [0003]  (s)SCHED:7                      0.078       0.159
      2072616.386537     2072616.386575  [0003]  (s)RCU:9                        0.038       0.298
      2072616.386068     2072616.387057  [0000]  virtio0-requests:25             0.989
      2072616.387057     2072616.387057  [0000]  (s)SCHED:7                      0.000       0.989
      2072616.387057     2072616.387057  [0000]  (s)SCHED:7                      0.000       0.989
      2072616.387726     2072616.387781  [0002]  (s)RCU:9                        0.055       1.512
      2072616.387025     2072616.388331  [0007]  (s)SCHED:7                      1.306       0.052
      2072616.388358     2072616.388404  [0007]  (s)RCU:9                        0.046       0.409
      2072616.388527     2072616.388573  [0007]  (s)SCHED:7                      0.046       0.264
      2072616.388595     2072616.388619  [0007]  (s)RCU:9                        0.024       2.890
      2072616.390267     2072616.390353  [0003]  (s)TIMER:1                      0.086       0.066
      2072616.390949     2072616.391060  [0007]  (s)RCU:9                        0.111       1.711
      2072616.391290     2072616.391340  [0002]  (s)RCU:9                        0.050       1.125
      2072616.392304     2072616.392353  [0007]  (s)RCU:9                        0.049       0.456
  ...

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 253 +++++++++++++++++++++++++++++++++++++
 1 file changed, 253 insertions(+)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 7e3da243ccd8..0ab34e3480fe 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -41,6 +41,7 @@ enum kwork_trace_type {
 enum kwork_report_type {
 	KWORK_REPORT_RUNTIME,
 	KWORK_REPORT_LATENCY,
+	KWORK_REPORT_TIMEHIST,
 };
 
 /*
@@ -213,10 +214,12 @@ struct perf_kwork {
 #define PRINT_TIMESTAMP_WIDTH 17
 #define PRINT_KWORK_NAME_WIDTH 25
 #define RPINT_DECIMAL_WIDTH 3
+#define PRINT_BRACKETPAIR_WIDTH 2
 #define PRINT_TIME_UNIT_SEC_WIDTH 2
 #define PRINT_TIME_UNIT_MESC_WIDTH 3
 #define PRINT_RUNTIME_HEADER_WIDTH (PRINT_RUNTIME_WIDTH + PRINT_TIME_UNIT_MESC_WIDTH)
 #define PRINT_LATENCY_HEADER_WIDTH (PRINT_LATENCY_WIDTH + PRINT_TIME_UNIT_MESC_WIDTH)
+#define PRINT_TIMEHIST_CPU_WIDTH (PRINT_CPU_WIDTH + PRINT_BRACKETPAIR_WIDTH)
 #define PRINT_TIMESTAMP_HEADER_WIDTH (PRINT_TIMESTAMP_WIDTH + PRINT_TIME_UNIT_SEC_WIDTH)
 
 struct sort_dimension {
@@ -746,6 +749,181 @@ static int latency_entry_event(struct perf_kwork *kwork,
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
+			if (!strcmp(sym->name, "__softirqentry_text_start"))
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
+				 struct kwork_cluster *cluster,
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
+	printf(" [%0*d] ", PRINT_CPU_WIDTH, cluster->cpu);
+
+	/*
+	 * kwork name
+	 */
+	if (cluster->class && cluster->class->cluster_name) {
+		cluster->class->cluster_name(cluster, kwork_name,
+					     PRINT_KWORK_NAME_WIDTH);
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
+	if (atom->prev != NULL)
+		printf(" %*.*f ", PRINT_LATENCY_WIDTH, RPINT_DECIMAL_WIDTH,
+		       (double)(atom->time - atom->prev->time) / NSEC_PER_MSEC);
+	else
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
+				struct machine *machine __maybe_unused)
+{
+	return cluster_push_atom(kwork, class, KWORK_TRACE_RAISE,
+				 KWORK_TRACE_MAX, evsel, sample, NULL);
+}
+
+static int timehist_entry_event(struct perf_kwork *kwork,
+				struct kwork_class *class,
+				struct evsel *evsel,
+				struct perf_sample *sample,
+				struct machine *machine)
+{
+	int ret;
+	struct kwork_cluster *cluster = NULL;
+
+	ret = cluster_push_atom(kwork, class, KWORK_TRACE_ENTRY,
+				KWORK_TRACE_RAISE, evsel, sample, &cluster);
+	if (ret)
+		return ret;
+
+	if (cluster != NULL)
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
+	struct kwork_cluster *cluster = NULL;
+	struct addr_location al;
+
+	if (machine__resolve(machine, &al, sample) < 0) {
+		pr_debug("Problem processing event, skipping it\n");
+		return -1;
+	}
+
+	atom = cluster_pop_atom(kwork, class, KWORK_TRACE_EXIT,
+				KWORK_TRACE_ENTRY, evsel, sample, &cluster);
+	if (cluster == NULL)
+		return -1;
+
+	if (atom != NULL) {
+		cluster->nr_atoms++;
+		timehist_print_event(kwork, cluster, atom, sample, &al);
+		atom_del(atom);
+	}
+
+	return 0;
+}
+
 static struct kwork_class kwork_irq;
 static int process_irq_handler_entry_event(struct perf_tool *tool,
 					   struct evsel *evsel,
@@ -1149,6 +1327,42 @@ static int report_print_header(struct perf_kwork *kwork)
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
@@ -1294,6 +1508,11 @@ static int perf_kwork__check_config(struct perf_kwork *kwork,
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
@@ -1302,6 +1521,9 @@ static int perf_kwork__check_config(struct perf_kwork *kwork,
 	case KWORK_REPORT_LATENCY:
 		kwork->tp_handler = &latency_ops;
 		break;
+	case KWORK_REPORT_TIMEHIST:
+		kwork->tp_handler = &timehist_ops;
+		break;
 	default:
 		pr_debug("Invalid report type %d\n", kwork->report);
 		break;
@@ -1364,6 +1586,9 @@ static int perf_kwork__read_events(struct perf_kwork *kwork)
 	if (perf_kwork__check_config(kwork, session) != 0)
 		goto out_delete;
 
+	if (kwork->report == KWORK_REPORT_TIMEHIST)
+		timehist_print_header();
+
 	ret = perf_session__process_events(session);
 	if (ret) {
 		pr_debug("Failed to process events, error %d\n", ret);
@@ -1379,6 +1604,28 @@ static int perf_kwork__read_events(struct perf_kwork *kwork)
 	return ret;
 }
 
+static int perf_kwork__timehist(struct perf_kwork *kwork)
+{
+	/*
+	 * event handlers for timehist option
+	 */
+	kwork->tool.mmap	 = perf_event__process_mmap;
+	kwork->tool.mmap2	 = perf_event__process_mmap2;
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
+	setup_pager();
+
+	return perf_kwork__read_events(kwork);
+}
+
 static void process_skipped_events(struct perf_kwork *kwork,
 				   struct kwork_cluster *cluster)
 {
@@ -1505,6 +1752,7 @@ static int perf_kwork__record(struct perf_kwork *kwork,
 
 int cmd_kwork(int argc, const char **argv)
 {
+	int ret;
 	static const char default_report_sort_order[] = "runtime, max, freq";
 	static const char default_latency_sort_order[] = "avg, max, freq";
 	static struct perf_kwork kwork = {
@@ -1655,6 +1903,11 @@ int cmd_kwork(int argc, const char **argv)
 			if (argc)
 				usage_with_options(timehist_usage, timehist_options);
 		}
+		ret = symbol__validate_sym_arguments();
+		if (ret)
+			return ret;
+		kwork.report = KWORK_REPORT_TIMEHIST;
+		return perf_kwork__timehist(&kwork);
 	} else
 		usage_with_options(kwork_usage, kwork_options);
 
-- 
2.30.GIT

