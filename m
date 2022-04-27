Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67D0511F0E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbiD0PyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240450AbiD0Pxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:53:50 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E58C5522B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:50:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id t13so1940328pfg.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dlG0K9xZUYvFAJYmf+buQXaqhKG8vCQsNhSOF2Se/b4=;
        b=y7vypUdy0AV6bxYU0yGYu/Q+FgbkCBWKrCwABEVdhwlOz8bGO12D6pjxX0N9nEXGFL
         M0B/CcvTyb8NGgqLPqsgPx6rRrUN1BlfscecIVDgOUcA6nQOZwArzaKsPWeJw4fXNeSW
         xQsRW0bWYH0tqiDdtgydkmQOMazUTDzb7GVQ5sbvgAiiFHnS939xYHrNARv9K5nKrTwj
         pn9PyYyr8rOGEjdMOD/RxyixWjN3/yEEQQfzQOyA8RbWQ1kNzY/InhrOD/de3HXiNllp
         KDEXSX8PYLtgV09kdx9FYz9Sf5TRyNfflw1Uwte0mN04fynKNQWbxOb6vn7vEo1oxX8F
         pn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dlG0K9xZUYvFAJYmf+buQXaqhKG8vCQsNhSOF2Se/b4=;
        b=IsxK74K8Ye3ptLFTGrG4YnFgxXtk+nSybS3zAAEGxcPRLOriz6cup1XP6kk9fUadat
         5/MbkoDpgZ3oVXCbTQzvMZBz7YqkTGIw5N5TqG//O2s+ky2cZ8d183Sb81HZkZ4mgU3r
         3JPPC5KUOWtnrfT+QG8OcvmZncFVK9iFuSvr6UWcS0ps3iXAG+VY9uXTPcRRVeiQC7SR
         AuDu7nS9XjLxabUc3a6yfUC8BqnZAkNlubG4Y502sZ3W9fynTVrst6HCosHzh8k7kgvr
         +6XnRP6LBdAbltfGHgEf03DWbistRa5Z/jFa293FgRJ+nIU4c5zCOwhBZICJtihCF8b5
         j4OA==
X-Gm-Message-State: AOAM531xGRlMrVde2wPCCUMkjKrie2nZGNEHKnSHBNGg6pfGItIrjk3A
        2+f3DfR2HRpMOvxlNSPsH5jCqA==
X-Google-Smtp-Source: ABdhPJzIxSlNFCS3cQoE/hHvRcfsYpng6Gubq9hpBNWLgPyaBfbDP0hASKEW4RTaraTkFECCK8s9gg==
X-Received: by 2002:a05:6a00:1254:b0:50a:55c5:5ff7 with SMTP id u20-20020a056a00125400b0050a55c55ff7mr30697342pfi.85.1651074626527;
        Wed, 27 Apr 2022 08:50:26 -0700 (PDT)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id v65-20020a626144000000b0050a839e490bsm19164127pfb.185.2022.04.27.08.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:50:25 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>, Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Ali Saidi <alisaidi@amazon.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 00/11] perf c2c: Support display for Arm64
Date:   Wed, 27 Apr 2022 23:50:02 +0800
Message-Id: <20220427155013.1833222-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm64 Neoverse CPUs can deliver data source in Arm SPE trace, this
allows us to detect like cache line contention and transfers.

There have two main differences between x86 arch and Arm64 arch for the
data source:

The data source in Arm64 Neoverse CPUs cannot provide the cache level
info for store operations, so this is why this patch set starts to
support 'any level' for store operations when we lack the exact cache
level info.

Another difference is Arm SPE trace data cannot provide 'HITM' liked
snooping flag, Ali Said has a patch set "perf: arm-spe: Decode SPE
source and use for perf c2c" [1] introducing 'peer' flag and synthesize
memory samples with 'peer' flag.  This patch is to finish the second
half to enable 'perf c2c' tool to consume the 'peer' flag, so it adds
an extra display 'peer' mode.

Patches 01, 02 and 03 are to support 'Any Lvl' cache for store
operations.

Patches 04 and 05 adds statistics and dimensions for memory samples with
peer flag.

Patches 06, 07, 08 are for refactoring, it refines the code with more
general naming so this can allow us to easier to extend display modes
but not strictly bound to HITM tags.

Patches 09, 10 and 11 are to extend display 'peer' mode, it also updates
the document and also changes to use 'peer' mode as default mode on
Arm64 arches.

This patch set has been verified for both x86 and Arm64 memory samples.

The display result with x86 memory samples:

  =================================================
             Shared Data Cache Line Table          
  =================================================
  #
  #        ----------- Cacheline ----------      Tot  ------- Load Hitm -------    Snoop    Total    Total    Total  --------- Stores --------  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
  # Index             Address  Node  PA cnt     Hitm    Total  LclHitm  RmtHitm     Peer  records    Loads   Stores    L1Hit   L1Miss   Anylvl       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
  # .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
  #
        0      0x55c8971f0080     0    1967   66.14%      252      252        0        0     6044     3550     2494     2024      470        0      528     2672       78        20      252         0        0         0         0
        1      0x55c8971f00c0     0       1   33.86%      129      129        0        0      914      914        0        0        0        0      272      374       52        87      129         0        0         0         0

  =================================================
        Shared Cache Line Distribution Pareto      
  =================================================
  #
  #        ----- HITM -----    Snoop  ------- Store Refs ------  --------- Data address ---------                      --------------- cycles ---------------    Total       cpu                                     Shared                               
  #   Num  RmtHitm  LclHitm     Peer   L1 Hit  L1 Miss  Any Lvl              Offset  Node  PA cnt        Code address  rmt hitm  lcl hitm      load      peer  records       cnt                  Symbol             Object              Source:Line  Node
  # .....  .......  .......  .......  .......  .......  .......  ..................  ....  ......  ..................  ........  ........  ........  ........  .......  ........  ......................  .................  .......................  ....
  #
    -------------------------------------------------------------------------------
        0        0      252        0     2024      470        0      0x55c8971f0080
    -------------------------------------------------------------------------------
             0.00%   12.30%    0.00%    0.00%    0.00%    0.00%                 0x0     0       1      0x55c8971ed3e9         0      1313       863         0     1222         3  [.] 0x00000000000013e9  false_sharing.exe  false_sharing.exe[13e9]   0
             0.00%    0.79%    0.00%   90.51%    0.00%    0.00%                 0x0     0       1      0x55c8971ed3e2         0      1800       878         0     3029         3  [.] 0x00000000000013e2  false_sharing.exe  false_sharing.exe[13e2]   0
             0.00%    0.00%    0.00%    9.49%  100.00%    0.00%                 0x0     0       1      0x55c8971ed3f4         0         0         0         0      662         3  [.] 0x00000000000013f4  false_sharing.exe  false_sharing.exe[13f4]   0
             0.00%   86.90%    0.00%    0.00%    0.00%    0.00%                0x20     0       1      0x55c8971ed447         0       141       103         0     1131         2  [.] 0x0000000000001447  false_sharing.exe  false_sharing.exe[1447]   0

    -------------------------------------------------------------------------------
        1        0      129        0        0        0        0      0x55c8971f00c0
    -------------------------------------------------------------------------------
             0.00%  100.00%    0.00%    0.00%    0.00%    0.00%                0x20     0       1      0x55c8971ed455         0        88        94         0      914         2  [.] 0x0000000000001455  false_sharing.exe  false_sharing.exe[1455]   0


The display result with Arm SPE memory samples:

  =================================================
             Shared Data Cache Line Table          
  =================================================
  #
  #        ----------- Cacheline ----------    Snoop  ------- Load Hitm -------    Snoop    Total    Total    Total  --------- Stores --------  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
  # Index             Address  Node  PA cnt     Peer    Total  LclHitm  RmtHitm     Peer  records    Loads   Stores    L1Hit   L1Miss   Anylvl       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
  # .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
  #
        0      0xaaaac17d6000   N/A       0  100.00%        0        0        0       99    18851    18851        0        0        0        0        0    18752        0         0        0         0        0         0         0

  =================================================
        Shared Cache Line Distribution Pareto      
  =================================================
  #
  #        ----- HITM -----    Snoop  ------- Store Refs ------  --------- Data address ---------                      --------------- cycles ---------------    Total       cpu                                    Shared                       
  #   Num  RmtHitm  LclHitm     Peer   L1 Hit  L1 Miss  Any Lvl              Offset  Node  PA cnt        Code address  rmt hitm  lcl hitm      load      peer  records       cnt                  Symbol            Object      Source:Line  Node
  # .....  .......  .......  .......  .......  .......  .......  ..................  ....  ......  ..................  ........  ........  ........  ........  .......  ........  ......................  ................  ...............  ....
  #
    -------------------------------------------------------------------------------
        0        0        0       99        0        0        0      0xaaaac17d6000
    -------------------------------------------------------------------------------
             0.00%    0.00%    6.06%    0.00%    0.00%    0.00%                0x20   N/A       0      0xaaaac17c25ac         0         0        43       375    18469         2  [.] 0x00000000000025ac  memstress         memstress[25ac]   0
             0.00%    0.00%   93.94%    0.00%    0.00%    0.00%                0x29   N/A       0      0xaaaac17c3e88         0         0       173       180      135         2  [.] 0x0000000000003e88  memstress         memstress[3e88]   0

[1] https://lore.kernel.org/lkml/20220426135937.18497-1-alisaidi@amazon.com/


Leo Yan (11):
  perf mem: Add any cache level statistics for store operation
  perf c2c: Add dimensions for 'anylvl' metrics of store operation
  perf c2c: Update documentation for store metric 'Any Lvl'
  perf mem: Add statistics for peer snooping
  perf c2c: Add dimensions for peer load operations
  perf c2c: Use explicit names for display macros
  perf c2c: Rename dimension from 'percent_hitm' to
    'percent_costly_snoop'
  perf c2c: Refactor node header
  perf c2c: Sort on peer snooping for load operations
  perf c2c: Update documentation for new display option 'peer'
  perf c2c: Use 'peer' as default display for Arm64

 tools/perf/Documentation/perf-c2c.txt |  30 ++-
 tools/perf/builtin-c2c.c              | 363 ++++++++++++++++++++------
 tools/perf/util/mem-events.c          |  15 +-
 tools/perf/util/mem-events.h          |   2 +
 4 files changed, 324 insertions(+), 86 deletions(-)

-- 
2.25.1

