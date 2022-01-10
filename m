Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C41348A10B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242476AbiAJUml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:42:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41762 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239763AbiAJUmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:42:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39446B8107D;
        Mon, 10 Jan 2022 20:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F4AC36AE3;
        Mon, 10 Jan 2022 20:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641847357;
        bh=ixfttF5n8HoI6L9+TzWzEOSbNh8LTbQ4ekAG8iY4T/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NIV4xl55UZBl1FPHB64zVduR8YPWadJtxAwjcECkJgkbbNXehdY6TELmm7Qn/Zsfr
         OkPg0wKey35IMgKmc7GW2NZMH7ojtPq9UcAcXS9UCbZA6sQtj6JtHXe+lSDq8isR06
         CqO1KnopwPqlG2mtTUu2eU3FhqRMvEx0PIpQ/gH9ztm2Eg/r7TwGYvBr8CBGIYLl6O
         rtYFRZ8PSn6XSn5AQpmcrVKFl7p2MvMI44248aTg5ctZxLdDyv6ikCeS6pB8UVMAd+
         O+2iYJ8+bnWGERl1TYRWN+JJYQRRNQHO71nXYMFlkVjELHa77tDLv+ywRigiLpuPcI
         n98SSMEzryMPQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 95C6940714; Mon, 10 Jan 2022 17:42:35 -0300 (-03)
Date:   Mon, 10 Jan 2022 17:42:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com,
        eranian@google.com
Subject: Re: [PATCH v4 00/48] Refactor perf cpumap
Message-ID: <YdyaOw5Yz8jmEfOw@kernel.org>
References: <20220105061351.120843-1-irogers@google.com>
 <YdyUVSHs/OLZ9Ntm@kernel.org>
 <YdyZq4dHjhJrxOHb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdyZq4dHjhJrxOHb@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 10, 2022 at 05:40:12PM -0300, Arnaldo Carvalho de Melo escreveu:
> > I'm now making it go thru the container builds.
> 
> Not a good start, checking:
> 
> [perfbuilder@five ~]$ time dm
>    1    50.25 almalinux:8                   : FAIL clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
>     builtin-stat.c:1499:31: error: unused function 'perf_env__get_cpu' [-Werror,-Wunused-function]
>     static inline struct perf_cpu perf_env__get_cpu(void *data, struct perf_cpu_map *map, int idx)

                                   ^
Interesting, it builds with gcc, not with clang:

+ make PYTHON=python3 ARCH= CROSS_COMPILE= EXTRA_CFLAGS= -C tools/perf O=/tmp/build/perf CC=clang

And it really isn't used anywhere in builtin-stat.c, will remove it
after figuring out when it stops being used.

- Arnaldo

>     1 error generated.
>    2    54.14 alpine:3.4                    : FAIL clang version 3.8.0 (tags/RELEASE_380/final)
>     builtin-stat.c:1499:31: error: unused function 'perf_env__get_cpu' [-Werror,-Wunused-function]
>     static inline struct perf_cpu perf_env__get_cpu(void *data, struct perf_cpu_map *map, int idx)
>                                   ^
>     1 error generated.
>    3    39.78 alpine:3.5                    : FAIL clang version 3.8.1 (tags/RELEASE_381/final)
>     builtin-stat.c:1499:31: error: unused function 'perf_env__get_cpu' [-Werror,-Wunused-function]
>     static inline struct perf_cpu perf_env__get_cpu(void *data, struct perf_cpu_map *map, int idx)
>                                   ^
>     1 error generated.
>    4    82.52 alpine:3.6                    : FAIL clang version 4.0.0 (tags/RELEASE_400/final)
>     builtin-stat.c:1499:31: error: unused function 'perf_env__get_cpu' [-Werror,-Wunused-function]
>     static inline struct perf_cpu perf_env__get_cpu(void *data, struct perf_cpu_map *map, int idx)
>                                   ^
>     1 error generated.
>    5   113.61 alpine:3.7                    : FAIL gcc version 6.4.0 (Alpine 6.4.0)
>     builtin-stat.c:1499:31: error: unused function 'perf_env__get_cpu' [-Werror,-Wunused-function]
>     static inline struct perf_cpu perf_env__get_cpu(void *data, struct perf_cpu_map *map, int idx)
>                                   ^
>     1 error generated.
>    6   119.02 alpine:3.8                    : FAIL gcc version 6.4.0 (Alpine 6.4.0)
>     builtin-stat.c:1499:31: error: unused function 'perf_env__get_cpu' [-Werror,-Wunused-function]
>     static inline struct perf_cpu perf_env__get_cpu(void *data, struct perf_cpu_map *map, int idx)
>                                   ^
>     1 error generated.
>    7    64.55 alpine:3.9                    : FAIL gcc version 8.3.0 (Alpine 8.3.0)
>     builtin-stat.c:1499:31: error: unused function 'perf_env__get_cpu' [-Werror,-Wunused-function]
>     static inline struct perf_cpu perf_env__get_cpu(void *data, struct perf_cpu_map *map, int idx)
>                                   ^
>     1 error generated.
>    8: alpine:3.10

-- 

- Arnaldo
