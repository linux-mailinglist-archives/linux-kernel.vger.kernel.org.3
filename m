Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17B748EC01
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242040AbiANOu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242325AbiANOt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:49:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7C5C061574;
        Fri, 14 Jan 2022 06:49:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1EFFB825F5;
        Fri, 14 Jan 2022 14:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501D6C36AEB;
        Fri, 14 Jan 2022 14:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642171795;
        bh=EHKChMUESb8pHu8+09xHBjEYyEfYUPm1CdXsqo8QKtk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lqUXifM+i6Y4uaO/C1PHlkeYPkPcfbe3FwxChvXQxnIVvDHZoWxguZBuWAtavVNRi
         Oknug3aWxC5ekTFlaYFK5ZnThsWZM7IbvKkmw+/ROMoMPFjtbeU0bpTHfB9XvZhtkk
         7pkt/D13V75rorYdyirzCeWDoHCHsIjSMy8O7981x0qBMBjaf2vMmT4Jpq9TsaZtuk
         9FovCIbYDguekIgr2KNqcFUyTvrNyX1hP/Tq75YNdjOTHQzbQYj7OfpMUXyb4MTBdr
         yx8dm+9pg/4aVBiH5MM+KRvQQNTbQYtgxd+4S5KrjV0FPyT8cE2P4OJMkkQ3MW9T9L
         lbKnXJK2Z09wA==
Received: by mail-wm1-f48.google.com with SMTP id c66so6332659wma.5;
        Fri, 14 Jan 2022 06:49:55 -0800 (PST)
X-Gm-Message-State: AOAM530fefafE9RN1Mu6503ZYJ/7r7olaFtmPxh2PCEC4EisrOHowY7X
        p35swTWt5pijW5/1b4sijEoD4hYnU8u8r5LE9A==
X-Google-Smtp-Source: ABdhPJwLLBZbVkRVccrMz8RDa54o8jm3GCauhk8o4f7l1N1wOO5BdzGlrav+Kdf4B1oUd/95C8CG0dIym0Xu63n8gPo=
X-Received: by 2002:a17:906:d184:: with SMTP id c4mr7432413ejz.20.1642171793672;
 Fri, 14 Jan 2022 06:49:53 -0800 (PST)
MIME-Version: 1.0
References: <20211214215630.4025090-1-robh@kernel.org> <CAP-5=fWkFhHZhPQ1WUTwJjMijBOJS6GMwG1UAo0GBsuS2G6Q8g@mail.gmail.com>
In-Reply-To: <CAP-5=fWkFhHZhPQ1WUTwJjMijBOJS6GMwG1UAo0GBsuS2G6Q8g@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 14 Jan 2022 08:49:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKZoiK+k98bHR6iKn7BWTod+i0H3BKCoYEh2cL1Cgry3g@mail.gmail.com>
Message-ID: <CAL_JsqKZoiK+k98bHR6iKn7BWTod+i0H3BKCoYEh2cL1Cgry3g@mail.gmail.com>
Subject: Re: [PATCH v8] libperf: Add arm64 support to perf_mmap__read_self()
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 8:19 AM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Dec 14, 2021, 1:56 PM Rob Herring <robh@kernel.org> wrote:
>>
>> Add the arm64 variants for read_perf_counter() and read_timestamp().
>> Unfortunately the counter number is encoded into the instruction, so the
>> code is a bit verbose to enumerate all possible counters.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>> v8:
>>  - Set attr.config1 to request user access on arm64
>> v7:
>>  - Move enabling of libperf user read test for arm64 to this patch
>> ---
>>  tools/lib/perf/mmap.c             | 98 +++++++++++++++++++++++++++++++
>>  tools/lib/perf/tests/test-evsel.c |  5 +-
>>  2 files changed, 102 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
>> index c89dfa5f67b3..7ee3eb9f5e27 100644
>> --- a/tools/lib/perf/mmap.c
>> +++ b/tools/lib/perf/mmap.c
>> @@ -13,6 +13,7 @@
>>  #include <internal/lib.h>
>>  #include <linux/kernel.h>
>>  #include <linux/math64.h>
>> +#include <linux/stringify.h>
>>  #include "internal.h"
>>
>>  void perf_mmap__init(struct perf_mmap *map, struct perf_mmap *prev,
>> @@ -294,6 +295,103 @@ static u64 read_timestamp(void)
>>
>>         return low | ((u64)high) << 32;
>>  }
>> +#elif defined(__aarch64__)
>> +#define read_sysreg(r) ({                                              \
>> +       u64 __val;                                                      \
>> +       asm volatile("mrs %0, " __stringify(r) : "=r" (__val));         \
>> +       __val;                                                          \
>> +})
>> +
>> +static u64 read_pmccntr(void)
>> +{
>> +       return read_sysreg(pmccntr_el0);
>> +}
>> +
>> +#define PMEVCNTR_READ(idx)                                     \
>> +       static u64 read_pmevcntr_##idx(void) {                  \
>> +               return read_sysreg(pmevcntr##idx##_el0);        \
>> +       }
>> +
>> +PMEVCNTR_READ(0);
>> +PMEVCNTR_READ(1);
>> +PMEVCNTR_READ(2);
>> +PMEVCNTR_READ(3);
>> +PMEVCNTR_READ(4);
>> +PMEVCNTR_READ(5);
>> +PMEVCNTR_READ(6);
>> +PMEVCNTR_READ(7);
>> +PMEVCNTR_READ(8);
>> +PMEVCNTR_READ(9);
>> +PMEVCNTR_READ(10);
>> +PMEVCNTR_READ(11);
>> +PMEVCNTR_READ(12);
>> +PMEVCNTR_READ(13);
>> +PMEVCNTR_READ(14);
>> +PMEVCNTR_READ(15);
>> +PMEVCNTR_READ(16);
>> +PMEVCNTR_READ(17);
>> +PMEVCNTR_READ(18);
>> +PMEVCNTR_READ(19);
>> +PMEVCNTR_READ(20);
>> +PMEVCNTR_READ(21);
>> +PMEVCNTR_READ(22);
>> +PMEVCNTR_READ(23);
>> +PMEVCNTR_READ(24);
>> +PMEVCNTR_READ(25);
>> +PMEVCNTR_READ(26);
>> +PMEVCNTR_READ(27);
>> +PMEVCNTR_READ(28);
>> +PMEVCNTR_READ(29);
>> +PMEVCNTR_READ(30);
>
>
> Nit: It looks strange that 31 is not here, ie 31 counters rather than 32.

From the Arm ARM:
D13.4.8
PMEVCNTR<n>_EL0, Performance Monitors Event Count Registers, n = 0 - 30

The 32nd counter is the cycle counter which is special and accessed in
a different register.

Rob
