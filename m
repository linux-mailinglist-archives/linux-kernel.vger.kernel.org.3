Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A615E599A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348308AbiHSKx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348253AbiHSKxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:53:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E241764FA;
        Fri, 19 Aug 2022 03:53:22 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z2so5194517edc.1;
        Fri, 19 Aug 2022 03:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=NPpSz6ktDO5fa1yfZFM2OZbG2NPmxwqsyXUCh1i9xqE=;
        b=Z5Y4ajcULHG0GLRJqI3s1wxz0rkq+PFwYT2tPueMiXk3a0wf3lEx9Q2s/OYtnofnHs
         a4Uh2thJqE63NpYDeYon3WOzh7OgKnT7xWXr4dTAElIrrGK+n4Z+hvIedmmwuVINKWzQ
         h2dQMsSSBwPQa+c7zAUPY2LkklY90nht6gb3qGqFkh2UFM0mUT8YIX2Gq/fISyjIy6Mi
         HOpnF5k9lna8GfmlD7cXWeCNiXnp2z22mAFpl/aPq/BV8zPrzFlYK+NXoAF+APKm3txC
         +IeL2taNjhm9IwWUaDaBONEHBhdMuhC4f40TFySsklgSV0Tgrip2lQjCkjcmp4O/V9kC
         VzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=NPpSz6ktDO5fa1yfZFM2OZbG2NPmxwqsyXUCh1i9xqE=;
        b=oc6IsKoXTS/V9gooytFlUmLC5wfLFd3hJpckKzX3/D1OYxbK8PmiYZrGvwCPE50lvv
         R/MPEocZZXPMrfJvEs4yD/+IHHVuqIGygLGNVcyvYhflzvYXYnRbPrPAsJsZWQ3FN62H
         Nlj6u2C7V5krlpSX1UXeAKtBmI/KleWSAyWB/TIYkbKs7/M4LKm4H0mkcihzb0KuJ8Fg
         bBQ5kzI1fnAh5AqD/aEbcL2O60lIR6kMX5uwGcR3rLz0yhajb8Okz7uoPl2g9fBenHsJ
         bzsnAuX3nmT3JsmP4gW3J6NUUEnKMOOutCePAMTuwGL1ip+voSvSam/Y2idzrjySzrSD
         BM8w==
X-Gm-Message-State: ACgBeo0r02ElSNKM+NTeHGbnuFU0fhmZeAaMp63IHVEI1PLPHvh7YcCw
        CUmxDXcv4hXW8r/07Gnvhac=
X-Google-Smtp-Source: AA6agR58F6OPYpwtEJKO4T0tIaQigvcnQM4ixqzQmTBNGKRt1CrGleKeLNGId0gZpqloBIsi87ratQ==
X-Received: by 2002:a50:baa1:0:b0:43e:5e95:3eda with SMTP id x30-20020a50baa1000000b0043e5e953edamr5656257ede.340.1660906401496;
        Fri, 19 Aug 2022 03:53:21 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id z7-20020a17090665c700b007341663d7ddsm2174618ejn.96.2022.08.19.03.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 03:53:21 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 19 Aug 2022 12:53:18 +0200
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/4] perf tools: Support reading PERF_FORMAT_LOST
Message-ID: <Yv9rnnHFQ7qxOsag@krava>
References: <20220819003644.508916-1-namhyung@kernel.org>
 <20220819003644.508916-5-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819003644.508916-5-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 05:36:44PM -0700, Namhyung Kim wrote:

SNIP

>  static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
> -			     u64 val, u64 ena, u64 run)
> +			     u64 val, u64 ena, u64 run, u64 lost)
>  {
>  	struct perf_counts_values *count;
>  
> @@ -1550,6 +1550,7 @@ static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
>  	count->val    = val;
>  	count->ena    = ena;
>  	count->run    = run;
> +	count->lost   = lost;
>  
>  	perf_counts__set_loaded(counter->counts, cpu_map_idx, thread, true);
>  }
> @@ -1558,7 +1559,7 @@ static int evsel__process_group_data(struct evsel *leader, int cpu_map_idx, int
>  {
>  	u64 read_format = leader->core.attr.read_format;
>  	struct sample_read_value *v;
> -	u64 nr, ena = 0, run = 0, i;
> +	u64 nr, ena = 0, run = 0, lost = 0;
>  
>  	nr = *data++;
>  
> @@ -1571,18 +1572,18 @@ static int evsel__process_group_data(struct evsel *leader, int cpu_map_idx, int
>  	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
>  		run = *data++;
>  
> -	v = (struct sample_read_value *) data;
> -
> -	evsel__set_count(leader, cpu_map_idx, thread, v[0].value, ena, run);
> -
> -	for (i = 1; i < nr; i++) {
> +	v = (void *)data;

nit, we could leave the 'v' assignment above right?

jirka

> +	sample_read_group__for_each(v, nr, read_format) {
>  		struct evsel *counter;
>  
> -		counter = evlist__id2evsel(leader->evlist, v[i].id);
> +		counter = evlist__id2evsel(leader->evlist, v->id);
>  		if (!counter)
>  			return -EINVAL;
>  
> -		evsel__set_count(counter, cpu_map_idx, thread, v[i].value, ena, run);
> +		if (read_format & PERF_FORMAT_LOST)
> +			lost = v->lost;
> +
> +		evsel__set_count(counter, cpu_map_idx, thread, v->value, ena, run, lost);

SNIP
