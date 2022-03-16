Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4024DB228
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353250AbiCPOJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348167AbiCPOJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:09:19 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6164B1B794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:08:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x34so1698785ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YTDqw/5RM7YTLcdoQN/6vy9qbsuM8ujEuNCDTNyOkUc=;
        b=dS0ZHLlr9VYdZaIZuQwLGg/uleRLpFu4ZRfzKvlqmo29yUE3OCGy09ulvtcq5LWZ4W
         5nvsHJoU/dyXM4em8NfzUHVJDh0jo2uJqGWZtXkWEtPn4XqShmoMqR/bREeyQx4CoPIJ
         FclozGehgqwrp+LigEZgla6NFB9806zM1fwtPn9/FA/HFh1fa7Pc+kRfN6T6kwz1OerD
         knzHff7SqiGLK0uA5kwHQQqn1WeWmeh/ik827QfZZKUUG61sXKlO2C6ZtcwMKlBX47wG
         jtIpMpJbtgXuLpg1AfYcbw00+n0CkGrIGPys2Nux6FXmsUL0ypHemoAmIOBp45HDVzNT
         d2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YTDqw/5RM7YTLcdoQN/6vy9qbsuM8ujEuNCDTNyOkUc=;
        b=ce2VVpKHr2nKq3Bxsr7HGJJH+tk9azSho17qGCqvKEGkX+k13lUHlVkIa0VkUupYCL
         O8NlqLizSDt4GOz3OgD5NprEbMxzEjZQ3zJHCxNSJYMDwmEBcaUDuaXgKqAdidAQGwuQ
         DHCa9MbJCrKc1zazWYxkEkplEihZmRIZgRTMMJ8BNI5Qckom1Vq2QjpQGoD5sXw/WHmT
         NmcWzUkCfbQWJJqjMNR9/GBCbJcL55l43pNd9X3KtDpkVd7iS+6Ap9c81zqqPczb4l2G
         gcUyEtwq5kjAqc0eD38ZehqFqcG4FlcINy3RUiomq/7rYgluiHrd4ZD2JgJeSMWRCSs1
         /Fxw==
X-Gm-Message-State: AOAM530HH5yz+1GHVPPGaQM9+F4/muTMQHNGXjFiIEdNqk+eoNK1ZEiU
        nFLR1urDF2p777Lm0U3A1vo=
X-Google-Smtp-Source: ABdhPJysE8PWjinnBDesUD3wHYzWGFtqUT6mMAqwa+Ti0b3fEcnNNeqaaf8r0vAYj259hq35kj4lXw==
X-Received: by 2002:a05:6402:847:b0:418:95d4:9126 with SMTP id b7-20020a056402084700b0041895d49126mr11184704edz.152.1647439683231;
        Wed, 16 Mar 2022 07:08:03 -0700 (PDT)
Received: from krava ([83.240.61.119])
        by smtp.gmail.com with ESMTPSA id a22-20020a50ff16000000b00410d029ea5csm996983edu.96.2022.03.16.07.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 07:08:02 -0700 (PDT)
Date:   Wed, 16 Mar 2022 15:08:00 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf evlist: Avoid iteration for empty evlist.
Message-ID: <YjHvB4q7VZyKsIUU@krava>
References: <20220316071049.2368250-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316071049.2368250-1-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 12:10:49AM -0700, Ian Rogers wrote:
> As seen with 'perf stat --null ..' and reported in:
> https://lore.kernel.org/lkml/YjCLcpcX2peeQVCH@kernel.org/
> 
> Fixes: 472832d2c000 ("perf evlist: Refactor evlist__for_each_cpu()")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evlist.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 8134d45e2164..a2dba9e00765 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -354,7 +354,10 @@ struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affin
>  		.affinity = affinity,
>  	};
>  
> -	if (itr.affinity) {
> +	if (evlist__empty(evlist)) {
> +		/* Ensure the empty list doesn't iterate. */
> +		itr.evlist_cpu_map_idx = itr.evlist_cpu_map_nr;

I can't see the crash anymore, but I'm bit confused with the code

if evlist is empty then itr.evsel is bogus.. and the loop code
__run_perf_stat is just lucky, right?

I think we need to set itr.evsel to NULL and skip the loop in
case evlist is empty

thanks,
jirka

> +	} else if (itr.affinity) {
>  		itr.cpu = perf_cpu_map__cpu(evlist->core.all_cpus, 0);
>  		affinity__set(itr.affinity, itr.cpu.cpu);
>  		itr.cpu_map_idx = perf_cpu_map__idx(itr.evsel->core.cpus, itr.cpu);
> -- 
> 2.35.1.723.g4982287a31-goog
> 
