Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DADD530B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiEWIoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiEWInz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:43:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F2D3FD94;
        Mon, 23 May 2022 01:43:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k30so20244079wrd.5;
        Mon, 23 May 2022 01:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XZSTdMReuFxUglr0zW1U7pUwHaY1HEM4FPwN5xMO+SM=;
        b=qTIBqn47z/Fb9xSVfVb33gHPU8ENmkdSAQGe2zeXBtk9/ccAtnXgbZYjwBCvSJl6UU
         Mvm+iH/61paNzSICE60vYxJcZp9YkUh0lCwoFFUoRkhXsljLzdiPCL7Pn58gEulfFJSn
         DIcPPdegVwCht55TAoLZ3QiShSMYg07AVowohLuqMRKk1+6ynBfj11Bf7nPbPssXSEb5
         vKICo9NK6G9FhexQ3+wb5DK8l1ngn5tez2zG5qCLW+vr5rsS4F19XgkOWzYQcUlAcDoH
         BsH4/bpHRNNlumclQ4csid6K9NDFkk6MfjDwx0CIJrfPdCdP2DrInyvY0KY1VfR0bAxM
         GE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XZSTdMReuFxUglr0zW1U7pUwHaY1HEM4FPwN5xMO+SM=;
        b=6PeIaszUrpcuYGEQaBfUk4NbEIxmiQe3uW/FNOoLEnlsNzD0UGoD0kFQNqDziDndY/
         WksDratGuScTRLB+Ou9T9l8U8byy6Rm+BaOIAZLQqGah9KiYuOhtCkp4J0+8bVsAsA5W
         kXSDIsEtisfzhY6qkjCiJGK1fnpBLxM5SqejOD2ScgYckoykB/L03pF6fEVcw+AWTw1Y
         FJaQMTwyhJW27tVaz0s8BQ8cwCsE+cBsx6XPsMjjlt0rKWRYV38eXdUSD7Of8Wam8tp/
         g57772Gj15d8EgypWKBpbZI+pP6uLDib4QSrzVvupd4GFGLJp2pe6yRbkOjVXhFURRSJ
         t0SA==
X-Gm-Message-State: AOAM533tf84xqr1STBnfO78n787P8UjFk1YD3MWqWi8FucD47oxTnpXt
        edp2WYaTKKIn5RB6KDvYftuErEb2fcnoU78P
X-Google-Smtp-Source: ABdhPJw8Loff4lKBqUCywlJhjWTuhQom5m+9y93XSta5iwQyYShn7WaatdDduekh7G/s7jg1A9WHcw==
X-Received: by 2002:a05:6000:178d:b0:20f:e84c:2f46 with SMTP id e13-20020a056000178d00b0020fe84c2f46mr1030243wrg.646.1653295432188;
        Mon, 23 May 2022 01:43:52 -0700 (PDT)
Received: from krava (net-93-65-240-241.cust.vodafonedsl.it. [93.65.240.241])
        by smtp.gmail.com with ESMTPSA id u25-20020adfae59000000b0020d106c0386sm9535510wrd.89.2022.05.23.01.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 01:43:51 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 23 May 2022 10:43:47 +0200
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Like Xu <likexu@tencent.com>, Alyssa Ross <hi@alyssa.is>,
        Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adam Li <adamli@amperemail.onmicrosoft.com>,
        Li Huafei <lihuafei1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/11] perf c2c: Support display for Arm64
Message-ID: <YotJQwZVfBtrEyuI@krava>
References: <20220518055729.1869566-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518055729.1869566-1-leo.yan@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 01:57:18PM +0800, Leo Yan wrote:
> Arm64 Neoverse CPUs supports data source in Arm SPE trace, this allows
> us to detect cache line contention and transfers.
> 
> Unlike x86 architecture, Arm SPE trace data cannot provide 'HITM'
> snooping flag, Ali Said has a patch set v9 "perf: arm-spe: Decode SPE
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
>         0      0xaaaac17d6000   N/A       0  100.00%        0        0        0       99    18851    18851        0        0        0        0        0    18752        0        99        0         0        0         0         0
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
> [1] https://lore.kernel.org/lkml/20220517020326.18580-1-alisaidi@amazon.com/
> 
> Changes from v2:
> * Updated patch 04 to account metrics for both cache level and ld_peer
>   for PEER flag;
> * Updated document for metric 'rmt_hit' which is accounted for all
>   remote accesses (include remote DRAM and any upward caches).

LGTM

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> Changes from v1:
> * Updated patches 01, 02 and 03 to support 'N/A' metrics for store
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
>  tools/perf/Documentation/perf-c2c.txt |  34 ++-
>  tools/perf/builtin-c2c.c              | 357 ++++++++++++++++++++------
>  tools/perf/util/mem-events.c          |  25 +-
>  tools/perf/util/mem-events.h          |   2 +
>  4 files changed, 331 insertions(+), 87 deletions(-)
> 
> -- 
> 2.25.1
> 
