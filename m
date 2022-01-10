Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0160D48A15A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343723AbiAJVDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:03:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51258 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239741AbiAJVDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:03:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4894EB8107D;
        Mon, 10 Jan 2022 21:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A986CC36AE9;
        Mon, 10 Jan 2022 21:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641848587;
        bh=AD4dVJVe8at8uwWCEmd7hOg8NubblSQq5w4iLskvH+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ObFdKKf75tSif71up58WTM5O5EMAlL9lhky2+vLsvZkCa4tF2GmKL6tnyLqmcJyE0
         S3H+ZsmwP34mfVuGtMhg8TM8X41/nQbRREeMIU2ZGa6M0u/5PTLc5oWmrlQ+Plbz37
         iw8Efj2XyfTY0n4Ne/aQSWkWd0Omz9nJRoaCjyalRkoHdjxQ15DO54wTxARnXpQ5CY
         RqwyN4HUJWnyMyvVoux/BMYO32tSgDkY82Hi++k2m2eFVOekoSQ2NccaQ34Z95aKEb
         ROqP8ZeInrbGSAhRqQU4BKU92H+0o6h0WCFvM1zNtC175KOiygQGnPk6hM8DX35pxn
         QLKehabnWGPWQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BBFE340714; Mon, 10 Jan 2022 18:03:04 -0300 (-03)
Date:   Mon, 10 Jan 2022 18:03:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com,
        eranian@google.com
Subject: Re: [PATCH v3 06/48] perf cpumap: Switch cpu_map__build_map to cpu
 function
Message-ID: <YdyfCN1/JWJtJHTO@kernel.org>
References: <20211230072030.302559-1-irogers@google.com>
 <20211230072030.302559-8-irogers@google.com>
 <YdybPJKjqx6zb28/@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdybPJKjqx6zb28/@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 10, 2022 at 05:46:52PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Dec 29, 2021 at 11:19:48PM -0800, Ian Rogers escreveu:
> > Avoid error prone cpu_map + idx variant. Remove now unused functions.
> 
> At this point we need to remove the now unused perf_env__get_cpu(), and
> then deal with the fallout in the following patches that needlessly
> modify this unused function.
> 
> Doing that now.

Done, force pushed to tmp.perf/perf_cpu, now it is going again thru the
build containers, a better start now:

[perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.100.2/perf/perf-5.16.0.tar.xz
[perfbuilder@five ~]$ time dm
   1    95.61 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
   2    56.18 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
   3: alpine:3.5


- Arnaldo
 
> ⬢[acme@toolbox perf]$ git diff
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 6b985abaa2d22c58..40cb3518f27e2309 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1477,22 +1477,6 @@ static void perf_stat__exit_aggr_mode(void)
>         stat_config.cpus_aggr_map = NULL;
>  }
> 
> -static inline int perf_env__get_cpu(void *data, struct perf_cpu_map *map, int idx)
> -{
> -       struct perf_env *env = data;
> -       int cpu;
> -
> -       if (idx > map->nr)
> -               return -1;
> -
> -       cpu = map->map[idx];
> -
> -       if (cpu >= env->nr_cpus_avail)
> -               return -1;
> -
> -       return cpu;
> -}
> -
>  static struct aggr_cpu_id perf_env__get_socket_aggr_by_cpu(int cpu, void *data)
>  {
>         struct perf_env *env = data;
>  
> > Reviewed-by: James Clark <james.clark@arm.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-stat.c | 28 ++++------------------------
> >  tools/perf/util/cpumap.c  | 12 ++++++------
> >  tools/perf/util/cpumap.h  |  2 +-
> >  3 files changed, 11 insertions(+), 31 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 9791ae9b1a53..6b985abaa2d2 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -1504,11 +1504,6 @@ static struct aggr_cpu_id perf_env__get_socket_aggr_by_cpu(int cpu, void *data)
> >  	return id;
> >  }
> >  
> > -static struct aggr_cpu_id perf_env__get_socket(struct perf_cpu_map *map, int idx, void *data)
> > -{
> > -	return perf_env__get_socket_aggr_by_cpu(perf_env__get_cpu(data, map, idx), data);
> > -}
> > -
> >  static struct aggr_cpu_id perf_env__get_die_aggr_by_cpu(int cpu, void *data)
> >  {
> >  	struct perf_env *env = data;
> > @@ -1527,11 +1522,6 @@ static struct aggr_cpu_id perf_env__get_die_aggr_by_cpu(int cpu, void *data)
> >  	return id;
> >  }
> >  
> > -static struct aggr_cpu_id perf_env__get_die(struct perf_cpu_map *map, int idx, void *data)
> > -{
> > -	return perf_env__get_die_aggr_by_cpu(perf_env__get_cpu(data, map, idx), data);
> > -}
> > -
> >  static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(int cpu, void *data)
> >  {
> >  	struct perf_env *env = data;
> > @@ -1551,11 +1541,6 @@ static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(int cpu, void *data)
> >  	return id;
> >  }
> >  
> > -static struct aggr_cpu_id perf_env__get_core(struct perf_cpu_map *map, int idx, void *data)
> > -{
> > -	return perf_env__get_core_aggr_by_cpu(perf_env__get_cpu(data, map, idx), data);
> > -}
> > -
> >  static struct aggr_cpu_id perf_env__get_node_aggr_by_cpu(int cpu, void *data)
> >  {
> >  	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
> > @@ -1564,33 +1549,28 @@ static struct aggr_cpu_id perf_env__get_node_aggr_by_cpu(int cpu, void *data)
> >  	return id;
> >  }
> >  
> > -static struct aggr_cpu_id perf_env__get_node(struct perf_cpu_map *map, int idx, void *data)
> > -{
> > -	return perf_env__get_node_aggr_by_cpu(perf_env__get_cpu(data, map, idx), data);
> > -}
> > -
> >  static int perf_env__build_socket_map(struct perf_env *env, struct perf_cpu_map *cpus,
> >  				      struct cpu_aggr_map **sockp)
> >  {
> > -	return cpu_map__build_map(cpus, sockp, perf_env__get_socket, env);
> > +	return cpu_map__build_map(cpus, sockp, perf_env__get_socket_aggr_by_cpu, env);
> >  }
> >  
> >  static int perf_env__build_die_map(struct perf_env *env, struct perf_cpu_map *cpus,
> >  				   struct cpu_aggr_map **diep)
> >  {
> > -	return cpu_map__build_map(cpus, diep, perf_env__get_die, env);
> > +	return cpu_map__build_map(cpus, diep, perf_env__get_die_aggr_by_cpu, env);
> >  }
> >  
> >  static int perf_env__build_core_map(struct perf_env *env, struct perf_cpu_map *cpus,
> >  				    struct cpu_aggr_map **corep)
> >  {
> > -	return cpu_map__build_map(cpus, corep, perf_env__get_core, env);
> > +	return cpu_map__build_map(cpus, corep, perf_env__get_core_aggr_by_cpu, env);
> >  }
> >  
> >  static int perf_env__build_node_map(struct perf_env *env, struct perf_cpu_map *cpus,
> >  				    struct cpu_aggr_map **nodep)
> >  {
> > -	return cpu_map__build_map(cpus, nodep, perf_env__get_node, env);
> > +	return cpu_map__build_map(cpus, nodep, perf_env__get_node_aggr_by_cpu, env);
> >  }
> >  
> >  static struct aggr_cpu_id perf_stat__get_socket_file(struct perf_stat_config *config __maybe_unused,
> > diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> > index 49fba2c53822..feaf34b25efc 100644
> > --- a/tools/perf/util/cpumap.c
> > +++ b/tools/perf/util/cpumap.c
> > @@ -163,7 +163,7 @@ static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
> >  }
> >  
> >  int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
> > -		       struct aggr_cpu_id (*f)(struct perf_cpu_map *map, int cpu, void *data),
> > +		       struct aggr_cpu_id (*f)(int cpu, void *data),
> >  		       void *data)
> >  {
> >  	int nr = cpus->nr;
> > @@ -178,7 +178,7 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
> >  	c->nr = 0;
> >  
> >  	for (cpu = 0; cpu < nr; cpu++) {
> > -		s1 = f(cpus, cpu, data);
> > +		s1 = f(cpu, data);
> >  		for (s2 = 0; s2 < c->nr; s2++) {
> >  			if (cpu_map__compare_aggr_cpu_id(s1, c->map[s2]))
> >  				break;
> > @@ -290,22 +290,22 @@ struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *da
> >  
> >  int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **sockp)
> >  {
> > -	return cpu_map__build_map(cpus, sockp, cpu_map__get_socket, NULL);
> > +	return cpu_map__build_map(cpus, sockp, cpu_map__get_socket_aggr_by_cpu, NULL);
> >  }
> >  
> >  int cpu_map__build_die_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **diep)
> >  {
> > -	return cpu_map__build_map(cpus, diep, cpu_map__get_die, NULL);
> > +	return cpu_map__build_map(cpus, diep, cpu_map__get_die_aggr_by_cpu, NULL);
> >  }
> >  
> >  int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **corep)
> >  {
> > -	return cpu_map__build_map(cpus, corep, cpu_map__get_core, NULL);
> > +	return cpu_map__build_map(cpus, corep, cpu_map__get_core_aggr_by_cpu, NULL);
> >  }
> >  
> >  int cpu_map__build_node_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **numap)
> >  {
> > -	return cpu_map__build_map(cpus, numap, cpu_map__get_node, NULL);
> > +	return cpu_map__build_map(cpus, numap, cpu_map__get_node_aggr_by_cpu, NULL);
> >  }
> >  
> >  /* setup simple routines to easily access node numbers given a cpu number */
> > diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> > index c62d67704425..9648816c4255 100644
> > --- a/tools/perf/util/cpumap.h
> > +++ b/tools/perf/util/cpumap.h
> > @@ -63,7 +63,7 @@ int cpu__max_present_cpu(void);
> >  int cpu__get_node(int cpu);
> >  
> >  int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
> > -		       struct aggr_cpu_id (*f)(struct perf_cpu_map *map, int cpu, void *data),
> > +		       struct aggr_cpu_id (*f)(int cpu, void *data),
> >  		       void *data);
> >  
> >  int cpu_map__cpu(struct perf_cpu_map *cpus, int idx);
> > -- 
> > 2.34.1.448.ga2b2bfdf31-goog
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
