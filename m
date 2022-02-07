Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1264ABF45
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385256AbiBGNJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442247AbiBGMUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 07:20:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C93DFDF8E3E8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 04:06:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6927CD6E;
        Mon,  7 Feb 2022 04:06:53 -0800 (PST)
Received: from [10.57.86.115] (unknown [10.57.86.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBEB93F718;
        Mon,  7 Feb 2022 04:06:51 -0800 (PST)
Subject: Re: [RFC PATCH 1/2] perf: arm_spe: Fix consistency of PMSCR register
 bit CX
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, mark.rutland@arm.com, james.clark@arm.com
References: <20220117124432.3119132-1-german.gomez@arm.com>
 <20220117124432.3119132-2-german.gomez@arm.com>
 <20220205153940.GB391033@leoy-ThinkPad-X240s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <4d5951ee-d7d2-1e76-eb24-5f3c46d1662c@arm.com>
Date:   Mon, 7 Feb 2022 12:06:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220205153940.GB391033@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 05/02/2022 15:39, Leo Yan wrote:
> Hi German,
>
> On Mon, Jan 17, 2022 at 12:44:31PM +0000, German Gomez wrote:
>> [...]
>>
>>   1. Run a process in the background with capability CAP_SYS_ADMIN in CPU0.
>>
>>     $ taskset --cpu-list 0 sudo dd if=/dev/random of=/dev/null &
>>     [3] 3806
>>
>>   2. Begin a perf session _without_ capabilities (we shouldn't see CONTEXT packets).
>>
>>     $ perf record -e arm_spe_0// -C0 -- sleep 1
>>     $ perf report -D | grep CONTEXT
>>     .  0000000e:  65 df 0e 00 00                                  CONTEXT 0xedf el2
>>     .  0000004e:  65 df 0e 00 00                                  CONTEXT 0xedf el2
>>     .  0000008e:  65 df 0e 00 00                                  CONTEXT 0xedf el2
>>     [...]
> Could you confirm if you still can reproduce this issue on the latest
> mainline kernel?  I cannot reproduce this issue on the latest mainline
> kernel, I suspect this is impacted by recent refactoring evlist
> patches from Ian Rogers (though I am not for this).

Are you referring to running on the latest kernel or the latest perf
tool? I can still reproduce using perf from v5.17-rc3, on a kernel and
SPE driver from 5.17.0-rc1 (commands below).

>
>> As can be seen, the traces begin showing CONTEXT packets when the pid is
>> 0xedf (3807). This happens because the pmu start callback is run when
>> the current process is not the owner of the perf session, so the CX
>> register bit is set.
> I can image a potential issue is: the "dd" program running in background
> with capability CAP_SYS_ADMIN on CPU0, and then perf session sends an
> IPI remotely from any other CPU to CPU0, the dd process (on CPU0) is
> interrupted to handle ioctl PERF_EVENT_IOC_ENABLE, thus perfmon_capable()
> returns the capability of dd process, finally it leads to the wrong
> setting for PMSCR.
>
> I reviewed the code and also traced the backtrace for the function
> arm_spe_pmu_start(), I can confirm that every time perf session will
> execute below flow:
>
>   evlist__enable()
>     __evlist__enable()
>       evlist__for_each_cpu() {  -> call affinity__set()
>         evsel__enable_cpu()
>       }
>
> We can see the macro evlist__for_each_cpu() will extend to invoke
> evlist__cpu_begin() and affinity__set(); affinity__set() will set CPU
> affinity to the target CPU, thus perf process will firstly migrate to
> the target CPU and enable event on the target CPU.  This means perf
> will not send remote IPI and it directly runs on target CPU, and the
> dd program will not interfere capabilities for perf session.
Thank you for looking at this,

I re-tested on the N1SDP (previously I was using a graviton2 instance).
I had to adjust the command slightly with "-m,2" to get it consistently
this time:

$ taskset --cpu-list 0 sudo dd if=/dev/random of=/dev/null &
$ perf record -e arm_spe_0// -C0 -m,2 -- sleep 1
$ perf report -D | grep CONTEXT | head
.  0000000e:  65 b5 6e 00 00                                  CONTEXT 0x6eb5 el2
.  0000004e:  65 b5 6e 00 00                                  CONTEXT 0x6eb5 el2
.  0000008e:  65 b5 6e 00 00                                  CONTEXT 0x6eb5 el2
[...]

>
> Thanks,
> Leo
>
>> One way to fix this is by caching the value of the CX bit during the
>> initialization of the PMU event, so that it remains consistent for the
>> duration of the session.
>>
>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/arm_spe_pmu.c?h=v5.16#n275
>> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/arm_spe_pmu.c?h=v5.16#n713
>> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/arm_spe_pmu.c?h=v5.16#n751
>>
>> Signed-off-by: German Gomez <german.gomez@arm.com>
>> ---
>>  drivers/perf/arm_spe_pmu.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
>> index d44bcc29d..8515bf85c 100644
>> --- a/drivers/perf/arm_spe_pmu.c
>> +++ b/drivers/perf/arm_spe_pmu.c
>> @@ -57,6 +57,7 @@ struct arm_spe_pmu {
>>  	u16					pmsver;
>>  	u16					min_period;
>>  	u16					counter_sz;
>> +	bool					pmscr_cx;
>>  
>>  #define SPE_PMU_FEAT_FILT_EVT			(1UL << 0)
>>  #define SPE_PMU_FEAT_FILT_TYP			(1UL << 1)
>> @@ -260,6 +261,7 @@ static const struct attribute_group *arm_spe_pmu_attr_groups[] = {
>>  static u64 arm_spe_event_to_pmscr(struct perf_event *event)
>>  {
>>  	struct perf_event_attr *attr = &event->attr;
>> +	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
>>  	u64 reg = 0;
>>  
>>  	reg |= ATTR_CFG_GET_FLD(attr, ts_enable) << SYS_PMSCR_EL1_TS_SHIFT;
>> @@ -272,7 +274,7 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
>>  	if (!attr->exclude_kernel)
>>  		reg |= BIT(SYS_PMSCR_EL1_E1SPE_SHIFT);
>>  
>> -	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
>> +	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && spe_pmu->pmscr_cx)
>>  		reg |= BIT(SYS_PMSCR_EL1_CX_SHIFT);
>>  
>>  	return reg;
>> @@ -709,10 +711,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
>>  	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
>>  		return -EOPNOTSUPP;
>>  
>> +	spe_pmu->pmscr_cx = perfmon_capable();
>>  	reg = arm_spe_event_to_pmscr(event);
>>  	if (!perfmon_capable() &&
>>  	    (reg & (BIT(SYS_PMSCR_EL1_PA_SHIFT) |
>> -		    BIT(SYS_PMSCR_EL1_CX_SHIFT) |
>>  		    BIT(SYS_PMSCR_EL1_PCT_SHIFT))))
>>  		return -EACCES;
>>  
>> -- 
>> 2.25.1
>>
