Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F462468BAE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbhLEPRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:17:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54130 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235530AbhLEPRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638717261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I8PgkR0IPDRUjmuyaE8eivNX9Dtmvnhl4Po3dfmKuc4=;
        b=Nyi4kqXMQIpiuEswrHUdAGoXIz16hPgSgf/5Gnv+zRGBI41b+Pt9+na6oXqeUxzqSJJzUw
        ZBdYVi35LWVhUyHkUydrxYWEtlr2VlokdOKm/sxVm2V0TxYQQqW/mYj886gvoW/tRslzh6
        ntKGSk7Qv5eAXC1UsYhLJ/gFc2maXDI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-f5rhpwaxOVGV-dSErlUUxA-1; Sun, 05 Dec 2021 10:14:19 -0500
X-MC-Unique: f5rhpwaxOVGV-dSErlUUxA-1
Received: by mail-wm1-f69.google.com with SMTP id 201-20020a1c04d2000000b003335bf8075fso4706948wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 07:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I8PgkR0IPDRUjmuyaE8eivNX9Dtmvnhl4Po3dfmKuc4=;
        b=4Bge9sHKhtsUNSlM8zKspt8vfUVULqFqYrD5fbEc2wzxiz8ckf/EsSrx1K3nl2pJZ1
         vz/r7s6zkIZVb3ON/+ls82N91b1vpbilnTDOWceYCdom+nFzDgj1vE5R5Q02sC/qbsFo
         zQik66sCXvdBgSYowK++5Wch/jXk7ssAq+GwWf1oBz5bxC7hznUgWvGsipHGl99MOhhj
         nrZvbK1YKfGGBSbG2Q8cN0Arp9hj8sULjHVuz9AdkJV0ft2dkuxuf10gQyeEXOr3o/ri
         XpBX08Gc2+pkTmHDuJiRh0ghz7ThQdtXpPVW+GePYOhicQjHKWHcCNs0SDQEtsPlJO4d
         f/OA==
X-Gm-Message-State: AOAM5301Ykem/eKab1ucoZIuRuB9o5gE4lXKynyLAsLWO8rKNCk6GN7+
        yns0CrEBcH/Eg6MtwOKoTlR3XCuVZ2zJKMbDrPedHSn2LY/Lo0ytHpGqbg+obPO6IOh1AnXxfBw
        24naA50ItldA/OawVOX5EA0o6
X-Received: by 2002:a7b:cf25:: with SMTP id m5mr31592249wmg.51.1638717258589;
        Sun, 05 Dec 2021 07:14:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9oCqKi7fHkCWQc2dxibXXTOhie1b37xymESuGlah67VsytyDWdy3l8fjNIgdhgZ/zG48aRw==
X-Received: by 2002:a7b:cf25:: with SMTP id m5mr31592217wmg.51.1638717258318;
        Sun, 05 Dec 2021 07:14:18 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id p12sm9150670wro.33.2021.12.05.07.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 07:14:18 -0800 (PST)
Date:   Sun, 5 Dec 2021 16:14:16 +0100
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
Subject: Re: [PATCH v12 13/16] perf record: Extend --threads command line
 option
Message-ID: <YazXSA3iI2PkygVe@krava>
References: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
 <f103a65518a1a41700f739df75f57cb0b46fbf19.1637675515.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f103a65518a1a41700f739df75f57cb0b46fbf19.1637675515.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 05:08:09PM +0300, Alexey Bayduraev wrote:

SNIP

>  	return 0;
>  }
> @@ -3263,6 +3327,17 @@ static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_c
>  		set_bit(cpus->map[c], mask->bits);
>  }
>  
> +static void record__mmap_cpu_mask_init_spec(struct mmap_cpu_mask *mask, const char *mask_spec)
> +{
> +	struct perf_cpu_map *cpus;
> +
> +	cpus = perf_cpu_map__new(mask_spec);
> +	if (cpus) {
> +		record__mmap_cpu_mask_init(mask, cpus);
> +		perf_cpu_map__put(cpus);
> +	}

we should bail out on perf_cpu_map__new error

jirka

> +}
> +
>  static void record__free_thread_masks(struct record *rec, int nr_threads)
>  {
>  	int t;
> @@ -3324,6 +3399,214 @@ static int record__init_thread_cpu_masks(struct record *rec, struct perf_cpu_map
>  	return 0;
>  }
>  
> +static int record__init_thread_masks_spec(struct record *rec, struct perf_cpu_map *cpus,
> +					  const char **maps_spec, const char **affinity_spec,
> +					  u32 nr_spec)
> +{
> +	u32 s;
> +	int ret = 0, t = 0;
> +	struct mmap_cpu_mask cpus_mask;
> +	struct thread_mask thread_mask, full_mask, *prev_masks;
> +
> +	ret = record__mmap_cpu_mask_alloc(&cpus_mask, cpu__max_cpu());
> +	if (ret)
> +		goto out;
> +	record__mmap_cpu_mask_init(&cpus_mask, cpus);
> +	ret = record__thread_mask_alloc(&thread_mask, cpu__max_cpu());
> +	if (ret)
> +		goto out_free_cpu_mask;
> +	ret = record__thread_mask_alloc(&full_mask, cpu__max_cpu());
> +	if (ret)
> +		goto out_free_thread_mask;
> +	record__thread_mask_clear(&full_mask);
> +
> +	for (s = 0; s < nr_spec; s++) {
> +		record__thread_mask_clear(&thread_mask);
> +
> +		record__mmap_cpu_mask_init_spec(&thread_mask.maps, maps_spec[s]);
> +		record__mmap_cpu_mask_init_spec(&thread_mask.affinity, affinity_spec[s]);
> +
> +		if (!bitmap_and(thread_mask.maps.bits, thread_mask.maps.bits,
> +				cpus_mask.bits, thread_mask.maps.nbits) ||
> +		    !bitmap_and(thread_mask.affinity.bits, thread_mask.affinity.bits,
> +				cpus_mask.bits, thread_mask.affinity.nbits))
> +			continue;
> +
> +		ret = record__thread_mask_intersects(&thread_mask, &full_mask);
> +		if (ret)
> +			goto out_free_full_mask;
> +		record__thread_mask_or(&full_mask, &full_mask, &thread_mask);
> +
> +		prev_masks = rec->thread_masks;
> +		rec->thread_masks = realloc(rec->thread_masks,
> +					    (t + 1) * sizeof(struct thread_mask));
> +		if (!rec->thread_masks) {
> +			pr_err("Failed to allocate thread masks\n");
> +			rec->thread_masks = prev_masks;
> +			ret = -ENOMEM;
> +			goto out_free_full_mask;
> +		}
> +		rec->thread_masks[t] = thread_mask;
> +		if (verbose) {
> +			pr_debug("thread_masks[%d]: ", t);
> +			mmap_cpu_mask__scnprintf(&rec->thread_masks[t].maps, "maps");
> +			pr_debug("thread_masks[%d]: ", t);
> +			mmap_cpu_mask__scnprintf(&rec->thread_masks[t].affinity, "affinity");
> +		}
> +		t++;
> +		ret = record__thread_mask_alloc(&thread_mask, cpu__max_cpu());
> +		if (ret)
> +			goto out_free_full_mask;
> +	}
> +
> +	rec->nr_threads = t;
> +	pr_debug("nr_threads: %d\n", rec->nr_threads);
> +
> +	if (rec->nr_threads <= 0)
> +		ret = -EINVAL;
> +
> +out_free_full_mask:
> +	record__thread_mask_free(&full_mask);
> +out_free_thread_mask:
> +	record__thread_mask_free(&thread_mask);
> +out_free_cpu_mask:
> +	record__mmap_cpu_mask_free(&cpus_mask);
> +out:
> +	return ret;
> +}

SNIP

