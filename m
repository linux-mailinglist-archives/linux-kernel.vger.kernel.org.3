Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2605054845A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbiFMJti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241104AbiFMJs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:48:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E7018B2F;
        Mon, 13 Jun 2022 02:48:24 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LM6Cz0VbKzjXdh;
        Mon, 13 Jun 2022 17:46:55 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:06 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:05 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [RFC 06/13] perf kwork: Implement perf kwork report
Date:   Mon, 13 Jun 2022 17:45:58 +0800
Message-ID: <20220613094605.208401-7-yangjihong1@huawei.com>
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

Implements framework of perf kwork report, which is used to report time
properties such as run time and frequency:

test case:

  Kwork Name                | Cpu  | Avg delay     | Frequency | Max delay     | Max delay start     | Max delay end       |
 ---------------------------------------------------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------------------------------------------------

Since there are no report supported events, the output is empty.

Briefly describe the data structure:
1. "class" indicates event type. For example, irq and softiq correspond
to different types.
2. "cluster" refers to a specific event corresponding to a type. For
example, RCU and TIMER in softirq correspond to different clusters,
which contains three types of events: raise, entry, and exit.
3. "atom" includes time of each sample and sample of the previous phase.
(For example, exit corresponds to entry, which is used for timehist.)

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 937 +++++++++++++++++++++++++++++++++++++
 1 file changed, 937 insertions(+)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index cda6fcbc6e41..ec199942150f 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -31,19 +31,122 @@ enum kwork_class_type {
 	KWORK_CLASS_MAX,
 };
 
+enum kwork_trace_type {
+	KWORK_TRACE_ENTRY,
+	KWORK_TRACE_EXIT,
+	KWORK_TRACE_MAX,
+};
+
+enum kwork_report_type {
+	KWORK_REPORT_RUNTIME,
+};
+
+/*
+ * data structure:
+ * perf_kwork --> kwork_class (irq) --> kwork_cluster (RCU) --> atom_list (KWROK_TRACE_RAISE)
+ *            |                     |                       |-> atom_list (KWROK_TRACE_ENTRY)
+ *            |                     |                        -> atom_list (KWROK_TRACE_EXIT)
+ *            |                     |
+ *            |                     |-> kwork_cluster (TIMER) --> atom_list (KWROK_TRACE_RAISE)
+ *            |                     |                         |-> atom_list (KWROK_TRACE_ENTRY)
+ *            |                     |                          -> atom_list (KWROK_TRACE_EXIT)
+ *            |                     |
+ *            |                      -> ...
+ *            |
+ *            |-> kwork_class (softirq) --> ...
+ *            |                         |
+ *            |                          -> ...
+ *            |
+ *             -> ...
+ */
+
+struct kwork_atom {
+	struct list_head list;
+	u64 time;
+	struct kwork_atom *prev;
+
+	void *page_addr;
+	unsigned long bit_inpage;
+};
+
+#define NR_ATOM_PER_PAGE 128
+struct kwork_atom_page {
+	struct list_head list;
+	struct kwork_atom atoms[NR_ATOM_PER_PAGE];
+	DECLARE_BITMAP(bitmap, NR_ATOM_PER_PAGE);
+};
+
+struct kwork_class;
+struct kwork_cluster {
+	/*
+	 * class field
+	 */
+	struct rb_node node;
+	struct kwork_class *class;
+
+	/*
+	 * cluster filed
+	 */
+	u64 id;
+	int cpu;
+	char *name;
+
+	/*
+	 * atom field
+	 */
+	u64 nr_atoms;
+	struct list_head atom_list[KWORK_TRACE_MAX];
+
+	/*
+	 * runtime report
+	 */
+	u64 max_runtime;
+	u64 max_runtime_start;
+	u64 max_runtime_end;
+	u64 total_runtime;
+};
+
 struct kwork_class {
 	struct list_head list;
 	const char *name;
 
 	unsigned int nr_tracepoints;
 	const struct evsel_str_handler *tp_handlers;
+
+	struct rb_root_cached cluster_root;
+
+	int (*class_init)(struct kwork_class *class,
+			  struct perf_session *session);
+
+	void (*cluster_init)(struct kwork_class *class,
+			     struct kwork_cluster *cluster,
+			     struct evsel *evsel, struct perf_sample *sample);
+
+	void (*cluster_name)(struct kwork_cluster *cluster,
+			     char *buf, int len);
+};
+
+struct perf_kwork;
+struct trace_kwork_handler {
+	int (*entry_event)(struct perf_kwork *kwork,
+			   struct kwork_class *class, struct evsel *evsel,
+			   struct perf_sample *sample, struct machine *machine);
+
+	int (*exit_event)(struct perf_kwork *kwork,
+			  struct kwork_class *class, struct evsel *evsel,
+			  struct perf_sample *sample, struct machine *machine);
 };
 
 struct perf_kwork {
 	/*
 	 * metadata
 	 */
+	struct perf_tool tool;
 	struct list_head class_list;
+	struct list_head atom_page_list;
+	struct list_head sort_list, cmp_id;
+	struct rb_root_cached sorted_cluster_root;
+	const struct trace_kwork_handler *tp_handler;
 
 	/*
 	 * profile filters
@@ -61,6 +164,7 @@ struct perf_kwork {
 	 */
 	bool force;
 	const char *event_list_str;
+	enum kwork_report_type report;
 
 	/*
 	 * options for subcommand
@@ -69,8 +173,472 @@ struct perf_kwork {
 	bool show_callchain;
 	unsigned int max_stack;
 	const char *sort_order;
+
+	/*
+	 * statistics
+	 */
+	u64 timestart;
+	u64 timeend;
+
+	unsigned long nr_events;
+	unsigned long nr_lost_chunks;
+	unsigned long nr_lost_events;
+
+	u64 all_runtime;
+	u64 all_count;
+	u64 nr_skipped_events[KWORK_TRACE_MAX + 1];
+};
+
+/*
+ * report header elements width
+ */
+#define PRINT_CPU_WIDTH 4
+#define PRINT_FREQ_WIDTH 9
+#define PRINT_RUNTIME_WIDTH 10
+#define PRINT_TIMESTAMP_WIDTH 17
+#define PRINT_KWORK_NAME_WIDTH 25
+#define RPINT_DECIMAL_WIDTH 3
+#define PRINT_TIME_UNIT_SEC_WIDTH 2
+#define PRINT_TIME_UNIT_MESC_WIDTH 3
+#define PRINT_RUNTIME_HEADER_WIDTH (PRINT_RUNTIME_WIDTH + PRINT_TIME_UNIT_MESC_WIDTH)
+#define PRINT_TIMESTAMP_HEADER_WIDTH (PRINT_TIMESTAMP_WIDTH + PRINT_TIME_UNIT_SEC_WIDTH)
+
+struct sort_dimension {
+	const char      *name;
+	int             (*cmp)(struct kwork_cluster *l, struct kwork_cluster *r);
+	struct          list_head list;
 };
 
+static int id_cmp(struct kwork_cluster *l, struct kwork_cluster *r)
+{
+	if (l->cpu > r->cpu)
+		return 1;
+	if (l->cpu < r->cpu)
+		return -1;
+
+	if (l->id > r->id)
+		return 1;
+	if (l->id < r->id)
+		return -1;
+
+	return 0;
+}
+
+static int freq_cmp(struct kwork_cluster *l, struct kwork_cluster *r)
+{
+	if (l->nr_atoms > r->nr_atoms)
+		return 1;
+	if (l->nr_atoms < r->nr_atoms)
+		return -1;
+
+	return 0;
+}
+
+static int runtime_cmp(struct kwork_cluster *l, struct kwork_cluster *r)
+{
+	if (l->total_runtime > r->total_runtime)
+		return 1;
+	if (l->total_runtime < r->total_runtime)
+		return -1;
+
+	return 0;
+}
+
+static int max_runtime_cmp(struct kwork_cluster *l, struct kwork_cluster *r)
+{
+	if (l->max_runtime > r->max_runtime)
+		return 1;
+	if (l->max_runtime < r->max_runtime)
+		return -1;
+
+	return 0;
+}
+
+static int sort_dimension__add(struct perf_kwork *kwork __maybe_unused,
+			       const char *tok, struct list_head *list)
+{
+	size_t i;
+	static struct sort_dimension max_sort_dimension = {
+		.name = "max",
+		.cmp  = max_runtime_cmp,
+	};
+	static struct sort_dimension id_sort_dimension = {
+		.name = "id",
+		.cmp  = id_cmp,
+	};
+	static struct sort_dimension runtime_sort_dimension = {
+		.name = "runtime",
+		.cmp  = runtime_cmp,
+	};
+	static struct sort_dimension freq_sort_dimension = {
+		.name = "freq",
+		.cmp  = freq_cmp,
+	};
+	struct sort_dimension *available_sorts[] = {
+		&id_sort_dimension,
+		&max_sort_dimension,
+		&freq_sort_dimension,
+		&runtime_sort_dimension,
+	};
+
+	for (i = 0; i < ARRAY_SIZE(available_sorts); i++) {
+		if (!strcmp(available_sorts[i]->name, tok)) {
+			list_add_tail(&available_sorts[i]->list, list);
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+static void setup_sorting(struct perf_kwork *kwork,
+			  const struct option *options,
+			  const char * const usage_msg[])
+{
+	char *tmp, *tok, *str = strdup(kwork->sort_order);
+
+	for (tok = strtok_r(str, ", ", &tmp);
+	     tok; tok = strtok_r(NULL, ", ", &tmp)) {
+		if (sort_dimension__add(kwork, tok, &kwork->sort_list) < 0)
+			usage_with_options_msg(usage_msg, options,
+					       "Unknown --sort key: `%s'", tok);
+	}
+
+	pr_debug("Sort order: %s\n", kwork->sort_order);
+	free(str);
+}
+
+static struct kwork_atom *atom_new(struct perf_kwork *kwork,
+				   struct perf_sample *sample)
+{
+	unsigned long i;
+	struct kwork_atom_page *page;
+	struct kwork_atom *atom = NULL;
+
+	list_for_each_entry(page, &kwork->atom_page_list, list) {
+		if (!bitmap_full(page->bitmap, NR_ATOM_PER_PAGE)) {
+			i = find_first_zero_bit(page->bitmap, NR_ATOM_PER_PAGE);
+			BUG_ON(i >= NR_ATOM_PER_PAGE);
+			atom = &page->atoms[i];
+			goto found_atom;
+		}
+	}
+
+	/*
+	 * new page
+	 */
+	page = zalloc(sizeof(*page));
+	if (page == NULL) {
+		pr_debug("Failed to zalloc kwork atom page\n");
+		return NULL;
+	}
+
+	i = 0;
+	atom = &page->atoms[0];
+	list_add_tail(&page->list, &kwork->atom_page_list);
+
+found_atom:
+	set_bit(i, page->bitmap);
+	atom->time = sample->time;
+	atom->prev = NULL;
+	atom->page_addr = page;
+	atom->bit_inpage = i;
+	return atom;
+}
+
+static void atom_free(struct kwork_atom *atom)
+{
+	if (atom->prev != NULL)
+		atom_free(atom->prev);
+
+	clear_bit(atom->bit_inpage,
+		  ((struct kwork_atom_page *)atom->page_addr)->bitmap);
+}
+
+static void atom_del(struct kwork_atom *atom)
+{
+	list_del(&atom->list);
+	atom_free(atom);
+}
+
+static int cluster_cmp(struct list_head *list,
+		       struct kwork_cluster *l, struct kwork_cluster *r)
+{
+	int ret = 0;
+	struct sort_dimension *sort;
+
+	BUG_ON(list_empty(list));
+
+	list_for_each_entry(sort, list, list) {
+		ret = sort->cmp(l, r);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+static struct kwork_cluster *cluster_search(struct rb_root_cached *root,
+					    struct kwork_cluster *key,
+					    struct list_head *sort_list)
+{
+	int cmp;
+	struct kwork_cluster *cluster;
+	struct rb_node *node = root->rb_root.rb_node;
+
+	while (node) {
+		cluster = container_of(node, struct kwork_cluster, node);
+		cmp = cluster_cmp(sort_list, key, cluster);
+		if (cmp > 0)
+			node = node->rb_left;
+		else if (cmp < 0)
+			node = node->rb_right;
+		else {
+			if (cluster->name == NULL)
+				cluster->name = key->name;
+			return cluster;
+		}
+	}
+	return NULL;
+}
+
+static void cluster_insert(struct rb_root_cached *root,
+			   struct kwork_cluster *key, struct list_head *sort_list)
+{
+	int cmp;
+	bool leftmost = true;
+	struct kwork_cluster *cur;
+	struct rb_node **new = &(root->rb_root.rb_node), *parent = NULL;
+
+	while (*new) {
+		cur = container_of(*new, struct kwork_cluster, node);
+		parent = *new;
+		cmp = cluster_cmp(sort_list, key, cur);
+
+		if (cmp > 0)
+			new = &((*new)->rb_left);
+		else {
+			new = &((*new)->rb_right);
+			leftmost = false;
+		}
+	}
+
+	rb_link_node(&key->node, parent, new);
+	rb_insert_color_cached(&key->node, root, leftmost);
+}
+
+static struct kwork_cluster *cluster_new(struct kwork_cluster *key)
+{
+	int i;
+	struct kwork_cluster *cluster = zalloc(sizeof(*cluster));
+
+	if (cluster == NULL) {
+		pr_debug("Failed to zalloc kwork cluster\n");
+		return NULL;
+	}
+
+	for (i = 0; i < KWORK_TRACE_MAX; i++)
+		INIT_LIST_HEAD(&cluster->atom_list[i]);
+
+	cluster->id = key->id;
+	cluster->cpu = key->cpu;
+	cluster->name = key->name;
+	cluster->class = key->class;
+	return cluster;
+}
+
+static struct kwork_cluster *cluster_findnew(struct rb_root_cached *root,
+					     struct kwork_cluster *key,
+					     struct list_head *sort_list)
+{
+	struct kwork_cluster *cluster = NULL;
+
+	cluster = cluster_search(root, key, sort_list);
+	if (cluster != NULL)
+		return cluster;
+
+	cluster = cluster_new(key);
+	if (cluster == NULL)
+		return NULL;
+
+	cluster_insert(root, cluster, sort_list);
+	return cluster;
+}
+
+static void profile_update_timespan(struct perf_kwork *kwork,
+				    struct perf_sample *sample)
+{
+	if (!kwork->summary)
+		return;
+
+	if ((kwork->timestart == 0) || (kwork->timestart > sample->time))
+		kwork->timestart = sample->time;
+
+	if (kwork->timeend < sample->time)
+		kwork->timeend = sample->time;
+}
+
+static bool profile_event_match(struct perf_kwork *kwork,
+				struct kwork_cluster *cluster,
+				struct perf_sample *sample)
+{
+	int cpu = cluster->cpu;
+	u64 time = sample->time;
+	struct perf_time_interval *ptime = &kwork->ptime;
+
+	if ((kwork->cpu_list != NULL) && !test_bit(cpu, kwork->cpu_bitmap))
+		return false;
+
+	if (((ptime->start != 0) && (ptime->start > time)) ||
+	    ((ptime->end != 0) && (ptime->end < time)))
+		return false;
+
+	if ((kwork->profile_name != NULL) &&
+	    ((cluster->name == NULL) ||
+	     (strcmp(cluster->name, kwork->profile_name) != 0)))
+		return false;
+
+	profile_update_timespan(kwork, sample);
+	return true;
+}
+
+static int cluster_push_atom(struct perf_kwork *kwork,
+			     struct kwork_class *class,
+			     enum kwork_trace_type src_type,
+			     enum kwork_trace_type dst_type,
+			     struct evsel *evsel,
+			     struct perf_sample *sample,
+			     struct kwork_cluster **ret_cluster)
+{
+	struct kwork_atom *atom, *dst_atom;
+	struct kwork_cluster *cluster, key;
+
+	BUG_ON(class->cluster_init == NULL);
+	class->cluster_init(class, &key, evsel, sample);
+
+	atom = atom_new(kwork, sample);
+	if (atom == NULL)
+		return -1;
+
+	cluster = cluster_findnew(&class->cluster_root, &key, &kwork->cmp_id);
+	if (cluster == NULL) {
+		free(atom);
+		return -1;
+	}
+
+	if (!profile_event_match(kwork, cluster, sample))
+		return 0;
+
+	if ((dst_type >= 0) && (dst_type < KWORK_TRACE_MAX)) {
+		dst_atom = list_last_entry_or_null(&cluster->atom_list[dst_type],
+						   struct kwork_atom, list);
+		if (dst_atom != NULL) {
+			atom->prev = dst_atom;
+			list_del(&dst_atom->list);
+		}
+	}
+
+	if (ret_cluster != NULL)
+		*ret_cluster = cluster;
+
+	list_add_tail(&atom->list, &cluster->atom_list[src_type]);
+
+	return 0;
+}
+
+static struct kwork_atom *cluster_pop_atom(struct perf_kwork *kwork,
+					   struct kwork_class *class,
+					   enum kwork_trace_type src_type,
+					   enum kwork_trace_type dst_type,
+					   struct evsel *evsel,
+					   struct perf_sample *sample,
+					   struct kwork_cluster **ret_cluster)
+{
+	struct kwork_atom *atom, *src_atom;
+	struct kwork_cluster *cluster, key;
+
+	BUG_ON(class->cluster_init == NULL);
+	class->cluster_init(class, &key, evsel, sample);
+
+	cluster = cluster_findnew(&class->cluster_root, &key, &kwork->cmp_id);
+	if (ret_cluster != NULL)
+		*ret_cluster = cluster;
+
+	if (cluster == NULL)
+		return NULL;
+
+	if (!profile_event_match(kwork, cluster, sample))
+		return NULL;
+
+	atom = list_last_entry_or_null(&cluster->atom_list[dst_type],
+				       struct kwork_atom, list);
+	if (atom != NULL)
+		return atom;
+
+	src_atom = atom_new(kwork, sample);
+	if (src_atom != NULL)
+		list_add_tail(&src_atom->list, &cluster->atom_list[src_type]);
+	else {
+		if (ret_cluster != NULL)
+			*ret_cluster = NULL;
+	}
+
+	return NULL;
+}
+
+static void report_update_exit_event(struct kwork_cluster *cluster,
+				     struct kwork_atom *atom,
+				     struct perf_sample *sample)
+{
+	u64 delta;
+	u64 exit_time = sample->time;
+	u64 entry_time = atom->time;
+
+	if ((entry_time != 0) && (exit_time >= entry_time)) {
+		delta = exit_time - entry_time;
+		if ((delta > cluster->max_runtime) ||
+		    (cluster->max_runtime == 0)) {
+			cluster->max_runtime = delta;
+			cluster->max_runtime_start = entry_time;
+			cluster->max_runtime_end = exit_time;
+		}
+		cluster->total_runtime += delta;
+		cluster->nr_atoms++;
+	}
+}
+
+static int report_entry_event(struct perf_kwork *kwork,
+			      struct kwork_class *class,
+			      struct evsel *evsel,
+			      struct perf_sample *sample,
+			      struct machine *machine __maybe_unused)
+{
+	return cluster_push_atom(kwork, class, KWORK_TRACE_ENTRY,
+				 KWORK_TRACE_MAX, evsel, sample, NULL);
+}
+
+static int report_exit_event(struct perf_kwork *kwork,
+			     struct kwork_class *class,
+			     struct evsel *evsel,
+			     struct perf_sample *sample,
+			     struct machine *machine __maybe_unused)
+{
+	struct kwork_atom *atom = NULL;
+	struct kwork_cluster *cluster = NULL;
+
+	atom = cluster_pop_atom(kwork, class, KWORK_TRACE_EXIT,
+				KWORK_TRACE_ENTRY, evsel, sample, &cluster);
+	if (cluster == NULL)
+		return -1;
+
+	if (atom != NULL) {
+		report_update_exit_event(cluster, atom, sample);
+		atom_del(atom);
+	}
+
+	return 0;
+}
+
 const struct evsel_str_handler irq_tp_handlers[] = {
 	{ "irq:irq_handler_entry", NULL, },
 	{ "irq:irq_handler_exit",  NULL, },
@@ -112,6 +680,182 @@ static struct kwork_class *kwork_class_supported_list[KWORK_CLASS_MAX] = {
 	[KWORK_CLASS_WORKQUEUE] = &kwork_workqueue,
 };
 
+static void print_separator(int len)
+{
+	printf(" %.*s\n", len, graph_dotted_line);
+}
+
+static void report_print_cluster(struct perf_kwork *kwork,
+				 struct kwork_cluster *cluster)
+{
+	int ret = 0;
+	char kwork_name[PRINT_KWORK_NAME_WIDTH];
+	char max_runtime_start[32], max_runtime_end[32];
+
+	printf(" ");
+
+	/*
+	 * kwork name
+	 */
+	if (cluster->class && cluster->class->cluster_name) {
+		cluster->class->cluster_name(cluster, kwork_name,
+					     PRINT_KWORK_NAME_WIDTH);
+		ret += printf(" %-*s |", PRINT_KWORK_NAME_WIDTH, kwork_name);
+	} else
+		ret += printf(" %-*s |", PRINT_KWORK_NAME_WIDTH, "");
+
+	/*
+	 * cpu
+	 */
+	ret += printf(" %0*d |", PRINT_CPU_WIDTH, cluster->cpu);
+
+	/*
+	 * total runtime
+	 */
+	if (kwork->report == KWORK_REPORT_RUNTIME)
+		ret += printf(" %*.*f ms |",
+			      PRINT_RUNTIME_WIDTH, RPINT_DECIMAL_WIDTH,
+			      (double)cluster->total_runtime / NSEC_PER_MSEC);
+
+	/*
+	 * frequency
+	 */
+	ret += printf(" %*" PRIu64 " |", PRINT_FREQ_WIDTH, cluster->nr_atoms);
+
+	/*
+	 * max runtime, max runtime start, max runtime end
+	 */
+	if (kwork->report == KWORK_REPORT_RUNTIME) {
+
+		timestamp__scnprintf_usec(cluster->max_runtime_start,
+					  max_runtime_start,
+					  sizeof(max_runtime_start));
+		timestamp__scnprintf_usec(cluster->max_runtime_end,
+					  max_runtime_end,
+					  sizeof(max_runtime_end));
+		ret += printf(" %*.*f ms | %*s s | %*s s |",
+			      PRINT_RUNTIME_WIDTH, RPINT_DECIMAL_WIDTH,
+			      (double)cluster->max_runtime / NSEC_PER_MSEC,
+			      PRINT_TIMESTAMP_WIDTH, max_runtime_start,
+			      PRINT_TIMESTAMP_WIDTH, max_runtime_end);
+	}
+
+	printf("\n");
+}
+
+static int report_print_header(struct perf_kwork *kwork)
+{
+	int ret;
+
+	printf("\n ");
+	ret = printf(" %-*s | %-*s |",
+		     PRINT_KWORK_NAME_WIDTH, "Kwork Name",
+		     PRINT_CPU_WIDTH, "Cpu");
+
+	if (kwork->report == KWORK_REPORT_RUNTIME)
+		ret += printf(" %-*s |",
+			      PRINT_RUNTIME_HEADER_WIDTH, "Total Runtime");
+
+	ret += printf(" %-*s |", PRINT_FREQ_WIDTH, "Frequency");
+
+	if (kwork->report == KWORK_REPORT_RUNTIME)
+		ret += printf(" %-*s | %-*s | %-*s |",
+			      PRINT_RUNTIME_HEADER_WIDTH, "Max runtime",
+			      PRINT_TIMESTAMP_HEADER_WIDTH, "Max runtime start",
+			      PRINT_TIMESTAMP_HEADER_WIDTH, "Max runtime end");
+
+	printf("\n");
+	print_separator(ret);
+	return ret;
+}
+
+static void print_summary(struct perf_kwork *kwork)
+{
+	u64 time = kwork->timeend - kwork->timestart;
+
+	printf("  Total count            : %9" PRIu64 "\n", kwork->all_count);
+	printf("  Total runtime   (msec) : %9.3f (%.3f%% load average)\n",
+	       (double)kwork->all_runtime / NSEC_PER_MSEC,
+	       (double)kwork->all_runtime / time);
+	printf("  Total time span (msec) : %9.3f\n",
+	       (double)time / NSEC_PER_MSEC);
+}
+
+static unsigned long long nr_list_entry(struct list_head *head)
+{
+	struct list_head *pos;
+	unsigned long long n = 0;
+
+	list_for_each(pos, head)
+		n++;
+
+	return n;
+}
+
+static void print_skipped_events(struct perf_kwork *kwork)
+{
+	int i;
+	const char *const kwork_event_str[] = {
+		[KWORK_TRACE_ENTRY] = "entry",
+		[KWORK_TRACE_EXIT]  = "exit",
+	};
+
+	if ((kwork->nr_skipped_events[KWORK_TRACE_MAX] != 0) &&
+	    (kwork->nr_events != 0)) {
+		printf("  INFO: %.3f%% skipped events (%" PRIu64 " including ",
+		       (double)kwork->nr_skipped_events[KWORK_TRACE_MAX] /
+		       (double)kwork->nr_events * 100.0,
+		       kwork->nr_skipped_events[KWORK_TRACE_MAX]);
+
+		for (i = 0; i < KWORK_TRACE_MAX; i++)
+			printf("%" PRIu64 " %s%s",
+			       kwork->nr_skipped_events[i],
+			       kwork_event_str[i],
+			       (i == KWORK_TRACE_MAX - 1) ? ")\n" : ", ");
+	}
+
+	if (verbose > 0)
+		printf("  INFO: use %lld atom pages\n",
+		       nr_list_entry(&kwork->atom_page_list));
+}
+
+static void print_bad_events(struct perf_kwork *kwork)
+{
+	if ((kwork->nr_lost_events != 0) && (kwork->nr_events != 0))
+		printf("  INFO: %.3f%% lost events (%ld out of %ld, in %ld chunks)\n",
+		       (double)kwork->nr_lost_events /
+		       (double)kwork->nr_events * 100.0,
+		       kwork->nr_lost_events, kwork->nr_events,
+		       kwork->nr_lost_chunks);
+}
+
+static void cluster_sort(struct perf_kwork *kwork, struct kwork_class *class)
+{
+	struct rb_node *node;
+	struct kwork_cluster *data;
+	struct rb_root_cached *root = &class->cluster_root;
+
+	pr_debug("Sorting %s ...\n", class->name);
+	for (;;) {
+		node = rb_first_cached(root);
+		if (!node)
+			break;
+
+		rb_erase_cached(node, root);
+		data = rb_entry(node, struct kwork_cluster, node);
+		cluster_insert(&kwork->sorted_cluster_root,
+			       data, &kwork->sort_list);
+	}
+}
+
+static void perf_kwork__sort(struct perf_kwork *kwork)
+{
+	struct kwork_class *class;
+
+	list_for_each_entry(class, &kwork->class_list, list)
+		cluster_sort(kwork, class);
+}
+
 static void setup_event_list(struct perf_kwork *kwork,
 			     const struct option *options,
 			     const char * const usage_msg[])
@@ -154,6 +898,176 @@ static void setup_event_list(struct perf_kwork *kwork,
 	pr_debug("\n");
 }
 
+static int perf_kwork__check_config(struct perf_kwork *kwork,
+				    struct perf_session *session)
+{
+	int ret;
+	struct evsel *evsel;
+	struct kwork_class *class;
+
+	static struct trace_kwork_handler report_ops = {
+		.entry_event = report_entry_event,
+		.exit_event  = report_exit_event,
+	};
+
+	switch (kwork->report) {
+	case KWORK_REPORT_RUNTIME:
+		kwork->tp_handler = &report_ops;
+		break;
+	default:
+		pr_debug("Invalid report type %d\n", kwork->report);
+		break;
+	}
+
+	list_for_each_entry(class, &kwork->class_list, list)
+		if ((class->class_init != NULL) &&
+		    (class->class_init(class, session) != 0))
+			return -1;
+
+	if (kwork->cpu_list != NULL) {
+		ret = perf_session__cpu_bitmap(session,
+					       kwork->cpu_list,
+					       kwork->cpu_bitmap);
+		if (ret < 0) {
+			pr_debug("Invalid cpu bitmap\n");
+			return -1;
+		}
+	}
+
+	if (kwork->time_str != NULL) {
+		ret = perf_time__parse_str(&kwork->ptime, kwork->time_str);
+		if (ret != 0) {
+			pr_debug("Invalid time span\n");
+			return -1;
+		}
+	}
+
+	list_for_each_entry(evsel, &session->evlist->core.entries, core.node) {
+		if (kwork->show_callchain && !evsel__has_callchain(evsel)) {
+			pr_debug("Samples do not have callchains\n");
+			kwork->show_callchain = 0;
+			symbol_conf.use_callchain = 0;
+		}
+	}
+
+	sort_dimension__add(kwork, "id", &kwork->cmp_id);
+	return 0;
+}
+
+static int perf_kwork__read_events(struct perf_kwork *kwork)
+{
+	int ret = -1;
+	struct perf_session *session = NULL;
+
+	struct perf_data data = {
+		.path  = input_name,
+		.mode  = PERF_DATA_MODE_READ,
+		.force = kwork->force,
+	};
+
+	session = perf_session__new(&data, &kwork->tool);
+	if (IS_ERR(session)) {
+		pr_debug("Error creating perf session\n");
+		return PTR_ERR(session);
+	}
+
+	symbol__init(&session->header.env);
+
+	if (perf_kwork__check_config(kwork, session) != 0)
+		goto out_delete;
+
+	ret = perf_session__process_events(session);
+	if (ret) {
+		pr_debug("Failed to process events, error %d\n", ret);
+		goto out_delete;
+	}
+
+	kwork->nr_events      = session->evlist->stats.nr_events[0];
+	kwork->nr_lost_events = session->evlist->stats.total_lost;
+	kwork->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
+
+out_delete:
+	perf_session__delete(session);
+	return ret;
+}
+
+static void process_skipped_events(struct perf_kwork *kwork,
+				   struct kwork_cluster *cluster)
+{
+	int i;
+	unsigned long long count;
+
+	for (i = 0; i < KWORK_TRACE_MAX; i++) {
+		count = nr_list_entry(&cluster->atom_list[i]);
+		kwork->nr_skipped_events[i] += count;
+		kwork->nr_skipped_events[KWORK_TRACE_MAX] += count;
+	}
+}
+
+static int perf_kwork__report(struct perf_kwork *kwork)
+{
+	int ret;
+	struct rb_node *next;
+	struct kwork_cluster *cluster;
+
+	setup_pager();
+
+	if (perf_kwork__read_events(kwork) != 0)
+		return -1;
+
+	perf_kwork__sort(kwork);
+
+	ret = report_print_header(kwork);
+	next = rb_first_cached(&kwork->sorted_cluster_root);
+	while (next) {
+		cluster = rb_entry(next, struct kwork_cluster, node);
+		process_skipped_events(kwork, cluster);
+
+		if (cluster->nr_atoms != 0) {
+			report_print_cluster(kwork, cluster);
+			if (kwork->summary) {
+				kwork->all_runtime += cluster->total_runtime;
+				kwork->all_count += cluster->nr_atoms;
+			}
+		}
+		next = rb_next(next);
+	}
+	print_separator(ret);
+
+	if (kwork->summary) {
+		print_summary(kwork);
+		print_separator(ret);
+	}
+
+	print_bad_events(kwork);
+	print_skipped_events(kwork);
+	printf("\n");
+
+	return 0;
+}
+
+typedef int (*tracepoint_handler)(struct perf_tool *tool,
+				  struct evsel *evsel,
+				  struct perf_sample *sample,
+				  struct machine *machine);
+
+static int perf_kwork__process_tracepoint_sample(struct perf_tool *tool,
+						 union perf_event *event __maybe_unused,
+						 struct perf_sample *sample,
+						 struct evsel *evsel,
+						 struct machine *machine)
+{
+	int err = 0;
+
+	if (evsel->handler != NULL) {
+		tracepoint_handler f = evsel->handler;
+
+		err = f(tool, evsel, sample, machine);
+	}
+
+	return err;
+}
+
 static int perf_kwork__record(struct perf_kwork *kwork,
 			      int argc, const char **argv)
 {
@@ -203,8 +1117,18 @@ static int perf_kwork__record(struct perf_kwork *kwork,
 
 int cmd_kwork(int argc, const char **argv)
 {
+	static const char default_report_sort_order[] = "runtime, max, freq";
 	static struct perf_kwork kwork = {
+		.tool = {
+			.sample = perf_kwork__process_tracepoint_sample,
+		},
+
 		.class_list          = LIST_HEAD_INIT(kwork.class_list),
+		.atom_page_list      = LIST_HEAD_INIT(kwork.atom_page_list),
+		.sort_list           = LIST_HEAD_INIT(kwork.sort_list),
+		.cmp_id              = LIST_HEAD_INIT(kwork.cmp_id),
+		.sorted_cluster_root = RB_ROOT_CACHED,
+		.tp_handler          = NULL,
 
 		.profile_name        = NULL,
 		.cpu_list            = NULL,
@@ -215,6 +1139,15 @@ int cmd_kwork(int argc, const char **argv)
 		.show_callchain      = false,
 		.max_stack           = 5,
 		.sort_order          = NULL,
+
+		.timestart           = 0,
+		.timeend             = 0,
+		.nr_events           = 0,
+		.nr_lost_chunks      = 0,
+		.nr_lost_events      = 0,
+		.all_runtime         = 0,
+		.all_count           = 0,
+		.nr_skipped_events   = { 0 },
 	};
 
 	const struct option kwork_options[] = {
@@ -308,11 +1241,15 @@ int cmd_kwork(int argc, const char **argv)
 	if (strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
 		return perf_kwork__record(&kwork, argc, argv);
 	} else if (strlen(argv[0]) > 2 && strstarts("report", argv[0])) {
+		kwork.sort_order = default_report_sort_order;
 		if (argc > 1) {
 			argc = parse_options(argc, argv, report_options, report_usage, 0);
 			if (argc)
 				usage_with_options(report_usage, report_options);
 		}
+		kwork.report = KWORK_REPORT_RUNTIME;
+		setup_sorting(&kwork, report_options, report_usage);
+		return perf_kwork__report(&kwork);
 	} else if (strlen(argv[0]) > 2 && strstarts("latency", argv[0])) {
 		if (argc > 1) {
 			argc = parse_options(argc, argv, latency_options, latency_usage, 0);
-- 
2.30.GIT

