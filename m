Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3C2468BAC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbhLEPRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:17:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40175 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235545AbhLEPRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638717246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WVpj98AgxLnpi53g2Oa8I5cAlGEkPDOd0xPAv4szwuA=;
        b=Sd7B7hE+U1iJSQfGEzTzXNno9Ln3mdI0gR/8IadbZfdMMfi0Zw2JuzUYCWiwtBvrNvJqz1
        ne7bo4xVduRa45LdONG8FF/pS2dlAmLvEtLJszQtSEU5n0TQfKzQ14mQZfJ64+fV7dGp3N
        cXz07pRyQqUiKR1NCf+/a/nGXgHGyqM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-429-h8cUbwzLNPekAOtwy73O8g-1; Sun, 05 Dec 2021 10:14:05 -0500
X-MC-Unique: h8cUbwzLNPekAOtwy73O8g-1
Received: by mail-wm1-f71.google.com with SMTP id y141-20020a1c7d93000000b0033c2ae3583fso4680423wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 07:14:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WVpj98AgxLnpi53g2Oa8I5cAlGEkPDOd0xPAv4szwuA=;
        b=BPlP8NgLG/TrijWnocEXELwRusnHjBSwZ4+U1FDzH+BCw4y1qTjnIJxaQfWfVYWtaK
         p801TreMuEpbfAia+wP+/0k1w7xGOp7/i7Ke/R37CHHj5ny2656g6yJA3SuL5uBLTpT4
         9eVoQJoOjSNtd+7kz8fbLyiSLc9+vEPITWsfLOIIKDwKFYmEzfZIA4xQBwRICYtpFUGQ
         57yYccrvn8ma0HwodkunWKYMXnQhoVrs0ZZoY2njMbl8Wf32W6T1cpNfquQZN3Nng1oQ
         Ko22Cy2/C9MQewDSg5JP5j7tSGZrdu/0QbAALoyYbJ2mkoSy+9uRkN3Ckewrqdlcwot5
         raOw==
X-Gm-Message-State: AOAM53278+3R4YZeYxegCGiwL2yVewpb1Y85YD+HtHDew1K2wJ0Lm4Kd
        VLyZ4l63oiIvG9YSZMvsHGOjccQVQWsVm0HfC/5x5PogzRYwLMzLZseYqSinn/13mVLXeRxN+BN
        WoOUqJZPG2JPKSqD7I4DYLsbZ
X-Received: by 2002:a5d:5147:: with SMTP id u7mr36829172wrt.233.1638717243571;
        Sun, 05 Dec 2021 07:14:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIlPTZr/0UhxjxqZyXy8eDP3dnlVtk3Wd6jpiIzoQ0QKx5x6mWUzjhwbdIvGXim5kjidHL5g==
X-Received: by 2002:a5d:5147:: with SMTP id u7mr36829151wrt.233.1638717243438;
        Sun, 05 Dec 2021 07:14:03 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id k8sm8421586wrn.91.2021.12.05.07.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 07:14:03 -0800 (PST)
Date:   Sun, 5 Dec 2021 16:14:01 +0100
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
Message-ID: <YazXOZRSk1EPdZ1n@krava>
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

nit, is this clear needed?

jirka

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

