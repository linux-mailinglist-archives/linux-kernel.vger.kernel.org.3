Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1E64A5B64
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbiBALqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:46:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:18384 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237374AbiBALqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643715970; x=1675251970;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UhhAmOP08mHpiYGdG5oTLPDaeji3h56e/uushyLLwi4=;
  b=AQCNBruFQX6Fx1tBHuG1HBo6RpxKa817feMvhtDbxjq8IbzOZivOzGd9
   7qT/dwyQiVXBWFcHWbs9swkMDQBJRWW8iH2HgIt1OF/Vq9V8v35+Eu47k
   sI2jbURU9Oga4mESUnW8IElPnK7SoPxFUj1TpzSyqTOAGkOAVUBFaNwwz
   UbO1FIsM5CGboUz0M5F3nrrRwwWXy7YQx7mwxTGmDSUV49FVsgDuRKC7R
   mpd4EbMtGz/8FKhTVjzf/yxCSynaQqEq94d4/6NFUcHW+K6b3Oi/FbMDA
   7S744c0XlKaY32RYHz26rPTi2yjG+jjs4MWrD8D41YCEouGzNpdOVU61l
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="310981333"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="310981333"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 03:46:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="537775993"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.225.106]) ([10.249.225.106])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 03:46:04 -0800
Message-ID: <2e0bbc9b-ece1-c90f-6280-72f6440885ad@linux.intel.com>
Date:   Tue, 1 Feb 2022 14:46:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v13 01/16] perf record: Introduce thread affinity and mmap
 masks
Content-Language: en-GB
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <9042bf7daf988e17e17e6acbf5d29590bde869cd.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <YfhN7kTLECDwgPLh@kernel.org> <YfhRkx0Ntp+g029v@kernel.org>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
In-Reply-To: <YfhRkx0Ntp+g029v@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.02.2022 0:16, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jan 31, 2022 at 06:00:31PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Mon, Jan 17, 2022 at 09:34:21PM +0300, Alexey Bayduraev escreveu:
>>> Introduce affinity and mmap thread masks. Thread affinity mask
>>> defines CPUs that a thread is allowed to run on. Thread maps
>>> mask defines mmap data buffers the thread serves to stream
>>> profiling data from.
>>>
>>> Acked-by: Andi Kleen <ak@linux.intel.com>
>>> Acked-by: Namhyung Kim <namhyung@gmail.com>
>>> Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
>>> Tested-by: Riccardo Mancini <rickyman7@gmail.com>
>>> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
>>
>> Some simplifications I added here while reviewing this patchkit:
> 
> But then, why allocate these even without using them? I.e. the init
> should be left for when we are sure that we'll actually use this, i.e.
> when the user asks for parallel mode.
> 
> We already have lots of needless initializations, reading of files that
> may not be needed, so we should avoid doing things till we really know
> that we'll use those allocations, readings, etc.
> 
> Anyway, continuing to review, will leave what I have at a separata
> branch so that we can continue from there.

In the current design, we assume that without --threads option nr_threads==1
and we allocate rec->thread_masks and rec->thread_data as arrays of size 1,
also we move some variables from "struct record" to rec->thread_data and
use thread_data[0] (thru "thread" pointer) in main thread instead of
"struct record". This simplifies the later implementation.

With another approach we could assume nr_threads==0 and use only necessary
"struct record" variables, but this adds many if(record__threads_enabled())

Regards,
Alexey

> 
> - Arnaldo
>  
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 41998f2140cd5119..53b88c8600624237 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -2213,35 +2213,33 @@ static int record__parse_affinity(const struct option *opt, const char *str, int
>>  
>>  static int record__mmap_cpu_mask_alloc(struct mmap_cpu_mask *mask, int nr_bits)
>>  {
>> -	mask->nbits = nr_bits;
>>  	mask->bits = bitmap_zalloc(mask->nbits);
>>  	if (!mask->bits)
>>  		return -ENOMEM;
>>  
>> +	mask->nbits = nr_bits;
>>  	return 0;
>>  }
>>  
>>  static void record__mmap_cpu_mask_free(struct mmap_cpu_mask *mask)
>>  {
>>  	bitmap_free(mask->bits);
>> +	mask->bits = NULL;
>>  	mask->nbits = 0;
>>  }
>>  
>>  static int record__thread_mask_alloc(struct thread_mask *mask, int nr_bits)
>>  {
>> -	int ret;
>> +	int ret = record__mmap_cpu_mask_alloc(&mask->maps, nr_bits);
>>  
>> -	ret = record__mmap_cpu_mask_alloc(&mask->maps, nr_bits);
>>  	if (ret) {
>>  		mask->affinity.bits = NULL;
>>  		return ret;
>>  	}
>>  
>>  	ret = record__mmap_cpu_mask_alloc(&mask->affinity, nr_bits);
>> -	if (ret) {
>> +	if (ret)
>>  		record__mmap_cpu_mask_free(&mask->maps);
>> -		mask->maps.bits = NULL;
>> -	}
>>  
>>  	return ret;
>>  }
>> @@ -2733,18 +2731,14 @@ struct option *record_options = __record_options;
>>  
>>  static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cpu_map *cpus)
>>  {
>> -	int c;
>> -
>> -	for (c = 0; c < cpus->nr; c++)
>> +	for (int c = 0; c < cpus->nr; c++)
>>  		set_bit(cpus->map[c].cpu, mask->bits);
>>  }
>>  
>>  static void record__free_thread_masks(struct record *rec, int nr_threads)
>>  {
>> -	int t;
>> -
>>  	if (rec->thread_masks)
>> -		for (t = 0; t < nr_threads; t++)
>> +		for (int t = 0; t < nr_threads; t++)
>>  			record__thread_mask_free(&rec->thread_masks[t]);
>>  
>>  	zfree(&rec->thread_masks);
>> @@ -2752,7 +2746,7 @@ static void record__free_thread_masks(struct record *rec, int nr_threads)
>>  
>>  static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr_bits)
>>  {
>> -	int t, ret;
>> +	int ret;
>>  
>>  	rec->thread_masks = zalloc(nr_threads * sizeof(*(rec->thread_masks)));
>>  	if (!rec->thread_masks) {
>> @@ -2760,7 +2754,7 @@ static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr
>>  		return -ENOMEM;
>>  	}
>>  
>> -	for (t = 0; t < nr_threads; t++) {
>> +	for (int t = 0; t < nr_threads; t++) {
>>  		ret = record__thread_mask_alloc(&rec->thread_masks[t], nr_bits);
>>  		if (ret) {
>>  			pr_err("Failed to allocate thread masks[%d]\n", t);
>> @@ -2778,9 +2772,7 @@ static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr
>>  
>>  static int record__init_thread_default_masks(struct record *rec, struct perf_cpu_map *cpus)
>>  {
>> -	int ret;
>> -
>> -	ret = record__alloc_thread_masks(rec, 1, cpu__max_cpu().cpu);
>> +	int ret = record__alloc_thread_masks(rec, 1, cpu__max_cpu().cpu);
>>  	if (ret)
>>  		return ret;
>>  
>>
>>
>>> ---
>>>  tools/perf/builtin-record.c | 123 ++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 123 insertions(+)
>>>
>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>> index bb716c953d02..41998f2140cd 100644
>>> --- a/tools/perf/builtin-record.c
>>> +++ b/tools/perf/builtin-record.c
>>> @@ -87,6 +87,11 @@ struct switch_output {
>>>  	int		 cur_file;
>>>  };
>>>  
>>> +struct thread_mask {
>>> +	struct mmap_cpu_mask	maps;
>>> +	struct mmap_cpu_mask	affinity;
>>> +};
>>> +
>>>  struct record {
>>>  	struct perf_tool	tool;
>>>  	struct record_opts	opts;
>>> @@ -112,6 +117,8 @@ struct record {
>>>  	struct mmap_cpu_mask	affinity_mask;
>>>  	unsigned long		output_max_size;	/* = 0: unlimited */
>>>  	struct perf_debuginfod	debuginfod;
>>> +	int			nr_threads;
>>> +	struct thread_mask	*thread_masks;
>>>  };
>>>  
>>>  static volatile int done;
>>> @@ -2204,6 +2211,47 @@ static int record__parse_affinity(const struct option *opt, const char *str, int
>>>  	return 0;
>>>  }
>>>  
>>> +static int record__mmap_cpu_mask_alloc(struct mmap_cpu_mask *mask, int nr_bits)
>>> +{
>>> +	mask->nbits = nr_bits;
>>> +	mask->bits = bitmap_zalloc(mask->nbits);
>>> +	if (!mask->bits)
>>> +		return -ENOMEM;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void record__mmap_cpu_mask_free(struct mmap_cpu_mask *mask)
>>> +{
>>> +	bitmap_free(mask->bits);
>>> +	mask->nbits = 0;
>>> +}
>>> +
>>> +static int record__thread_mask_alloc(struct thread_mask *mask, int nr_bits)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = record__mmap_cpu_mask_alloc(&mask->maps, nr_bits);
>>> +	if (ret) {
>>> +		mask->affinity.bits = NULL;
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = record__mmap_cpu_mask_alloc(&mask->affinity, nr_bits);
>>> +	if (ret) {
>>> +		record__mmap_cpu_mask_free(&mask->maps);
>>> +		mask->maps.bits = NULL;
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static void record__thread_mask_free(struct thread_mask *mask)
>>> +{
>>> +	record__mmap_cpu_mask_free(&mask->maps);
>>> +	record__mmap_cpu_mask_free(&mask->affinity);
>>> +}
>>> +
>>>  static int parse_output_max_size(const struct option *opt,
>>>  				 const char *str, int unset)
>>>  {
>>> @@ -2683,6 +2731,73 @@ static struct option __record_options[] = {
>>>  
>>>  struct option *record_options = __record_options;
>>>  
>>> +static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cpu_map *cpus)
>>> +{
>>> +	int c;
>>> +
>>> +	for (c = 0; c < cpus->nr; c++)
>>> +		set_bit(cpus->map[c].cpu, mask->bits);
>>> +}
>>> +
>>> +static void record__free_thread_masks(struct record *rec, int nr_threads)
>>> +{
>>> +	int t;
>>> +
>>> +	if (rec->thread_masks)
>>> +		for (t = 0; t < nr_threads; t++)
>>> +			record__thread_mask_free(&rec->thread_masks[t]);
>>> +
>>> +	zfree(&rec->thread_masks);
>>> +}
>>> +
>>> +static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr_bits)
>>> +{
>>> +	int t, ret;
>>> +
>>> +	rec->thread_masks = zalloc(nr_threads * sizeof(*(rec->thread_masks)));
>>> +	if (!rec->thread_masks) {
>>> +		pr_err("Failed to allocate thread masks\n");
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	for (t = 0; t < nr_threads; t++) {
>>> +		ret = record__thread_mask_alloc(&rec->thread_masks[t], nr_bits);
>>> +		if (ret) {
>>> +			pr_err("Failed to allocate thread masks[%d]\n", t);
>>> +			goto out_free;
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>> +
>>> +out_free:
>>> +	record__free_thread_masks(rec, nr_threads);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int record__init_thread_default_masks(struct record *rec, struct perf_cpu_map *cpus)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = record__alloc_thread_masks(rec, 1, cpu__max_cpu().cpu);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	record__mmap_cpu_mask_init(&rec->thread_masks->maps, cpus);
>>> +
>>> +	rec->nr_threads = 1;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int record__init_thread_masks(struct record *rec)
>>> +{
>>> +	struct perf_cpu_map *cpus = rec->evlist->core.cpus;
>>> +
>>> +	return record__init_thread_default_masks(rec, cpus);
>>> +}
>>> +
>>>  int cmd_record(int argc, const char **argv)
>>>  {
>>>  	int err;
>>> @@ -2948,6 +3063,12 @@ int cmd_record(int argc, const char **argv)
>>>  		goto out;
>>>  	}
>>>  
>>> +	err = record__init_thread_masks(rec);
>>> +	if (err) {
>>> +		pr_err("Failed to initialize parallel data streaming masks\n");
>>> +		goto out;
>>> +	}
>>> +
>>>  	if (rec->opts.nr_cblocks > nr_cblocks_max)
>>>  		rec->opts.nr_cblocks = nr_cblocks_max;
>>>  	pr_debug("nr_cblocks: %d\n", rec->opts.nr_cblocks);
>>> @@ -2966,6 +3087,8 @@ int cmd_record(int argc, const char **argv)
>>>  	symbol__exit();
>>>  	auxtrace_record__free(rec->itr);
>>>  out_opts:
>>> +	record__free_thread_masks(rec, rec->nr_threads);
>>> +	rec->nr_threads = 0;
>>>  	evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack, &rec->opts.ctl_fd_close);
>>>  	return err;
>>>  }
>>> -- 
>>> 2.19.0
>>
>> -- 
>>
>> - Arnaldo
> 
