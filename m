Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B5258F1FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 19:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiHJRzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 13:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbiHJRzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 13:55:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DA66186EF;
        Wed, 10 Aug 2022 10:55:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B492611FB;
        Wed, 10 Aug 2022 10:55:48 -0700 (PDT)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E554C3F5A1;
        Wed, 10 Aug 2022 10:55:46 -0700 (PDT)
Message-ID: <67f38a67-d664-4537-6df0-5fdef7596e52@foss.arm.com>
Date:   Wed, 10 Aug 2022 18:55:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 12/14] perf test: Add unroll thread test shell script
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
 <20220728145256.2985298-13-carsten.haitzler@foss.arm.com>
 <20220807054406.GJ34254@leoy-ThinkPad-X240s>
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <20220807054406.GJ34254@leoy-ThinkPad-X240s>
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



On 8/7/22 06:44, Leo Yan wrote:
> On Thu, Jul 28, 2022 at 03:52:54PM +0100, carsten.haitzler@foss.arm.com wrote:
>> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
>>
>> This adds scripts to drive the unroll thread tests to compare perf
>> output against a minimum bar of content/quality.
>>
>> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
>> ---
>>   .../shell/coresight/unroll_loop_thread_10.sh   | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>   create mode 100755 tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
>>
>> diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh b/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
>> new file mode 100755
>> index 000000000000..f48c85230b15
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
>> @@ -0,0 +1,18 @@
>> +#!/bin/sh -e
>> +# CoreSight / Unroll Loop Thread 10
>> +
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +
>> +TEST="unroll_loop_thread"
>> +. $(dirname $0)/../lib/coresight.sh
>> +ARGS="10"
>> +DATV="10"
>> +DATA="$DATD/perf-$TEST-$DATV.data"
>> +
>> +perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
>> +
>> +perf_dump_aux_verify "$DATA" 10 10 10
> 
> Just minor comments for checking the trace data quality:
> 
> The unroll program loops for 10000 times per thread, and this test
> creates 10 threads; so if we pass the parameter "10 10 10" for
> perf_dump_aux_verify, seems to me this is very conservative?

Correct. It's very conservative. It's essentially saying "i need just 
SOME data... something minimal to say it caught something executing". It 
SHOULD catch it, but the more I raise these numbers, the more likely it 
is sometimes you get failures. At the start My numbers were chosen at 
about 20% of the minimum run of the code empirically. It's not 100%^ 
pure ASM so some is compiler generated code thus some may vary per 
binary produced by different compilers and options, so there has to be 
some leeway.

So I did lower the bar to "some data - just some" as opposed to "a 
reasonable amount of data" which would be larger numbers. The csv files 
still store this side-bad data anyway.

> I would like hear Mike's opinion for these quality metrics; the
> patch itself is fine for me, you could add my review tag:
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> 
> 
> P.s. it's off-topic, just want to remind to use the "b4" tool when you
> spin for next version's patch set, e.g. you could use below commands:
> 
>    $ b4 am 20220728145256.2985298-1-carsten.haitzler@foss.arm.com
>              ^
>              ` I get the message ID from the page:
>                https://lore.kernel.org/lkml/20220728145256.2985298-1-carsten.haitzler@foss.arm.com/
>    $ git am ./v5_20220728_carsten_haitzler_a_patch_series_improving_data_quality_of_perf_test_for_coresight.mbx
> 
> We can benefit from this due "b4" can automatically append tags in
> patches; this can help us to track which patches have been reviewed
> and tested in previous versions.

OK - that's news to me. I'll look into it.

> Thanks,
> Leo
> 
>> +
>> +err=$?
>> +exit $err
>> -- 
>> 2.32.0
>>
