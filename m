Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E90B52D5CD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbiESOTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiESOTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:19:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4950673795;
        Thu, 19 May 2022 07:19:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB4D31650;
        Thu, 19 May 2022 07:19:12 -0700 (PDT)
Received: from [10.57.1.211] (unknown [10.57.1.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70C0B3F66F;
        Thu, 19 May 2022 07:19:10 -0700 (PDT)
Message-ID: <d15bb8a2-2203-cabf-69de-627d0a45efdc@arm.com>
Date:   Thu, 19 May 2022 15:19:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 00/11] perf c2c: Support display for Arm64
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
References: <20220508092346.255826-1-leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Like Xu <likexu@tencent.com>, Ian Rogers <irogers@google.com>,
        Alyssa Ross <hi@alyssa.is>, Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220508092346.255826-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/05/2022 10:23, Leo Yan wrote:
> Arm64 Neoverse CPUs supports data source in Arm SPE trace, this allows
> us to detect cache line contention and transfers.
> 
> Unlike x86 architecture, Arm SPE trace data cannot provide 'HITM'
> snooping flag, Ali Said has a patch set "perf: arm-spe: Decode SPE
> source and use for perf c2c" [1] which introduces 'peer' flag and
> synthesizes memory samples with this flag.
> 
> Based on patch set [1], this patch set is to finish the second half work
> to consume the 'peer' flag in perf c2c tool, it adds an extra display
> 'peer' mode.
> 
> Patches 01, 02 and 03 are to support 'N/A' metrics for store operations.
> 
> Patches 04 and 05 adds statistics and dimensions for memory samples with
> peer flag.
> 
> Patches 06, 07, 08 are for refactoring, it refines the code with more
> general naming so this can allow us to easier to extend display modes
> but not strictly bound to HITM tags.
> 
> Patches 09, 10 and 11 are to extend display 'peer' mode, it also updates
> the document and also changes to use 'peer' mode as default mode on
> Arm64 arches.
> 
> This patch set has been verified for both x86 and Arm64 memory samples.
> 
> The display result with x86 memory samples:
> 
>   =================================================
>              Shared Data Cache Line Table          
>   =================================================
>   #
>   #        ----------- Cacheline ----------      Tot  ------- Load Hitm -------    Snoop    Total    Total    Total  --------- Stores --------  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
>   # Index             Address  Node  PA cnt     Hitm    Total  LclHitm  RmtHitm     Peer  records    Loads   Stores    L1Hit   L1Miss      N/A       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
>   # .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
>   #
>         0      0x55c8971f0080     0    1967   66.14%      252      252        0        0     6044     3550     2494     2024      470        0      528     2672       78        20      252         0        0         0         0
>         1      0x55c8971f00c0     0       1   33.86%      129      129        0        0      914      914        0        0        0        0      272      374       52        87      129         0        0         0         0
> 
>   =================================================
>         Shared Cache Line Distribution Pareto      
>   =================================================
>   #
>   #        ----- HITM -----    Snoop  ------- Store Refs ------  --------- Data address ---------                      --------------- cycles ---------------    Total       cpu                                     Shared                               
>   #   Num  RmtHitm  LclHitm     Peer   L1 Hit  L1 Miss      N/A              Offset  Node  PA cnt        Code address  rmt hitm  lcl hitm      load      peer  records       cnt                  Symbol             Object              Source:Line  Node
>   # .....  .......  .......  .......  .......  .......  .......  ..................  ....  ......  ..................  ........  ........  ........  ........  .......  ........  ......................  .................  .......................  ....
>   #
>     -------------------------------------------------------------------------------
>         0        0      252        0     2024      470        0      0x55c8971f0080
>     -------------------------------------------------------------------------------
>              0.00%   12.30%    0.00%    0.00%    0.00%    0.00%                 0x0     0       1      0x55c8971ed3e9         0      1313       863         0     1222         3  [.] 0x00000000000013e9  false_sharing.exe  false_sharing.exe[13e9]   0
>              0.00%    0.79%    0.00%   90.51%    0.00%    0.00%                 0x0     0       1      0x55c8971ed3e2         0      1800       878         0     3029         3  [.] 0x00000000000013e2  false_sharing.exe  false_sharing.exe[13e2]   0
>              0.00%    0.00%    0.00%    9.49%  100.00%    0.00%                 0x0     0       1      0x55c8971ed3f4         0         0         0         0      662         3  [.] 0x00000000000013f4  false_sharing.exe  false_sharing.exe[13f4]   0
>              0.00%   86.90%    0.00%    0.00%    0.00%    0.00%                0x20     0       1      0x55c8971ed447         0       141       103         0     1131         2  [.] 0x0000000000001447  false_sharing.exe  false_sharing.exe[1447]   0
> 
>     -------------------------------------------------------------------------------
>         1        0      129        0        0        0        0      0x55c8971f00c0
>     -------------------------------------------------------------------------------
>              0.00%  100.00%    0.00%    0.00%    0.00%    0.00%                0x20     0       1      0x55c8971ed455         0        88        94         0      914         2  [.] 0x0000000000001455  false_sharing.exe  false_sharing.exe[1455]   0
> 
> 
> The display result with Arm SPE memory samples:
> 
>   =================================================
>              Shared Data Cache Line Table          
>   =================================================
>   #
>   #        ----------- Cacheline ----------    Snoop  ------- Load Hitm -------    Snoop    Total    Total    Total  --------- Stores --------  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
>   # Index             Address  Node  PA cnt     Peer    Total  LclHitm  RmtHitm     Peer  records    Loads   Stores    L1Hit   L1Miss      N/A       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
>   # .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
>   #
>         0      0xaaaac17d6000   N/A       0  100.00%        0        0        0       99    18851    18851        0        0        0        0        0    18752        0         0        0         0        0         0         0
> 
>   =================================================
>         Shared Cache Line Distribution Pareto      
>   =================================================
>   #
>   #        ----- HITM -----    Snoop  ------- Store Refs ------  --------- Data address ---------                      --------------- cycles ---------------    Total       cpu                                    Shared                       
>   #   Num  RmtHitm  LclHitm     Peer   L1 Hit  L1 Miss      N/A              Offset  Node  PA cnt        Code address  rmt hitm  lcl hitm      load      peer  records       cnt                  Symbol            Object      Source:Line  Node
>   # .....  .......  .......  .......  .......  .......  .......  ..................  ....  ......  ..................  ........  ........  ........  ........  .......  ........  ......................  ................  ...............  ....
>   #
>     -------------------------------------------------------------------------------
>         0        0        0       99        0        0        0      0xaaaac17d6000
>     -------------------------------------------------------------------------------
>              0.00%    0.00%    6.06%    0.00%    0.00%    0.00%                0x20   N/A       0      0xaaaac17c25ac         0         0        43       375    18469         2  [.] 0x00000000000025ac  memstress         memstress[25ac]   0
>              0.00%    0.00%   93.94%    0.00%    0.00%    0.00%                0x29   N/A       0      0xaaaac17c3e88         0         0       173       180      135         2  [.] 0x0000000000003e88  memstress         memstress[3e88]   0
> 

Hi Leo,

I see that the HITM and Store Refs columns (even N/A) are all 0% on Arm.
Assuming it's a similar example to the x86 one above, does that mean that
these are always expected to be 0? If so, should they be removed to avoid
confusion, or is it just a case of the example not producing any non 0
data for these columns?

Thanks
James

> [1] https://lore.kernel.org/lkml/20220504184850.24986-1-alisaidi@amazon.com/
> 
> Changes from v1:
> * Update patches 01, 02 and 03 to support 'N/A' metrics for store
>   operations, so can align with the patch set [1] for store samples.
> 
> 
> Leo Yan (11):
>   perf mem: Add stats for store operation with no available memory level
>   perf c2c: Add dimensions for 'N/A' metrics of store operation
>   perf c2c: Update documentation for store metric 'N/A'
>   perf mem: Add statistics for peer snooping
>   perf c2c: Add dimensions for peer load operations
>   perf c2c: Use explicit names for display macros
>   perf c2c: Rename dimension from 'percent_hitm' to
>     'percent_costly_snoop'
>   perf c2c: Refactor node header
>   perf c2c: Sort on peer snooping for load operations
>   perf c2c: Update documentation for new display option 'peer'
>   perf c2c: Use 'peer' as default display for Arm64
> 
>  tools/perf/Documentation/perf-c2c.txt |  30 ++-
>  tools/perf/builtin-c2c.c              | 363 ++++++++++++++++++++------
>  tools/perf/util/mem-events.c          |  14 +-
>  tools/perf/util/mem-events.h          |   2 +
>  4 files changed, 323 insertions(+), 86 deletions(-)
> 
