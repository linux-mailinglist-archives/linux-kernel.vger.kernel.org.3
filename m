Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966A24715AA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 20:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhLKTZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 14:25:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40040 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230170AbhLKTZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 14:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639250708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sg3tYegBcr8a1PhGekugtBk97+3Tj4pLXTNqM52G2ak=;
        b=ZnH7sAKbcTK28HZWrOlmxFUfGDNLbT0Yo8h2FHh+H4LycoDwiI6OUxSo5WGz8G3945ebJG
        396e1h+Ipng04iiZclwPxnEfbc+q48EvWfweB1JqO7ak8G+wPoPYrEFCIfSCK5ryIXySy6
        byEbVOMNRvJrkzO9rpY7Gx/nxmZb8TA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-02w6aES5PoisB-iNxpqutg-1; Sat, 11 Dec 2021 14:25:07 -0500
X-MC-Unique: 02w6aES5PoisB-iNxpqutg-1
Received: by mail-wm1-f71.google.com with SMTP id g11-20020a1c200b000000b003320d092d08so7017618wmg.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 11:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sg3tYegBcr8a1PhGekugtBk97+3Tj4pLXTNqM52G2ak=;
        b=p9RvOgGSmq4JsJNKO/GXm1Ww6QodE+UwKp16gDIklZx5ruFmW37t1YGFf+IlOSmsxz
         1McQZC9ALfVEolIcjApcoVeLsv6O+Hyd6MPYNEsGsrzVovosQVKkYwwD50qETGfkI7JJ
         EvvdeVfHWBKtYbWfUEvJfggEqPcKkJSXGn8qypz6vZnjDOuqbQxNstI8kXOUP+mDtg7V
         NTu8V9ic4q9cmOognrI4kj20jQuqQJKmVKtHgxPc63IObuG6nIZkOJFp++SzqmRC5zIr
         p/4NMNGPL4ce1w2cg9ZTTxti5VVOtmHj+KKPY2ycOvtNbihC3vOredtwzlUKhIocQPgp
         V/MA==
X-Gm-Message-State: AOAM533+5lr1mCzDhMxGXQFa720eWPD67sYhwCHC+ziR2bwxMhsoZh5b
        OmLQyfNsNwFEc8dK/6Oe4eNBQ8gMs0NMtxuzfGme8USpnDlnuLKZ7UlG3feoYG42kNTxOZiQaQf
        gJPEISLfGo+V7L6UrbRN7+2cw
X-Received: by 2002:a05:6000:1625:: with SMTP id v5mr21433901wrb.196.1639250705498;
        Sat, 11 Dec 2021 11:25:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTpjMNfovA5xcjOrwxzt06x14rvtSJ8nONeyisARxOvdFpDA0WXOOEF8zSOsDUhDjheMvD9w==
X-Received: by 2002:a05:6000:1625:: with SMTP id v5mr21433881wrb.196.1639250705330;
        Sat, 11 Dec 2021 11:25:05 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id e24sm5893514wra.78.2021.12.11.11.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 11:25:04 -0800 (PST)
Date:   Sat, 11 Dec 2021 20:25:02 +0100
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
        linux-arm-kernel@lists.infradead.org, eranian@google.com
Subject: Re: [PATCH 06/22] perf cpumap: Remove map+index get_socket
Message-ID: <YbT7DgbmLDXctakZ@krava>
References: <20211208024607.1784932-1-irogers@google.com>
 <20211208024607.1784932-7-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208024607.1784932-7-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 06:45:51PM -0800, Ian Rogers wrote:
> Migrate final users to appropriate cpu variant.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/topology.c | 2 +-
>  tools/perf/util/cpumap.c    | 9 ---------
>  tools/perf/util/cpumap.h    | 1 -
>  tools/perf/util/stat.c      | 2 +-
>  4 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
> index 869986139146..69a64074b897 100644
> --- a/tools/perf/tests/topology.c
> +++ b/tools/perf/tests/topology.c
> @@ -150,7 +150,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>  
>  	// Test that socket ID contains only socket
>  	for (i = 0; i < map->nr; i++) {
> -		id = cpu_map__get_socket(map, i, NULL);
> +		id = cpu_map__get_socket_aggr_by_cpu(perf_cpu_map__cpu(map, i), NULL);

you could also use the perf_cpu_map__for_each_cpu in here?
same for the following changes

jirka

>  		TEST_ASSERT_VAL("Socket map - Socket ID doesn't match",
>  			session->header.env.cpu[map->map[i]].socket_id == id.socket);
>  
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index feaf34b25efc..342a5eaee9d3 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -136,15 +136,6 @@ struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data __maybe_u
>  	return id;
>  }
>  
> -struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx,
> -				       void *data)
> -{
> -	if (idx < 0 || idx > map->nr)
> -		return cpu_map__empty_aggr_cpu_id();
> -
> -	return cpu_map__get_socket_aggr_by_cpu(map->map[idx], data);
> -}
> -
>  static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
>  {
>  	struct aggr_cpu_id *a = (struct aggr_cpu_id *)a_pointer;
> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> index 9648816c4255..a53af24301d2 100644
> --- a/tools/perf/util/cpumap.h
> +++ b/tools/perf/util/cpumap.h
> @@ -32,7 +32,6 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size);
>  size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp);
>  int cpu_map__get_socket_id(int cpu);
>  struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data);
> -struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx, void *data);
>  int cpu_map__get_die_id(int cpu);
>  struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data);
>  struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *data);
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 09ea334586f2..9eca1111fa52 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -328,7 +328,7 @@ static int check_per_pkg(struct evsel *counter,
>  	if (!(vals->run && vals->ena))
>  		return 0;
>  
> -	s = cpu_map__get_socket(cpus, cpu, NULL).socket;
> +	s = cpu_map__get_socket_id(cpu);
>  	if (s < 0)
>  		return -1;
>  
> -- 
> 2.34.1.400.ga245620fadb-goog
> 

