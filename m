Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8B5468BB3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbhLEPSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:18:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49783 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235623AbhLEPSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:18:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638717296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LPV32rELj3FNCGkiOcm9UQAwfU3MyW8Mszkg3+9TdYE=;
        b=VshEW7YIL0cSailVXk7Bv/KOEeah/I8LOU442agAqnJtO4zV90HV7/KYWjAIESCqrd2UUR
        m1yWmzMBKXOL0Ntvd7fpbT1T58NFuEBJvieqY1am6mP5z1GuM3jJMMLApy+ISw/7h0ZroT
        gHsM+r6gJny++32cnx/Z/8W0DR1rMS8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-MdwVbCZLNvi4A-ymaN2wEw-1; Sun, 05 Dec 2021 10:14:54 -0500
X-MC-Unique: MdwVbCZLNvi4A-ymaN2wEw-1
Received: by mail-wr1-f70.google.com with SMTP id x17-20020a5d6511000000b0019838caab88so1420211wru.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 07:14:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LPV32rELj3FNCGkiOcm9UQAwfU3MyW8Mszkg3+9TdYE=;
        b=alS4BzuZF82WGeUSPsS5/zUsGCozL90cLwfTi/dbNrePjkO3QpLg7kpTsjrWpi1Q9Z
         lOVX8x5BKh4n3MjfLliKy2ruc1jDD57Jyrb9snGcZcWvZiKY2hy1wC+vN3lclSL7kDEz
         mRmGukN/UDEljhc/oQC2Fxdv5qcOG+vKSURT/rkX3F1V/Z8nGj9UT4jzKC4HgoRSc4QU
         uUJIddqs1LcxIk/dVPpAqANHkXVgkpozkOe94BwAyDkeTWNVCpGCcT5TTsSKVlkTvuqa
         QW80ypWFiGOZh71cXFxdUiejSEHnw5XFFLSQGU1b1yRYIXbHmKZaeM6i3L0FBxLljrFx
         ty+w==
X-Gm-Message-State: AOAM531WDvjQH24Xjglrcjezoh5nLGIsA6+pGJ4TxAeRMfolK9aPlA7J
        Z2TeaTdIw2IgCHviZyHidK/W49MrLYWEpwBVLK3Jo3NqOeG1uACVC940t9eLGZkBlwCK0XLypXO
        aNDkj7+waEilWrrK07gjjfqIB
X-Received: by 2002:a5d:55d1:: with SMTP id i17mr36860416wrw.618.1638717293768;
        Sun, 05 Dec 2021 07:14:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7c982lbD8Ko6QQzdyb086ct+KRx5lNV+6lzioKQ7x3fnNlGsoLDelf8BYet7o57sTP3vThQ==
X-Received: by 2002:a5d:55d1:: with SMTP id i17mr36860392wrw.618.1638717293562;
        Sun, 05 Dec 2021 07:14:53 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id l3sm9691317wmq.46.2021.12.05.07.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 07:14:53 -0800 (PST)
Date:   Sun, 5 Dec 2021 16:14:49 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v12 09/16] perf record: Introduce bytes written stats
Message-ID: <YazXabglLVSvO5V4@krava>
References: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
 <b235542dee6bfaa8966dabf124ec4b7c0b2dc9f9.1637675515.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b235542dee6bfaa8966dabf124ec4b7c0b2dc9f9.1637675515.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 05:08:05PM +0300, Alexey Bayduraev wrote:
> Introduce a function to calculate the total amount of data written
> and use it to support the --max-size option.
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
> Tested-by: Riccardo Mancini <rickyman7@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index ce660691df1d..cd4f74c311e8 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -108,6 +108,7 @@ struct record_thread {
>  	struct record		*rec;
>  	unsigned long long	samples;
>  	unsigned long		waking;
> +	u64			bytes_written;
>  };
>  
>  static __thread struct record_thread *thread;
> @@ -191,10 +192,22 @@ static bool switch_output_time(struct record *rec)
>  	       trigger_is_ready(&switch_output_trigger);
>  }
>  
> +static u64 record__bytes_written(struct record *rec)
> +{
> +	int t;
> +	u64 bytes_written = rec->bytes_written;
> +	struct record_thread *thread_data = rec->thread_data;
> +
> +	for (t = 0; t < rec->nr_threads; t++)
> +		bytes_written += thread_data[t].bytes_written;
> +
> +	return bytes_written;
> +}
> +
>  static bool record__output_max_size_exceeded(struct record *rec)
>  {
>  	return rec->output_max_size &&
> -	       (rec->bytes_written >= rec->output_max_size);
> +	       (record__bytes_written(rec) >= rec->output_max_size);
>  }
>  
>  static int record__write(struct record *rec, struct mmap *map __maybe_unused,
> @@ -210,13 +223,15 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>  		return -1;
>  	}
>  
> -	if (!(map && map->file))
> +	if (map && map->file)
> +		thread->bytes_written += size;
> +	else
>  		rec->bytes_written += size;

ok, that's why ;-) do we actually stil need rec->bytes_written?
can't we count that under synthesizing main thread->bytes_written?

jirka

>  
>  	if (record__output_max_size_exceeded(rec) && !done) {
>  		fprintf(stderr, "[ perf record: perf size limit reached (%" PRIu64 " KB),"
>  				" stopping session ]\n",
> -				rec->bytes_written >> 10);
> +				record__bytes_written(rec) >> 10);
>  		done = 1;
>  	}
>  
> -- 
> 2.19.0
> 

