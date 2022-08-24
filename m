Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A0859FB64
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbiHXNam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237364AbiHXNab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:30:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134BD564C9;
        Wed, 24 Aug 2022 06:30:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A555261724;
        Wed, 24 Aug 2022 13:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5069C433D6;
        Wed, 24 Aug 2022 13:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661347829;
        bh=YFeuufGJjRCEIZJE99oiG+vmcFrF+tjiY5Sdh7Go5hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mdvwLe/dtuo98a0/fKoG2NsWq4jSpVvOh1jp0klUT3v6r3bMekCV1aJ1uAeAi5y0g
         O7xR7PHjY2QKpuru8pyN8QrGMB4pCpvAt0DA4C7QL8Uve5wzbrFHnExfgFky19KuCt
         1VV27OD+7MZ2yQZ+FCIEPgS6lxL0TuC24s17pqaVWuIGBvg0ZGfvaSNhZcoSMR6UDe
         0V3vr2nALWL6II5t/ZCHYV0PaIF+/oFEnxLWVELZZ/LnWYj7CC5UhpkYxiDAr0xKTw
         nRDA2FF5eqO2dmzdUB7rV7T2ARoKiYdVKigt+XnVm90PEDrGGQ2m9IwOR0t0YKHtAZ
         Cm6e7tDrcsLMA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5F04F404A1; Wed, 24 Aug 2022 10:30:26 -0300 (-03)
Date:   Wed, 24 Aug 2022 10:30:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf hashmap: Tidy hashmap dependency
Message-ID: <YwYn8i6Gy58IKqGm@kernel.org>
References: <20220824050604.352156-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824050604.352156-1-irogers@google.com>
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

Em Tue, Aug 23, 2022 at 10:06:04PM -0700, Ian Rogers escreveu:
> When libbpf is present the build uses definitions in libbpf hashmap.c,
> however, libbpf's hashmap.h wasn't being used. Switch to using the
> correct hashmap.h dependent on the define HAVE_LIBBPF_SUPPORT. This
> was the original intent in:
> https://lore.kernel.org/lkml/20200515221732.44078-8-irogers@google.com/

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/bpf-loader.c |  6 +++++-
>  tools/perf/util/evsel.c      |  6 +++++-
>  tools/perf/util/expr.h       | 11 ++++-------
>  tools/perf/util/stat.c       |  6 +++++-
>  4 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> index e2052f4fed33..d657594894cf 100644
> --- a/tools/perf/util/bpf-loader.c
> +++ b/tools/perf/util/bpf-loader.c
> @@ -27,7 +27,11 @@
>  #include "util.h"
>  #include "llvm-utils.h"
>  #include "c++/clang-c.h"
> -#include "hashmap.h"
> +#ifdef HAVE_LIBBPF_SUPPORT
> +#include <bpf/hashmap.h>
> +#else
> +#include "util/hashmap.h"
> +#endif
>  #include "asm/bug.h"
>  
>  #include <internal/xyarray.h>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 4852089e1d79..14846b7edb17 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -46,7 +46,11 @@
>  #include "string2.h"
>  #include "memswap.h"
>  #include "util.h"
> -#include "hashmap.h"
> +#ifdef HAVE_LIBBPF_SUPPORT
> +#include <bpf/hashmap.h>
> +#else
> +#include "util/hashmap.h"
> +#endif
>  #include "pmu-hybrid.h"
>  #include "off_cpu.h"
>  #include "../perf-sys.h"
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index bd2116983bbb..0403a92d9dcc 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -2,14 +2,11 @@
>  #ifndef PARSE_CTX_H
>  #define PARSE_CTX_H 1
>  
> -// There are fixes that need to land upstream before we can use libbpf's headers,
> -// for now use our copy unconditionally, since the data structures at this point
> -// are exactly the same, no problem.
> -//#ifdef HAVE_LIBBPF_SUPPORT
> -//#include <bpf/hashmap.h>
> -//#else
> +#ifdef HAVE_LIBBPF_SUPPORT
> +#include <bpf/hashmap.h>
> +#else
>  #include "util/hashmap.h"
> -//#endif
> +#endif
>  
>  struct metric_ref;
>  
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 0882b4754fcf..ce5e9e372fc4 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -14,7 +14,11 @@
>  #include "evlist.h"
>  #include "evsel.h"
>  #include "thread_map.h"
> -#include "hashmap.h"
> +#ifdef HAVE_LIBBPF_SUPPORT
> +#include <bpf/hashmap.h>
> +#else
> +#include "util/hashmap.h"
> +#endif
>  #include <linux/zalloc.h>
>  
>  void update_stats(struct stats *stats, u64 val)
> -- 
> 2.37.2.609.g9ff673ca1a-goog

-- 

- Arnaldo
