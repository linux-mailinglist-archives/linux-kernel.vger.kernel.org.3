Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42684B2B83
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345371AbiBKRNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:13:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352010AbiBKRNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:13:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E208D102;
        Fri, 11 Feb 2022 09:13:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D2A361ACA;
        Fri, 11 Feb 2022 17:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF387C340E9;
        Fri, 11 Feb 2022 17:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644599628;
        bh=hLI++bbFRo+eerzKnpdCJJ+7tVu4buscw5+N3RMzt28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHk4P2GbzQlNn/ZUxRoQHJpryRsALMrTmeHIKSWAGnlihM2w5iKTImlB4rCtje2gu
         u/4pYWQUAHg4xMJMuVdJJKyjLE/ujS5lbRArqzOYLn8AGnaeKI78ZykU76Kdg36dsv
         9prklqqyiFCzH61qs1B0rInPE8EZbWoDMZwPvxVg7d+jVlgIOS+OAN/EL4wb8mSmZu
         Mr33PSEGu+xLN5ECov7F5Km4yflMAeXew6atvHuvO7uCIm89jS6MRbj9a0/Pa6ISWV
         mqXHgeeFCTVa+rcDI9OMqcrnQl/OHjn6raD3sPRiOPl8rPebi2xpzDZx6jDBVeMnQx
         s01crtOQkP38A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C944D400FE; Fri, 11 Feb 2022 14:13:46 -0300 (-03)
Date:   Fri, 11 Feb 2022 14:13:46 -0300
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
Subject: Re: [PATCH v3 03/22] perf dso: Make lock error check and add BUG_ONs
Message-ID: <YgaZSk8h6rQ6MgLy@kernel.org>
References: <20220211103415.2737789-1-irogers@google.com>
 <20220211103415.2737789-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211103415.2737789-4-irogers@google.com>
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

Em Fri, Feb 11, 2022 at 02:33:56AM -0800, Ian Rogers escreveu:
> Make the pthread mutex on dso use the error check type. This allows
> deadlock checking via the return type. Assert the returned value from
> mutex lock is always 0.

I think this is too blunt/pervasive source code wise, perhaps we should
wrap this like its done with rwsem in tools/perf/util/rwsem.h to get
away from pthreads primitives and make the source code look more like
a kernel one and then, taking advantage of the so far ideologic
needless indirection, add this BUG_ON if we build with "DEBUG=1" or
something, wdyt?

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/dso.c    | 12 +++++++++---
>  tools/perf/util/symbol.c |  2 +-
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 9cc8a1772b4b..6beccffeef7b 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -784,7 +784,7 @@ dso_cache__free(struct dso *dso)
>  	struct rb_root *root = &dso->data.cache;
>  	struct rb_node *next = rb_first(root);
>  
> -	pthread_mutex_lock(&dso->lock);
> +	BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
>  	while (next) {
>  		struct dso_cache *cache;
>  
> @@ -830,7 +830,7 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
>  	struct dso_cache *cache;
>  	u64 offset = new->offset;
>  
> -	pthread_mutex_lock(&dso->lock);
> +	BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
>  	while (*p != NULL) {
>  		u64 end;
>  
> @@ -1259,6 +1259,8 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
>  	struct dso *dso = calloc(1, sizeof(*dso) + strlen(name) + 1);
>  
>  	if (dso != NULL) {
> +		pthread_mutexattr_t lock_attr;
> +
>  		strcpy(dso->name, name);
>  		if (id)
>  			dso->id = *id;
> @@ -1286,8 +1288,12 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
>  		dso->root = NULL;
>  		INIT_LIST_HEAD(&dso->node);
>  		INIT_LIST_HEAD(&dso->data.open_entry);
> -		pthread_mutex_init(&dso->lock, NULL);
> +		pthread_mutexattr_init(&lock_attr);
> +		pthread_mutexattr_settype(&lock_attr, PTHREAD_MUTEX_ERRORCHECK);
> +		pthread_mutex_init(&dso->lock, &lock_attr);
> +		pthread_mutexattr_destroy(&lock_attr);
>  		refcount_set(&dso->refcnt, 1);
> +
>  	}
>  
>  	return dso;
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index b2ed3140a1fa..43f47532696f 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1783,7 +1783,7 @@ int dso__load(struct dso *dso, struct map *map)
>  	}
>  
>  	nsinfo__mountns_enter(dso->nsinfo, &nsc);
> -	pthread_mutex_lock(&dso->lock);
> +	BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
>  
>  	/* check again under the dso->lock */
>  	if (dso__loaded(dso)) {
> -- 
> 2.35.1.265.g69c8d7142f-goog

-- 

- Arnaldo
