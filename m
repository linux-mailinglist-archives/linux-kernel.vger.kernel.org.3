Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7A5484336
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiADOUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:20:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55492 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234096AbiADOUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641306006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tdBXcdlUZgH91vSV8gBFMtFgTf/fDf2VkDsQMplYoag=;
        b=W2syZLrtg98LPwkFetWikVPH1TWKDNIghIwTwM2jgmg65df4nrzlPeMVMzlz0ANH82WWZl
        wnOwstiWuBhLiSNEoT4nassAPQ0sSruTas1VCjdtZDdOqb3HdRVbcpfnLEqc1uf2MEcFP+
        dqIuoelHsYlIWL0iZQqaQj3QQazBqxo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-n1iAn0RgMQeFHGQPKVCCVQ-1; Tue, 04 Jan 2022 09:20:05 -0500
X-MC-Unique: n1iAn0RgMQeFHGQPKVCCVQ-1
Received: by mail-ed1-f69.google.com with SMTP id dz8-20020a0564021d4800b003f897935eb3so25425956edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 06:20:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tdBXcdlUZgH91vSV8gBFMtFgTf/fDf2VkDsQMplYoag=;
        b=LfurKwZcm74voUJKo67ZHQSzdgwOr0egnbqb6h9IxQ8Sgp62WsKoSlNKpxdmBReSGj
         ROLN/Ur+BrTYLdyPpnT5EXD3FNWDtUXBCaJKYrjdSYgSR6zrDH9Rv+vfl/9yocGkOyk8
         CgvVtgjeW6qS3saUiqW1M19DHfNcWPK32WuCuhwjAiRC6w0A4Hmpi3hES7qByUKkxDks
         XsUrIafx+huX6SI086BlllcB3HInPfyYnZxvJ9rgVFbJ+q/mBeKmpjV/XfCwmROoT1Nm
         yCOQ+4F9gTq/XQwM0AA69qGVOzYHj8vk0gIFA5MDKEDBJW4mpf7NRNKnnBwmccfYKlrp
         yOVw==
X-Gm-Message-State: AOAM530l7FFPBpkhyR6vbLqoiNsOjL8a9Kgqt+FfFf1RVCFixGlMo0Lo
        oflRfnovxCHDb+/NUoG3j2/Ysn5TvM3KPL0mKkcuwkQnMd1lFFjj9fd6chPTbhcYHnlFBe6KUlE
        unK+Axn5bh/ZS7ZP0NPwI6maz
X-Received: by 2002:a17:907:3f83:: with SMTP id hr3mr41248730ejc.604.1641306004249;
        Tue, 04 Jan 2022 06:20:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDMB0s8rjFyQSN39kRHQDqc01meMLfO5JYh1JLbN/Rupu47T0fL4hC9U8RPK01PTE4BlD7MQ==
X-Received: by 2002:a17:907:3f83:: with SMTP id hr3mr41248713ejc.604.1641306004067;
        Tue, 04 Jan 2022 06:20:04 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id f14sm14766323eds.20.2022.01.04.06.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 06:20:03 -0800 (PST)
Date:   Tue, 4 Jan 2022 15:20:01 +0100
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
Subject: Re: [PATCH v3 18/48] perf cpumap: Refactor cpu_map__build_map
Message-ID: <YdRXkXIVAkgO1p0d@krava>
References: <20211230072030.302559-1-irogers@google.com>
 <20211230072030.302559-20-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230072030.302559-20-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 11:20:00PM -0800, Ian Rogers wrote:

SNIP

> +		return 0;
> +
> +	stat_config.aggr_map = cpu_aggr_map__new(evsel_list->core.cpus, get_id, env);
> +	if (!stat_config.aggr_map) {
> +		pr_err("cannot build %s map", aggr_mode__string[stat_config.aggr_mode]);
> +		return -1;
> +	}
> +	stat_config.aggr_get_id = aggr_mode__get_id_file(stat_config.aggr_mode);
>  	return 0;
>  }
>  
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 32f9fc2dd389..ba4468f691c8 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -140,7 +140,7 @@ struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data __maybe_u
>  	return id;
>  }
>  
> -static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
> +static int aggr_cpu_id__cmp(const void *a_pointer, const void *b_pointer)
>  {
>  	struct aggr_cpu_id *a = (struct aggr_cpu_id *)a_pointer;
>  	struct aggr_cpu_id *b = (struct aggr_cpu_id *)b_pointer;
> @@ -157,37 +157,40 @@ static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
>  		return a->thread - b->thread;
>  }
>  
> -int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
> -		       struct aggr_cpu_id (*f)(int cpu, void *data),
> -		       void *data)
> +struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
> +				       aggr_cpu_id_get_t f,

s/f/get_id/ ?

jirka


> +				       void *data)
>  {
> -	int nr = cpus->nr;
> -	struct cpu_aggr_map *c = cpu_aggr_map__empty_new(nr);
> -	int cpu, s2;
> -	struct aggr_cpu_id s1;
> +	int cpu, idx;
> +	struct cpu_aggr_map *c = cpu_aggr_map__empty_new(cpus->nr);

SNIP

