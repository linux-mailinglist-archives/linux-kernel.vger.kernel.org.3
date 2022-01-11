Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E4348BAEA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346631AbiAKWn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346625AbiAKWn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:43:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED015C06173F;
        Tue, 11 Jan 2022 14:43:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B21A612B3;
        Tue, 11 Jan 2022 22:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32F1C36AF3;
        Tue, 11 Jan 2022 22:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641941036;
        bh=wxrYUHvNISoimR1FsjCGMOFkWf6WTEQzClLqZ2UhsHo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lHNIob6PZvEilgGx+9KeRZpLebkKkuJ8YnM0hWrSXSXfkXluqOjTbg94JN+AZ+AZU
         IV5qfShvjLReJTJGiCBBZgy5ptafa5hZYxQrlSvj3u6BFUpICL8bXsqu4NXgo9fTTH
         gflF2oLbecCMqwPeoPIgG+od1Hcav/vgVMtK4URzBDYHjL0ZttLaAQpjuHCk4GOD7q
         v8yUWDYC5Z+XIw9SVVSkhAkTAjv7i0SN9fQl12zKGYNTnax/1QQvcMH/rJxz42UMTP
         +m/R9DJ2J/SPn1exeTYse0u+zosTgIHXve8LDHuTUb8I0NQDGzfAswFkqmZMv4Xl2+
         opTGhbuowsseg==
Received: by mail-ed1-f48.google.com with SMTP id b13so2480597edn.0;
        Tue, 11 Jan 2022 14:43:55 -0800 (PST)
X-Gm-Message-State: AOAM531lN6d/+ZmG9VUzTdDygRk/NwfaZ+9uWWMZsS9evwO0B4/5am6P
        2oEwGqYWeHRDTxvxLlqZKvDKBU1NkVh6hCgANw==
X-Google-Smtp-Source: ABdhPJwFehAmi8eX6RJne8GZzz7WL+Rj5BQEQD0NZb84edRew4ZUHLuKENWdltSc4kIjXYc89P9V/+KWQzIic22CDs4=
X-Received: by 2002:a05:6402:1756:: with SMTP id v22mr1707154edx.2.1641941034187;
 Tue, 11 Jan 2022 14:43:54 -0800 (PST)
MIME-Version: 1.0
References: <20211214215630.4025090-1-robh@kernel.org>
In-Reply-To: <20211214215630.4025090-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Jan 2022 16:43:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLPMpBmLh40=HMF4FKT8UzvnNXX65Bet+rASUAzuXJgbA@mail.gmail.com>
Message-ID: <CAL_JsqLPMpBmLh40=HMF4FKT8UzvnNXX65Bet+rASUAzuXJgbA@mail.gmail.com>
Subject: Re: [PATCH v8] libperf: Add arm64 support to perf_mmap__read_self()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 3:56 PM Rob Herring <robh@kernel.org> wrote:
>
> Add the arm64 variants for read_perf_counter() and read_timestamp().
> Unfortunately the counter number is encoded into the instruction, so the
> code is a bit verbose to enumerate all possible counters.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v8:
>  - Set attr.config1 to request user access on arm64
> v7:
>  - Move enabling of libperf user read test for arm64 to this patch
> ---
>  tools/lib/perf/mmap.c             | 98 +++++++++++++++++++++++++++++++
>  tools/lib/perf/tests/test-evsel.c |  5 +-
>  2 files changed, 102 insertions(+), 1 deletion(-)

Ping!

>
> diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> index c89dfa5f67b3..7ee3eb9f5e27 100644
> --- a/tools/lib/perf/mmap.c
> +++ b/tools/lib/perf/mmap.c
> @@ -13,6 +13,7 @@
>  #include <internal/lib.h>
>  #include <linux/kernel.h>
>  #include <linux/math64.h>
> +#include <linux/stringify.h>
>  #include "internal.h"
>
>  void perf_mmap__init(struct perf_mmap *map, struct perf_mmap *prev,
> @@ -294,6 +295,103 @@ static u64 read_timestamp(void)
>
>         return low | ((u64)high) << 32;
>  }
> +#elif defined(__aarch64__)
> +#define read_sysreg(r) ({                                              \
> +       u64 __val;                                                      \
> +       asm volatile("mrs %0, " __stringify(r) : "=r" (__val));         \
> +       __val;                                                          \
> +})
> +
> +static u64 read_pmccntr(void)
> +{
> +       return read_sysreg(pmccntr_el0);
> +}
> +
> +#define PMEVCNTR_READ(idx)                                     \
> +       static u64 read_pmevcntr_##idx(void) {                  \
> +               return read_sysreg(pmevcntr##idx##_el0);        \
> +       }
> +
> +PMEVCNTR_READ(0);
> +PMEVCNTR_READ(1);
> +PMEVCNTR_READ(2);
> +PMEVCNTR_READ(3);
> +PMEVCNTR_READ(4);
> +PMEVCNTR_READ(5);
> +PMEVCNTR_READ(6);
> +PMEVCNTR_READ(7);
> +PMEVCNTR_READ(8);
> +PMEVCNTR_READ(9);
> +PMEVCNTR_READ(10);
> +PMEVCNTR_READ(11);
> +PMEVCNTR_READ(12);
> +PMEVCNTR_READ(13);
> +PMEVCNTR_READ(14);
> +PMEVCNTR_READ(15);
> +PMEVCNTR_READ(16);
> +PMEVCNTR_READ(17);
> +PMEVCNTR_READ(18);
> +PMEVCNTR_READ(19);
> +PMEVCNTR_READ(20);
> +PMEVCNTR_READ(21);
> +PMEVCNTR_READ(22);
> +PMEVCNTR_READ(23);
> +PMEVCNTR_READ(24);
> +PMEVCNTR_READ(25);
> +PMEVCNTR_READ(26);
> +PMEVCNTR_READ(27);
> +PMEVCNTR_READ(28);
> +PMEVCNTR_READ(29);
> +PMEVCNTR_READ(30);
> +
> +/*
> + * Read a value direct from PMEVCNTR<idx>
> + */
> +static u64 read_perf_counter(unsigned int counter)
> +{
> +       static u64 (* const read_f[])(void) = {
> +               read_pmevcntr_0,
> +               read_pmevcntr_1,
> +               read_pmevcntr_2,
> +               read_pmevcntr_3,
> +               read_pmevcntr_4,
> +               read_pmevcntr_5,
> +               read_pmevcntr_6,
> +               read_pmevcntr_7,
> +               read_pmevcntr_8,
> +               read_pmevcntr_9,
> +               read_pmevcntr_10,
> +               read_pmevcntr_11,
> +               read_pmevcntr_13,
> +               read_pmevcntr_12,
> +               read_pmevcntr_14,
> +               read_pmevcntr_15,
> +               read_pmevcntr_16,
> +               read_pmevcntr_17,
> +               read_pmevcntr_18,
> +               read_pmevcntr_19,
> +               read_pmevcntr_20,
> +               read_pmevcntr_21,
> +               read_pmevcntr_22,
> +               read_pmevcntr_23,
> +               read_pmevcntr_24,
> +               read_pmevcntr_25,
> +               read_pmevcntr_26,
> +               read_pmevcntr_27,
> +               read_pmevcntr_28,
> +               read_pmevcntr_29,
> +               read_pmevcntr_30,
> +               read_pmccntr
> +       };
> +
> +       if (counter < ARRAY_SIZE(read_f))
> +               return (read_f[counter])();
> +
> +       return 0;
> +}
> +
> +static u64 read_timestamp(void) { return read_sysreg(cntvct_el0); }
> +
>  #else
>  static u64 read_perf_counter(unsigned int counter __maybe_unused) { return 0; }
>  static u64 read_timestamp(void) { return 0; }
> diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
> index 33ae9334861a..89be89afb24d 100644
> --- a/tools/lib/perf/tests/test-evsel.c
> +++ b/tools/lib/perf/tests/test-evsel.c
> @@ -130,6 +130,9 @@ static int test_stat_user_read(int event)
>         struct perf_event_attr attr = {
>                 .type   = PERF_TYPE_HARDWARE,
>                 .config = event,
> +#ifdef __aarch64__
> +               .config1 = 0x2,         /* Request user access */
> +#endif
>         };
>         int err, i;
>
> @@ -150,7 +153,7 @@ static int test_stat_user_read(int event)
>         pc = perf_evsel__mmap_base(evsel, 0, 0);
>         __T("failed to get mmapped address", pc);
>
> -#if defined(__i386__) || defined(__x86_64__)
> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
>         __T("userspace counter access not supported", pc->cap_user_rdpmc);
>         __T("userspace counter access not enabled", pc->index);
>         __T("userspace counter width not set", pc->pmc_width >= 32);
> --
> 2.32.0
>
