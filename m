Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A1346DDA8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 22:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbhLHVir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 16:38:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52285 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237265AbhLHVip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 16:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638999312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CeXKyb655iDPT4A+Z5xrV0y1RP5TDI3g9ay8C+HT3HE=;
        b=eIVd5avwxD1Bdftyf4pMjmDfJoPE4lzUMU+1sJLmyCrkrSrC++lEyKCRa5cj91zguzMpQO
        ENXZV845cDnyIBl72dd0s2ZMeT+TLbXID+BIs3Qy5G78/e6a2DgVt0Jnc5hE51ciNtIHM3
        2wk9ev1oIYevtraqRmpU1YjRpkOAi1o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-bIX-DmEeMV6U5F1mqH-UhA-1; Wed, 08 Dec 2021 16:35:11 -0500
X-MC-Unique: bIX-DmEeMV6U5F1mqH-UhA-1
Received: by mail-wr1-f71.google.com with SMTP id u4-20020a5d4684000000b0017c8c1de97dso720622wrq.16
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 13:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CeXKyb655iDPT4A+Z5xrV0y1RP5TDI3g9ay8C+HT3HE=;
        b=J6Gohuy7KnlVIGJUQoIexGUG6Qyf5RAoYoDsElOXZLIMWlHJHfI3Ml0cdrb1u2HOge
         GSQlcrX/xo+XjUJLLo6IAgmsWSYWf6sa/Slkj4XW2/sl4wO6iP1MnYGqMk7dqaveTheV
         u0r7U91sXIzDveJe+NVF4/6tlKbvwVzzeX86TerGALUoISBR7JjdWVUIDWU/DBf0e2dY
         yk+TQpL2NerIfVoiBpQ7k2rbgBrEEl58JHK/vNSATz8/R9YuOUIV5DRF2iOYDNR8LG1g
         0OzbiOJFGdDUIrmQqM490Ix4RKt70iEIAeC1A63dWk2FN9Nqw0A6I9ZTmwPb1BRDWG3q
         PGWg==
X-Gm-Message-State: AOAM531xj3/UiQ9nkb+Ske4aO0I5EQQOhUh9hVK7XFJRQoytVJB4g4z2
        BsW40ZJ3ZZgXgTv1u8dv2a99r1+mJVxNePyNfTtZvn9g3tZolPhaSLTC7pc+pLNKvT24aorq1xY
        INBFzMi/IYz5R8pfUrsHHmQBn
X-Received: by 2002:adf:e391:: with SMTP id e17mr1405787wrm.613.1638999310065;
        Wed, 08 Dec 2021 13:35:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx56PDcQ9x4W4KPUCMLY+uuyJihSBiRNIwzduX5rQ30E/1Tn92gPDE60lBy2g7CxuCj7cySQA==
X-Received: by 2002:adf:e391:: with SMTP id e17mr1405757wrm.613.1638999309893;
        Wed, 08 Dec 2021 13:35:09 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id b6sm7152187wmq.45.2021.12.08.13.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 13:35:09 -0800 (PST)
Date:   Wed, 8 Dec 2021 22:35:07 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 1/4] perf tools: Prevent out-of-bounds access to
 registers
Message-ID: <YbElC/fEgduFMAuo@krava>
References: <20211201123334.679131-1-german.gomez@arm.com>
 <20211201123334.679131-2-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201123334.679131-2-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 12:33:29PM +0000, German Gomez wrote:
> The size of the cache of register values is arch-dependant
> (PERF_REGS_MAX). This has the potential of causing an out-of-bounds
> access in the function "perf_reg_value" if the local architecture
> contains less registers than the one the perf.data file was recorded on.
> 
> Since the maximum number of registers is bound by the bitmask "u64
> cache_mask", and the size of the cache when running under x86 systems is
> 64 already, fix the size to 64 and add a range-check to the function
> "perf_reg_value" to prevent out-of-bounds access.
> 
> Signed-off-by: German Gomez <german.gomez@arm.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/event.h     | 5 ++++-
>  tools/perf/util/perf_regs.c | 3 +++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index 95ffed663..c59331eea 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -44,13 +44,16 @@ struct perf_event_attr;
>  /* perf sample has 16 bits size limit */
>  #define PERF_SAMPLE_MAX_SIZE (1 << 16)
>  
> +/* number of register is bound by the number of bits in regs_dump::mask (64) */
> +#define PERF_SAMPLE_REGS_CACHE_SIZE (8 * sizeof(u64))
> +
>  struct regs_dump {
>  	u64 abi;
>  	u64 mask;
>  	u64 *regs;
>  
>  	/* Cached values/mask filled by first register access. */
> -	u64 cache_regs[PERF_REGS_MAX];
> +	u64 cache_regs[PERF_SAMPLE_REGS_CACHE_SIZE];
>  	u64 cache_mask;
>  };
>  
> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> index 5ee47ae15..06a7461ba 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -25,6 +25,9 @@ int perf_reg_value(u64 *valp, struct regs_dump *regs, int id)
>  	int i, idx = 0;
>  	u64 mask = regs->mask;
>  
> +	if ((u64)id >= PERF_SAMPLE_REGS_CACHE_SIZE)
> +		return -EINVAL;
> +
>  	if (regs->cache_mask & (1ULL << id))
>  		goto out;
>  
> -- 
> 2.25.1
> 

