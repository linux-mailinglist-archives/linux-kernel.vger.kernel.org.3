Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED8449281E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbiAROOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:14:38 -0500
Received: from foss.arm.com ([217.140.110.172]:57870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235517AbiAROOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:14:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 502B81FB;
        Tue, 18 Jan 2022 06:13:59 -0800 (PST)
Received: from [10.57.35.29] (unknown [10.57.35.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 681EC3F766;
        Tue, 18 Jan 2022 06:13:58 -0800 (PST)
Subject: Re: [RFC PATCH 2/2] perf: arm_spe: Enable CONTEXT packets in SPE
 traces if the profiler runs in CPU mode.
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, james.clark@arm.com, leo.yan@linaro.org
References: <20220117124432.3119132-1-german.gomez@arm.com>
 <20220117124432.3119132-3-german.gomez@arm.com>
 <20220118095258.GA16547@willie-the-truck>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <a5bc60d9-fff0-abf9-c268-dcb75b790bfb@arm.com>
Date:   Tue, 18 Jan 2022 14:13:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220118095258.GA16547@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/01/2022 09:52, Will Deacon wrote:
> On Mon, Jan 17, 2022 at 12:44:32PM +0000, German Gomez wrote:
>> Enable CONTEXT packets in SPE traces if the profiler runs in CPU mode.
>> This is no less permissive than the existing behavior for the following
>> reason:
>>
>> If perf_event_paranoid <= 0, then non perfmon_capable() users can open
>> a per-CPU event. With a per-CPU event, unpriviledged users are allowed
>> to profile _all_ processes, even ones owned by root.
>>
>> Without this change, users could see kernel addresses, root processes,
>> etc, but not gather the PIDs of those processes. The PID is probably the
>> least sensitive of all the information.
>>
>> It would be more idiomatic to check the perf_event_paranoid level with
>> perf_allow_cpu(), but this function is not exported so cannot be used
>> from a module. Looking for cpu != -1 is the indirect way of checking
>> the same thing as it could never get to arm_spe_pmu_event_init() without
>> perf_event_paranoid <= 0.
> perf_allow_cpu() is a static inline so there's no need to export it. What's
> missing?

We were still running into build errors:

ERROR: modpost: "security_perf_event_open" [drivers/perf/arm_spe_pmu.ko] undefined!
ERROR: modpost: "sysctl_perf_event_paranoid" [drivers/perf/arm_spe_pmu.ko] undefined

>
> Will
