Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4DD492B31
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 17:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbiARQ2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 11:28:33 -0500
Received: from foss.arm.com ([217.140.110.172]:60932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233718AbiARQ2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:28:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA3D71FB;
        Tue, 18 Jan 2022 08:28:31 -0800 (PST)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7AC43F774;
        Tue, 18 Jan 2022 08:28:30 -0800 (PST)
Subject: Re: [RFC PATCH 1/2] perf: arm_spe: Fix consistency of PMSCR register
 bit CX
To:     Will Deacon <will@kernel.org>, German Gomez <german.gomez@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, leo.yan@linaro.org
References: <20220117124432.3119132-1-german.gomez@arm.com>
 <20220117124432.3119132-2-german.gomez@arm.com>
 <20220118100702.GB16547@willie-the-truck>
From:   James Clark <james.clark@arm.com>
Message-ID: <0afb1f94-8f35-72af-cead-f3a0d18e0dbc@arm.com>
Date:   Tue, 18 Jan 2022 16:28:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220118100702.GB16547@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2022 10:07, Will Deacon wrote:
> On Mon, Jan 17, 2022 at 12:44:31PM +0000, German Gomez wrote:
>> The arm_spe_pmu driver will enable the CX bit of the PMSCR register in
>> order to add CONTEXT packets into the traces if the owner of the perf
>> event runs with capabilities CAP_PERFMON or CAP_SYS_ADMIN.
>>
>> The value of the bit is computed in the arm_spe_event_to_pmscr function
>> [1], and the check for capabilities happens in [2] in the pmu init
>> callback. This suggests that the value of the CX bit should remain
>> consistent for the duration of the perf session.
>>
>> However, the function arm_spe_event_to_pmscr may be called later during
>> the start callback [3] when the "current" process is not the owner of
>> the perf session, so the CX bit is currently not consistent. Consider
>> the following example:
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
>>
>> As can be seen, the traces begin showing CONTEXT packets when the pid is
>> 0xedf (3807).
> 
> So to be clear: we shouldn't be reporting these packets because 'perf'
> doesn't have the right capabilities, but we evaluate that in the context of
> 'dd' (running as root) and so incorrectly grant the permission. Correct?

In my opinion we should be reporting context packets in this case. The only reason
a normal user is allowed to profile a root process is if they have
perf_event_paranoid <= 0. So from that perspective perf does have the right
capabilities. But a call to only perfmon_capable() doesn't look at the paranoid
value, only CAP_SYS_ADMIN and CAP_SYS_ADMIN.

> 
>> This happens because the pmu start callback is run when
>> the current process is not the owner of the perf session, so the CX
>> register bit is set.
> 
> This doesn't really seem SPE-specific to me -- the perf_allow_*() helpers
> also operate implicitly on the current task. How do other PMU drivers avoid
> falling into this trap?> 
>> One way to fix this is by caching the value of the CX bit during the
>> initialization of the PMU event, so that it remains consistent for the
>> duration of the session.
> 
> It doesn't feel right to stash this in 'struct arm_spe_pmu' during event
> initialisation -- wouldn't that allow perf to continue creating new events
> with CX set, even if the paranoid sysctl was changed dynamically? Instead,
> I think it would be better if the capabilities were stash in the event
> itself somehow at initialisation time.

If stashing is the issue then the change could be to check the right thing
every time, as in do something like the second patch in this set which
also checks perf_event_paranoid <= 0 (indirectly).

James

> 
> Will
> 
