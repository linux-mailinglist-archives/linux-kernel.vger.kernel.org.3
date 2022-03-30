Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727D84EC5F5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346365AbiC3NwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346370AbiC3NwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:52:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3EA103D9C;
        Wed, 30 Mar 2022 06:50:18 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id lr4so33224672ejb.11;
        Wed, 30 Mar 2022 06:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ve9HTLPfFiMCqiwgASkWrbDiD4usuPpG+DRPyijCLk8=;
        b=eIvKa43EHIQTbycQoMdVO30wG3/EVljSIiT6UoFWWS1p6j1f25we5Gi8WXXKtXyGEO
         7+AVCoDw8987uSkno/lDgaSuyI5fNTv1mk2iSs3VXX8LIAwrZET1+EtkBbgQb6tLCUNb
         QQcKVTQHixqeH1n1ngeTpXzE3tU+tdNgWA62CPKNKrm94aJiZCvi2nuBMC9K6TlKWEtA
         DzY7F72kWqMX9DcAp5fxRLHLQw584am3Wnl9dHpJ9xKgBB20HcRUBqEItH2ow3bNGsQI
         1nALgzbiL9upNA8Q8dDaIl/xj53DUnfzfyMz0tFWCqzP5H3wgxCv7J7A7fWiRDbWjFUp
         hY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ve9HTLPfFiMCqiwgASkWrbDiD4usuPpG+DRPyijCLk8=;
        b=dnn1yjikCxhwslhFGTqST3RsLDG+uIIfLsxJvpTBO+LHFEh04u62VM+4LCnGRI/Nw0
         AJeLK+07QVGT6b6QbdfYlRAK8bIFjkvk1nn2DTlu9BXGlDv6uSwwhYAQfkxMYChF8ZGW
         KEbfstJHMPcubS1MxvPo4LLhCTsBR3DNdHRu7mgXjXEKOzwfeIOOpyd31MqlZxVdHjx+
         Ajj0ZhSCAmxpbaTYkJmTuxwt3eXhTAQNGEfc8sr2rGYcOQBmLeFho+RpwZWHUxT7dojb
         /1TtioW2B719LKkPV/NUI2n/Sqy7z8MwzcINae5S0xGtETab/DY95w5UimMiny4mcASh
         Cciw==
X-Gm-Message-State: AOAM533Pdyj2OWKbaloi8nY/xstD9yikxDrleJsKCaaGdKe9JB2XT0WY
        IWLisL25/j+jRenPfPo0IlsLs85XjMpQzQ==
X-Google-Smtp-Source: ABdhPJwBQA7PDLXrRtWTLbYizbA3UaR8lkI3rC1/vQj4NvaGHbnwhV/0YsVpIq6+mbJ3fbGLpN6oCw==
X-Received: by 2002:a17:907:8a25:b0:6d7:d59:6912 with SMTP id sc37-20020a1709078a2500b006d70d596912mr39962831ejc.259.1648648216396;
        Wed, 30 Mar 2022 06:50:16 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090677d500b006df766974basm8433015ejn.3.2022.03.30.06.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 06:50:16 -0700 (PDT)
Date:   Wed, 30 Mar 2022 15:50:13 +0200
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/7] libperf: Move 'open_flags' from tools/perf to
 evsel::open_flags
Message-ID: <YkRgFdWdW0HyqIno@krava>
References: <20220325043829.224045-1-nakamura.shun@fujitsu.com>
 <20220325043829.224045-3-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325043829.224045-3-nakamura.shun@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 01:38:24PM +0900, Shunsuke Nakamura wrote:
> Move evsel::open_flags to perf_evsel::open_flags, so we can move
> the open_flags interface to libperf.
> 
> Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> ---
>  tools/lib/perf/evsel.c                  |  3 ++-
>  tools/lib/perf/include/internal/evsel.h |  2 ++
>  tools/perf/util/evsel.c                 | 16 +++++++++-------
>  tools/perf/util/evsel.h                 |  1 -
>  4 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 210ea7c06ce8..6640a333e6d9 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -26,6 +26,7 @@ void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
>  	evsel->attr = *attr;
>  	evsel->idx  = idx;
>  	evsel->leader = evsel;
> +	evsel->open_flags = 0;
>  }
>  
>  struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr)
> @@ -158,7 +159,7 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
>  
>  			fd = sys_perf_event_open(&evsel->attr,
>  						 threads->map[thread].pid,
> -						 cpu, group_fd, 0);
> +						 cpu, group_fd, evsel->open_flags);

please keep this change just open_flags field move,
this change should go to later patch

jirka

>  
>  			if (fd < 0)
>  				return -errno;
> diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
> index cfc9ebd7968e..37a99cf261b3 100644
> --- a/tools/lib/perf/include/internal/evsel.h
> +++ b/tools/lib/perf/include/internal/evsel.h
> @@ -51,6 +51,8 @@ struct perf_evsel {
>  	int			 nr_members;
>  	bool			 system_wide;
>  	int			 idx;
> +
> +	unsigned long		 open_flags;
>  };
>  
>  void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 22d3267ce294..52c34552ee76 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1794,9 +1794,9 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	    perf_evsel__alloc_fd(&evsel->core, perf_cpu_map__nr(cpus), nthreads) < 0)
>  		return -ENOMEM;
>  
> -	evsel->open_flags = PERF_FLAG_FD_CLOEXEC;
> +	evsel->core.open_flags = PERF_FLAG_FD_CLOEXEC;
>  	if (evsel->cgrp)
> -		evsel->open_flags |= PERF_FLAG_PID_CGROUP;
> +		evsel->core.open_flags |= PERF_FLAG_PID_CGROUP;
>  
>  	return 0;
>  }
> @@ -1814,7 +1814,7 @@ static void evsel__disable_missing_features(struct evsel *evsel)
>  		evsel->core.attr.clockid = 0;
>  	}
>  	if (perf_missing_features.cloexec)
> -		evsel->open_flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
> +		evsel->core.open_flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
>  	if (perf_missing_features.mmap2)
>  		evsel->core.attr.mmap2 = 0;
>  	if (evsel->pmu && evsel->pmu->missing_features.exclude_guest)
> @@ -1902,7 +1902,8 @@ bool evsel__detect_missing_features(struct evsel *evsel)
>  		perf_missing_features.clockid = true;
>  		pr_debug2_peo("switching off use_clockid\n");
>  		return true;
> -	} else if (!perf_missing_features.cloexec && (evsel->open_flags & PERF_FLAG_FD_CLOEXEC)) {
> +	} else if (!perf_missing_features.cloexec &&
> +		   (evsel->core.open_flags & PERF_FLAG_FD_CLOEXEC)) {
>  		perf_missing_features.cloexec = true;
>  		pr_debug2_peo("switching off cloexec flag\n");
>  		return true;
> @@ -2029,11 +2030,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  			test_attr__ready();
>  
>  			pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
> -				pid, perf_cpu_map__cpu(cpus, idx).cpu, group_fd, evsel->open_flags);
> +				pid, perf_cpu_map__cpu(cpus, idx).cpu, group_fd,
> +				evsel->core.open_flags);
>  
>  			fd = sys_perf_event_open(&evsel->core.attr, pid,
>  						perf_cpu_map__cpu(cpus, idx).cpu,
> -						group_fd, evsel->open_flags);
> +						group_fd, evsel->core.open_flags);
>  
>  			FD(evsel, idx, thread) = fd;
>  
> @@ -2050,7 +2052,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  			if (unlikely(test_attr__enabled)) {
>  				test_attr__open(&evsel->core.attr, pid,
>  						perf_cpu_map__cpu(cpus, idx),
> -						fd, group_fd, evsel->open_flags);
> +						fd, group_fd, evsel->core.open_flags);
>  			}
>  
>  			pr_debug2_peo(" = %d\n", fd);
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 041b42d33bf5..8a545954eec7 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -152,7 +152,6 @@ struct evsel {
>  		struct bperf_leader_bpf *leader_skel;
>  		struct bperf_follower_bpf *follower_skel;
>  	};
> -	unsigned long		open_flags;
>  	int			precise_ip_original;
>  
>  	/* for missing_features */
> -- 
> 2.25.1
> 
