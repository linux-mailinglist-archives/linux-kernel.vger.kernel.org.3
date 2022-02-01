Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C994A584D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiBAII5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:08:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:6555 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229895AbiBAII4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643702936; x=1675238936;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qrTzs7KNuNvowMdSGJ1jIYqS1al0ZQmkfwngAUCdmn8=;
  b=nDzMzNCvqp+/0zzf9d6HqF985wrJYOp0fpp/VKC0rsEDhxoDWXfEtmnH
   7qqThS7WsT9CwoUvYfvJE3VvB9DgWcOwMA4fwk/VjguhlnoxUJ/FL7xXP
   ov7DrJLRhQwNJjwzg5qBIrg93R87GGr3Bb/7nRAYS3ZhIzLgWz6MJaTO4
   8aqdCLbUV/TWKVNVhEmtvK1WI48bMWNv7Uju38Ie08jiSo8X7ON+mxHmH
   C/8ZEhmUVmb2Q3g1UIgD7Ti3pcCa+bBm5Svx2onC2fi3/mIr+fF6vQi7H
   nZCyw+EtG8Pu2SpyG4LT7hsB6l1TMzcIAo5OtT/q95SYjSyB7mJzdj1bb
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="246473941"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="246473941"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 00:08:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="522973152"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.225.106]) ([10.249.225.106])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 00:08:52 -0800
Message-ID: <9867b3a1-8c73-077a-73f6-013af7209b4d@linux.intel.com>
Date:   Tue, 1 Feb 2022 11:08:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v13 10/16] perf record: Introduce compressor at mmap
 buffer object
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
 <80edc286cf6543139a7d5a91217605123aa0b50d.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <YfhbEd/QYIZzsgw2@kernel.org>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
In-Reply-To: <YfhbEd/QYIZzsgw2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.02.2022 0:56, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jan 17, 2022 at 09:34:30PM +0300, Alexey Bayduraev escreveu:
>> Introduce compressor object into mmap object so it could be used to
>> pack the data stream from the corresponding kernel data buffer.
>> Initialize and make use of the introduced per mmap compressor.

SNIP

>> --- a/tools/perf/util/mmap.c
>> +++ b/tools/perf/util/mmap.c
>> @@ -230,6 +230,10 @@ void mmap__munmap(struct mmap *map)
>>  {
>>  	bitmap_free(map->affinity_mask.bits);
>>  
>> +#ifndef PYTHON_PERF
>> +	zstd_fini(&map->zstd_data);
>> +#endif
>> +
> 
> Exposing this build detail in the main source code seems ugly, casual
> readers will scratch their heads trying to figure this out, so either
> we should have this behind some macro that hides these deps on a header
> file or add a comment stating why this is needed.

This is quick fix for the fact that the perf.so library for Python is not
compiled with -lzstd, but it includes mmap.c. Probably adding stub macro
to mmap.h would be better.

Regards,
Alexey

> 	
> 
>>  	perf_mmap__aio_munmap(map);
>>  	if (map->data != NULL) {
>>  		munmap(map->data, mmap__mmap_len(map));
>> @@ -292,6 +296,12 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, struct perf_cpu
>>  	map->core.flush = mp->flush;
>>  
>>  	map->comp_level = mp->comp_level;
>> +#ifndef PYTHON_PERF
>> +	if (zstd_init(&map->zstd_data, map->comp_level)) {
>> +		pr_debug2("failed to init mmap commpressor, error %d\n", errno);
>> +		return -1;
>> +	}
>> +#endif
>>  
>>  	if (map->comp_level && !perf_mmap__aio_enabled(map)) {
>>  		map->data = mmap(NULL, mmap__mmap_len(map), PROT_READ|PROT_WRITE,
>> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
>> index 62f38d7977bb..cd8b0777473b 100644
>> --- a/tools/perf/util/mmap.h
>> +++ b/tools/perf/util/mmap.h
>> @@ -15,6 +15,7 @@
>>  #endif
>>  #include "auxtrace.h"
>>  #include "event.h"
>> +#include "util/compress.h"
>>  
>>  struct aiocb;
>>  
>> @@ -46,6 +47,7 @@ struct mmap {
>>  	void		*data;
>>  	int		comp_level;
>>  	struct perf_data_file *file;
>> +	struct zstd_data      zstd_data;
>>  };
>>  
>>  struct mmap_params {
>> -- 
>> 2.19.0
> 
