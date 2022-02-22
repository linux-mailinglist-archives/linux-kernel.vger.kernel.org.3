Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2FF4BFD72
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbiBVPuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiBVPuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:50:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9980046B16;
        Tue, 22 Feb 2022 07:49:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 607211042;
        Tue, 22 Feb 2022 07:49:35 -0800 (PST)
Received: from [10.57.39.208] (unknown [10.57.39.208])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 878FF3F70D;
        Tue, 22 Feb 2022 07:49:32 -0800 (PST)
Message-ID: <8f563870-3410-221d-4464-5c54a0018b55@arm.com>
Date:   Tue, 22 Feb 2022 15:49:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] perf: cs-etm: Fix corrupt inject files when only last
 branch option is enabled
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     linux-perf-users@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220210200620.1227232-1-james.clark@arm.com>
 <20220210200620.1227232-2-james.clark@arm.com>
 <20220211160516.GD475776@leoy-ThinkPad-X240s> <YgvBpvYzAMCGSECj@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <YgvBpvYzAMCGSECj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/02/2022 15:07, Arnaldo Carvalho de Melo wrote:
> Em Sat, Feb 12, 2022 at 12:05:16AM +0800, Leo Yan escreveu:
>> On Thu, Feb 10, 2022 at 08:06:20PM +0000, James Clark wrote:
>>> Perf inject with Coresight data generates files that cannot be opened
>>> when only the last branch option is specified:
>>>
>>>   perf inject -i perf.data --itrace=l -o inject.data
>>>   perf script -i inject.data
>>>   0x33faa8 [0x8]: failed to process type: 9 [Bad address]
>>>
>>> This is because cs_etm__synth_instruction_sample() is called even when
>>> the sample type for instructions hasn't been setup. Last branch records
>>> are attached to instruction samples so it doesn't make sense to generate
>>> them when --itrace=i isn't specified anyway.
>>>
>>> This change disables all calls of cs_etm__synth_instruction_sample()
>>> unless --itrace=i is specified, resulting in a file with no samples if
>>> only --itrace=l is provided, rather than a bad file.
>>>
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>
>> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> 
> Thanks, applied.
> 
> - Arnaldo
> 

Thanks Leo and Arnaldo!

>  
>>> ---
>>>  tools/perf/util/cs-etm.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>>> index 796a065a500e..8b95fb3c4d7b 100644
>>> --- a/tools/perf/util/cs-etm.c
>>> +++ b/tools/perf/util/cs-etm.c
>>> @@ -1553,6 +1553,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
>>>  		goto swap_packet;
>>>  
>>>  	if (etmq->etm->synth_opts.last_branch &&
>>> +	    etmq->etm->synth_opts.instructions &&
>>>  	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
>>>  		u64 addr;
>>>  
>>> @@ -1610,6 +1611,7 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq,
>>>  	 * the trace.
>>>  	 */
>>>  	if (etmq->etm->synth_opts.last_branch &&
>>> +	    etmq->etm->synth_opts.instructions &&
>>>  	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
>>>  		u64 addr;
>>>  
>>> -- 
>>> 2.28.0
>>>
> 
