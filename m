Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDBC562E13
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbiGAIZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbiGAIZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:25:28 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C7174DFE;
        Fri,  1 Jul 2022 01:23:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id o25so2717298ejm.3;
        Fri, 01 Jul 2022 01:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vWrFQuOWDjGJDXFkn6Ee2cPfT0NEVvQcuVBzCjDLFCY=;
        b=ge2gVLgOqGrsbCfJ0W4Q92+08eouugRkP8axSr1k/c+O1kDvRfhk7J7CzQ5/iCkAGV
         mfo79nniFkwlYj0XY3KB/5oyUV6UQJ54U8zVi7syrsu8yrSMP+4iknmdILLUL55gwU3I
         LbUgM7bZrxh7C0z8L6D1p39quHo0NsQ/kHNsm0m6FW1733bIBbahro9H+6SfXY+OFJ2y
         jb3gLnPQyNbRIW1B9nef272/hXSpntv6AEcHB7cGuX5DqGi5tuGDokA5pWkpH720Et1l
         yVMlTbwgUy7o2nXDf+8VdcPbiFXBfT9CL3UsjkbZ2QT82fq0SsOazCfUltoErcNijFTy
         A73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vWrFQuOWDjGJDXFkn6Ee2cPfT0NEVvQcuVBzCjDLFCY=;
        b=6N5FoheLNcKWckNvmKjifPtTKwDwrEDvIItuU7BKfZiEj10ahu5zjrdWrChOWx8rGI
         9jHhR0aqTVtnmzilLsl5N5/g9ZiO0S/d1zN9EGXA15Eyi4CcHTI0snsFcj75OzgPwzCG
         7ycmAFAWVL8bpITKBEPI4+WNZRA7IrCUI1c0ijxs0i2RmUuGxMo2udVsDCh+StOWlONI
         YxTQ59fPaDZe4qBI0KbZqfklrxcBTr8/DEGv7Wsri9gWopslfublhWj3LcikQktmvniQ
         uq5/RC4JsfWOkx244ar3jwgyXSOgmw7s3XMmoaCeu7qznjDbmB+jp/vTomcc91gnxGmh
         DdqQ==
X-Gm-Message-State: AJIora9cxgEs9l/GmsMkjo444kSr8l7231avvhP4qq43d3PjgDRHvXT+
        4DrEqsma9fQ19h2Vi5q2jkM=
X-Google-Smtp-Source: AGRyM1ustAfD4AUnC7cGTCIfzAsHscqrkcHN4XNBYePKgaGKEPlBcOTfoo9pa9T5+W7IGYyhkP1ygw==
X-Received: by 2002:a17:907:eaa:b0:726:a3ab:f000 with SMTP id ho42-20020a1709070eaa00b00726a3abf000mr13530930ejc.382.1656663810423;
        Fri, 01 Jul 2022 01:23:30 -0700 (PDT)
Received: from krava ([151.8.209.42])
        by smtp.gmail.com with ESMTPSA id kw7-20020a170907770700b0072a815f3344sm988146ejc.137.2022.07.01.01.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:23:29 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 1 Jul 2022 10:23:26 +0200
To:     Blake Jones <blakejones@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Add a "-m" option to "perf buildid-list".
Message-ID: <Yr6u/jdLvg2TcT8s@krava>
References: <20220629213632.3899212-1-blakejones@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629213632.3899212-1-blakejones@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 02:36:32PM -0700, Blake Jones wrote:
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

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  .../perf/Documentation/perf-buildid-list.txt  |  4 ++
>  tools/perf/builtin-buildid-list.c             | 38 ++++++++++++++++++-
>  tools/perf/util/machine.c                     | 15 ++++++++
>  tools/perf/util/machine.h                     |  5 +++
>  4 files changed, 61 insertions(+), 1 deletion(-)
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
> index cebadd632234..cffca6a536e9 100644
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
> @@ -20,6 +21,34 @@
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
> +	if (dso->long_name != NULL) {
> +		printf(" %s", dso->long_name);
> +	} else if (dso->short_name != NULL) {
> +		printf(" %s", dso->short_name);
> +	}
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
> @@ -99,6 +128,7 @@ static int perf_session__list_build_ids(bool force, bool with_hits)
>  int cmd_buildid_list(int argc, const char **argv)
>  {
>  	bool show_kernel = false;
> +	bool show_kernel_maps = false;
>  	bool with_hits = false;
>  	bool force = false;
>  	const struct option options[] = {
> @@ -106,6 +136,8 @@ int cmd_buildid_list(int argc, const char **argv)
>  	OPT_STRING('i', "input", &input_name, "file", "input file name"),
>  	OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
>  	OPT_BOOLEAN('k', "kernel", &show_kernel, "Show current kernel build id"),
> +	OPT_BOOLEAN('m', "kernel-maps", &show_kernel_maps,
> +	    "Show build id of current kernel + modules"),
>  	OPT_INCR('v', "verbose", &verbose, "be more verbose"),
>  	OPT_END()
>  	};
> @@ -117,8 +149,12 @@ int cmd_buildid_list(int argc, const char **argv)
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
> index 009061852808..16d225149b93 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -3327,3 +3327,18 @@ int machine__for_each_dso(struct machine *machine, machine__dso_t fn, void *priv
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
> +		err = fn(map, priv);
> +		if (err != 0) {
> +			break;
> +		}
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
> 2.37.0.rc0.161.g10f37bed90-goog
> 
