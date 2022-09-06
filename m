Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BDA5AF4A8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiIFTpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIFTpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:45:18 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3707C76446;
        Tue,  6 Sep 2022 12:45:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gh9so3729055ejc.8;
        Tue, 06 Sep 2022 12:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=IvjgiEgsvkGUAgt8KiSYXHu54u57Qk5KGBecEOEMqDc=;
        b=ImgTx5OrGISz4NWZJ9G7eF4mOeKvJIXRf8LoLhTaGFv6SoFUK9QcVmAHdTOcemLisP
         HRj4kUb92expxR4XKdq6lJS1+BWFTIX2E5i5XB24h4QKLVJcrzrxgEJrvqOBZ1v961Kw
         UE60V+q4pB0cNklbY64jZdwt6mmaL9xUmne1Hmd8O1XvtvVOWLa9blsQdUovkdEtTtU8
         EClT3HXHJCiPK4YQuHVF4t7quyvKd5gaNCZLwSBXWhBgWDylqc5OB9YcDeJujXj3tV9V
         lZpvAByNI79GUcWGblnr3F9QjgcQbjV+61slr72QksFpGvBvgU2E4Yykg/zWffKrbQmo
         Mc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=IvjgiEgsvkGUAgt8KiSYXHu54u57Qk5KGBecEOEMqDc=;
        b=AWDS2IXSRYOABtaNd+YxpVvqbeDmWJJzPgO7aLUKZZgJyEPRZsHGLdZTAnkcsLAmGj
         lG+b4p7zzrHQPImRvOf0XpWus7+sqbAj+T2E6vj9SWib2nxuybAC2cT9QMvbnf6WgPEV
         0ddum2odRX75Dp7Se/YbewtAC9y0lLrPlh8LT0Pli2sOHPUmQczwQWYOvsWBEt7xJvk8
         EjBoXeZ3CfQM5OeZ32AMA9Jllwo7jbUD31K4QLvDwbfndjPCStX/gtEHdpYRXy54eQva
         CLVV/HhcACYROpUah51sQKJ+J+s11PzAQW/LaiSBa+PrNh0KSRG9eYZ9h17kLptlSK2+
         6L8g==
X-Gm-Message-State: ACgBeo0byGYRcW4ISoHpt/LHAf5qGbq+qw8V98I4tgd01+fmb6JM+CWF
        ovJZ2GqwnThF28oIaAjmFuA=
X-Google-Smtp-Source: AA6agR4C/ZlvryTOPOEhC2ZzUUamswZYK5ABqpZ115fyYtiQMAyN99tFcsx85yOaJ+73kT11WW0RQg==
X-Received: by 2002:a17:907:845:b0:731:2f6c:6dbd with SMTP id ww5-20020a170907084500b007312f6c6dbdmr29515ejb.551.1662493515527;
        Tue, 06 Sep 2022 12:45:15 -0700 (PDT)
Received: from krava ([83.240.62.96])
        by smtp.gmail.com with ESMTPSA id l16-20020a50d6d0000000b0044625884285sm9129694edj.49.2022.09.06.12.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 12:45:15 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 6 Sep 2022 21:45:08 +0200
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH V2] libperf evlist: Fix per-thread mmaps for
 multi-threaded targets
Message-ID: <YxejRK2/LO7QouOZ@krava>
References: <20220905114209.8389-1-adrian.hunter@intel.com>
 <YxdEQkmkZjBC6wGb@krava>
 <60b5c9bf-4ec9-957e-17dd-aa0a50411ff9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60b5c9bf-4ec9-957e-17dd-aa0a50411ff9@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 05:04:45PM +0300, Adrian Hunter wrote:
> On 6/09/22 15:59, Jiri Olsa wrote:
> > On Mon, Sep 05, 2022 at 02:42:09PM +0300, Adrian Hunter wrote:
> > 
> > SNIP
> > 
> >> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> >> index e6c98a6e3908..6b1bafe267a4 100644
> >> --- a/tools/lib/perf/evlist.c
> >> +++ b/tools/lib/perf/evlist.c
> >> @@ -486,6 +486,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
> >>  			if (ops->idx)
> >>  				ops->idx(evlist, evsel, mp, idx);
> >>  
> >> +			pr_debug("idx %d: mmapping fd %d\n", idx, *output);
> >>  			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
> >>  				return -1;
> >>  
> >> @@ -494,6 +495,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
> >>  			if (!idx)
> >>  				perf_evlist__set_mmap_first(evlist, map, overwrite);
> >>  		} else {
> >> +			pr_debug("idx %d: set output fd %d -> %d\n", idx, fd, *output);
> >>  			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
> >>  				return -1;
> >>  
> >> @@ -519,6 +521,48 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
> >>  	return 0;
> >>  }
> >>  
> >> +static int
> >> +mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
> >> +		struct perf_mmap_param *mp)
> >> +{
> >> +	int nr_threads = perf_thread_map__nr(evlist->threads);
> >> +	int nr_cpus    = perf_cpu_map__nr(evlist->all_cpus);
> >> +	int cpu, thread, idx = 0;
> >> +	int nr_mmaps = 0;
> >> +
> >> +	pr_debug("%s: nr cpu values (may include -1) %d nr threads %d\n",
> >> +		 __func__, nr_cpus, nr_threads);
> > 
> > -1 as cpu value is only for 'empty' perf_cpu_map, right?
> 
> The cpu map is a map of valid 3rd arguments to perf_event_open, so -1
> means all CPUs which is per-thread by necessity.
> 
> > 
> >> +
> >> +	/* per-thread mmaps */
> >> +	for (thread = 0; thread < nr_threads; thread++, idx++) {
> >> +		int output = -1;
> >> +		int output_overwrite = -1;
> >> +
> >> +		if (mmap_per_evsel(evlist, ops, idx, mp, 0, thread, &output,
> >> +				   &output_overwrite, &nr_mmaps))
> >> +			goto out_unmap;
> >> +	}
> >> +
> >> +	/* system-wide mmaps i.e. per-cpu */
> >> +	for (cpu = 1; cpu < nr_cpus; cpu++, idx++) {
> >> +		int output = -1;
> >> +		int output_overwrite = -1;
> >> +
> >> +		if (mmap_per_evsel(evlist, ops, idx, mp, cpu, 0, &output,
> >> +				   &output_overwrite, &nr_mmaps))
> >> +			goto out_unmap;
> >> +	}
> > 
> > will this loop be executed? we are in here because all_cpus is empty, right?
> 
> Yes it is executed.  I put back the code that was there before ae4f8ae16a07
> ("libperf evlist: Allow mixing per-thread and per-cpu mmaps"), which uses

hm, but commit ae4f8ae16a07 does not have similar cpu loop

> perf_cpu_map__empty() which only checks the first entry is -1:
> 
> bool perf_cpu_map__empty(const struct perf_cpu_map *map)
> {
> 	return map ? map->map[0].cpu == -1 : true;
> }
> 
> But there can be more CPUs in the map, so perf_cpu_map__empty()
> returns true for the per-thread case, as desired, even if there
> are also system-wide CPUs.

I don't see how, if I'd see -1 together with other cpu values in
perf_cpu_map I'd think it's a bug, but I might be missing some
auxtrace usage,

I thought we use -1 just for empty cpu map, so in per-thread case
-1 is properly passed to perf_event_open syscall

jirka

> 
> I guess perf_cpu_map__empty() needs renaming.
> 
> > 
> > thanks,
> > jirka
> > 
> >> +
> >> +	if (nr_mmaps != evlist->nr_mmaps)
> >> +		pr_err("Miscounted nr_mmaps %d vs %d\n", nr_mmaps, evlist->nr_mmaps);
> >> +
> >> +	return 0;
> >> +
> >> +out_unmap:
> >> +	perf_evlist__munmap(evlist);
> >> +	return -1;
> >> +}
> > 
> > SNIP
> 
