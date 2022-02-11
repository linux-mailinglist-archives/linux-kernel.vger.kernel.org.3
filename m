Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02A04B2BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352108AbiBKRXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:23:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352048AbiBKRXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:23:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E01CEB;
        Fri, 11 Feb 2022 09:23:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E612F61ACF;
        Fri, 11 Feb 2022 17:23:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08B2C340E9;
        Fri, 11 Feb 2022 17:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644600186;
        bh=hjaXga3hfPg/eVj0wlTtHWPTYKFgzl33eDcb2SVSwRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T0p0DLnz/5DdiY0Micp3fL3kwv0MwgRjDsQNdlmmEAEfsvctLhlHZwxRY1b7uv+C5
         8yWsE9B3Tnmfdq3QlHYK8AfDiCFSDTG3+eoWdNIFY1dKBAjNywAWzWY7JE5o1yGmEH
         gY3EjUBKP2x/qAF/wip/OGRLXyhfnMXOQpcP3LUzlSln9IEpKNgVNv5dFP4LwgUrgM
         A+882fl9n8lukZ4FFf880kUZQko5ofEdwTdhNaiHRjZ9o8kELzH2RrLjeMjaKXBRKT
         QygFAIXf5UaIMQ4mGo8q0iGohQdIfqnWRYhnkY+Ij9MsG+hkx3ZvGwjQ1j/gxDWuqh
         q8x68moQktPGg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 854E9400FE; Fri, 11 Feb 2022 14:23:03 -0300 (-03)
Date:   Fri, 11 Feb 2022 14:23:03 -0300
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
Subject: Re: [PATCH v3 05/22] perf maps: Use a pointer for kmaps
Message-ID: <Ygabd1q3G1x19LU3@kernel.org>
References: <20220211103415.2737789-1-irogers@google.com>
 <20220211103415.2737789-6-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220211103415.2737789-6-irogers@google.com>
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

Em Fri, Feb 11, 2022 at 02:33:58AM -0800, Ian Rogers escreveu:
> struct maps is reference counted, using a pointer is more idiomatic.

So, I tried to apply this after adding this to the cset comming log to
make sure reviewers know that this is just a clarifying comming, no code
change:

Committer notes:

Definition of machine__kernel_maps(machine), the replacement of &machine->kmaps

static inline
struct maps *machine__kernel_maps(struct machine *machine)
{
        return machine->kmaps;
}

but then when building on a f34 system I got:

  CC      /tmp/build/perf/bench/inject-buildid.o
In file included from /var/home/acme/git/perf/tools/perf/util/build-id.h:10,
                 from /var/home/acme/git/perf/tools/perf/util/dso.h:13,
                 from tests/vmlinux-kallsyms.c:8:
In function ‘machine__kernel_maps’,
    inlined from ‘test__vmlinux_matches_kallsyms’ at tests/vmlinux-kallsyms.c:122:22:
/var/home/acme/git/perf/tools/perf/util/machine.h:86:23: error: ‘vmlinux.kmaps’ is used uninitialized [-Werror=uninitialized]
   86 |         return machine->kmaps;
      |                ~~~~~~~^~~~~~~
tests/vmlinux-kallsyms.c: In function ‘test__vmlinux_matches_kallsyms’:
tests/vmlinux-kallsyms.c:121:34: note: ‘vmlinux’ declared here
  121 |         struct machine kallsyms, vmlinux;
      |                                  ^~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/tests/vmlinux-kallsyms.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  CC      /tmp/build/perf/util/config.o
  CC      /tmp/build/perf/arch/x86/util/archinsn.o
  CC      /tmp/build/perf/arch/x86/util/intel-pt.o
  CC      /tmp/build/perf/arch/x86/util/intel-bts.o
  CC      /tmp/build/perf/util/db-export.o
  CC      /tmp/build/perf/util/event.o
make[3]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:139: tests] Error 2
make[3]: *** Waiting for unfinished jobs....

Can you please  take a look at that?

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/util/event.c    |  2 +-
>  tools/perf/tests/vmlinux-kallsyms.c |  4 +--
>  tools/perf/util/bpf-event.c         |  2 +-
>  tools/perf/util/callchain.c         |  2 +-
>  tools/perf/util/event.c             |  6 ++---
>  tools/perf/util/machine.c           | 38 ++++++++++++++++-------------
>  tools/perf/util/machine.h           |  8 +++---
>  tools/perf/util/probe-event.c       |  2 +-
>  8 files changed, 34 insertions(+), 30 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
> index 9b31734ee968..e670f3547581 100644
> --- a/tools/perf/arch/x86/util/event.c
> +++ b/tools/perf/arch/x86/util/event.c
> @@ -18,7 +18,7 @@ int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
>  {
>  	int rc = 0;
>  	struct map *pos;
> -	struct maps *kmaps = &machine->kmaps;
> +	struct maps *kmaps = machine__kernel_maps(machine);
>  	union perf_event *event = zalloc(sizeof(event->mmap) +
>  					 machine->id_hdr_size);
>  
> diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
> index e80df13c0420..84bf5f640065 100644
> --- a/tools/perf/tests/vmlinux-kallsyms.c
> +++ b/tools/perf/tests/vmlinux-kallsyms.c
> @@ -293,7 +293,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
>  		 * so use the short name, less descriptive but the same ("[kernel]" in
>  		 * both cases.
>  		 */
> -		pair = maps__find_by_name(&kallsyms.kmaps, (map->dso->kernel ?
> +		pair = maps__find_by_name(kallsyms.kmaps, (map->dso->kernel ?
>  								map->dso->short_name :
>  								map->dso->name));
>  		if (pair) {
> @@ -315,7 +315,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
>  		mem_start = vmlinux_map->unmap_ip(vmlinux_map, map->start);
>  		mem_end = vmlinux_map->unmap_ip(vmlinux_map, map->end);
>  
> -		pair = maps__find(&kallsyms.kmaps, mem_start);
> +		pair = maps__find(kallsyms.kmaps, mem_start);
>  		if (pair == NULL || pair->priv)
>  			continue;
>  
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index a517eaa51eb3..33257b594a71 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -92,7 +92,7 @@ static int machine__process_bpf_event_load(struct machine *machine,
>  	for (i = 0; i < info_linear->info.nr_jited_ksyms; i++) {
>  		u64 *addrs = (u64 *)(uintptr_t)(info_linear->info.jited_ksyms);
>  		u64 addr = addrs[i];
> -		struct map *map = maps__find(&machine->kmaps, addr);
> +		struct map *map = maps__find(machine__kernel_maps(machine), addr);
>  
>  		if (map) {
>  			map->dso->binary_type = DSO_BINARY_TYPE__BPF_PROG_INFO;
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 131207b91d15..5c27a4b2e7a7 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1119,7 +1119,7 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
>  			goto out;
>  	}
>  
> -	if (al->maps == &al->maps->machine->kmaps) {
> +	if (al->maps == machine__kernel_maps(al->maps->machine)) {
>  		if (machine__is_host(al->maps->machine)) {
>  			al->cpumode = PERF_RECORD_MISC_KERNEL;
>  			al->level = 'k';
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index fe24801f8e9f..6439c888ae38 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -484,7 +484,7 @@ size_t perf_event__fprintf_text_poke(union perf_event *event, struct machine *ma
>  	if (machine) {
>  		struct addr_location al;
>  
> -		al.map = maps__find(&machine->kmaps, tp->addr);
> +		al.map = maps__find(machine__kernel_maps(machine), tp->addr);
>  		if (al.map && map__load(al.map) >= 0) {
>  			al.addr = al.map->map_ip(al.map, tp->addr);
>  			al.sym = map__find_symbol(al.map, al.addr);
> @@ -587,13 +587,13 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
>  
>  	if (cpumode == PERF_RECORD_MISC_KERNEL && perf_host) {
>  		al->level = 'k';
> -		al->maps = maps = &machine->kmaps;
> +		al->maps = maps = machine__kernel_maps(machine);
>  		load_map = true;
>  	} else if (cpumode == PERF_RECORD_MISC_USER && perf_host) {
>  		al->level = '.';
>  	} else if (cpumode == PERF_RECORD_MISC_GUEST_KERNEL && perf_guest) {
>  		al->level = 'g';
> -		al->maps = maps = &machine->kmaps;
> +		al->maps = maps = machine__kernel_maps(machine);
>  		load_map = true;
>  	} else if (cpumode == PERF_RECORD_MISC_GUEST_USER && perf_guest) {
>  		al->level = 'u';
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index f70ba56912d4..57fbdba66425 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -89,7 +89,10 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
>  	int err = -ENOMEM;
>  
>  	memset(machine, 0, sizeof(*machine));
> -	maps__init(&machine->kmaps, machine);
> +	machine->kmaps = maps__new(machine);
> +	if (machine->kmaps == NULL)
> +		return -ENOMEM;
> +
>  	RB_CLEAR_NODE(&machine->rb_node);
>  	dsos__init(&machine->dsos);
>  
> @@ -108,7 +111,7 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
>  
>  	machine->root_dir = strdup(root_dir);
>  	if (machine->root_dir == NULL)
> -		return -ENOMEM;
> +		goto out;
>  
>  	if (machine__set_mmap_name(machine))
>  		goto out;
> @@ -131,6 +134,7 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
>  
>  out:
>  	if (err) {
> +		zfree(&machine->kmaps);
>  		zfree(&machine->root_dir);
>  		zfree(&machine->mmap_name);
>  	}
> @@ -220,7 +224,7 @@ void machine__exit(struct machine *machine)
>  		return;
>  
>  	machine__destroy_kernel_maps(machine);
> -	maps__exit(&machine->kmaps);
> +	maps__delete(machine->kmaps);
>  	dsos__exit(&machine->dsos);
>  	machine__exit_vdso(machine);
>  	zfree(&machine->root_dir);
> @@ -778,7 +782,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
>  					     struct perf_sample *sample __maybe_unused)
>  {
>  	struct symbol *sym;
> -	struct map *map = maps__find(&machine->kmaps, event->ksymbol.addr);
> +	struct map *map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
>  
>  	if (!map) {
>  		struct dso *dso = dso__new(event->ksymbol.name);
> @@ -801,7 +805,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
>  
>  		map->start = event->ksymbol.addr;
>  		map->end = map->start + event->ksymbol.len;
> -		maps__insert(&machine->kmaps, map);
> +		maps__insert(machine__kernel_maps(machine), map);
>  		map__put(map);
>  		dso__set_loaded(dso);
>  
> @@ -827,12 +831,12 @@ static int machine__process_ksymbol_unregister(struct machine *machine,
>  	struct symbol *sym;
>  	struct map *map;
>  
> -	map = maps__find(&machine->kmaps, event->ksymbol.addr);
> +	map = maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
>  	if (!map)
>  		return 0;
>  
>  	if (map != machine->vmlinux_map)
> -		maps__remove(&machine->kmaps, map);
> +		maps__remove(machine__kernel_maps(machine), map);
>  	else {
>  		sym = dso__find_symbol(map->dso, map->map_ip(map, map->start));
>  		if (sym)
> @@ -858,7 +862,7 @@ int machine__process_ksymbol(struct machine *machine __maybe_unused,
>  int machine__process_text_poke(struct machine *machine, union perf_event *event,
>  			       struct perf_sample *sample __maybe_unused)
>  {
> -	struct map *map = maps__find(&machine->kmaps, event->text_poke.addr);
> +	struct map *map = maps__find(machine__kernel_maps(machine), event->text_poke.addr);
>  	u8 cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
>  
>  	if (dump_trace)
> @@ -914,7 +918,7 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
>  	if (map == NULL)
>  		goto out;
>  
> -	maps__insert(&machine->kmaps, map);
> +	maps__insert(machine__kernel_maps(machine), map);
>  
>  	/* Put the map here because maps__insert already got it */
>  	map__put(map);
> @@ -1100,7 +1104,7 @@ int machine__create_extra_kernel_map(struct machine *machine,
>  
>  	strlcpy(kmap->name, xm->name, KMAP_NAME_LEN);
>  
> -	maps__insert(&machine->kmaps, map);
> +	maps__insert(machine__kernel_maps(machine), map);
>  
>  	pr_debug2("Added extra kernel map %s %" PRIx64 "-%" PRIx64 "\n",
>  		  kmap->name, map->start, map->end);
> @@ -1145,7 +1149,7 @@ static u64 find_entry_trampoline(struct dso *dso)
>  int machine__map_x86_64_entry_trampolines(struct machine *machine,
>  					  struct dso *kernel)
>  {
> -	struct maps *kmaps = &machine->kmaps;
> +	struct maps *kmaps = machine__kernel_maps(machine);
>  	int nr_cpus_avail, cpu;
>  	bool found = false;
>  	struct map *map;
> @@ -1215,7 +1219,7 @@ __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
>  		return -1;
>  
>  	machine->vmlinux_map->map_ip = machine->vmlinux_map->unmap_ip = identity__map_ip;
> -	maps__insert(&machine->kmaps, machine->vmlinux_map);
> +	maps__insert(machine__kernel_maps(machine), machine->vmlinux_map);
>  	return 0;
>  }
>  
> @@ -1228,7 +1232,7 @@ void machine__destroy_kernel_maps(struct machine *machine)
>  		return;
>  
>  	kmap = map__kmap(map);
> -	maps__remove(&machine->kmaps, map);
> +	maps__remove(machine__kernel_maps(machine), map);
>  	if (kmap && kmap->ref_reloc_sym) {
>  		zfree((char **)&kmap->ref_reloc_sym->name);
>  		zfree(&kmap->ref_reloc_sym);
> @@ -1323,7 +1327,7 @@ int machine__load_kallsyms(struct machine *machine, const char *filename)
>  		 * kernel, with modules between them, fixup the end of all
>  		 * sections.
>  		 */
> -		maps__fixup_end(&machine->kmaps);
> +		maps__fixup_end(machine__kernel_maps(machine));
>  	}
>  
>  	return ret;
> @@ -1471,7 +1475,7 @@ static int machine__set_modules_path(struct machine *machine)
>  		 machine->root_dir, version);
>  	free(version);
>  
> -	return maps__set_modules_path_dir(&machine->kmaps, modules_path, 0);
> +	return maps__set_modules_path_dir(machine__kernel_maps(machine), modules_path, 0);
>  }
>  int __weak arch__fix_module_text_start(u64 *start __maybe_unused,
>  				u64 *size __maybe_unused,
> @@ -1544,11 +1548,11 @@ static void machine__update_kernel_mmap(struct machine *machine,
>  	struct map *map = machine__kernel_map(machine);
>  
>  	map__get(map);
> -	maps__remove(&machine->kmaps, map);
> +	maps__remove(machine__kernel_maps(machine), map);
>  
>  	machine__set_kernel_mmap(machine, start, end);
>  
> -	maps__insert(&machine->kmaps, map);
> +	maps__insert(machine__kernel_maps(machine), map);
>  	map__put(map);
>  }
>  
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index c5a45dc8df4c..0023165422aa 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -51,7 +51,7 @@ struct machine {
>  	struct vdso_info  *vdso_info;
>  	struct perf_env   *env;
>  	struct dsos	  dsos;
> -	struct maps	  kmaps;
> +	struct maps	  *kmaps;
>  	struct map	  *vmlinux_map;
>  	u64		  kernel_start;
>  	pid_t		  *current_tid;
> @@ -83,7 +83,7 @@ struct map *machine__kernel_map(struct machine *machine)
>  static inline
>  struct maps *machine__kernel_maps(struct machine *machine)
>  {
> -	return &machine->kmaps;
> +	return machine->kmaps;
>  }
>  
>  int machine__get_kernel_start(struct machine *machine);
> @@ -223,7 +223,7 @@ static inline
>  struct symbol *machine__find_kernel_symbol(struct machine *machine, u64 addr,
>  					   struct map **mapp)
>  {
> -	return maps__find_symbol(&machine->kmaps, addr, mapp);
> +	return maps__find_symbol(machine->kmaps, addr, mapp);
>  }
>  
>  static inline
> @@ -231,7 +231,7 @@ struct symbol *machine__find_kernel_symbol_by_name(struct machine *machine,
>  						   const char *name,
>  						   struct map **mapp)
>  {
> -	return maps__find_symbol_by_name(&machine->kmaps, name, mapp);
> +	return maps__find_symbol_by_name(machine->kmaps, name, mapp);
>  }
>  
>  int arch__fix_module_text_start(u64 *start, u64 *size, const char *name);
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 7444e689ece7..bc5ab782ace5 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -334,7 +334,7 @@ static int kernel_get_module_dso(const char *module, struct dso **pdso)
>  		char module_name[128];
>  
>  		snprintf(module_name, sizeof(module_name), "[%s]", module);
> -		map = maps__find_by_name(&host_machine->kmaps, module_name);
> +		map = maps__find_by_name(machine__kernel_maps(host_machine), module_name);
>  		if (map) {
>  			dso = map->dso;
>  			goto found;
> -- 
> 2.35.1.265.g69c8d7142f-goog

-- 

- Arnaldo
