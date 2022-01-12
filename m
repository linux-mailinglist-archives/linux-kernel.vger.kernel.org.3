Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA9848CA89
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355876AbiALSAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 13:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348660AbiALSAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:00:42 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDCFC06173F;
        Wed, 12 Jan 2022 10:00:42 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id c7so344751qtc.11;
        Wed, 12 Jan 2022 10:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CriCySXrNpC8ZnIvwaSwEFiKu6PNvsRlr1qh1Ccyt5Y=;
        b=Sw/X3lgrThaJv1+CGWfnQCvUfW97chW8vgAXpY3KSX8dDKAhQMql5BSRaiGLpMInZU
         YY+XbAoEQSMJU9wuapM9AgoIQwWIiCBVphOqDA4TAdhZ8ggy+BZotzb4G1Vist52fGxT
         hEUTGw/24MnTdn+QAlXZvWtaErFo51L4MbWu8NsPBh0kDkwzh5lCbXuHaUqJKPeiKEL9
         1mEH12Xw6s+OYzCwhisQiKGzgAn/uDafvjdximhNmsiiOlQ4JKZPxeBYcHpE2RFnLotB
         Sqpkf9+wAjeMHaGU7jn1EcVVSAFKoEwmqJwXRQyQ/9i5ikWlRFaUN3N9CA4g4NhnGiUX
         kf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CriCySXrNpC8ZnIvwaSwEFiKu6PNvsRlr1qh1Ccyt5Y=;
        b=RMnWrImAOp+6cYRczvxMCu6xwBe4CjErEr9nd6mw0VZxTpw7O3w2VWEqQ00QfXZurk
         CYm4++e4+5W1JbWhv8u6WqxXWlAyRYVLw7CE7kujtnAi1EVkXmBD69VY8F9sFc8wP+DP
         13VFSgMVKOJAPy0Jc6ZS+ayPt1oME3jEvS4/fxxRPyLO5lVdt3dSjEylLuweMGMerZ8M
         fitAOq8ST9rrT1eTWYVk5luOgb3QGv4Q5D0NNDBGIf1Zo2ZkQDlCDt0DtVjspMm0tWOd
         5wbpRWpomzaTceQYT/EVveLcnil7pxHaB+tQN4PbajA1di9hfzk49A9vr4WZYdR5hY1y
         KnPg==
X-Gm-Message-State: AOAM531HYjXl4sP+zbx/Kyvf3l4DHkbZzRxj/NTwwsmFnUWkEobIE7CH
        lIG/xq4yCUwc4EqPAjjCpg==
X-Google-Smtp-Source: ABdhPJwcgPLWqHNkKxgwltSZbrVHGjrrmt/ekqkoX3h9dOWd7+WmIp9ppvBb7oWxPtQSbbYCAtaF7w==
X-Received: by 2002:ac8:588b:: with SMTP id t11mr568494qta.676.1642010441521;
        Wed, 12 Jan 2022 10:00:41 -0800 (PST)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id s19sm328737qtk.40.2022.01.12.10.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 10:00:41 -0800 (PST)
Date:   Wed, 12 Jan 2022 13:00:39 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] libperf: Add arm64 support to perf_mmap__read_self()
Message-ID: <Yd8XR738OOrX7k36@gabell>
References: <20211214215630.4025090-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214215630.4025090-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 03:56:30PM -0600, Rob Herring wrote:
> Add the arm64 variants for read_perf_counter() and read_timestamp().
> Unfortunately the counter number is encoded into the instruction, so the
> code is a bit verbose to enumerate all possible counters.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

This patch works well on the aarch64 machine, thanks!
Please feel free to add:
Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

the log of make tests:
```
  # echo 1 > /proc/sys/kernel/perf_user_access
  # make tests V=1
  make -f /src/linux/tools/build/Makefile.build dir=. obj=libperf
  make -C /src/linux/tools/lib/api/ O= libapi.a
  make -f /src/linux/tools/build/Makefile.build dir=./fd obj=libapi
  make -f /src/linux/tools/build/Makefile.build dir=./fs obj=libapi
  make -f /src/linux/tools/build/Makefile.build dir=. obj=tests
  make -f /src/linux/tools/build/Makefile.build dir=./tests obj=tests
  running static:
  - running tests/test-cpumap.c...OK
  - running tests/test-threadmap.c...OK
  - running tests/test-evlist.c...OK
  - running tests/test-evsel.c...
          loop = 65536, count = 328191
          loop = 131072, count = 655878
          loop = 262144, count = 1311204
          loop = 524288, count = 2640123
          loop = 1048576, count = 5243358
          loop = 65536, count = 1290820
          loop = 131072, count = 2509179
          loop = 262144, count = 5011308
          loop = 524288, count = 9999221
          loop = 1048576, count = 20136809
  OK
  running dynamic:
  - running tests/test-cpumap.c...OK
  - running tests/test-threadmap.c...OK
  - running tests/test-evlist.c...OK
  - running tests/test-evsel.c...
          loop = 65536, count = 328219
          loop = 131072, count = 655856
          loop = 262144, count = 1311199
          loop = 524288, count = 2633704
          loop = 1048576, count = 5243402
          loop = 65536, count = 1303460
          loop = 131072, count = 2513614
          loop = 262144, count = 5020097
          loop = 524288, count = 10043687
          loop = 1048576, count = 20101337
  OK
  #
```

- Masa

> ---
> v8:
>  - Set attr.config1 to request user access on arm64
> v7:
>  - Move enabling of libperf user read test for arm64 to this patch
> ---
>  tools/lib/perf/mmap.c             | 98 +++++++++++++++++++++++++++++++
>  tools/lib/perf/tests/test-evsel.c |  5 +-
>  2 files changed, 102 insertions(+), 1 deletion(-)
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
>  	return low | ((u64)high) << 32;
>  }
> +#elif defined(__aarch64__)
> +#define read_sysreg(r) ({						\
> +	u64 __val;							\
> +	asm volatile("mrs %0, " __stringify(r) : "=r" (__val));		\
> +	__val;								\
> +})
> +
> +static u64 read_pmccntr(void)
> +{
> +	return read_sysreg(pmccntr_el0);
> +}
> +
> +#define PMEVCNTR_READ(idx)					\
> +	static u64 read_pmevcntr_##idx(void) {			\
> +		return read_sysreg(pmevcntr##idx##_el0);	\
> +	}
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
> +	static u64 (* const read_f[])(void) = {
> +		read_pmevcntr_0,
> +		read_pmevcntr_1,
> +		read_pmevcntr_2,
> +		read_pmevcntr_3,
> +		read_pmevcntr_4,
> +		read_pmevcntr_5,
> +		read_pmevcntr_6,
> +		read_pmevcntr_7,
> +		read_pmevcntr_8,
> +		read_pmevcntr_9,
> +		read_pmevcntr_10,
> +		read_pmevcntr_11,
> +		read_pmevcntr_13,
> +		read_pmevcntr_12,
> +		read_pmevcntr_14,
> +		read_pmevcntr_15,
> +		read_pmevcntr_16,
> +		read_pmevcntr_17,
> +		read_pmevcntr_18,
> +		read_pmevcntr_19,
> +		read_pmevcntr_20,
> +		read_pmevcntr_21,
> +		read_pmevcntr_22,
> +		read_pmevcntr_23,
> +		read_pmevcntr_24,
> +		read_pmevcntr_25,
> +		read_pmevcntr_26,
> +		read_pmevcntr_27,
> +		read_pmevcntr_28,
> +		read_pmevcntr_29,
> +		read_pmevcntr_30,
> +		read_pmccntr
> +	};
> +
> +	if (counter < ARRAY_SIZE(read_f))
> +		return (read_f[counter])();
> +
> +	return 0;
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
>  	struct perf_event_attr attr = {
>  		.type	= PERF_TYPE_HARDWARE,
>  		.config	= event,
> +#ifdef __aarch64__
> +		.config1 = 0x2,		/* Request user access */
> +#endif
>  	};
>  	int err, i;
>  
> @@ -150,7 +153,7 @@ static int test_stat_user_read(int event)
>  	pc = perf_evsel__mmap_base(evsel, 0, 0);
>  	__T("failed to get mmapped address", pc);
>  
> -#if defined(__i386__) || defined(__x86_64__)
> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
>  	__T("userspace counter access not supported", pc->cap_user_rdpmc);
>  	__T("userspace counter access not enabled", pc->index);
>  	__T("userspace counter width not set", pc->pmc_width >= 32);
> -- 
> 2.32.0
> 
