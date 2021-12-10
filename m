Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B530A4703B8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242779AbhLJPY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:24:58 -0500
Received: from foss.arm.com ([217.140.110.172]:43176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239316AbhLJPY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:24:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07B9712FC;
        Fri, 10 Dec 2021 07:21:21 -0800 (PST)
Received: from [10.57.6.190] (unknown [10.57.6.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15F073F5A1;
        Fri, 10 Dec 2021 07:21:17 -0800 (PST)
Subject: Re: [PATCH v2 3/3] perf tools: Support register names from all archs
From:   German Gomez <german.gomez@arm.com>
To:     John Garry <john.garry@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org
Cc:     Alexandre Truong <alexandre.truong@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20211207180653.1147374-1-german.gomez@arm.com>
 <20211207180653.1147374-4-german.gomez@arm.com>
 <90bcce69-9585-3fb4-de89-bbf2bd6def05@huawei.com>
 <aee0c3b8-4d8c-6f1e-24ed-5539a7c1a7b5@arm.com>
Message-ID: <9828a385-acde-145a-33db-76043e799344@arm.com>
Date:   Fri, 10 Dec 2021 15:21:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <aee0c3b8-4d8c-6f1e-24ed-5539a7c1a7b5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/12/2021 13:55, German Gomez wrote:
> Hi John,
>
> On 08/12/2021 11:51, John Garry wrote:
>> On 07/12/2021 18:06, German Gomez wrote:
>>>   tools/perf/arch/arm/include/perf_regs.h       |  42 --
>>>   tools/perf/arch/arm64/include/perf_regs.h     |  76 --
>>>   tools/perf/arch/csky/include/perf_regs.h      |  82 ---
>>>   tools/perf/arch/mips/include/perf_regs.h      |  69 --
>>>   tools/perf/arch/powerpc/include/perf_regs.h   |  66 --
>>>   tools/perf/arch/riscv/include/perf_regs.h     |  74 --
>>>   tools/perf/arch/s390/include/perf_regs.h      |  78 --
>>>   tools/perf/arch/x86/include/perf_regs.h       |  82 ---
>>>   tools/perf/builtin-script.c                   |  18 +-
>>>   tools/perf/util/perf_regs.c                   | 666 ++++++++++++++++++
>>>   tools/perf/util/perf_regs.h                   |  10 +-
>>>   .../scripting-engines/trace-event-python.c    |  10 +-
>>>   tools/perf/util/session.c                     |  25 +-
>>>   13 files changed, 697 insertions(+), 601 deletions(-)
>> Did you consider leaving the register structures where they are while
>> renaming to include the arch name and then having as externs or similar? I see an example of that idea for arm64_unwind_libunwind_ops.
>>
> If by register structures you are referring to "__perf_reg_name(int)", I
> can't leave them where they are. Only one of them would be included in
> the build.

I think I need to elaborate a bit more on this since some of the files
involved share the same name but are serving different purposes and it
could lead to confusion.

The linux repo has "perf_regs.h" for each architecture enumerating the
registers from each architecture. These are the files I #include'd in
"/tools/perf/util/perf_regs.c".

The other "perf_regs.h" affected by this patch are local only to perf.
Likewise there is one file for each architecture, but contrary to the
linux ones, they are mutually exclusive, so I can't #include them all:

#ifndef ARCH_PERF_REGS_H
#define ARCH_PERF_REGS_H
//...
#undef ARCH_PERF_REGS_H

Before the patch, the functions "__perf_reg_name" were declared &
implemented in these headers, so I had to take them out.

Thanks,
German
