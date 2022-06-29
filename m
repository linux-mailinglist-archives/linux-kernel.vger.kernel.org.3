Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3491F55FC2B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiF2Jin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiF2Jil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:38:41 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDD1344F7;
        Wed, 29 Jun 2022 02:38:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id d2so19649490ejy.1;
        Wed, 29 Jun 2022 02:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k6oe5HEpSP/3PpEQG2PUO3klQcAhWUWpeHfTAN39oX0=;
        b=W4e7yR9ZG0trJJugdEemzCpLENreaJ1h95PAmwWFdXQHHGFE7e6BEeSmGWVvgNqH4Q
         9bShryjOI/WYLLQ+bRLj7jggPuoSy9yTmFaRl85Vhd7ZJ0fPlVRzgK3gCQn/pcMyFAxQ
         CiEIJxDHD3mihnof5epKKxCZrtMohEOaM363LgKgS39J867RbjrC8cEICdRBX3sTe57H
         OY9PjusZs8QDiOV0POIpulIaH2PvUYITjTmqYpSuUANuma5i8SJR7zob48r3VCL/2jRN
         89m/ZAon4H4w/UEGpGT/f2u996G5UQd0fOPlNnNLbLOteKQSutlU5dMkEhWh1Io1bO5P
         cYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k6oe5HEpSP/3PpEQG2PUO3klQcAhWUWpeHfTAN39oX0=;
        b=Q46DZoeEBn5dnMTzGh65JdHtb1j2zuP6fxs7ZcL8uM9JkDdyMpewRp8BpG08X1Nidp
         ulFFUgg8q2Hfiy3DNbOna1C0T6WmLjA66NBNW2SELDmX9Nf/zwx08CDhRFFy5FA6NEpN
         4IAgZa//thGPeDoThs74eUphxV6zTajBdaswtWovGAtTmFquL0nENGs9+bmdZ91v1Xav
         UfdffgtMMDsj9uRKv/38KL6BF7B0xCEXT4pGRB/KvpJ7ePxNu0Pff3RUwdXiZSGxTdRN
         aeIjuVRCIKUw7NgI1FOSSEl0kUwCIovTyBag+CMuXTIDOJXs8pH4ulkJLOXu7o0eULD4
         lODw==
X-Gm-Message-State: AJIora/+W08QhBDT9tyOFw8TbtlRB/sgA0TVNwGwPkEQ1+NO9ji7VZP+
        qOXik4fbsVvktyOM8gmED7Y=
X-Google-Smtp-Source: AGRyM1vBCl+JXbc4hO4FdLPbxshOfGmCJHN00UL2M4bqUQOXHUUBC+OtlfpzcwXLDb/iC2E0kQZpqw==
X-Received: by 2002:a17:907:6d99:b0:726:3668:4f2a with SMTP id sb25-20020a1709076d9900b0072636684f2amr2312436ejc.627.1656495518506;
        Wed, 29 Jun 2022 02:38:38 -0700 (PDT)
Received: from krava (net-109-116-206-47.cust.vodafonedsl.it. [109.116.206.47])
        by smtp.gmail.com with ESMTPSA id fd5-20020a056402388500b00436f3107bdasm10095675edb.38.2022.06.29.02.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 02:38:37 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 29 Jun 2022 11:38:35 +0200
To:     Blake Jones <blakejones@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] Add a "-m" option to "perf buildid-list".
Message-ID: <Yrwdm4eW+lFtByiZ@krava>
References: <20220627224116.3015376-1-blakejones@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627224116.3015376-1-blakejones@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 03:41:16PM -0700, Blake Jones wrote:
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
> 
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

nit, should we display short_name in case long_name is missing?

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

I think we should rather break in here and return user's error
other than that, the patch looks good to me

thanks,
jirka

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
> 
