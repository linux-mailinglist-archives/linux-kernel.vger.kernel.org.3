Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E0449D246
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244341AbiAZTIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:08:22 -0500
Received: from foss.arm.com ([217.140.110.172]:32800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231167AbiAZTIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:08:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DFB21FB;
        Wed, 26 Jan 2022 11:08:21 -0800 (PST)
Received: from [10.57.88.59] (unknown [10.57.88.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D87C3F7D8;
        Wed, 26 Jan 2022 11:08:17 -0800 (PST)
Subject: Re: [PATCH 1/2] perf arm-spe: Add arm_spe_record to synthesized
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        andrew.kilroy@arm.com, benh@kernel.crashing.org,
        james.clark@arm.com, john.garry@huawei.com, jolsa@redhat.com,
        leo.yan@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mathieu.poirier@linaro.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, will@kernel.org
References: <5ca990a5-eedd-0edb-26d3-b5e16c36ac34@arm.com>
 <20220126155820.21929-1-alisaidi@amazon.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <c4a96839-1b4b-ac4d-38aa-26c1f4c8645a@arm.com>
Date:   Wed, 26 Jan 2022 19:07:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220126155820.21929-1-alisaidi@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/01/2022 15:58, Ali Saidi wrote:
> Hi German,
>> Hi Ali,
>>
>> On 25/01/2022 19:20, Ali Saidi wrote:
>>> [...]
>>>
>>> +	sample.raw_size = sizeof(*record);
>>> +	sample.raw_data = record;
>> Have you tried this with perf-inject? I think it would need the PERF_SAMPLE_RAW bit in the sample_type,
> Yes I've tried the following and it worked as expected with the original
> perf.data or the perf.data.jitted after perf-inject. 
>
> perf record -e arm_spe_0/jitter=1/ -k 1 java ...
> perf  inject -f --jit -i perf.data -o perf.data.jitted

This is not injecting the synthesized samples. I think it is still    
processing from the aux trace. Try adding "--itrace=i1i --strip" to the
inject command to remove the AUXTRACE events. Judging by the raw
samples, the data is missing:

11 20005239445831 0x3510 [0x94]: PERF_RECORD_SAMPLE(IP, 0x1): 47670/47670: 0xffffab6e02d1b320 period: 1 addr: 0

. ... raw event: size 64 bytes
.  0000:  09 00 00 00 01 00 40 00 f3 10 9b 3b 00 00 00 00  ......@....;....
.  0010:  98 c5 e3 02 6e ab ff ff 36 ba 00 00 36 ba 00 00  ....n...6...6...
.  0020:  35 da 30 d5 31 12 00 00 0b 00 00 00 00 00 00 00  5.0.1...........
.  0030:  01 00 00 00 00 00 00 00 82 01 00 88 00 00 00 00  ................

vs when adding PERF_SAMPLE_RAW to attr.sample_type:      

. ... raw event: size 148 bytes
.  0000:  09 00 00 00 01 00 94 00 f3 10 9b 3b 00 00 00 00  ...........;....
.  0010:  98 c5 e3 02 6e ab ff ff 36 ba 00 00 36 ba 00 00  ....n...6...6...
[...]
.  0080:  00 00 00 00 2a 00 00 00 00 00 00 00 82 01 00 88  ....*...........
.  0090:  00 00 00 00

> perf script -i perf.data -s t1.py --itrace=i1i
>
>> Although I quickly looked over the perf inject code and it looks like it's expecting some type of padding:
>>
>> [...]
>>
>> I'm seeing some comments in utils/event.h related to this on the intel events.
> Yes i noticed this too,but looking at how the raw data is added to the same
> other places like intel-pt.c:1703 the perf_synth__raw*() functions are used to
> strip away the 4 bytes bytes before the data is added to the sample. The other
> places i can find the padding used is in builtin-script.c but given we have the
> --dump-raw-trace option it's not clear to me that it's needed to wrap the
> arm_spe_event in another struct with padding like perf_synth_intel_ptwrite?

I think the intel use case makes sense because the layout of the data
is fixed and documented. If we modify the struct arm_spe_record later it
may not be obvious how to match it to the raw data of an older perf.data
file. And we're generating bigger files with redundant information.

Thanks,
German

>
> Thanks,
> Ali
>
