Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2210055FC0E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiF2JbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiF2JbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:31:12 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38E339825;
        Wed, 29 Jun 2022 02:31:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sb34so31270870ejc.11;
        Wed, 29 Jun 2022 02:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1MQtKyGpLfxVaTXrtUo/eYc0t4KdNpNUjTXmOdTkSlg=;
        b=q8HNG5xT4k5tqN0KcQ7F/ovA4ug+wyQHASp0zFULB9rYp681wgfyMdhDhTi4Lef2LR
         IU51FH6k9uPtpIpD/rfRA6deez95BBiSD42tjIjDBrDCrtzsT5jVne9tga8K3pJmm/fK
         KwTGF8C5KGokhCHmQChBWj0aIomx9BmUxJAGB0gEmtQAIEnHN0UXKpgMn98PhAWxRIfi
         5JgOOpCm0wlg9xFMRzVTJ08zfkPXpirJktFvRCrsM0hLJmlpCMfY/4WnPZeHBx1rTem0
         V4WoySDmh27Qb9x0UpLwi0HNP53DhB31pZZo+vR0TmyEhNpfKCsIvsSWT+PeiOGGMbi8
         A1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1MQtKyGpLfxVaTXrtUo/eYc0t4KdNpNUjTXmOdTkSlg=;
        b=5TVq+vq0D8KdiLuyNLMFJqIFa6BPEVaNJVqoz4IC9ZSfNLXgJKzpzEtbdid8HV1Jb3
         w3jsx2eASjCkrlG2Czy1VghC3Oxqql1mvY6fhMtU0mnz2LCtvTvZoHZrePNPyKCd24ny
         Mzidpb7a8+Pdvik3J3hvZnc7LzQCZWdAa/h5rb5FguVtTQ57GfewQGjZSlChMHyFM2Ap
         D+1EZkqbHns/vPbaZZnee3TSxrkAh4d05J8yDTaAVfbxTKIRU8N3OYJztvAJWJdhTHaC
         SVNthCP6KKNz9spqppc6jMG8lBdjiA7MhwZmGuXSmJ+xxyDlcIZHjdt/i3l8wfvFBWbt
         2DQQ==
X-Gm-Message-State: AJIora+R1ylGo13mEgIf0vtzo3u5tbbnmfVw4TbcR84M8KMGwSBO1xjD
        HHejV/GSugQdhh19UPvqkr4=
X-Google-Smtp-Source: AGRyM1uSHVD3OrNA4yy2l4BhcVNH+1bC36C6joYvzWd41Pmu+x3ByjAsa0AVI7z0Pg6WTVr+PUa4ww==
X-Received: by 2002:a17:907:7248:b0:726:30fc:e7fc with SMTP id ds8-20020a170907724800b0072630fce7fcmr2424523ejc.274.1656495070357;
        Wed, 29 Jun 2022 02:31:10 -0700 (PDT)
Received: from krava (net-109-116-206-47.cust.vodafonedsl.it. [109.116.206.47])
        by smtp.gmail.com with ESMTPSA id a12-20020a170906670c00b006fe8c831632sm7437057ejp.73.2022.06.29.02.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 02:31:09 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 29 Jun 2022 11:31:07 +0200
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
Message-ID: <Yrwb28xHsPCZzSw7@krava>
References: <20220614143353.1559597-1-irogers@google.com>
 <20220614143353.1559597-7-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614143353.1559597-7-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 07:33:53AM -0700, Ian Rogers wrote:

SNIP

> -static size_t cpus_size(const struct perf_cpu_map *map)
> +static void synthesize_range_cpus(struct synthesize_cpu_map_data *data)
>  {
> -	return sizeof(struct cpu_map_entries) + perf_cpu_map__nr(map) * sizeof(u16);
> +	data->data->type = PERF_CPU_MAP__RANGE_CPUS;
> +	data->data->range_cpu_data.any_cpu = data->has_any_cpu;
> +	data->data->range_cpu_data.start_cpu = data->min_cpu;
> +	data->data->range_cpu_data.end_cpu = data->max_cpu;
>  }
>  
> -static size_t mask_size(const struct perf_cpu_map *map, int *max)
> -{
> -	*max = perf_cpu_map__max(map).cpu;
> -	return sizeof(struct perf_record_mask_cpu_map32) + BITS_TO_U32(*max) * sizeof(__u32);
> -}
> -
> -static void *cpu_map_data__alloc(const struct perf_cpu_map *map, size_t *size,
> -				 u16 *type, int *max)
> +static void *cpu_map_data__alloc(struct synthesize_cpu_map_data *syn_data,
> +				 size_t header_size)
>  {
>  	size_t size_cpus, size_mask;
> -	bool is_dummy = perf_cpu_map__empty(map);
>  
> -	/*
> -	 * Both array and mask data have variable size based
> -	 * on the number of cpus and their actual values.
> -	 * The size of the 'struct perf_record_cpu_map_data' is:
> -	 *
> -	 *   array = size of 'struct cpu_map_entries' +
> -	 *           number of cpus * sizeof(u64)
> -	 *
> -	 *   mask  = size of 'struct perf_record_record_cpu_map' +
> -	 *           maximum cpu bit converted to size of longs
> -	 *
> -	 * and finally + the size of 'struct perf_record_cpu_map_data'.
> -	 */
> -	size_cpus = cpus_size(map);
> -	size_mask = mask_size(map, max);
> +	syn_data->nr = perf_cpu_map__nr(syn_data->map);
> +	syn_data->has_any_cpu = (perf_cpu_map__cpu(syn_data->map, 0).cpu == -1) ? 1 : 0;

I'm bit lost in the logic in here.. should it be '.cpu != -1' ?
has_any_cpu is named as bool but used as index below ;-)

could you please keep/update the comment above and explain
the conditions when each cpu_map type is taken

thanks,
jirka

>  
> -	if (is_dummy || (size_cpus < size_mask)) {
> -		*size += size_cpus;
> -		*type  = PERF_CPU_MAP__CPUS;
> -	} else {
> -		*size += size_mask;
> -		*type  = PERF_CPU_MAP__MASK;
> +	syn_data->min_cpu = perf_cpu_map__cpu(syn_data->map, syn_data->has_any_cpu).cpu;
> +	syn_data->max_cpu = perf_cpu_map__max(syn_data->map).cpu;
> +	if (syn_data->max_cpu - syn_data->min_cpu + 1 == syn_data->nr - syn_data->has_any_cpu) {
> +		/* A consecutive range of CPUs can be encoded using a range. */
> +		assert(sizeof(u16) + sizeof(struct perf_record_range_cpu_map) == sizeof(u64));
> +		syn_data->type = PERF_CPU_MAP__RANGE_CPUS;
> +		syn_data->size = header_size + sizeof(u64);
> +		return zalloc(syn_data->size);
>  	}
>  
> -	*size += sizeof(__u16); /* For perf_record_cpu_map_data.type. */
> -	*size = PERF_ALIGN(*size, sizeof(u64));
> -	return zalloc(*size);
> +	size_cpus = sizeof(u16) + sizeof(struct cpu_map_entries) + syn_data->nr * sizeof(u16);
> +	/* Due to padding, the 4bytes per entry mask variant is always smaller. */
> +	size_mask = sizeof(u16) + sizeof(struct perf_record_mask_cpu_map32) +
> +		BITS_TO_U32(syn_data->max_cpu) * sizeof(__u32);
> +	if (syn_data->has_any_cpu || size_cpus < size_mask) {
> +		/* Follow the CPU map encoding. */
> +		syn_data->type = PERF_CPU_MAP__CPUS;
> +		syn_data->size = header_size + PERF_ALIGN(size_cpus, sizeof(u64));
> +		return zalloc(syn_data->size);
> +	}
> +	/* Encode using a bitmask. */
> +	syn_data->type = PERF_CPU_MAP__MASK;
> +	syn_data->size = header_size + PERF_ALIGN(size_mask, sizeof(u64));
> +	return zalloc(syn_data->size);

SNIP
