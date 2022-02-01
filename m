Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4E64A57D9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 08:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbiBAHfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 02:35:42 -0500
Received: from mga18.intel.com ([134.134.136.126]:45200 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233079AbiBAHfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 02:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643700941; x=1675236941;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SRYaiFMBny6ljAarJROz1RKcPtjybKoMtdHqG8tHxDw=;
  b=RIQ0+oH4HD+jUzNiGGF0KuTMns39glltEfmKbEhs8Q8OMIZ9OGus8wn4
   M4nr0ChoDjemLlpbE3SG6+9fc3D1/tFMUxtuwYjLcM1Ai3qUyhDO7Q0tL
   pMWPGeQ6sfClwLWw7r2NccahGqmfY+g0Ws7Fo44hFQM+8W2qmW+bGyzrg
   BuLmz8QD7E2CLUtDcLsPa7dE4fjhxksxluq70kKc0O7oJsMnLDvwoshx3
   7ouIRDj9QzOANCCCdFUYJv1vNXA4KGLj9AzVmvQ0swAvOOrq3Tlb4X/H3
   2UqJBboO+6XwaFR2ro6TURle4NuXsSR6OttVAw2qjNsCy5cQeBrNI9cpY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="231207739"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="231207739"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:35:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="522966414"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.225.106]) ([10.249.225.106])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:35:38 -0800
Message-ID: <2f61c060-0020-8e55-130d-98e59321010a@linux.intel.com>
Date:   Tue, 1 Feb 2022 10:35:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v13 05/16] perf record: Introduce thread local variable
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
 <0d127555219991c1dcd6c6bb76b24fa6b78d2932.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <YfhYfG0Ak92VmcFL@kernel.org>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
In-Reply-To: <YfhYfG0Ak92VmcFL@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.02.2022 0:45, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jan 17, 2022 at 09:34:25PM +0300, Alexey Bayduraev escreveu:
>> Introduce thread local variable and use it for threaded trace streaming.
>> Use thread affinity mask instead of record affinity mask in affinity
>> modes. Use evlist__ctlfd_update() to propagate control commands from
>> thread object to global evlist object to enable evlist__ctlfd_*
>> functionality. Move waking and sample statistic to struct record_thread
>> and introduce record__waking function to calculate the total number of
>> wakes.

SNIP

>>  	if (record__open(rec) != 0) {
>>  		err = -1;
>> -		goto out_child;
>> +		goto out_free_threads;
>>  	}

SNIP

>>  
>>  out_child:
>> -	evlist__finalize_ctlfd(rec->evlist);
>> +	record__stop_threads(rec);
>>  	record__mmap_read_all(rec, true);
>> +out_free_threads:
>>  	record__free_thread_data(rec);
>> +	evlist__finalize_ctlfd(rec->evlist);
> 
> You changed the calling order, moving evlist__finalize_ctlfd to after
> record__mmap_read_all, is that ok? And if so, should be in a separate
> patch, right?

This is necessary because record__mmap_read_all() must be right after 
record__stop_threads() to prevent data loss, but we must deinitialize
ctlfd after out_free_threads as it was initialized in record__open()

record__mmap_read_all() looks independent of evlist__finalize_ctlfd()
but I think any deinitialization in evlist would be safer after
record__mmap_read_all()

Probably adding such notes to this patch will be enough.

Regards,
Alexey

> 
> - Arnaldo
> 
>>  	record__aio_mmap_read_sync(rec);
>>  
>>  	if (rec->session->bytes_transferred && rec->session->bytes_compressed) {
>> @@ -3164,17 +3224,6 @@ int cmd_record(int argc, const char **argv)
>>  
>>  	symbol__init(NULL);
>>  
>> -	if (rec->opts.affinity != PERF_AFFINITY_SYS) {
>> -		rec->affinity_mask.nbits = cpu__max_cpu().cpu;
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
>> @@ -3323,7 +3372,6 @@ int cmd_record(int argc, const char **argv)
>>  
>>  	err = __cmd_record(&record, argc, argv);
>>  out:
>> -	bitmap_free(rec->affinity_mask.bits);
>>  	evlist__delete(rec->evlist);
>>  	symbol__exit();
>>  	auxtrace_record__free(rec->itr);
>> -- 
>> 2.19.0
> 
