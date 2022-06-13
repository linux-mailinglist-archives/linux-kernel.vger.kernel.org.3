Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF88F548459
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241319AbiFMJuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241331AbiFMJty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:49:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E311ADAA;
        Mon, 13 Jun 2022 02:49:22 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LM6F46fh4zjXfm;
        Mon, 13 Jun 2022 17:47:52 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:08 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:07 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [RFC 10/13] perf kwork: Implement perf kwork latency
Date:   Mon, 13 Jun 2022 17:46:02 +0800
Message-ID: <20220613094605.208401-11-yangjihong1@huawei.com>
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

Implements framework of perf kwork latency, which is used to report time
properties such as delay time and frequency.

test case:

  Kwork Name                | Cpu  | Avg delay     | Frequency | Max delay     | Max delay start     | Max delay end       |
 ---------------------------------------------------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------------------------------------------------
  INFO: 37.324% skipped events (33174 including 0 raise, 33174 entry, 0 exit)

Since there are no latency-enabled events, the output is empty.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 153 +++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index f27ffad223a3..84e318eea832 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -32,6 +32,7 @@ enum kwork_class_type {
 };
 
 enum kwork_trace_type {
+	KWORK_TRACE_RAISE,
 	KWORK_TRACE_ENTRY,
 	KWORK_TRACE_EXIT,
 	KWORK_TRACE_MAX,
@@ -39,6 +40,7 @@ enum kwork_trace_type {
 
 enum kwork_report_type {
 	KWORK_REPORT_RUNTIME,
+	KWORK_REPORT_LATENCY,
 };
 
 /*
@@ -104,6 +106,14 @@ struct kwork_cluster {
 	u64 max_runtime_start;
 	u64 max_runtime_end;
 	u64 total_runtime;
+
+	/*
+	 * latency report
+	 */
+	u64 max_latency;
+	u64 max_latency_start;
+	u64 max_latency_end;
+	u64 total_latency;
 };
 
 struct kwork_class {
@@ -128,6 +138,10 @@ struct kwork_class {
 
 struct perf_kwork;
 struct trace_kwork_handler {
+	int (*raise_event)(struct perf_kwork *kwork,
+			   struct kwork_class *class, struct evsel *evsel,
+			   struct perf_sample *sample, struct machine *machine);
+
 	int (*entry_event)(struct perf_kwork *kwork,
 			   struct kwork_class *class, struct evsel *evsel,
 			   struct perf_sample *sample, struct machine *machine);
@@ -195,12 +209,14 @@ struct perf_kwork {
 #define PRINT_CPU_WIDTH 4
 #define PRINT_FREQ_WIDTH 9
 #define PRINT_RUNTIME_WIDTH 10
+#define PRINT_LATENCY_WIDTH 10
 #define PRINT_TIMESTAMP_WIDTH 17
 #define PRINT_KWORK_NAME_WIDTH 25
 #define RPINT_DECIMAL_WIDTH 3
 #define PRINT_TIME_UNIT_SEC_WIDTH 2
 #define PRINT_TIME_UNIT_MESC_WIDTH 3
 #define PRINT_RUNTIME_HEADER_WIDTH (PRINT_RUNTIME_WIDTH + PRINT_TIME_UNIT_MESC_WIDTH)
+#define PRINT_LATENCY_HEADER_WIDTH (PRINT_LATENCY_WIDTH + PRINT_TIME_UNIT_MESC_WIDTH)
 #define PRINT_TIMESTAMP_HEADER_WIDTH (PRINT_TIMESTAMP_WIDTH + PRINT_TIME_UNIT_SEC_WIDTH)
 
 struct sort_dimension {
@@ -254,6 +270,36 @@ static int max_runtime_cmp(struct kwork_cluster *l, struct kwork_cluster *r)
 	return 0;
 }
 
+static int avg_latency_cmp(struct kwork_cluster *l, struct kwork_cluster *r)
+{
+	u64 avgl, avgr;
+
+	if (!r->nr_atoms)
+		return 1;
+	if (!l->nr_atoms)
+		return -1;
+
+	avgl = l->total_latency / l->nr_atoms;
+	avgr = r->total_latency / r->nr_atoms;
+
+	if (avgl > avgr)
+		return 1;
+	if (avgl < avgr)
+		return -1;
+
+	return 0;
+}
+
+static int max_latency_cmp(struct kwork_cluster *l, struct kwork_cluster *r)
+{
+	if (l->max_latency > r->max_latency)
+		return 1;
+	if (l->max_latency < r->max_latency)
+		return -1;
+
+	return 0;
+}
+
 static int sort_dimension__add(struct perf_kwork *kwork __maybe_unused,
 			       const char *tok, struct list_head *list)
 {
@@ -274,13 +320,21 @@ static int sort_dimension__add(struct perf_kwork *kwork __maybe_unused,
 		.name = "freq",
 		.cmp  = freq_cmp,
 	};
+	static struct sort_dimension avg_sort_dimension = {
+		.name = "avg",
+		.cmp  = avg_latency_cmp,
+	};
 	struct sort_dimension *available_sorts[] = {
 		&id_sort_dimension,
 		&max_sort_dimension,
 		&freq_sort_dimension,
 		&runtime_sort_dimension,
+		&avg_sort_dimension,
 	};
 
+	if (kwork->report == KWORK_REPORT_LATENCY)
+		max_sort_dimension.cmp = max_latency_cmp;
+
 	for (i = 0; i < ARRAY_SIZE(available_sorts); i++) {
 		if (!strcmp(available_sorts[i]->name, tok)) {
 			list_add_tail(&available_sorts[i]->list, list);
@@ -639,6 +693,59 @@ static int report_exit_event(struct perf_kwork *kwork,
 	return 0;
 }
 
+static void latency_update_entry_event(struct kwork_cluster *cluster,
+				       struct kwork_atom *atom,
+				       struct perf_sample *sample)
+{
+	u64 delta;
+	u64 entry_time = sample->time;
+	u64 raise_time = atom->time;
+
+	if ((raise_time != 0) && (entry_time >= raise_time)) {
+		delta = entry_time - raise_time;
+		if ((delta > cluster->max_latency) ||
+		    (cluster->max_latency == 0)) {
+			cluster->max_latency = delta;
+			cluster->max_latency_start = raise_time;
+			cluster->max_latency_end = entry_time;
+		}
+		cluster->total_latency += delta;
+		cluster->nr_atoms++;
+	}
+}
+
+static int latency_raise_event(struct perf_kwork *kwork,
+			       struct kwork_class *class,
+			       struct evsel *evsel,
+			       struct perf_sample *sample,
+			       struct machine *machine __maybe_unused)
+{
+	return cluster_push_atom(kwork, class, KWORK_TRACE_RAISE,
+				 KWORK_TRACE_MAX, evsel, sample, NULL);
+}
+
+static int latency_entry_event(struct perf_kwork *kwork,
+			       struct kwork_class *class,
+			       struct evsel *evsel,
+			       struct perf_sample *sample,
+			       struct machine *machine __maybe_unused)
+{
+	struct kwork_atom *atom = NULL;
+	struct kwork_cluster *cluster = NULL;
+
+	atom = cluster_pop_atom(kwork, class, KWORK_TRACE_ENTRY,
+				KWORK_TRACE_RAISE, evsel, sample, &cluster);
+	if (cluster == NULL)
+		return -1;
+
+	if (atom != NULL) {
+		latency_update_entry_event(cluster, atom, sample);
+		atom_del(atom);
+	}
+
+	return 0;
+}
+
 static struct kwork_class kwork_irq;
 static int process_irq_handler_entry_event(struct perf_tool *tool,
 					   struct evsel *evsel,
@@ -903,6 +1010,7 @@ static void report_print_cluster(struct perf_kwork *kwork,
 	int ret = 0;
 	char kwork_name[PRINT_KWORK_NAME_WIDTH];
 	char max_runtime_start[32], max_runtime_end[32];
+	char max_latency_start[32], max_latency_end[32];
 
 	printf(" ");
 
@@ -928,6 +1036,14 @@ static void report_print_cluster(struct perf_kwork *kwork,
 		ret += printf(" %*.*f ms |",
 			      PRINT_RUNTIME_WIDTH, RPINT_DECIMAL_WIDTH,
 			      (double)cluster->total_runtime / NSEC_PER_MSEC);
+	/*
+	 * avg delay
+	 */
+	else if (kwork->report == KWORK_REPORT_LATENCY)
+		ret += printf(" %*.*f ms |",
+			      PRINT_LATENCY_WIDTH, RPINT_DECIMAL_WIDTH,
+			      (double)cluster->total_latency /
+			      cluster->nr_atoms / NSEC_PER_MSEC);
 
 	/*
 	 * frequency
@@ -951,6 +1067,22 @@ static void report_print_cluster(struct perf_kwork *kwork,
 			      PRINT_TIMESTAMP_WIDTH, max_runtime_start,
 			      PRINT_TIMESTAMP_WIDTH, max_runtime_end);
 	}
+	/*
+	 * max delay, max delay start, max delay end
+	 */
+	else if (kwork->report == KWORK_REPORT_LATENCY) {
+		timestamp__scnprintf_usec(cluster->max_latency_start,
+					  max_latency_start,
+					  sizeof(max_latency_start));
+		timestamp__scnprintf_usec(cluster->max_latency_end,
+					  max_latency_end,
+					  sizeof(max_latency_end));
+		ret += printf(" %*.*f ms | %*s s | %*s s |",
+			      PRINT_LATENCY_WIDTH, RPINT_DECIMAL_WIDTH,
+			      (double)cluster->max_latency / NSEC_PER_MSEC,
+			      PRINT_TIMESTAMP_WIDTH, max_latency_start,
+			      PRINT_TIMESTAMP_WIDTH, max_latency_end);
+	}
 
 	printf("\n");
 }
@@ -967,6 +1099,9 @@ static int report_print_header(struct perf_kwork *kwork)
 	if (kwork->report == KWORK_REPORT_RUNTIME)
 		ret += printf(" %-*s |",
 			      PRINT_RUNTIME_HEADER_WIDTH, "Total Runtime");
+	else if (kwork->report == KWORK_REPORT_LATENCY)
+		ret += printf(" %-*s |",
+			      PRINT_LATENCY_HEADER_WIDTH, "Avg delay");
 
 	ret += printf(" %-*s |", PRINT_FREQ_WIDTH, "Frequency");
 
@@ -975,6 +1110,11 @@ static int report_print_header(struct perf_kwork *kwork)
 			      PRINT_RUNTIME_HEADER_WIDTH, "Max runtime",
 			      PRINT_TIMESTAMP_HEADER_WIDTH, "Max runtime start",
 			      PRINT_TIMESTAMP_HEADER_WIDTH, "Max runtime end");
+	else if (kwork->report == KWORK_REPORT_LATENCY)
+		ret += printf(" %-*s | %-*s | %-*s |",
+			      PRINT_LATENCY_HEADER_WIDTH, "Max delay",
+			      PRINT_TIMESTAMP_HEADER_WIDTH, "Max delay start",
+			      PRINT_TIMESTAMP_HEADER_WIDTH, "Max delay end");
 
 	printf("\n");
 	print_separator(ret);
@@ -1008,6 +1148,7 @@ static void print_skipped_events(struct perf_kwork *kwork)
 {
 	int i;
 	const char *const kwork_event_str[] = {
+		[KWORK_TRACE_RAISE] = "raise",
 		[KWORK_TRACE_ENTRY] = "entry",
 		[KWORK_TRACE_EXIT]  = "exit",
 	};
@@ -1121,11 +1262,18 @@ static int perf_kwork__check_config(struct perf_kwork *kwork,
 		.entry_event = report_entry_event,
 		.exit_event  = report_exit_event,
 	};
+	static struct trace_kwork_handler latency_ops = {
+		.raise_event = latency_raise_event,
+		.entry_event = latency_entry_event,
+	};
 
 	switch (kwork->report) {
 	case KWORK_REPORT_RUNTIME:
 		kwork->tp_handler = &report_ops;
 		break;
+	case KWORK_REPORT_LATENCY:
+		kwork->tp_handler = &latency_ops;
+		break;
 	default:
 		pr_debug("Invalid report type %d\n", kwork->report);
 		break;
@@ -1330,6 +1478,7 @@ static int perf_kwork__record(struct perf_kwork *kwork,
 int cmd_kwork(int argc, const char **argv)
 {
 	static const char default_report_sort_order[] = "runtime, max, freq";
+	static const char default_latency_sort_order[] = "avg, max, freq";
 	static struct perf_kwork kwork = {
 		.tool = {
 			.sample = perf_kwork__process_tracepoint_sample,
@@ -1463,11 +1612,15 @@ int cmd_kwork(int argc, const char **argv)
 		setup_sorting(&kwork, report_options, report_usage);
 		return perf_kwork__report(&kwork);
 	} else if (strlen(argv[0]) > 2 && strstarts("latency", argv[0])) {
+		kwork.sort_order = default_latency_sort_order;
 		if (argc > 1) {
 			argc = parse_options(argc, argv, latency_options, latency_usage, 0);
 			if (argc)
 				usage_with_options(latency_usage, latency_options);
 		}
+		kwork.report = KWORK_REPORT_LATENCY;
+		setup_sorting(&kwork, latency_options, latency_usage);
+		return perf_kwork__report(&kwork);
 	} else if (strlen(argv[0]) > 2 && strstarts("timehist", argv[0])) {
 		if (argc > 1) {
 			argc = parse_options(argc, argv, timehist_options, timehist_usage, 0);
-- 
2.30.GIT

