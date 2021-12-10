Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548B04709E8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343535AbhLJTN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:13:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33684 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbhLJTN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:13:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7749EB829BE;
        Fri, 10 Dec 2021 19:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF196C00446;
        Fri, 10 Dec 2021 19:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639163419;
        bh=MjW1Fpjxl/djfZyI0SFVyxDpWQY7QPvsplp+v8eHKWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ACMXnaKtN/7NtK3bR1qiAB/GomO+x70mlr9jJTIh+uFVhDPs3LBveOldxk2YV7/XZ
         0YaFJ/6no+l2/7k7rX8uwYWCaOVdDjdpyFjdz8McUmwLeZtBaNRd6/1pUxyjAqHq9F
         3qPn/w5itIv2Cpk9oWdgq0/duPXqH8wv3F46U82SYv+jyTt2OKaIA1yY/dMEHZSr3w
         RyD+jZ8uh2yk0GPSGDmC7TAmsTS3rDwJCR6NiTVn/Y+Dz2guGFKHjmc8mFmWmqMqU8
         QDUPD9fNZlt3iwoG+OhGbM/d/ESiY3Og0ul+cG6Fu1nJnDQe3yllUJQmZDUY8ZOTQL
         wFTwdrJ/Xxc8Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 68B80405D8; Fri, 10 Dec 2021 16:10:17 -0300 (-03)
Date:   Fri, 10 Dec 2021 16:10:17 -0300
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
        linux-arm-kernel@lists.infradead.org, eranian@google.com
Subject: Re: [PATCH 02/22] perf stat: Add aggr creators that are passed a cpu.
Message-ID: <YbOmGdzZAJ8q8Lz6@kernel.org>
References: <20211208024607.1784932-1-irogers@google.com>
 <20211208024607.1784932-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208024607.1784932-3-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 07, 2021 at 06:45:47PM -0800, Ian Rogers escreveu:
> The cpu_map and index can get confused. Add variants of the cpu_map__get
> routines that are passed a cpu. Make the existing cpu_map__get routines
> use the new functions with a view to remove them when no longer used.

Looks ok from a quick lock
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/cpumap.c | 79 +++++++++++++++++++++++-----------------
>  tools/perf/util/cpumap.h |  6 ++-
>  2 files changed, 51 insertions(+), 34 deletions(-)
> 
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 87d3eca9b872..49fba2c53822 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -128,21 +128,23 @@ int cpu_map__get_socket_id(int cpu)
>  	return ret ?: value;
>  }
>  
> -struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx,
> -					void *data __maybe_unused)
> +struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data __maybe_unused)
>  {
> -	int cpu;
>  	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
>  
> -	if (idx > map->nr)
> -		return id;
> -
> -	cpu = map->map[idx];
> -
>  	id.socket = cpu_map__get_socket_id(cpu);
>  	return id;
>  }
>  
> +struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx,
> +				       void *data)
> +{
> +	if (idx < 0 || idx > map->nr)
> +		return cpu_map__empty_aggr_cpu_id();
> +
> +	return cpu_map__get_socket_aggr_by_cpu(map->map[idx], data);
> +}
> +
>  static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
>  {
>  	struct aggr_cpu_id *a = (struct aggr_cpu_id *)a_pointer;
> @@ -200,15 +202,10 @@ int cpu_map__get_die_id(int cpu)
>  	return ret ?: value;
>  }
>  
> -struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *data)
> +struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data)
>  {
> -	int cpu, die;
> -	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
> -
> -	if (idx > map->nr)
> -		return id;
> -
> -	cpu = map->map[idx];
> +	struct aggr_cpu_id id;
> +	int die;
>  
>  	die = cpu_map__get_die_id(cpu);
>  	/* There is no die_id on legacy system. */
> @@ -220,7 +217,7 @@ struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *dat
>  	 * with the socket ID and then add die to
>  	 * make a unique ID.
>  	 */
> -	id = cpu_map__get_socket(map, idx, data);
> +	id = cpu_map__get_socket_aggr_by_cpu(cpu, data);
>  	if (cpu_map__aggr_cpu_id_is_empty(id))
>  		return id;
>  
> @@ -228,6 +225,15 @@ struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *dat
>  	return id;
>  }
>  
> +struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx,
> +				    void *data)
> +{
> +	if (idx < 0 || idx > map->nr)
> +		return cpu_map__empty_aggr_cpu_id();
> +
> +	return cpu_map__get_die_aggr_by_cpu(map->map[idx], data);
> +}
> +
>  int cpu_map__get_core_id(int cpu)
>  {
>  	int value, ret = cpu__get_topology_int(cpu, "core_id", &value);
> @@ -239,20 +245,13 @@ int cpu_map__get_node_id(int cpu)
>  	return cpu__get_node(cpu);
>  }
>  
> -struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data)
> +struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data)
>  {
> -	int cpu;
> -	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
> -
> -	if (idx > map->nr)
> -		return id;
> -
> -	cpu = map->map[idx];
> -
> -	cpu = cpu_map__get_core_id(cpu);
> +	struct aggr_cpu_id id;
> +	int core = cpu_map__get_core_id(cpu);
>  
>  	/* cpu_map__get_die returns a struct with socket and die set*/
> -	id = cpu_map__get_die(map, idx, data);
> +	id = cpu_map__get_die_aggr_by_cpu(cpu, data);
>  	if (cpu_map__aggr_cpu_id_is_empty(id))
>  		return id;
>  
> @@ -260,19 +259,33 @@ struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *da
>  	 * core_id is relative to socket and die, we need a global id.
>  	 * So we combine the result from cpu_map__get_die with the core id
>  	 */
> -	id.core = cpu;
> +	id.core = core;
>  	return id;
> +
>  }
>  
> -struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data __maybe_unused)
> +struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data)
> +{
> +	if (idx < 0 || idx > map->nr)
> +		return cpu_map__empty_aggr_cpu_id();
> +
> +	return cpu_map__get_core_aggr_by_cpu(map->map[idx], data);
> +}
> +
> +struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data __maybe_unused)
>  {
>  	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
>  
> +	id.node = cpu_map__get_node_id(cpu);
> +	return id;
> +}
> +
> +struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data)
> +{
>  	if (idx < 0 || idx >= map->nr)
> -		return id;
> +		return cpu_map__empty_aggr_cpu_id();
>  
> -	id.node = cpu_map__get_node_id(map->map[idx]);
> -	return id;
> +	return cpu_map__get_node_aggr_by_cpu(map->map[idx], data);
>  }
>  
>  int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **sockp)
> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> index a27eeaf086e8..c62d67704425 100644
> --- a/tools/perf/util/cpumap.h
> +++ b/tools/perf/util/cpumap.h
> @@ -31,13 +31,17 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
>  size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size);
>  size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp);
>  int cpu_map__get_socket_id(int cpu);
> +struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data);
>  struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx, void *data);
>  int cpu_map__get_die_id(int cpu);
> +struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data);
>  struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *data);
>  int cpu_map__get_core_id(int cpu);
> +struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data);
>  struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data);
>  int cpu_map__get_node_id(int cpu);
> -struct aggr_cpu_id  cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data);
> +struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data);
> +struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data);
>  int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **sockp);
>  int cpu_map__build_die_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **diep);
>  int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **corep);
> -- 
> 2.34.1.400.ga245620fadb-goog

-- 

- Arnaldo
