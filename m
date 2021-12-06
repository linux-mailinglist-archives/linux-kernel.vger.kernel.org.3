Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4E64694EE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242398AbhLFLZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:25:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:21530 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240320AbhLFLZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:25:45 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="237107719"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="237107719"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 03:22:17 -0800
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="514701979"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.226.178]) ([10.249.226.178])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 03:22:13 -0800
Message-ID: <d190206e-f2ea-dbf6-f6b4-5bb062980ad2@linux.intel.com>
Date:   Mon, 6 Dec 2021 14:22:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v12 09/16] perf record: Introduce bytes written stats
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
 <b235542dee6bfaa8966dabf124ec4b7c0b2dc9f9.1637675515.git.alexey.v.bayduraev@linux.intel.com>
 <YazXabglLVSvO5V4@krava>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
In-Reply-To: <YazXabglLVSvO5V4@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.2021 18:14, Jiri Olsa wrote:

<SNIP>

>>  static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>> @@ -210,13 +223,15 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>>  		return -1;
>>  	}
>>  
>> -	if (!(map && map->file))
>> +	if (map && map->file)
>> +		thread->bytes_written += size;
>> +	else
>>  		rec->bytes_written += size;
> 
> ok, that's why ;-) do we actually stil need rec->bytes_written?
> can't we count that under synthesizing main thread->bytes_written?

Hi Jiri,

No, we still need rec->bytes_written because it is used for 
the header in "perf.data/data", and it cannot be replaced by
threads[0].bytes_written because threads[0] is used for
"perf.data/data.0".

Regards,
Alexey

> 
> jirka
> 
>>  
>>  	if (record__output_max_size_exceeded(rec) && !done) {
>>  		fprintf(stderr, "[ perf record: perf size limit reached (%" PRIu64 " KB),"
>>  				" stopping session ]\n",
>> -				rec->bytes_written >> 10);
>> +				record__bytes_written(rec) >> 10);
>>  		done = 1;
>>  	}
>>  
>> -- 
>> 2.19.0
>>
> 
