Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563D647A76A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 10:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhLTJtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 04:49:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:6090 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230170AbhLTJtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 04:49:31 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="240088062"
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="240088062"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 01:49:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="520737723"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.226.24]) ([10.249.226.24])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 01:49:27 -0800
Message-ID: <9f8f8b08-04f5-38af-bb03-e86ac8d67d01@linux.intel.com>
Date:   Mon, 20 Dec 2021 12:49:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v12 05/16] perf record: Introduce thread local variable
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
 <c9f2747f11fcce59b879b547f8128f2ae5a7f8c0.1637675515.git.alexey.v.bayduraev@linux.intel.com>
 <YazXWM7rVdaoF4yX@krava>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
In-Reply-To: <YazXWM7rVdaoF4yX@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.12.2021 18:14, Jiri Olsa wrote:
> On Tue, Nov 23, 2021 at 05:08:01PM +0300, Alexey Bayduraev wrote:
> 
> SNIP
> 
>>  
>> +	if (record__start_threads(rec))
>> +		goto out_free_threads;
>> +
>>  	/*
>>  	 * When perf is starting the traced process, all the events
>>  	 * (apart from group members) have enable_on_exec=1 set,
>> @@ -2122,7 +2175,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>  	trigger_ready(&switch_output_trigger);
>>  	perf_hooks__invoke_record_start();
>>  	for (;;) {
>> -		unsigned long long hits = rec->samples;
>> +		unsigned long long hits = thread->samples;
>>  
>>  		/*
>>  		 * rec->evlist->bkw_mmap_state is possible to be
>> @@ -2176,8 +2229,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>  
>>  			if (!quiet)
>>  				fprintf(stderr, "[ perf record: dump data: Woken up %ld times ]\n",
>> -					waking);
>> -			waking = 0;
>> +					record__waking(rec));
>> +			thread->waking = 0;
>>  			fd = record__switch_output(rec, false);
>>  			if (fd < 0) {
>>  				pr_err("Failed to switch to new file\n");
>> @@ -2191,20 +2244,24 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>  				alarm(rec->switch_output.time);
>>  		}
>>  
>> -		if (hits == rec->samples) {
>> +		if (hits == thread->samples) {
>>  			if (done || draining)
>>  				break;
>> -			err = evlist__poll(rec->evlist, -1);
>> +			err = fdarray__poll(&thread->pollfd, -1);
>>  			/*
>>  			 * Propagate error, only if there's any. Ignore positive
>>  			 * number of returned events and interrupt error.
>>  			 */
>>  			if (err > 0 || (err < 0 && errno == EINTR))
>>  				err = 0;
>> -			waking++;
>> +			thread->waking++;
>>  
>> -			if (evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
>> +			if (fdarray__filter(&thread->pollfd, POLLERR | POLLHUP,
>> +					    record__thread_munmap_filtered, NULL) == 0)
>>  				draining = true;
>> +
>> +			evlist__ctlfd_update(rec->evlist,
>> +				&thread->pollfd.entries[thread->ctlfd_pos]);
> 
> hm, why is this needed? we only switch to record_thread data, right?
> there should not be any processing change

Hi,

This is necessary to propagate ctlfd events from thread->pollfd to rec->evlist
to enable evlist__ctlfd_*() functionality, see [PATCH v12 04/16].
I will add explanations to the description of the patch.

Regards,
Alexey

> 
> jirka
> 
>>  		}
>>  
>>  		if (evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
>> @@ -2258,15 +2315,18 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>  	}
>>  
>>  	if (!quiet)
>> -		fprintf(stderr, "[ perf record: Woken up %ld times to write data ]\n", waking);
>> +		fprintf(stderr, "[ perf record: Woken up %ld times to write data ]\n",
>> +			record__waking(rec));
>>  
>>  	if (target__none(&rec->opts.target))
>>  		record__synthesize_workload(rec, true);
>>  
>>  out_child:
>> -	evlist__finalize_ctlfd(rec->evlist);
>> +	record__stop_threads(rec);
>>  	record__mmap_read_all(rec, true);
>> +out_free_threads:
>>  	record__free_thread_data(rec);
>> +	evlist__finalize_ctlfd(rec->evlist);
>>  	record__aio_mmap_read_sync(rec);
>>  
>>  	if (rec->session->bytes_transferred && rec->session->bytes_compressed) {
>> @@ -3158,17 +3218,6 @@ int cmd_record(int argc, const char **argv)
>>  
>>  	symbol__init(NULL);
>>  
>> -	if (rec->opts.affinity != PERF_AFFINITY_SYS) {
>> -		rec->affinity_mask.nbits = cpu__max_cpu();
>> -		rec->affinity_mask.bits = bitmap_zalloc(rec->affinity_mask.nbits);
>> -		if (!rec->affinity_mask.bits) {
>> -			pr_err("Failed to allocate thread mask for %zd cpus\n", rec->affinity_mask.nbits);
>> -			err = -ENOMEM;
>> -			goto out_opts;
>> -		}
>> -		pr_debug2("thread mask[%zd]: empty\n", rec->affinity_mask.nbits);
>> -	}
>> -
>>  	err = record__auxtrace_init(rec);
>>  	if (err)
>>  		goto out;
>> @@ -3313,7 +3362,6 @@ int cmd_record(int argc, const char **argv)
>>  
>>  	err = __cmd_record(&record, argc, argv);
>>  out:
>> -	bitmap_free(rec->affinity_mask.bits);
>>  	evlist__delete(rec->evlist);
>>  	symbol__exit();
>>  	auxtrace_record__free(rec->itr);
>> -- 
>> 2.19.0
>>
> 
