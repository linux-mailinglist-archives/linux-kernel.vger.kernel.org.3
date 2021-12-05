Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B88468BAB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbhLEPR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:17:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42556 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235341AbhLEPR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638717239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QxvxQc41Ew/AKTWBd/7QLuFTH5E37kP+3Ti2L6TAk5Q=;
        b=Lpsqwn9nWiJD4ZTVWBZ13nUCOKggk0xmhh4wktiAgjuEgHLSAnHOrlUzxDPQSFqzkpubo6
        8sWM2ftOpebVeBL9cGSPM0r/jIaz9xdAtLBLZEERh4QEfHRXOyZLvHtbGlRbGdL5XjbQ14
        6R166LpHSbPnWK59P9KLYpKOIyMNe/c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-gYu_mn-OP1y-P38UtdNv1A-1; Sun, 05 Dec 2021 10:13:58 -0500
X-MC-Unique: gYu_mn-OP1y-P38UtdNv1A-1
Received: by mail-wm1-f72.google.com with SMTP id r129-20020a1c4487000000b00333629ed22dso6595650wma.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 07:13:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QxvxQc41Ew/AKTWBd/7QLuFTH5E37kP+3Ti2L6TAk5Q=;
        b=LTRXg63jqWBtPjQPsOeM3USC7YtXUmOfdJvZ25s+nMUzlqCiqe3+MGYsFliFnNBsIp
         6tuVywLIWr1Ve0vT2YHvfyHHjEPrhkoOcyJGNhh1NTkTzMU0fSpjL7PeRKhdnxIpyhI8
         V//6CEiScX5S2x2IC20x6H1yGSvMp+RQFeTMLaa5Kg179RjuBr5ubik5f+k7FHlOtrz8
         /1yyWi5z+XL937W0y9Z7Ig5mC+tPH3rtjzs5z4QIrcs3ljOI+0ncYnF2rwQiazxta2tB
         XPpWhKu2ooep33//L35vwlytnMtB4SB9zWuKewMFlDR+JidoIeSz3vCSmkhZ38XnltWb
         AT9g==
X-Gm-Message-State: AOAM533ipYzMUE7PIWaOxnmm79bhjAy7i1WU/lxBMmyjsSaVjnmsOXT0
        EHrGb1WheGJE5ekN05xnVWL0flXiU9xcpyZZFb+GsPG1ACFFHPUCz/KweyS68DOeEMxZ7Hs8/4d
        Gvg5mtARKCfiUNpvnsTgx+qVQ
X-Received: by 2002:a1c:20d3:: with SMTP id g202mr32061384wmg.129.1638717236895;
        Sun, 05 Dec 2021 07:13:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEiPZOYPKBWMVLyfryKqzrDQaJxX/0GpUn1xVQTfiO9GOrRvZsZtUoYNyC2YJnHbl7Mu5hHg==
X-Received: by 2002:a1c:20d3:: with SMTP id g202mr32061370wmg.129.1638717236699;
        Sun, 05 Dec 2021 07:13:56 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id z6sm8348888wrm.93.2021.12.05.07.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 07:13:56 -0800 (PST)
Date:   Sun, 5 Dec 2021 16:13:54 +0100
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
Subject: Re: [PATCH v12 01/16] perf record: Introduce thread affinity and
 mmap masks
Message-ID: <YazXMuT+oQ9cFeTi@krava>
References: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
 <22ee51ee5430b51eee5f03301fb498d5d3e33d1e.1637675515.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22ee51ee5430b51eee5f03301fb498d5d3e33d1e.1637675515.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 05:07:57PM +0300, Alexey Bayduraev wrote:

SNIP

> +static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cpu_map *cpus)
> +{
> +	int c;
> +
> +	for (c = 0; c < cpus->nr; c++)
> +		set_bit(cpus->map[c], mask->bits);
> +}
> +
> +static void record__free_thread_masks(struct record *rec, int nr_threads)
> +{
> +	int t;
> +
> +	if (rec->thread_masks)
> +		for (t = 0; t < nr_threads; t++)
> +			record__thread_mask_free(&rec->thread_masks[t]);
> +
> +	zfree(&rec->thread_masks);
> +}
> +
> +static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr_bits)
> +{
> +	int t, ret;
> +
> +	rec->thread_masks = zalloc(nr_threads * sizeof(*(rec->thread_masks)));
> +	if (!rec->thread_masks) {
> +		pr_err("Failed to allocate thread masks\n");
> +		return -ENOMEM;
> +	}
> +
> +	for (t = 0; t < nr_threads; t++) {
> +		ret = record__thread_mask_alloc(&rec->thread_masks[t], nr_bits);
> +		if (ret)
> +			goto out_free;
> +		record__thread_mask_clear(&rec->thread_masks[t]);

nit, is this clear needed?

jirka

> +	}
> +
> +	return 0;
> +
> +out_free:
> +	record__free_thread_masks(rec, nr_threads);
> +
> +	return ret;
> +}
> +

SNIP

