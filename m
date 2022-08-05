Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBF758AA1E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240644AbiHEL2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240632AbiHEL2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:28:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AFDB7F7;
        Fri,  5 Aug 2022 04:28:10 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LzjsN1tWRz67PZF;
        Fri,  5 Aug 2022 19:23:52 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Fri, 5 Aug 2022 13:28:08 +0200
Received: from [10.126.170.142] (10.126.170.142) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Fri, 5 Aug 2022 12:28:07 +0100
Message-ID: <99ebff46-2b1f-e99c-693a-a6c37cfe7974@huawei.com>
Date:   Fri, 5 Aug 2022 12:28:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 09/17] perf pmu-events: Avoid passing pmu_events_map
To:     Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        "James Clark" <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Kan Liang" <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
CC:     Stephane Eranian <eranian@google.com>
References: <20220804221816.1802790-1-irogers@google.com>
 <20220804221816.1802790-10-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220804221816.1802790-10-irogers@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.170.142]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2022 23:18, Ian Rogers wrote:
> Preparation for hiding pmu_events_map as an implementation detail. While
> the map is passed, the table of events is all that is normally wanted.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Apart from comments on naming, below:

Reviewed-by: John Garry <john.garry@huawei.com>

As an aside, I will mention that reviewing this series is not helped by 
limited description of the changes in the cover letter. A primer would 
be nice. As I go through the series, I am often assuming that the 
motivation for the change is sound.

Thanks,
John

> ---
>   tools/perf/arch/arm64/util/pmu.c  |  4 +-
>   tools/perf/tests/expand-cgroup.c  |  6 +--
>   tools/perf/tests/parse-metric.c   |  7 +--
>   tools/perf/tests/pmu-events.c     | 63 +++++++++++-------------
>   tools/perf/util/metricgroup.c     | 82 +++++++++++++++----------------
>   tools/perf/util/metricgroup.h     |  4 +-
>   tools/perf/util/pmu.c             | 33 +++++++------
>   tools/perf/util/pmu.h             |  6 +--
>   tools/perf/util/s390-sample-raw.c | 12 ++---
>   9 files changed, 99 insertions(+), 118 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
> index 79124bba713e..646af8603227 100644
> --- a/tools/perf/arch/arm64/util/pmu.c
> +++ b/tools/perf/arch/arm64/util/pmu.c
> @@ -3,7 +3,7 @@
>   #include "../../../util/cpumap.h"
>   #include "../../../util/pmu.h"
>   
> -const struct pmu_events_map *pmu_events_map__find(void)
> +const struct pmu_event *pmu_events_map__find(void)

The function name is no longer appropriate


>   {
>   	struct perf_pmu *pmu = NULL;
>   
> @@ -18,7 +18,7 @@ const struct pmu_events_map *pmu_events_map__find(void)
>   		if (pmu->cpus->nr != cpu__max_cpu().cpu)
>   			return NULL;
>   
> -		return perf_pmu__find_map(pmu);
> +		return perf_pmu__find_table(pmu);
>   	}
>   
>   	return NULL;
> diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
> index dc4038f997d7..411fc578e5a4 100644
> --- a/tools/perf/tests/expand-cgroup.c
> +++ b/tools/perf/tests/expand-cgroup.c
> @@ -195,16 +195,12 @@ static int expand_metric_events(void)
>   			.metric_name	= NULL,
>   		},
>   	};
> -	const struct pmu_events_map ev_map = {
> -		.cpuid		= "test",
> -		.table		= pme_test,
> -	};
>   
>   	evlist = evlist__new();
>   	TEST_ASSERT_VAL("failed to get evlist", evlist);
>   
>   	rblist__init(&metric_events);
> -	ret = metricgroup__parse_groups_test(evlist, &ev_map, metric_str,
> +	ret = metricgroup__parse_groups_test(evlist, pme_test, metric_str,
>   					     false, false, &metric_events);
>   	if (ret < 0) {
>   		pr_debug("failed to parse '%s' metric\n", metric_str);
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index 1b811a26f4ee..7aebde7c37ec 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -79,11 +79,6 @@ static struct pmu_event pme_test[] = {
>   }
>   };
>   
> -static const struct pmu_events_map map = {
> -	.cpuid		= "test",
> -	.table		= pme_test,
> -};
> -
>   struct value {
>   	const char	*event;
>   	u64		 val;
> @@ -166,7 +161,7 @@ static int __compute_metric(const char *name, struct value *vals,
>   	runtime_stat__init(&st);
>   
>   	/* Parse the metric into metric_events list. */
> -	err = metricgroup__parse_groups_test(evlist, &map, name,
> +	err = metricgroup__parse_groups_test(evlist, pme_test, name,
>   					     false, false,
>   					     &metric_events);
>   	if (err)
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index a39a2c99ede6..b3cde5f98982 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -272,13 +272,11 @@ static bool is_same(const char *reference, const char *test)
>   	return !strcmp(reference, test);
>   }
>   
> -static const struct pmu_events_map *__test_pmu_get_events_map(void)
> +static const struct pmu_event *__test_pmu_get_events_table(void)
>   {
> -	const struct pmu_events_map *map;
> -
> -	for (map = &pmu_events_map[0]; map->cpuid; map++) {
> +	for (const struct pmu_events_map *map = &pmu_events_map[0]; map->cpuid; map++) {
>   		if (!strcmp(map->cpuid, "testcpu"))
> -			return map;
> +			return map->table;
>   	}
>   
>   	pr_err("could not find test events map\n");
> @@ -440,8 +438,7 @@ static int test__pmu_event_table(struct test_suite *test __maybe_unused,
>   				 int subtest __maybe_unused)
>   {
>   	const struct pmu_event *sys_event_tables = find_sys_events_table("pme_test_soc_sys");
> -	const struct pmu_events_map *map = __test_pmu_get_events_map();
> -	const struct pmu_event *table;
> +	const struct pmu_event *table = __test_pmu_get_events_table();
>   	int map_events = 0, expected_events;
>   
>   	/* ignore 3x sentinels */
> @@ -449,10 +446,10 @@ static int test__pmu_event_table(struct test_suite *test __maybe_unused,
>   			  ARRAY_SIZE(uncore_events) +
>   			  ARRAY_SIZE(sys_events) - 3;
>   
> -	if (!map || !sys_event_tables)
> +	if (!table || !sys_event_tables)
>   		return -1;
>   
> -	for (table = map->table; table->name; table++) {
> +	for (; table->name; table++) {
>   		struct perf_pmu_test_event const **test_event_table;
>   		bool found = false;
>   
> @@ -537,10 +534,10 @@ static int __test_core_pmu_event_aliases(char *pmu_name, int *count)
>   	struct perf_pmu *pmu;
>   	LIST_HEAD(aliases);
>   	int res = 0;
> -	const struct pmu_events_map *map = __test_pmu_get_events_map();
> +	const struct pmu_event *table = __test_pmu_get_events_table();
>   	struct perf_pmu_alias *a, *tmp;
>   
> -	if (!map)
> +	if (!table)
>   		return -1;
>   
>   	test_event_table = &core_events[0];
> @@ -551,7 +548,7 @@ static int __test_core_pmu_event_aliases(char *pmu_name, int *count)
>   
>   	pmu->name = pmu_name;
>   
> -	pmu_add_cpu_aliases_map(&aliases, pmu, map);
> +	pmu_add_cpu_aliases_map(&aliases, pmu, table);
>   
>   	for (; *test_event_table; test_event_table++) {
>   		struct perf_pmu_test_event const *test_event = *test_event_table;
> @@ -590,14 +587,14 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
>   	struct perf_pmu *pmu = &test_pmu->pmu;
>   	const char *pmu_name = pmu->name;
>   	struct perf_pmu_alias *a, *tmp, *alias;
> -	const struct pmu_events_map *map;
> +	const struct pmu_event *events_table;
>   	LIST_HEAD(aliases);
>   	int res = 0;
>   
> -	map = __test_pmu_get_events_map();
> -	if (!map)
> +	events_table = __test_pmu_get_events_table();
> +	if (!events_table)
>   		return -1;
> -	pmu_add_cpu_aliases_map(&aliases, pmu, map);
> +	pmu_add_cpu_aliases_map(&aliases, pmu, events_table);
>   	pmu_add_sys_aliases(&aliases, pmu);
>   
>   	/* Count how many aliases we generated */
> @@ -848,13 +845,9 @@ static int check_parse_fake(const char *id)
>   	return ret;
>   }
>   
> -static void expr_failure(const char *msg,
> -			 const struct pmu_events_map *map,
> -			 const struct pmu_event *pe)
> +static void expr_failure(const char *msg, const struct pmu_event *pe)
>   {
> -	pr_debug("%s for map %s %s\n", msg, map->arch, map->cpuid);
> -	pr_debug("On metric %s\n", pe->metric_name);
> -	pr_debug("On expression %s\n", pe->metric_expr);
> +	pr_debug("%s\nOn metric %s\nOn expression %s\n", msg, pe->metric_name, pe->metric_expr);
>   }
>   
>   struct metric {
> @@ -864,7 +857,7 @@ struct metric {
>   
>   static int resolve_metric_simple(struct expr_parse_ctx *pctx,
>   				 struct list_head *compound_list,
> -				 const struct pmu_events_map *map,
> +				 const struct pmu_event *map,
>   				 const char *metric_name)
>   {
>   	struct hashmap_entry *cur, *cur_tmp;
> @@ -925,8 +918,7 @@ static int resolve_metric_simple(struct expr_parse_ctx *pctx,
>   static int test__parsing(struct test_suite *test __maybe_unused,
>   			 int subtest __maybe_unused)
>   {
> -	const struct pmu_events_map *cpus_map = pmu_events_map__find();
> -	const struct pmu_events_map *map;
> +	const struct pmu_event *cpus_table = pmu_events_map__find();
>   	const struct pmu_event *pe;
>   	int i, j, k;
>   	int ret = 0;
> @@ -940,7 +932,8 @@ static int test__parsing(struct test_suite *test __maybe_unused,
>   	}
>   	i = 0;
>   	for (;;) {
> -		map = &pmu_events_map[i++];
> +		const struct pmu_events_map *map = &pmu_events_map[i++];
> +
>   		if (!map->table)
>   			break;
>   		j = 0;
> @@ -957,14 +950,14 @@ static int test__parsing(struct test_suite *test __maybe_unused,
>   				continue;
>   			expr__ctx_clear(ctx);
>   			if (expr__find_ids(pe->metric_expr, NULL, ctx) < 0) {
> -				expr_failure("Parse find ids failed", map, pe);
> +				expr_failure("Parse find ids failed", pe);
>   				ret++;
>   				continue;
>   			}
>   
> -			if (resolve_metric_simple(ctx, &compound_list, map,
> +			if (resolve_metric_simple(ctx, &compound_list, map->table,
>   						  pe->metric_name)) {
> -				expr_failure("Could not resolve metrics", map, pe);
> +				expr_failure("Could not resolve metrics", pe);
>   				ret++;
>   				goto exit; /* Don't tolerate errors due to severity */
>   			}
> @@ -979,7 +972,7 @@ static int test__parsing(struct test_suite *test __maybe_unused,
>   				expr__add_id_val(ctx, strdup(cur->key), k++);
>   
>   			hashmap__for_each_entry(ctx->ids, cur, bkt) {
> -				if (check_parse_cpu(cur->key, map == cpus_map,
> +				if (check_parse_cpu(cur->key, map->table == cpus_table,
>   						   pe))
>   					ret++;
>   			}
> @@ -999,7 +992,7 @@ static int test__parsing(struct test_suite *test __maybe_unused,
>   				hashmap__for_each_entry(ctx->ids, cur, bkt)
>   					expr__add_id_val(ctx, strdup(cur->key), k--);
>   				if (expr__parse(&result, ctx, pe->metric_expr)) {
> -					expr_failure("Parse failed", map, pe);
> +					expr_failure("Parse failed", pe);
>   					ret++;
>   				}
>   			}
> @@ -1088,8 +1081,6 @@ static int metric_parse_fake(const char *str)
>   static int test__parsing_fake(struct test_suite *test __maybe_unused,
>   			      int subtest __maybe_unused)
>   {
> -	const struct pmu_events_map *map;
> -	const struct pmu_event *pe;
>   	unsigned int i, j;
>   	int err = 0;
>   
> @@ -1101,12 +1092,14 @@ static int test__parsing_fake(struct test_suite *test __maybe_unused,
>   
>   	i = 0;
>   	for (;;) {
> -		map = &pmu_events_map[i++];
> +		const struct pmu_events_map *map = &pmu_events_map[i++];
> +
>   		if (!map->table)
>   			break;
>   		j = 0;
>   		for (;;) {
> -			pe = &map->table[j++];
> +			const struct pmu_event *pe = &map->table[j++];
> +
>   			if (!pe->name && !pe->metric_group && !pe->metric_name)
>   				break;
>   			if (!pe->metric_expr)
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 8f7baeabc5cf..4d32b4fbf67d 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -539,9 +539,6 @@ static int metricgroup__print_sys_event_iter(const struct pmu_event *pe, void *d
>   void metricgroup__print(bool metrics, bool metricgroups, char *filter,
>   			bool raw, bool details, const char *pmu_name)
>   {
> -	const struct pmu_events_map *map = pmu_events_map__find();
> -	const struct pmu_event *pe;
> -	int i;
>   	struct rblist groups;
>   	struct rb_node *node, *next;
>   	struct strlist *metriclist = NULL;
> @@ -556,8 +553,7 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
>   	groups.node_new = mep_new;
>   	groups.node_cmp = mep_cmp;
>   	groups.node_delete = mep_delete;
> -	for (i = 0; map; i++) {
> -		pe = &map->table[i];
> +	for (const struct pmu_event *pe = pmu_events_map__find(); pe; pe++) {
>   
>   		if (!pe->name && !pe->metric_group && !pe->metric_name)
>   			break;
> @@ -850,7 +846,7 @@ struct metricgroup_add_iter_data {
>   	bool metric_no_group;
>   	struct metric *root_metric;
>   	const struct visited_metric *visited;
> -	const struct pmu_events_map *map;
> +	const struct pmu_event *table;
>   };
>   
>   static int add_metric(struct list_head *metric_list,
> @@ -859,7 +855,7 @@ static int add_metric(struct list_head *metric_list,
>   		      bool metric_no_group,
>   		      struct metric *root_metric,
>   		      const struct visited_metric *visited,
> -		      const struct pmu_events_map *map);
> +		      const struct pmu_event *table);
>   
>   /**
>    * resolve_metric - Locate metrics within the root metric and recursively add
> @@ -874,7 +870,7 @@ static int add_metric(struct list_head *metric_list,
>    *               metrics. When adding a root this argument is NULL.
>    * @visited: A singly linked list of metric names being added that is used to
>    *           detect recursion.
> - * @map: The map that is searched for metrics, most commonly the table for the
> + * @table: The table that is searched for metrics, most commonly the table for the
>    *       architecture perf is running upon.
>    */
>   static int resolve_metric(struct list_head *metric_list,
> @@ -882,7 +878,7 @@ static int resolve_metric(struct list_head *metric_list,
>   			  bool metric_no_group,
>   			  struct metric *root_metric,
>   			  const struct visited_metric *visited,
> -			  const struct pmu_events_map *map)
> +			  const struct pmu_event *table)
>   {
>   	struct hashmap_entry *cur;
>   	size_t bkt;
> @@ -904,7 +900,7 @@ static int resolve_metric(struct list_head *metric_list,
>   	hashmap__for_each_entry(root_metric->pctx->ids, cur, bkt) {
>   		const struct pmu_event *pe;
>   
> -		pe = metricgroup__find_metric(cur->key, map);
> +		pe = metricgroup__find_metric(cur->key, table);
>   		if (pe) {
>   			pending = realloc(pending,
>   					(pending_cnt + 1) * sizeof(struct to_resolve));
> @@ -927,7 +923,7 @@ static int resolve_metric(struct list_head *metric_list,
>   	 */
>   	for (i = 0; i < pending_cnt; i++) {
>   		ret = add_metric(metric_list, pending[i].pe, modifier, metric_no_group,
> -				root_metric, visited, map);
> +				root_metric, visited, table);
>   		if (ret)
>   			break;
>   	}
> @@ -950,7 +946,7 @@ static int resolve_metric(struct list_head *metric_list,
>    *               metrics. When adding a root this argument is NULL.
>    * @visited: A singly linked list of metric names being added that is used to
>    *           detect recursion.
> - * @map: The map that is searched for metrics, most commonly the table for the
> + * @table: The table that is searched for metrics, most commonly the table for the
>    *       architecture perf is running upon.
>    */
>   static int __add_metric(struct list_head *metric_list,
> @@ -960,7 +956,7 @@ static int __add_metric(struct list_head *metric_list,
>   			int runtime,
>   			struct metric *root_metric,
>   			const struct visited_metric *visited,
> -			const struct pmu_events_map *map)
> +			const struct pmu_event *table)
>   {
>   	const struct visited_metric *vm;
>   	int ret;
> @@ -1032,7 +1028,7 @@ static int __add_metric(struct list_head *metric_list,
>   	} else {
>   		/* Resolve referenced metrics. */
>   		ret = resolve_metric(metric_list, modifier, metric_no_group, root_metric,
> -				     &visited_node, map);
> +				     &visited_node, table);
>   	}
>   
>   	if (ret) {
> @@ -1045,25 +1041,25 @@ static int __add_metric(struct list_head *metric_list,
>   	return ret;
>   }
>   
> -#define map_for_each_event(__pe, __idx, __map)					\
> -	if (__map)								\
> -		for (__idx = 0, __pe = &__map->table[__idx];			\
> +#define table_for_each_event(__pe, __idx, __table)					\
> +	if (__table)								\
> +		for (__idx = 0, __pe = &__table[__idx];				\
>   		     __pe->name || __pe->metric_group || __pe->metric_name;	\
> -		     __pe = &__map->table[++__idx])
> +		     __pe = &__table[++__idx])
>   
> -#define map_for_each_metric(__pe, __idx, __map, __metric)		\
> -	map_for_each_event(__pe, __idx, __map)				\
> +#define table_for_each_metric(__pe, __idx, __table, __metric)		\
> +	table_for_each_event(__pe, __idx, __table)				\
>   		if (__pe->metric_expr &&				\
>   		    (match_metric(__pe->metric_group, __metric) ||	\
>   		     match_metric(__pe->metric_name, __metric)))
>   
>   const struct pmu_event *metricgroup__find_metric(const char *metric,
> -						 const struct pmu_events_map *map)
> +						 const struct pmu_event *table)
>   {
>   	const struct pmu_event *pe;
>   	int i;
>   
> -	map_for_each_event(pe, i, map) {
> +	table_for_each_event(pe, i, table) {
>   		if (match_metric(pe->metric_name, metric))
>   			return pe;
>   	}
> @@ -1077,7 +1073,7 @@ static int add_metric(struct list_head *metric_list,
>   		      bool metric_no_group,
>   		      struct metric *root_metric,
>   		      const struct visited_metric *visited,
> -		      const struct pmu_events_map *map)
> +		      const struct pmu_event *table)
>   {
>   	int ret = 0;
>   
> @@ -1085,7 +1081,7 @@ static int add_metric(struct list_head *metric_list,
>   
>   	if (!strstr(pe->metric_expr, "?")) {
>   		ret = __add_metric(metric_list, pe, modifier, metric_no_group, 0,
> -				   root_metric, visited, map);
> +				   root_metric, visited, table);
>   	} else {
>   		int j, count;
>   
> @@ -1098,7 +1094,7 @@ static int add_metric(struct list_head *metric_list,
>   
>   		for (j = 0; j < count && !ret; j++)
>   			ret = __add_metric(metric_list, pe, modifier, metric_no_group, j,
> -					root_metric, visited, map);
> +					root_metric, visited, table);
>   	}
>   
>   	return ret;
> @@ -1114,7 +1110,7 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_event *pe,
>   		return 0;
>   
>   	ret = add_metric(d->metric_list, pe, d->modifier, d->metric_no_group,
> -			 d->root_metric, d->visited, d->map);
> +			 d->root_metric, d->visited, d->table);
>   	if (ret)
>   		goto out;
>   
> @@ -1162,13 +1158,13 @@ static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
>    *                   global. Grouping is the default but due to multiplexing the
>    *                   user may override.
>    * @metric_list: The list that the metric or metric group are added to.
> - * @map: The map that is searched for metrics, most commonly the table for the
> + * @table: The table that is searched for metrics, most commonly the table for the
>    *       architecture perf is running upon.
>    */
>   static int metricgroup__add_metric(const char *metric_name, const char *modifier,
>   				   bool metric_no_group,
>   				   struct list_head *metric_list,
> -				   const struct pmu_events_map *map)
> +				   const struct pmu_event *table)
>   {
>   	const struct pmu_event *pe;
>   	LIST_HEAD(list);
> @@ -1179,11 +1175,11 @@ static int metricgroup__add_metric(const char *metric_name, const char *modifier
>   	 * Iterate over all metrics seeing if metric matches either the name or
>   	 * group. When it does add the metric to the list.
>   	 */
> -	map_for_each_metric(pe, i, map, metric_name) {
> +	table_for_each_metric(pe, i, table, metric_name) {
>   		has_match = true;
>   		ret = add_metric(&list, pe, modifier, metric_no_group,
>   				 /*root_metric=*/NULL,
> -				 /*visited_metrics=*/NULL, map);
> +				 /*visited_metrics=*/NULL, table);
>   		if (ret)
>   			goto out;
>   	}
> @@ -1198,7 +1194,7 @@ static int metricgroup__add_metric(const char *metric_name, const char *modifier
>   				.metric_no_group = metric_no_group,
>   				.has_match = &has_match,
>   				.ret = &ret,
> -				.map = map,
> +				.table = table,
>   			},
>   		};
>   
> @@ -1227,12 +1223,12 @@ static int metricgroup__add_metric(const char *metric_name, const char *modifier
>    *                   global. Grouping is the default but due to multiplexing the
>    *                   user may override.
>    * @metric_list: The list that metrics are added to.
> - * @map: The map that is searched for metrics, most commonly the table for the
> + * @table: The table that is searched for metrics, most commonly the table for the
>    *       architecture perf is running upon.
>    */
>   static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
>   					struct list_head *metric_list,
> -					const struct pmu_events_map *map)
> +					const struct pmu_event *table)
>   {
>   	char *list_itr, *list_copy, *metric_name, *modifier;
>   	int ret, count = 0;
> @@ -1249,7 +1245,7 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
>   
>   		ret = metricgroup__add_metric(metric_name, modifier,
>   					      metric_no_group, metric_list,
> -					      map);
> +					      table);
>   		if (ret == -EINVAL)
>   			pr_err("Cannot find metric or group `%s'\n", metric_name);
>   
> @@ -1440,7 +1436,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
>   			bool metric_no_merge,
>   			struct perf_pmu *fake_pmu,
>   			struct rblist *metric_events_list,
> -			const struct pmu_events_map *map)
> +			const struct pmu_event *table)
>   {
>   	struct evlist *combined_evlist = NULL;
>   	LIST_HEAD(metric_list);
> @@ -1451,7 +1447,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
>   	if (metric_events_list->nr_entries == 0)
>   		metricgroup__rblist_init(metric_events_list);
>   	ret = metricgroup__add_metric_list(str, metric_no_group,
> -					   &metric_list, map);
> +					   &metric_list, table);
>   	if (ret)
>   		goto out;
>   
> @@ -1586,34 +1582,34 @@ int metricgroup__parse_groups(const struct option *opt,
>   			      struct rblist *metric_events)
>   {
>   	struct evlist *perf_evlist = *(struct evlist **)opt->value;
> -	const struct pmu_events_map *map = pmu_events_map__find();
> +	const struct pmu_event *table = pmu_events_map__find();
>   
>   	return parse_groups(perf_evlist, str, metric_no_group,
> -			    metric_no_merge, NULL, metric_events, map);
> +			    metric_no_merge, NULL, metric_events, table);
>   }
>   
>   int metricgroup__parse_groups_test(struct evlist *evlist,
> -				   const struct pmu_events_map *map,
> +				   const struct pmu_event *table,
>   				   const char *str,
>   				   bool metric_no_group,
>   				   bool metric_no_merge,
>   				   struct rblist *metric_events)
>   {
>   	return parse_groups(evlist, str, metric_no_group,
> -			    metric_no_merge, &perf_pmu__fake, metric_events, map);
> +			    metric_no_merge, &perf_pmu__fake, metric_events, table);
>   }
>   
>   bool metricgroup__has_metric(const char *metric)
>   {
> -	const struct pmu_events_map *map = pmu_events_map__find();
> +	const struct pmu_event *table = pmu_events_map__find();
>   	const struct pmu_event *pe;
>   	int i;
>   
> -	if (!map)
> +	if (!table)
>   		return false;
>   
>   	for (i = 0; ; i++) {
> -		pe = &map->table[i];
> +		pe = &table[i];
>   
>   		if (!pe->name && !pe->metric_group && !pe->metric_name)
>   			break;
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> index 2b42b778d1bf..5a1390e73d25 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -71,9 +71,9 @@ int metricgroup__parse_groups(const struct option *opt,
>   			      bool metric_no_merge,
>   			      struct rblist *metric_events);
>   const struct pmu_event *metricgroup__find_metric(const char *metric,
> -						 const struct pmu_events_map *map);
> +						 const struct pmu_event *table);
>   int metricgroup__parse_groups_test(struct evlist *evlist,
> -				   const struct pmu_events_map *map,
> +				   const struct pmu_event *table,
>   				   const char *str,
>   				   bool metric_no_group,
>   				   bool metric_no_merge,
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index d8717c4548a4..f3e3c4a147e9 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -710,9 +710,9 @@ static char *perf_pmu__getcpuid(struct perf_pmu *pmu)
>   	return cpuid;
>   }
>   
> -const struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
> +const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu)
>   {
> -	const struct pmu_events_map *map;
> +	const struct pmu_event *table = NULL;
>   	char *cpuid = perf_pmu__getcpuid(pmu);
>   	int i;
>   
> @@ -724,22 +724,23 @@ const struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
>   
>   	i = 0;
>   	for (;;) {
> -		map = &pmu_events_map[i++];
> -		if (!map->table) {
> -			map = NULL;
> +		const struct pmu_events_map *map = &pmu_events_map[i++];
> +
> +		if (!map->table)
>   			break;
> -		}
>   
> -		if (!strcmp_cpuid_str(map->cpuid, cpuid))
> +		if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
> +			table = map->table;
>   			break;
> +		}
>   	}
>   	free(cpuid);
> -	return map;
> +	return table;
>   }
>   
> -const struct pmu_events_map *__weak pmu_events_map__find(void)
> +__weak const struct pmu_event *pmu_events_map__find(void)
>   {
> -	return perf_pmu__find_map(NULL);
> +	return perf_pmu__find_table(NULL);
>   }
>   
>   /*
> @@ -824,7 +825,7 @@ bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
>    * as aliases.
>    */
>   void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,

Again, it seems that this name should be changed

> -			     const struct pmu_events_map *map)
> +			     const struct pmu_event *table)
>   {
>   	int i;
>   	const char *name = pmu->name;
> @@ -834,7 +835,7 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
>   	i = 0;
>   	while (1) {
>   		const char *cpu_name = is_arm_pmu_core(name) ? name : "cpu";
> -		const struct pmu_event *pe = &map->table[i++];
> +		const struct pmu_event *pe = &table[i++];
>   		const char *pname = pe->pmu ? pe->pmu : cpu_name;
>   
>   		if (!pe->name) {
> @@ -859,13 +860,13 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
>   
>   static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
>   {
> -	const struct pmu_events_map *map;
> +	const struct pmu_event *table;
>   
> -	map = perf_pmu__find_map(pmu);
> -	if (!map)
> +	table = perf_pmu__find_table(pmu);
> +	if (!table)
>   		return;
>   
> -	pmu_add_cpu_aliases_map(head, pmu, map);
> +	pmu_add_cpu_aliases_map(head, pmu, table);
>   }
>   
>   struct pmu_sys_event_iter_data {
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 7e667eec2a01..015242c83698 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -126,10 +126,10 @@ int perf_pmu__test(void);
>   
>   struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
>   void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
> -			     const struct pmu_events_map *map);
> +			     const struct pmu_event *map);
>   
> -const struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
> -const struct pmu_events_map *pmu_events_map__find(void);
> +const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu);
> +const struct pmu_event *pmu_events_map__find(void);
>   bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
>   void perf_pmu_free_alias(struct perf_pmu_alias *alias);
>   
> diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
> index cd3a34840389..1ecb718fc0eb 100644
> --- a/tools/perf/util/s390-sample-raw.c
> +++ b/tools/perf/util/s390-sample-raw.c
> @@ -135,12 +135,12 @@ static int get_counterset_start(int setnr)
>    * the name of this counter.
>    * If no match is found a NULL pointer is returned.
>    */
> -static const char *get_counter_name(int set, int nr, const struct pmu_events_map *map)
> +static const char *get_counter_name(int set, int nr, const struct pmu_event *table)
>   {
>   	int rc, event_nr, wanted = get_counterset_start(set) + nr;
>   
> -	if (map) {
> -		const struct pmu_event *evp = map->table;
> +	if (table) {
> +		const struct pmu_event *evp = table;
>   
>   		for (; evp->name || evp->event || evp->desc; ++evp) {
>   			if (evp->name == NULL || evp->event == NULL)
> @@ -159,10 +159,10 @@ static void s390_cpumcfdg_dump(struct perf_sample *sample)
>   	unsigned char *buf = sample->raw_data;
>   	const char *color = PERF_COLOR_BLUE;
>   	struct cf_ctrset_entry *cep, ce;
> -	const struct pmu_events_map *map;
> +	const struct pmu_event *table;
>   	u64 *p;
>   
> -	map = pmu_events_map__find();
> +	table = pmu_events_map__find();
>   	while (offset < len) {
>   		cep = (struct cf_ctrset_entry *)(buf + offset);
>   
> @@ -180,7 +180,7 @@ static void s390_cpumcfdg_dump(struct perf_sample *sample)
>   		color_fprintf(stdout, color, "    [%#08zx] Counterset:%d"
>   			      " Counters:%d\n", offset, ce.set, ce.ctr);
>   		for (i = 0, p = (u64 *)(cep + 1); i < ce.ctr; ++i, ++p) {
> -			const char *ev_name = get_counter_name(ce.set, i, map);
> +			const char *ev_name = get_counter_name(ce.set, i, table);
>   
>   			color_fprintf(stdout, color,
>   				      "\tCounter:%03d %s Value:%#018lx\n", i,

