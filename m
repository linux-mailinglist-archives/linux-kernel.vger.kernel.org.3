Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9B4484335
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiADOUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:20:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56926 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229798AbiADOT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641305998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4o1dUpMKxkuScgdlrFDStdsyfxNC95K73l0Z6QXPvzQ=;
        b=PGM7dWiqnTSgSGoq+S8Jj9kQT/3id8hI2leSYuvumrGuyI87cF5oSlO/mpQzpNivnhIGOi
        bIV/NNjvhglGgVCnZ/oRjsl/Svi5mElmbTUh8wW/TRMjXoIol5FM8e+6QNg3GSvGnWv7p1
        l59KUwTi7JR16Islh2qJWzPlhAEh/oE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-Oy85sI_lMUaM9ARx2_QYGA-1; Tue, 04 Jan 2022 09:19:57 -0500
X-MC-Unique: Oy85sI_lMUaM9ARx2_QYGA-1
Received: by mail-ed1-f69.google.com with SMTP id o20-20020a056402439400b003f83cf1e472so25407232edc.18
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 06:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4o1dUpMKxkuScgdlrFDStdsyfxNC95K73l0Z6QXPvzQ=;
        b=SkrdHbdLoNGiob0oFkR74G1u2BhVC8lMC8KcKJCeZjdAzW08ixmh50G65zoEEzaYJV
         qjacPtqXEoQrgYUaN1j2mTlIq7morETL9GzSthsiH+fMs0slEdLDb7koDULJyj/5b/uY
         rjVWwG2D+tGRSjkS8ZG/sTgyVHhtzzCTLU5I6DYpHBeKHokHnMLginSX5Xz3e074M7nT
         yJ7P7db5nsbe0qTPFMxKNDaDxACfQIEUwCACTJ3LwONshoJ2eJdMSxP0sg+O6lVP+4Da
         tfLzr+UkoCnbbltTQwsmnWpsknscNGOn6M3khEJNyhr8C1iEAXuAWmXSYr4zPBO4FW9u
         Nt3g==
X-Gm-Message-State: AOAM530dfdiBitzxNH1dJZzFlJgNPWFc0/7jlrw6aqjTcCb/s1r+9hvs
        vuuSrZenZryfyrXaSWDDjuaaYWuy3EOeVdGTsN6zUCmqNlsJ6aO/AohCFeJ8FwCbM12nBGG4FJG
        gJyYFGuUhcy19HfG+IsoBDh9f
X-Received: by 2002:a17:906:8981:: with SMTP id gg1mr14679878ejc.511.1641305996406;
        Tue, 04 Jan 2022 06:19:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz185nPOkQ2E/XUIdj7/n9gpKbnEymZqBm+PWnqWGcUp6r7ZcjCZjXBRiSiu594U8svxpbQdQ==
X-Received: by 2002:a17:906:8981:: with SMTP id gg1mr14679858ejc.511.1641305996239;
        Tue, 04 Jan 2022 06:19:56 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id hb11sm11500426ejc.33.2022.01.04.06.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 06:19:46 -0800 (PST)
Date:   Tue, 4 Jan 2022 15:19:44 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: Re: [PATCH v3 08/48] perf cpumap: Remove map+index get_die
Message-ID: <YdRXgF4OoFnU6MUo@krava>
References: <20211230072030.302559-1-irogers@google.com>
 <20211230072030.302559-10-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230072030.302559-10-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 11:19:50PM -0800, Ian Rogers wrote:
> Migrate final users to appropriate cpu variant.
> 
> Reviewed-by: James Clark <james.clark@arm.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/topology.c | 2 +-
>  tools/perf/util/cpumap.c    | 9 ---------
>  tools/perf/util/cpumap.h    | 1 -
>  tools/perf/util/stat.c      | 2 +-
>  4 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
> index 69a64074b897..ce085b6f379b 100644
> --- a/tools/perf/tests/topology.c
> +++ b/tools/perf/tests/topology.c
> @@ -136,7 +136,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>  
>  	// Test that die ID contains socket and die
>  	for (i = 0; i < map->nr; i++) {
> -		id = cpu_map__get_die(map, i, NULL);
> +		id = cpu_map__get_die_aggr_by_cpu(perf_cpu_map__cpu(map, i), NULL);
>  		TEST_ASSERT_VAL("Die map - Socket ID doesn't match",
>  			session->header.env.cpu[map->map[i]].socket_id == id.socket);
>  
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 342a5eaee9d3..ff91c32da688 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -216,15 +216,6 @@ struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data)
>  	return id;
>  }
>  
> -struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx,
> -				    void *data)
> -{
> -	if (idx < 0 || idx > map->nr)
> -		return cpu_map__empty_aggr_cpu_id();
> -
> -	return cpu_map__get_die_aggr_by_cpu(map->map[idx], data);
> -}
> -
>  int cpu_map__get_core_id(int cpu)
>  {
>  	int value, ret = cpu__get_topology_int(cpu, "core_id", &value);
> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> index a53af24301d2..365ed69699e1 100644
> --- a/tools/perf/util/cpumap.h
> +++ b/tools/perf/util/cpumap.h
> @@ -34,7 +34,6 @@ int cpu_map__get_socket_id(int cpu);
>  struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data);
>  int cpu_map__get_die_id(int cpu);
>  struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data);
> -struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *data);
>  int cpu_map__get_core_id(int cpu);
>  struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data);
>  struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data);
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 9eca1111fa52..5ed99bcfe91e 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -336,7 +336,7 @@ static int check_per_pkg(struct evsel *counter,
>  	 * On multi-die system, die_id > 0. On no-die system, die_id = 0.
>  	 * We use hashmap(socket, die) to check the used socket+die pair.
>  	 */
> -	d = cpu_map__get_die(cpus, cpu, NULL).die;
> +	d = cpu_map__get_die_id(cpu);
>  	if (d < 0)
>  		return -1;

looking on this I realized that probably we have broken

  perf stat record
  perf stat report

if that report is run on different machine, because we
take die from current system

should be fixed in another patchset though

jirka

