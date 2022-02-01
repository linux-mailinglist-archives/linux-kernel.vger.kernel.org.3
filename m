Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373324A68DE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243041AbiBAX77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241096AbiBAX76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:59:58 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B389C061714;
        Tue,  1 Feb 2022 15:59:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C67AFCE1B02;
        Tue,  1 Feb 2022 23:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4431C340EB;
        Tue,  1 Feb 2022 23:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643759993;
        bh=ue4RtWGJnXTWHompasZC27/ozql0kDk4bjSgN5qaTjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oDQKynrmPyfh5V9b7E+gahUB9j/vndh5hi99TRCu7Tj10XzdTJ3gR+vGnS2oJSk3C
         L34DupgdhO9dk17MCq/D04t6fkbTxvYOd9PaxZvJ9M3d/fzIkTbNpSypq4HNT/0d/6
         iRo+jPAeHXKJMOgjVi58ogsPfvUimIl6rPcJZ/T1iFIjjHlQlzLnQCbyz0oPtZN13G
         Iex987vb9od5e70gDHXA7Ziz/qMjXcJPZ5JtdHd3fk/zhxyOlQ6O6bRp8WQzqR1MJ1
         d+6t49hMJFo5q4crKbZCG24NdacfVlqNHiRuIBkLNpkDxqWdVumpa31INZoIq9tslT
         FggJsC7TaAqVw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 18FF440466; Tue,  1 Feb 2022 20:59:51 -0300 (-03)
Date:   Tue, 1 Feb 2022 20:59:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9] libperf: Add arm64 support to perf_mmap__read_self()
Message-ID: <YfnJd7nMhbsIlghV@kernel.org>
References: <20220201214056.702854-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201214056.702854-1-robh@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 01, 2022 at 03:40:56PM -0600, Rob Herring escreveu:
> Add the arm64 variants for read_perf_counter() and read_timestamp().
> Unfortunately the counter number is encoded into the instruction, so the
> code is a bit verbose to enumerate all possible counters.
> 
> Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Looks sane, will give some time to Jiri to react.

- Arnaldo

> ---
> Arm64 kernel support landed in 5.17, but the corresponding libperf 
> support didn't get picked up.
> 
> v9:
>  - Rebase on v5.17-rc
>  - Add Tested-by
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
> index f7ee07cb5818..0d1634cedf44 100644
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

-- 

- Arnaldo
