Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95E34B2BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352212AbiBKRfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:35:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbiBKRfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:35:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3E8391;
        Fri, 11 Feb 2022 09:35:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0553619E0;
        Fri, 11 Feb 2022 17:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6A4C340ED;
        Fri, 11 Feb 2022 17:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644600903;
        bh=lw1dBO7XoboWI/jtTxgCSFObpklgH6xxDUCWW8Z4fdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BWfoNYyTOyiHDeAYjgURUw7DJ/aRTnPDxxVUglxrJQAlmvSAozLIrNeWvLkpEq394
         1w/MBkrAaWgdaVzkRNogWF+rgj4sQBcfvsBXe6FuOUUz3QfWzBDIqmexDKGlnM0pdC
         BqnZxEUML+DuT+KWoZ3QiHv1FqN241AfeLFiO/RcB69cv515AoMRsdTLeN9kZiiESl
         Fxh0Rhi1QbvsKKQRSpIp4PW4CsuS0KXFxhOKBScw6mlOk/YNIFY/Sqz/bIz430kFIt
         VfpXAets+PgNYe2RltUwbeLCdffmJsPDo3ZD8YzoG6yXxz4ULwbuKukQ8a/2I7IaoA
         t7Nzw9PeHrLxw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CC017400FE; Fri, 11 Feb 2022 14:35:00 -0300 (-03)
Date:   Fri, 11 Feb 2022 14:35:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
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
        Masami Hiramatsu <mhiramat@kernel.org>,
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
Subject: Re: [PATCH v3 15/22] perf map: Use functions to access the variables
 in map
Message-ID: <YgaeRNfK4rjyt4vx@kernel.org>
References: <20220211103415.2737789-1-irogers@google.com>
 <20220211103415.2737789-16-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211103415.2737789-16-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 11, 2022 at 02:34:08AM -0800, Ian Rogers escreveu:
> The use of functions enables easier reference count
> checking. Some minor changes to map_ip and unmap_ip to making the
> naming a little clearer. __maps_insert is modified to return the
> inserted map, which simplifies the reference checking
> wrapping. maps__fixup_overlappings has some minor tweaks so that
> puts occur on error paths. dso__process_kernel_symbol has the
> unused curr_mapp argument removed.

This one should be at the forefront of this patchset to reduce the
possibility that it would clash with patches coming after it, lets see..

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/s390/annotate/instructions.c  |   4 +-
>  tools/perf/arch/x86/tests/dwarf-unwind.c      |   2 +-
>  tools/perf/arch/x86/util/event.c              |   6 +-
>  tools/perf/builtin-annotate.c                 |   8 +-
>  tools/perf/builtin-inject.c                   |   8 +-
>  tools/perf/builtin-kallsyms.c                 |   6 +-
>  tools/perf/builtin-kmem.c                     |   4 +-
>  tools/perf/builtin-mem.c                      |   4 +-
>  tools/perf/builtin-report.c                   |  20 +--
>  tools/perf/builtin-script.c                   |  26 ++--
>  tools/perf/builtin-top.c                      |  12 +-
>  tools/perf/builtin-trace.c                    |   2 +-
>  .../scripts/python/Perf-Trace-Util/Context.c  |   7 +-
>  tools/perf/tests/code-reading.c               |  32 ++---
>  tools/perf/tests/hists_common.c               |   4 +-
>  tools/perf/tests/vmlinux-kallsyms.c           |  35 +++---
>  tools/perf/ui/browsers/annotate.c             |   7 +-
>  tools/perf/ui/browsers/hists.c                |  18 +--
>  tools/perf/ui/browsers/map.c                  |   4 +-
>  tools/perf/util/annotate.c                    |  38 +++---
>  tools/perf/util/auxtrace.c                    |   2 +-
>  tools/perf/util/block-info.c                  |   4 +-
>  tools/perf/util/bpf-event.c                   |   8 +-
>  tools/perf/util/build-id.c                    |   2 +-
>  tools/perf/util/callchain.c                   |  10 +-
>  tools/perf/util/data-convert-json.c           |   4 +-
>  tools/perf/util/db-export.c                   |   4 +-
>  tools/perf/util/dlfilter.c                    |  21 ++--
>  tools/perf/util/dso.c                         |   4 +-
>  tools/perf/util/event.c                       |  14 +--
>  tools/perf/util/evsel_fprintf.c               |   4 +-
>  tools/perf/util/hist.c                        |  10 +-
>  tools/perf/util/intel-pt.c                    |  48 +++----
>  tools/perf/util/machine.c                     |  84 +++++++------
>  tools/perf/util/map.c                         | 117 +++++++++---------
>  tools/perf/util/map.h                         |  58 ++++++++-
>  tools/perf/util/maps.c                        |  83 +++++++------
>  tools/perf/util/probe-event.c                 |  44 +++----
>  .../util/scripting-engines/trace-event-perl.c |   9 +-
>  .../scripting-engines/trace-event-python.c    |  12 +-
>  tools/perf/util/sort.c                        |  46 +++----
>  tools/perf/util/symbol-elf.c                  |  39 +++---
>  tools/perf/util/symbol.c                      |  96 +++++++-------
>  tools/perf/util/symbol_fprintf.c              |   2 +-
>  tools/perf/util/synthetic-events.c            |  28 ++---
>  tools/perf/util/thread.c                      |  26 ++--
>  tools/perf/util/unwind-libunwind-local.c      |  34 ++---
>  tools/perf/util/unwind-libunwind.c            |   4 +-
>  tools/perf/util/vdso.c                        |   2 +-
>  49 files changed, 577 insertions(+), 489 deletions(-)
> 
> diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
> index 0e136630659e..740f1a63bc04 100644
> --- a/tools/perf/arch/s390/annotate/instructions.c
> +++ b/tools/perf/arch/s390/annotate/instructions.c
> @@ -39,7 +39,9 @@ static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
>  	target.addr = map__objdump_2mem(map, ops->target.addr);
>  
>  	if (maps__find_ams(ms->maps, &target) == 0 &&
> -	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) == ops->target.addr)
> +	    map__rip_2objdump(target.ms.map,
> +			      map->map_ip(target.ms.map, target.addr)
> +			     ) == ops->target.addr)
>  		ops->target.sym = target.ms.sym;
>  
>  	return 0;
> diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
> index a54dea7c112f..497593be80f2 100644
> --- a/tools/perf/arch/x86/tests/dwarf-unwind.c
> +++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
> @@ -33,7 +33,7 @@ static int sample_ustack(struct perf_sample *sample,
>  		return -1;
>  	}
>  
> -	stack_size = map->end - sp;
> +	stack_size = map__end(map) - sp;
>  	stack_size = stack_size > STACK_SIZE ? STACK_SIZE : stack_size;
>  
>  	memcpy(buf, (void *) sp, stack_size);
> diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
> index 7b6b0c98fb36..c790c682b76e 100644
> --- a/tools/perf/arch/x86/util/event.c
> +++ b/tools/perf/arch/x86/util/event.c
> @@ -57,9 +57,9 @@ int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
>  
>  		event->mmap.header.size = size;
>  
> -		event->mmap.start = map->start;
> -		event->mmap.len   = map->end - map->start;
> -		event->mmap.pgoff = map->pgoff;
> +		event->mmap.start = map__start(map);
> +		event->mmap.len   = map__size(map);
> +		event->mmap.pgoff = map__pgoff(map);
>  		event->mmap.pid   = machine->pid;
>  
>  		strlcpy(event->mmap.filename, kmap->name, PATH_MAX);
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 490bb9b8cf17..49d3ae36fd89 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -199,7 +199,7 @@ static int process_branch_callback(struct evsel *evsel,
>  		return 0;
>  
>  	if (a.map != NULL)
> -		a.map->dso->hit = 1;
> +		map__dso(a.map)->hit = 1;
>  
>  	hist__account_cycles(sample->branch_stack, al, sample, false, NULL);
>  
> @@ -231,9 +231,9 @@ static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
>  		 */
>  		if (al->sym != NULL) {
>  			rb_erase_cached(&al->sym->rb_node,
> -				 &al->map->dso->symbols);
> +					&map__dso(al->map)->symbols);
>  			symbol__delete(al->sym);
> -			dso__reset_find_symbol_cache(al->map->dso);
> +			dso__reset_find_symbol_cache(map__dso(al->map));
>  		}
>  		return 0;
>  	}
> @@ -315,7 +315,7 @@ static void hists__find_annotations(struct hists *hists,
>  		struct hist_entry *he = rb_entry(nd, struct hist_entry, rb_node);
>  		struct annotation *notes;
>  
> -		if (he->ms.sym == NULL || he->ms.map->dso->annotate_warned)
> +		if (he->ms.sym == NULL || map__dso(he->ms.map)->annotate_warned)
>  			goto find_next;
>  
>  		if (ann->sym_hist_filter &&
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index f7917c390e96..92a9dbc3d4cd 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -600,10 +600,10 @@ int perf_event__inject_buildid(struct perf_tool *tool, union perf_event *event,
>  	}
>  
>  	if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
> -		if (!al.map->dso->hit) {
> -			al.map->dso->hit = 1;
> -			dso__inject_build_id(al.map->dso, tool, machine,
> -					     sample->cpumode, al.map->flags);
> +		if (!map__dso(al.map)->hit) {
> +			map__dso(al.map)->hit = 1;
> +			dso__inject_build_id(map__dso(al.map), tool, machine,
> +					     sample->cpumode, map__flags(al.map));
>  		}
>  	}
>  
> diff --git a/tools/perf/builtin-kallsyms.c b/tools/perf/builtin-kallsyms.c
> index c08ee81529e8..d940b60ce812 100644
> --- a/tools/perf/builtin-kallsyms.c
> +++ b/tools/perf/builtin-kallsyms.c
> @@ -36,8 +36,10 @@ static int __cmd_kallsyms(int argc, const char **argv)
>  		}
>  
>  		printf("%s: %s %s %#" PRIx64 "-%#" PRIx64 " (%#" PRIx64 "-%#" PRIx64")\n",
> -			symbol->name, map->dso->short_name, map->dso->long_name,
> -			map->unmap_ip(map, symbol->start), map->unmap_ip(map, symbol->end),
> +			symbol->name, map__dso(map)->short_name,
> +			map__dso(map)->long_name,
> +			map__unmap_ip(map, symbol->start),
> +			map__unmap_ip(map, symbol->end),
>  			symbol->start, symbol->end);
>  	}
>  
> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index 99d7ff9a8eff..d87d9c341a20 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -410,7 +410,7 @@ static u64 find_callsite(struct evsel *evsel, struct perf_sample *sample)
>  		if (!caller) {
>  			/* found */
>  			if (node->ms.map)
> -				addr = map__unmap_ip(node->ms.map, node->ip);
> +				addr = map__dso_unmap_ip(node->ms.map, node->ip);
>  			else
>  				addr = node->ip;
>  
> @@ -1012,7 +1012,7 @@ static void __print_slab_result(struct rb_root *root,
>  
>  		if (sym != NULL)
>  			snprintf(buf, sizeof(buf), "%s+%" PRIx64 "", sym->name,
> -				 addr - map->unmap_ip(map, sym->start));
> +				 addr - map__unmap_ip(map, sym->start));
>  		else
>  			snprintf(buf, sizeof(buf), "%#" PRIx64 "", addr);
>  		printf(" %-34s |", buf);
> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
> index fcf65a59bea2..d18083f57303 100644
> --- a/tools/perf/builtin-mem.c
> +++ b/tools/perf/builtin-mem.c
> @@ -200,7 +200,7 @@ dump_raw_samples(struct perf_tool *tool,
>  		goto out_put;
>  
>  	if (al.map != NULL)
> -		al.map->dso->hit = 1;
> +		map__dso(al.map)->hit = 1;
>  
>  	field_sep = symbol_conf.field_sep;
>  	if (field_sep) {
> @@ -241,7 +241,7 @@ dump_raw_samples(struct perf_tool *tool,
>  		symbol_conf.field_sep,
>  		sample->data_src,
>  		symbol_conf.field_sep,
> -		al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
> +		al.map && map__dso(al.map) ? map__dso(al.map)->long_name : "???",
>  		al.sym ? al.sym->name : "???");
>  out_put:
>  	addr_location__put(&al);
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 57611ef725c3..9b92b2bbd7de 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -304,7 +304,7 @@ static int process_sample_event(struct perf_tool *tool,
>  	}
>  
>  	if (al.map != NULL)
> -		al.map->dso->hit = 1;
> +		map__dso(al.map)->hit = 1;
>  
>  	if (ui__has_annotation() || rep->symbol_ipc || rep->total_cycles_mode) {
>  		hist__account_cycles(sample->branch_stack, &al, sample,
> @@ -579,7 +579,7 @@ static void report__warn_kptr_restrict(const struct report *rep)
>  		return;
>  
>  	if (kernel_map == NULL ||
> -	    (kernel_map->dso->hit &&
> +	    (map__dso(kernel_map)->hit &&
>  	     (kernel_kmap->ref_reloc_sym == NULL ||
>  	      kernel_kmap->ref_reloc_sym->addr == 0))) {
>  		const char *desc =
> @@ -805,13 +805,15 @@ static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
>  		struct map *map = rb_node->map;
>  
>  		printed += fprintf(fp, "%*s  %" PRIx64 "-%" PRIx64 " %c%c%c%c %08" PRIx64 " %" PRIu64 " %s\n",
> -				   indent, "", map->start, map->end,
> -				   map->prot & PROT_READ ? 'r' : '-',
> -				   map->prot & PROT_WRITE ? 'w' : '-',
> -				   map->prot & PROT_EXEC ? 'x' : '-',
> -				   map->flags & MAP_SHARED ? 's' : 'p',
> -				   map->pgoff,
> -				   map->dso->id.ino, map->dso->name);
> +				   indent, "",
> +				   map__start(map), map__end(map),
> +				   map__prot(map) & PROT_READ ? 'r' : '-',
> +				   map__prot(map) & PROT_WRITE ? 'w' : '-',
> +				   map__prot(map) & PROT_EXEC ? 'x' : '-',
> +				   map__flags(map) & MAP_SHARED ? 's' : 'p',
> +				   map__pgoff(map),
> +				   map__dso(map)->id.ino,
> +				   map__dso(map)->name);
>  	}
>  
>  	return printed;
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index abae8184e171..4edfce95e137 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -972,12 +972,12 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
>  		to   = entries[i].to;
>  
>  		if (thread__find_map_fb(thread, sample->cpumode, from, &alf) &&
> -		    !alf.map->dso->adjust_symbols)
> -			from = map__map_ip(alf.map, from);
> +		    !map__dso(alf.map)->adjust_symbols)
> +			from = map__dso_map_ip(alf.map, from);
>  
>  		if (thread__find_map_fb(thread, sample->cpumode, to, &alt) &&
> -		    !alt.map->dso->adjust_symbols)
> -			to = map__map_ip(alt.map, to);
> +		    !map__dso(alt.map)->adjust_symbols)
> +			to = map__dso_map_ip(alt.map, to);
>  
>  		printed += fprintf(fp, " 0x%"PRIx64, from);
>  		if (PRINT_FIELD(DSO)) {
> @@ -1039,11 +1039,11 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
>  		return 0;
>  	}
>  
> -	if (!thread__find_map(thread, *cpumode, start, &al) || !al.map->dso) {
> +	if (!thread__find_map(thread, *cpumode, start, &al) || !map__dso(al.map)) {
>  		pr_debug("\tcannot resolve %" PRIx64 "-%" PRIx64 "\n", start, end);
>  		return 0;
>  	}
> -	if (al.map->dso->data.status == DSO_DATA_STATUS_ERROR) {
> +	if (map__dso(al.map)->data.status == DSO_DATA_STATUS_ERROR) {
>  		pr_debug("\tcannot resolve %" PRIx64 "-%" PRIx64 "\n", start, end);
>  		return 0;
>  	}
> @@ -1051,11 +1051,11 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
>  	/* Load maps to ensure dso->is_64_bit has been updated */
>  	map__load(al.map);
>  
> -	offset = al.map->map_ip(al.map, start);
> -	len = dso__data_read_offset(al.map->dso, machine, offset, (u8 *)buffer,
> -				    end - start + MAXINSN);
> +	offset = map__map_ip(al.map, start);
> +	len = dso__data_read_offset(map__dso(al.map), machine, offset,
> +				    (u8 *)buffer, end - start + MAXINSN);
>  
> -	*is64bit = al.map->dso->is_64_bit;
> +	*is64bit = map__dso(al.map)->is_64_bit;
>  	if (len <= 0)
>  		pr_debug("\tcannot fetch code for block at %" PRIx64 "-%" PRIx64 "\n",
>  			start, end);
> @@ -1070,9 +1070,9 @@ static int map__fprintf_srccode(struct map *map, u64 addr, FILE *fp, struct srcc
>  	int len;
>  	char *srccode;
>  
> -	if (!map || !map->dso)
> +	if (!map || !map__dso(map))
>  		return 0;
> -	srcfile = get_srcline_split(map->dso,
> +	srcfile = get_srcline_split(map__dso(map),
>  				    map__rip_2objdump(map, addr),
>  				    &line);
>  	if (!srcfile)
> @@ -1164,7 +1164,7 @@ static int ip__fprintf_sym(uint64_t addr, struct thread *thread,
>  	if (al.addr < al.sym->end)
>  		off = al.addr - al.sym->start;
>  	else
> -		off = al.addr - al.map->start - al.sym->start;
> +		off = al.addr - map__start(al.map) - al.sym->start;
>  	printed += fprintf(fp, "\t%s", al.sym->name);
>  	if (off)
>  		printed += fprintf(fp, "%+d", off);
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 1fc390f136dd..8db1df7bdabe 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -127,8 +127,8 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
>  	/*
>  	 * We can't annotate with just /proc/kallsyms
>  	 */
> -	if (map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
> -	    !dso__is_kcore(map->dso)) {
> +	if (map__dso(map)->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
> +	    !dso__is_kcore(map__dso(map))) {
>  		pr_err("Can't annotate %s: No vmlinux file was found in the "
>  		       "path\n", sym->name);
>  		sleep(1);
> @@ -180,8 +180,9 @@ static void ui__warn_map_erange(struct map *map, struct symbol *sym, u64 ip)
>  		    "Tools:  %s\n\n"
>  		    "Not all samples will be on the annotation output.\n\n"
>  		    "Please report to linux-kernel@vger.kernel.org\n",
> -		    ip, map->dso->long_name, dso__symtab_origin(map->dso),
> -		    map->start, map->end, sym->start, sym->end,
> +		    ip, map__dso(map)->long_name,
> +		    dso__symtab_origin(map__dso(map)),
> +		    map__start(map), map__end(map), sym->start, sym->end,
>  		    sym->binding == STB_GLOBAL ? 'g' :
>  		    sym->binding == STB_LOCAL  ? 'l' : 'w', sym->name,
>  		    err ? "[unknown]" : uts.machine,
> @@ -810,7 +811,8 @@ static void perf_event__process_sample(struct perf_tool *tool,
>  		    __map__is_kernel(al.map) && map__has_symbols(al.map)) {
>  			if (symbol_conf.vmlinux_name) {
>  				char serr[256];
> -				dso__strerror_load(al.map->dso, serr, sizeof(serr));
> +				dso__strerror_load(map__dso(al.map),
> +						   serr, sizeof(serr));
>  				ui__warning("The %s file can't be used: %s\n%s",
>  					    symbol_conf.vmlinux_name, serr, msg);
>  			} else {
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 32844d8a0ea5..0134f24da3e3 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2862,7 +2862,7 @@ static void print_location(FILE *f, struct perf_sample *sample,
>  {
>  
>  	if ((verbose > 0 || print_dso) && al->map)
> -		fprintf(f, "%s@", al->map->dso->long_name);
> +		fprintf(f, "%s@", map__dso(al->map)->long_name);
>  
>  	if ((verbose > 0 || print_sym) && al->sym)
>  		fprintf(f, "%s+0x%" PRIx64, al->sym->name,
> diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> index b64013a87c54..b83b62d33945 100644
> --- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> +++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
> @@ -152,9 +152,10 @@ static PyObject *perf_sample_src(PyObject *obj, PyObject *args, bool get_srccode
>  	map = c->al->map;
>  	addr = c->al->addr;
>  
> -	if (map && map->dso)
> -		srcfile = get_srcline_split(map->dso, map__rip_2objdump(map, addr), &line);
> -
> +	if (map && map__dso(map)) {
> +		srcfile = get_srcline_split(map__dso(map),
> +					    map__rip_2objdump(map, addr), &line);
> +	}
>  	if (get_srccode) {
>  		if (srcfile)
>  			srccode = find_sourceline(srcfile, line, &len);
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
> index 6eafe36a8704..9cb7d3f577d7 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -240,7 +240,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
>  
>  	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
>  
> -	if (!thread__find_map(thread, cpumode, addr, &al) || !al.map->dso) {
> +	if (!thread__find_map(thread, cpumode, addr, &al) || !map__dso(al.map)) {
>  		if (cpumode == PERF_RECORD_MISC_HYPERVISOR) {
>  			pr_debug("Hypervisor address can not be resolved - skipping\n");
>  			return 0;
> @@ -250,10 +250,10 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
>  		return -1;
>  	}
>  
> -	pr_debug("File is: %s\n", al.map->dso->long_name);
> +	pr_debug("File is: %s\n", map__dso(al.map)->long_name);
>  
> -	if (al.map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
> -	    !dso__is_kcore(al.map->dso)) {
> +	if (map__dso(al.map)->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
> +	    !dso__is_kcore(map__dso(al.map))) {
>  		pr_debug("Unexpected kernel address - skipping\n");
>  		return 0;
>  	}
> @@ -264,11 +264,11 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
>  		len = BUFSZ;
>  
>  	/* Do not go off the map */
> -	if (addr + len > al.map->end)
> -		len = al.map->end - addr;
> +	if (addr + len > map__end(al.map))
> +		len = map__end(al.map) - addr;
>  
>  	/* Read the object code using perf */
> -	ret_len = dso__data_read_offset(al.map->dso, maps__machine(thread->maps),
> +	ret_len = dso__data_read_offset(map__dso(al.map), maps__machine(thread->maps),
>  					al.addr, buf1, len);
>  	if (ret_len != len) {
>  		pr_debug("dso__data_read_offset failed\n");
> @@ -283,11 +283,11 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
>  		return -1;
>  
>  	/* objdump struggles with kcore - try each map only once */
> -	if (dso__is_kcore(al.map->dso)) {
> +	if (dso__is_kcore(map__dso(al.map))) {
>  		size_t d;
>  
>  		for (d = 0; d < state->done_cnt; d++) {
> -			if (state->done[d] == al.map->start) {
> +			if (state->done[d] == map__start(al.map)) {
>  				pr_debug("kcore map tested already");
>  				pr_debug(" - skipping\n");
>  				return 0;
> @@ -297,12 +297,12 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
>  			pr_debug("Too many kcore maps - skipping\n");
>  			return 0;
>  		}
> -		state->done[state->done_cnt++] = al.map->start;
> +		state->done[state->done_cnt++] = map__start(al.map);
>  	}
>  
> -	objdump_name = al.map->dso->long_name;
> -	if (dso__needs_decompress(al.map->dso)) {
> -		if (dso__decompress_kmodule_path(al.map->dso, objdump_name,
> +	objdump_name = map__dso(al.map)->long_name;
> +	if (dso__needs_decompress(map__dso(al.map))) {
> +		if (dso__decompress_kmodule_path(map__dso(al.map), objdump_name,
>  						 decomp_name,
>  						 sizeof(decomp_name)) < 0) {
>  			pr_debug("decompression failed\n");
> @@ -330,7 +330,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
>  			len -= ret;
>  			if (len) {
>  				pr_debug("Reducing len to %zu\n", len);
> -			} else if (dso__is_kcore(al.map->dso)) {
> +			} else if (dso__is_kcore(map__dso(al.map))) {
>  				/*
>  				 * objdump cannot handle very large segments
>  				 * that may be found in kcore.
> @@ -588,8 +588,8 @@ static int do_test_code_reading(bool try_kcore)
>  		pr_debug("map__load failed\n");
>  		goto out_err;
>  	}
> -	have_vmlinux = dso__is_vmlinux(map->dso);
> -	have_kcore = dso__is_kcore(map->dso);
> +	have_vmlinux = dso__is_vmlinux(map__dso(map));
> +	have_kcore = dso__is_kcore(map__dso(map));
>  
>  	/* 2nd time through we just try kcore */
>  	if (try_kcore && !have_kcore)
> diff --git a/tools/perf/tests/hists_common.c b/tools/perf/tests/hists_common.c
> index 6f34d08b84e5..40eccc659767 100644
> --- a/tools/perf/tests/hists_common.c
> +++ b/tools/perf/tests/hists_common.c
> @@ -181,7 +181,7 @@ void print_hists_in(struct hists *hists)
>  		if (!he->filtered) {
>  			pr_info("%2d: entry: %-8s [%-8s] %20s: period = %"PRIu64"\n",
>  				i, thread__comm_str(he->thread),
> -				he->ms.map->dso->short_name,
> +				map__dso(he->ms.map)->short_name,
>  				he->ms.sym->name, he->stat.period);
>  		}
>  
> @@ -208,7 +208,7 @@ void print_hists_out(struct hists *hists)
>  		if (!he->filtered) {
>  			pr_info("%2d: entry: %8s:%5d [%-8s] %20s: period = %"PRIu64"/%"PRIu64"\n",
>  				i, thread__comm_str(he->thread), he->thread->tid,
> -				he->ms.map->dso->short_name,
> +				map__dso(he->ms.map)->short_name,
>  				he->ms.sym->name, he->stat.period,
>  				he->stat_acc ? he->stat_acc->period : 0);
>  		}
> diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
> index 11a230ee5894..5afab21455f1 100644
> --- a/tools/perf/tests/vmlinux-kallsyms.c
> +++ b/tools/perf/tests/vmlinux-kallsyms.c
> @@ -13,7 +13,7 @@
>  #include "debug.h"
>  #include "machine.h"
>  
> -#define UM(x) kallsyms_map->unmap_ip(kallsyms_map, (x))
> +#define UM(x) map__unmap_ip(kallsyms_map, (x))
>  
>  static bool is_ignored_symbol(const char *name, char type)
>  {
> @@ -216,8 +216,8 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
>  		if (sym->start == sym->end)
>  			continue;
>  
> -		mem_start = vmlinux_map->unmap_ip(vmlinux_map, sym->start);
> -		mem_end = vmlinux_map->unmap_ip(vmlinux_map, sym->end);
> +		mem_start = map__unmap_ip(vmlinux_map, sym->start);
> +		mem_end = map__unmap_ip(vmlinux_map, sym->end);
>  
>  		first_pair = machine__find_kernel_symbol(&kallsyms, mem_start, NULL);
>  		pair = first_pair;
> @@ -262,7 +262,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
>  
>  				continue;
>  			}
> -		} else if (mem_start == kallsyms.vmlinux_map->end) {
> +		} else if (mem_start == map__end(kallsyms.vmlinux_map)) {
>  			/*
>  			 * Ignore aliases to _etext, i.e. to the end of the kernel text area,
>  			 * such as __indirect_thunk_end.
> @@ -294,9 +294,10 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
>  		 * so use the short name, less descriptive but the same ("[kernel]" in
>  		 * both cases.
>  		 */
> -		struct map *pair = maps__find_by_name(kallsyms.kmaps, (map->dso->kernel ?
> -								map->dso->short_name :
> -								map->dso->name));
> +		struct map *pair = maps__find_by_name(kallsyms.kmaps,
> +						map__dso(map)->kernel
> +						? map__dso(map)->short_name
> +						: map__dso(map)->name);
>  		if (pair) {
>  			pair->priv = 1;
>  		} else {
> @@ -313,25 +314,27 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
>  	maps__for_each_entry(maps, rb_node) {
>  		struct map *pair, *map = rb_node->map;
>  
> -		mem_start = vmlinux_map->unmap_ip(vmlinux_map, map->start);
> -		mem_end = vmlinux_map->unmap_ip(vmlinux_map, map->end);
> +		mem_start = map__unmap_ip(vmlinux_map, map__start(map));
> +		mem_end = map__unmap_ip(vmlinux_map, map__end(map));
>  
>  		pair = maps__find(kallsyms.kmaps, mem_start);
> -		if (pair == NULL || pair->priv)
> +		if (pair == NULL || map__priv(pair))
>  			continue;
>  
> -		if (pair->start == mem_start) {
> +		if (map__start(pair) == mem_start) {
>  			if (!header_printed) {
>  				pr_info("WARN: Maps in vmlinux with a different name in kallsyms:\n");
>  				header_printed = true;
>  			}
>  
>  			pr_info("WARN: %" PRIx64 "-%" PRIx64 " %" PRIx64 " %s in kallsyms as",
> -				map->start, map->end, map->pgoff, map->dso->name);
> -			if (mem_end != pair->end)
> +				map__start(map), map__end(map),
> +				map__pgoff(map), map__dso(map)->name);
> +			if (mem_end != map__end(pair))
>  				pr_info(":\nWARN: *%" PRIx64 "-%" PRIx64 " %" PRIx64,
> -					pair->start, pair->end, pair->pgoff);
> -			pr_info(" %s\n", pair->dso->name);
> +					map__start(pair), map__end(pair),
> +					map__pgoff(pair));
> +			pr_info(" %s\n", map__dso(pair)->name);
>  			pair->priv = 1;
>  		}
>  	}
> @@ -343,7 +346,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
>  	maps__for_each_entry(maps, rb_node) {
>  		struct map *map = rb_node->map;
>  
> -		if (!map->priv) {
> +		if (!map__priv(map)) {
>  			if (!header_printed) {
>  				pr_info("WARN: Maps only in kallsyms:\n");
>  				header_printed = true;
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index 44ba900828f6..7d51d92302dc 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -446,7 +446,8 @@ static void ui_browser__init_asm_mode(struct ui_browser *browser)
>  static int sym_title(struct symbol *sym, struct map *map, char *title,
>  		     size_t sz, int percent_type)
>  {
> -	return snprintf(title, sz, "%s  %s [Percent: %s]", sym->name, map->dso->long_name,
> +	return snprintf(title, sz, "%s  %s [Percent: %s]", sym->name,
> +			map__dso(map)->long_name,
>  			percent_type_str(percent_type));
>  }
>  
> @@ -971,14 +972,14 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
>  	if (sym == NULL)
>  		return -1;
>  
> -	if (ms->map->dso->annotate_warned)
> +	if (map__dso(ms->map)->annotate_warned)
>  		return -1;
>  
>  	if (not_annotated) {
>  		err = symbol__annotate2(ms, evsel, opts, &browser.arch);
>  		if (err) {
>  			char msg[BUFSIZ];
> -			ms->map->dso->annotate_warned = true;
> +			map__dso(ms->map)->annotate_warned = true;
>  			symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
>  			ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
>  			goto out_free_offsets;
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index 572ff38ceb0f..2241447e9bfb 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2487,7 +2487,7 @@ static struct symbol *symbol__new_unresolved(u64 addr, struct map *map)
>  			return NULL;
>  		}
>  
> -		dso__insert_symbol(map->dso, sym);
> +		dso__insert_symbol(map__dso(map), sym);
>  	}
>  
>  	return sym;
> @@ -2499,7 +2499,7 @@ add_annotate_opt(struct hist_browser *browser __maybe_unused,
>  		 struct map_symbol *ms,
>  		 u64 addr)
>  {
> -	if (!ms->map || !ms->map->dso || ms->map->dso->annotate_warned)
> +	if (!ms->map || !map__dso(ms->map) || map__dso(ms->map)->annotate_warned)
>  		return 0;
>  
>  	if (!ms->sym)
> @@ -2590,8 +2590,10 @@ static int hists_browser__zoom_map(struct hist_browser *browser, struct map *map
>  		ui_helpline__pop();
>  	} else {
>  		ui_helpline__fpush("To zoom out press ESC or ENTER + \"Zoom out of %s DSO\"",
> -				   __map__is_kernel(map) ? "the Kernel" : map->dso->short_name);
> -		browser->hists->dso_filter = map->dso;
> +				   __map__is_kernel(map)
> +				   ? "the Kernel"
> +				   : map__dso(map)->short_name);
> +		browser->hists->dso_filter = map__dso(map);
>  		perf_hpp__set_elide(HISTC_DSO, true);
>  		pstack__push(browser->pstack, &browser->hists->dso_filter);
>  	}
> @@ -2616,7 +2618,9 @@ add_dso_opt(struct hist_browser *browser, struct popup_action *act,
>  
>  	if (asprintf(optstr, "Zoom %s %s DSO (use the 'k' hotkey to zoom directly into the kernel)",
>  		     browser->hists->dso_filter ? "out of" : "into",
> -		     __map__is_kernel(map) ? "the Kernel" : map->dso->short_name) < 0)
> +		     __map__is_kernel(map)
> +		     ? "the Kernel"
> +		     : map__dso(map)->short_name) < 0)
>  		return 0;
>  
>  	act->ms.map = map;
> @@ -3091,8 +3095,8 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
>  
>  			if (!browser->selection ||
>  			    !browser->selection->map ||
> -			    !browser->selection->map->dso ||
> -			    browser->selection->map->dso->annotate_warned) {
> +			    !map__dso(browser->selection->map) ||
> +			    map__dso(browser->selection->map)->annotate_warned) {
>  				continue;
>  			}
>  
> diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
> index 3d49b916c9e4..3d1b958d8832 100644
> --- a/tools/perf/ui/browsers/map.c
> +++ b/tools/perf/ui/browsers/map.c
> @@ -76,7 +76,7 @@ static int map_browser__run(struct map_browser *browser)
>  {
>  	int key;
>  
> -	if (ui_browser__show(&browser->b, browser->map->dso->long_name,
> +	if (ui_browser__show(&browser->b, map__dso(browser->map)->long_name,
>  			     "Press ESC to exit, %s / to search",
>  			     verbose > 0 ? "" : "restart with -v to use") < 0)
>  		return -1;
> @@ -106,7 +106,7 @@ int map__browse(struct map *map)
>  {
>  	struct map_browser mb = {
>  		.b = {
> -			.entries = &map->dso->symbols,
> +			.entries = &map__dso(map)->symbols,
>  			.refresh = ui_browser__rb_tree_refresh,
>  			.seek	 = ui_browser__rb_tree_seek,
>  			.write	 = map_browser__write,
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 01900689dc00..3a7433d3e48a 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -280,7 +280,9 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
>  	target.addr = map__objdump_2mem(map, ops->target.addr);
>  
>  	if (maps__find_ams(ms->maps, &target) == 0 &&
> -	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) == ops->target.addr)
> +	    map__rip_2objdump(target.ms.map,
> +			      map->map_ip(target.ms.map, target.addr)
> +			      ) == ops->target.addr)
>  		ops->target.sym = target.ms.sym;
>  
>  	return 0;
> @@ -384,8 +386,8 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
>  	}
>  
>  	target.addr = map__objdump_2mem(map, ops->target.addr);
> -	start = map->unmap_ip(map, sym->start),
> -	end = map->unmap_ip(map, sym->end);
> +	start = map__unmap_ip(map, sym->start),
> +	end = map__unmap_ip(map, sym->end);
>  
>  	ops->target.outside = target.addr < start || target.addr > end;
>  
> @@ -408,7 +410,9 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
>  	 * the symbol searching and disassembly should be done.
>  	 */
>  	if (maps__find_ams(ms->maps, &target) == 0 &&
> -	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) == ops->target.addr)
> +	    map__rip_2objdump(target.ms.map,
> +			      map->map_ip(target.ms.map, target.addr)
> +			      ) == ops->target.addr)
>  		ops->target.sym = target.ms.sym;
>  
>  	if (!ops->target.outside) {
> @@ -889,7 +893,7 @@ static int __symbol__inc_addr_samples(struct map_symbol *ms,
>  	unsigned offset;
>  	struct sym_hist *h;
>  
> -	pr_debug3("%s: addr=%#" PRIx64 "\n", __func__, ms->map->unmap_ip(ms->map, addr));
> +	pr_debug3("%s: addr=%#" PRIx64 "\n", __func__, map__unmap_ip(ms->map, addr));
>  
>  	if ((addr < sym->start || addr >= sym->end) &&
>  	    (addr != sym->end || sym->start != sym->end)) {
> @@ -1016,13 +1020,13 @@ int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
>  	if (start &&
>  		(start->ms.sym == ams->ms.sym ||
>  		 (ams->ms.sym &&
> -		   start->addr == ams->ms.sym->start + ams->ms.map->start)))
> +		  start->addr == ams->ms.sym->start + map__start(ams->ms.map))))
>  		saddr = start->al_addr;
>  	if (saddr == 0)
>  		pr_debug2("BB with bad start: addr %"PRIx64" start %"PRIx64" sym %"PRIx64" saddr %"PRIx64"\n",
>  			ams->addr,
>  			start ? start->addr : 0,
> -			ams->ms.sym ? ams->ms.sym->start + ams->ms.map->start : 0,
> +			ams->ms.sym ? ams->ms.sym->start + map__start(ams->ms.map) : 0,
>  			saddr);
>  	err = symbol__account_cycles(ams->al_addr, saddr, ams->ms.sym, cycles);
>  	if (err)
> @@ -1593,7 +1597,7 @@ static void delete_last_nop(struct symbol *sym)
>  
>  int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, size_t buflen)
>  {
> -	struct dso *dso = ms->map->dso;
> +	struct dso *dso = map__dso(ms->map);
>  
>  	BUG_ON(buflen == 0);
>  
> @@ -1723,7 +1727,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
>  	struct map *map = args->ms.map;
>  	struct perf_bpil *info_linear;
>  	struct disassemble_info info;
> -	struct dso *dso = map->dso;
> +	struct dso *dso = map__dso(map);
>  	int pc = 0, count, sub_id;
>  	struct btf *btf = NULL;
>  	char tpath[PATH_MAX];
> @@ -1946,7 +1950,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  {
>  	struct annotation_options *opts = args->options;
>  	struct map *map = args->ms.map;
> -	struct dso *dso = map->dso;
> +	struct dso *dso = map__dso(map);
>  	char *command;
>  	FILE *file;
>  	char symfs_filename[PATH_MAX];
> @@ -1973,8 +1977,8 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  		return err;
>  
>  	pr_debug("%s: filename=%s, sym=%s, start=%#" PRIx64 ", end=%#" PRIx64 "\n", __func__,
> -		 symfs_filename, sym->name, map->unmap_ip(map, sym->start),
> -		 map->unmap_ip(map, sym->end));
> +		 symfs_filename, sym->name, map__unmap_ip(map, sym->start),
> +		 map__unmap_ip(map, sym->end));
>  
>  	pr_debug("annotating [%p] %30s : [%p] %30s\n",
>  		 dso, dso->long_name, sym, sym->name);
> @@ -2386,7 +2390,7 @@ int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel,
>  {
>  	struct map *map = ms->map;
>  	struct symbol *sym = ms->sym;
> -	struct dso *dso = map->dso;
> +	struct dso *dso = map__dso(map);
>  	char *filename;
>  	const char *d_filename;
>  	const char *evsel_name = evsel__name(evsel);
> @@ -2569,7 +2573,7 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
>  	}
>  
>  	fprintf(fp, "%s() %s\nEvent: %s\n\n",
> -		ms->sym->name, ms->map->dso->long_name, ev_name);
> +		ms->sym->name, map__dso(ms->map)->long_name, ev_name);
>  	symbol__annotate_fprintf2(ms->sym, fp, opts);
>  
>  	fclose(fp);
> @@ -2781,7 +2785,7 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
>  		if (percent_max <= 0.5)
>  			continue;
>  
> -		al->path = get_srcline(map->dso, notes->start + al->offset, NULL,
> +		al->path = get_srcline(map__dso(map), notes->start + al->offset, NULL,
>  				       false, true, notes->start + al->offset);
>  		insert_source_line(&tmp_root, al, opts);
>  	}
> @@ -2800,7 +2804,7 @@ static void symbol__calc_lines(struct map_symbol *ms, struct rb_root *root,
>  int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel,
>  			  struct annotation_options *opts)
>  {
> -	struct dso *dso = ms->map->dso;
> +	struct dso *dso = map__dso(ms->map);
>  	struct symbol *sym = ms->sym;
>  	struct rb_root source_line = RB_ROOT;
>  	struct hists *hists = evsel__hists(evsel);
> @@ -2836,7 +2840,7 @@ int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel,
>  int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel,
>  			 struct annotation_options *opts)
>  {
> -	struct dso *dso = ms->map->dso;
> +	struct dso *dso = map__dso(ms->map);
>  	struct symbol *sym = ms->sym;
>  	struct rb_root source_line = RB_ROOT;
>  	int err;
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 825336304a37..2e864c9bdef3 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -2478,7 +2478,7 @@ static struct dso *load_dso(const char *name)
>  	if (map__load(map) < 0)
>  		pr_err("File '%s' not found or has no symbols.\n", name);
>  
> -	dso = dso__get(map->dso);
> +	dso = dso__get(map__dso(map));
>  
>  	map__put(map);
>  
> diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
> index 5ecd4f401f32..16a7b4adcf18 100644
> --- a/tools/perf/util/block-info.c
> +++ b/tools/perf/util/block-info.c
> @@ -317,9 +317,9 @@ static int block_dso_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>  	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
>  	struct map *map = he->ms.map;
>  
> -	if (map && map->dso) {
> +	if (map && map__dso(map)) {
>  		return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
> -				 map->dso->short_name);
> +				 map__dso(map)->short_name);
>  	}
>  
>  	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 33257b594a71..5717933be116 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -95,10 +95,10 @@ static int machine__process_bpf_event_load(struct machine *machine,
>  		struct map *map = maps__find(machine__kernel_maps(machine), addr);
>  
>  		if (map) {
> -			map->dso->binary_type = DSO_BINARY_TYPE__BPF_PROG_INFO;
> -			map->dso->bpf_prog.id = id;
> -			map->dso->bpf_prog.sub_id = i;
> -			map->dso->bpf_prog.env = env;
> +			map__dso(map)->binary_type = DSO_BINARY_TYPE__BPF_PROG_INFO;
> +			map__dso(map)->bpf_prog.id = id;
> +			map__dso(map)->bpf_prog.sub_id = i;
> +			map__dso(map)->bpf_prog.env = env;
>  		}
>  	}
>  	return 0;
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 7a5821c87f94..274b705dd941 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -59,7 +59,7 @@ int build_id__mark_dso_hit(struct perf_tool *tool __maybe_unused,
>  	}
>  
>  	if (thread__find_map(thread, sample->cpumode, sample->ip, &al))
> -		al.map->dso->hit = 1;
> +		map__dso(al.map)->hit = 1;
>  
>  	thread__put(thread);
>  	return 0;
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 61bb3fb2107a..a8cfd31a3ff0 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -695,8 +695,8 @@ static enum match_result match_chain_strings(const char *left,
>  static enum match_result match_chain_dso_addresses(struct map *left_map, u64 left_ip,
>  						   struct map *right_map, u64 right_ip)
>  {
> -	struct dso *left_dso = left_map ? left_map->dso : NULL;
> -	struct dso *right_dso = right_map ? right_map->dso : NULL;
> +	struct dso *left_dso = left_map ? map__dso(left_map) : NULL;
> +	struct dso *right_dso = right_map ? map__dso(right_map) : NULL;
>  
>  	if (left_dso != right_dso)
>  		return left_dso < right_dso ? MATCH_LT : MATCH_GT;
> @@ -1167,9 +1167,9 @@ char *callchain_list__sym_name(struct callchain_list *cl,
>  
>  	if (show_dso)
>  		scnprintf(bf + printed, bfsize - printed, " %s",
> -			  cl->ms.map ?
> -			  cl->ms.map->dso->short_name :
> -			  "unknown");
> +			  cl->ms.map
> +			  ? map__dso(cl->ms.map)->short_name
> +			  : "unknown");
>  
>  	return bf;
>  }
> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
> index f1ab6edba446..9c83228bb9f1 100644
> --- a/tools/perf/util/data-convert-json.c
> +++ b/tools/perf/util/data-convert-json.c
> @@ -127,8 +127,8 @@ static void output_sample_callchain_entry(struct perf_tool *tool,
>  		fputc(',', out);
>  		output_json_key_string(out, false, 5, "symbol", al->sym->name);
>  
> -		if (al->map && al->map->dso) {
> -			const char *dso = al->map->dso->short_name;
> +		if (al->map && map__dso(al->map)) {
> +			const char *dso = map__dso(al->map)->short_name;
>  
>  			if (dso && strlen(dso) > 0) {
>  				fputc(',', out);
> diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
> index 1cfcfdd3cf52..84c970c11794 100644
> --- a/tools/perf/util/db-export.c
> +++ b/tools/perf/util/db-export.c
> @@ -179,7 +179,7 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
>  	int err;
>  
>  	if (al->map) {
> -		struct dso *dso = al->map->dso;
> +		struct dso *dso = map__dso(al->map);
>  
>  		err = db_export__dso(dbe, dso, maps__machine(al->maps));
>  		if (err)
> @@ -255,7 +255,7 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
>  		al.addr = node->ip;
>  
>  		if (al.map && !al.sym)
> -			al.sym = dso__find_symbol(al.map->dso, al.addr);
> +			al.sym = dso__find_symbol(map__dso(al.map), al.addr);
>  
>  		db_ids_from_al(dbe, &al, &dso_db_id, &sym_db_id, &offset);
>  
> diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
> index d59462af15f1..f1d9dd7065e6 100644
> --- a/tools/perf/util/dlfilter.c
> +++ b/tools/perf/util/dlfilter.c
> @@ -29,7 +29,7 @@ static void al_to_d_al(struct addr_location *al, struct perf_dlfilter_al *d_al)
>  
>  	d_al->size = sizeof(*d_al);
>  	if (al->map) {
> -		struct dso *dso = al->map->dso;
> +		struct dso *dso = map__dso(al->map);
>  
>  		if (symbol_conf.show_kernel_path && dso->long_name)
>  			d_al->dso = dso->long_name;
> @@ -51,7 +51,7 @@ static void al_to_d_al(struct addr_location *al, struct perf_dlfilter_al *d_al)
>  		if (al->addr < sym->end)
>  			d_al->symoff = al->addr - sym->start;
>  		else
> -			d_al->symoff = al->addr - al->map->start - sym->start;
> +			d_al->symoff = al->addr - map__start(al->map) - sym->start;
>  		d_al->sym_binding = sym->binding;
>  	} else {
>  		d_al->sym = NULL;
> @@ -232,9 +232,10 @@ static const char *dlfilter__srcline(void *ctx, __u32 *line_no)
>  	map = al->map;
>  	addr = al->addr;
>  
> -	if (map && map->dso)
> -		srcfile = get_srcline_split(map->dso, map__rip_2objdump(map, addr), &line);
> -
> +	if (map && map__dso(map)) {
> +		srcfile = get_srcline_split(map__dso(map),
> +					    map__rip_2objdump(map, addr), &line);
> +	}
>  	*line_no = line;
>  	return srcfile;
>  }
> @@ -266,7 +267,7 @@ static __s32 dlfilter__object_code(void *ctx, __u64 ip, void *buf, __u32 len)
>  
>  	map = al->map;
>  
> -	if (map && ip >= map->start && ip < map->end &&
> +	if (map && ip >= map__start(map) && ip < map__end(map) &&
>  	    machine__kernel_ip(d->machine, ip) == machine__kernel_ip(d->machine, d->sample->ip))
>  		goto have_map;
>  
> @@ -276,10 +277,10 @@ static __s32 dlfilter__object_code(void *ctx, __u64 ip, void *buf, __u32 len)
>  
>  	map = a.map;
>  have_map:
> -	offset = map->map_ip(map, ip);
> -	if (ip + len >= map->end)
> -		len = map->end - ip;
> -	return dso__data_read_offset(map->dso, d->machine, offset, buf, len);
> +	offset = map__map_ip(map, ip);
> +	if (ip + len >= map__end(map))
> +		len = map__end(map) - ip;
> +	return dso__data_read_offset(map__dso(map), d->machine, offset, buf, len);
>  }
>  
>  static const struct perf_dlfilter_fns perf_dlfilter_fns = {
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index b2f570adba35..1115bc51a261 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1109,7 +1109,7 @@ ssize_t dso__data_read_addr(struct dso *dso, struct map *map,
>  			    struct machine *machine, u64 addr,
>  			    u8 *data, ssize_t size)
>  {
> -	u64 offset = map->map_ip(map, addr);
> +	u64 offset = map__map_ip(map, addr);
>  	return dso__data_read_offset(dso, machine, offset, data, size);
>  }
>  
> @@ -1149,7 +1149,7 @@ ssize_t dso__data_write_cache_addr(struct dso *dso, struct map *map,
>  				   struct machine *machine, u64 addr,
>  				   const u8 *data, ssize_t size)
>  {
> -	u64 offset = map->map_ip(map, addr);
> +	u64 offset = map__map_ip(map, addr);
>  	return dso__data_write_cache_offs(dso, machine, offset, data, size);
>  }
>  
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 40a3b1a35613..54a1d4df5f70 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -486,7 +486,7 @@ size_t perf_event__fprintf_text_poke(union perf_event *event, struct machine *ma
>  
>  		al.map = maps__find(machine__kernel_maps(machine), tp->addr);
>  		if (al.map && map__load(al.map) >= 0) {
> -			al.addr = al.map->map_ip(al.map, tp->addr);
> +			al.addr = map__map_ip(al.map, tp->addr);
>  			al.sym = map__find_symbol(al.map, al.addr);
>  			if (al.sym)
>  				ret += symbol__fprintf_symname_offs(al.sym, &al, fp);
> @@ -621,7 +621,7 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
>  		 */
>  		if (load_map)
>  			map__load(al->map);
> -		al->addr = al->map->map_ip(al->map, al->addr);
> +		al->addr = map__map_ip(al->map, al->addr);
>  	}
>  
>  	return al->map;
> @@ -692,8 +692,8 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
>  	dump_printf(" ... thread: %s:%d\n", thread__comm_str(thread), thread->tid);
>  	thread__find_map(thread, sample->cpumode, sample->ip, al);
>  	dump_printf(" ...... dso: %s\n",
> -		    al->map ? al->map->dso->long_name :
> -			al->level == 'H' ? "[hypervisor]" : "<not found>");
> +		    al->map ? map__dso(al->map)->long_name
> +			    : al->level == 'H' ? "[hypervisor]" : "<not found>");
>  
>  	if (thread__is_filtered(thread))
>  		al->filtered |= (1 << HIST_FILTER__THREAD);
> @@ -711,7 +711,7 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
>  	}
>  
>  	if (al->map) {
> -		struct dso *dso = al->map->dso;
> +		struct dso *dso = map__dso(al->map);
>  
>  		if (symbol_conf.dso_list &&
>  		    (!dso || !(strlist__has_entry(symbol_conf.dso_list,
> @@ -738,12 +738,12 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
>  		}
>  		if (!ret && al->sym) {
>  			snprintf(al_addr_str, sz, "0x%"PRIx64,
> -				al->map->unmap_ip(al->map, al->sym->start));
> +				 map__unmap_ip(al->map, al->sym->start));
>  			ret = strlist__has_entry(symbol_conf.sym_list,
>  						al_addr_str);
>  		}
>  		if (!ret && symbol_conf.addr_list && al->map) {
> -			unsigned long addr = al->map->unmap_ip(al->map, al->addr);
> +			unsigned long addr = map__unmap_ip(al->map, al->addr);
>  
>  			ret = intlist__has_entry(symbol_conf.addr_list, addr);
>  			if (!ret && symbol_conf.addr_range) {
> diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
> index 8c2ea8001329..ac6fef9d8906 100644
> --- a/tools/perf/util/evsel_fprintf.c
> +++ b/tools/perf/util/evsel_fprintf.c
> @@ -146,11 +146,11 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
>  				printed += fprintf(fp, " <-");
>  
>  			if (map)
> -				addr = map->map_ip(map, node->ip);
> +				addr = map__map_ip(map, node->ip);
>  
>  			if (print_ip) {
>  				/* Show binary offset for userspace addr */
> -				if (map && !map->dso->kernel)
> +				if (map && !map__dso(map)->kernel)
>  					printed += fprintf(fp, "%c%16" PRIx64, s, addr);
>  				else
>  					printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 78f9fbb925a7..f19ac6eb4775 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -105,7 +105,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
>  		hists__set_col_len(hists, HISTC_THREAD, len + 8);
>  
>  	if (h->ms.map) {
> -		len = dso__name_len(h->ms.map->dso);
> +		len = dso__name_len(map__dso(h->ms.map));
>  		hists__new_col_len(hists, HISTC_DSO, len);
>  	}
>  
> @@ -119,7 +119,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
>  				symlen += BITS_PER_LONG / 4 + 2 + 3;
>  			hists__new_col_len(hists, HISTC_SYMBOL_FROM, symlen);
>  
> -			symlen = dso__name_len(h->branch_info->from.ms.map->dso);
> +			symlen = dso__name_len(map__dso(h->branch_info->from.ms.map));
>  			hists__new_col_len(hists, HISTC_DSO_FROM, symlen);
>  		} else {
>  			symlen = unresolved_col_width + 4 + 2;
> @@ -133,7 +133,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
>  				symlen += BITS_PER_LONG / 4 + 2 + 3;
>  			hists__new_col_len(hists, HISTC_SYMBOL_TO, symlen);
>  
> -			symlen = dso__name_len(h->branch_info->to.ms.map->dso);
> +			symlen = dso__name_len(map__dso(h->branch_info->to.ms.map));
>  			hists__new_col_len(hists, HISTC_DSO_TO, symlen);
>  		} else {
>  			symlen = unresolved_col_width + 4 + 2;
> @@ -177,7 +177,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
>  		}
>  
>  		if (h->mem_info->daddr.ms.map) {
> -			symlen = dso__name_len(h->mem_info->daddr.ms.map->dso);
> +			symlen = dso__name_len(map__dso(h->mem_info->daddr.ms.map));
>  			hists__new_col_len(hists, HISTC_MEM_DADDR_DSO,
>  					   symlen);
>  		} else {
> @@ -2096,7 +2096,7 @@ static bool hists__filter_entry_by_dso(struct hists *hists,
>  				       struct hist_entry *he)
>  {
>  	if (hists->dso_filter != NULL &&
> -	    (he->ms.map == NULL || he->ms.map->dso != hists->dso_filter)) {
> +	    (he->ms.map == NULL || map__dso(he->ms.map) != hists->dso_filter)) {
>  		he->filtered |= (1 << HIST_FILTER__DSO);
>  		return true;
>  	}
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index e8613cbda331..c88f112c0a06 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -731,20 +731,20 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
>  	}
>  
>  	while (1) {
> -		if (!thread__find_map(thread, cpumode, *ip, &al) || !al.map->dso)
> +		if (!thread__find_map(thread, cpumode, *ip, &al) || !map__dso(al.map))
>  			return -EINVAL;
>  
> -		if (al.map->dso->data.status == DSO_DATA_STATUS_ERROR &&
> -		    dso__data_status_seen(al.map->dso,
> +		if (map__dso(al.map)->data.status == DSO_DATA_STATUS_ERROR &&
> +		    dso__data_status_seen(map__dso(al.map),
>  					  DSO_DATA_STATUS_SEEN_ITRACE))
>  			return -ENOENT;
>  
> -		offset = al.map->map_ip(al.map, *ip);
> +		offset = map__map_ip(al.map, *ip);
>  
>  		if (!to_ip && one_map) {
>  			struct intel_pt_cache_entry *e;
>  
> -			e = intel_pt_cache_lookup(al.map->dso, machine, offset);
> +			e = intel_pt_cache_lookup(map__dso(al.map), machine, offset);
>  			if (e &&
>  			    (!max_insn_cnt || e->insn_cnt <= max_insn_cnt)) {
>  				*insn_cnt_ptr = e->insn_cnt;
> @@ -766,10 +766,10 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
>  		/* Load maps to ensure dso->is_64_bit has been updated */
>  		map__load(al.map);
>  
> -		x86_64 = al.map->dso->is_64_bit;
> +		x86_64 = map__dso(al.map)->is_64_bit;
>  
>  		while (1) {
> -			len = dso__data_read_offset(al.map->dso, machine,
> +			len = dso__data_read_offset(map__dso(al.map), machine,
>  						    offset, buf,
>  						    INTEL_PT_INSN_BUF_SZ);
>  			if (len <= 0)
> @@ -795,7 +795,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
>  				goto out_no_cache;
>  			}
>  
> -			if (*ip >= al.map->end)
> +			if (*ip >= map__end(al.map))
>  				break;
>  
>  			offset += intel_pt_insn->length;
> @@ -815,13 +815,13 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
>  	if (to_ip) {
>  		struct intel_pt_cache_entry *e;
>  
> -		e = intel_pt_cache_lookup(al.map->dso, machine, start_offset);
> +		e = intel_pt_cache_lookup(map__dso(al.map), machine, start_offset);
>  		if (e)
>  			return 0;
>  	}
>  
>  	/* Ignore cache errors */
> -	intel_pt_cache_add(al.map->dso, machine, start_offset, insn_cnt,
> +	intel_pt_cache_add(map__dso(al.map), machine, start_offset, insn_cnt,
>  			   *ip - start_ip, intel_pt_insn);
>  
>  	return 0;
> @@ -892,13 +892,13 @@ static int __intel_pt_pgd_ip(uint64_t ip, void *data)
>  	if (!thread)
>  		return -EINVAL;
>  
> -	if (!thread__find_map(thread, cpumode, ip, &al) || !al.map->dso)
> +	if (!thread__find_map(thread, cpumode, ip, &al) || !map__dso(al.map))
>  		return -EINVAL;
>  
> -	offset = al.map->map_ip(al.map, ip);
> +	offset = map__map_ip(al.map, ip);
>  
>  	return intel_pt_match_pgd_ip(ptq->pt, ip, offset,
> -				     al.map->dso->long_name);
> +				     map__dso(al.map)->long_name);
>  }
>  
>  static bool intel_pt_pgd_ip(uint64_t ip, void *data)
> @@ -2406,13 +2406,13 @@ static u64 intel_pt_switch_ip(struct intel_pt *pt, u64 *ptss_ip)
>  	if (map__load(map))
>  		return 0;
>  
> -	start = dso__first_symbol(map->dso);
> +	start = dso__first_symbol(map__dso(map));
>  
>  	for (sym = start; sym; sym = dso__next_symbol(sym)) {
>  		if (sym->binding == STB_GLOBAL &&
>  		    !strcmp(sym->name, "__switch_to")) {
> -			ip = map->unmap_ip(map, sym->start);
> -			if (ip >= map->start && ip < map->end) {
> +			ip = map__unmap_ip(map, sym->start);
> +			if (ip >= map__start(map) && ip < map__end(map)) {
>  				switch_ip = ip;
>  				break;
>  			}
> @@ -2429,8 +2429,8 @@ static u64 intel_pt_switch_ip(struct intel_pt *pt, u64 *ptss_ip)
>  
>  	for (sym = start; sym; sym = dso__next_symbol(sym)) {
>  		if (!strcmp(sym->name, ptss)) {
> -			ip = map->unmap_ip(map, sym->start);
> -			if (ip >= map->start && ip < map->end) {
> +			ip = map__unmap_ip(map, sym->start);
> +			if (ip >= map__start(map) && ip < map__end(map)) {
>  				*ptss_ip = ip;
>  				break;
>  			}
> @@ -2965,7 +2965,7 @@ static int intel_pt_process_aux_output_hw_id(struct intel_pt *pt,
>  static int intel_pt_find_map(struct thread *thread, u8 cpumode, u64 addr,
>  			     struct addr_location *al)
>  {
> -	if (!al->map || addr < al->map->start || addr >= al->map->end) {
> +	if (!al->map || addr < map__start(al->map) || addr >= map__end(al->map)) {
>  		if (!thread__find_map(thread, cpumode, addr, al))
>  			return -1;
>  	}
> @@ -2996,12 +2996,12 @@ static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
>  			continue;
>  		}
>  
> -		if (!al.map->dso || !al.map->dso->auxtrace_cache)
> +		if (!map__dso(al.map) || !map__dso(al.map)->auxtrace_cache)
>  			continue;
>  
> -		offset = al.map->map_ip(al.map, addr);
> +		offset = map__map_ip(al.map, addr);
>  
> -		e = intel_pt_cache_lookup(al.map->dso, machine, offset);
> +		e = intel_pt_cache_lookup(map__dso(al.map), machine, offset);
>  		if (!e)
>  			continue;
>  
> @@ -3014,9 +3014,9 @@ static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
>  			if (e->branch != INTEL_PT_BR_NO_BRANCH)
>  				return 0;
>  		} else {
> -			intel_pt_cache_invalidate(al.map->dso, machine, offset);
> +			intel_pt_cache_invalidate(map__dso(al.map), machine, offset);
>  			intel_pt_log("Invalidated instruction cache for %s at %#"PRIx64"\n",
> -				     al.map->dso->long_name, addr);
> +				     map__dso(al.map)->long_name, addr);
>  		}
>  	}
>  
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 88279008e761..940fb2a50dfd 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -47,7 +47,7 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
>  
>  static struct dso *machine__kernel_dso(struct machine *machine)
>  {
> -	return machine->vmlinux_map->dso;
> +	return map__dso(machine->vmlinux_map);
>  }
>  
>  static void dsos__init(struct dsos *dsos)
> @@ -842,9 +842,10 @@ static int machine__process_ksymbol_unregister(struct machine *machine,
>  	if (map != machine->vmlinux_map)
>  		maps__remove(machine__kernel_maps(machine), map);
>  	else {
> -		sym = dso__find_symbol(map->dso, map->map_ip(map, map->start));
> +		sym = dso__find_symbol(map__dso(map),
> +				map__map_ip(map, map__start(map)));
>  		if (sym)
> -			dso__delete_symbol(map->dso, sym);
> +			dso__delete_symbol(map__dso(map), sym);
>  	}
>  
>  	return 0;
> @@ -880,7 +881,7 @@ int machine__process_text_poke(struct machine *machine, union perf_event *event,
>  		return 0;
>  	}
>  
> -	if (map && map->dso) {
> +	if (map && map__dso(map)) {
>  		u8 *new_bytes = event->text_poke.bytes + event->text_poke.old_len;
>  		int ret;
>  
> @@ -889,7 +890,7 @@ int machine__process_text_poke(struct machine *machine, union perf_event *event,
>  		 * must be done prior to using kernel maps.
>  		 */
>  		map__load(map);
> -		ret = dso__data_write_cache_addr(map->dso, map, machine,
> +		ret = dso__data_write_cache_addr(map__dso(map), map, machine,
>  						 event->text_poke.addr,
>  						 new_bytes,
>  						 event->text_poke.new_len);
> @@ -931,6 +932,7 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
>  	/* If maps__insert failed, return NULL. */
>  	if (err)
>  		map = NULL;
> +
>  out:
>  	/* put the dso here, corresponding to  machine__findnew_module_dso */
>  	dso__put(dso);
> @@ -1118,7 +1120,7 @@ int machine__create_extra_kernel_map(struct machine *machine,
>  
>  	if (!err) {
>  		pr_debug2("Added extra kernel map %s %" PRIx64 "-%" PRIx64 "\n",
> -			kmap->name, map->start, map->end);
> +			kmap->name, map__start(map), map__end(map));
>  	}
>  
>  	map__put(map);
> @@ -1178,9 +1180,9 @@ int machine__map_x86_64_entry_trampolines(struct machine *machine,
>  		if (!kmap || !is_entry_trampoline(kmap->name))
>  			continue;
>  
> -		dest_map = maps__find(kmaps, map->pgoff);
> +		dest_map = maps__find(kmaps, map__pgoff(map));
>  		if (dest_map != map)
> -			map->pgoff = dest_map->map_ip(dest_map, map->pgoff);
> +			map->pgoff = map__map_ip(dest_map, map__pgoff(map));
>  		found = true;
>  	}
>  	if (found || machine->trampolines_mapped)
> @@ -1230,7 +1232,8 @@ __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
>  	if (machine->vmlinux_map == NULL)
>  		return -ENOMEM;
>  
> -	machine->vmlinux_map->map_ip = machine->vmlinux_map->unmap_ip = identity__map_ip;
> +	machine->vmlinux_map->map_ip = map__identity_ip;
> +	machine->vmlinux_map->unmap_ip = map__identity_ip;
>  	return maps__insert(machine__kernel_maps(machine), machine->vmlinux_map);
>  }
>  
> @@ -1329,10 +1332,10 @@ int machines__create_kernel_maps(struct machines *machines, pid_t pid)
>  int machine__load_kallsyms(struct machine *machine, const char *filename)
>  {
>  	struct map *map = machine__kernel_map(machine);
> -	int ret = __dso__load_kallsyms(map->dso, filename, map, true);
> +	int ret = __dso__load_kallsyms(map__dso(map), filename, map, true);
>  
>  	if (ret > 0) {
> -		dso__set_loaded(map->dso);
> +		dso__set_loaded(map__dso(map));
>  		/*
>  		 * Since /proc/kallsyms will have multiple sessions for the
>  		 * kernel, with modules between them, fixup the end of all
> @@ -1347,10 +1350,10 @@ int machine__load_kallsyms(struct machine *machine, const char *filename)
>  int machine__load_vmlinux_path(struct machine *machine)
>  {
>  	struct map *map = machine__kernel_map(machine);
> -	int ret = dso__load_vmlinux_path(map->dso, map);
> +	int ret = dso__load_vmlinux_path(map__dso(map), map);
>  
>  	if (ret > 0)
> -		dso__set_loaded(map->dso);
> +		dso__set_loaded(map__dso(map));
>  
>  	return ret;
>  }
> @@ -1401,16 +1404,16 @@ static int maps__set_module_path(struct maps *maps, const char *path, struct kmo
>  	if (long_name == NULL)
>  		return -ENOMEM;
>  
> -	dso__set_long_name(map->dso, long_name, true);
> -	dso__kernel_module_get_build_id(map->dso, "");
> +	dso__set_long_name(map__dso(map), long_name, true);
> +	dso__kernel_module_get_build_id(map__dso(map), "");
>  
>  	/*
>  	 * Full name could reveal us kmod compression, so
>  	 * we need to update the symtab_type if needed.
>  	 */
> -	if (m->comp && is_kmod_dso(map->dso)) {
> -		map->dso->symtab_type++;
> -		map->dso->comp = m->comp;
> +	if (m->comp && is_kmod_dso(map__dso(map))) {
> +		map__dso(map)->symtab_type++;
> +		map__dso(map)->comp = m->comp;
>  	}
>  
>  	return 0;
> @@ -1509,8 +1512,7 @@ static int machine__create_module(void *arg, const char *name, u64 start,
>  		return -1;
>  	map->end = start + size;
>  
> -	dso__kernel_module_get_build_id(map->dso, machine->root_dir);
> -
> +	dso__kernel_module_get_build_id(map__dso(map), machine->root_dir);
>  	return 0;
>  }
>  
> @@ -1619,7 +1621,7 @@ int machine__create_kernel_maps(struct machine *machine)
>  		struct map_rb_node *next = map_rb_node__next(rb_node);
>  
>  		if (next)
> -			machine__set_kernel_mmap(machine, start, next->map->start);
> +			machine__set_kernel_mmap(machine, start, map__start(next->map));
>  	}
>  
>  out_put:
> @@ -1683,10 +1685,10 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
>  		if (map == NULL)
>  			goto out_problem;
>  
> -		map->end = map->start + xm->end - xm->start;
> +		map->end = map__start(map) + xm->end - xm->start;
>  
>  		if (build_id__is_defined(bid))
> -			dso__set_build_id(map->dso, bid);
> +			dso__set_build_id(map__dso(map), bid);
>  
>  	} else if (is_kernel_mmap) {
>  		const char *symbol_name = (xm->name + strlen(machine->mmap_name));
> @@ -2148,14 +2150,14 @@ static char *callchain_srcline(struct map_symbol *ms, u64 ip)
>  	if (!map || callchain_param.key == CCKEY_FUNCTION)
>  		return srcline;
>  
> -	srcline = srcline__tree_find(&map->dso->srclines, ip);
> +	srcline = srcline__tree_find(&map__dso(map)->srclines, ip);
>  	if (!srcline) {
>  		bool show_sym = false;
>  		bool show_addr = callchain_param.key == CCKEY_ADDRESS;
>  
> -		srcline = get_srcline(map->dso, map__rip_2objdump(map, ip),
> +		srcline = get_srcline(map__dso(map), map__rip_2objdump(map, ip),
>  				      ms->sym, show_sym, show_addr, ip);
> -		srcline__tree_insert(&map->dso->srclines, ip, srcline);
> +		srcline__tree_insert(&map__dso(map)->srclines, ip, srcline);
>  	}
>  
>  	return srcline;
> @@ -2179,7 +2181,7 @@ static int add_callchain_ip(struct thread *thread,
>  {
>  	struct map_symbol ms;
>  	struct addr_location al;
> -	int nr_loop_iter = 0;
> +	int nr_loop_iter = 0, err;
>  	u64 iter_cycles = 0;
>  	const char *srcline = NULL;
>  
> @@ -2228,9 +2230,10 @@ static int add_callchain_ip(struct thread *thread,
>  		}
>  	}
>  
> -	if (symbol_conf.hide_unresolved && al.sym == NULL)
> +	if (symbol_conf.hide_unresolved && al.sym == NULL) {
> +		addr_location__put(&al);
>  		return 0;
> -
> +	}
>  	if (iter) {
>  		nr_loop_iter = iter->nr_loop_iter;
>  		iter_cycles = iter->cycles;
> @@ -2240,9 +2243,10 @@ static int add_callchain_ip(struct thread *thread,
>  	ms.map = al.map;
>  	ms.sym = al.sym;
>  	srcline = callchain_srcline(&ms, al.addr);
> -	return callchain_cursor_append(cursor, ip, &ms,
> -				       branch, flags, nr_loop_iter,
> -				       iter_cycles, branch_from, srcline);
> +	err = callchain_cursor_append(cursor, ip, &ms,
> +				      branch, flags, nr_loop_iter,
> +				      iter_cycles, branch_from, srcline);
> +	return err;
>  }
>  
>  struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
> @@ -2937,15 +2941,15 @@ static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms
>  	if (!symbol_conf.inline_name || !map || !sym)
>  		return ret;
>  
> -	addr = map__map_ip(map, ip);
> +	addr = map__dso_map_ip(map, ip);
>  	addr = map__rip_2objdump(map, addr);
>  
> -	inline_node = inlines__tree_find(&map->dso->inlined_nodes, addr);
> +	inline_node = inlines__tree_find(&map__dso(map)->inlined_nodes, addr);
>  	if (!inline_node) {
> -		inline_node = dso__parse_addr_inlines(map->dso, addr, sym);
> +		inline_node = dso__parse_addr_inlines(map__dso(map), addr, sym);
>  		if (!inline_node)
>  			return ret;
> -		inlines__tree_insert(&map->dso->inlined_nodes, inline_node);
> +		inlines__tree_insert(&map__dso(map)->inlined_nodes, inline_node);
>  	}
>  
>  	list_for_each_entry(ilist, &inline_node->val, list) {
> @@ -2981,7 +2985,7 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
>  	 * its corresponding binary.
>  	 */
>  	if (entry->ms.map)
> -		addr = map__map_ip(entry->ms.map, entry->ip);
> +		addr = map__dso_map_ip(entry->ms.map, entry->ip);
>  
>  	srcline = callchain_srcline(&entry->ms, addr);
>  	return callchain_cursor_append(cursor, entry->ip, &entry->ms,
> @@ -3183,7 +3187,7 @@ int machine__get_kernel_start(struct machine *machine)
>  		 * kernel_start = 1ULL << 63 for x86_64.
>  		 */
>  		if (!err && !machine__is(machine, "x86_64"))
> -			machine->kernel_start = map->start;
> +			machine->kernel_start = map__start(map);
>  	}
>  	return err;
>  }
> @@ -3234,8 +3238,8 @@ char *machine__resolve_kernel_addr(void *vmachine, unsigned long long *addrp, ch
>  	if (sym == NULL)
>  		return NULL;
>  
> -	*modp = __map__is_kmodule(map) ? (char *)map->dso->short_name : NULL;
> -	*addrp = map->unmap_ip(map, sym->start);
> +	*modp = __map__is_kmodule(map) ? (char *)map__dso(map)->short_name : NULL;
> +	*addrp = map__unmap_ip(map, sym->start);
>  	return sym->name;
>  }
>  
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 57e926ce115f..47d81e361e29 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -109,8 +109,8 @@ void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
>  	map->pgoff    = pgoff;
>  	map->reloc    = 0;
>  	map->dso      = dso__get(dso);
> -	map->map_ip   = map__map_ip;
> -	map->unmap_ip = map__unmap_ip;
> +	map->map_ip   = map__dso_map_ip;
> +	map->unmap_ip = map__dso_unmap_ip;
>  	map->erange_warned = false;
>  	refcount_set(&map->refcnt, 1);
>  }
> @@ -120,10 +120,11 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>  		     u32 prot, u32 flags, struct build_id *bid,
>  		     char *filename, struct thread *thread)
>  {
> -	struct map *map = malloc(sizeof(*map));
> +	struct map *map;
>  	struct nsinfo *nsi = NULL;
>  	struct nsinfo *nnsi;
>  
> +	map = malloc(sizeof(*map));
>  	if (map != NULL) {
>  		char newfilename[PATH_MAX];
>  		struct dso *dso;
> @@ -170,7 +171,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>  		map__init(map, start, start + len, pgoff, dso);
>  
>  		if (anon || no_dso) {
> -			map->map_ip = map->unmap_ip = identity__map_ip;
> +			map->map_ip = map->unmap_ip = map__identity_ip;
>  
>  			/*
>  			 * Set memory without DSO as loaded. All map__find_*
> @@ -204,8 +205,9 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>   */
>  struct map *map__new2(u64 start, struct dso *dso)
>  {
> -	struct map *map = calloc(1, (sizeof(*map) +
> -				     (dso->kernel ? sizeof(struct kmap) : 0)));
> +	struct map *map;
> +
> +	map = calloc(1, sizeof(*map) + (dso->kernel ? sizeof(struct kmap) : 0));
>  	if (map != NULL) {
>  		/*
>  		 * ->end will be filled after we load all the symbols
> @@ -218,7 +220,7 @@ struct map *map__new2(u64 start, struct dso *dso)
>  
>  bool __map__is_kernel(const struct map *map)
>  {
> -	if (!map->dso->kernel)
> +	if (!map__dso(map)->kernel)
>  		return false;
>  	return machine__kernel_map(maps__machine(map__kmaps((struct map *)map))) == map;
>  }
> @@ -234,7 +236,7 @@ bool __map__is_bpf_prog(const struct map *map)
>  {
>  	const char *name;
>  
> -	if (map->dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
> +	if (map__dso(map)->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
>  		return true;
>  
>  	/*
> @@ -242,7 +244,7 @@ bool __map__is_bpf_prog(const struct map *map)
>  	 * type of DSO_BINARY_TYPE__BPF_PROG_INFO. In such cases, we can
>  	 * guess the type based on name.
>  	 */
> -	name = map->dso->short_name;
> +	name = map__dso(map)->short_name;
>  	return name && (strstr(name, "bpf_prog_") == name);
>  }
>  
> @@ -250,7 +252,7 @@ bool __map__is_bpf_image(const struct map *map)
>  {
>  	const char *name;
>  
> -	if (map->dso->binary_type == DSO_BINARY_TYPE__BPF_IMAGE)
> +	if (map__dso(map)->binary_type == DSO_BINARY_TYPE__BPF_IMAGE)
>  		return true;
>  
>  	/*
> @@ -258,18 +260,19 @@ bool __map__is_bpf_image(const struct map *map)
>  	 * type of DSO_BINARY_TYPE__BPF_IMAGE. In such cases, we can
>  	 * guess the type based on name.
>  	 */
> -	name = map->dso->short_name;
> +	name = map__dso(map)->short_name;
>  	return name && is_bpf_image(name);
>  }
>  
>  bool __map__is_ool(const struct map *map)
>  {
> -	return map->dso && map->dso->binary_type == DSO_BINARY_TYPE__OOL;
> +	return map__dso(map) &&
> +	       map__dso(map)->binary_type == DSO_BINARY_TYPE__OOL;
>  }
>  
>  bool map__has_symbols(const struct map *map)
>  {
> -	return dso__has_symbols(map->dso);
> +	return dso__has_symbols(map__dso(map));
>  }
>  
>  static void map__exit(struct map *map)
> @@ -292,7 +295,7 @@ void map__put(struct map *map)
>  
>  void map__fixup_start(struct map *map)
>  {
> -	struct rb_root_cached *symbols = &map->dso->symbols;
> +	struct rb_root_cached *symbols = &map__dso(map)->symbols;
>  	struct rb_node *nd = rb_first_cached(symbols);
>  	if (nd != NULL) {
>  		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
> @@ -302,7 +305,7 @@ void map__fixup_start(struct map *map)
>  
>  void map__fixup_end(struct map *map)
>  {
> -	struct rb_root_cached *symbols = &map->dso->symbols;
> +	struct rb_root_cached *symbols = &map__dso(map)->symbols;
>  	struct rb_node *nd = rb_last(&symbols->rb_root);
>  	if (nd != NULL) {
>  		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
> @@ -314,18 +317,18 @@ void map__fixup_end(struct map *map)
>  
>  int map__load(struct map *map)
>  {
> -	const char *name = map->dso->long_name;
> +	const char *name = map__dso(map)->long_name;
>  	int nr;
>  
> -	if (dso__loaded(map->dso))
> +	if (dso__loaded(map__dso(map)))
>  		return 0;
>  
> -	nr = dso__load(map->dso, map);
> +	nr = dso__load(map__dso(map), map);
>  	if (nr < 0) {
> -		if (map->dso->has_build_id) {
> +		if (map__dso(map)->has_build_id) {
>  			char sbuild_id[SBUILD_ID_SIZE];
>  
> -			build_id__sprintf(&map->dso->bid, sbuild_id);
> +			build_id__sprintf(&map__dso(map)->bid, sbuild_id);
>  			pr_debug("%s with build id %s not found", name, sbuild_id);
>  		} else
>  			pr_debug("Failed to open %s", name);
> @@ -357,7 +360,7 @@ struct symbol *map__find_symbol(struct map *map, u64 addr)
>  	if (map__load(map) < 0)
>  		return NULL;
>  
> -	return dso__find_symbol(map->dso, addr);
> +	return dso__find_symbol(map__dso(map), addr);
>  }
>  
>  struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
> @@ -365,24 +368,24 @@ struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
>  	if (map__load(map) < 0)
>  		return NULL;
>  
> -	if (!dso__sorted_by_name(map->dso))
> -		dso__sort_by_name(map->dso);
> +	if (!dso__sorted_by_name(map__dso(map)))
> +		dso__sort_by_name(map__dso(map));
>  
> -	return dso__find_symbol_by_name(map->dso, name);
> +	return dso__find_symbol_by_name(map__dso(map), name);
>  }
>  
>  struct map *map__clone(struct map *from)
>  {
> -	size_t size = sizeof(struct map);
>  	struct map *map;
> +	size_t size = sizeof(struct map);
>  
> -	if (from->dso && from->dso->kernel)
> +	if (map__dso(from) && map__dso(from)->kernel)
>  		size += sizeof(struct kmap);
>  
>  	map = memdup(from, size);
>  	if (map != NULL) {
>  		refcount_set(&map->refcnt, 1);
> -		dso__get(map->dso);
> +		map->dso = dso__get(map->dso);
>  	}
>  
>  	return map;
> @@ -391,7 +394,8 @@ struct map *map__clone(struct map *from)
>  size_t map__fprintf(struct map *map, FILE *fp)
>  {
>  	return fprintf(fp, " %" PRIx64 "-%" PRIx64 " %" PRIx64 " %s\n",
> -		       map->start, map->end, map->pgoff, map->dso->name);
> +		       map__start(map), map__end(map),
> +		       map__pgoff(map), map__dso(map)->name);
>  }
>  
>  size_t map__fprintf_dsoname(struct map *map, FILE *fp)
> @@ -399,11 +403,11 @@ size_t map__fprintf_dsoname(struct map *map, FILE *fp)
>  	char buf[symbol_conf.pad_output_len_dso + 1];
>  	const char *dsoname = "[unknown]";
>  
> -	if (map && map->dso) {
> -		if (symbol_conf.show_kernel_path && map->dso->long_name)
> -			dsoname = map->dso->long_name;
> +	if (map && map__dso(map)) {
> +		if (symbol_conf.show_kernel_path && map__dso(map)->long_name)
> +			dsoname = map__dso(map)->long_name;
>  		else
> -			dsoname = map->dso->name;
> +			dsoname = map__dso(map)->name;
>  	}
>  
>  	if (symbol_conf.pad_output_len_dso) {
> @@ -418,7 +422,8 @@ char *map__srcline(struct map *map, u64 addr, struct symbol *sym)
>  {
>  	if (map == NULL)
>  		return SRCLINE_UNKNOWN;
> -	return get_srcline(map->dso, map__rip_2objdump(map, addr), sym, true, true, addr);
> +	return get_srcline(map__dso(map), map__rip_2objdump(map, addr),
> +			   sym, true, true, addr);
>  }
>  
>  int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
> @@ -426,7 +431,7 @@ int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
>  {
>  	int ret = 0;
>  
> -	if (map && map->dso) {
> +	if (map && map__dso(map)) {
>  		char *srcline = map__srcline(map, addr, NULL);
>  		if (strncmp(srcline, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0)
>  			ret = fprintf(fp, "%s%s", prefix, srcline);
> @@ -472,20 +477,20 @@ u64 map__rip_2objdump(struct map *map, u64 rip)
>  		}
>  	}
>  
> -	if (!map->dso->adjust_symbols)
> +	if (!map__dso(map)->adjust_symbols)
>  		return rip;
>  
> -	if (map->dso->rel)
> -		return rip - map->pgoff;
> +	if (map__dso(map)->rel)
> +		return rip - map__pgoff(map);
>  
>  	/*
>  	 * kernel modules also have DSO_TYPE_USER in dso->kernel,
>  	 * but all kernel modules are ET_REL, so won't get here.
>  	 */
> -	if (map->dso->kernel == DSO_SPACE__USER)
> -		return rip + map->dso->text_offset;
> +	if (map__dso(map)->kernel == DSO_SPACE__USER)
> +		return rip + map__dso(map)->text_offset;
>  
> -	return map->unmap_ip(map, rip) - map->reloc;
> +	return map__unmap_ip(map, rip) - map__reloc(map);
>  }
>  
>  /**
> @@ -502,34 +507,34 @@ u64 map__rip_2objdump(struct map *map, u64 rip)
>   */
>  u64 map__objdump_2mem(struct map *map, u64 ip)
>  {
> -	if (!map->dso->adjust_symbols)
> -		return map->unmap_ip(map, ip);
> +	if (!map__dso(map)->adjust_symbols)
> +		return map__unmap_ip(map, ip);
>  
> -	if (map->dso->rel)
> -		return map->unmap_ip(map, ip + map->pgoff);
> +	if (map__dso(map)->rel)
> +		return map__unmap_ip(map, ip + map__pgoff(map));
>  
>  	/*
>  	 * kernel modules also have DSO_TYPE_USER in dso->kernel,
>  	 * but all kernel modules are ET_REL, so won't get here.
>  	 */
> -	if (map->dso->kernel == DSO_SPACE__USER)
> -		return map->unmap_ip(map, ip - map->dso->text_offset);
> +	if (map__dso(map)->kernel == DSO_SPACE__USER)
> +		return map__unmap_ip(map, ip - map__dso(map)->text_offset);
>  
> -	return ip + map->reloc;
> +	return ip + map__reloc(map);
>  }
>  
>  bool map__contains_symbol(const struct map *map, const struct symbol *sym)
>  {
> -	u64 ip = map->unmap_ip(map, sym->start);
> +	u64 ip = map__unmap_ip(map, sym->start);
>  
> -	return ip >= map->start && ip < map->end;
> +	return ip >= map__start(map) && ip < map__end(map);
>  }
>  
>  struct kmap *__map__kmap(struct map *map)
>  {
> -	if (!map->dso || !map->dso->kernel)
> +	if (!map__dso(map) || !map__dso(map)->kernel)
>  		return NULL;
> -	return (struct kmap *)(map + 1);
> +	return (struct kmap *)(&map[1]);
>  }
>  
>  struct kmap *map__kmap(struct map *map)
> @@ -552,17 +557,17 @@ struct maps *map__kmaps(struct map *map)
>  	return kmap->kmaps;
>  }
>  
> -u64 map__map_ip(const struct map *map, u64 ip)
> +u64 map__dso_map_ip(const struct map *map, u64 ip)
>  {
> -	return ip - map->start + map->pgoff;
> +	return ip - map__start(map) + map__pgoff(map);
>  }
>  
> -u64 map__unmap_ip(const struct map *map, u64 ip)
> +u64 map__dso_unmap_ip(const struct map *map, u64 ip)
>  {
> -	return ip + map->start - map->pgoff;
> +	return ip + map__start(map) - map__pgoff(map);
>  }
>  
> -u64 identity__map_ip(const struct map *map __maybe_unused, u64 ip)
> +u64 map__identity_ip(const struct map *map __maybe_unused, u64 ip)
>  {
>  	return ip;
>  }
> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> index d1a6f85fd31d..99ef0464a357 100644
> --- a/tools/perf/util/map.h
> +++ b/tools/perf/util/map.h
> @@ -41,15 +41,65 @@ struct kmap *map__kmap(struct map *map);
>  struct maps *map__kmaps(struct map *map);
>  
>  /* ip -> dso rip */
> -u64 map__map_ip(const struct map *map, u64 ip);
> +u64 map__dso_map_ip(const struct map *map, u64 ip);
>  /* dso rip -> ip */
> -u64 map__unmap_ip(const struct map *map, u64 ip);
> +u64 map__dso_unmap_ip(const struct map *map, u64 ip);
>  /* Returns ip */
> -u64 identity__map_ip(const struct map *map __maybe_unused, u64 ip);
> +u64 map__identity_ip(const struct map *map __maybe_unused, u64 ip);
> +
> +static inline struct dso *map__dso(const struct map *map)
> +{
> +	return map->dso;
> +}
> +
> +static inline u64 map__map_ip(const struct map *map, u64 ip)
> +{
> +	return map->map_ip(map, ip);
> +}
> +
> +static inline u64 map__unmap_ip(const struct map *map, u64 ip)
> +{
> +	return map->unmap_ip(map, ip);
> +}
> +
> +static inline u64 map__start(const struct map *map)
> +{
> +	return map->start;
> +}
> +
> +static inline u64 map__end(const struct map *map)
> +{
> +	return map->end;
> +}
> +
> +static inline u64 map__pgoff(const struct map *map)
> +{
> +	return map->pgoff;
> +}
> +
> +static inline u64 map__reloc(const struct map *map)
> +{
> +	return map->reloc;
> +}
> +
> +static inline u32 map__flags(const struct map *map)
> +{
> +	return map->flags;
> +}
> +
> +static inline u32 map__prot(const struct map *map)
> +{
> +	return map->prot;
> +}
> +
> +static inline bool map__priv(const struct map *map)
> +{
> +	return map->priv;
> +}
>  
>  static inline size_t map__size(const struct map *map)
>  {
> -	return map->end - map->start;
> +	return map__end(map) - map__start(map);
>  }
>  
>  /* rip/ip <-> addr suitable for passing to `objdump --start-address=` */
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 9fc3e7186b8e..6efbcb79131c 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -30,24 +30,24 @@ static void __maps__free_maps_by_name(struct maps *maps)
>  	maps->nr_maps_allocated = 0;
>  }
>  
> -static int __maps__insert(struct maps *maps, struct map *map)
> +static struct map *__maps__insert(struct maps *maps, struct map *map)
>  {
>  	struct rb_node **p = &maps__entries(maps)->rb_node;
>  	struct rb_node *parent = NULL;
> -	const u64 ip = map->start;
> +	const u64 ip = map__start(map);
>  	struct map_rb_node *m, *new_rb_node;
>  
>  	new_rb_node = malloc(sizeof(*new_rb_node));
>  	if (!new_rb_node)
> -		return -ENOMEM;
> +		return NULL;
>  
>  	RB_CLEAR_NODE(&new_rb_node->rb_node);
> -	new_rb_node->map = map;
> +	new_rb_node->map = map__get(map);
>  
>  	while (*p != NULL) {
>  		parent = *p;
>  		m = rb_entry(parent, struct map_rb_node, rb_node);
> -		if (ip < m->map->start)
> +		if (ip < map__start(m->map))
>  			p = &(*p)->rb_left;
>  		else
>  			p = &(*p)->rb_right;
> @@ -55,22 +55,23 @@ static int __maps__insert(struct maps *maps, struct map *map)
>  
>  	rb_link_node(&new_rb_node->rb_node, parent, p);
>  	rb_insert_color(&new_rb_node->rb_node, maps__entries(maps));
> -	map__get(map);
> -	return 0;
> +	return new_rb_node->map;
>  }
>  
>  int maps__insert(struct maps *maps, struct map *map)
>  {
> -	int err;
> +	int err = 0;
>  
>  	down_write(maps__lock(maps));
> -	err = __maps__insert(maps, map);
> -	if (err)
> +	map = __maps__insert(maps, map);
> +	if (!map) {
> +		err = -ENOMEM;
>  		goto out;
> +	}
>  
>  	++maps->nr_maps;
>  
> -	if (map->dso && map->dso->kernel) {
> +	if (map__dso(map) && map__dso(map)->kernel) {
>  		struct kmap *kmap = map__kmap(map);
>  
>  		if (kmap)
> @@ -193,7 +194,7 @@ struct symbol *maps__find_symbol(struct maps *maps, u64 addr, struct map **mapp)
>  	if (map != NULL && map__load(map) >= 0) {
>  		if (mapp != NULL)
>  			*mapp = map;
> -		return map__find_symbol(map, map->map_ip(map, addr));
> +		return map__find_symbol(map, map__map_ip(map, addr));
>  	}
>  
>  	return NULL;
> @@ -228,7 +229,8 @@ struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name, st
>  
>  int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
>  {
> -	if (ams->addr < ams->ms.map->start || ams->addr >= ams->ms.map->end) {
> +	if (ams->addr < map__start(ams->ms.map) ||
> +	    ams->addr >= map__end(ams->ms.map)) {
>  		if (maps == NULL)
>  			return -1;
>  		ams->ms.map = maps__find(maps, ams->addr);
> @@ -236,7 +238,7 @@ int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
>  			return -1;
>  	}
>  
> -	ams->al_addr = ams->ms.map->map_ip(ams->ms.map, ams->addr);
> +	ams->al_addr = map__map_ip(ams->ms.map, ams->addr);
>  	ams->ms.sym = map__find_symbol(ams->ms.map, ams->al_addr);
>  
>  	return ams->ms.sym ? 0 : -1;
> @@ -253,7 +255,7 @@ size_t maps__fprintf(struct maps *maps, FILE *fp)
>  		printed += fprintf(fp, "Map:");
>  		printed += map__fprintf(pos->map, fp);
>  		if (verbose > 2) {
> -			printed += dso__fprintf(pos->map->dso, fp);
> +			printed += dso__fprintf(map__dso(pos->map), fp);
>  			printed += fprintf(fp, "--\n");
>  		}
>  	}
> @@ -282,9 +284,9 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
>  	while (next) {
>  		struct map_rb_node *pos = rb_entry(next, struct map_rb_node, rb_node);
>  
> -		if (pos->map->end > map->start) {
> +		if (map__end(pos->map) > map__start(map)) {
>  			first = next;
> -			if (pos->map->start <= map->start)
> +			if (map__start(pos->map) <= map__start(map))
>  				break;
>  			next = next->rb_left;
>  		} else
> @@ -300,14 +302,14 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
>  		 * Stop if current map starts after map->end.
>  		 * Maps are ordered by start: next will not overlap for sure.
>  		 */
> -		if (pos->map->start >= map->end)
> +		if (map__start(pos->map) >= map__end(map))
>  			break;
>  
>  		if (verbose >= 2) {
>  
>  			if (use_browser) {
>  				pr_debug("overlapping maps in %s (disable tui for more info)\n",
> -					   map->dso->name);
> +					   map__dso(map)->name);
>  			} else {
>  				fputs("overlapping maps:\n", fp);
>  				map__fprintf(map, fp);
> @@ -320,7 +322,7 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
>  		 * Now check if we need to create new maps for areas not
>  		 * overlapped by the new map:
>  		 */
> -		if (map->start > pos->map->start) {
> +		if (map__start(map) > map__start(pos->map)) {
>  			struct map *before = map__clone(pos->map);
>  
>  			if (before == NULL) {
> @@ -328,17 +330,19 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
>  				goto put_map;
>  			}
>  
> -			before->end = map->start;
> -			err = __maps__insert(maps, before);
> -			if (err)
> +			before->end = map__start(map);
> +			if (!__maps__insert(maps, before)) {
> +				map__put(before);
> +				err = -ENOMEM;
>  				goto put_map;
> +			}
>  
>  			if (verbose >= 2 && !use_browser)
>  				map__fprintf(before, fp);
>  			map__put(before);
>  		}
>  
> -		if (map->end < pos->map->end) {
> +		if (map__end(map) < map__end(pos->map)) {
>  			struct map *after = map__clone(pos->map);
>  
>  			if (after == NULL) {
> @@ -346,14 +350,15 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
>  				goto put_map;
>  			}
>  
> -			after->start = map->end;
> -			after->pgoff += map->end - pos->map->start;
> -			assert(pos->map->map_ip(pos->map, map->end) ==
> -				after->map_ip(after, map->end));
> -			err = __maps__insert(maps, after);
> -			if (err)
> +			after->start = map__end(map);
> +			after->pgoff += map__end(map) - map__start(pos->map);
> +			assert(map__map_ip(pos->map, map__end(map)) ==
> +				map__map_ip(after, map__end(map)));
> +			if (!__maps__insert(maps, after)) {
> +				map__put(after);
> +				err = -ENOMEM;
>  				goto put_map;
> -
> +			}
>  			if (verbose >= 2 && !use_browser)
>  				map__fprintf(after, fp);
>  			map__put(after);
> @@ -377,7 +382,7 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
>  int maps__clone(struct thread *thread, struct maps *parent)
>  {
>  	struct maps *maps = thread->maps;
> -	int err;
> +	int err = 0;
>  	struct map_rb_node *rb_node;
>  
>  	down_read(maps__lock(parent));
> @@ -391,17 +396,13 @@ int maps__clone(struct thread *thread, struct maps *parent)
>  		}
>  
>  		err = unwind__prepare_access(maps, new, NULL);
> -		if (err)
> -			goto out_unlock;
> +		if (!err)
> +			err = maps__insert(maps, new);
>  
> -		err = maps__insert(maps, new);
> +		map__put(new);
>  		if (err)
>  			goto out_unlock;
> -
> -		map__put(new);
>  	}
> -
> -	err = 0;
>  out_unlock:
>  	up_read(maps__lock(parent));
>  	return err;
> @@ -428,9 +429,9 @@ struct map *maps__find(struct maps *maps, u64 ip)
>  	p = maps__entries(maps)->rb_node;
>  	while (p != NULL) {
>  		m = rb_entry(p, struct map_rb_node, rb_node);
> -		if (ip < m->map->start)
> +		if (ip < map__start(m->map))
>  			p = p->rb_left;
> -		else if (ip >= m->map->end)
> +		else if (ip >= map__end(m->map))
>  			p = p->rb_right;
>  		else
>  			goto out;
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index f9fbf611f2bf..1a93dca50a4c 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -134,15 +134,15 @@ static int kernel_get_symbol_address_by_name(const char *name, u64 *addr,
>  	/* ref_reloc_sym is just a label. Need a special fix*/
>  	reloc_sym = kernel_get_ref_reloc_sym(&map);
>  	if (reloc_sym && strcmp(name, reloc_sym->name) == 0)
> -		*addr = (!map->reloc || reloc) ? reloc_sym->addr :
> +		*addr = (!map__reloc(map) || reloc) ? reloc_sym->addr :
>  			reloc_sym->unrelocated_addr;
>  	else {
>  		sym = machine__find_kernel_symbol_by_name(host_machine, name, &map);
>  		if (!sym)
>  			return -ENOENT;
> -		*addr = map->unmap_ip(map, sym->start) -
> -			((reloc) ? 0 : map->reloc) -
> -			((reladdr) ? map->start : 0);
> +		*addr = map__unmap_ip(map, sym->start) -
> +			((reloc) ? 0 : map__reloc(map)) -
> +			((reladdr) ? map__start(map) : 0);
>  	}
>  	return 0;
>  }
> @@ -164,8 +164,8 @@ static struct map *kernel_get_module_map(const char *module)
>  
>  	maps__for_each_entry(maps, pos) {
>  		/* short_name is "[module]" */
> -		const char *short_name = pos->map->dso->short_name;
> -		u16 short_name_len =  pos->map->dso->short_name_len;
> +		const char *short_name = map__dso(pos->map)->short_name;
> +		u16 short_name_len =  map__dso(pos->map)->short_name_len;
>  
>  		if (strncmp(short_name + 1, module,
>  			    short_name_len - 2) == 0 &&
> @@ -183,11 +183,11 @@ struct map *get_target_map(const char *target, struct nsinfo *nsi, bool user)
>  		struct map *map;
>  
>  		map = dso__new_map(target);
> -		if (map && map->dso) {
> -			BUG_ON(pthread_mutex_lock(&map->dso->lock) != 0);
> -			nsinfo__put(map->dso->nsinfo);
> -			map->dso->nsinfo = nsinfo__get(nsi);
> -			pthread_mutex_unlock(&map->dso->lock);
> +		if (map && map__dso(map)) {
> +			BUG_ON(pthread_mutex_lock(&map__dso(map)->lock) != 0);
> +			nsinfo__put(map__dso(map)->nsinfo);
> +			map__dso(map)->nsinfo = nsinfo__get(nsi);
> +			pthread_mutex_unlock(&map__dso(map)->lock);
>  		}
>  		return map;
>  	} else {
> @@ -253,7 +253,7 @@ static bool kprobe_warn_out_range(const char *symbol, u64 address)
>  
>  	map = kernel_get_module_map(NULL);
>  	if (map) {
> -		ret = address <= map->start || map->end < address;
> +		ret = address <= map__start(map) || map__end(map) < address;
>  		if (ret)
>  			pr_warning("%s is out of .text, skip it.\n", symbol);
>  		map__put(map);
> @@ -340,7 +340,7 @@ static int kernel_get_module_dso(const char *module, struct dso **pdso)
>  		snprintf(module_name, sizeof(module_name), "[%s]", module);
>  		map = maps__find_by_name(machine__kernel_maps(host_machine), module_name);
>  		if (map) {
> -			dso = map->dso;
> +			dso = map__dso(map);
>  			goto found;
>  		}
>  		pr_debug("Failed to find module %s.\n", module);
> @@ -348,7 +348,7 @@ static int kernel_get_module_dso(const char *module, struct dso **pdso)
>  	}
>  
>  	map = machine__kernel_map(host_machine);
> -	dso = map->dso;
> +	dso = map__dso(map);
>  	if (!dso->has_build_id)
>  		dso__read_running_kernel_build_id(dso, host_machine);
>  
> @@ -396,7 +396,8 @@ static int find_alternative_probe_point(struct debuginfo *dinfo,
>  					   "Consider identifying the final function used at run time and set the probe directly on that.\n",
>  					   pp->function);
>  		} else
> -			address = map->unmap_ip(map, sym->start) - map->reloc;
> +			address = map__unmap_ip(map, sym->start) -
> +				  map__reloc(map);
>  		break;
>  	}
>  	if (!address) {
> @@ -862,8 +863,7 @@ post_process_kernel_probe_trace_events(struct probe_trace_event *tevs,
>  			free(tevs[i].point.symbol);
>  		tevs[i].point.symbol = tmp;
>  		tevs[i].point.offset = tevs[i].point.address -
> -			(map->reloc ? reloc_sym->unrelocated_addr :
> -				      reloc_sym->addr);
> +			(map__reloc(map) ? reloc_sym->unrelocated_addr : reloc_sym->addr);
>  	}
>  	return skipped;
>  }
> @@ -2243,7 +2243,7 @@ static int find_perf_probe_point_from_map(struct probe_trace_point *tp,
>  		goto out;
>  
>  	pp->retprobe = tp->retprobe;
> -	pp->offset = addr - map->unmap_ip(map, sym->start);
> +	pp->offset = addr - map__unmap_ip(map, sym->start);
>  	pp->function = strdup(sym->name);
>  	ret = pp->function ? 0 : -ENOMEM;
>  
> @@ -3117,7 +3117,7 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
>  			goto err_out;
>  		}
>  		/* Add one probe point */
> -		tp->address = map->unmap_ip(map, sym->start) + pp->offset;
> +		tp->address = map__unmap_ip(map, sym->start) + pp->offset;
>  
>  		/* Check the kprobe (not in module) is within .text  */
>  		if (!pev->uprobes && !pev->target &&
> @@ -3759,13 +3759,13 @@ int show_available_funcs(const char *target, struct nsinfo *nsi,
>  			       (target) ? : "kernel");
>  		goto end;
>  	}
> -	if (!dso__sorted_by_name(map->dso))
> -		dso__sort_by_name(map->dso);
> +	if (!dso__sorted_by_name(map__dso(map)))
> +		dso__sort_by_name(map__dso(map));
>  
>  	/* Show all (filtered) symbols */
>  	setup_pager();
>  
> -	for (nd = rb_first_cached(&map->dso->symbol_names); nd;
> +	for (nd = rb_first_cached(&map__dso(map)->symbol_names); nd;
>  	     nd = rb_next(nd)) {
>  		struct symbol_name_rb_node *pos = rb_entry(nd, struct symbol_name_rb_node, rb_node);
>  
> diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
> index a5d945415bbc..1282fb9b45e1 100644
> --- a/tools/perf/util/scripting-engines/trace-event-perl.c
> +++ b/tools/perf/util/scripting-engines/trace-event-perl.c
> @@ -315,11 +315,12 @@ static SV *perl_process_callchain(struct perf_sample *sample,
>  		if (node->ms.map) {
>  			struct map *map = node->ms.map;
>  			const char *dsoname = "[unknown]";
> -			if (map && map->dso) {
> -				if (symbol_conf.show_kernel_path && map->dso->long_name)
> -					dsoname = map->dso->long_name;
> +			if (map && map__dso(map)) {
> +				if (symbol_conf.show_kernel_path &&
> +				    map__dso(map)->long_name)
> +					dsoname = map__dso(map)->long_name;
>  				else
> -					dsoname = map->dso->name;
> +					dsoname = map__dso(map)->name;
>  			}
>  			if (!hv_stores(elem, "dso", newSVpv(dsoname,0))) {
>  				hv_undef(elem);
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 0290dc3a6258..559b2ac5cac3 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -382,11 +382,11 @@ static const char *get_dsoname(struct map *map)
>  {
>  	const char *dsoname = "[unknown]";
>  
> -	if (map && map->dso) {
> -		if (symbol_conf.show_kernel_path && map->dso->long_name)
> -			dsoname = map->dso->long_name;
> +	if (map && map__dso(map)) {
> +		if (symbol_conf.show_kernel_path && map__dso(map)->long_name)
> +			dsoname = map__dso(map)->long_name;
>  		else
> -			dsoname = map->dso->name;
> +			dsoname = map__dso(map)->name;
>  	}
>  
>  	return dsoname;
> @@ -527,7 +527,7 @@ static unsigned long get_offset(struct symbol *sym, struct addr_location *al)
>  	if (al->addr < sym->end)
>  		offset = al->addr - sym->start;
>  	else
> -		offset = al->addr - al->map->start - sym->start;
> +		offset = al->addr - map__start(al->map) - sym->start;
>  
>  	return offset;
>  }
> @@ -741,7 +741,7 @@ static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
>  {
>  	if (al->map) {
>  		pydict_set_item_string_decref(dict, dso_field,
> -			_PyUnicode_FromString(al->map->dso->name));
> +			_PyUnicode_FromString(map__dso(al->map)->name));
>  	}
>  	if (al->sym) {
>  		pydict_set_item_string_decref(dict, sym_field,
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 25686d67ee6f..6d19bbcd30df 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -173,8 +173,8 @@ struct sort_entry sort_comm = {
>  
>  static int64_t _sort__dso_cmp(struct map *map_l, struct map *map_r)
>  {
> -	struct dso *dso_l = map_l ? map_l->dso : NULL;
> -	struct dso *dso_r = map_r ? map_r->dso : NULL;
> +	struct dso *dso_l = map_l ? map__dso(map_l) : NULL;
> +	struct dso *dso_r = map_r ? map__dso(map_r) : NULL;
>  	const char *dso_name_l, *dso_name_r;
>  
>  	if (!dso_l || !dso_r)
> @@ -200,9 +200,9 @@ sort__dso_cmp(struct hist_entry *left, struct hist_entry *right)
>  static int _hist_entry__dso_snprintf(struct map *map, char *bf,
>  				     size_t size, unsigned int width)
>  {
> -	if (map && map->dso) {
> -		const char *dso_name = verbose > 0 ? map->dso->long_name :
> -			map->dso->short_name;
> +	if (map && map__dso(map)) {
> +		const char *dso_name = verbose > 0 ? map__dso(map)->long_name :
> +			map__dso(map)->short_name;
>  		return repsep_snprintf(bf, size, "%-*.*s", width, width, dso_name);
>  	}
>  
> @@ -222,7 +222,7 @@ static int hist_entry__dso_filter(struct hist_entry *he, int type, const void *a
>  	if (type != HIST_FILTER__DSO)
>  		return -1;
>  
> -	return dso && (!he->ms.map || he->ms.map->dso != dso);
> +	return dso && (!he->ms.map || map__dso(he->ms.map) != dso);
>  }
>  
>  struct sort_entry sort_dso = {
> @@ -302,12 +302,12 @@ static int _hist_entry__sym_snprintf(struct map_symbol *ms,
>  	size_t ret = 0;
>  
>  	if (verbose > 0) {
> -		char o = map ? dso__symtab_origin(map->dso) : '!';
> +		char o = map ? dso__symtab_origin(map__dso(map)) : '!';
>  		u64 rip = ip;
>  
> -		if (map && map->dso && map->dso->kernel
> -		    && map->dso->adjust_symbols)
> -			rip = map->unmap_ip(map, ip);
> +		if (map && map__dso(map) && map__dso(map)->kernel
> +		    && map__dso(map)->adjust_symbols)
> +			rip = map__unmap_ip(map, ip);
>  
>  		ret += repsep_snprintf(bf, size, "%-#*llx %c ",
>  				       BITS_PER_LONG / 4 + 2, rip, o);
> @@ -318,7 +318,7 @@ static int _hist_entry__sym_snprintf(struct map_symbol *ms,
>  		if (sym->type == STT_OBJECT) {
>  			ret += repsep_snprintf(bf + ret, size - ret, "%s", sym->name);
>  			ret += repsep_snprintf(bf + ret, size - ret, "+0x%llx",
> -					ip - map->unmap_ip(map, sym->start));
> +					ip - map__unmap_ip(map, sym->start));
>  		} else {
>  			ret += repsep_snprintf(bf + ret, size - ret, "%.*s",
>  					       width - ret,
> @@ -517,7 +517,7 @@ static char *hist_entry__get_srcfile(struct hist_entry *e)
>  	if (!map)
>  		return no_srcfile;
>  
> -	sf = __get_srcline(map->dso, map__rip_2objdump(map, e->ip),
> +	sf = __get_srcline(map__dso(map), map__rip_2objdump(map, e->ip),
>  			 e->ms.sym, false, true, true, e->ip);
>  	if (!strcmp(sf, SRCLINE_UNKNOWN))
>  		return no_srcfile;
> @@ -838,7 +838,7 @@ static int hist_entry__dso_from_filter(struct hist_entry *he, int type,
>  		return -1;
>  
>  	return dso && (!he->branch_info || !he->branch_info->from.ms.map ||
> -		       he->branch_info->from.ms.map->dso != dso);
> +		map__dso(he->branch_info->from.ms.map) != dso);
>  }
>  
>  static int64_t
> @@ -870,7 +870,7 @@ static int hist_entry__dso_to_filter(struct hist_entry *he, int type,
>  		return -1;
>  
>  	return dso && (!he->branch_info || !he->branch_info->to.ms.map ||
> -		       he->branch_info->to.ms.map->dso != dso);
> +		map__dso(he->branch_info->to.ms.map) != dso);
>  }
>  
>  static int64_t
> @@ -1259,7 +1259,7 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
>  	if (!l_map) return -1;
>  	if (!r_map) return 1;
>  
> -	rc = dso__cmp_id(l_map->dso, r_map->dso);
> +	rc = dso__cmp_id(map__dso(l_map), map__dso(r_map));
>  	if (rc)
>  		return rc;
>  	/*
> @@ -1271,9 +1271,9 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
>  	 */
>  
>  	if ((left->cpumode != PERF_RECORD_MISC_KERNEL) &&
> -	    (!(l_map->flags & MAP_SHARED)) &&
> -	    !l_map->dso->id.maj && !l_map->dso->id.min &&
> -	    !l_map->dso->id.ino && !l_map->dso->id.ino_generation) {
> +	    (!(map__flags(l_map) & MAP_SHARED)) &&
> +	    !map__dso(l_map)->id.maj && !map__dso(l_map)->id.min &&
> +	    !map__dso(l_map)->id.ino && !map__dso(l_map)->id.ino_generation) {
>  		/* userspace anonymous */
>  
>  		if (left->thread->pid_ > right->thread->pid_) return -1;
> @@ -1307,10 +1307,10 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
>  
>  		/* print [s] for shared data mmaps */
>  		if ((he->cpumode != PERF_RECORD_MISC_KERNEL) &&
> -		     map && !(map->prot & PROT_EXEC) &&
> -		    (map->flags & MAP_SHARED) &&
> -		    (map->dso->id.maj || map->dso->id.min ||
> -		     map->dso->id.ino || map->dso->id.ino_generation))
> +		    map && !(map__prot(map) & PROT_EXEC) &&
> +		    (map__flags(map) & MAP_SHARED) &&
> +		    (map__dso(map)->id.maj || map__dso(map)->id.min ||
> +		     map__dso(map)->id.ino || map__dso(map)->id.ino_generation))
>  			level = 's';
>  		else if (!map)
>  			level = 'X';
> @@ -1806,7 +1806,7 @@ sort__dso_size_cmp(struct hist_entry *left, struct hist_entry *right)
>  static int _hist_entry__dso_size_snprintf(struct map *map, char *bf,
>  					  size_t bf_size, unsigned int width)
>  {
> -	if (map && map->dso)
> +	if (map && map__dso(map))
>  		return repsep_snprintf(bf, bf_size, "%*d", width,
>  				       map__size(map));
>  
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 3ca9a0968345..056405d3d655 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -970,7 +970,7 @@ void __weak arch__sym_update(struct symbol *s __maybe_unused,
>  static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
>  				      GElf_Sym *sym, GElf_Shdr *shdr,
>  				      struct maps *kmaps, struct kmap *kmap,
> -				      struct dso **curr_dsop, struct map **curr_mapp,
> +				      struct dso **curr_dsop,
>  				      const char *section_name,
>  				      bool adjust_kernel_syms, bool kmodule, bool *remap_kernel)
>  {
> @@ -994,18 +994,18 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
>  		if (*remap_kernel && dso->kernel && !kmodule) {
>  			*remap_kernel = false;
>  			map->start = shdr->sh_addr + ref_reloc(kmap);
> -			map->end = map->start + shdr->sh_size;
> +			map->end = map__start(map) + shdr->sh_size;
>  			map->pgoff = shdr->sh_offset;
> -			map->map_ip = map__map_ip;
> -			map->unmap_ip = map__unmap_ip;
> +			map->map_ip = map__dso_map_ip;
> +			map->unmap_ip = map__dso_unmap_ip;
>  			/* Ensure maps are correctly ordered */
>  			if (kmaps) {
>  				int err;
> +				struct map *updated = map__get(map);
>  
> -				map__get(map);
>  				maps__remove(kmaps, map);
> -				err = maps__insert(kmaps, map);
> -				map__put(map);
> +				err = maps__insert(kmaps, updated);
> +				map__put(updated);
>  				if (err)
>  					return err;
>  			}
> @@ -1021,7 +1021,6 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
>  			map->pgoff = shdr->sh_offset;
>  		}
>  
> -		*curr_mapp = map;
>  		*curr_dsop = dso;
>  		return 0;
>  	}
> @@ -1036,7 +1035,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
>  		u64 start = sym->st_value;
>  
>  		if (kmodule)
> -			start += map->start + shdr->sh_offset;
> +			start += map__start(map) + shdr->sh_offset;
>  
>  		curr_dso = dso__new(dso_name);
>  		if (curr_dso == NULL)
> @@ -1054,10 +1053,11 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
>  
>  		if (adjust_kernel_syms) {
>  			curr_map->start  = shdr->sh_addr + ref_reloc(kmap);
> -			curr_map->end	 = curr_map->start + shdr->sh_size;
> -			curr_map->pgoff	 = shdr->sh_offset;
> +			curr_map->end	= map__start(curr_map) + shdr->sh_size;
> +			curr_map->pgoff	= shdr->sh_offset;
>  		} else {
> -			curr_map->map_ip = curr_map->unmap_ip = identity__map_ip;
> +			curr_map->map_ip = map__identity_ip;
> +			curr_map->unmap_ip = map__identity_ip;
>  		}
>  		curr_dso->symtab_type = dso->symtab_type;
>  		if (maps__insert(kmaps, curr_map))
> @@ -1068,13 +1068,11 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
>  		 * *curr_map->dso.
>  		 */
>  		dsos__add(&maps__machine(kmaps)->dsos, curr_dso);
> -		/* kmaps already got it */
> -		map__put(curr_map);
>  		dso__set_loaded(curr_dso);
> -		*curr_mapp = curr_map;
>  		*curr_dsop = curr_dso;
> +		map__put(curr_map);
>  	} else
> -		*curr_dsop = curr_map->dso;
> +		*curr_dsop = map__dso(curr_map);
>  
>  	return 0;
>  }
> @@ -1085,7 +1083,6 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  {
>  	struct kmap *kmap = dso->kernel ? map__kmap(map) : NULL;
>  	struct maps *kmaps = kmap ? map__kmaps(map) : NULL;
> -	struct map *curr_map = map;
>  	struct dso *curr_dso = dso;
>  	Elf_Data *symstrs, *secstrs, *secstrs_run, *secstrs_sym;
>  	uint32_t nr_syms;
> @@ -1175,7 +1172,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  	 * attempted to prelink vdso to its virtual address.
>  	 */
>  	if (dso__is_vdso(dso))
> -		map->reloc = map->start - dso->text_offset;
> +		map->reloc = map__start(map) - dso->text_offset;
>  
>  	dso->adjust_symbols = runtime_ss->adjust_symbols || ref_reloc(kmap);
>  	/*
> @@ -1262,8 +1259,10 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  			--sym.st_value;
>  
>  		if (dso->kernel) {
> -			if (dso__process_kernel_symbol(dso, map, &sym, &shdr, kmaps, kmap, &curr_dso, &curr_map,
> -						       section_name, adjust_kernel_syms, kmodule, &remap_kernel))
> +			if (dso__process_kernel_symbol(dso, map, &sym, &shdr,
> +						       kmaps, kmap, &curr_dso,
> +						       section_name, adjust_kernel_syms,
> +						       kmodule, &remap_kernel))
>  				goto out_elf_end;
>  		} else if ((used_opd && runtime_ss->adjust_symbols) ||
>  			   (!used_opd && syms_ss->adjust_symbols)) {
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 9b51e669a722..6289b3028b91 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -252,8 +252,8 @@ void maps__fixup_end(struct maps *maps)
>  	down_write(maps__lock(maps));
>  
>  	maps__for_each_entry(maps, curr) {
> -		if (prev != NULL && !prev->map->end)
> -			prev->map->end = curr->map->start;
> +		if (prev != NULL && !map__end(prev->map))
> +			prev->map->end = map__start(curr->map);
>  
>  		prev = curr;
>  	}
> @@ -262,7 +262,7 @@ void maps__fixup_end(struct maps *maps)
>  	 * We still haven't the actual symbols, so guess the
>  	 * last map final address.
>  	 */
> -	if (curr && !curr->map->end)
> +	if (curr && !map__end(curr->map))
>  		curr->map->end = ~0ULL;
>  
>  	up_write(maps__lock(maps));
> @@ -778,12 +778,12 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
>  			continue;
>  		}
>  
> -		pos->start -= curr_map->start - curr_map->pgoff;
> -		if (pos->end > curr_map->end)
> -			pos->end = curr_map->end;
> +		pos->start -= map__start(curr_map) - map__pgoff(curr_map);
> +		if (pos->end > map__end(curr_map))
> +			pos->end = map__end(curr_map);
>  		if (pos->end)
> -			pos->end -= curr_map->start - curr_map->pgoff;
> -		symbols__insert(&curr_map->dso->symbols, pos);
> +			pos->end -= map__start(curr_map) - map__pgoff(curr_map);
> +		symbols__insert(&map__dso(curr_map)->symbols, pos);
>  		++count;
>  	}
>  
> @@ -830,7 +830,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
>  
>  			*module++ = '\0';
>  
> -			if (strcmp(curr_map->dso->short_name, module)) {
> +			if (strcmp(map__dso(curr_map)->short_name, module)) {
>  				if (curr_map != initial_map &&
>  				    dso->kernel == DSO_SPACE__KERNEL_GUEST &&
>  				    machine__is_default_guest(machine)) {
> @@ -841,7 +841,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
>  					 * symbols are in its kmap. Mark it as
>  					 * loaded.
>  					 */
> -					dso__set_loaded(curr_map->dso);
> +					dso__set_loaded(map__dso(curr_map));
>  				}
>  
>  				curr_map = maps__find_by_name(kmaps, module);
> @@ -854,7 +854,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
>  					goto discard_symbol;
>  				}
>  
> -				if (curr_map->dso->loaded &&
> +				if (map__dso(curr_map)->loaded &&
>  				    !machine__is_default_guest(machine))
>  					goto discard_symbol;
>  			}
> @@ -862,8 +862,8 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
>  			 * So that we look just like we get from .ko files,
>  			 * i.e. not prelinked, relative to initial_map->start.
>  			 */
> -			pos->start = curr_map->map_ip(curr_map, pos->start);
> -			pos->end   = curr_map->map_ip(curr_map, pos->end);
> +			pos->start = map__map_ip(curr_map, pos->start);
> +			pos->end   = map__map_ip(curr_map, pos->end);
>  		} else if (x86_64 && is_entry_trampoline(pos->name)) {
>  			/*
>  			 * These symbols are not needed anymore since the
> @@ -910,7 +910,8 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
>  				return -1;
>  			}
>  
> -			curr_map->map_ip = curr_map->unmap_ip = identity__map_ip;
> +			curr_map->map_ip = map__identity_ip;
> +			curr_map->unmap_ip = map__identity_ip;
>  			if (maps__insert(kmaps, curr_map)) {
>  				dso__put(ndso);
>  				return -1;
> @@ -924,7 +925,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
>  add_symbol:
>  		if (curr_map != initial_map) {
>  			rb_erase_cached(&pos->rb_node, root);
> -			symbols__insert(&curr_map->dso->symbols, pos);
> +			symbols__insert(&map__dso(curr_map)->symbols, pos);
>  			++moved;
>  		} else
>  			++count;
> @@ -938,7 +939,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
>  	if (curr_map != initial_map &&
>  	    dso->kernel == DSO_SPACE__KERNEL_GUEST &&
>  	    machine__is_default_guest(maps__machine(kmaps))) {
> -		dso__set_loaded(curr_map->dso);
> +		dso__set_loaded(map__dso(curr_map));
>  	}
>  
>  	return count + moved;
> @@ -1118,8 +1119,8 @@ static int do_validate_kcore_modules(const char *filename, struct maps *kmaps)
>  		}
>  
>  		/* Module must be in memory at the same address */
> -		mi = find_module(old_map->dso->short_name, &modules);
> -		if (!mi || mi->start != old_map->start) {
> +		mi = find_module(map__dso(old_map)->short_name, &modules);
> +		if (!mi || mi->start != map__start(old_map)) {
>  			err = -EINVAL;
>  			goto out;
>  		}
> @@ -1214,7 +1215,7 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
>  		return -ENOMEM;
>  	}
>  
> -	list_node->map->end = list_node->map->start + len;
> +	list_node->map->end = map__start(list_node->map) + len;
>  	list_node->map->pgoff = pgoff;
>  
>  	list_add(&list_node->node, &md->maps);
> @@ -1236,21 +1237,21 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
>  		struct map *old_map = rb_node->map;
>  
>  		/* no overload with this one */
> -		if (new_map->end < old_map->start ||
> -		    new_map->start >= old_map->end)
> +		if (map__end(new_map) < map__start(old_map) ||
> +		    map__start(new_map) >= map__end(old_map))
>  			continue;
>  
> -		if (new_map->start < old_map->start) {
> +		if (map__start(new_map) < map__start(old_map)) {
>  			/*
>  			 * |new......
>  			 *       |old....
>  			 */
> -			if (new_map->end < old_map->end) {
> +			if (map__end(new_map) < map__end(old_map)) {
>  				/*
>  				 * |new......|     -> |new..|
>  				 *       |old....| ->       |old....|
>  				 */
> -				new_map->end = old_map->start;
> +				new_map->end = map__start(old_map);
>  			} else {
>  				/*
>  				 * |new.............| -> |new..|       |new..|
> @@ -1271,17 +1272,18 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
>  					goto out;
>  				}
>  
> -				m->map->end = old_map->start;
> +				m->map->end = map__start(old_map);
>  				list_add_tail(&m->node, &merged);
> -				new_map->pgoff += old_map->end - new_map->start;
> -				new_map->start = old_map->end;
> +				new_map->pgoff +=
> +					map__end(old_map) - map__start(new_map);
> +				new_map->start = map__end(old_map);
>  			}
>  		} else {
>  			/*
>  			 *      |new......
>  			 * |old....
>  			 */
> -			if (new_map->end < old_map->end) {
> +			if (map__end(new_map) < map__end(old_map)) {
>  				/*
>  				 *      |new..|   -> x
>  				 * |old.........| -> |old.........|
> @@ -1294,8 +1296,9 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
>  				 *      |new......| ->         |new...|
>  				 * |old....|        -> |old....|
>  				 */
> -				new_map->pgoff += old_map->end - new_map->start;
> -				new_map->start = old_map->end;
> +				new_map->pgoff +=
> +					map__end(old_map) - map__start(new_map);
> +				new_map->start = map__end(old_map);
>  			}
>  		}
>  	}
> @@ -1361,7 +1364,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>  	}
>  
>  	/* Read new maps into temporary lists */
> -	err = file__read_maps(fd, map->prot & PROT_EXEC, kcore_mapfn, &md,
> +	err = file__read_maps(fd, map__prot(map) & PROT_EXEC, kcore_mapfn, &md,
>  			      &is_64_bit);
>  	if (err)
>  		goto out_err;
> @@ -1391,7 +1394,8 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>  		struct map_list_node *new_node;
>  
>  		list_for_each_entry(new_node, &md.maps, node) {
> -			if (stext >= new_node->map->start && stext < new_node->map->end) {
> +			if (stext >= map__start(new_node->map) &&
> +			    stext < map__end(new_node->map)) {
>  				replacement_map = new_node->map;
>  				break;
>  			}
> @@ -1408,16 +1412,18 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>  		new_node = list_entry(md.maps.next, struct map_list_node, node);
>  		list_del_init(&new_node->node);
>  		if (new_node->map == replacement_map) {
> -			map->start	= new_node->map->start;
> -			map->end	= new_node->map->end;
> -			map->pgoff	= new_node->map->pgoff;
> -			map->map_ip	= new_node->map->map_ip;
> -			map->unmap_ip	= new_node->map->unmap_ip;
> +			struct  map *updated;
> +
> +			map->start = map__start(new_node->map);
> +			map->end   = map__end(new_node->map);
> +			map->pgoff = map__pgoff(new_node->map);
> +			map->map_ip = new_node->map->map_ip;
> +			map->unmap_ip = new_node->map->unmap_ip;
>  			/* Ensure maps are correctly ordered */
> -			map__get(map);
> +			updated = map__get(map);
>  			maps__remove(kmaps, map);
> -			err = maps__insert(kmaps, map);
> -			map__put(map);
> +			err = maps__insert(kmaps, updated);
> +			map__put(updated);
>  			map__put(new_node->map);
>  			if (err)
>  				goto out_err;
> @@ -1460,7 +1466,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>  
>  	close(fd);
>  
> -	if (map->prot & PROT_EXEC)
> +	if (map__prot(map) & PROT_EXEC)
>  		pr_debug("Using %s for kernel object code\n", kcore_filename);
>  	else
>  		pr_debug("Using %s for kernel data\n", kcore_filename);
> @@ -1995,13 +2001,13 @@ int dso__load(struct dso *dso, struct map *map)
>  static int map__strcmp(const void *a, const void *b)
>  {
>  	const struct map *ma = *(const struct map **)a, *mb = *(const struct map **)b;
> -	return strcmp(ma->dso->short_name, mb->dso->short_name);
> +	return strcmp(map__dso(ma)->short_name, map__dso(mb)->short_name);
>  }
>  
>  static int map__strcmp_name(const void *name, const void *b)
>  {
>  	const struct map *map = *(const struct map **)b;
> -	return strcmp(name, map->dso->short_name);
> +	return strcmp(name, map__dso(map)->short_name);
>  }
>  
>  void __maps__sort_by_name(struct maps *maps)
> @@ -2052,7 +2058,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
>  	down_read(maps__lock(maps));
>  
>  	if (maps->last_search_by_name &&
> -	    strcmp(maps->last_search_by_name->dso->short_name, name) == 0) {
> +	    strcmp(map__dso(maps->last_search_by_name)->short_name, name) == 0) {
>  		map = maps->last_search_by_name;
>  		goto out_unlock;
>  	}
> @@ -2068,7 +2074,7 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
>  	/* Fallback to traversing the rbtree... */
>  	maps__for_each_entry(maps, rb_node) {
>  		map = rb_node->map;
> -		if (strcmp(map->dso->short_name, name) == 0) {
> +		if (strcmp(map__dso(map)->short_name, name) == 0) {
>  			maps->last_search_by_name = map;
>  			goto out_unlock;
>  		}
> diff --git a/tools/perf/util/symbol_fprintf.c b/tools/perf/util/symbol_fprintf.c
> index 2664fb65e47a..d9e5ad040b6a 100644
> --- a/tools/perf/util/symbol_fprintf.c
> +++ b/tools/perf/util/symbol_fprintf.c
> @@ -30,7 +30,7 @@ size_t __symbol__fprintf_symname_offs(const struct symbol *sym,
>  			if (al->addr < sym->end)
>  				offset = al->addr - sym->start;
>  			else
> -				offset = al->addr - al->map->start - sym->start;
> +				offset = al->addr - map__start(al->map) - sym->start;
>  			length += fprintf(fp, "+0x%lx", offset);
>  		}
>  		return length;
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index ed2d55d224aa..437fd57c2084 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -668,33 +668,33 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
>  			continue;
>  
>  		if (symbol_conf.buildid_mmap2) {
> -			size = PERF_ALIGN(map->dso->long_name_len + 1, sizeof(u64));
> +			size = PERF_ALIGN(map__dso(map)->long_name_len + 1, sizeof(u64));
>  			event->mmap2.header.type = PERF_RECORD_MMAP2;
>  			event->mmap2.header.size = (sizeof(event->mmap2) -
>  						(sizeof(event->mmap2.filename) - size));
>  			memset(event->mmap2.filename + size, 0, machine->id_hdr_size);
>  			event->mmap2.header.size += machine->id_hdr_size;
> -			event->mmap2.start = map->start;
> -			event->mmap2.len   = map->end - map->start;
> +			event->mmap2.start = map__start(map);
> +			event->mmap2.len   = map__end(map) - map__start(map);
>  			event->mmap2.pid   = machine->pid;
>  
> -			memcpy(event->mmap2.filename, map->dso->long_name,
> -			       map->dso->long_name_len + 1);
> +			memcpy(event->mmap2.filename, map__dso(map)->long_name,
> +			       map__dso(map)->long_name_len + 1);
>  
>  			perf_record_mmap2__read_build_id(&event->mmap2, false);
>  		} else {
> -			size = PERF_ALIGN(map->dso->long_name_len + 1, sizeof(u64));
> +			size = PERF_ALIGN(map__dso(map)->long_name_len + 1, sizeof(u64));
>  			event->mmap.header.type = PERF_RECORD_MMAP;
>  			event->mmap.header.size = (sizeof(event->mmap) -
>  						(sizeof(event->mmap.filename) - size));
>  			memset(event->mmap.filename + size, 0, machine->id_hdr_size);
>  			event->mmap.header.size += machine->id_hdr_size;
> -			event->mmap.start = map->start;
> -			event->mmap.len   = map->end - map->start;
> +			event->mmap.start = map__start(map);
> +			event->mmap.len   = map__end(map) - map__start(map);
>  			event->mmap.pid   = machine->pid;
>  
> -			memcpy(event->mmap.filename, map->dso->long_name,
> -			       map->dso->long_name_len + 1);
> +			memcpy(event->mmap.filename, map__dso(map)->long_name,
> +			       map__dso(map)->long_name_len + 1);
>  		}
>  
>  		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
> @@ -1112,8 +1112,8 @@ static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
>  		event->mmap2.header.size = (sizeof(event->mmap2) -
>  				(sizeof(event->mmap2.filename) - size) + machine->id_hdr_size);
>  		event->mmap2.pgoff = kmap->ref_reloc_sym->addr;
> -		event->mmap2.start = map->start;
> -		event->mmap2.len   = map->end - event->mmap.start;
> +		event->mmap2.start = map__start(map);
> +		event->mmap2.len   = map__end(map) - event->mmap.start;
>  		event->mmap2.pid   = machine->pid;
>  
>  		perf_record_mmap2__read_build_id(&event->mmap2, true);
> @@ -1125,8 +1125,8 @@ static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
>  		event->mmap.header.size = (sizeof(event->mmap) -
>  				(sizeof(event->mmap.filename) - size) + machine->id_hdr_size);
>  		event->mmap.pgoff = kmap->ref_reloc_sym->addr;
> -		event->mmap.start = map->start;
> -		event->mmap.len   = map->end - event->mmap.start;
> +		event->mmap.start = map__start(map);
> +		event->mmap.len   = map__end(map) - event->mmap.start;
>  		event->mmap.pid   = machine->pid;
>  	}
>  
> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index c2256777b813..6fbcc115cc6d 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
> @@ -434,23 +434,23 @@ struct thread *thread__main_thread(struct machine *machine, struct thread *threa
>  int thread__memcpy(struct thread *thread, struct machine *machine,
>  		   void *buf, u64 ip, int len, bool *is64bit)
>  {
> -       u8 cpumode = PERF_RECORD_MISC_USER;
> -       struct addr_location al;
> -       long offset;
> +	u8 cpumode = PERF_RECORD_MISC_USER;
> +	struct addr_location al;
> +	long offset;
>  
> -       if (machine__kernel_ip(machine, ip))
> -               cpumode = PERF_RECORD_MISC_KERNEL;
> +	if (machine__kernel_ip(machine, ip))
> +		cpumode = PERF_RECORD_MISC_KERNEL;
>  
> -       if (!thread__find_map(thread, cpumode, ip, &al) || !al.map->dso ||
> -	   al.map->dso->data.status == DSO_DATA_STATUS_ERROR ||
> -	   map__load(al.map) < 0)
> -               return -1;
> +	if (!thread__find_map(thread, cpumode, ip, &al) || !map__dso(al.map) ||
> +		map__dso(al.map)->data.status == DSO_DATA_STATUS_ERROR ||
> +		map__load(al.map) < 0)
> +		return -1;
>  
> -       offset = al.map->map_ip(al.map, ip);
> -       if (is64bit)
> -               *is64bit = al.map->dso->is_64_bit;
> +	offset = map__map_ip(al.map, ip);
> +	if (is64bit)
> +		*is64bit = map__dso(al.map)->is_64_bit;
>  
> -       return dso__data_read_offset(al.map->dso, machine, offset, buf, len);
> +	return dso__data_read_offset(map__dso(al.map), machine, offset, buf, len);
>  }
>  
>  void thread__free_stitch_list(struct thread *thread)
> diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
> index 7e6c59811292..841ac84a93ab 100644
> --- a/tools/perf/util/unwind-libunwind-local.c
> +++ b/tools/perf/util/unwind-libunwind-local.c
> @@ -381,20 +381,20 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
>  	int ret = -EINVAL;
>  
>  	map = find_map(ip, ui);
> -	if (!map || !map->dso)
> +	if (!map || !map__dso(map))
>  		return -EINVAL;
>  
> -	pr_debug("unwind: find_proc_info dso %s\n", map->dso->name);
> +	pr_debug("unwind: %s dso %s\n", __func__, map__dso(map)->name);
>  
>  	/* Check the .eh_frame section for unwinding info */
> -	if (!read_unwind_spec_eh_frame(map->dso, ui->machine,
> +	if (!read_unwind_spec_eh_frame(map__dso(map), ui->machine,
>  				       &table_data, &segbase, &fde_count)) {
>  		memset(&di, 0, sizeof(di));
>  		di.format   = UNW_INFO_FORMAT_REMOTE_TABLE;
> -		di.start_ip = map->start;
> -		di.end_ip   = map->end;
> -		di.u.rti.segbase    = map->start + segbase - map->pgoff;
> -		di.u.rti.table_data = map->start + table_data - map->pgoff;
> +		di.start_ip = map__start(map);
> +		di.end_ip   = map__end(map);
> +		di.u.rti.segbase    = map__start(map) + segbase - map__pgoff(map);
> +		di.u.rti.table_data = map__start(map) + table_data - map__pgoff(map);
>  		di.u.rti.table_len  = fde_count * sizeof(struct table_entry)
>  				      / sizeof(unw_word_t);
>  		ret = dwarf_search_unwind_table(as, ip, &di, pi,
> @@ -404,20 +404,20 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
>  #ifndef NO_LIBUNWIND_DEBUG_FRAME
>  	/* Check the .debug_frame section for unwinding info */
>  	if (ret < 0 &&
> -	    !read_unwind_spec_debug_frame(map->dso, ui->machine, &segbase)) {
> -		int fd = dso__data_get_fd(map->dso, ui->machine);
> -		int is_exec = elf_is_exec(fd, map->dso->name);
> -		unw_word_t base = is_exec ? 0 : map->start;
> +	    !read_unwind_spec_debug_frame(map__dso(map), ui->machine, &segbase)) {
> +		int fd = dso__data_get_fd(map__dso(map), ui->machine);
> +		int is_exec = elf_is_exec(fd, map__dso(map)->name);
> +		unw_word_t base = is_exec ? 0 : map__start(map);
>  		const char *symfile;
>  
>  		if (fd >= 0)
> -			dso__data_put_fd(map->dso);
> +			dso__data_put_fd(map__dso(map));
>  
> -		symfile = map->dso->symsrc_filename ?: map->dso->name;
> +		symfile = map__dso(map)->symsrc_filename ?: map__dso(map)->name;
>  
>  		memset(&di, 0, sizeof(di));
>  		if (dwarf_find_debug_frame(0, &di, ip, base, symfile,
> -					   map->start, map->end))
> +					   map__start(map), map__end(map)))
>  			return dwarf_search_unwind_table(as, ip, &di, pi,
>  							 need_unwind_info, arg);
>  	}
> @@ -473,10 +473,10 @@ static int access_dso_mem(struct unwind_info *ui, unw_word_t addr,
>  		return -1;
>  	}
>  
> -	if (!map->dso)
> +	if (!map__dso(map))
>  		return -1;
>  
> -	size = dso__data_read_addr(map->dso, map, ui->machine,
> +	size = dso__data_read_addr(map__dso(map), map, ui->machine,
>  				   addr, (u8 *) data, sizeof(*data));
>  
>  	return !(size == sizeof(*data));
> @@ -583,7 +583,7 @@ static int entry(u64 ip, struct thread *thread,
>  	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
>  		 al.sym ? al.sym->name : "''",
>  		 ip,
> -		 al.map ? al.map->map_ip(al.map, ip) : (u64) 0);
> +		 al.map ? map__map_ip(al.map, ip) : (u64) 0);
>  
>  	return cb(&e, arg);
>  }
> diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
> index 7b797ffadd19..cece1ee89031 100644
> --- a/tools/perf/util/unwind-libunwind.c
> +++ b/tools/perf/util/unwind-libunwind.c
> @@ -30,7 +30,7 @@ int unwind__prepare_access(struct maps *maps, struct map *map, bool *initialized
>  
>  	if (maps__addr_space(maps)) {
>  		pr_debug("unwind: thread map already set, dso=%s\n",
> -			 map->dso->name);
> +			 map__dso(map)->name);
>  		if (initialized)
>  			*initialized = true;
>  		return 0;
> @@ -41,7 +41,7 @@ int unwind__prepare_access(struct maps *maps, struct map *map, bool *initialized
>  	if (!machine->env || !machine->env->arch)
>  		goto out_register;
>  
> -	dso_type = dso__type(map->dso, machine);
> +	dso_type = dso__type(map__dso(map), machine);
>  	if (dso_type == DSO__TYPE_UNKNOWN)
>  		return 0;
>  
> diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
> index 835c39efb80d..ec777ee11493 100644
> --- a/tools/perf/util/vdso.c
> +++ b/tools/perf/util/vdso.c
> @@ -147,7 +147,7 @@ static enum dso_type machine__thread_dso_type(struct machine *machine,
>  	struct map_rb_node *rb_node;
>  
>  	maps__for_each_entry(thread->maps, rb_node) {
> -		struct dso *dso = rb_node->map->dso;
> +		struct dso *dso = map__dso(rb_node->map);
>  
>  		if (!dso || dso->long_name[0] != '/')
>  			continue;
> -- 
> 2.35.1.265.g69c8d7142f-goog

-- 

- Arnaldo
