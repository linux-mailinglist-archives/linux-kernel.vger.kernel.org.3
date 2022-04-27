Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E5A511DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240418AbiD0PyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240705AbiD0Px7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:53:59 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD7A5418D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:50:46 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u9so1286205plf.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mfKXbZgTIWEbTeJVhX3se1YhLuBecr8QQNQtzkisZ/M=;
        b=FynZD/Nxe3Kd36w7ZFjddUbEH+HlByXx87gtJ4W57LZLaRmUOK1HRcfbyB6Ql8llP3
         Lnjwql8fWqr9XFPpLWm66YB+ZbPyCJH87wO59ONmwO3sQ3q/NHljKCCBH2rEGeqf1+TS
         pos6vXQ78YWj6iqWkEfIaM7qSt37Y7ukFGvPiW3ELILfmRZSy+bCMJyxnZOwiIS67gZY
         qKQqJTD8UAXCD7mQHEwN2qigtUxK49DEXsMosJbcFv7CT9iPjVHTXOiuCJ7seygl50FK
         /vbqM8DHshD2+mhEuXaIJT4uvpgiuqgWoQKX0p3uJR+ES+VPb/UMINH8W3sI8v6Od8QK
         UPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mfKXbZgTIWEbTeJVhX3se1YhLuBecr8QQNQtzkisZ/M=;
        b=QSTjZNgcktaeouQIoEvv7+SqhUwzukIoc3NCENgJ5fFHQ9BpEBm3pGjwOysUHdDXkG
         qEzy6orHglqowmZiZrTh0mpo8ZUakzCU8Yh0xQ2FZ3W8FUdicp9HOpj1zhlGBoV/7iTa
         thk5jZol5lhyaG8eVppO8rdr9KfanXPjbR3Y8UEMpYCGIazON6y7SZjEDl/dDuKGlVU3
         SupwFjDr8Vztv+R9oa4jkN3ohzCMuMoAsmafF8BS1X+rkFGFoHOkjMI5jsvf2q0QXanP
         1JlMKnPEIyTE3eO/AsrRLD5eQPwLRqinV/WUZHuMGDCsyCZL0NwEe+kk3/5qOe9m4bIc
         WXQw==
X-Gm-Message-State: AOAM5335wthqaJcEm3NvntMkPYu0uRRezH5r86852/2FIBg7XWcGFOBk
        TRGzDNsYRKr2P03DHTFDO0FSUg==
X-Google-Smtp-Source: ABdhPJzyg4F/AeRn63E0UEHpjQyBVkOG2K2klpoV5R1ukWxPZZMkych35g8pp0R8H2elq8bJi8QzTA==
X-Received: by 2002:a17:90b:1c8e:b0:1bf:364c:dd7a with SMTP id oo14-20020a17090b1c8e00b001bf364cdd7amr33215082pjb.103.1651074646401;
        Wed, 27 Apr 2022 08:50:46 -0700 (PDT)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id v65-20020a626144000000b0050a839e490bsm19164127pfb.185.2022.04.27.08.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:50:46 -0700 (PDT)
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
Subject: [PATCH v1 03/11] perf c2c: Update documentation for store metric 'Any Lvl'
Date:   Wed, 27 Apr 2022 23:50:05 +0800
Message-Id: <20220427155013.1833222-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427155013.1833222-1-leo.yan@linaro.org>
References: <20220427155013.1833222-1-leo.yan@linaro.org>
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

The 'Any Lvl' metric is added for store operations, update documentation
to reflect changes in the report table.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/Documentation/perf-c2c.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 3b6a2c84ea02..b39e3f3df272 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -189,9 +189,10 @@ For each cacheline in the 1) list we display following data:
   Total stores
   - sum of all store accesses
 
-  Store Reference - L1Hit, L1Miss
+  Store Reference - L1Hit, L1Miss, AnyLvl
     L1Hit - store accesses that hit L1
     L1Miss - store accesses that missed L1
+    AnyLvl - store accesses which is possible to hit any cache level
 
   Core Load Hit - FB, L1, L2
   - count of load hits in FB (Fill Buffer), L1 and L2 cache
@@ -210,8 +211,9 @@ For each offset in the 2) list we display following data:
   HITM - Rmt, Lcl
   - % of Remote/Local HITM accesses for given offset within cacheline
 
-  Store Refs - L1 Hit, L1 Miss
-  - % of store accesses that hit/missed L1 for given offset within cacheline
+  Store Refs - L1 Hit, L1 Miss, Any Lvl
+  - % of store accesses that hit L1, missed L1 and any cache level for given
+    offset within cacheline
 
   Data address - Offset
   - offset address
-- 
2.25.1

