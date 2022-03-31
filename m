Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7754ED8AD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbiCaLqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiCaLqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:46:40 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C51208315;
        Thu, 31 Mar 2022 04:44:47 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dr20so47473869ejc.6;
        Thu, 31 Mar 2022 04:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AstwEy6sbT71FKbynsBECww/Cn1UAWSTeaB7mE9n2JA=;
        b=UoZ1B7Y2nSEs+OkR/tohs4nJVjDmYy4rq3GKzxjfr1nr9iUkq3WujR9bMfdoUAhiLj
         BOGootZflDZLs1Srx7wxbbrSjjKKmQrM7DI2I3h9OseiBb+Fnnmx96brtZebnxPjd093
         uiS+W5Ipj75ZlXT62dNc9coMg+f37tj2GTmz0iM6915ocKZA0FUIq6tX2W1ZofV2tFfW
         DwCE49g0KqP/E7sbcGqe26r85CxSD3+I3Hj9SdlPFuPknwnci2ni1aged8Pn0qBGbezS
         xLp3C59vhqdrt8C3JXM1g45TGm/9P5kz+7ITuFoQ5+qt2lSOstQ3WvO8qv/V1lNPIEyg
         3o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AstwEy6sbT71FKbynsBECww/Cn1UAWSTeaB7mE9n2JA=;
        b=AHNRYAJramd2kTr9xfSWh0eKqN4Y49D46iKYK+2T0HhhIdl1MHgGdY3Erx+5Wc/oLG
         +M94ddXYjlr2U/xa4ZobpngUdaSkxUE3tLW0IVPZASS0BWpS+/bbrljZDJm4//v6POsV
         pYlAXFlYLVMUQ9XeC6ym/nQJtKzAIh3jlhhxV10dL/Opmz0OR0I39G0hGVwFkOExC7uQ
         aAbw/+wlAu3jyz1H2xgjMmQPrZIVXiQzAmwabnzmHEBxeaa9OzOgh9yNRtBoM3xL6SFO
         UMoVVp+/7/41p+243uXkYfAvgJyP8EZtHkNxFe8wXT2XJadXu0Mbj/n+c/Nft8K/Elrr
         MXHg==
X-Gm-Message-State: AOAM530tZpz/jTtQyErJ/ZxfVh8bRxgS4iu00XcnH6IMD/6ZqphNNrs6
        4o/mn0fdha0i2SA12gSeTXU=
X-Google-Smtp-Source: ABdhPJzsMiSACkIutaukAiGPYkdDRxm1TnS7IAElimbeLAI9Hj9B7FlOKTQNBQdFgvowkOKxRyYkcg==
X-Received: by 2002:a17:906:f857:b0:6df:ae2d:73a0 with SMTP id ks23-20020a170906f85700b006dfae2d73a0mr4576732ejb.614.1648727086080;
        Thu, 31 Mar 2022 04:44:46 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id d23-20020aa7d5d7000000b00418f7b2f1dbsm11143598eds.71.2022.03.31.04.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 04:44:45 -0700 (PDT)
Date:   Thu, 31 Mar 2022 13:44:43 +0200
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Denis Nikitin <denik@chromium.org>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        jolsa@kernel.org, alexey.budankov@linux.intel.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        james.clark@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf session: Remap buf if there is no space for event
Message-ID: <YkWUK+1padnj2JB4@krava>
References: <20220330031130.2152327-1-denik@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330031130.2152327-1-denik@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 08:11:30PM -0700, Denis Nikitin wrote:
> If a perf event doesn't fit into remaining buffer space return NULL to
> remap buf and fetch the event again.
> Keep the logic to error out on inadequate input from fuzzing.
> 
> This fixes perf failing on ChromeOS (with 32b userspace):
> 
>   $ perf report -v -i perf.data
>   ...
>   prefetch_event: head=0x1fffff8 event->header_size=0x30, mmap_size=0x2000000: fuzzed or compressed perf.data?
>   Error:
>   failed to process sample
> 
> Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing invalid header.size")
> Signed-off-by: Denis Nikitin <denik@chromium.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/session.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 3b8dfe603e50..45a30040ec8d 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -2095,6 +2095,7 @@ prefetch_event(char *buf, u64 head, size_t mmap_size,
>  	       bool needs_swap, union perf_event *error)
>  {
>  	union perf_event *event;
> +	u16 event_size;
>  
>  	/*
>  	 * Ensure we have enough space remaining to read
> @@ -2107,15 +2108,23 @@ prefetch_event(char *buf, u64 head, size_t mmap_size,
>  	if (needs_swap)
>  		perf_event_header__bswap(&event->header);
>  
> -	if (head + event->header.size <= mmap_size)
> +	event_size = event->header.size;
> +	if (head + event_size <= mmap_size)
>  		return event;
>  
>  	/* We're not fetching the event so swap back again */
>  	if (needs_swap)
>  		perf_event_header__bswap(&event->header);
>  
> -	pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx:"
> -		 " fuzzed or compressed perf.data?\n",__func__, head, event->header.size, mmap_size);
> +	/* Check if the event fits into the next mmapped buf. */
> +	if (event_size <= mmap_size - head % page_size) {
> +		/* Remap buf and fetch again. */
> +		return NULL;
> +	}
> +
> +	/* Invalid input. Event size should never exceed mmap_size. */
> +	pr_debug("%s: head=%#" PRIx64 " event->header.size=%#x, mmap_size=%#zx:"
> +		 " fuzzed or compressed perf.data?\n", __func__, head, event_size, mmap_size);
>  
>  	return error;
>  }
> -- 
> 2.35.1.1021.g381101b075-goog
> 
