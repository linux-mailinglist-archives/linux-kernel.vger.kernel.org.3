Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D325221A5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347650AbiEJQun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344800AbiEJQui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:50:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCEF1E059E;
        Tue, 10 May 2022 09:46:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24C75B81E71;
        Tue, 10 May 2022 16:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4B7C385A6;
        Tue, 10 May 2022 16:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652201197;
        bh=zHV25yDgvrMbIlsbXVeSOlwYr8tZQy5F8h+jc2nsv64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LIaNI5fqKIb9FYdU0Uye+STqdkGPHaRq3w2xjyY0y1h3ShNWUU3dyjuugfBuIKmOQ
         7bPemqQr0a8yFIRvmGD77oJ5yUVuloF7ye+XlCJh1L3G1pJtHuzz8ZYm5nDxMbQd8n
         tYbdZpLqgOO5hTo4k0fgkAA+iY6NzkzhLKJXsI3v3LgekdWfe0khD/a46mi0e12aA7
         EfWilsmymoRMjC84Yn3tRId50hD1I7ldki+uNfn0TDfNpwPxe9sWp9BM2J2J5iJ07+
         nvl+z77YPqvvkddIhtS0jw2UkpyRNHN7v9enTWnlEgdKYY3O94F2R5FhdqhhSTTJkQ
         vo+papb+E8ogw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 72F0E400B1; Tue, 10 May 2022 13:46:35 -0300 (-03)
Date:   Tue, 10 May 2022 13:46:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Blake Jones <blakejones@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add an "-m" option to "perf buildid-list".
Message-ID: <YnqW68rLssWA8uba@kernel.org>
References: <20220503213704.2524229-1-blakejones@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503213704.2524229-1-blakejones@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 03, 2022 at 02:37:04PM -0700, Blake Jones escreveu:
> This new option displays all of the information needed to do external
> BuildID-based symbolization of kernel stack traces, such as those collected
> by bpf_get_stackid(). For each kernel module plus the main kernel, it
> displays the BuildID, the start and end virtual addresses of that module's
> text range (rounded out to page boundaries), and the pathname of the
> module.
> 
> When run as a non-privileged user, the actual addresses of the modules'
> text ranges are not available, so the tools displays "0, <text length>" for
> kernel modules and "0, ffffffffffffffff" for the kernel itself.
> 
> Sample output:
> 
> root# perf buildid-list -m
> cf6df852fd4da122d616153353cc8f560fd12fe0 ffffffffa5400000 ffffffffa6001e27 [kernel.kallsyms]
> 1aa7209aa2acb067d66ed6cf7676d65066384d61 ffffffffc0087000 ffffffffc008b000 /lib/modules/5.15.15-1rodete2-amd64/kernel/crypto/sha512_generic.ko
> 3857815b5bf0183697b68f8fe0ea06121644041e ffffffffc008c000 ffffffffc0098000 /lib/modules/5.15.15-1rodete2-amd64/kernel/arch/x86/crypto/sha512-ssse3.ko
> 4081fde0bca2bc097cb3e9d1efcb836047d485f1 ffffffffc0099000 ffffffffc009f000 /lib/modules/5.15.15-1rodete2-amd64/kernel/drivers/acpi/button.ko
> 1ef81ba4890552ea6b0314f9635fc43fc8cef568 ffffffffc00a4000 ffffffffc00aa000 /lib/modules/5.15.15-1rodete2-amd64/kernel/crypto/cryptd.ko
> cc5c985506cb240d7d082b55ed260cbb851f983e ffffffffc00af000 ffffffffc00b6000 /lib/modules/5.15.15-1rodete2-amd64/kernel/drivers/i2c/busses/i2c-piix4.ko
> [...]
> 
> Signed-off-by: Blake Jones <blakejones@google.com>
> ---
>  .../perf/Documentation/perf-buildid-list.txt  |  3 ++
>  tools/perf/builtin-buildid-list.c             | 33 ++++++++++++++++++-
>  tools/perf/util/dso.c                         | 23 +++++++++++++
>  tools/perf/util/dso.h                         |  2 ++
>  tools/perf/util/machine.c                     | 13 ++++++++
>  tools/perf/util/machine.h                     |  5 +++
>  6 files changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-buildid-list.txt b/tools/perf/Documentation/perf-buildid-list.txt
> index 25c52efcc7f0..a82e92c2667d 100644
> --- a/tools/perf/Documentation/perf-buildid-list.txt
> +++ b/tools/perf/Documentation/perf-buildid-list.txt
> @@ -33,6 +33,9 @@ OPTIONS
>  -k::
>  --kernel::
>  	Show running kernel build id.
> +-m::
> +--modules::
> +	Show buildid, start/end text address, and path of kernel and modules.

Hi,

	Wouldn't it be better to have -m show just modules, name +
buildid, then have -v show more verbose info, i.e. the start, end and
switch from just the module name to its full path?

	Then to get what your patch produces now one would use:

	$ perf buildid-list -kmv

	That would be more flexible, wdyt?

- Arnaldo

>  -v::
>  --verbose::
>  	Be more verbose.
> diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
> index cebadd632234..9a5587de8fd0 100644
> --- a/tools/perf/builtin-buildid-list.c
> +++ b/tools/perf/builtin-buildid-list.c
> @@ -12,6 +12,7 @@
>  #include "util/build-id.h"
>  #include "util/debug.h"
>  #include "util/dso.h"
> +#include "util/map.h"
>  #include <subcmd/pager.h>
>  #include <subcmd/parse-options.h>
>  #include "util/session.h"
> @@ -20,6 +21,29 @@
>  #include <errno.h>
>  #include <linux/err.h>
>  
> +static int buildid__map_cb(struct map *map, void *arg __maybe_unused)
> +{
> +	struct build_id build_id;
> +	char bid_buf[SBUILD_ID_SIZE];
> +	char modpath[255];
> +
> +	dso__get_build_id(map->dso, &build_id);
> +	build_id__sprintf(&build_id, bid_buf);
> +	dso__get_long_name(map->dso, modpath, sizeof(modpath));
> +	printf("%s %16lx %16lx %s\n", bid_buf, map->start, map->end, modpath);
> +
> +	return 0;
> +}
> +
> +static void buildid__show_kernel_modules(void)
> +{
> +	struct machine *machine;
> +
> +	machine = machine__new_host();
> +	machine__for_each_kernel_map(machine, buildid__map_cb, NULL);
> +	machine__delete(machine);
> +}
> +
>  static int sysfs__fprintf_build_id(FILE *fp)
>  {
>  	char sbuild_id[SBUILD_ID_SIZE];
> @@ -99,6 +123,7 @@ static int perf_session__list_build_ids(bool force, bool with_hits)
>  int cmd_buildid_list(int argc, const char **argv)
>  {
>  	bool show_kernel = false;
> +	bool show_modules = false;
>  	bool with_hits = false;
>  	bool force = false;
>  	const struct option options[] = {
> @@ -106,6 +131,8 @@ int cmd_buildid_list(int argc, const char **argv)
>  	OPT_STRING('i', "input", &input_name, "file", "input file name"),
>  	OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
>  	OPT_BOOLEAN('k', "kernel", &show_kernel, "Show current kernel build id"),
> +	OPT_BOOLEAN('m', "modules", &show_modules,
> +	    "Show build id of current kernel + modules"),
>  	OPT_INCR('v', "verbose", &verbose, "be more verbose"),
>  	OPT_END()
>  	};
> @@ -117,8 +144,12 @@ int cmd_buildid_list(int argc, const char **argv)
>  	argc = parse_options(argc, argv, options, buildid_list_usage, 0);
>  	setup_pager();
>  
> -	if (show_kernel)
> +	if (show_kernel) {
>  		return !(sysfs__fprintf_build_id(stdout) > 0);
> +	} else if (show_modules) {
> +		buildid__show_kernel_modules();
> +		return 0;
> +	}
>  
>  	return perf_session__list_build_ids(force, with_hits);
>  }
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 5ac13958d1bd..7c490b5ce449 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1227,6 +1227,19 @@ void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated)
>  	dso__set_long_name_id(dso, name, NULL, name_allocated);
>  }
>  
> +void dso__get_long_name(const struct dso *dso, char *name, size_t len)
> +{
> +	if (len == 0)
> +		return;
> +	if (dso->long_name == NULL) {
> +		name[0] = '\0';
> +		return;
> +	}
> +
> +	strncpy(name, dso->long_name, len);
> +	name[len - 1] = '\0';
> +}
> +
>  void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated)
>  {
>  	if (name == NULL)
> @@ -1359,6 +1372,16 @@ void dso__set_build_id(struct dso *dso, struct build_id *bid)
>  	dso->has_build_id = 1;
>  }
>  
> +void dso__get_build_id(struct dso *dso, struct build_id *bid)
> +{
> +	if (dso->has_build_id) {
> +		*bid = dso->bid;
> +	} else {
> +		bid->size = 0;
> +		memset(bid->data, 0, sizeof(*bid->data));
> +	}
> +}
> +
>  bool dso__build_id_equal(const struct dso *dso, struct build_id *bid)
>  {
>  	if (dso->bid.size > bid->size && dso->bid.size == BUILD_ID_SIZE) {
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 3a9fd4d389b5..896ed335b562 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -237,6 +237,7 @@ void dso__delete(struct dso *dso);
>  int dso__cmp_id(struct dso *a, struct dso *b);
>  void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated);
>  void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated);
> +void dso__get_long_name(const struct dso *dso, char *name, size_t len);
>  
>  int dso__name_len(const struct dso *dso);
>  
> @@ -263,6 +264,7 @@ void dso__set_sorted_by_name(struct dso *dso);
>  void dso__sort_by_name(struct dso *dso);
>  
>  void dso__set_build_id(struct dso *dso, struct build_id *bid);
> +void dso__get_build_id(struct dso *dso, struct build_id *bid);
>  bool dso__build_id_equal(const struct dso *dso, struct build_id *bid);
>  void dso__read_running_kernel_build_id(struct dso *dso,
>  				       struct machine *machine);
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 95391236f5f6..78e84eb037a6 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -3232,3 +3232,16 @@ int machine__for_each_dso(struct machine *machine, machine__dso_t fn, void *priv
>  	}
>  	return err;
>  }
> +
> +int machine__for_each_kernel_map(struct machine *machine, machine__map_t fn, void *priv)
> +{
> +	struct maps *maps = machine__kernel_maps(machine);
> +	struct map *map;
> +	int err = 0;
> +
> +	for (map = maps__first(maps); map != NULL; map = map__next(map)) {
> +		if (fn(map, priv))
> +			err = -1;
> +	}
> +	return err;
> +}
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index 0023165422aa..2a022259d373 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -259,6 +259,11 @@ typedef int (*machine__dso_t)(struct dso *dso, struct machine *machine, void *pr
>  
>  int machine__for_each_dso(struct machine *machine, machine__dso_t fn,
>  			  void *priv);
> +
> +typedef int (*machine__map_t)(struct map *map, void *priv);
> +int machine__for_each_kernel_map(struct machine *machine, machine__map_t fn,
> +				 void *priv);
> +
>  int machine__for_each_thread(struct machine *machine,
>  			     int (*fn)(struct thread *thread, void *p),
>  			     void *priv);
> 
> base-commit: e0c1b8f9eba88173b30ba42eb492fd20582cf376
> -- 
> 2.36.0.464.gb9c8b46e94-goog

-- 

- Arnaldo
