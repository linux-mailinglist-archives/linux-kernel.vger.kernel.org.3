Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8AB4E3E19
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbiCVMIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbiCVMIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:08:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5685583B2C;
        Tue, 22 Mar 2022 05:06:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0380C153B;
        Tue, 22 Mar 2022 05:06:53 -0700 (PDT)
Received: from [10.1.39.145] (e127744.cambridge.arm.com [10.1.39.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 059A73F73B;
        Tue, 22 Mar 2022 05:06:48 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] perf: arm-spe: Decode SPE source and use for perf
 c2c
To:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, leo.yan@linaro.org,
        acme@kernel.org
Cc:     benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
References: <20220318195913.17459-1-alisaidi@amazon.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <cd1abed3-6528-ec8f-260e-dca3654e5ce9@arm.com>
Date:   Tue, 22 Mar 2022 12:05:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220318195913.17459-1-alisaidi@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ali, thank you for your patches

On 18/03/2022 19:59, Ali Saidi wrote:
> When synthesizing data from SPE, augment the type with source information
> for Arm Neoverse cores so we can detect situtions like cache line contention
> and transfers on Arm platforms. 
>
> This changes enables the expected behavior of perf c2c on a system with SPE where
> lines that are shared among multiple cores show up in perf c2c output. 
>
> These changes switch to use mem_lvl_num to encode the level information instead
> of mem_lvl which is being deprecated, but I haven't found other users of
> mem_lvl_num. 
>
> Changes in v3:
>   * Assume ther are only three levels of cache hierarchy
>   * Split the mem_lvl_num and HITM changes in c2c into two seperate patches
>
> Ali Saidi (3):
>   perf arm-spe: Use SPE data source for neoverse cores
>   perf mem: Support mem_lvl_num in c2c command
>   perf mem: Support HITM for when mem_lvl_num is any
>
>  .../util/arm-spe-decoder/arm-spe-decoder.c    |   1 +
>  .../util/arm-spe-decoder/arm-spe-decoder.h    |  12 ++
>  tools/perf/util/arm-spe.c                     | 109 +++++++++++++++---
>  tools/perf/util/mem-events.c                  |  20 +++-
>  4 files changed, 124 insertions(+), 18 deletions(-)
>

I tested on a Neoverse N1 system using the below commands and the output
looks either unchanged or improved compared to before. For example:

| $ perf mem record -e spe-ldst -a -- sleep 4
| $ perf mem report
|
| 1.39%             1  1263          L3 miss                   [k] 0xffffb9a34bda2088
| 0.58%             1  529           L1 miss                   [k] 0xffffb9a34bd3be7c
| 0.34%             1  310           N/A                       [k] 0xffffb9a34baf4d28
| 0.34%             1  309           N/A                       [k] 0xffffb9a34bb82844

... became:

| 1.39%             1  1263          RAM hit                   [k] 0xffffb9a34bda2088
| 0.58%             1  529           L2 hit                    [k] 0xffffb9a34bd3be7c
| 0.34%             1  310           L1 hit                    [k] 0xffffb9a34baf4d28
| 0.34%             1  309           L1 hit                    [k] 0xffffb9a34bb82844
                                                                      
Also some L3 misses are now labeled as "Any cache hit" with the Snoop 
bit set. For example:
                                                                      
| 0.37%             1  332           L3 miss                   [.] 0x0000aaaadf70a700    N/A

... became:                                                           

| 0.37%             1  332           Any cache hit             [.] 0x0000aaaadf70a700    HitM

Tested-by: German Gomez <german.gomez@arm.com>
Reviewed-by: German Gomez <german.gomez@arm.com>

Thanks,
German

(I didn't run on a non-Neoverse system but it doesn't look like any   
behaviour is changed for those)
