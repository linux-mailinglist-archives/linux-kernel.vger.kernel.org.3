Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A0058F79D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 08:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbiHKG1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 02:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbiHKG0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:26:42 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF0D6C101
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:26:27 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z19so16188445plb.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=aXFjFccGANdUwvtZryztlC25DdtbTU6bNIi+xzPEs8M=;
        b=cmTa5UTGnSb14CI383akQ88vLH4A5udvCixMf7QsdBG6KLLeHMiTByAczpfmDrjVlU
         NAJ2wfa+nb2rcg+3YbqsR0J8FjBSkV/70C2ESUhQ5aNwCgRIpLkSO/6Q3jdVZIvIXjRS
         46nJzDGdEHgQuKgNVJRo0foXbYGRKcO4d8Ou+XL1RB5WZcoSNB4smQPdq+nV9zLuejk2
         +TlxcTdHeKQXxYfePEDl8VqoXBN4efNHORQ6eXOYO4Xffi5kBSKGzrjm1ufobE1Dd61Y
         PZkQPyBPhosY2QjcTu9dAa8u/4WXmbUwZWK8FIUpqkU8InnHeIyy6k/jgLSFjRiOmT23
         ZdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=aXFjFccGANdUwvtZryztlC25DdtbTU6bNIi+xzPEs8M=;
        b=sgklgiP70SSZZ1v9d0BBkYvAErE4yIRCGsxrG1llbjoeKW0XAx/ZyEdgX+c4H4tOgw
         PbRw0XEqz5MbneiqWtS4hWJGwaiGipAdyB1vGJFwvw8VpT3A6li4jit/GAnuN5cgN7gS
         9Vs/hvKTEJXpBq2XpmxyusYpDqgScUWTooMTIjmE5TvIcCSOTTXVYGiGUArizPUWJmMU
         hDDS5GgMS//+8a45vZPXc2km4Yv63hWisfudD4+6x1hc0q0b8v3LiOLsOilfSiVMNrGT
         hz1pFdJv6THSdOUvEn8cBlCFcwoc+YxZpJgqZ2e/PNN0MDnJnE473fK3lOd/unv8WiNe
         9Zwg==
X-Gm-Message-State: ACgBeo0DkEK1m88QQ9CCQDywsWNtkq2qdGjgsWrjHs+ggdoPCvgWUQ9L
        OVvMqNA+f/yNSTG8ZoC/AFo68A==
X-Google-Smtp-Source: AA6agR4n8ZaYpx9klZ/kRtJ73Tu6pOdF0YML1o9FxjpCu9NyxtSyyJol8ieOc0kQOL4T7cm2afHQwg==
X-Received: by 2002:a17:90a:c4f:b0:1df:a178:897f with SMTP id u15-20020a17090a0c4f00b001dfa178897fmr7300240pje.19.1660199186832;
        Wed, 10 Aug 2022 23:26:26 -0700 (PDT)
Received: from leoy-yangtze.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090a55cc00b001f506009036sm2766926pjm.49.2022.08.10.23.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 23:26:26 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ian Rogers <irogers@google.com>, Like Xu <likexu@tencent.com>,
        German Gomez <german.gomez@arm.com>,
        Timothy Hayes <timothy.hayes@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 15/15] perf c2c: Update documentation for new display option 'peer'
Date:   Thu, 11 Aug 2022 14:24:51 +0800
Message-Id: <20220811062451.435810-16-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220811062451.435810-1-leo.yan@linaro.org>
References: <20220811062451.435810-1-leo.yan@linaro.org>
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

Since the new display option 'peer' is introduced, this patch is to
update the documentation to reflect it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/Documentation/perf-c2c.txt | 31 +++++++++++++++++++++------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 6f69173731aa..f1f7ae6b08d1 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -109,7 +109,9 @@ REPORT OPTIONS
 
 -d::
 --display::
-	Switch to HITM type (rmt, lcl) to display and sort on. Total HITMs as default.
+	Switch to HITM type (rmt, lcl) or peer snooping type (peer) to display
+	and sort on. Total HITMs (tot) as default, except Arm64 uses peer mode
+	as default.
 
 --stitch-lbr::
 	Show callgraph with stitched LBRs, which may have more complete
@@ -174,12 +176,18 @@ For each cacheline in the 1) list we display following data:
   Cacheline
   - cacheline address (hex number)
 
-  Rmt/Lcl Hitm
+  Rmt/Lcl Hitm (Display with HITM types)
   - cacheline percentage of all Remote/Local HITM accesses
 
-  LLC Load Hitm - Total, LclHitm, RmtHitm
+  Peer Snoop (Display with peer type)
+  - cacheline percentage of all peer accesses
+
+  LLC Load Hitm - Total, LclHitm, RmtHitm (For display with HITM types)
   - count of Total/Local/Remote load HITMs
 
+  Load Peer - Total, Local, Remote (For display with peer type)
+  - count of Total/Local/Remote load from peer cache or DRAM
+
   Total records
   - sum of all cachelines accesses
 
@@ -201,16 +209,21 @@ For each cacheline in the 1) list we display following data:
   - count of LLC load accesses, includes LLC hits and LLC HITMs
 
   RMT Load Hit - RmtHit, RmtHitm
-  - count of remote load accesses, includes remote hits and remote HITMs
+  - count of remote load accesses, includes remote hits and remote HITMs;
+    on Arm neoverse cores, RmtHit is used to account remote accesses,
+    includes remote DRAM or any upward cache level in remote node
 
   Load Dram - Lcl, Rmt
   - count of local and remote DRAM accesses
 
 For each offset in the 2) list we display following data:
 
-  HITM - Rmt, Lcl
+  HITM - Rmt, Lcl (Display with HITM types)
   - % of Remote/Local HITM accesses for given offset within cacheline
 
+  Peer Snoop - Rmt, Lcl (Display with peer type)
+  - % of Remote/Local peer accesses for given offset within cacheline
+
   Store Refs - L1 Hit, L1 Miss, N/A
   - % of store accesses that hit L1, missed L1 and N/A (no available) memory
     level for given offset within cacheline
@@ -227,9 +240,12 @@ For each offset in the 2) list we display following data:
   Code address
   - code address responsible for the accesses
 
-  cycles - rmt hitm, lcl hitm, load
+  cycles - rmt hitm, lcl hitm, load (Display with HITM types)
     - sum of cycles for given accesses - Remote/Local HITM and generic load
 
+  cycles - rmt peer, lcl peer, load (Display with peer type)
+    - sum of cycles for given accesses - Remote/Local peer load and generic load
+
   cpu cnt
     - number of cpus that participated on the access
 
@@ -251,7 +267,8 @@ The 'Node' field displays nodes that accesses given cacheline
 offset. Its output comes in 3 flavors:
   - node IDs separated by ','
   - node IDs with stats for each ID, in following format:
-      Node{cpus %hitms %stores}
+      Node{cpus %hitms %stores} (Display with HITM types)
+      Node{cpus %peers %stores} (Display with peer type)
   - node IDs with list of affected CPUs in following format:
       Node{cpu list}
 
-- 
2.34.1

