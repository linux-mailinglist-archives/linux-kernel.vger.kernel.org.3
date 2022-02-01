Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16ABA4A68D7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243021AbiBAX7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241096AbiBAX7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:59:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4D6C061714;
        Tue,  1 Feb 2022 15:59:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF42CB8241E;
        Tue,  1 Feb 2022 23:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB34C340EB;
        Tue,  1 Feb 2022 23:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643759942;
        bh=kwMD6uL4mpXj+hHjcC0KOQ6sWJ+8UYucGmBNS0v9jVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HB12T3jVTRAXVVG9hnDLtKDX4/6eVw5FM5EZfiRhELWxKxygc6leUhYUqmQ0sb6e1
         4Qi1BPxfBB2Vcwn1ET4N3wRaUQvSvvtd5t8zfHvJoOecBzta2xyz1ewL1LVIYCUs/O
         oLfpdjfIrpI9VzTRp6Z5tWM1Wu2Zofvx54mIR6HF7jXjC4d2w7Yfp3aU4ygLvuZRNx
         9brcMKbOlJA5S2WBWK8ik0DC7VxVezo5fFMTjZUVmlUy0JPdSFq52IdGHygy3Yhmtt
         WmUwIpFvO7cgcNY933oVWI2rHUB4872b85ncdbhfItSImyEYmxZV2fOP3JbqW7DOH8
         56c718LEUosCA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B60C140466; Tue,  1 Feb 2022 20:58:59 -0300 (-03)
Date:   Tue, 1 Feb 2022 20:58:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libperf: Fix 32-bit build for tests uint64_t printf
Message-ID: <YfnJQ44BgtyIIBDw@kernel.org>
References: <20220201213903.699656-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220201213903.699656-1-robh@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 01, 2022 at 03:39:03PM -0600, Rob Herring escreveu:
> Commit a7f3713f6bf2 ("libperf tests: Add test_stat_multiplexing test")
> added printf's of 64-bit ints using %lu which doesn't work on 32-bit
> builds:
> 
> tests/test-evlist.c:529:29: error: format ‘%lu’ expects argument of type \
>   ‘long unsigned int’, but argument 4 has type ‘uint64_t’ {aka ‘long long unsigned int’} [-Werror=format=]
> 
> Use PRIu64 instead which works on both 32-bit and 64-bit systems.

I´ll apply this tomorrow and as well will check why the existing tests
aren't catching this :-\

Thanks!

- Arnaldo
 
> Fixes: a7f3713f6bf2 ("libperf tests: Add test_stat_multiplexing test")
> Cc: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  tools/lib/perf/tests/test-evlist.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
> index b3479dfa9a1c..fa854c83b7e7 100644
> --- a/tools/lib/perf/tests/test-evlist.c
> +++ b/tools/lib/perf/tests/test-evlist.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #define _GNU_SOURCE // needed for sched.h to get sched_[gs]etaffinity and CPU_(ZERO,SET)
> +#include <inttypes.h>
>  #include <sched.h>
>  #include <stdio.h>
>  #include <stdarg.h>
> @@ -526,12 +527,12 @@ static int test_stat_multiplexing(void)
>  
>  	min = counts[0].val;
>  	for (i = 0; i < EVENT_NUM; i++) {
> -		__T_VERBOSE("Event %2d -- Raw count = %lu, run = %lu, enable = %lu\n",
> +		__T_VERBOSE("Event %2d -- Raw count = %" PRIu64 ", run = %" PRIu64 ", enable = %" PRIu64 "\n",
>  			    i, counts[i].val, counts[i].run, counts[i].ena);
>  
>  		perf_counts_values__scale(&counts[i], true, &scaled);
>  		if (scaled == 1) {
> -			__T_VERBOSE("\t Scaled count = %lu (%.2lf%%, %lu/%lu)\n",
> +			__T_VERBOSE("\t Scaled count = %" PRIu64 " (%.2lf%%, %" PRIu64 "/%" PRIu64 ")\n",
>  				    counts[i].val,
>  				    (double)counts[i].run / (double)counts[i].ena * 100.0,
>  				    counts[i].run, counts[i].ena);
> -- 
> 2.32.0

-- 

- Arnaldo
