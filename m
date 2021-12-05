Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB928468BB0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbhLEPSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:18:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235586AbhLEPSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638717276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H5IzgNIsCDN4CTraRVcjZncPXVQybgk7pRae5MbgbVg=;
        b=GRJ4xw2NfX6Apj1Y2QMWIF4Np/jidhk+yfQCEGI4XLBZbc2KblVrwCp5//gQLYm1VCdvgO
        h6fnoFPNsbphuPnCssJrYGvPf/pOdU/Ti26aPnwGjxDjGdC7UJbFq3ocnrkuHi7Hr0pBAK
        f4oZ05yt7vH1CzBj2b4cFIs7Csdv5cE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-GDwO-u5dOqKo4jQOma2-6A-1; Sun, 05 Dec 2021 10:14:35 -0500
X-MC-Unique: GDwO-u5dOqKo4jQOma2-6A-1
Received: by mail-wm1-f71.google.com with SMTP id z138-20020a1c7e90000000b003319c5f9164so6598085wmc.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 07:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H5IzgNIsCDN4CTraRVcjZncPXVQybgk7pRae5MbgbVg=;
        b=2NtvHoPySdsjHloZZ9tIcorDM8tEPG2ijBeUlSjB0f0QvGS4y0TEfgKYsE2klaZSIX
         tlzA6ldcmnDJ13vJE6Y/ZdIeRZQqsjoBZrZXoF6EV3H/sRk+gqmQi6x2VyIm5uUpShN8
         moM69hteVhOPo7xEIy6TFV2XLVax2vBQ6XJIJNhij64er59Hp0w704KqEsIRGskMHAt5
         bPOLfgF0+VR1QpBw2oLS9A5lUEDEXzLjr1h1jRTSAH3OH5WBLVH3eXMBneTBvKVExa/H
         menOTA18mUHgXHbGuOYmJq5+rubleZxPGZIaNW1N6AU0v93BdZlAKbkjOnB+1mWPC98Y
         mENw==
X-Gm-Message-State: AOAM531/Ge4zOe1BbPkk4YYOchGK9p+iZqMcDh4YB28dqU/2C5zoaByr
        n8o9V0Zh2T3bviEi6+65lSXpEcrI5UD9mqurKYvvXWJj70YeZgDhGeB4mosDTvG8krwJ3m3/ypz
        l5/nc1a0uXhRs5Hu377s9DiRK
X-Received: by 2002:a05:600c:1d9b:: with SMTP id p27mr31854650wms.123.1638717274676;
        Sun, 05 Dec 2021 07:14:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwW8j5CvDY0KV8Q1/OHn0ymJRKGXVcU3AhKys4oTQOzHUKrUsxAEh9xONde6a8Q933W0XqtkA==
X-Received: by 2002:a05:600c:1d9b:: with SMTP id p27mr31854629wms.123.1638717274526;
        Sun, 05 Dec 2021 07:14:34 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id o10sm10119745wri.15.2021.12.05.07.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 07:14:34 -0800 (PST)
Date:   Sun, 5 Dec 2021 16:14:32 +0100
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
Subject: Re: [PATCH v12 05/16] perf record: Introduce thread local variable
Message-ID: <YazXWM7rVdaoF4yX@krava>
References: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
 <c9f2747f11fcce59b879b547f8128f2ae5a7f8c0.1637675515.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9f2747f11fcce59b879b547f8128f2ae5a7f8c0.1637675515.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 05:08:01PM +0300, Alexey Bayduraev wrote:

SNIP

>  
> +	if (record__start_threads(rec))
> +		goto out_free_threads;
> +
>  	/*
>  	 * When perf is starting the traced process, all the events
>  	 * (apart from group members) have enable_on_exec=1 set,
> @@ -2122,7 +2175,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	trigger_ready(&switch_output_trigger);
>  	perf_hooks__invoke_record_start();
>  	for (;;) {
> -		unsigned long long hits = rec->samples;
> +		unsigned long long hits = thread->samples;
>  
>  		/*
>  		 * rec->evlist->bkw_mmap_state is possible to be
> @@ -2176,8 +2229,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  
>  			if (!quiet)
>  				fprintf(stderr, "[ perf record: dump data: Woken up %ld times ]\n",
> -					waking);
> -			waking = 0;
> +					record__waking(rec));
> +			thread->waking = 0;
>  			fd = record__switch_output(rec, false);
>  			if (fd < 0) {
>  				pr_err("Failed to switch to new file\n");
> @@ -2191,20 +2244,24 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  				alarm(rec->switch_output.time);
>  		}
>  
> -		if (hits == rec->samples) {
> +		if (hits == thread->samples) {
>  			if (done || draining)
>  				break;
> -			err = evlist__poll(rec->evlist, -1);
> +			err = fdarray__poll(&thread->pollfd, -1);
>  			/*
>  			 * Propagate error, only if there's any. Ignore positive
>  			 * number of returned events and interrupt error.
>  			 */
>  			if (err > 0 || (err < 0 && errno == EINTR))
>  				err = 0;
> -			waking++;
> +			thread->waking++;
>  
> -			if (evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
> +			if (fdarray__filter(&thread->pollfd, POLLERR | POLLHUP,
> +					    record__thread_munmap_filtered, NULL) == 0)
>  				draining = true;
> +
> +			evlist__ctlfd_update(rec->evlist,
> +				&thread->pollfd.entries[thread->ctlfd_pos]);

hm, why is this needed? we only switch to record_thread data, right?
there should not be any processing change

jirka

>  		}
>  
>  		if (evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
> @@ -2258,15 +2315,18 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	}
>  
>  	if (!quiet)
> -		fprintf(stderr, "[ perf record: Woken up %ld times to write data ]\n", waking);
> +		fprintf(stderr, "[ perf record: Woken up %ld times to write data ]\n",
> +			record__waking(rec));
>  
>  	if (target__none(&rec->opts.target))
>  		record__synthesize_workload(rec, true);
>  
>  out_child:
> -	evlist__finalize_ctlfd(rec->evlist);
> +	record__stop_threads(rec);
>  	record__mmap_read_all(rec, true);
> +out_free_threads:
>  	record__free_thread_data(rec);
> +	evlist__finalize_ctlfd(rec->evlist);
>  	record__aio_mmap_read_sync(rec);
>  
>  	if (rec->session->bytes_transferred && rec->session->bytes_compressed) {
> @@ -3158,17 +3218,6 @@ int cmd_record(int argc, const char **argv)
>  
>  	symbol__init(NULL);
>  
> -	if (rec->opts.affinity != PERF_AFFINITY_SYS) {
> -		rec->affinity_mask.nbits = cpu__max_cpu();
> -		rec->affinity_mask.bits = bitmap_zalloc(rec->affinity_mask.nbits);
> -		if (!rec->affinity_mask.bits) {
> -			pr_err("Failed to allocate thread mask for %zd cpus\n", rec->affinity_mask.nbits);
> -			err = -ENOMEM;
> -			goto out_opts;
> -		}
> -		pr_debug2("thread mask[%zd]: empty\n", rec->affinity_mask.nbits);
> -	}
> -
>  	err = record__auxtrace_init(rec);
>  	if (err)
>  		goto out;
> @@ -3313,7 +3362,6 @@ int cmd_record(int argc, const char **argv)
>  
>  	err = __cmd_record(&record, argc, argv);
>  out:
> -	bitmap_free(rec->affinity_mask.bits);
>  	evlist__delete(rec->evlist);
>  	symbol__exit();
>  	auxtrace_record__free(rec->itr);
> -- 
> 2.19.0
> 

