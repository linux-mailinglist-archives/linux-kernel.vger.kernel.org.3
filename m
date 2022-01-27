Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F122F49E232
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbiA0MUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:20:54 -0500
Received: from foss.arm.com ([217.140.110.172]:58304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241050AbiA0MUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:20:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1F57113E;
        Thu, 27 Jan 2022 04:20:52 -0800 (PST)
Received: from [10.163.42.218] (unknown [10.163.42.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1B0F3F7D8;
        Thu, 27 Jan 2022 04:20:48 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [RFC V1 06/11] arm64/perf: Drive BRBE from perf event states
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
 <1642998653-21377-7-git-send-email-anshuman.khandual@arm.com>
 <YfF/zBS3kL/+eC1k@robh.at.kernel.org>
Message-ID: <9e56509a-2772-a333-ccc3-ad49a2028616@arm.com>
Date:   Thu, 27 Jan 2022 17:50:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YfF/zBS3kL/+eC1k@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/26/22 10:37 PM, Rob Herring wrote:
> On Mon, Jan 24, 2022 at 10:00:48AM +0530, Anshuman Khandual wrote:
>> Branch stack sampling rides along the normal perf event and all the branch
>> records get captured during the PMU interrupt. This just changes perf event
>> handling on the arm64 platform to accommodate required BRBE operations that
>> will enable branch stack sampling support.
>>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: linux-perf-users@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/kernel/perf_event.c |  6 +++++
>>  drivers/perf/arm_pmu.c         | 40 ++++++++++++++++++++++++++++++++++
>>  2 files changed, 46 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
>> index f6a47036b0b4..11c82c8f2eec 100644
>> --- a/arch/arm64/kernel/perf_event.c
>> +++ b/arch/arm64/kernel/perf_event.c
>> @@ -864,6 +864,12 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
>>  		if (!armpmu_event_set_period(event))
>>  			continue;
>>  
>> +		if (has_branch_stack(event)) {
>> +			cpu_pmu->brbe_read(cpuc, event);
> 
> Is has_branch_stack() guaranteed to be false on arm32? If not, this will 
> be a NULL function ptr.

armpmu_event_init() blocks a perf event from being created with branch
stack sampling request without CONFIG_ARM_BRBE_PMU option being enabled
first, which has dependency on CONFIG_ARM64. So has_branch_stack() is
guaranteed to be false on arm32.

static int armpmu_event_init(struct perf_event *event)
{
	....
        if (has_branch_stack(event)) {
                /*
                 * BRBE support is absent. Select CONFIG_ARM_BRBE_PMU
                 * in the config, before branch stack sampling events
                 * can be requested.
                 */
                if (!IS_ENABLED(CONFIG_ARM_BRBE_PMU)) {
                        pr_warn_once("BRBE is disabled, select CONFIG_ARM_BRBE_PMU\n");
                        return -EOPNOTSUPP;
                }


config ARM_BRBE_PMU
        tristate "Enable support for Branch Record Buffer Extension (BRBE)"
        depends on ARM64 && ARM_PMU
        default y
        help
          Enable perf support for Branch Record Buffer Extension (BRBE) which
          records all branches taken in an execution path. This supports some
          branch types and privilege based filtering. It captured additional
          relevant information such as cycle count, misprediction and branch
          type, branch privilege level etc.

> 
> To add to my other comments, this patch is where I would add 
> brbe_read(), etc. to arm_pmu.

Because all new arm_pmu helpers get added and get used in the perf driver
in the same patch, although the actual helper implementation would still
come by bit later via the driver. This also uses updates to pmu_hw_events
struct as well, then that patch needs to be folded here as well.

There is no problem as such, kind of bit subjective. I just feel inclined
to keep the independent infrastructure changes separate making it easy to
review while also creating a flow.
