Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFD54B34B4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 12:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbiBLLas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 06:30:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiBLLao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 06:30:44 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB5F26AF7;
        Sat, 12 Feb 2022 03:30:41 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id b13so20209282edn.0;
        Sat, 12 Feb 2022 03:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jv0WkmIUjrG0tZLaVODfh5nXkUsmipBvXV3pTw4nVB4=;
        b=flKURlaklL4NiuZTeoLBvt76QwlB9aUz+yVSmZVdD+ujOuGBev2+8jiYhcg4Qxxv8X
         IhPLBNq43kCL8RH1LIds83VioghMFPaaRJ/MW9coKEj4zChgrV1FvNKNZjOi1tXFIeD/
         gYP1hQneiXzyBIVI0evC57kstrM3czOu6eKTleaur99LTZF2bkvmJ7zFuV9Rb8FDItQK
         3gb2PEvDlZ2p1U4js227dEtN8EzG5sWqCFCnse4QR45xCejpfC7thmzDjrtz9pRzec9G
         fY4WCSF/8yMvYUXatkE30oGatZkQ1vz1fpU3eLDLR1NMO8B4k30oVQf2Vh2SUi36XnXz
         cljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jv0WkmIUjrG0tZLaVODfh5nXkUsmipBvXV3pTw4nVB4=;
        b=BZphEo8pJ1lG2q7OH49jtmH+ANd1QgsJ6Xz/omx7fcdjqmtr2ZV29JeMae2x6f4Ca1
         eBOuwJiwmKwgS9LIzL7DDzdgxl83Hby37unTywEdY0sCiUONC+aCtIk8zwCL03v1Z3Ll
         qgrLBzuPQNyE09K2/H/Thptf4BP16PBfglPOF/ZGG951i9FzkEd7pZI1NZp+QKi5pPWt
         99o2pWrwZ9sWxVY8xfjOOXhHleQytFpt+i5w2PgLX/ai90CATVGW7ROMv6L9t46hFsb6
         Qd1FWLKbCo4f9bLG8QnfMNyXIK2GMCW4l5cDTmQKQjrPPRQKg/b7Ww8yo2v+jXQTn3Lw
         maeg==
X-Gm-Message-State: AOAM530a6uWvC7bi5TQFKoEVbRSQbxEL9t4XQ7Zc0p1dv3tauPN3ZnQ8
        sOUccteO/trKgrNDhYEkpgw=
X-Google-Smtp-Source: ABdhPJznHyQt9g/DcKeFUCs3n8YJ/YRlv6aOnl4GQ/sq9iWdPX9RtG4L7QYgO0K/y8pFU8zyXQIP6g==
X-Received: by 2002:a05:6402:3514:: with SMTP id b20mr6262194edd.65.1644665439686;
        Sat, 12 Feb 2022 03:30:39 -0800 (PST)
Received: from krava ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id q7sm5608620ejj.8.2022.02.12.03.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 03:30:39 -0800 (PST)
Date:   Sat, 12 Feb 2022 12:30:35 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
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
Subject: Re: [PATCH v3 04/22] perf dso: Hold lock when accessing nsinfo
Message-ID: <YgeaW4K5XY/66afx@krava>
References: <20220211103415.2737789-1-irogers@google.com>
 <20220211103415.2737789-5-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211103415.2737789-5-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 02:33:57AM -0800, Ian Rogers wrote:
> There may be threads racing to update dso->nsinfo:
> https://lore.kernel.org/linux-perf-users/CAP-5=fWZH20L4kv-BwVtGLwR=Em3AOOT+Q4QGivvQuYn5AsPRg@mail.gmail.com/
> Holding the dso->lock avoids use-after-free, memory leaks and other
> such bugs. Apply the fix in:
> https://lore.kernel.org/linux-perf-users/20211118193714.2293728-1-irogers@google.com/
> of there being a missing nsinfo__put now that the accesses are data race
> free.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-inject.c   | 4 ++++
>  tools/perf/util/dso.c         | 5 ++++-
>  tools/perf/util/map.c         | 3 +++
>  tools/perf/util/probe-event.c | 2 ++
>  tools/perf/util/symbol.c      | 2 +-
>  5 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index fbf43a454cba..bede332bf0e2 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -363,8 +363,10 @@ static struct dso *findnew_dso(int pid, int tid, const char *filename,
>  	}
>  
>  	if (dso) {
> +		BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
>  		nsinfo__put(dso->nsinfo);
>  		dso->nsinfo = nsi;
> +		pthread_mutex_unlock(&dso->lock);
>  	} else
>  		nsinfo__put(nsi);
>  
> @@ -547,7 +549,9 @@ static int dso__read_build_id(struct dso *dso)
>  	if (dso->has_build_id)
>  		return 0;
>  
> +	BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
>  	nsinfo__mountns_enter(dso->nsinfo, &nsc);
> +	pthread_mutex_unlock(&dso->lock);

so this separates nsinfo__mountns_enter and nsinfo__put,
should we care also about nsinfo__mountns_exit?

jirka

>  	if (filename__read_build_id(dso->long_name, &dso->bid) > 0)
>  		dso->has_build_id = true;
>  	nsinfo__mountns_exit(&nsc);
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 6beccffeef7b..b2f570adba35 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -548,8 +548,11 @@ static int open_dso(struct dso *dso, struct machine *machine)
>  	int fd;
>  	struct nscookie nsc;
>  
> -	if (dso->binary_type != DSO_BINARY_TYPE__BUILD_ID_CACHE)
> +	if (dso->binary_type != DSO_BINARY_TYPE__BUILD_ID_CACHE) {
> +		BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
>  		nsinfo__mountns_enter(dso->nsinfo, &nsc);
> +		pthread_mutex_unlock(&dso->lock);
> +	}
>  	fd = __open_dso(dso, machine);
>  	if (dso->binary_type != DSO_BINARY_TYPE__BUILD_ID_CACHE)
>  		nsinfo__mountns_exit(&nsc);
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 8af693d9678c..ae99b52502d5 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -192,7 +192,10 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>  			if (!(prot & PROT_EXEC))
>  				dso__set_loaded(dso);
>  		}
> +		BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
> +		nsinfo__put(dso->nsinfo);
>  		dso->nsinfo = nsi;
> +		pthread_mutex_unlock(&dso->lock);
>  
>  		if (build_id__is_defined(bid))
>  			dso__set_build_id(dso, bid);
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index a834918a0a0d..7444e689ece7 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -180,8 +180,10 @@ struct map *get_target_map(const char *target, struct nsinfo *nsi, bool user)
>  
>  		map = dso__new_map(target);
>  		if (map && map->dso) {
> +			BUG_ON(pthread_mutex_lock(&map->dso->lock) != 0);
>  			nsinfo__put(map->dso->nsinfo);
>  			map->dso->nsinfo = nsinfo__get(nsi);
> +			pthread_mutex_unlock(&map->dso->lock);
>  		}
>  		return map;
>  	} else {
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 43f47532696f..a504346feb05 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1774,6 +1774,7 @@ int dso__load(struct dso *dso, struct map *map)
>  	char newmapname[PATH_MAX];
>  	const char *map_path = dso->long_name;
>  
> +	BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
>  	perfmap = strncmp(dso->name, "/tmp/perf-", 10) == 0;
>  	if (perfmap) {
>  		if (dso->nsinfo && (dso__find_perf_map(newmapname,
> @@ -1783,7 +1784,6 @@ int dso__load(struct dso *dso, struct map *map)
>  	}
>  
>  	nsinfo__mountns_enter(dso->nsinfo, &nsc);
> -	BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
>  
>  	/* check again under the dso->lock */
>  	if (dso__loaded(dso)) {
> -- 
> 2.35.1.265.g69c8d7142f-goog
> 
