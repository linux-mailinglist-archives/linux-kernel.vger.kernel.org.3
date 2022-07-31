Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E95D585EEA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 14:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbiGaMjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 08:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiGaMjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 08:39:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944F4DF8A;
        Sun, 31 Jul 2022 05:39:39 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i13so10609201edj.11;
        Sun, 31 Jul 2022 05:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=j65sAOKYqI+Uxv1jBk/p69AEquNqVjyqeGyH/PlKGl8=;
        b=QT7G8U6c2KAKqExmH16DbFOxqVACF96FT1etnfZAfBZRoPQqRi2oCom07LVhIxYtuT
         Wv6i4E4sEjG32iqikZ5yEi/A8tKid6IETe7/q8y1Owd4pTGtWGc7ESXBJETppN3xESpc
         2GPpeyHCGGMRvgppDMP+dKJ+aYc9nf4Z9uDNTg5ARUtrGs2cCC5SbeliplKXAFBDirkM
         dESBNN18pyTMWZKNSTqJq8I4Abz95cgxfYJg1E1U4m8z6d8KjOkgxjh6imL7lsNioQ8U
         ZMiL08M/0HlzNmAJmDbXSICE6QV+eUVZCQjD28EM+cY0qYM6+nUfzzCWzzrJKdc95H6E
         cm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=j65sAOKYqI+Uxv1jBk/p69AEquNqVjyqeGyH/PlKGl8=;
        b=eklihG/jdlRygjR6cT4mUIXpvD5bcmZNb0kzloC/2n4rnVRgzIzE2YsZ9hCID+eZEi
         YRetrDok8zT97vFnjZlm9Xp5Yg9gjw9weNwVe/koDGvt2o/WP/0VUYvRFKjEl0seNjlg
         1c7zphQstuogKsIyoDT8dQBjKCrc7d/QrffTrzGXXyO9eQDjvII5JR1ul2ucHKpOlVqC
         oXsVZuOY0n4g/5bW2hbAh3NMGPyatwBCQXCYpy3jhebCB08K8dcyu94LJ5BH1FRyk67n
         bM2HZUGbazZo5VzxYPRHga8tLKHyo2PyRTF4XXbS37fzt2Msvz0SJmn077rhL2c3Jwuu
         1JIQ==
X-Gm-Message-State: AJIora+i+9MkNij18Jnb5kFpfywyW+yiZlcrOCE1oEc3LkC8FJziEyL3
        O993DixvIq4ezpxQ+zMicp4=
X-Google-Smtp-Source: AGRyM1uKxYs2rRscg8zn4DVKKdNeX1xhPibA8eIExfAl5Slk9njR0VsLOwgGlsD3DNinYFXH2rE7Mw==
X-Received: by 2002:a05:6402:294c:b0:43a:91a9:a691 with SMTP id ed12-20020a056402294c00b0043a91a9a691mr11513929edb.182.1659271178098;
        Sun, 31 Jul 2022 05:39:38 -0700 (PDT)
Received: from krava ([83.240.61.175])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090626ca00b007262b7afa05sm3993497ejc.213.2022.07.31.05.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 05:39:37 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 31 Jul 2022 14:39:36 +0200
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Colin Ian King <colin.king@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 6/6] perf cpumap: Add range data encoding
Message-ID: <YuZ4CEnken8U4HO5@krava>
References: <20220614143353.1559597-1-irogers@google.com>
 <20220614143353.1559597-7-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614143353.1559597-7-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 07:33:53AM -0700, Ian Rogers wrote:

SNIP

> +	event = cpu_map_data__alloc(&syn_data, sizeof(struct perf_event_header));
>  	if (!event)
>  		return NULL;
>  
> +	syn_data.data = &event->data;
>  	event->header.type = PERF_RECORD_CPU_MAP;
> -	event->header.size = size;
> -	event->data.type   = type;
> -
> -	cpu_map_data__synthesize(&event->data, map, type, max);
> +	event->header.size = syn_data.size;
> +	cpu_map_data__synthesize(&syn_data);
>  	return event;
>  }
>  
> +
>  int perf_event__synthesize_cpu_map(struct perf_tool *tool,
>  				   const struct perf_cpu_map *map,
>  				   perf_event__handler_t process,
> @@ -1891,24 +1894,20 @@ int perf_event__synthesize_event_update_name(struct perf_tool *tool, struct evse
>  int perf_event__synthesize_event_update_cpus(struct perf_tool *tool, struct evsel *evsel,
>  					     perf_event__handler_t process)
>  {
> -	size_t size = sizeof(struct perf_event_header) + sizeof(u64) + sizeof(u64);
> +	struct synthesize_cpu_map_data syn_data = { .map = evsel->core.own_cpus };
>  	struct perf_record_event_update *ev;
> -	int max, err;
> -	u16 type;
> -
> -	if (!evsel->core.own_cpus)
> -		return 0;

all seems fine, just looks like we no longer do this check,
might not be needed anymore, as that changed in past

thanks,
jirka

> +	int err;
>  
> -	ev = cpu_map_data__alloc(evsel->core.own_cpus, &size, &type, &max);
> +	ev = cpu_map_data__alloc(&syn_data, sizeof(struct perf_event_header) + 2 * sizeof(u64));
>  	if (!ev)
>  		return -ENOMEM;
>  
> +	syn_data.data = &ev->cpus.cpus;
>  	ev->header.type = PERF_RECORD_EVENT_UPDATE;
> -	ev->header.size = (u16)size;
> +	ev->header.size = (u16)syn_data.size;
>  	ev->type	= PERF_EVENT_UPDATE__CPUS;
>  	ev->id		= evsel->core.id[0];
> -
> -	cpu_map_data__synthesize(&ev->cpus.cpus, evsel->core.own_cpus, type, max);
> +	cpu_map_data__synthesize(&syn_data);
>  
>  	err = process(tool, (union perf_event *)ev, NULL, NULL);
>  	free(ev);
> -- 
> 2.36.1.476.g0c4daa206d-goog
> 
