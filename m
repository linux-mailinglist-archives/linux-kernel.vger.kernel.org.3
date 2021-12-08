Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FA646D4E2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbhLHN7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:59:16 -0500
Received: from foss.arm.com ([217.140.110.172]:60510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhLHN7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:59:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CBEED6E;
        Wed,  8 Dec 2021 05:55:43 -0800 (PST)
Received: from [10.1.26.149] (e127744.cambridge.arm.com [10.1.26.149])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 104B43F73B;
        Wed,  8 Dec 2021 05:55:39 -0800 (PST)
Subject: Re: [PATCH v2 3/3] perf tools: Support register names from all archs
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
From:   German Gomez <german.gomez@arm.com>
Message-ID: <aee0c3b8-4d8c-6f1e-24ed-5539a7c1a7b5@arm.com>
Date:   Wed, 8 Dec 2021 13:55:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <90bcce69-9585-3fb4-de89-bbf2bd6def05@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 08/12/2021 11:51, John Garry wrote:
> On 07/12/2021 18:06, German Gomez wrote:
>>   tools/perf/arch/arm/include/perf_regs.h       |  42 --
>>   tools/perf/arch/arm64/include/perf_regs.h     |  76 --
>>   tools/perf/arch/csky/include/perf_regs.h      |  82 ---
>>   tools/perf/arch/mips/include/perf_regs.h      |  69 --
>>   tools/perf/arch/powerpc/include/perf_regs.h   |  66 --
>>   tools/perf/arch/riscv/include/perf_regs.h     |  74 --
>>   tools/perf/arch/s390/include/perf_regs.h      |  78 --
>>   tools/perf/arch/x86/include/perf_regs.h       |  82 ---
>>   tools/perf/builtin-script.c                   |  18 +-
>>   tools/perf/util/perf_regs.c                   | 666 ++++++++++++++++++
>>   tools/perf/util/perf_regs.h                   |  10 +-
>>   .../scripting-engines/trace-event-python.c    |  10 +-
>>   tools/perf/util/session.c                     |  25 +-
>>   13 files changed, 697 insertions(+), 601 deletions(-)
>
> Did you consider leaving the register structures where they are while
> renaming to include the arch name and then having as externs or similar? I see an example of that idea for arm64_unwind_libunwind_ops.
>

If by register structures you are referring to "__perf_reg_name(int)", I
can't leave them where they are. Only one of them would be included in
the build.

I think the idea from arm64_unwind_libunwind_ops makes more sense in
that case because perf might not link against libunwind-arm64. In the
case of registers, we always have this info available in /tools/.

Thanks,
German

> Cheers,
> John
