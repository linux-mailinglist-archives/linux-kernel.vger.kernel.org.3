Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3ACC52EB17
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348684AbiETLqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347951AbiETLqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:46:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB9FA57105;
        Fri, 20 May 2022 04:46:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F63A1477;
        Fri, 20 May 2022 04:46:34 -0700 (PDT)
Received: from [192.168.0.5] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C68E3F718;
        Fri, 20 May 2022 04:46:31 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] perf: arm64: Tools support for Dwarf unwinding
 through SVE functions
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        broonie@kernel.org, leo.yan@linaro.org, mathieu.poirier@linaro.org,
        john.garry@huawei.com, Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220517102005.3022017-1-james.clark@arm.com>
 <YoO4Hiue7PmJ9KOS@kernel.org>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <995099d3-a170-69dc-d12e-c9b2e4753f35@arm.com>
Date:   Fri, 20 May 2022 12:46:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YoO4Hiue7PmJ9KOS@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/05/2022 15:58, Arnaldo Carvalho de Melo wrote:
> Em Tue, May 17, 2022 at 11:20:01AM +0100, James Clark escreveu:
>> Changes since v1:
>>
>>   * Split patchset into kernel side and Perf tool changes
> Thanks, now I'll wait for the kernel side to be merged.
>
> - Arnaldo
>  

Hi,

I think we also need to fix the below import (it's trying to import the
perf_regs.h from the kernel, not the tools/ dir).

diff --git a/tools/perf/util/libunwind/arm64.c b/tools/perf/util/libunwind/arm64.c
index 15f60fd09424..014d82159656 100644
--- a/tools/perf/util/libunwind/arm64.c
+++ b/tools/perf/util/libunwind/arm64.c
@@ -24,7 +24,7 @@
 #include "unwind.h"
 #include "libunwind-aarch64.h"
 #define perf_event_arm_regs perf_event_arm64_regs
-#include <../../../../arch/arm64/include/uapi/asm/perf_regs.h>
+#include <../../../arch/arm64/include/uapi/asm/perf_regs.h>
 #undef perf_event_arm_regs
 #include "../../arch/arm64/util/unwind-libunwind.c"


