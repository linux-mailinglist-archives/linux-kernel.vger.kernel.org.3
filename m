Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B7C5340E6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbiEYP7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiEYP7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:59:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 590AB6A045;
        Wed, 25 May 2022 08:59:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 107DD1424;
        Wed, 25 May 2022 08:59:39 -0700 (PDT)
Received: from [10.1.25.169] (e127744.cambridge.arm.com [10.1.25.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD0373F73D;
        Wed, 25 May 2022 08:59:35 -0700 (PDT)
Subject: Re: [PATCH v3 1/5] perf tools: arm64: Use perf's copy of kernel
 headers
To:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org
Cc:     broonie@kernel.org, leo.yan@linaro.org, mathieu.poirier@linaro.org,
        john.garry@huawei.com, Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220525154114.718321-1-james.clark@arm.com>
 <20220525154114.718321-2-james.clark@arm.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <b6cf9d34-313e-6b7d-3781-a8a5af203cd6@arm.com>
Date:   Wed, 25 May 2022 16:59:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220525154114.718321-2-james.clark@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/05/2022 16:41, James Clark wrote:
> Fix this include path to use perf's copy of the kernel header
> rather than the one from the root of the repo.
>
> This fixes build errors when only applying the perf tools
> part of a patchset rather than both sides.
>
> Reported-by: German Gomez <german.gomez@arm.com>
> Signed-off-by: James Clark <james.clark@arm.com>

Without this change "make -C tools/perf" was failing if kernel-side changes weren't applied

Tested-by: German Gomez <german.gomez@arm.com>

Thanks,
German

> ---
>  tools/perf/util/libunwind/arm64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/libunwind/arm64.c b/tools/perf/util/libunwind/arm64.c
> index 15f60fd09424..014d82159656 100644
> --- a/tools/perf/util/libunwind/arm64.c
> +++ b/tools/perf/util/libunwind/arm64.c
> @@ -24,7 +24,7 @@
>  #include "unwind.h"
>  #include "libunwind-aarch64.h"
>  #define perf_event_arm_regs perf_event_arm64_regs
> -#include <../../../../arch/arm64/include/uapi/asm/perf_regs.h>
> +#include <../../../arch/arm64/include/uapi/asm/perf_regs.h>
>  #undef perf_event_arm_regs
>  #include "../../arch/arm64/util/unwind-libunwind.c"
>  
