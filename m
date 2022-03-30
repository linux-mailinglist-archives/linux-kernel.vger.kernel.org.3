Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926DB4EC5F7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344013AbiC3Nwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346440AbiC3NwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:52:23 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6337611BD8D;
        Wed, 30 Mar 2022 06:50:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id pv16so41706601ejb.0;
        Wed, 30 Mar 2022 06:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gWM9GkYB6rAmCs70UAZyJQ/xD+eIZEEf12p6v+nGrXY=;
        b=AJhm1Zv3k6eIdhiszXAF8EvtqvdO40tkAnxwlsiYleE730PfqQV0yJgMsC6GD+2pXO
         wPTWcpMwtLwzRACJ3MaooeFIlNE8Glc4dcKN9SOdOkhzmiNQ5aVmA+eswLL9eocB0hvh
         49MOArWphhLrGIcb6NqOYHG+0e/BdCOmMW6JPg5JqA7mh8K+TDaEoKCEXar/dg/AEPFm
         YydXNLx0EBeQAzpboYF7gnhU3KGvYUJFupa9a5eN4z8wND5BFHyanaXzedNT+3Syhbje
         nhYvg5yuotbDj50tT5qfDRQG118DXigafVKsRnzpZ7mayS7FCoE3ulWGEHD+UNJwjat7
         tEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gWM9GkYB6rAmCs70UAZyJQ/xD+eIZEEf12p6v+nGrXY=;
        b=3pk/kkqrJi/rvmIIKMzXrUY7oQlYsRFHJndM9Flw+oUKPa6Cq4xn5V78/pcRtphGp3
         Esii0hDZFCjmIQ7INWrPipX698zlzdy47/L+3b2WJ5wizc5x93PAa6FaQ2GoJFKO5wCk
         VIk0/0DYrZ2AeaX5pdGkRb/2pgMFaTTfDtPTH4hMI0TezOONmk5+6iGaw4Vlht2qVnrE
         kYPBMNJxuZIv2SIFDqDkvBN9GF6XC8kcvTWOkD+hZVXVScoB9kxItj820dhy17xHB8Ly
         OAkaMPOvi7D3LTg3GV7w+aZdDC72qF9MNgegOj0ZZ07hHk85gwsOVojWffmK1b/UE2Xz
         biSQ==
X-Gm-Message-State: AOAM531Xi0tqMWJf6p6WY30/Ums7NnxEx05mr8UVRIsV4ddNMEIFf5Eg
        nKrc+ijtwRoQcaHeDXTBiIVd9vToZ/5mbw==
X-Google-Smtp-Source: ABdhPJx9A2W7Hj+/nb97bJlGbZ1JkbzEdSNhof9ExqMNyJJOsk/b5A8l7Hwe+ApBDjPs2ZK5P22qEg==
X-Received: by 2002:a17:906:c113:b0:6d7:7b53:9cb with SMTP id do19-20020a170906c11300b006d77b5309cbmr40923926ejc.197.1648648231512;
        Wed, 30 Mar 2022 06:50:31 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id s6-20020a170906778600b006dfc5be1ce0sm8289156ejm.146.2022.03.30.06.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 06:50:31 -0700 (PDT)
Date:   Wed, 30 Mar 2022 15:50:28 +0200
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/7] libperf: Introduce perf_{evsel,
 evlist}__open_opt with extensible struct opts
Message-ID: <YkRgJI913TCCCY2S@krava>
References: <20220325043829.224045-1-nakamura.shun@fujitsu.com>
 <20220325043829.224045-5-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325043829.224045-5-nakamura.shun@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 01:38:26PM +0900, Shunsuke Nakamura wrote:
> Introduce perf_{evsel, evlist}__open_opt with extensible structure opts.
> The mechanism of the extensible structure opts imitates
> tools/lib/bpf/libbpf.h. This allows the user to set the open_flags
> specified in perf_event_open and a signal handler to receive overflow
> notifications for sampling events.
> 
> Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> ---
>  tools/lib/perf/Documentation/libperf.txt |  14 +++
>  tools/lib/perf/evlist.c                  |  20 +++++
>  tools/lib/perf/evsel.c                   | 105 +++++++++++++++++++++++
>  tools/lib/perf/include/perf/evlist.h     |   3 +
>  tools/lib/perf/include/perf/evsel.h      |  26 ++++++
>  tools/lib/perf/internal.h                |  44 ++++++++++
>  tools/lib/perf/libperf.map               |   2 +
>  7 files changed, 214 insertions(+)
> 
> diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> index ae55e62fc4ce..700c1ce15159 100644
> --- a/tools/lib/perf/Documentation/libperf.txt
> +++ b/tools/lib/perf/Documentation/libperf.txt
> @@ -131,6 +131,20 @@ SYNOPSIS
>            };
>    };
>  
> +  struct perf_evsel_open_opts {
> +          /* size of this struct, for forward/backward compatibility */
> +          size_t sz;
> +
> +          unsigned long open_flags;       /* perf_event_open flags */
> +          int flags;                      /* fcntl flags */
> +          unsigned int signal;
> +          int owner_type;
> +          struct sigaction *sig;
> +  };
> +  #define perf_evsel_open_opts__last_field sig
> +
> +  #define LIBPERF_OPTS(TYPE, NAME, ...)
> +

SNIP

> +
> +int perf_evsel__open_opts(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
> +			  struct perf_thread_map *threads,
> +			  struct perf_evsel_open_opts *opts)
> +{
> +	int err = 0;
> +
> +	if (!OPTS_VALID(opts, perf_evsel_open_opts)) {
> +		err = -EINVAL;
> +		return err;
> +	}
> +
> +	evsel->open_flags = OPTS_GET(opts, open_flags, 0);
> +
> +	err = perf_evsel__open(evsel, cpus, threads);
> +	if (err)
> +		return err;
> +
> +	err = perf_evsel__set_signal_handler(evsel, opts);
> +	if (err)
> +		return err;

please move the signal stuff handling into separate patch
together with the related fields in opts struct

thanks,
jirka

> +
> +	return err;
> +}
> diff --git a/tools/lib/perf/include/perf/evlist.h b/tools/lib/perf/include/perf/evlist.h
> index 9ca399d49bb4..6eff1e9b3481 100644
> --- a/tools/lib/perf/include/perf/evlist.h
> +++ b/tools/lib/perf/include/perf/evlist.h
> @@ -9,6 +9,7 @@ struct perf_evlist;
>  struct perf_evsel;
>  struct perf_cpu_map;
>  struct perf_thread_map;
> +struct perf_evsel_open_opts;
>  
>  LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
>  				  struct perf_evsel *evsel);
> @@ -47,4 +48,6 @@ LIBPERF_API struct perf_mmap *perf_evlist__next_mmap(struct perf_evlist *evlist,
>  	     (pos) = perf_evlist__next_mmap((evlist), (pos), overwrite))
>  
>  LIBPERF_API void perf_evlist__set_leader(struct perf_evlist *evlist);
> +LIBPERF_API int perf_evlist__open_opts(struct perf_evlist *evlist,
> +				       struct perf_evsel_open_opts *opts);
>  #endif /* __LIBPERF_EVLIST_H */
> diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
> index 360ced734add..ecf30bc6303f 100644
> --- a/tools/lib/perf/include/perf/evsel.h
> +++ b/tools/lib/perf/include/perf/evsel.h
> @@ -5,6 +5,7 @@
>  #include <stdint.h>
>  #include <perf/core.h>
>  #include <stdbool.h>
> +#include <signal.h>
>  #include <linux/types.h>
>  
>  struct perf_evsel;
> @@ -23,6 +24,27 @@ struct perf_counts_values {
>  	};
>  };
>  
> +struct perf_evsel_open_opts {
> +	/* size of this struct, for forward/backward compatibility */
> +	size_t sz;
> +
> +	unsigned long open_flags;	/* perf_event_open flags */
> +	int flags;			/* fcntl flags */
> +	unsigned int signal;
> +	int owner_type;
> +	struct sigaction *sig;
> +};
> +#define perf_evsel_open_opts__last_field sig
> +
> +#define LIBPERF_OPTS(TYPE, NAME, ...)			\
> +	struct TYPE NAME = ({				\
> +		memset(&NAME, 0, sizeof(struct TYPE));	\
> +		(struct TYPE) {				\
> +			.sz = sizeof(struct TYPE),	\
> +			__VA_ARGS__			\
> +		};					\
> +	})
> +
>  LIBPERF_API struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr);
>  LIBPERF_API void perf_evsel__delete(struct perf_evsel *evsel);
>  LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
> @@ -48,5 +70,9 @@ LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel
>  LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
>  LIBPERF_API void perf_counts_values__scale(struct perf_counts_values *count,
>  					   bool scale, __s8 *pscaled);
> +LIBPERF_API int perf_evsel__open_opts(struct perf_evsel *evsel,
> +				      struct perf_cpu_map *cpus,
> +				      struct perf_thread_map *threads,
> +				      struct perf_evsel_open_opts *opts);
>  
>  #endif /* __LIBPERF_EVSEL_H */
> diff --git a/tools/lib/perf/internal.h b/tools/lib/perf/internal.h
> index 2c27e158de6b..637bf6793c26 100644
> --- a/tools/lib/perf/internal.h
> +++ b/tools/lib/perf/internal.h
> @@ -20,4 +20,48 @@ do {                            \
>  #define pr_debug2(fmt, ...)     __pr(LIBPERF_DEBUG2, fmt, ##__VA_ARGS__)
>  #define pr_debug3(fmt, ...)     __pr(LIBPERF_DEBUG3, fmt, ##__VA_ARGS__)
>  
> +static inline bool libperf_is_mem_zeroed(const char *p, ssize_t len)
> +{
> +	while (len > 0) {
> +		if (*p)
> +			return false;
> +		p++;
> +		len--;
> +	}
> +	return true;
> +}
> +
> +static inline bool libperf_validate_opts(const char *opts,
> +					 size_t opts_sz, size_t user_sz,
> +					 const char *type_name)
> +{
> +	if (user_sz < sizeof(size_t)) {
> +		pr_warning("%s size (%zu) is too small\n", type_name, user_sz);
> +		return false;
> +	}
> +	if (!libperf_is_mem_zeroed(opts + opts_sz, (ssize_t)user_sz - opts_sz)) {
> +		pr_warning("%s has non-zero extra bytes\n", type_name);
> +		return false;
> +	}
> +	return true;
> +}
> +
> +# define offsetofend(TYPE, FIELD) \
> +	(offsetof(TYPE, FIELD) + sizeof(((TYPE *)0)->FIELD))
> +
> +#define OPTS_VALID(opts, type)							\
> +	(!(opts) || libperf_validate_opts((const char *)opts,			\
> +					  offsetofend(struct type,		\
> +						      type##__last_field),	\
> +						(opts)->sz, #type))
> +#define OPTS_HAS(opts, field) \
> +	((opts) && opts->sz >= offsetofend(typeof(*(opts)), field))
> +#define OPTS_GET(opts, field, fallback_value) \
> +	(OPTS_HAS(opts, field) ? (opts)->field : fallback_value)
> +#define OPTS_SET(opts, field, value)		\
> +	do {					\
> +		if (OPTS_HAS(opts, field))	\
> +			(opts)->field = value;	\
> +	} while (0)
> +
>  #endif /* __LIBPERF_INTERNAL_H */
> diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> index ab0f44e9bb57..534614fbbb26 100644
> --- a/tools/lib/perf/libperf.map
> +++ b/tools/lib/perf/libperf.map
> @@ -24,6 +24,7 @@ LIBPERF_0.0.1 {
>  		perf_evsel__enable;
>  		perf_evsel__disable;
>  		perf_evsel__open;
> +		perf_evsel__open_opts;
>  		perf_evsel__close;
>  		perf_evsel__mmap;
>  		perf_evsel__munmap;
> @@ -39,6 +40,7 @@ LIBPERF_0.0.1 {
>  		perf_evlist__new;
>  		perf_evlist__delete;
>  		perf_evlist__open;
> +		perf_evlist__open_opts;
>  		perf_evlist__close;
>  		perf_evlist__enable;
>  		perf_evlist__disable;
> -- 
> 2.25.1
> 
