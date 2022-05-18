Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6126552B724
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbiERJqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiERJqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:46:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2C7513CC8;
        Wed, 18 May 2022 02:45:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33AD61FB;
        Wed, 18 May 2022 02:45:01 -0700 (PDT)
Received: from [10.57.4.200] (unknown [10.57.4.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 872E13F66F;
        Wed, 18 May 2022 02:44:58 -0700 (PDT)
Message-ID: <ca02e8f5-04bd-01ff-7b57-0fd08a1e2359@arm.com>
Date:   Wed, 18 May 2022 10:44:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 4/4] perf tools: arm64: Add support for VG register
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
 <20220517102005.3022017-5-james.clark@arm.com>
 <20220517131952.GE153558@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220517131952.GE153558@leoy-ThinkPad-X240s>
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



On 17/05/2022 14:19, Leo Yan wrote:
> On Tue, May 17, 2022 at 11:20:05AM +0100, James Clark wrote:
>> Add the name of the VG register so it can be used in --user-regs
>>
>> The event will fail to open if the register is requested but not
>> available so only add it to the mask if the kernel supports sve and also
>> if it supports that specific register.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/arch/arm64/util/perf_regs.c | 34 ++++++++++++++++++++++++++
>>  tools/perf/util/perf_regs.c            |  2 ++
>>  2 files changed, 36 insertions(+)
>>
>> diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
>> index 476b037eea1c..c0a921512a90 100644
>> --- a/tools/perf/arch/arm64/util/perf_regs.c
>> +++ b/tools/perf/arch/arm64/util/perf_regs.c
>> @@ -2,9 +2,11 @@
>>  #include <errno.h>
>>  #include <regex.h>
>>  #include <string.h>
>> +#include <sys/auxv.h>
>>  #include <linux/kernel.h>
>>  #include <linux/zalloc.h>
>>  
>> +#include "../../../perf-sys.h"
>>  #include "../../../util/debug.h"
>>  #include "../../../util/event.h"
>>  #include "../../../util/perf_regs.h"
>> @@ -43,6 +45,7 @@ const struct sample_reg sample_reg_masks[] = {
>>  	SMPL_REG(lr, PERF_REG_ARM64_LR),
>>  	SMPL_REG(sp, PERF_REG_ARM64_SP),
>>  	SMPL_REG(pc, PERF_REG_ARM64_PC),
>> +	SMPL_REG(vg, PERF_REG_ARM64_VG),
>>  	SMPL_REG_END
>>  };
>>  
>> @@ -131,3 +134,34 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
>>  
>>  	return SDT_ARG_VALID;
>>  }
>> +
>> +uint64_t arch__user_reg_mask(void)
>> +{
>> +	struct perf_event_attr attr = {
>> +		.type                   = PERF_TYPE_HARDWARE,
>> +		.config                 = PERF_COUNT_HW_CPU_CYCLES,
>> +		.sample_type            = PERF_SAMPLE_REGS_USER,
>> +		.disabled               = 1,
>> +		.exclude_kernel         = 1,
>> +		.sample_period		= 1,
>> +		.sample_regs_user	= PERF_REGS_MASK
>> +	};
>> +	int fd;
>> +
>> +	if (getauxval(AT_HWCAP) & HWCAP_SVE)
>> +		attr.sample_regs_user |= SMPL_REG_MASK(PERF_REG_ARM64_VG);
>> +
>> +	/*
>> +	 * Check if the pmu supports perf extended regs, before
>> +	 * returning the register mask to sample.
>> +	 */
>> +	if (attr.sample_regs_user != PERF_REGS_MASK) {
>> +		event_attr_init(&attr);
>> +		fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
>> +		if (fd != -1) {
>> +			close(fd);
>> +			return attr.sample_regs_user;
>> +		}
>> +	}
> 
> Just curious, since we can know SVE is supported from reading
> auxiliary value, can we directly return the register mask as below?
> 
>   PERF_REGS_MASK | SMPL_REG_MASK(PERF_REG_ARM64_VG);

I was trying to cover the case where the system supports SVE, but
the kernel doesn't have my changes to add the VG register yet.

Technically I could just attempt to open the event without checking
for SVE first and see if it works or not. But I preferred to be
explicit so it's obvious why we're doing that.

James

> 
> Except this question, this patch looks good to me.
> 
> Thanks,
> Leo
> 
>> +	return PERF_REGS_MASK;
>> +}
>> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
>> index a982e40ee5a9..872dd3d38782 100644
>> --- a/tools/perf/util/perf_regs.c
>> +++ b/tools/perf/util/perf_regs.c
>> @@ -103,6 +103,8 @@ static const char *__perf_reg_name_arm64(int id)
>>  		return "lr";
>>  	case PERF_REG_ARM64_PC:
>>  		return "pc";
>> +	case PERF_REG_ARM64_VG:
>> +		return "vg";
>>  	default:
>>  		return NULL;
>>  	}
>> -- 
>> 2.28.0
>>
