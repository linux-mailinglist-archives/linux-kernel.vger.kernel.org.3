Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F8346F427
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhLITn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:43:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:24456 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhLITn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639078824; x=1670614824;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=jBbWetDjW6tzongDTRJF/vdw5vhM7eHFdgOaNQyJnkg=;
  b=Fvc92D1Prtf2RZ8ynrPUqSLJlgoh1bNuCHUAR1MlcZQ6DMkN+BXJP7up
   go+m5BQGJ/fQLkCJ6R5SF3Rm/btBmo75mhpP5nrbaOP+AkOQb4L1spstt
   FDKrR6dnW+kiy/L4D2W7UUh9PEa/axR/r/fVwSIkGCwsYEJnOXBlj5Bbi
   jS090bfALRYpXIa7bbDhVScKJ/eUv6Q5AfKudYlzVCDxd8r57Xxd/w3z2
   L75RgwB2WPoSc/wt6fOP+xfZ0AIrK6v6M15KUOHopmUNJGY4MWRQXianF
   +78tmgvwLcVC6gTVsZl2p9+pZmj2dfH2xtp23L399GlVx/0+IVYz9ThoD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="235704847"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="235704847"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 11:40:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="503622544"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga007.jf.intel.com with ESMTP; 09 Dec 2021 11:40:20 -0800
Subject: Re: [PATCH] perf dlfilter: Drop unused variable
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Cc:     German Gomez <german.gomez@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211123211821.132924-1-carnil@debian.org>
 <5603b487-3e42-cfbd-200b-250c46dc0bc6@arm.com> <YbCS/xEis4QKbH6D@eldamar.lan>
 <YbJW9sHObkXC5lcz@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c43649d7-aa30-f207-bae1-42809b352397@intel.com>
Date:   Thu, 9 Dec 2021 21:40:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YbJW9sHObkXC5lcz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2021 21:20, Arnaldo Carvalho de Melo wrote:
> Em Wed, Dec 08, 2021 at 12:11:59PM +0100, Salvatore Bonaccorso escreveu:
>> Hi German,
>>
>> On Wed, Dec 08, 2021 at 10:44:01AM +0000, German Gomez wrote:
>>>
>>> On 23/11/2021 21:18, Salvatore Bonaccorso wrote:
>>>> Compiling tools/perf/dlfilters/dlfilter-test-api-v0.c result in:
>>>>
>>>> 	checking for stdlib.h... dlfilters/dlfilter-test-api-v0.c: In function ‘filter_event’:
>>>> 	dlfilters/dlfilter-test-api-v0.c:311:29: warning: unused variable ‘d’ [-Wunused-variable]
>>>> 	  311 |         struct filter_data *d = data;
>>>> 	      |
>>>
>>> Did you get this warning when issuing "make"? From my side, it generated
>>> this gcc command so I didn't get it (make DEBUG=1):
>>>
>>>   gcc -c -Iinclude  -o dlfilters/dlfilter-test-api-v0.o -fpic dlfilters/dlfilter-test-api-v0.c
>>>
>>> Reviewed-by: German Gomez <german.gomez@arm.com>
>>
>> Only when passing -Wall (this is the case when building the kernel packages in
>> Debian with additional flags, so this is why this was spotted):
>>
>> gcc -Wall -c -Iinclude  -o dlfilters/dlfilter-test-api-v0.o -fpic dlfilters/dlfilter-test-api-v0.c
>> dlfilters/dlfilter-test-api-v0.c: In function ‘filter_event’:
>> dlfilters/dlfilter-test-api-v0.c:311:29: warning: unused variable ‘d’ [-Wunused-variable]
>>   311 |         struct filter_data *d = data;
>>       |
>>
> 
> So I'm applying this, its an obvious cleanup, but please CC the author
> next time, I'm doing it in this reply, Adrian, ok?

Yes, thank you!
