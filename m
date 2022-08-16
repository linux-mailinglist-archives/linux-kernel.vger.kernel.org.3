Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BD4595D21
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiHPNUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbiHPNTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:19:53 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB85DF0;
        Tue, 16 Aug 2022 06:19:23 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id s11so13417125edd.13;
        Tue, 16 Aug 2022 06:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=qmHSiAZVfahNJyGDQHqY9RH0z385W5MNqPmTHwP/rM0=;
        b=RxFatrzfZbS95Eg3KXfsn18/tlkBlSKOXix79F8ldtLP7WNS4nnyylSkfkbNfZAyXa
         XNexvzCa0kZ2tW6DXUqWbXxlujxiLZ36wZ8LF6eYjxjWUmXADth7ljPGSsOili4BQ7to
         FEPC1bv/9wkt0GBW2Ug4ncOm3bn2wflANsD7PU4yZ6Q7mXqTozTZEZisoTtNhIwKGstH
         Hgv9PLnDxiyUsAcCa6ndeYF7DR1i9A+ntaEQ2QyNGHtlukeVvA87ntPIaz3rx+p9dsgv
         9fNcxM4FdP9HC6xNeVmCxcE0YgeSlEhuy5j9lNesX9XZ5sy5SyBwMH+LCRqmC81rwjPY
         DNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=qmHSiAZVfahNJyGDQHqY9RH0z385W5MNqPmTHwP/rM0=;
        b=vH8kC9TI18gzNknpRMTfjN/nn5aqE2qseXBN91x4Q0qZvP9lMzSlkYuHp9m7P9TjR1
         YuTulef/petl4oZqFwyScxc18ao0ywC4QLViqctacfRgnhPUfpdxJ5N/32lLiWDc0KnO
         b9aSPrBXi3xMyd41Mc79Ay3diJYiwWoS2WWYPvWRySHLuz4lZFMXkmwC6PkqE6EMqeh9
         bo+2iH1Sr2W3hijQE+jEAXJHjl3PMXjVj6BWqhwmAd+p7ctLFn5O33LwOsTyi2MvoJ6t
         98QU7+y6Pp3QsszlM5J21ewwq9blpPPCExTtVMl5SWq/J58usgB/1hOFXPRGKZ19qLYN
         vWoQ==
X-Gm-Message-State: ACgBeo3pTaE1OQHLKhDA9pJq3X/mVLxCbkj/ThSiHtYdHTChAJGo16k9
        MWl/9zusfoln2lUbC8CWkWpcGU4h3zebyQ==
X-Google-Smtp-Source: AA6agR5eqJMOuTyl7XBOWuq4mnBTsgrS/8h6hKrqf/TqzZKKZ0DHsNBaBwulO3l1ROSFKn9qUoxcYg==
X-Received: by 2002:a05:6402:3492:b0:43e:9666:ece2 with SMTP id v18-20020a056402349200b0043e9666ece2mr19078057edc.65.1660655962362;
        Tue, 16 Aug 2022 06:19:22 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id l13-20020a1709066b8d00b007262b9f7120sm5281259ejr.167.2022.08.16.06.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 06:19:22 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 16 Aug 2022 15:19:20 +0200
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/4] tools lib perf: Handle read format in
 perf_evsel__read()
Message-ID: <YvuZWAzsBVo/l9sf@krava>
References: <20220815190106.1293082-1-namhyung@kernel.org>
 <20220815190106.1293082-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815190106.1293082-3-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 12:01:04PM -0700, Namhyung Kim wrote:
> The perf_counts_values should be increased to read the new lost data.
> Also adjust values after read according the read format.
> 
> This supports PERF_FORMAT_GROUP which has a different data format but
> it's only available for leader events.  Currently it doesn't have an API
> to read sibling (member) events in the group.  But users may read the
> sibling event directly.
> 
> Also reading from mmap would be disabled when the read format has ID or
> LOST bit as it's not exposed via mmap.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/lib/perf/evsel.c              | 72 +++++++++++++++++++++++++++++
>  tools/lib/perf/include/perf/event.h |  3 +-
>  tools/lib/perf/include/perf/evsel.h |  4 +-
>  3 files changed, 77 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 952f3520d5c2..fc23670231cb 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -305,6 +305,9 @@ int perf_evsel__read_size(struct perf_evsel *evsel)
>  	if (read_format & PERF_FORMAT_ID)
>  		entry += sizeof(u64);
>  
> +	if (read_format & PERF_FORMAT_LOST)
> +		entry += sizeof(u64);
> +
>  	if (read_format & PERF_FORMAT_GROUP) {
>  		nr = evsel->nr_members;
>  		size += sizeof(u64);
> @@ -314,24 +317,93 @@ int perf_evsel__read_size(struct perf_evsel *evsel)
>  	return size;
>  }
>  
> +/* This only reads values for the leader */
> +static int perf_evsel__read_group(struct perf_evsel *evsel, int cpu_map_idx,
> +				  int thread, struct perf_counts_values *count)
> +{
> +	size_t size = perf_evsel__read_size(evsel);
> +	int *fd = FD(evsel, cpu_map_idx, thread);
> +	u64 read_format = evsel->attr.read_format;
> +	u64 *data;
> +	int idx = 1;
> +
> +	if (fd == NULL || *fd < 0)
> +		return -EINVAL;
> +
> +	data = calloc(1, size);
> +	if (data == NULL)
> +		return -ENOMEM;
> +
> +	if (readn(*fd, data, size) <= 0) {
> +		free(data);
> +		return -errno;
> +	}

could you please put in here some comment that this is intentionaly
reading only the leader or better yet rename the function? I was lost
before I got to read the changelog ;-)

> +
> +	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
> +		count->ena = data[idx++];
> +	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
> +		count->run = data[idx++];
> +
> +	/* value is always available */
> +	count->val = data[idx++];
> +	if (read_format & PERF_FORMAT_ID)
> +		count->id = data[idx++];
> +	if (read_format & PERF_FORMAT_LOST)
> +		count->lost = data[idx++];
> +
> +	free(data);
> +	return 0;
> +}
> +
> +/*
> + * The perf read format is very flexible.  It needs to set the proper
> + * values according to the read format.
> + */
> +static void perf_evsel__adjust_values(struct perf_evsel *evsel,
> +				      struct perf_counts_values *count)
> +{
> +	u64 read_format = evsel->attr.read_format;
> +
> +	if (!(read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)) {
> +		memmove(&count->values[2], &count->values[1], 24);
> +		count->ena = 0;
> +	}
> +
> +	if (!(read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)) {
> +		memmove(&count->values[3], &count->values[2], 16);
> +		count->run = 0;
> +	}
> +
> +	if (!(read_format & PERF_FORMAT_ID)) {
> +		memmove(&count->values[4], &count->values[3], 8);
> +		count->id = 0;
> +	}
> +}


could we do this the same way we read group counters.. like make read
into local buffer and initialize perf_counts_values values based on
format, something like:

        readn(fd, data ...

        if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
                count->ena = data[idx++];
        if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
                count->run = data[idx++];

        /* value is always available */
        count->val = data[idx++];
        if (read_format & PERF_FORMAT_ID)
                count->id = data[idx++];
        if (read_format & PERF_FORMAT_LOST)
                count->lost = data[idx++];


and perhaps we should cancel that perf_counts_values's union and keep
only 'val/ena/run...' fields?

jirka
