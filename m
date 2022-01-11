Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49B448B7A3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240158AbiAKTuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239082AbiAKTuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:50:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A517CC06173F;
        Tue, 11 Jan 2022 11:50:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2341FB81C20;
        Tue, 11 Jan 2022 19:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6924EC36AE9;
        Tue, 11 Jan 2022 19:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641930597;
        bh=yzpiOcIaZAFz66wpbSFV4nYHEJIrxjwnt4oQT6ol0bE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R8P2vph61aomu1a2a9jgxWp+VHYfFVImR5japexIR3BdYwh6TqCUUu7SP1bef5Z/F
         5xK3+h3cNFO3kxIrrDR5xbSHQxCa2T4JDHz+JLbBCuHZz0mvYGJTH070S/g/Dw2Uqp
         TzmH+QhXgSuhY1KT5lvT5fF6MkI894N/YsPObu3podSQg57eLjq31Ko1KzGN79sRqc
         3WUSfwoe8k2dUgLX6PhUek25SmNiRQEVXYymcHZXYjjbP1iES9Bh+yl2VCj1U3Oq1+
         0ZsbLC3QwbMXhfU7wsSpLeRct9JgbYqsdf8gh6WfshnG9Z7mTUbwUBR+s7dshGlN/b
         amKlNrcmoCjuA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C6F1940714; Tue, 11 Jan 2022 16:49:54 -0300 (-03)
Date:   Tue, 11 Jan 2022 16:49:54 -0300
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
Subject: Re: [PATCH v4 02/48] perf stat: Add aggr creators that are passed a
 cpu.
Message-ID: <Yd3fYqKi9X+fonEn@kernel.org>
References: <20220105061351.120843-1-irogers@google.com>
 <20220105061351.120843-3-irogers@google.com>
 <Yd3bbelDA1qGPodk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd3bbelDA1qGPodk@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 11, 2022 at 04:33:01PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Jan 04, 2022 at 10:13:05PM -0800, Ian Rogers escreveu:
> > The cpu_map and index can get confused. Add variants of the cpu_map__get
> > routines that are passed a cpu. Make the existing cpu_map__get routines
> > use the new functions with a view to remove them when no longer used.
> > 
> > Reviewed-by: James Clark <james.clark@arm.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/cpumap.c | 79 +++++++++++++++++++++++-----------------
> >  tools/perf/util/cpumap.h |  6 ++-
> >  2 files changed, 51 insertions(+), 34 deletions(-)
> > 
> > diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> > index 87d3eca9b872..49fba2c53822 100644
> > --- a/tools/perf/util/cpumap.c
> > +++ b/tools/perf/util/cpumap.c
> > @@ -128,21 +128,23 @@ int cpu_map__get_socket_id(int cpu)
> >  	return ret ?: value;
> >  }
> >  
> > -struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx,
> > -					void *data __maybe_unused)
> > +struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data __maybe_unused)
> >  {
> > -	int cpu;
> >  	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
> >  
> > -	if (idx > map->nr)
> > -		return id;
> > -
> > -	cpu = map->map[idx];
> > -
> >  	id.socket = cpu_map__get_socket_id(cpu);
> >  	return id;
> >  }
> >  
> > +struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx,
> > +				       void *data)
> > +{
> > +	if (idx < 0 || idx > map->nr)
> > +		return cpu_map__empty_aggr_cpu_id();
> > +
> > +	return cpu_map__get_socket_aggr_by_cpu(map->map[idx], data);
> > +}
> > +
> 
> 
> This 'idx < 0' wasn't in the original code nor is described in the
> comment log message, please avoid doing this, this may be harmless or
> even a good hardening, but either way would be interesting to have it in
> a separate patch. This eases review as in the end this code is just a
> refactoring, moving things around but in the end should be equivalent code.
> 
> There are a few more, please consider this and if you agree, to speed
> things up I can make the changes here, if I think this won't fallout in
> changes to subsequent patches touching this area.

Nah, should be harmless, and its too much work already, so lets leave it
as-is, but please consider this in the future.

- Arnaldo
 
> - Arnaldo
> 
> >  static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
> >  {
> >  	struct aggr_cpu_id *a = (struct aggr_cpu_id *)a_pointer;
> > @@ -200,15 +202,10 @@ int cpu_map__get_die_id(int cpu)
> >  	return ret ?: value;
> >  }
> >  
> > -struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *data)
> > +struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data)
> >  {
> > -	int cpu, die;
> > -	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
> > -
> > -	if (idx > map->nr)
> > -		return id;
> > -
> > -	cpu = map->map[idx];
> > +	struct aggr_cpu_id id;
> > +	int die;
> >  
> >  	die = cpu_map__get_die_id(cpu);
> >  	/* There is no die_id on legacy system. */
> > @@ -220,7 +217,7 @@ struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *dat
> >  	 * with the socket ID and then add die to
> >  	 * make a unique ID.
> >  	 */
> > -	id = cpu_map__get_socket(map, idx, data);
> > +	id = cpu_map__get_socket_aggr_by_cpu(cpu, data);
> >  	if (cpu_map__aggr_cpu_id_is_empty(id))
> >  		return id;
> >  
> > @@ -228,6 +225,15 @@ struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *dat
> >  	return id;
> >  }
> >  
> > +struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx,
> > +				    void *data)
> > +{
> > +	if (idx < 0 || idx > map->nr)
> > +		return cpu_map__empty_aggr_cpu_id();
> 
> Ditto
> 
> > +
> > +	return cpu_map__get_die_aggr_by_cpu(map->map[idx], data);
> > +}
> > +
> >  int cpu_map__get_core_id(int cpu)
> >  {
> >  	int value, ret = cpu__get_topology_int(cpu, "core_id", &value);
> > @@ -239,20 +245,13 @@ int cpu_map__get_node_id(int cpu)
> >  	return cpu__get_node(cpu);
> >  }
> >  
> > -struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data)
> > +struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data)
> >  {
> > -	int cpu;
> > -	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
> > -
> > -	if (idx > map->nr)
> > -		return id;
> > -
> > -	cpu = map->map[idx];
> > -
> > -	cpu = cpu_map__get_core_id(cpu);
> > +	struct aggr_cpu_id id;
> > +	int core = cpu_map__get_core_id(cpu);
> >  
> >  	/* cpu_map__get_die returns a struct with socket and die set*/
> > -	id = cpu_map__get_die(map, idx, data);
> > +	id = cpu_map__get_die_aggr_by_cpu(cpu, data);
> >  	if (cpu_map__aggr_cpu_id_is_empty(id))
> >  		return id;
> >  
> > @@ -260,19 +259,33 @@ struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *da
> >  	 * core_id is relative to socket and die, we need a global id.
> >  	 * So we combine the result from cpu_map__get_die with the core id
> >  	 */
> > -	id.core = cpu;
> > +	id.core = core;
> >  	return id;
> > +
> >  }
> >  
> > -struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data __maybe_unused)
> > +struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data)
> > +{
> > +	if (idx < 0 || idx > map->nr)
> > +		return cpu_map__empty_aggr_cpu_id();
> 
> Ditto
> 
> > +
> > +	return cpu_map__get_core_aggr_by_cpu(map->map[idx], data);
> > +}
> > +
> > +struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data __maybe_unused)
> >  {
> >  	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
> >  
> > +	id.node = cpu_map__get_node_id(cpu);
> > +	return id;
> > +}
> > +
> > +struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data)
> > +{
> >  	if (idx < 0 || idx >= map->nr)
> > -		return id;
> > +		return cpu_map__empty_aggr_cpu_id();
> >  
> > -	id.node = cpu_map__get_node_id(map->map[idx]);
> > -	return id;
> > +	return cpu_map__get_node_aggr_by_cpu(map->map[idx], data);
> >  }
> >  
> >  int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **sockp)
> > diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> > index a27eeaf086e8..c62d67704425 100644
> > --- a/tools/perf/util/cpumap.h
> > +++ b/tools/perf/util/cpumap.h
> > @@ -31,13 +31,17 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
> >  size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size);
> >  size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp);
> >  int cpu_map__get_socket_id(int cpu);
> > +struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data);
> >  struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx, void *data);
> >  int cpu_map__get_die_id(int cpu);
> > +struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data);
> >  struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *data);
> >  int cpu_map__get_core_id(int cpu);
> > +struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data);
> >  struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data);
> >  int cpu_map__get_node_id(int cpu);
> > -struct aggr_cpu_id  cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data);
> > +struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data);
> > +struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data);
> >  int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **sockp);
> >  int cpu_map__build_die_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **diep);
> >  int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **corep);
> > -- 
> > 2.34.1.448.ga2b2bfdf31-goog
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
