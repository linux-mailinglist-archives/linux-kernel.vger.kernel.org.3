Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0B04DE2A7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240729AbiCRUlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 16:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240614AbiCRUl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:41:27 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F472467C8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:40:08 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a8so19199202ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pzFK/L8jrb4SpzZ3v4GeCIos+dZnAZe5Zkw5DCwe97I=;
        b=mjpANjH7f8JLct/KJ9f4LFEERuTp0htS9e48xmZcucHY2F80rDh1IK0jtzKzqY+1IF
         4N7hHkHVUTYISboJRjmKklJjCBzwA/NA90tG2BRhBMDhdhjzX54FdL+Gpmh6v3/WBg+i
         tt0rHfybejtyYbm+YoKRv4kQUQ2hL9oZTrE6cxt4dvEEPfQx/JexbwUNdBie4++LG0iF
         05sA1rN3mum8FJ2U8EesrYgCckal5QBuaUATRaMgI55Mrj3VmkP2BMvXQw+6hvUe2gYe
         7wImWsYF9hYHMF4x+WP74VH0ttzHhmzi3SxYHpOv3uDp2mrfqw4J5htr7e1xtpejAGBV
         cHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pzFK/L8jrb4SpzZ3v4GeCIos+dZnAZe5Zkw5DCwe97I=;
        b=jcdYQipidddxEgoRhUllnlThtt6UZFWIYmEReiLTgD7BFPuxdF0Npa9tashouliwbi
         /ePPPuUf9mvpPj9V/2oVua36G7ydpO/Ih+4w3LyMcntCs8lhbhfIGWNf8IauUJEWFUwc
         KPDunUMfiPJj0vW19jR0HTnWA91yZvivqw4hgWxjOVnEmo+QxiAYu5889nH+VxpwD2KG
         oZMj647k8wV2GkGu29jwNm/ZF7vKG1AuJeBevKwr6sMRYrG+SngasZV8kLTxH9vn8Jki
         wfK2UFchq+MqEgJGfSJGdHRtKLEgowZm+D8lVrUCULUZ7W3V070kcT395mYTVvQc4ePt
         JpZw==
X-Gm-Message-State: AOAM5331kj/Xu/bTbVR+MLx5PIpP9/igtvl0ITEvnjITJq2s36tlMnZN
        TXZdvNvMIEZK7BiMTjt281E=
X-Google-Smtp-Source: ABdhPJxg7ZgCLA60dgAE7NbXoT6njOvCfjxIWb6dYSD0ANfEhfQP1qM2O/mPHnBl1EP9uCJsw+TI0g==
X-Received: by 2002:a17:906:743:b0:6d0:7f19:d737 with SMTP id z3-20020a170906074300b006d07f19d737mr10894755ejb.11.1647636006367;
        Fri, 18 Mar 2022 13:40:06 -0700 (PDT)
Received: from krava ([83.240.61.119])
        by smtp.gmail.com with ESMTPSA id o2-20020a50d802000000b00410d7f0c52csm4697707edj.8.2022.03.18.13.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 13:40:06 -0700 (PDT)
Date:   Fri, 18 Mar 2022 21:40:04 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf evlist: Avoid iteration for empty evlist.
Message-ID: <YjTuJLklOMmavh5C@krava>
References: <20220317231643.550902-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317231643.550902-1-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 04:16:43PM -0700, Ian Rogers wrote:
> As seen with 'perf stat --null ..' and reported in:
> https://lore.kernel.org/lkml/YjCLcpcX2peeQVCH@kernel.org/
> 
> v2. Avoids setting evsel in the empty list case as suggested by Jiri
>     Olsa <jolsa@kernel.org>.
> Fixes: 472832d2c000 ("perf evlist: Refactor evlist__for_each_cpu()")
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/evlist.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 8134d45e2164..9bb79e049957 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -346,7 +346,7 @@ struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affin
>  {
>  	struct evlist_cpu_iterator itr = {
>  		.container = evlist,
> -		.evsel = evlist__first(evlist),
> +		.evsel = NULL,
>  		.cpu_map_idx = 0,
>  		.evlist_cpu_map_idx = 0,
>  		.evlist_cpu_map_nr = perf_cpu_map__nr(evlist->core.all_cpus),
> @@ -354,16 +354,22 @@ struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affin
>  		.affinity = affinity,
>  	};
>  
> -	if (itr.affinity) {
> -		itr.cpu = perf_cpu_map__cpu(evlist->core.all_cpus, 0);
> -		affinity__set(itr.affinity, itr.cpu.cpu);
> -		itr.cpu_map_idx = perf_cpu_map__idx(itr.evsel->core.cpus, itr.cpu);
> -		/*
> -		 * If this CPU isn't in the evsel's cpu map then advance through
> -		 * the list.
> -		 */
> -		if (itr.cpu_map_idx == -1)
> -			evlist_cpu_iterator__next(&itr);
> +	if (evlist__empty(evlist)) {
> +		/* Ensure the empty list doesn't iterate. */
> +		itr.evlist_cpu_map_idx = itr.evlist_cpu_map_nr;
> +	} else {
> +		itr.evsel = evlist__first(evlist);
> +		if (itr.affinity) {
> +			itr.cpu = perf_cpu_map__cpu(evlist->core.all_cpus, 0);
> +			affinity__set(itr.affinity, itr.cpu.cpu);
> +			itr.cpu_map_idx = perf_cpu_map__idx(itr.evsel->core.cpus, itr.cpu);
> +			/*
> +			 * If this CPU isn't in the evsel's cpu map then advance
> +			 * through the list.
> +			 */
> +			if (itr.cpu_map_idx == -1)
> +				evlist_cpu_iterator__next(&itr);
> +		}
>  	}
>  	return itr;
>  }
> -- 
> 2.35.1.894.gb6a874cedc-goog
> 
