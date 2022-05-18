Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B660852BCA9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbiERN0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbiERNZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:25:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14D3D248F9;
        Wed, 18 May 2022 06:25:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB38223A;
        Wed, 18 May 2022 06:25:42 -0700 (PDT)
Received: from [10.57.4.200] (unknown [10.57.4.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A3013F73D;
        Wed, 18 May 2022 06:25:40 -0700 (PDT)
Message-ID: <8f48b4d3-b463-a858-c0fc-0d503eee42dd@arm.com>
Date:   Wed, 18 May 2022 14:25:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/4] perf tools: Use dynamic register set for Dwarf
 unwind
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        broonie@kernel.org, acme@kernel.org, german.gomez@arm.com,
        mathieu.poirier@linaro.org, john.garry@huawei.com,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220517102005.3022017-1-james.clark@arm.com>
 <20220517102005.3022017-3-james.clark@arm.com>
 <20220517110322.GC153558@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220517110322.GC153558@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/05/2022 12:03, Leo Yan wrote:
> On Tue, May 17, 2022 at 11:20:03AM +0100, James Clark wrote:
>> Architectures can detect availability of extra registers at
>> runtime so use this more complete set for unwinding. This
>> will include the VG register on arm64 in a later commit.
>>
>> If the function isn't implemented then PERF_REGS_MASK is
>> returned and there is no change.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
> 
> This patch looks good to me:
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> 
> Just curious, do you think should update the test (e.g.
> arch/arm64/tests/dwarf-unwind.c) to use arch__user_reg_mask()?

I don't think so because the normal set of registers is manually
loaded in tools/perf/arch/arm64/tests/regs_load.S so it wouldn't
include this pseudo register. Also there is no SVE in the call
chain of the test so it would never have an effect.

I could add a new test for SVE, but it depends on getting the
libunwind changes through first so will have to come later.

Thanks,
James

> 
> Thanks,
> Leo
> 
>> ---
>>  tools/perf/util/evsel.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index 5fd7924f8eb3..787bbcbcd2ae 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -896,7 +896,7 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
>>  					   "specifying a subset with --user-regs may render DWARF unwinding unreliable, "
>>  					   "so the minimal registers set (IP, SP) is explicitly forced.\n");
>>  			} else {
>> -				attr->sample_regs_user |= PERF_REGS_MASK;
>> +				attr->sample_regs_user |= arch__user_reg_mask();
>>  			}
>>  			attr->sample_stack_user = param->dump_size;
>>  			attr->exclude_callchain_user = 1;
>> -- 
>> 2.28.0
>>
