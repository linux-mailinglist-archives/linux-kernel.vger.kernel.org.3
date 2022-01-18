Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201514927F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241950AbiAROEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:04:41 -0500
Received: from foss.arm.com ([217.140.110.172]:57630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243890AbiAROEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:04:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBDC01FB;
        Tue, 18 Jan 2022 06:04:32 -0800 (PST)
Received: from [10.57.35.29] (unknown [10.57.35.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A312D3F766;
        Tue, 18 Jan 2022 06:04:31 -0800 (PST)
Subject: Re: [RFC PATCH 1/2] perf: arm_spe: Fix consistency of PMSCR register
 bit CX
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, james.clark@arm.com, leo.yan@linaro.org
References: <20220117124432.3119132-1-german.gomez@arm.com>
 <20220117124432.3119132-2-german.gomez@arm.com>
 <20220118100702.GB16547@willie-the-truck>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <2cb1baab-fd9c-ea20-2a09-4cd60d9d5531@arm.com>
Date:   Tue, 18 Jan 2022 14:04:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220118100702.GB16547@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

Many thanks for your comments

On 18/01/2022 10:07, Will Deacon wrote:
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
>>
>> As can be seen, the traces begin showing CONTEXT packets when the pid is
>> 0xedf (3807).
> So to be clear: we shouldn't be reporting these packets because 'perf'
> doesn't have the right capabilities, but we evaluate that in the context of
> 'dd' (running as root) and so incorrectly grant the permission. Correct?

Yes, correct. My guess was that "perfmon_capable()" was being called
under the assumption that it would always be evaluated in the context of
'perf'. Is that correct?

>
>> This happens because the pmu start callback is run when
>> the current process is not the owner of the perf session, so the CX
>> register bit is set.
> This doesn't really seem SPE-specific to me -- the perf_allow_*() helpers
> also operate implicitly on the current task. How do other PMU drivers avoid
> falling into this trap?

I'm not as familiar with the other PMU drivers. I quickly tried grepping
something related in the cs_etm drivers as they use CONTEXTIDR as well,
but couldn't find references to perfmon_capable() or similar checks.

Grepping for "perf_allow_" inside of drivers doesn't yield results.
There's some gpu driver that has similar perfmon_capable() checks but
unlike spe, they error out if they don't pass (drivers/gpu/drm/i915/i915_perf.c).

>
>> One way to fix this is by caching the value of the CX bit during the
>> initialization of the PMU event, so that it remains consistent for the
>> duration of the session.
> It doesn't feel right to stash this in 'struct arm_spe_pmu' during event
> initialisation -- wouldn't that allow perf to continue creating new events
> with CX set, even if the paranoid sysctl was changed dynamically? Instead,
> I think it would be better if the capabilities were stash in the event
> itself somehow at initialisation time.

I hadn't considered this. Makes more sense to store in the perf_event
or via some type of mapping in the struct spe_pmu if not possible. Do
you have any idea for the former? Or an idiomatic structure from the
kernel for the later?

Thanks,
German

>
> Will
