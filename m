Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AF349F1D4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 04:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345762AbiA1D1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 22:27:07 -0500
Received: from foss.arm.com ([217.140.110.172]:43828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242068AbiA1D1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 22:27:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DC5A113E;
        Thu, 27 Jan 2022 19:27:05 -0800 (PST)
Received: from [10.163.44.75] (unknown [10.163.44.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DA4F3F793;
        Thu, 27 Jan 2022 19:27:01 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [RFC V1 05/11] arm64/perf: Detect support for BRBE
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
 <1642998653-21377-6-git-send-email-anshuman.khandual@arm.com>
 <YfGCgwlk6wHS/OYe@robh.at.kernel.org>
Message-ID: <71181375-c36e-d3a6-d244-a2bbfd4004fc@arm.com>
Date:   Fri, 28 Jan 2022 08:57:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YfGCgwlk6wHS/OYe@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/22 10:48 PM, Rob Herring wrote:
> On Mon, Jan 24, 2022 at 10:00:47AM +0530, Anshuman Khandual wrote:
>> CPU specific BRBE entries, cycle count, format support gets detected during
>> PMU init. This information gets saved in per-cpu struct pmu_hw_events which
>> later helps in operating BRBE during a perf event context.
> 
> Another NOP commit. The subject says 'arm64' and that we detect BRBE 
> support. This patch neither touches arm64 code nor detects anything.

Right, this is a NOP at this point but it will have functionality when the
driver gets added later on. I will correct the arm64 part and also update
the message saying - it just adds the infrastructure for BRBE detection not
the actual function.

> 
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  drivers/perf/arm_pmu_platform.c | 34 +++++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>
>> diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
>> index 513de1f54e2d..800e4a6e8bc3 100644
>> --- a/drivers/perf/arm_pmu_platform.c
>> +++ b/drivers/perf/arm_pmu_platform.c
>> @@ -172,6 +172,36 @@ static int armpmu_request_irqs(struct arm_pmu *armpmu)
>>  	return err;
>>  }
>>  
>> +static void arm_brbe_probe_cpu(void *info)
>> +{
>> +	struct pmu_hw_events *hw_events;
>> +	struct arm_pmu *armpmu = info;
>> +
>> +	/*
>> +	 * Return from here, if BRBE driver has not been
>> +	 * implemented for this PMU. This helps prevent
>> +	 * kernel crash later when brbe_probe() will be
>> +	 * called on the PMU.
>> +	 */
>> +	if (!armpmu->brbe_probe)
>> +		return;
>> +
>> +	hw_events = per_cpu_ptr(armpmu->hw_events, smp_processor_id());
>> +	armpmu->brbe_probe(hw_events);
>> +}
>> +
>> +static int armpmu_request_brbe(struct arm_pmu *armpmu)
>> +{
>> +	int cpu, err = 0;
>> +
>> +	for_each_cpu(cpu, &armpmu->supported_cpus) {
>> +		err = smp_call_function_single(cpu, arm_brbe_probe_cpu, armpmu, 1);
>> +		if (err)
>> +			return err;
>> +	}
>> +	return err;
>> +}
>> +
>>  static void armpmu_free_irqs(struct arm_pmu *armpmu)
>>  {
>>  	int cpu;
>> @@ -229,6 +259,10 @@ int arm_pmu_device_probe(struct platform_device *pdev,
>>  	if (ret)
>>  		goto out_free_irqs;
>>  
>> +	ret = armpmu_request_brbe(pmu);
>> +	if (ret)
>> +		goto out_free_irqs;
>> +
>>  	ret = armpmu_register(pmu);
>>  	if (ret) {
>>  		dev_err(dev, "failed to register PMU devices!\n");
>> -- 
>> 2.25.1
>>
>>
