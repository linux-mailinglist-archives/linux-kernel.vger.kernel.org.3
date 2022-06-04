Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BA953D571
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350430AbiFDE2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiFDE2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:28:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5EE35DF0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 21:28:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n13-20020a17090a394d00b001e30a60f82dso13526622pjf.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 21:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yn5/ZDP8Cojank8hFfjZKa0tb2ssK51DrACpaq53qsA=;
        b=pmiYleJAyY4Pmhe9IA+istalMQQ2fNuvuI4ulBeYvwEcfBwtO0Z4SHYElxtwDwr87Z
         wRAoWnYOjED4BtdGz0S1GRPVaXEW7wyY7nopMyi7LGY9TnS4u74WaSLnb1/ojgjxEk0k
         Z4EVoBe4CpcsBs3P32Qc3sp/80vs9wbz3Pb4s+BK+w5jMb4OTWtrAXRfX9zMs1D5bJeL
         G/9vj0yOXcEBtga+JtP/gnKCOFPO0iO2qNrFrioBD/IFJj5+lXnthTu+Iq4kJUQ2syge
         yWiu1/0yswEhGPM/E8zyJk1ZbwVelL1FoWkBgJ6ddpfZ8AtfJRVtAvR2QSsnOKiwqY6N
         4gIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yn5/ZDP8Cojank8hFfjZKa0tb2ssK51DrACpaq53qsA=;
        b=JCU/cxsE57JYmZA2Rv7k3bCO+wcSjyuNEFflh81L77I7e3aCQbZo9xxRT1WNFTd0vG
         oXMREtt461zr6cX4PbnSe7MWgdcskHMNfgQyxmCLrnhc37JgYsVeggRNF4hl1E7v4ZJh
         dFuhJFGzRMwmcgx0kR2zRmijhumo5UgwtjZlkBQPF2huQC4ZnwdiG7skPW73IUul4oEH
         pnt5e1NHADbxgOvR3r9LDSyMmWf3ywAnYMLpJKmu79K3FiCQzAlpQ6c5DY5xsXTgjZbk
         Xe9Srj0TrhuEGwDKAvkY6cHxM8e56unCBCnYbPuUd9gnZ9DeXVec9Hj1nj4d9Y3/0QNO
         XNiQ==
X-Gm-Message-State: AOAM5313pHG14DLwilbYxY4cOBqCk1bkhPJwRA7FNyZ8TA4Ce8WcPXWi
        K1zni94mLjiRQaBTlrG8XIfj4A==
X-Google-Smtp-Source: ABdhPJwxyyu+5EskOg5GTwWkuWqJPxuVx7mgJG0Eh2CnxWlooMI7n0I1FYZXm4li0cV/Bxkkv2RUrA==
X-Received: by 2002:a17:903:290:b0:15c:1c87:e66c with SMTP id j16-20020a170903029000b0015c1c87e66cmr13300666plr.61.1654316921960;
        Fri, 03 Jun 2022 21:28:41 -0700 (PDT)
Received: from leo-build-box.lan (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm6152916pll.304.2022.06.03.21.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 21:28:41 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 00/17] perf c2c: Support data source and display for Arm64
Date:   Sat,  4 Jun 2022 12:28:03 +0800
Message-Id: <20220604042820.2270916-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm64 Neoverse CPUs supports data source in Arm SPE trace, this allows
us to detect cache line contention and transfers.

This patch set includes Ali's patch set v9 "perf: arm-spe: Decode SPE
source and use for perf c2c" [1] and rebased on the latest perf core
banch with latest commit 1bcca2b1bd67 ("perf vendor events intel:
Update metrics for Alderlake").

Patches 01-05 comes from Ali's patch set to support data source for Arm
SPE for neoverse cores.

Patches 06-17 are patches from patch set v4 for support perf c2c peer
display for Arm64 [2].

This patch set has been verified for both x86 perf memory events and Arm
SPE events.

[1] https://lore.kernel.org/lkml/20220517020326.18580-1-alisaidi@amazon.com/
[2] https://lore.kernel.org/lkml/20220530114036.3225544-1-leo.yan@linaro.org/

Changes from v4:
* Included Ali's patch set for adding data source in Arm SPE samples;
* Added Ian's ACK and Ali's review and test tags;
* Update document for the default peer dispaly for Arm64 (Ali).

Changes from v3:
* Changed to display remote and local peer accesses (Joe);
* Fixed the usage info for display types (Joe);
* Do not display HITM dimensions when use 'peer' display, and HITM
  display doesn't show any 'peer' dimensions (James);
* Split to smaller patches for adding dimensions of peer operations;
* Updated documentation to reflect the latest GUI and stdio.

Changes from v2:
* Updated patch 04 to account metrics for both cache level and ld_peer
  for PEER flag;
* Updated document for metric 'rmt_hit' which is accounted for all
  remote accesses (include remote DRAM and any upward caches).

Changes from v1:
* Updated patches 01, 02 and 03 to support 'N/A' metrics for store
  operations, so can align with the patch set [1] for store samples.


Ali Saidi (3):
  perf: Add SNOOP_PEER flag to perf mem data struct
  perf tools: sync addition of PERF_MEM_SNOOPX_PEER
  perf arm-spe: Use SPE data source for neoverse cores

Leo Yan (14):
  perf mem: Print snoop peer flag
  perf arm-spe: Don't set data source if it's not a memory operation
  perf mem: Add statistics for peer snooping
  perf c2c: Output statistics for peer snooping
  perf c2c: Add dimensions for peer load operations
  perf c2c: Add dimensions of peer metrics for cache line view
  perf c2c: Add mean dimensions for peer operations
  perf c2c: Use explicit names for display macros
  perf c2c: Rename dimension from 'percent_hitm' to
    'percent_costly_snoop'
  perf c2c: Refactor node header
  perf c2c: Refactor display string
  perf c2c: Sort on peer snooping for load operations
  perf c2c: Use 'peer' as default display for Arm64
  perf c2c: Update documentation for new display option 'peer'

 include/uapi/linux/perf_event.h               |   2 +-
 tools/include/uapi/linux/perf_event.h         |   2 +-
 tools/perf/Documentation/perf-c2c.txt         |  31 +-
 tools/perf/builtin-c2c.c                      | 454 ++++++++++++++----
 .../util/arm-spe-decoder/arm-spe-decoder.c    |   1 +
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  12 +
 tools/perf/util/arm-spe.c                     | 140 +++++-
 tools/perf/util/mem-events.c                  |  46 +-
 tools/perf/util/mem-events.h                  |   3 +
 9 files changed, 550 insertions(+), 141 deletions(-)

-- 
2.25.1

