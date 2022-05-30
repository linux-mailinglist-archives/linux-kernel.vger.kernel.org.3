Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441B3537A1C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiE3Lmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbiE3LmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:42:05 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602B512752
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:41:58 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y1so10363029pfr.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LdxnTcXDrJ5Hs4bCX9T3OZHsm8XEJDCruVBdQ6pwKoc=;
        b=ooUrNtahWsQ/dC/e3fO6YAyaQSMxODE6/OQ6nYHoSjmHvFGqgpLkHe3/hRwNWXuB0v
         Yg5WP+nhNqzLXUuu7QQBrejrPUMWVylWInURkgIzUzfe7OS+oYXBYVz5VMFl3bQRa09Z
         Cso5qREOTM0fDZ9Pav5SAyLlbaTBtrFV0u4NwACN0bPaKfWvm3ajw5mq1UXYHTMO7Tte
         dXTwvMtSQNVScWSwlWuJ1uG0vQNbGO2IGKIRZKV9ZgDJ1dT5hnrJhna6WkPXH2Ks3J76
         jINH1Qpxuq3fCz4LXptKKbtFHt7weHfti8p0cuuZm5yCTS+Oz96QrvwemkQ5IINOPJjQ
         Vl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LdxnTcXDrJ5Hs4bCX9T3OZHsm8XEJDCruVBdQ6pwKoc=;
        b=1k8XTOh0KpfneP+n/LWVByX/RxTKUjKnMv6z0XeA18pIaipW5moepLlVQiJIwAspFf
         nzxA95REhSB0YRuOl3fGdt2/YpI0aUaO8NJy1gZJnTaHskF3X/hsdoileelAx0xxZRUR
         nesELM5DfPU8cviy1kmQkxJnpow0NO9JnYu632qwnHqq2s/hbiJyZ+ZFJaNyfVvdTcpP
         fZHYl0XzWbynB4pOQhsb+5zHZtMvx2CVTLY2l1EsYL5aXPxWKHDxzMEmEcIq2pj2lz5+
         V2PLv7jf2yZ2uInsDs0AHG2VO1BloucqhfMS8fvtlO16m/EpdQsWWrnp407zSHml3ptm
         k0aA==
X-Gm-Message-State: AOAM532cUJMuWvrozz1S8i4mVXtlJhcf71aSnDlwBPvBnvqEE+qE2gES
        kVZjLNWpZWrMgFpqepsF09m9/g==
X-Google-Smtp-Source: ABdhPJzXUeKZvxuLnb/e7hEqtwEeM9YU+K0OtIUC58d4PVWRRcbiWsnWXYTefnUXwlC4viMdlGugFA==
X-Received: by 2002:a62:1b06:0:b0:518:1649:bb6d with SMTP id b6-20020a621b06000000b005181649bb6dmr57040995pfb.25.1653910917454;
        Mon, 30 May 2022 04:41:57 -0700 (PDT)
Received: from leo-build-box.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902724700b00161a9df4de8sm8846194pll.145.2022.05.30.04.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 04:41:57 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Alyssa Ross <hi@alyssa.is>,
        Ian Rogers <irogers@google.com>, Like Xu <likexu@tencent.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 12/12] perf c2c: Update documentation for new display option 'peer'
Date:   Mon, 30 May 2022 19:40:36 +0800
Message-Id: <20220530114036.3225544-13-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220530114036.3225544-1-leo.yan@linaro.org>
References: <20220530114036.3225544-1-leo.yan@linaro.org>
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
---
 tools/perf/Documentation/perf-c2c.txt | 30 ++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 6f69173731aa..e1549798c6f3 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -109,7 +109,8 @@ REPORT OPTIONS
 
 -d::
 --display::
-	Switch to HITM type (rmt, lcl) to display and sort on. Total HITMs as default.
+	Switch to HITM type (rmt, lcl) or peer snooping type (peer) to display
+	and sort on. Total HITMs (tot) as default.
 
 --stitch-lbr::
 	Show callgraph with stitched LBRs, which may have more complete
@@ -174,12 +175,18 @@ For each cacheline in the 1) list we display following data:
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
 
@@ -201,16 +208,21 @@ For each cacheline in the 1) list we display following data:
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
@@ -227,9 +239,12 @@ For each offset in the 2) list we display following data:
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
 
@@ -251,7 +266,8 @@ The 'Node' field displays nodes that accesses given cacheline
 offset. Its output comes in 3 flavors:
   - node IDs separated by ','
   - node IDs with stats for each ID, in following format:
-      Node{cpus %hitms %stores}
+      Node{cpus %hitms %stores} (Display with HITM types)
+      Node{cpus %peers %stores} (Display with peer type)
   - node IDs with list of affected CPUs in following format:
       Node{cpu list}
 
-- 
2.25.1

