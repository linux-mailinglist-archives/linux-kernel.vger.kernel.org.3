Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE1D47A7CD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 11:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhLTKiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 05:38:03 -0500
Received: from mga05.intel.com ([192.55.52.43]:32231 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhLTKiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 05:38:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="326437569"
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="326437569"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 02:37:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="520750014"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.226.24]) ([10.249.226.24])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 02:37:51 -0800
Message-ID: <90352f48-86a8-f8d9-2b74-b884b32d013d@linux.intel.com>
Date:   Mon, 20 Dec 2021 13:37:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v12 01/16] perf record: Introduce thread affinity and mmap
 masks
Content-Language: en-GB
To:     Jiri Olsa <jolsa@redhat.com>
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
References: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
 <22ee51ee5430b51eee5f03301fb498d5d3e33d1e.1637675515.git.alexey.v.bayduraev@linux.intel.com>
 <YazXMuT+oQ9cFeTi@krava>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
In-Reply-To: <YazXMuT+oQ9cFeTi@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.2021 18:13, Jiri Olsa wrote:
> On Tue, Nov 23, 2021 at 05:07:57PM +0300, Alexey Bayduraev wrote:
> 
> SNIP
> 
>> +static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cpu_map *cpus)
>> +{
>> +	int c;
>> +
>> +	for (c = 0; c < cpus->nr; c++)
>> +		set_bit(cpus->map[c], mask->bits);
>> +}
>> +
>> +static void record__free_thread_masks(struct record *rec, int nr_threads)
>> +{
>> +	int t;
>> +
>> +	if (rec->thread_masks)
>> +		for (t = 0; t < nr_threads; t++)
>> +			record__thread_mask_free(&rec->thread_masks[t]);
>> +
>> +	zfree(&rec->thread_masks);
>> +}
>> +
>> +static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr_bits)
>> +{
>> +	int t, ret;
>> +
>> +	rec->thread_masks = zalloc(nr_threads * sizeof(*(rec->thread_masks)));
>> +	if (!rec->thread_masks) {
>> +		pr_err("Failed to allocate thread masks\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	for (t = 0; t < nr_threads; t++) {
>> +		ret = record__thread_mask_alloc(&rec->thread_masks[t], nr_bits);
>> +		if (ret)
>> +			goto out_free;
>> +		record__thread_mask_clear(&rec->thread_masks[t]);
> 
> nit, is this clear needed?

Hi,

You are right, since all elements of mask->bits is set to zero after
bitmap_zalloc in record__thread_mask_alloc, calling
record__thread_mask_clear after record__thread_mask_alloc
is redundant.
I will remove it here and in [PATCH v12 13/16].

Thanks,
Alexey

> 
> jirka
> 
>> +	}
>> +
>> +	return 0;
>> +
>> +out_free:
>> +	record__free_thread_masks(rec, nr_threads);
>> +
>> +	return ret;
>> +}
>> +
> 
> SNIP
> 
