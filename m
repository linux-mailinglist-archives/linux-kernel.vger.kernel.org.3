Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215034B2BBF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352169AbiBKR2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:28:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240606AbiBKR2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:28:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155712BF;
        Fri, 11 Feb 2022 09:28:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5F59B82B23;
        Fri, 11 Feb 2022 17:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40141C340EF;
        Fri, 11 Feb 2022 17:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644600488;
        bh=LK/7kZ1wCa9ctZCetD4KcUNk2hYQK+I+NhyvbffF6es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gd+FXfH0nF0oMxPJPuSCsG8ogN7gx0WiHg8kndf6TBFE6Ywa+fWinCWI6GkdSDtOf
         u0YXgmh789/xN01FMbrk2/kpLiHrI9bcDQ90VC826TlwgDO/jefwNuq8l5SpEEeMam
         zbmdc0ucjlVLgVkhzXt73t8jr0bLIIZW0uEXJ3z/POjhHwGEjg5V40SkRMvofIb263
         kbdLtDDo0SLAk91Wi/DCRtyOZe1JPwp42PP231hRSA7vvhru+p9sikCCNxgQQt3MxH
         XZpzLcHj64lB+VvPCVNUZdkrzcgji436wGVNQ0Kgm0I991ELe6Dj/1dqui2vDmzR1q
         UxqHkJOB7LYmA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 73116400FE; Fri, 11 Feb 2022 14:28:06 -0300 (-03)
Date:   Fri, 11 Feb 2022 14:28:06 -0300
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
Subject: Re: [PATCH v3 09/22] perf map: Add const to map_ip and unmap_ip
Message-ID: <Ygacpt3tdaLyTPrb@kernel.org>
References: <20220211103415.2737789-1-irogers@google.com>
 <20220211103415.2737789-10-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211103415.2737789-10-irogers@google.com>
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

Em Fri, Feb 11, 2022 at 02:34:02AM -0800, Ian Rogers escreveu:
> Functions purely determine a value from the map and don't need to modify
> it. Move functions to C file as they are most commonly used via a
> function pointer.

Builds, applied.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/map.c | 15 +++++++++++++++
>  tools/perf/util/map.h | 24 ++++++++----------------
>  2 files changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 2cfe5744b86c..b98fb000eb5c 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -563,3 +563,18 @@ struct maps *map__kmaps(struct map *map)
>  	}
>  	return kmap->kmaps;
>  }
> +
> +u64 map__map_ip(const struct map *map, u64 ip)
> +{
> +	return ip - map->start + map->pgoff;
> +}
> +
> +u64 map__unmap_ip(const struct map *map, u64 ip)
> +{
> +	return ip + map->start - map->pgoff;
> +}
> +
> +u64 identity__map_ip(const struct map *map __maybe_unused, u64 ip)
> +{
> +	return ip;
> +}
> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> index 973dce27b253..212a9468d5e1 100644
> --- a/tools/perf/util/map.h
> +++ b/tools/perf/util/map.h
> @@ -29,9 +29,9 @@ struct map {
>  	u64			reloc;
>  
>  	/* ip -> dso rip */
> -	u64			(*map_ip)(struct map *, u64);
> +	u64			(*map_ip)(const struct map *, u64);
>  	/* dso rip -> ip */
> -	u64			(*unmap_ip)(struct map *, u64);
> +	u64			(*unmap_ip)(const struct map *, u64);
>  
>  	struct dso		*dso;
>  	refcount_t		refcnt;
> @@ -44,20 +44,12 @@ struct kmap *__map__kmap(struct map *map);
>  struct kmap *map__kmap(struct map *map);
>  struct maps *map__kmaps(struct map *map);
>  
> -static inline u64 map__map_ip(struct map *map, u64 ip)
> -{
> -	return ip - map->start + map->pgoff;
> -}
> -
> -static inline u64 map__unmap_ip(struct map *map, u64 ip)
> -{
> -	return ip + map->start - map->pgoff;
> -}
> -
> -static inline u64 identity__map_ip(struct map *map __maybe_unused, u64 ip)
> -{
> -	return ip;
> -}
> +/* ip -> dso rip */
> +u64 map__map_ip(const struct map *map, u64 ip);
> +/* dso rip -> ip */
> +u64 map__unmap_ip(const struct map *map, u64 ip);
> +/* Returns ip */
> +u64 identity__map_ip(const struct map *map __maybe_unused, u64 ip);
>  
>  static inline size_t map__size(const struct map *map)
>  {
> -- 
> 2.35.1.265.g69c8d7142f-goog

-- 

- Arnaldo
