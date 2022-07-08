Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487F856B537
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237783AbiGHJTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbiGHJTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:19:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D853C2A948;
        Fri,  8 Jul 2022 02:19:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09CB3D6E;
        Fri,  8 Jul 2022 02:19:07 -0700 (PDT)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A30FE3F66F;
        Fri,  8 Jul 2022 02:19:05 -0700 (PDT)
Message-ID: <5dbda300-2ad3-ca23-6013-f3dd3126ba30@foss.arm.com>
Date:   Fri, 8 Jul 2022 10:19:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 08/14] perf test: Add memcpy thread test shell script
Content-Language: en-US
To:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20220701120804.3226396-1-carsten.haitzler@foss.arm.com>
 <20220701120804.3226396-9-carsten.haitzler@foss.arm.com>
 <f6b21fa9-7e0b-cb0d-d708-cfd7f3f53087@arm.com>
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <f6b21fa9-7e0b-cb0d-d708-cfd7f3f53087@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/22 15:25, James Clark wrote:
> 
> 
> On 01/07/2022 13:07, carsten.haitzler@foss.arm.com wrote:
>> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
>>
>> Add a script to drive the threaded memcpy test that gathers data so
>> it passes a minimum bar for amount and quality of content that we
>> extract from the kernel's perf support.
>>
> 
> On this one I get a failure about 1/50 times on N1SDP (I ran it about 150

I also see inconsistent results. The whole point of these tests is to 
point this out and provide data to track it and then lead eventually to 
improvements/fixes. A failing test is probably good - it found a 
problem. Perf test for me has lots of failures so I'm taking the 
position that failures are OK normally in perf test as long as you know 
what those failures are and why.

> times and saw 3 failures so it's quite consistent). Usually it records
> about a 1.4MB file with one aux record. But when it fails the file is
> only 20K and has one small aux record:
> 
>     0 0 0x1a10 [0x30]: PERF_RECORD_AUXTRACE size: 0x1820  offset: 0  ref: 0x1c23126d7ff3d2ab  idx: 3  tid: 682799  cpu: 3
> 
> Nothing was dropped, and the load on the system wasn't any different
> to when it passes. So I'm not sure if this is a real coresight bug
> or that the test is flaky. There was a bug in SPE before where

The binary is the same with the same content running the same perf 
command every time. Workload doesn't change. The perf data captured does 
change. It sometimes captures so little it fails even the low pass bar 
given in the test.

> threads weren't followed after forking, but only very rarely. It feels
> a bit like that.

That ... would be a "CoreSight" bug though I think, not the test.

> It could also be some contention issue because 10 threads are launched
> but the machine only has 4 cores.

We still should be capturing data reliably (in theory). If you have 10 
threads on a 4 core machine it'll take longer to run for the same 
workload as the threads will have to share the same cores, but this 
should still result in decent data collection as the cores switch 
between threads. That's the point.

> The failure message from the test looks like this:
> 
>     77: CoreSight / Memcpy 16k 10 Threads                               :
>     --- start ---
>     Couldn't synthesize bpf events.
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.012 MB ./perf-memcpy_thread-16k_10.data ]
>     Sanity check number of ASYNC is too low (3 < 10)
>      ---- end ----
>     CoreSight / Memcpy 16k 10 Threads: FAILED!
> 
> I didn't see this issue on any of the other tests. Sometimes very small
> files were made if I loaded the system, but the tests still passed.

For me the "Check TID" tests fails very often... but as I said - the 
point here is to find issues and ensure they are reported in results. 
The test even track the results over time/many runs in the csv files so 
you get a good idea of consistency and even how it may statistically 
change over time matching that up to changes in the kernel.

Unless of course you think it's acceptable that sometimes perf record + 
CoreSight will output essentially no data (your 20k example). :)

> Thanks
> James
> 
>> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
>> ---
>>   .../shell/coresight/memcpy_thread_16k_10.sh    | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>   create mode 100755 tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
>>
>> diff --git a/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh b/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
>> new file mode 100755
>> index 000000000000..d21ba8545938
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
>> @@ -0,0 +1,18 @@
>> +#!/bin/sh -e
>> +# CoreSight / Memcpy 16k 10 Threads
>> +
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +
>> +TEST="memcpy_thread"
>> +. $(dirname $0)/../lib/coresight.sh
>> +ARGS="16 10 1"
>> +DATV="16k_10"
>> +DATA="$DATD/perf-$TEST-$DATV.data"
>> +
>> +perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
>> +
>> +perf_dump_aux_verify "$DATA" 10 10 10
>> +
>> +err=$?
>> +exit $err
