Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4695347C18D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238497AbhLUOcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:32:09 -0500
Received: from foss.arm.com ([217.140.110.172]:54272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234548AbhLUOcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:32:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F4FE6D;
        Tue, 21 Dec 2021 06:32:08 -0800 (PST)
Received: from [10.57.37.41] (unknown [10.57.37.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F36F3F774;
        Tue, 21 Dec 2021 06:32:05 -0800 (PST)
Message-ID: <bd25fae8-c78d-3c42-01e3-c7d9237ce50c@arm.com>
Date:   Tue, 21 Dec 2021 14:31:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH 1/1] perf arm64: Implement --topdown with metrics
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <4c375d34-bf20-496d-22fc-aed8597126e2@huawei.com>
 <20211214184240.24215-1-andrew.kilroy@arm.com>
 <20211214184240.24215-2-andrew.kilroy@arm.com>
 <48437bee-9c39-38ba-e990-ba9a6a5378b4@huawei.com>
From:   Andrew Kilroy <andrew.kilroy@arm.com>
In-Reply-To: <48437bee-9c39-38ba-e990-ba9a6a5378b4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/12/2021 10:19, John Garry wrote:
> On 14/12/2021 18:42, Andrew Kilroy wrote:
>> This patch implements the --topdown option by making use of metrics to
>> dictate what counters are obtained in order to show the various topdown
>> columns, e.g.  Frontend Bound, Backend Bound, Retiring and Bad
>> Speculation.
>>
>> The MetricGroup name is used to identify which set of metrics are to be
>> shown.  For the moment use TopDownL1 and enable for arm64
>>
>> Signed-off-by: Andrew Kilroy<andrew.kilroy@arm.com>
> 
> This works in that it gives results, but does not supply the same output 
> format as for x86 nor has same restrictions in usage (-a commandline 
> required, for example, below).
> 
> For my x86 broadwell:
> 
> john@localhost:~/linux/tools/perf> sudo ./perf stat --topdown  sleep 1
> top down event configuration requires system-wide mode (-a)
> 
> john@localhost:~/linux/tools/perf> sudo ./perf stat --topdown -a sleep 1
> Performance counter stats for 'system wide':
> 
>                                     retiring      bad speculation 
> frontend bound        backend bound
> S0-D0-C0           2                29.2%                 6.3%      
> 37.4%                27.1%
> S0-D0-C1           2                20.4%                 6.2%      
> 42.1%                31.3%
> 
>        0.998007338 seconds time elapsed
> 
> john@localhost:~/linux/tools/perf>
> 

Judging by comments in commits 44b1e60ab576c, 55c36a9fc2aaa, whether -a 
is required or not differs depending on the cpu.  As to why, I'm not 
sure.  The requirement was relaxed in 55c36a9fc2aaa, but I guess that 
doesn't affect the broadwell.

The stats are printed per cpu because on your broadwell, the existing 
code is forcing per-core mode.  Hence why -a is required.  See 
builtin-stat.c lines 1885-1890 on commit 8ff4f20f3eb55.

My patch wasn't forcing per-core, hence it didn't require -a.


Andrew
