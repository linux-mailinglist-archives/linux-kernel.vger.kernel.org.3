Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335FE5AE8EF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239313AbiIFM77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbiIFM7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:59:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07B6DF96;
        Tue,  6 Sep 2022 05:59:49 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t14so8055267wrx.8;
        Tue, 06 Sep 2022 05:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=IsZ8Acj8HiY+PCYcQooZPNnZ71Fe9MyumAj9Qy4yqCM=;
        b=lYQWhFaxQ7C4+N6fAciUhuIz+j+n7PULoCJWBlbV/UeL+uHlD9wmxtP/MQY6JNrcD+
         CiwjI4TFDssXd0DpOU9hTXhIkbsPinBp61WUz5BY0CGvs/u8ogjjlBV9jDkvDK4vAVEg
         zJAQu9bJfCD8tZP2XngsTmUQTaQmL3OXO9myGvwHJR2xBKAGbOrQPv6d55iLit8ndmgP
         uN0cKTWb3oWAUcaAg2YdapZMPoabzQNyX0JP6qZzVVESDjEUZ1dPux70hI3j0qqJ8G5v
         VpXOF2k3SdZUJfHpibewEIWA6MMrq+u/OtTJGRfsS1wkxMN5+lnaAfo71c0STZG0qMq9
         rJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=IsZ8Acj8HiY+PCYcQooZPNnZ71Fe9MyumAj9Qy4yqCM=;
        b=CQVA7XXhcsyEJ+36Dwj7/7NqYOrwf2MuwdXq36CR1AYXk8Y6v9jmji93h6NJ5cX9Py
         6eHculMTy8H2HheGN65TKcW0kbBii9n69qNFjs1MZ23iu6AEesR/iRxrOvr4vUeQPXTo
         MJMO7HPvpqH560TkxW1NhdL7VrMVX+dZhFoXfEq7PMb8h3slEWbNsugcmOYi5suRB7EU
         HqMWWNCT3isUhXx75PGGvpE43o5y9uZ97lpOFS5jUZpsQIp98Kn9QqtenJ2W28ELYowt
         oOXSrxiq6bNeyHojAoD2l4ytJtHaDHCVA3ylRvKwiTQN1becEwQsN9SpzOYjTDcnuEw4
         8kXQ==
X-Gm-Message-State: ACgBeo2/nA6Ecd0NOL6yul4gT/rsRsjocdaiLzjDcdK72SAO3zvhq/c+
        JI93fo1WklAdF+jy5XrXpG0=
X-Google-Smtp-Source: AA6agR6trd0TkDiP1QmabzfEvmwWPQkxNAeNdfqfALYBfVIz+4suNcNYVNTc6FgECQlFXZj5WNqvdg==
X-Received: by 2002:a5d:45c4:0:b0:228:9248:867d with SMTP id b4-20020a5d45c4000000b002289248867dmr5319373wrs.474.1662469188224;
        Tue, 06 Sep 2022 05:59:48 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c4fd000b003a5c999cd1asm18772015wmq.14.2022.09.06.05.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 05:59:47 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 6 Sep 2022 14:59:46 +0200
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH V2] libperf evlist: Fix per-thread mmaps for
 multi-threaded targets
Message-ID: <YxdEQkmkZjBC6wGb@krava>
References: <20220905114209.8389-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905114209.8389-1-adrian.hunter@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 02:42:09PM +0300, Adrian Hunter wrote:

SNIP

> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index e6c98a6e3908..6b1bafe267a4 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -486,6 +486,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  			if (ops->idx)
>  				ops->idx(evlist, evsel, mp, idx);
>  
> +			pr_debug("idx %d: mmapping fd %d\n", idx, *output);
>  			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
>  				return -1;
>  
> @@ -494,6 +495,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  			if (!idx)
>  				perf_evlist__set_mmap_first(evlist, map, overwrite);
>  		} else {
> +			pr_debug("idx %d: set output fd %d -> %d\n", idx, fd, *output);
>  			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
>  				return -1;
>  
> @@ -519,6 +521,48 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  	return 0;
>  }
>  
> +static int
> +mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
> +		struct perf_mmap_param *mp)
> +{
> +	int nr_threads = perf_thread_map__nr(evlist->threads);
> +	int nr_cpus    = perf_cpu_map__nr(evlist->all_cpus);
> +	int cpu, thread, idx = 0;
> +	int nr_mmaps = 0;
> +
> +	pr_debug("%s: nr cpu values (may include -1) %d nr threads %d\n",
> +		 __func__, nr_cpus, nr_threads);

-1 as cpu value is only for 'empty' perf_cpu_map, right?

> +
> +	/* per-thread mmaps */
> +	for (thread = 0; thread < nr_threads; thread++, idx++) {
> +		int output = -1;
> +		int output_overwrite = -1;
> +
> +		if (mmap_per_evsel(evlist, ops, idx, mp, 0, thread, &output,
> +				   &output_overwrite, &nr_mmaps))
> +			goto out_unmap;
> +	}
> +
> +	/* system-wide mmaps i.e. per-cpu */
> +	for (cpu = 1; cpu < nr_cpus; cpu++, idx++) {
> +		int output = -1;
> +		int output_overwrite = -1;
> +
> +		if (mmap_per_evsel(evlist, ops, idx, mp, cpu, 0, &output,
> +				   &output_overwrite, &nr_mmaps))
> +			goto out_unmap;
> +	}

will this loop be executed? we are in here because all_cpus is empty, right?

thanks,
jirka

> +
> +	if (nr_mmaps != evlist->nr_mmaps)
> +		pr_err("Miscounted nr_mmaps %d vs %d\n", nr_mmaps, evlist->nr_mmaps);
> +
> +	return 0;
> +
> +out_unmap:
> +	perf_evlist__munmap(evlist);
> +	return -1;
> +}

SNIP
