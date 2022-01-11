Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECA748B769
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbiAKTgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbiAKTgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:36:15 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C6EC061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:36:15 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id i14so266292ioj.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RqpwIREVX70fiCmsWTnArwdFuDEuBHwwhekMVXd1NL0=;
        b=T6XQRrca1BYPLOv7HE5gukVge1tS9AnvJNBCUAqkqgZ91+KsRjq3ScXr81he2oit9e
         96MOCR0/Z14od8uAyny1EIXxz/f+ZmHseCHRBncMQopbgCl7ZWM+4E1tzrbc5uLK4OUI
         uXajkOR+MWuqfqw4BjcUeUQjayOai2/lmE8d2bEnUZ88vBCacCJSiqfSv9CVw5FLZVuL
         RXrbxORYrFeCFA0OpJh2jeCxRJHWhnP+a9YCMZqhE7gltTn3hvyh1IzSYqRVA+giIirg
         AmS1g5KbcLywsuesP0JdCqSCjsgVcZD3rpj7Mxn3APOx9zEQSJs77YjJED5aJ8Cu2XPT
         7foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RqpwIREVX70fiCmsWTnArwdFuDEuBHwwhekMVXd1NL0=;
        b=wvmQFrqP4MUj8tHIhHt6mdODHxnNXAJFjCk3aM7fjqw7Ln/1mrLRimvLxwKj3oyvOO
         USQ1B0lwVX1A/P88Jx+SFfn2AuThJ3FOOTcIFaw6lfIlqWHzs60eNuEbce/gT9owPahV
         /mabfuDmm0p9gn9wTKoTLnROhG6fqmxe5X4MM10BRGqEGxXIIxUxGYaONEs8dONear4A
         yZPoBjMINkHVgM/6AkWh+9/bXA5Rb4618490u6m6Y8ZNw2duO1OBYUXaCRc+oG8fvsyE
         aIJJWFxtc3LFQoYT3euqo1sm6sWDdRFNXGal/CgueDtwxAaWj3QzA9mikCv6kogzJ9QX
         Bv3Q==
X-Gm-Message-State: AOAM530uJRSq68X6RlwMlbBKgD/Ar89DVA50nUOvphj5queB/hy/v/21
        jvk3xfrJ+ffuJt8KTASIF5F6mfqVMdKsL+Y6tdLEcQ==
X-Google-Smtp-Source: ABdhPJybo/+BZxGJYXYN/OyXarDfnsUgX5kgIAawVlZ7LjS3iI+ozapXi9pAiXZrc4jLu7xoEZ4elzr91pqD4OvY6V0=
X-Received: by 2002:a02:22c9:: with SMTP id o192mr3118882jao.287.1641929774723;
 Tue, 11 Jan 2022 11:36:14 -0800 (PST)
MIME-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com> <20220105061351.120843-3-irogers@google.com>
 <Yd3bbelDA1qGPodk@kernel.org>
In-Reply-To: <Yd3bbelDA1qGPodk@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 11 Jan 2022 11:36:02 -0800
Message-ID: <CAP-5=fVSuF-BCKuv6dutwLaAEKOctNYPtHzGYYDzZ7cm0110GQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/48] perf stat: Add aggr creators that are passed a cpu.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:33 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
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
> >       return ret ?: value;
> >  }
> >
> > -struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx,
> > -                                     void *data __maybe_unused)
> > +struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data __maybe_unused)
> >  {
> > -     int cpu;
> >       struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
> >
> > -     if (idx > map->nr)
> > -             return id;
> > -
> > -     cpu = map->map[idx];
> > -
> >       id.socket = cpu_map__get_socket_id(cpu);
> >       return id;
> >  }
> >
> > +struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx,
> > +                                    void *data)
> > +{
> > +     if (idx < 0 || idx > map->nr)
> > +             return cpu_map__empty_aggr_cpu_id();
> > +
> > +     return cpu_map__get_socket_aggr_by_cpu(map->map[idx], data);
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
>
> - Arnaldo

Fwiw, there's the same issue in cpu_map__get_die that's also in
cpu_map__get_core, but weirdly not copied into cpu_map__get_node. As
these functions are removed later I think doing nothing is best here.

Thanks,
Ian

> >  static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
> >  {
> >       struct aggr_cpu_id *a = (struct aggr_cpu_id *)a_pointer;
> > @@ -200,15 +202,10 @@ int cpu_map__get_die_id(int cpu)
> >       return ret ?: value;
> >  }
> >
> > -struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *data)
> > +struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data)
> >  {
> > -     int cpu, die;
> > -     struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
> > -
> > -     if (idx > map->nr)
> > -             return id;
> > -
> > -     cpu = map->map[idx];
> > +     struct aggr_cpu_id id;
> > +     int die;
> >
> >       die = cpu_map__get_die_id(cpu);
> >       /* There is no die_id on legacy system. */
> > @@ -220,7 +217,7 @@ struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *dat
> >        * with the socket ID and then add die to
> >        * make a unique ID.
> >        */
> > -     id = cpu_map__get_socket(map, idx, data);
> > +     id = cpu_map__get_socket_aggr_by_cpu(cpu, data);
> >       if (cpu_map__aggr_cpu_id_is_empty(id))
> >               return id;
> >
> > @@ -228,6 +225,15 @@ struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *dat
> >       return id;
> >  }
> >
> > +struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx,
> > +                                 void *data)
> > +{
> > +     if (idx < 0 || idx > map->nr)
> > +             return cpu_map__empty_aggr_cpu_id();
>
> Ditto
>
> > +
> > +     return cpu_map__get_die_aggr_by_cpu(map->map[idx], data);
> > +}
> > +
> >  int cpu_map__get_core_id(int cpu)
> >  {
> >       int value, ret = cpu__get_topology_int(cpu, "core_id", &value);
> > @@ -239,20 +245,13 @@ int cpu_map__get_node_id(int cpu)
> >       return cpu__get_node(cpu);
> >  }
> >
> > -struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data)
> > +struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data)
> >  {
> > -     int cpu;
> > -     struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
> > -
> > -     if (idx > map->nr)
> > -             return id;
> > -
> > -     cpu = map->map[idx];
> > -
> > -     cpu = cpu_map__get_core_id(cpu);
> > +     struct aggr_cpu_id id;
> > +     int core = cpu_map__get_core_id(cpu);
> >
> >       /* cpu_map__get_die returns a struct with socket and die set*/
> > -     id = cpu_map__get_die(map, idx, data);
> > +     id = cpu_map__get_die_aggr_by_cpu(cpu, data);
> >       if (cpu_map__aggr_cpu_id_is_empty(id))
> >               return id;
> >
> > @@ -260,19 +259,33 @@ struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *da
> >        * core_id is relative to socket and die, we need a global id.
> >        * So we combine the result from cpu_map__get_die with the core id
> >        */
> > -     id.core = cpu;
> > +     id.core = core;
> >       return id;
> > +
> >  }
> >
> > -struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data __maybe_unused)
> > +struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data)
> > +{
> > +     if (idx < 0 || idx > map->nr)
> > +             return cpu_map__empty_aggr_cpu_id();
>
> Ditto
>
> > +
> > +     return cpu_map__get_core_aggr_by_cpu(map->map[idx], data);
> > +}
> > +
> > +struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data __maybe_unused)
> >  {
> >       struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
> >
> > +     id.node = cpu_map__get_node_id(cpu);
> > +     return id;
> > +}
> > +
> > +struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data)
> > +{
> >       if (idx < 0 || idx >= map->nr)
> > -             return id;
> > +             return cpu_map__empty_aggr_cpu_id();
> >
> > -     id.node = cpu_map__get_node_id(map->map[idx]);
> > -     return id;
> > +     return cpu_map__get_node_aggr_by_cpu(map->map[idx], data);
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
