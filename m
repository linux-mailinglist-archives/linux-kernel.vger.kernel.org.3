Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36975982DE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244527AbiHRMEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244479AbiHRMEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:04:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8120895EB;
        Thu, 18 Aug 2022 05:04:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id e13so1579232edj.12;
        Thu, 18 Aug 2022 05:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=epVRuEfdEDYUlG3EB1G1lfmyQEEMQQhsfHFNQYC2RJc=;
        b=XMuB3EuJ7Ml/AoCrVB8jvl+UUpjRL2yblM0CPFQfIHIajRiAwBrlrCjPHLecUiICbk
         1+xeyvqsk2Xo5GQ1NQXvAh12GD+XWGlvAz4k698clJGDErV7B2zKLf+IE8SVHm57QmHC
         8Y8cXYRYhWJZ8q1kb2r/XH21NapCbJsBrBRi6cQl6xsvgotR9AOa3+E9iZC3rWM7i8/L
         BefThtuNTGFPoCIn6A0YGbWNPzkcwj25UNvukY9QHpgb/Ug5NRk9na6sIt69BqXptjaP
         Nz7pRWvUh64vg9pBj48l+LpXApvMxoS54wQdhDUgAcp37n32cmMLfl3PIa1WfOgizWPn
         ccbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=epVRuEfdEDYUlG3EB1G1lfmyQEEMQQhsfHFNQYC2RJc=;
        b=e8EyIMTKzw9lxbkktbfgqOX+IlLLTQhnlgmGfgSuQD1Ax0EANTD2mxkftTe6hPQINg
         9ChCYOqasaWBS7qQ8pYH/k3NvLDjkjmV3rR4iL702wEB3UpwlVSpI8hQX3yvhd/ML92S
         qQf69sgzQibxeeuGH2pfteA7jAUtfLbsWFPPRjesxRiFEtWbpyI3bXhwadxVztCTwRrE
         7f3Q8JA5cjvT/tS8ZTskRwUQ5RgGJe+Kc4tPuJGe9dmi5SzKXHGl03gY4KeoAcyKdiyB
         atqF4LiVR5WDlkDcTvVa14FUE++X1ml/lvTQ651jew4aLqzh84b6IWHh0zjoeppi6GV3
         CIBQ==
X-Gm-Message-State: ACgBeo2gY0vi1QFJZ/oLWHYXlqOylBZtU6Bfm7Z1YWcnDXT4jVvdEDkq
        OljHwclCKlfd8fx3gp3tXtA=
X-Google-Smtp-Source: AA6agR7Ohj4R+4cYl8liBBD5MR3+bCm44GDO6PWIAfHL/dWqFLmj0DqLZTt0LVrSyjlmL+0CnzIwdA==
X-Received: by 2002:a05:6402:2813:b0:442:bfc8:5d34 with SMTP id h19-20020a056402281300b00442bfc85d34mr2005642ede.114.1660824254092;
        Thu, 18 Aug 2022 05:04:14 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm737385ejd.101.2022.08.18.05.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 05:04:13 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 18 Aug 2022 14:04:11 +0200
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/4] perf tools: Support reading PERF_FORMAT_LOST
Message-ID: <Yv4qu8xMpfzUQ/8L@krava>
References: <20220816221747.275828-1-namhyung@kernel.org>
 <20220816221747.275828-5-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816221747.275828-5-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 03:17:47PM -0700, Namhyung Kim wrote:

SNIP

> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index a7b0931d5137..7753368d70d6 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -65,7 +65,8 @@ struct stack_dump {
>  
>  struct sample_read_value {
>  	u64 value;
> -	u64 id;
> +	u64 id;   /* only if PERF_FORMAT_ID */
> +	u64 lost; /* only if PERF_FORMAT_LOST */
>  };

I was wondering why not to split this patch into smaller piece,
but once you change this struct you break all the places

SNIP

> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1541,7 +1541,7 @@ static int evsel__read_one(struct evsel *evsel, int cpu_map_idx, int thread)
>  }
>  
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
> +	u64 nr, ena = 0, run = 0, lost = 0, i;
>  
>  	nr = *data++;
>  
> @@ -1573,16 +1574,25 @@ static int evsel__process_group_data(struct evsel *leader, int cpu_map_idx, int
>  
>  	v = (struct sample_read_value *) data;
>  
> -	evsel__set_count(leader, cpu_map_idx, thread, v[0].value, ena, run);
> +	if (read_format & PERF_FORMAT_LOST)
> +		lost = v->lost;
> +
> +	evsel__set_count(leader, cpu_map_idx, thread, v[0].value, ena, run, lost);
> +
> +	v = next_sample_read_value(v, read_format);

oneway of making this simpler here and share with other places
could be adding something like:

  for_each_group_data(v, i, nr, read_format) {
  }

but not sure how would that turn out, thoughts?

>  
>  	for (i = 1; i < nr; i++) {
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
> +		v = next_sample_read_value(v, read_format);
>  	}
>  
>  	return 0;
> @@ -2475,16 +2485,21 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  
>  			if (data->read.group.nr > max_group_nr)
>  				return -EFAULT;
> -			sz = data->read.group.nr *
> -			     sizeof(struct sample_read_value);
> +
> +			sz = data->read.group.nr * sample_read_value_size(read_format);
>  			OVERFLOW_CHECK(array, sz, max_size);
> -			data->read.group.values =
> -					(struct sample_read_value *)array;
> +			data->read.group.values = (void *)array;

nit, is this void casting needed?

thanks,
jirka

>  			array = (void *)array + sz;
>  		} else {
>  			OVERFLOW_CHECK_u64(array);
>  			data->read.one.id = *array;
>  			array++;
> +
> +			if (read_format & PERF_FORMAT_LOST) {
> +				OVERFLOW_CHECK_u64(array);
> +				data->read.one.lost = *array;
> +				array++;
> +			}
>  		}
>  	}
>  

SNIP
