Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F98A4B2BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352128AbiBKR3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:29:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352118AbiBKR26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:28:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A73D2C6;
        Fri, 11 Feb 2022 09:28:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1367F6104E;
        Fri, 11 Feb 2022 17:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0D4C340E9;
        Fri, 11 Feb 2022 17:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644600536;
        bh=GF0DIBc7aK0kQJt5C0tlOnogc8fvhWW9ChMrLDTsQnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KpeLLhujt8rJTOsyLP2ftJEZ63vHFx/RaFoNiAIXaQTX8XKtNIqKMP7LTbLIPg5qm
         L5nbZHO0WFEpkEFLHnX/CivPogx6tc3POJApZ6onjHyo7nkKIga117KOT0/+vcxGUK
         W+zfDvs/5+ededQ4gBYYggxthdMh23f7a40xO4VELnUJfEBjYT4ItLQE49ND7FyBe9
         aDS7vEfLYHdgoHbVrJc3XOK5AR7c8zs2+5Hf6ebYD+UJhMlgDMWb0YvctpCGMYB2F+
         LJrSf13pIsuJfEeH87y6B/ApzvJA6p/A1J8aop0Kt+QTJsllzWgQQIQEJF64x2M42B
         WJxYyCb/AjMpA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B2AB2400FE; Fri, 11 Feb 2022 14:28:54 -0300 (-03)
Date:   Fri, 11 Feb 2022 14:28:54 -0300
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
Subject: Re: [PATCH v3 10/22] perf map: Make map__contains_symbol args const
Message-ID: <Ygac1qqTB4Jio9Cg@kernel.org>
References: <20220211103415.2737789-1-irogers@google.com>
 <20220211103415.2737789-11-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211103415.2737789-11-irogers@google.com>
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

Em Fri, Feb 11, 2022 at 02:34:03AM -0800, Ian Rogers escreveu:
> Now unmap_ip is const, make contains symbol const.

Not applying, waiting for a refresh of this patch set after the subset
that has been applied.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/map.c | 2 +-
>  tools/perf/util/map.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index b98fb000eb5c..8bbf9246a3cf 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -516,7 +516,7 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
>  	return ip + map->reloc;
>  }
>  
> -bool map__contains_symbol(struct map *map, struct symbol *sym)
> +bool map__contains_symbol(const struct map *map, const struct symbol *sym)
>  {
>  	u64 ip = map->unmap_ip(map, sym->start);
>  
> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> index 212a9468d5e1..3dcfe06db6b3 100644
> --- a/tools/perf/util/map.h
> +++ b/tools/perf/util/map.h
> @@ -152,7 +152,7 @@ static inline bool __map__is_kmodule(const struct map *map)
>  
>  bool map__has_symbols(const struct map *map);
>  
> -bool map__contains_symbol(struct map *map, struct symbol *sym);
> +bool map__contains_symbol(const struct map *map, const struct symbol *sym);
>  
>  #define ENTRY_TRAMPOLINE_NAME "__entry_SYSCALL_64_trampoline"
>  
> -- 
> 2.35.1.265.g69c8d7142f-goog

-- 

- Arnaldo
