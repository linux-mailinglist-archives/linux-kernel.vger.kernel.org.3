Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084D65785C2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbiGROuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGROu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:50:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F1A1401A;
        Mon, 18 Jul 2022 07:50:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E409B81616;
        Mon, 18 Jul 2022 14:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF43FC341C0;
        Mon, 18 Jul 2022 14:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658155826;
        bh=BhYFCVA7dpyOPmNpW0wkDUPxPDs6vHeHXBug41P4VaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iVqF+HbsqYpoEpwyllLcfNKQOh6gW/yXWxhAg6ErVDQ1Me1yvR81Cdvh6UVjW8yQJ
         YVxERx7H02qbPtQVxvFEI/Mxfgn1F8l6+ALlbiF/yKT/GoS0cfYOR/m4EYZ0kHT0bN
         U6emKMoQSfPCDr2+yQ0UebW4qCKWMHNbUuhezMI5VSz25Hj440XZLWKRKVqVw+Xno+
         qIbN3hg8VjZFgcts6UJQigiB7dibbAQ1t5nsHOWuM47AcqImtk0IDEegSWobikMoXZ
         5jChYN7jDOiBfeWRAg0xstV5NhY9efuHQZ+ZTBs7ELjWqo4/+wLnDggnOurCyNx9wh
         DI+l8MDB+ulCw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AF97840374; Mon, 18 Jul 2022 11:50:22 -0300 (-03)
Date:   Mon, 18 Jul 2022 11:50:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Blake Jones <blakejones@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Add a "-m" option to "perf buildid-list".
Message-ID: <YtVzLodaUYIou7JQ@kernel.org>
References: <20220615001334.611882-1-blakejones@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615001334.611882-1-blakejones@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 14, 2022 at 05:13:34PM -0700, Blake Jones escreveu:
> This new option displays all of the information needed to do external
> BuildID-based symbolization of kernel stack traces, such as those collected
> by bpf_get_stackid(). For each kernel module plus the main kernel, it
> displays the BuildID, the start and end virtual addresses of that module's
> text range (rounded out to page boundaries), and the pathname of the
> module.
> 
> When run as a non-privileged user, the actual addresses of the modules'
> text ranges are not available, so the tools displays "0, <text length>" for
> kernel modules and "0, 0xffffffffffffffff" for the kernel itself.
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

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Blake Jones <blakejones@google.com>
> ---
>  .../perf/Documentation/perf-buildid-list.txt  |  4 +++
>  tools/perf/builtin-buildid-list.c             | 35 ++++++++++++++++++-
>  tools/perf/util/machine.c                     | 13 +++++++
>  tools/perf/util/machine.h                     |  5 +++
>  4 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-buildid-list.txt b/tools/perf/Documentation/perf-buildid-list.txt
> index 25c52efcc7f0..e1e8fdbe06b9 100644
> --- a/tools/perf/Documentation/perf-buildid-list.txt
> +++ b/tools/perf/Documentation/perf-buildid-list.txt
> @@ -33,6 +33,10 @@ OPTIONS
>  -k::
>  --kernel::
>  	Show running kernel build id.
> +-m::
> +--kernel-maps::
> +	Show buildid, start/end text address, and path of running kernel and
> +	its modules.
>  -v::
>  --verbose::
>  	Be more verbose.
> diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
> index cebadd632234..e73520190974 100644
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
> @@ -20,6 +21,31 @@
>  #include <errno.h>
>  #include <linux/err.h>
>  
> +static int buildid__map_cb(struct map *map, void *arg __maybe_unused)
> +{
> +	const struct dso *dso = map->dso;
> +	char bid_buf[SBUILD_ID_SIZE];
> +
> +	memset(bid_buf, 0, sizeof(bid_buf));
> +	if (dso->has_build_id)
> +		build_id__sprintf(&dso->bid, bid_buf);
> +	printf("%s %16lx %16lx", bid_buf, map->start, map->end);
> +	if (dso->long_name != NULL)
> +		printf(" %s", dso->long_name);
> +	printf("\n");
> +
> +	return 0;
> +}
> +
> +static void buildid__show_kernel_maps(void)
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
> @@ -99,6 +125,7 @@ static int perf_session__list_build_ids(bool force, bool with_hits)
>  int cmd_buildid_list(int argc, const char **argv)
>  {
>  	bool show_kernel = false;
> +	bool show_kernel_maps = false;
>  	bool with_hits = false;
>  	bool force = false;
>  	const struct option options[] = {
> @@ -106,6 +133,8 @@ int cmd_buildid_list(int argc, const char **argv)
>  	OPT_STRING('i', "input", &input_name, "file", "input file name"),
>  	OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
>  	OPT_BOOLEAN('k', "kernel", &show_kernel, "Show current kernel build id"),
> +	OPT_BOOLEAN('m', "kernel-maps", &show_kernel_maps,
> +	    "Show build id of current kernel + modules"),
>  	OPT_INCR('v', "verbose", &verbose, "be more verbose"),
>  	OPT_END()
>  	};
> @@ -117,8 +146,12 @@ int cmd_buildid_list(int argc, const char **argv)
>  	argc = parse_options(argc, argv, options, buildid_list_usage, 0);
>  	setup_pager();
>  
> -	if (show_kernel)
> +	if (show_kernel) {
>  		return !(sysfs__fprintf_build_id(stdout) > 0);
> +	} else if (show_kernel_maps) {
> +		buildid__show_kernel_maps();
> +		return 0;
> +	}
>  
>  	return perf_session__list_build_ids(force, with_hits);
>  }
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 009061852808..28fff9a02ab0 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -3327,3 +3327,16 @@ int machine__for_each_dso(struct machine *machine, machine__dso_t fn, void *priv
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
> index 5d7daf7cb7bc..e1476343cbb2 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -262,6 +262,11 @@ typedef int (*machine__dso_t)(struct dso *dso, struct machine *machine, void *pr
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
> base-commit: 1bcca2b1bd67f3c0e5c3a88ed16c6389f01a5b31
> -- 
> 2.36.1.476.g0c4daa206d-goog

-- 

- Arnaldo
