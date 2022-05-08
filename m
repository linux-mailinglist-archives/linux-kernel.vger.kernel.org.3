Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A6951EC72
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 11:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbiEHJ2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 05:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbiEHJ2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 05:28:01 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23490E018
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 02:24:11 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i24so9856313pfa.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 02:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z6uX63iR449Fhd6M4diOxMzit8RTT+bIpfvarwCvnXI=;
        b=Rxn3Hn9CvU1CZ64On5PEPNh5xUZsM8XWXzcA5s54WThKboDOyJ6i2+TWGuAZV1hqs2
         h4IKAyJ0oAYhI+uoZU7RrvB+EoGQ+qN4TD6dL8faM+HXfaKndVIJsP0FrS88s3D83T46
         WQS69CyvCLlkXblypOua/GVlG+x9jln3AofBG+rPJCDePthXcnpTr1CbCGUJCbJqR+RU
         4e14ZqbN//MLkyU1+9XXcUUToi6OLdIfbf6h6YCXT8HX0UYxIIy5VLNcY8efCRM2uW/K
         IdkCtig7Lom9Vt8f7C/JGIV0Q0f4Ax4rQk97dDxRV4VzDuUddg4g2LwE52tSsQUVnZ3M
         lV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z6uX63iR449Fhd6M4diOxMzit8RTT+bIpfvarwCvnXI=;
        b=DilgbCV3cQFiB2vCeovlNKYVpqGf7l9bQOyMDm1XTuKduKbYjZZgeBauCZaSnjZDkp
         8Bg4nvQVQIcHc+kqPPxZWS+SmxIJtbYELHGwB6qNUQFaFSmCJHBKP+9Yz9UBBRn2TPzI
         a73TT3R3mRcQjBIPvjImf121YtSaTlmvfBLrulF8LWq88D1VcWfhfAqOEfLtAVFEb+68
         VsCqoQi8RnV2EtuYLIQknxn0sq3H9ny5JomSv3hIbIEmrKSr22xvos0gIqOCYbLmRytK
         S0Q8A4yiDyMHNt48bqgFpUrXKKow8U7qTAxP1JkjGDXF+8x20i+d4IG7Is3xvJOJvGAG
         CaOw==
X-Gm-Message-State: AOAM531eHEBlimjtmOiXh5hy6bfB3isdxvLtm+P/Fff/J9vGu98VOhlK
        F/CwfkQJr4jv05DFegA+8NkffQ==
X-Google-Smtp-Source: ABdhPJyCbod0+gKnjsgkQzEHMUBPT/g+jW0Df9eAmY3KtFsrU0UH0nvyBVu4IXcPXFb2fCwRz18yxg==
X-Received: by 2002:a63:6847:0:b0:3c5:7405:1ce1 with SMTP id d68-20020a636847000000b003c574051ce1mr8879078pgc.500.1652001850451;
        Sun, 08 May 2022 02:24:10 -0700 (PDT)
Received: from localhost.localdomain (104-237-153-19.ip.linodeusercontent.com. [104.237.153.19])
        by smtp.gmail.com with ESMTPSA id t63-20020a638142000000b003c14af505f7sm6155088pgd.15.2022.05.08.02.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 02:24:09 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 00/11] perf c2c: Support display for Arm64
Date:   Sun,  8 May 2022 17:23:35 +0800
Message-Id: <20220508092346.255826-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm64 Neoverse CPUs supports data source in Arm SPE trace, this allows
us to detect cache line contention and transfers.

Unlike x86 architecture, Arm SPE trace data cannot provide 'HITM'
snooping flag, Ali Said has a patch set "perf: arm-spe: Decode SPE
source and use for perf c2c" [1] which introduces 'peer' flag and
synthesizes memory samples with this flag.

Based on patch set [1], this patch set is to finish the second half work
to consume the 'peer' flag in perf c2c tool, it adds an extra display
'peer' mode.

Patches 01, 02 and 03 are to support 'N/A' metrics for store operations.

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
  # Index             Address  Node  PA cnt     Hitm    Total  LclHitm  RmtHitm     Peer  records    Loads   Stores    L1Hit   L1Miss      N/A       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
  # .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
  #
        0      0x55c8971f0080     0    1967   66.14%      252      252        0        0     6044     3550     2494     2024      470        0      528     2672       78        20      252         0        0         0         0
        1      0x55c8971f00c0     0       1   33.86%      129      129        0        0      914      914        0        0        0        0      272      374       52        87      129         0        0         0         0

  =================================================
        Shared Cache Line Distribution Pareto      
  =================================================
  #
  #        ----- HITM -----    Snoop  ------- Store Refs ------  --------- Data address ---------                      --------------- cycles ---------------    Total       cpu                                     Shared                               
  #   Num  RmtHitm  LclHitm     Peer   L1 Hit  L1 Miss      N/A              Offset  Node  PA cnt        Code address  rmt hitm  lcl hitm      load      peer  records       cnt                  Symbol             Object              Source:Line  Node
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
  # Index             Address  Node  PA cnt     Peer    Total  LclHitm  RmtHitm     Peer  records    Loads   Stores    L1Hit   L1Miss      N/A       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
  # .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
  #
        0      0xaaaac17d6000   N/A       0  100.00%        0        0        0       99    18851    18851        0        0        0        0        0    18752        0         0        0         0        0         0         0

  =================================================
        Shared Cache Line Distribution Pareto      
  =================================================
  #
  #        ----- HITM -----    Snoop  ------- Store Refs ------  --------- Data address ---------                      --------------- cycles ---------------    Total       cpu                                    Shared                       
  #   Num  RmtHitm  LclHitm     Peer   L1 Hit  L1 Miss      N/A              Offset  Node  PA cnt        Code address  rmt hitm  lcl hitm      load      peer  records       cnt                  Symbol            Object      Source:Line  Node
  # .....  .......  .......  .......  .......  .......  .......  ..................  ....  ......  ..................  ........  ........  ........  ........  .......  ........  ......................  ................  ...............  ....
  #
    -------------------------------------------------------------------------------
        0        0        0       99        0        0        0      0xaaaac17d6000
    -------------------------------------------------------------------------------
             0.00%    0.00%    6.06%    0.00%    0.00%    0.00%                0x20   N/A       0      0xaaaac17c25ac         0         0        43       375    18469         2  [.] 0x00000000000025ac  memstress         memstress[25ac]   0
             0.00%    0.00%   93.94%    0.00%    0.00%    0.00%                0x29   N/A       0      0xaaaac17c3e88         0         0       173       180      135         2  [.] 0x0000000000003e88  memstress         memstress[3e88]   0

[1] https://lore.kernel.org/lkml/20220504184850.24986-1-alisaidi@amazon.com/

Changes from v1:
* Update patches 01, 02 and 03 to support 'N/A' metrics for store
  operations, so can align with the patch set [1] for store samples.


Leo Yan (11):
  perf mem: Add stats for store operation with no available memory level
  perf c2c: Add dimensions for 'N/A' metrics of store operation
  perf c2c: Update documentation for store metric 'N/A'
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
 tools/perf/util/mem-events.c          |  14 +-
 tools/perf/util/mem-events.h          |   2 +
 4 files changed, 323 insertions(+), 86 deletions(-)

-- 
2.25.1

