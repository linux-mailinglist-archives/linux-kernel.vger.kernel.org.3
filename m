Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B824B33F0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 09:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiBLIqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 03:46:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiBLIqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 03:46:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60382613F;
        Sat, 12 Feb 2022 00:46:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29533B80011;
        Sat, 12 Feb 2022 08:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2BFC340E7;
        Sat, 12 Feb 2022 08:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644655561;
        bh=ZD0wqzLQ1TM8QfacBwPUkDYzFa1fO8DrkSC/WluGzr8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jRZn68rTUr3aKtYr3hBd41AcViq+SNDk8NZB1TN1yqaABtbi4jtP9AAKOcCpXoK1E
         wUQd5O/3e1FRnlj34Qrd6Efpgy4GMWatb2/oiJ34vgNm/+Q9D67nCp3z3UX6tThLma
         p4hze7qUPI/8bamcLxGGxfxtuJcYboPVhFfo6aXfOrccCoVpybgr8PH4hJoAL5fGkR
         4znd7UL0Kh9hyHcoY74VUlK2/DTh1peSIlkvEUmyvWQtGV8HDgmrbaMykGjiljGmGX
         Wr04X7IHXlBBm/kn9QUuTD+8AfuoRQPlj8fMXZMma41lqMNddy5PmJOo/IWwUM7tWA
         leAvvQYdh4+Vw==
Date:   Sat, 12 Feb 2022 17:45:50 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?B?IkFuZHLDqSBBbG1laWRhIg==?= <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>, eranian@google.com
Subject: Re: [PATCH v3 17/22] perf map: Changes to reference counting
Message-Id: <20220212174550.7ff16e7fb08a2fca00bde35e@kernel.org>
In-Reply-To: <20220211103415.2737789-18-irogers@google.com>
References: <20220211103415.2737789-1-irogers@google.com>
        <20220211103415.2737789-18-irogers@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Fri, 11 Feb 2022 02:34:10 -0800
Ian Rogers <irogers@google.com> wrote:

> When a pointer to a map exists do a get, when that pointer is
> overwritten or freed, put the map. This avoids issues with gets and
> puts being inconsistently used causing, use after puts, etc. Reference
> count checking and address sanitizer were used to identify issues.

OK, and please add comments in the code what should be actually done
so the others can understand it correctly, since this changes the
map object handling model.

Previously;

  map__get(map);
  map_operations(map);
  map__put(map);

Now, we have to use the object returned from get() ops.
This is more likely to the memdup()/free().

  new = map__get(map);
  map_operations(new);
  map__put(new);

To update the object in the other object (e.g. machine__update_kernel_mmap())
The original one must be put because it has the old copy.

Previous;

  map__get(parent_obj->map);
  update_operation(parent_obj->map);
  map__put(parent_obj->map;

Is now;

  orig = parent_obj->map;
  new = map__get(orig);
  update_operation(new);
  parent_obj->map = new;
  map__put(orig);

I think this change also should be documented with some concrete example
patterns so that someone can program it correctly. :-)

(This is the reason why I asked you to introduce object-token instead
 of modifying object pointer itself.)

Thank you,

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/hists_cumulate.c     | 14 ++++-
>  tools/perf/tests/hists_filter.c       | 14 ++++-
>  tools/perf/tests/hists_link.c         | 18 +++++-
>  tools/perf/tests/hists_output.c       | 12 +++-
>  tools/perf/tests/mmap-thread-lookup.c |  3 +-
>  tools/perf/util/callchain.c           |  9 +--
>  tools/perf/util/event.c               |  8 ++-
>  tools/perf/util/hist.c                | 10 ++--
>  tools/perf/util/machine.c             | 80 ++++++++++++++++-----------
>  9 files changed, 118 insertions(+), 50 deletions(-)
> 
> diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
> index 17f4fcd6bdce..28f5eb41eed9 100644
> --- a/tools/perf/tests/hists_cumulate.c
> +++ b/tools/perf/tests/hists_cumulate.c
> @@ -112,6 +112,7 @@ static int add_hist_entries(struct hists *hists, struct machine *machine)
>  		}
>  
>  		fake_samples[i].thread = al.thread;
> +		map__put(fake_samples[i].map);
>  		fake_samples[i].map = al.map;
>  		fake_samples[i].sym = al.sym;
>  	}
> @@ -147,15 +148,23 @@ static void del_hist_entries(struct hists *hists)
>  	}
>  }
>  
> +static void put_fake_samples(void)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < ARRAY_SIZE(fake_samples); i++)
> +		map__put(fake_samples[i].map);
> +}
> +
>  typedef int (*test_fn_t)(struct evsel *, struct machine *);
>  
>  #define COMM(he)  (thread__comm_str(he->thread))
> -#define DSO(he)   (he->ms.map->dso->short_name)
> +#define DSO(he)   (map__dso(he->ms.map)->short_name)
>  #define SYM(he)   (he->ms.sym->name)
>  #define CPU(he)   (he->cpu)
>  #define PID(he)   (he->thread->tid)
>  #define DEPTH(he) (he->callchain->max_depth)
> -#define CDSO(cl)  (cl->ms.map->dso->short_name)
> +#define CDSO(cl)  (map__dso(cl->ms.map)->short_name)
>  #define CSYM(cl)  (cl->ms.sym->name)
>  
>  struct result {
> @@ -733,6 +742,7 @@ static int test__hists_cumulate(struct test_suite *test __maybe_unused, int subt
>  	/* tear down everything */
>  	evlist__delete(evlist);
>  	machines__exit(&machines);
> +	put_fake_samples();
>  
>  	return err;
>  }
> diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
> index 08cbeb9e39ae..bcd46244182a 100644
> --- a/tools/perf/tests/hists_filter.c
> +++ b/tools/perf/tests/hists_filter.c
> @@ -89,6 +89,7 @@ static int add_hist_entries(struct evlist *evlist,
>  			}
>  
>  			fake_samples[i].thread = al.thread;
> +			map__put(fake_samples[i].map);
>  			fake_samples[i].map = al.map;
>  			fake_samples[i].sym = al.sym;
>  		}
> @@ -101,6 +102,14 @@ static int add_hist_entries(struct evlist *evlist,
>  	return TEST_FAIL;
>  }
>  
> +static void put_fake_samples(void)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < ARRAY_SIZE(fake_samples); i++)
> +		map__put(fake_samples[i].map);
> +}
> +
>  static int test__hists_filter(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
>  {
>  	int err = TEST_FAIL;
> @@ -194,7 +203,7 @@ static int test__hists_filter(struct test_suite *test __maybe_unused, int subtes
>  		hists__filter_by_thread(hists);
>  
>  		/* now applying dso filter for 'kernel' */
> -		hists->dso_filter = fake_samples[0].map->dso;
> +		hists->dso_filter = map__dso(fake_samples[0].map);
>  		hists__filter_by_dso(hists);
>  
>  		if (verbose > 2) {
> @@ -288,7 +297,7 @@ static int test__hists_filter(struct test_suite *test __maybe_unused, int subtes
>  
>  		/* now applying all filters at once. */
>  		hists->thread_filter = fake_samples[1].thread;
> -		hists->dso_filter = fake_samples[1].map->dso;
> +		hists->dso_filter = map__dso(fake_samples[1].map);
>  		hists__filter_by_thread(hists);
>  		hists__filter_by_dso(hists);
>  
> @@ -322,6 +331,7 @@ static int test__hists_filter(struct test_suite *test __maybe_unused, int subtes
>  	evlist__delete(evlist);
>  	reset_output_field();
>  	machines__exit(&machines);
> +	put_fake_samples();
>  
>  	return err;
>  }
> diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
> index c575e13a850d..060e8731feff 100644
> --- a/tools/perf/tests/hists_link.c
> +++ b/tools/perf/tests/hists_link.c
> @@ -6,6 +6,7 @@
>  #include "evsel.h"
>  #include "evlist.h"
>  #include "machine.h"
> +#include "map.h"
>  #include "parse-events.h"
>  #include "hists_common.h"
>  #include "util/mmap.h"
> @@ -94,6 +95,7 @@ static int add_hist_entries(struct evlist *evlist, struct machine *machine)
>  			}
>  
>  			fake_common_samples[k].thread = al.thread;
> +			map__put(fake_common_samples[k].map);
>  			fake_common_samples[k].map = al.map;
>  			fake_common_samples[k].sym = al.sym;
>  		}
> @@ -126,11 +128,24 @@ static int add_hist_entries(struct evlist *evlist, struct machine *machine)
>  	return -1;
>  }
>  
> +static void put_fake_samples(void)
> +{
> +	size_t i, j;
> +
> +	for (i = 0; i < ARRAY_SIZE(fake_common_samples); i++)
> +		map__put(fake_common_samples[i].map);
> +	for (i = 0; i < ARRAY_SIZE(fake_samples); i++) {
> +		for (j = 0; j < ARRAY_SIZE(fake_samples[0]); j++)
> +			map__put(fake_samples[i][j].map);
> +	}
> +}
> +
>  static int find_sample(struct sample *samples, size_t nr_samples,
>  		       struct thread *t, struct map *m, struct symbol *s)
>  {
>  	while (nr_samples--) {
> -		if (samples->thread == t && samples->map == m &&
> +		if (samples->thread == t &&
> +		    samples->map == m &&
>  		    samples->sym == s)
>  			return 1;
>  		samples++;
> @@ -336,6 +351,7 @@ static int test__hists_link(struct test_suite *test __maybe_unused, int subtest
>  	evlist__delete(evlist);
>  	reset_output_field();
>  	machines__exit(&machines);
> +	put_fake_samples();
>  
>  	return err;
>  }
> diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
> index 0bde4a768c15..4af6916491e5 100644
> --- a/tools/perf/tests/hists_output.c
> +++ b/tools/perf/tests/hists_output.c
> @@ -78,6 +78,7 @@ static int add_hist_entries(struct hists *hists, struct machine *machine)
>  		}
>  
>  		fake_samples[i].thread = al.thread;
> +		map__put(fake_samples[i].map);
>  		fake_samples[i].map = al.map;
>  		fake_samples[i].sym = al.sym;
>  	}
> @@ -113,10 +114,18 @@ static void del_hist_entries(struct hists *hists)
>  	}
>  }
>  
> +static void put_fake_samples(void)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < ARRAY_SIZE(fake_samples); i++)
> +		map__put(fake_samples[i].map);
> +}
> +
>  typedef int (*test_fn_t)(struct evsel *, struct machine *);
>  
>  #define COMM(he)  (thread__comm_str(he->thread))
> -#define DSO(he)   (he->ms.map->dso->short_name)
> +#define DSO(he)   (map__dso(he->ms.map)->short_name)
>  #define SYM(he)   (he->ms.sym->name)
>  #define CPU(he)   (he->cpu)
>  #define PID(he)   (he->thread->tid)
> @@ -620,6 +629,7 @@ static int test__hists_output(struct test_suite *test __maybe_unused, int subtes
>  	/* tear down everything */
>  	evlist__delete(evlist);
>  	machines__exit(&machines);
> +	put_fake_samples();
>  
>  	return err;
>  }
> diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
> index a4301fc7b770..898eda55b7a8 100644
> --- a/tools/perf/tests/mmap-thread-lookup.c
> +++ b/tools/perf/tests/mmap-thread-lookup.c
> @@ -202,7 +202,8 @@ static int mmap_events(synth_cb synth)
>  			break;
>  		}
>  
> -		pr_debug("map %p, addr %" PRIx64 "\n", al.map, al.map->start);
> +		pr_debug("map %p, addr %" PRIx64 "\n", al.map, map__start(al.map));
> +		map__put(al.map);
>  	}
>  
>  	machine__delete_threads(machine);
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index a8cfd31a3ff0..ae65b7bc9ab7 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -583,7 +583,7 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
>  		}
>  		call->ip = cursor_node->ip;
>  		call->ms = cursor_node->ms;
> -		map__get(call->ms.map);
> +		call->ms.map = map__get(call->ms.map);
>  		call->srcline = cursor_node->srcline;
>  
>  		if (cursor_node->branch) {
> @@ -1061,7 +1061,7 @@ int callchain_cursor_append(struct callchain_cursor *cursor,
>  	node->ip = ip;
>  	map__zput(node->ms.map);
>  	node->ms = *ms;
> -	map__get(node->ms.map);
> +	node->ms.map = map__get(node->ms.map);
>  	node->branch = branch;
>  	node->nr_loop_iter = nr_loop_iter;
>  	node->iter_cycles = iter_cycles;
> @@ -1109,7 +1109,8 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
>  	struct machine *machine = maps__machine(node->ms.maps);
>  
>  	al->maps = node->ms.maps;
> -	al->map = node->ms.map;
> +	map__put(al->map);
> +	al->map = map__get(node->ms.map);
>  	al->sym = node->ms.sym;
>  	al->srcline = node->srcline;
>  	al->addr = node->ip;
> @@ -1530,7 +1531,7 @@ int callchain_node__make_parent_list(struct callchain_node *node)
>  				goto out;
>  			*new = *chain;
>  			new->has_children = false;
> -			map__get(new->ms.map);
> +			new->ms.map = map__get(new->ms.map);
>  			list_add_tail(&new->list, &head);
>  		}
>  		parent = parent->parent;
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 54a1d4df5f70..266318d5d006 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -484,13 +484,14 @@ size_t perf_event__fprintf_text_poke(union perf_event *event, struct machine *ma
>  	if (machine) {
>  		struct addr_location al;
>  
> -		al.map = maps__find(machine__kernel_maps(machine), tp->addr);
> +		al.map = map__get(maps__find(machine__kernel_maps(machine), tp->addr));
>  		if (al.map && map__load(al.map) >= 0) {
>  			al.addr = map__map_ip(al.map, tp->addr);
>  			al.sym = map__find_symbol(al.map, al.addr);
>  			if (al.sym)
>  				ret += symbol__fprintf_symname_offs(al.sym, &al, fp);
>  		}
> +		map__put(al.map);
>  	}
>  	ret += fprintf(fp, " old len %u new len %u\n", tp->old_len, tp->new_len);
>  	old = true;
> @@ -581,6 +582,7 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
>  	al->filtered = 0;
>  
>  	if (machine == NULL) {
> +		map__put(al->map);
>  		al->map = NULL;
>  		return NULL;
>  	}
> @@ -599,6 +601,7 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
>  		al->level = 'u';
>  	} else {
>  		al->level = 'H';
> +		map__put(al->map);
>  		al->map = NULL;
>  
>  		if ((cpumode == PERF_RECORD_MISC_GUEST_USER ||
> @@ -613,7 +616,7 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
>  		return NULL;
>  	}
>  
> -	al->map = maps__find(maps, al->addr);
> +	al->map = map__get(maps__find(maps, al->addr));
>  	if (al->map != NULL) {
>  		/*
>  		 * Kernel maps might be changed when loading symbols so loading
> @@ -768,6 +771,7 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
>   */
>  void addr_location__put(struct addr_location *al)
>  {
> +	map__zput(al->map);
>  	thread__zput(al->thread);
>  }
>  
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index f19ac6eb4775..4dbb1dbf3679 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -446,7 +446,7 @@ static int hist_entry__init(struct hist_entry *he,
>  			memset(&he->stat, 0, sizeof(he->stat));
>  	}
>  
> -	map__get(he->ms.map);
> +	he->ms.map = map__get(he->ms.map);
>  
>  	if (he->branch_info) {
>  		/*
> @@ -461,13 +461,13 @@ static int hist_entry__init(struct hist_entry *he,
>  		memcpy(he->branch_info, template->branch_info,
>  		       sizeof(*he->branch_info));
>  
> -		map__get(he->branch_info->from.ms.map);
> -		map__get(he->branch_info->to.ms.map);
> +		he->branch_info->from.ms.map = map__get(he->branch_info->from.ms.map);
> +		he->branch_info->to.ms.map = map__get(he->branch_info->to.ms.map);
>  	}
>  
>  	if (he->mem_info) {
> -		map__get(he->mem_info->iaddr.ms.map);
> -		map__get(he->mem_info->daddr.ms.map);
> +		he->mem_info->iaddr.ms.map = map__get(he->mem_info->iaddr.ms.map);
> +		he->mem_info->daddr.ms.map = map__get(he->mem_info->daddr.ms.map);
>  	}
>  
>  	if (hist_entry__has_callchains(he) && symbol_conf.use_callchain)
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 940fb2a50dfd..49e4891e92b7 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -783,33 +783,42 @@ static int machine__process_ksymbol_register(struct machine *machine,
>  {
>  	struct symbol *sym;
>  	struct map *map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
> +	bool put_map = false;
> +	int err = 0;
>  
>  	if (!map) {
>  		struct dso *dso = dso__new(event->ksymbol.name);
> -		int err;
>  
> -		if (dso) {
> -			dso->kernel = DSO_SPACE__KERNEL;
> -			map = map__new2(0, dso);
> -			dso__put(dso);
> +		if (!dso) {
> +			err = -ENOMEM;
> +			goto out;
>  		}
> -
> -		if (!dso || !map) {
> -			return -ENOMEM;
> +		dso->kernel = DSO_SPACE__KERNEL;
> +		map = map__new2(0, dso);
> +		dso__put(dso);
> +		if (!map) {
> +			err = -ENOMEM;
> +			goto out;
>  		}
> -
> +		/*
> +		 * The inserted map has a get on it, we need to put to release
> +		 * the reference count here, but do it after all accesses are
> +		 * done.
> +		 */
> +		put_map = true;
>  		if (event->ksymbol.ksym_type == PERF_RECORD_KSYMBOL_TYPE_OOL) {
> -			map->dso->binary_type = DSO_BINARY_TYPE__OOL;
> -			map->dso->data.file_size = event->ksymbol.len;
> -			dso__set_loaded(map->dso);
> +			map__dso(map)->binary_type = DSO_BINARY_TYPE__OOL;
> +			map__dso(map)->data.file_size = event->ksymbol.len;
> +			dso__set_loaded(map__dso(map));
>  		}
>  
>  		map->start = event->ksymbol.addr;
> -		map->end = map->start + event->ksymbol.len;
> +		map->end = map__start(map) + event->ksymbol.len;
>  		err = maps__insert(machine__kernel_maps(machine), map);
> -		map__put(map);
> -		if (err)
> -			return err;
> +		if (err) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
>  
>  		dso__set_loaded(dso);
>  
> @@ -819,13 +828,18 @@ static int machine__process_ksymbol_register(struct machine *machine,
>  		}
>  	}
>  
> -	sym = symbol__new(map->map_ip(map, map->start),
> +	sym = symbol__new(map__map_ip(map, map__start(map)),
>  			  event->ksymbol.len,
>  			  0, 0, event->ksymbol.name);
> -	if (!sym)
> -		return -ENOMEM;
> -	dso__insert_symbol(map->dso, sym);
> -	return 0;
> +	if (!sym) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +	dso__insert_symbol(map__dso(map), sym);
> +out:
> +	if (put_map)
> +		map__put(map);
> +	return err;
>  }
>  
>  static int machine__process_ksymbol_unregister(struct machine *machine,
> @@ -925,14 +939,11 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
>  		goto out;
>  
>  	err = maps__insert(machine__kernel_maps(machine), map);
> -
> -	/* Put the map here because maps__insert already got it */
> -	map__put(map);
> -
>  	/* If maps__insert failed, return NULL. */
> -	if (err)
> +	if (err) {
> +		map__put(map);
>  		map = NULL;
> -
> +	}
>  out:
>  	/* put the dso here, corresponding to  machine__findnew_module_dso */
>  	dso__put(dso);
> @@ -1228,6 +1239,7 @@ __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
>  	/* In case of renewal the kernel map, destroy previous one */
>  	machine__destroy_kernel_maps(machine);
>  
> +	map__put(machine->vmlinux_map);
>  	machine->vmlinux_map = map__new2(0, kernel);
>  	if (machine->vmlinux_map == NULL)
>  		return -ENOMEM;
> @@ -1513,6 +1525,7 @@ static int machine__create_module(void *arg, const char *name, u64 start,
>  	map->end = start + size;
>  
>  	dso__kernel_module_get_build_id(map__dso(map), machine->root_dir);
> +	map__put(map);
>  	return 0;
>  }
>  
> @@ -1558,16 +1571,18 @@ static void machine__set_kernel_mmap(struct machine *machine,
>  static int machine__update_kernel_mmap(struct machine *machine,
>  				     u64 start, u64 end)
>  {
> -	struct map *map = machine__kernel_map(machine);
> +	struct map *orig, *updated;
>  	int err;
>  
> -	map__get(map);
> -	maps__remove(machine__kernel_maps(machine), map);
> +	orig = machine->vmlinux_map;
> +	updated = map__get(orig);
>  
> +	machine->vmlinux_map = updated;
>  	machine__set_kernel_mmap(machine, start, end);
> +	maps__remove(machine__kernel_maps(machine), orig);
> +	err = maps__insert(machine__kernel_maps(machine), updated);
> +	map__put(orig);
>  
> -	err = maps__insert(machine__kernel_maps(machine), map);
> -	map__put(map);
>  	return err;
>  }
>  
> @@ -2246,6 +2261,7 @@ static int add_callchain_ip(struct thread *thread,
>  	err = callchain_cursor_append(cursor, ip, &ms,
>  				      branch, flags, nr_loop_iter,
>  				      iter_cycles, branch_from, srcline);
> +	map__put(al.map);
>  	return err;
>  }
>  
> -- 
> 2.35.1.265.g69c8d7142f-goog
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
