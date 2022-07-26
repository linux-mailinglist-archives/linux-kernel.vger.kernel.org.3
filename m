Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038C75818B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239634AbiGZRlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239632AbiGZRkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:40:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664EE3247F;
        Tue, 26 Jul 2022 10:40:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 784CC60F13;
        Tue, 26 Jul 2022 17:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF83C433D6;
        Tue, 26 Jul 2022 17:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658857234;
        bh=ZrN0GlMfIhXXY8Od+oM3R5g9HrIg3R6H3qynMH8GcqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Je93CidxRjhrtUAH+adrmlBJEd0iFbP0/DG18zaWs+hezewtRN9nGI1iRfpd74mSj
         VJSS4MxSzCHF8/adXYmDCn+Fg1VaKfS3NkihmXwzh4r5MWeokHhG6eu4vd1ts9s6/R
         NQl5YlIBkq9JjOlI1/zTa+T0sClGSuZyA/22XOXB0eeoKyXVGMyS+zHsva2FFJMhGU
         Gh6pwiWcxZHyWjSzkTQHVXqZQao6gj09uFIydOAcmDrErKy0nGoZwgoYWvYCg0kyjl
         94sQu7Dy3aRyQ/9S4BNLx6jeqQ9brOHfYthQ05NNRQcZwoO4aBsfvr//4aX54XRS1h
         dfI0v0L+hjOYQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1FF3140374; Tue, 26 Jul 2022 14:40:32 -0300 (-03)
Date:   Tue, 26 Jul 2022 14:40:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, pc@us.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC v3 06/17] perf kwork: Implement perf kwork report
Message-ID: <YuAnEBpYSf53PkXI@kernel.org>
References: <20220709015033.38326-1-yangjihong1@huawei.com>
 <20220709015033.38326-7-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220709015033.38326-7-yangjihong1@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jul 09, 2022 at 09:50:22AM +0800, Yang Jihong escreveu:
> +
> +static void report_print_work(struct perf_kwork *kwork,
> +			      struct kwork_work *work)
> +{
> +	int ret = 0;
> +	char kwork_name[PRINT_KWORK_NAME_WIDTH];
> +	char max_runtime_start[32], max_runtime_end[32];

Committer notes:

- Add some {} for multiline for/if blocks

- Return the calculated number of printed bytes in report_print_work,
  otherwise soem compilers will complain that variable isn't used, e.g.:

   2    92.64 almalinux:9                   : FAIL clang version 13.0.1 (Red Hat 13.0.1-1.el9)
    builtin-kwork.c:1061:6: error: variable 'ret' set but not used [-Werror,-Wunused-but-set-variable]
            int ret = 0;


> +
> +	printf(" ");
> +
> +	/*
> +	 * kwork name
> +	 */
> +	if (work->class && work->class->work_name) {
> +		work->class->work_name(work, kwork_name,
> +				       PRINT_KWORK_NAME_WIDTH);
> +		ret += printf(" %-*s |", PRINT_KWORK_NAME_WIDTH, kwork_name);
> +	} else
> +		ret += printf(" %-*s |", PRINT_KWORK_NAME_WIDTH, "");
> +
> +	/*
> +	 * cpu
> +	 */
> +	ret += printf(" %0*d |", PRINT_CPU_WIDTH, work->cpu);
> +
> +	/*
> +	 * total runtime
> +	 */
> +	if (kwork->report == KWORK_REPORT_RUNTIME)
> +		ret += printf(" %*.*f ms |",
> +			      PRINT_RUNTIME_WIDTH, RPINT_DECIMAL_WIDTH,
> +			      (double)work->total_runtime / NSEC_PER_MSEC);
> +
> +	/*
> +	 * count
> +	 */
> +	ret += printf(" %*" PRIu64 " |", PRINT_COUNT_WIDTH, work->nr_atoms);
> +
> +	/*
> +	 * max runtime, max runtime start, max runtime end
> +	 */
> +	if (kwork->report == KWORK_REPORT_RUNTIME) {
> +
> +		timestamp__scnprintf_usec(work->max_runtime_start,
> +					  max_runtime_start,
> +					  sizeof(max_runtime_start));
> +		timestamp__scnprintf_usec(work->max_runtime_end,
> +					  max_runtime_end,
> +					  sizeof(max_runtime_end));
> +		ret += printf(" %*.*f ms | %*s s | %*s s |",
> +			      PRINT_RUNTIME_WIDTH, RPINT_DECIMAL_WIDTH,
> +			      (double)work->max_runtime / NSEC_PER_MSEC,
> +			      PRINT_TIMESTAMP_WIDTH, max_runtime_start,
> +			      PRINT_TIMESTAMP_WIDTH, max_runtime_end);
> +	}
> +
> +	printf("\n");
> +}
> +
> +static int report_print_header(struct perf_kwork *kwork)
> +{
> +	int ret;
> +
> +	printf("\n ");
> +	ret = printf(" %-*s | %-*s |",
> +		     PRINT_KWORK_NAME_WIDTH, "Kwork Name",
> +		     PRINT_CPU_WIDTH, "Cpu");
> +
> +	if (kwork->report == KWORK_REPORT_RUNTIME)
> +		ret += printf(" %-*s |",
> +			      PRINT_RUNTIME_HEADER_WIDTH, "Total Runtime");
> +
> +	ret += printf(" %-*s |", PRINT_COUNT_WIDTH, "Count");
> +
> +	if (kwork->report == KWORK_REPORT_RUNTIME)
> +		ret += printf(" %-*s | %-*s | %-*s |",
> +			      PRINT_RUNTIME_HEADER_WIDTH, "Max runtime",
> +			      PRINT_TIMESTAMP_HEADER_WIDTH, "Max runtime start",
> +			      PRINT_TIMESTAMP_HEADER_WIDTH, "Max runtime end");
> +
> +	printf("\n");
> +	print_separator(ret);
> +	return ret;
> +}
> +
> +static void print_summary(struct perf_kwork *kwork)
> +{
> +	u64 time = kwork->timeend - kwork->timestart;
> +
> +	printf("  Total count            : %9" PRIu64 "\n", kwork->all_count);
> +	printf("  Total runtime   (msec) : %9.3f (%.3f%% load average)\n",
> +	       (double)kwork->all_runtime / NSEC_PER_MSEC,
> +	       time == 0 ? 0 : (double)kwork->all_runtime / time);
> +	printf("  Total time span (msec) : %9.3f\n",
> +	       (double)time / NSEC_PER_MSEC);
> +}
> +
> +static unsigned long long nr_list_entry(struct list_head *head)
> +{
> +	struct list_head *pos;
> +	unsigned long long n = 0;
> +
> +	list_for_each(pos, head)
> +		n++;
> +
> +	return n;
> +}
> +
> +static void print_skipped_events(struct perf_kwork *kwork)
> +{
> +	int i;
> +	const char *const kwork_event_str[] = {
> +		[KWORK_TRACE_ENTRY] = "entry",
> +		[KWORK_TRACE_EXIT]  = "exit",
> +	};
> +
> +	if ((kwork->nr_skipped_events[KWORK_TRACE_MAX] != 0) &&
> +	    (kwork->nr_events != 0)) {
> +		printf("  INFO: %.3f%% skipped events (%" PRIu64 " including ",
> +		       (double)kwork->nr_skipped_events[KWORK_TRACE_MAX] /
> +		       (double)kwork->nr_events * 100.0,
> +		       kwork->nr_skipped_events[KWORK_TRACE_MAX]);
> +
> +		for (i = 0; i < KWORK_TRACE_MAX; i++)
> +			printf("%" PRIu64 " %s%s",
> +			       kwork->nr_skipped_events[i],
> +			       kwork_event_str[i],
> +			       (i == KWORK_TRACE_MAX - 1) ? ")\n" : ", ");
> +	}
> +
> +	if (verbose > 0)
> +		printf("  INFO: use %lld atom pages\n",
> +		       nr_list_entry(&kwork->atom_page_list));
> +}
> +
> +static void print_bad_events(struct perf_kwork *kwork)
> +{
> +	if ((kwork->nr_lost_events != 0) && (kwork->nr_events != 0))
> +		printf("  INFO: %.3f%% lost events (%ld out of %ld, in %ld chunks)\n",
> +		       (double)kwork->nr_lost_events /
> +		       (double)kwork->nr_events * 100.0,
> +		       kwork->nr_lost_events, kwork->nr_events,
> +		       kwork->nr_lost_chunks);
> +}
> +
> +static void work_sort(struct perf_kwork *kwork, struct kwork_class *class)
> +{
> +	struct rb_node *node;
> +	struct kwork_work *data;
> +	struct rb_root_cached *root = &class->work_root;
> +
> +	pr_debug("Sorting %s ...\n", class->name);
> +	for (;;) {
> +		node = rb_first_cached(root);
> +		if (!node)
> +			break;
> +
> +		rb_erase_cached(node, root);
> +		data = rb_entry(node, struct kwork_work, node);
> +		work_insert(&kwork->sorted_work_root,
> +			       data, &kwork->sort_list);
> +	}
> +}
> +
> +static void perf_kwork__sort(struct perf_kwork *kwork)
> +{
> +	struct kwork_class *class;
> +
> +	list_for_each_entry(class, &kwork->class_list, list)
> +		work_sort(kwork, class);
> +}
> +
> +static int perf_kwork__check_config(struct perf_kwork *kwork,
> +				    struct perf_session *session)
> +{
> +	int ret;
> +	struct kwork_class *class;
> +
> +	static struct trace_kwork_handler report_ops = {
> +		.entry_event = report_entry_event,
> +		.exit_event  = report_exit_event,
> +	};
> +
> +	switch (kwork->report) {
> +	case KWORK_REPORT_RUNTIME:
> +		kwork->tp_handler = &report_ops;
> +		break;
> +	default:
> +		pr_debug("Invalid report type %d\n", kwork->report);
> +		return -1;
> +	}
> +
> +	list_for_each_entry(class, &kwork->class_list, list)
> +		if ((class->class_init != NULL) &&
> +		    (class->class_init(class, session) != 0))
> +			return -1;
> +
> +	if (kwork->cpu_list != NULL) {
> +		ret = perf_session__cpu_bitmap(session,
> +					       kwork->cpu_list,
> +					       kwork->cpu_bitmap);
> +		if (ret < 0) {
> +			pr_err("Invalid cpu bitmap\n");
> +			return -1;
> +		}
> +	}
> +
> +	if (kwork->time_str != NULL) {
> +		ret = perf_time__parse_str(&kwork->ptime, kwork->time_str);
> +		if (ret != 0) {
> +			pr_err("Invalid time span\n");
> +			return -1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int perf_kwork__read_events(struct perf_kwork *kwork)
> +{
> +	int ret = -1;
> +	struct perf_session *session = NULL;
> +
> +	struct perf_data data = {
> +		.path  = input_name,
> +		.mode  = PERF_DATA_MODE_READ,
> +		.force = kwork->force,
> +	};
> +
> +	session = perf_session__new(&data, &kwork->tool);
> +	if (IS_ERR(session)) {
> +		pr_debug("Error creating perf session\n");
> +		return PTR_ERR(session);
> +	}
> +
> +	symbol__init(&session->header.env);
> +
> +	if (perf_kwork__check_config(kwork, session) != 0)
> +		goto out_delete;
> +
> +	if (session->tevent.pevent &&
> +	    tep_set_function_resolver(session->tevent.pevent,
> +				      machine__resolve_kernel_addr,
> +				      &session->machines.host) < 0) {
> +		pr_err("Failed to set libtraceevent function resolver\n");
> +		goto out_delete;
> +	}
> +
> +	ret = perf_session__process_events(session);
> +	if (ret) {
> +		pr_debug("Failed to process events, error %d\n", ret);
> +		goto out_delete;
> +	}
> +
> +	kwork->nr_events      = session->evlist->stats.nr_events[0];
> +	kwork->nr_lost_events = session->evlist->stats.total_lost;
> +	kwork->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
> +
> +out_delete:
> +	perf_session__delete(session);
> +	return ret;
> +}
> +
> +static void process_skipped_events(struct perf_kwork *kwork,
> +				   struct kwork_work *work)
> +{
> +	int i;
> +	unsigned long long count;
> +
> +	for (i = 0; i < KWORK_TRACE_MAX; i++) {
> +		count = nr_list_entry(&work->atom_list[i]);
> +		kwork->nr_skipped_events[i] += count;
> +		kwork->nr_skipped_events[KWORK_TRACE_MAX] += count;
> +	}
> +}
> +
> +static int perf_kwork__report(struct perf_kwork *kwork)
> +{
> +	int ret;
> +	struct rb_node *next;
> +	struct kwork_work *work;
> +
> +	ret = perf_kwork__read_events(kwork);
> +	if (ret != 0)
> +		return -1;
> +
> +	perf_kwork__sort(kwork);
> +
> +	setup_pager();
> +
> +	ret = report_print_header(kwork);
> +	next = rb_first_cached(&kwork->sorted_work_root);
> +	while (next) {
> +		work = rb_entry(next, struct kwork_work, node);
> +		process_skipped_events(kwork, work);
> +
> +		if (work->nr_atoms != 0) {
> +			report_print_work(kwork, work);
> +			if (kwork->summary) {
> +				kwork->all_runtime += work->total_runtime;
> +				kwork->all_count += work->nr_atoms;
> +			}
> +		}
> +		next = rb_next(next);
> +	}
> +	print_separator(ret);
> +
> +	if (kwork->summary) {
> +		print_summary(kwork);
> +		print_separator(ret);
> +	}
> +
> +	print_bad_events(kwork);
> +	print_skipped_events(kwork);
> +	printf("\n");
> +
> +	return 0;
> +}
> +
> +typedef int (*tracepoint_handler)(struct perf_tool *tool,
> +				  struct evsel *evsel,
> +				  struct perf_sample *sample,
> +				  struct machine *machine);
> +
> +static int perf_kwork__process_tracepoint_sample(struct perf_tool *tool,
> +						 union perf_event *event __maybe_unused,
> +						 struct perf_sample *sample,
> +						 struct evsel *evsel,
> +						 struct machine *machine)
> +{
> +	int err = 0;
> +
> +	if (evsel->handler != NULL) {
> +		tracepoint_handler f = evsel->handler;
> +
> +		err = f(tool, evsel, sample, machine);
> +	}
> +
> +	return err;
> +}
> +
>  static void setup_event_list(struct perf_kwork *kwork,
>  			     const struct option *options,
>  			     const char * const usage_msg[])
> @@ -161,11 +960,37 @@ static int perf_kwork__record(struct perf_kwork *kwork,
>  int cmd_kwork(int argc, const char **argv)
>  {
>  	static struct perf_kwork kwork = {
> +		.tool = {
> +			.mmap    = perf_event__process_mmap,
> +			.mmap2   = perf_event__process_mmap2,
> +			.sample  = perf_kwork__process_tracepoint_sample,
> +		},
> +
>  		.class_list          = LIST_HEAD_INIT(kwork.class_list),
> +		.atom_page_list      = LIST_HEAD_INIT(kwork.atom_page_list),
> +		.sort_list           = LIST_HEAD_INIT(kwork.sort_list),
> +		.cmp_id              = LIST_HEAD_INIT(kwork.cmp_id),
> +		.sorted_work_root    = RB_ROOT_CACHED,
> +		.tp_handler          = NULL,
>  
> +		.profile_name        = NULL,
> +		.cpu_list            = NULL,
> +		.time_str            = NULL,
>  		.force               = false,
>  		.event_list_str      = NULL,
> +		.summary             = false,
> +		.sort_order          = NULL,
> +
> +		.timestart           = 0,
> +		.timeend             = 0,
> +		.nr_events           = 0,
> +		.nr_lost_chunks      = 0,
> +		.nr_lost_events      = 0,
> +		.all_runtime         = 0,
> +		.all_count           = 0,
> +		.nr_skipped_events   = { 0 },
>  	};
> +	static const char default_report_sort_order[] = "runtime, max, count";
>  
>  	const struct option kwork_options[] = {
>  	OPT_INCR('v', "verbose", &verbose,
> @@ -177,13 +1002,32 @@ int cmd_kwork(int argc, const char **argv)
>  	OPT_BOOLEAN('f', "force", &kwork.force, "don't complain, do it"),
>  	OPT_END()
>  	};
> +	const struct option report_options[] = {
> +	OPT_STRING('s', "sort", &kwork.sort_order, "key[,key2...]",
> +		   "sort by key(s): runtime, max, count"),
> +	OPT_STRING('C', "cpu", &kwork.cpu_list, "cpu",
> +		   "list of cpus to profile"),
> +	OPT_STRING('n', "name", &kwork.profile_name, "name",
> +		   "event name to profile"),
> +	OPT_STRING(0, "time", &kwork.time_str, "str",
> +		   "Time span for analysis (start,stop)"),
> +	OPT_STRING('i', "input", &input_name, "file",
> +		   "input file name"),
> +	OPT_BOOLEAN('S', "with-summary", &kwork.summary,
> +		    "Show summary with statistics"),
> +	OPT_PARENT(kwork_options)
> +	};
>  
>  	const char *kwork_usage[] = {
>  		NULL,
>  		NULL
>  	};
> +	const char * const report_usage[] = {
> +		"perf kwork report [<options>]",
> +		NULL
> +	};
>  	const char *const kwork_subcommands[] = {
> -		"record", NULL
> +		"record", "report", NULL
>  	};
>  
>  	argc = parse_options_subcommand(argc, argv, kwork_options,
> @@ -193,10 +1037,21 @@ int cmd_kwork(int argc, const char **argv)
>  		usage_with_options(kwork_usage, kwork_options);
>  
>  	setup_event_list(&kwork, kwork_options, kwork_usage);
> +	sort_dimension__add(&kwork, "id", &kwork.cmp_id);
>  
>  	if (strlen(argv[0]) > 2 && strstarts("record", argv[0]))
>  		return perf_kwork__record(&kwork, argc, argv);
> -	else
> +	else if (strlen(argv[0]) > 2 && strstarts("report", argv[0])) {
> +		kwork.sort_order = default_report_sort_order;
> +		if (argc > 1) {
> +			argc = parse_options(argc, argv, report_options, report_usage, 0);
> +			if (argc)
> +				usage_with_options(report_usage, report_options);
> +		}
> +		kwork.report = KWORK_REPORT_RUNTIME;
> +		setup_sorting(&kwork, report_options, report_usage);
> +		return perf_kwork__report(&kwork);
> +	} else
>  		usage_with_options(kwork_usage, kwork_options);
>  
>  	return 0;
> diff --git a/tools/perf/util/kwork.h b/tools/perf/util/kwork.h
> index 03203c4deb34..0a86bf47c74d 100644
> --- a/tools/perf/util/kwork.h
> +++ b/tools/perf/util/kwork.h
> @@ -19,6 +19,105 @@ enum kwork_class_type {
>  	KWORK_CLASS_MAX,
>  };
>  
> +enum kwork_report_type {
> +	KWORK_REPORT_RUNTIME,
> +};
> +
> +enum kwork_trace_type {
> +	KWORK_TRACE_ENTRY,
> +	KWORK_TRACE_EXIT,
> +	KWORK_TRACE_MAX,
> +};
> +
> +/*
> + * data structure:
> + *
> + *                 +==================+ +============+ +======================+
> + *                 |      class       | |    work    | |         atom         |
> + *                 +==================+ +============+ +======================+
> + * +------------+  |  +-----+         | |  +------+  | |  +-------+   +-----+ |
> + * | perf_kwork | +-> | irq | --------|+-> | eth0 | --+-> | raise | - | ... | --+   +-----------+
> + * +-----+------+ ||  +-----+         |||  +------+  |||  +-------+   +-----+ | |   |           |
> + *       |        ||                  |||            |||                      | +-> | atom_page |
> + *       |        ||                  |||            |||  +-------+   +-----+ |     |           |
> + *       |  class_list                |||            |+-> | entry | - | ... | ----> |           |
> + *       |        ||                  |||            |||  +-------+   +-----+ |     |           |
> + *       |        ||                  |||            |||                      | +-> |           |
> + *       |        ||                  |||            |||  +-------+   +-----+ | |   |           |
> + *       |        ||                  |||            |+-> | exit  | - | ... | --+   +-----+-----+
> + *       |        ||                  |||            | |  +-------+   +-----+ |           |
> + *       |        ||                  |||            | |                      |           |
> + *       |        ||                  |||  +-----+   | |                      |           |
> + *       |        ||                  |+-> | ... |   | |                      |           |
> + *       |        ||                  | |  +-----+   | |                      |           |
> + *       |        ||                  | |            | |                      |           |
> + *       |        ||  +---------+     | |  +-----+   | |  +-------+   +-----+ |           |
> + *       |        +-> | softirq | -------> | RCU | ---+-> | raise | - | ... | --+   +-----+-----+
> + *       |        ||  +---------+     | |  +-----+   |||  +-------+   +-----+ | |   |           |
> + *       |        ||                  | |            |||                      | +-> | atom_page |
> + *       |        ||                  | |            |||  +-------+   +-----+ |     |           |
> + *       |        ||                  | |            |+-> | entry | - | ... | ----> |           |
> + *       |        ||                  | |            |||  +-------+   +-----+ |     |           |
> + *       |        ||                  | |            |||                      | +-> |           |
> + *       |        ||                  | |            |||  +-------+   +-----+ | |   |           |
> + *       |        ||                  | |            |+-> | exit  | - | ... | --+   +-----+-----+
> + *       |        ||                  | |            | |  +-------+   +-----+ |           |
> + *       |        ||                  | |            | |                      |           |
> + *       |        ||  +-----------+   | |  +-----+   | |                      |           |
> + *       |        +-> | workqueue | -----> | ... |   | |                      |           |
> + *       |         |  +-----------+   | |  +-----+   | |                      |           |
> + *       |         +==================+ +============+ +======================+           |
> + *       |                                                                                |
> + *       +---->  atom_page_list  ---------------------------------------------------------+
> + *
> + */
> +
> +struct kwork_atom {
> +	struct list_head list;
> +	u64 time;
> +	struct kwork_atom *prev;
> +
> +	void *page_addr;
> +	unsigned long bit_inpage;
> +};
> +
> +#define NR_ATOM_PER_PAGE 128
> +struct kwork_atom_page {
> +	struct list_head list;
> +	struct kwork_atom atoms[NR_ATOM_PER_PAGE];
> +	DECLARE_BITMAP(bitmap, NR_ATOM_PER_PAGE);
> +};
> +
> +struct kwork_class;
> +struct kwork_work {
> +	/*
> +	 * class field
> +	 */
> +	struct rb_node node;
> +	struct kwork_class *class;
> +
> +	/*
> +	 * work field
> +	 */
> +	u64 id;
> +	int cpu;
> +	char *name;
> +
> +	/*
> +	 * atom field
> +	 */
> +	u64 nr_atoms;
> +	struct list_head atom_list[KWORK_TRACE_MAX];
> +
> +	/*
> +	 * runtime report
> +	 */
> +	u64 max_runtime;
> +	u64 max_runtime_start;
> +	u64 max_runtime_end;
> +	u64 total_runtime;
> +};
> +
>  struct kwork_class {
>  	struct list_head list;
>  	const char *name;
> @@ -26,19 +125,81 @@ struct kwork_class {
>  
>  	unsigned int nr_tracepoints;
>  	const struct evsel_str_handler *tp_handlers;
> +
> +	struct rb_root_cached work_root;
> +
> +	int (*class_init)(struct kwork_class *class,
> +			  struct perf_session *session);
> +
> +	void (*work_init)(struct kwork_class *class,
> +			  struct kwork_work *work,
> +			  struct evsel *evsel,
> +			  struct perf_sample *sample,
> +			  struct machine *machine);
> +
> +	void (*work_name)(struct kwork_work *work,
> +			  char *buf, int len);
> +};
> +
> +struct perf_kwork;
> +struct trace_kwork_handler {
> +	int (*entry_event)(struct perf_kwork *kwork,
> +			   struct kwork_class *class, struct evsel *evsel,
> +			   struct perf_sample *sample, struct machine *machine);
> +
> +	int (*exit_event)(struct perf_kwork *kwork,
> +			  struct kwork_class *class, struct evsel *evsel,
> +			  struct perf_sample *sample, struct machine *machine);
>  };
>  
>  struct perf_kwork {
>  	/*
>  	 * metadata
>  	 */
> +	struct perf_tool tool;
>  	struct list_head class_list;
> +	struct list_head atom_page_list;
> +	struct list_head sort_list, cmp_id;
> +	struct rb_root_cached sorted_work_root;
> +	const struct trace_kwork_handler *tp_handler;
> +
> +	/*
> +	 * profile filters
> +	 */
> +	const char *profile_name;
> +
> +	const char *cpu_list;
> +	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
> +
> +	const char *time_str;
> +	struct perf_time_interval ptime;
>  
>  	/*
>  	 * options for command
>  	 */
>  	bool force;
>  	const char *event_list_str;
> +	enum kwork_report_type report;
> +
> +	/*
> +	 * options for subcommand
> +	 */
> +	bool summary;
> +	const char *sort_order;
> +
> +	/*
> +	 * statistics
> +	 */
> +	u64 timestart;
> +	u64 timeend;
> +
> +	unsigned long nr_events;
> +	unsigned long nr_lost_chunks;
> +	unsigned long nr_lost_events;
> +
> +	u64 all_runtime;
> +	u64 all_count;
> +	u64 nr_skipped_events[KWORK_TRACE_MAX + 1];
>  };
>  
>  #endif  /* PERF_UTIL_KWORK_H */
> -- 
> 2.30.GIT

-- 

- Arnaldo
