Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC7152B216
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiERF7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 01:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiERF6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 01:58:43 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FC8C1EC4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 22:58:42 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id w200so1168222pfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 22:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HuFAm8dswxs0wJpe859Bx/uCWiO+qpjjwMrcj/U6zI0=;
        b=M6+qEdMvMfzUIQxtmpSvBhA21ny+1NzlPaIQQgrc+seZv/J7LPxk7xIBlKL2uet6pi
         LdyB86+Wvp/TKUFxOae3trOTC+RSVuvSoGnGqwJPHVQRb6kLFUZ78/aYjNHzYLRzVbuw
         O9dnRd7zBrue9sd4KnTfrgLBO7kvxy7QQmrWeqFdESFqs7+vEtzs5RlNnfX4QaqfCmbI
         Nv8FH2V61F1Gw+qH+UxDUOMBHlSY1IutZ7l7XysEM1BQAUgPoU9+/wERBOWwBo8Fj9yx
         mtGQyeKbh6VSRyrn/sbMAs6dwBKyizpp+apayaANYV9QnBYopKZ8KQ1g3r9/ASQuUYI+
         tiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HuFAm8dswxs0wJpe859Bx/uCWiO+qpjjwMrcj/U6zI0=;
        b=kfuQ6zYX0xwjmn9e1Tmps9/lU6BggHigimqM2maX8XRoJcEsiIvs6Q7Q0TOdrA1Gf7
         8aPZaCj/h+qoAom9Uclt+nJEUzWpoav/40nhOsE9zNSZ32S0ADJ0BNL6gNXtOlIqFuC4
         UXvCik8+CKlfv0k5FlKakUAThUuLGH+PTWAvC7yYIUOfLpFhbj+Acu5/EoanCPpP3PPi
         h3arWxXfGteIRSuxTV20MMzNO9X9CxH5+1ifSmEbK86Dapjkacw8GQLAEBCBgs7oVIeO
         sXFB83YeCw1fOlk2t0GBlEYMQgdaB5uktONXzS+w+qSGHCLPNj0Lku0Fk2KLmzCM9AN9
         MaTw==
X-Gm-Message-State: AOAM532Rs1IQdO25YzyOCDxiAm21Yu068MZC3laRnR75Z9lAZIa/aEWT
        nMx4Y/edAVUI2KIWhYfAcrgaGg==
X-Google-Smtp-Source: ABdhPJwPDL9HVyNCX0HgEXtiamj9uLQ76gvMYy3PaiVMKxK6ebJgDTBKmqbx02hC7UEpmkYiFk+oHw==
X-Received: by 2002:aa7:83c2:0:b0:505:723f:6ace with SMTP id j2-20020aa783c2000000b00505723f6acemr25884638pfn.86.1652853521612;
        Tue, 17 May 2022 22:58:41 -0700 (PDT)
Received: from localhost.localdomain (n058152048195.netvigator.com. [58.152.48.195])
        by smtp.gmail.com with ESMTPSA id cp16-20020a170902e79000b0015e8d4eb2c2sm627127plb.268.2022.05.17.22.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 22:58:41 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
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
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 10/11] perf c2c: Update documentation for new display option 'peer'
Date:   Wed, 18 May 2022 13:57:28 +0800
Message-Id: <20220518055729.1869566-11-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518055729.1869566-1-leo.yan@linaro.org>
References: <20220518055729.1869566-1-leo.yan@linaro.org>
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

Since the new display option 'peer' is introduced, this patch is to
update the documentation to reflect it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/Documentation/perf-c2c.txt | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 6f69173731aa..df9536be856b 100644
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
+  Rmt/Lcl Hitm (For display with HITM types)
   - cacheline percentage of all Remote/Local HITM accesses
 
+  Snoop Peer (For display with peer type)
+  - cacheline percentage of peer access
+
   LLC Load Hitm - Total, LclHitm, RmtHitm
   - count of Total/Local/Remote load HITMs
 
+  Snoop Peer
+  - count of peer access
+
   Total records
   - sum of all cachelines accesses
 
@@ -201,7 +208,9 @@ For each cacheline in the 1) list we display following data:
   - count of LLC load accesses, includes LLC hits and LLC HITMs
 
   RMT Load Hit - RmtHit, RmtHitm
-  - count of remote load accesses, includes remote hits and remote HITMs
+  - count of remote load accesses, includes remote hits and remote HITMs;
+    on Arm neoverse cores, RmtHit is used to account remote accesses,
+    includes remote DRAM or any upward cache level in remote node
 
   Load Dram - Lcl, Rmt
   - count of local and remote DRAM accesses
@@ -211,6 +220,9 @@ For each offset in the 2) list we display following data:
   HITM - Rmt, Lcl
   - % of Remote/Local HITM accesses for given offset within cacheline
 
+  Snoop Peer
+  - % of peer accesses for given offset within cacheline
+
   Store Refs - L1 Hit, L1 Miss, N/A
   - % of store accesses that hit L1, missed L1 and N/A (no available) memory
     level for given offset within cacheline
@@ -227,8 +239,9 @@ For each offset in the 2) list we display following data:
   Code address
   - code address responsible for the accesses
 
-  cycles - rmt hitm, lcl hitm, load
-    - sum of cycles for given accesses - Remote/Local HITM and generic load
+  cycles - rmt hitm, lcl hitm, load, peer
+    - sum of cycles for given accesses - Remote/Local HITM, generic load and
+      peer access
 
   cpu cnt
     - number of cpus that participated on the access
@@ -251,7 +264,8 @@ The 'Node' field displays nodes that accesses given cacheline
 offset. Its output comes in 3 flavors:
   - node IDs separated by ','
   - node IDs with stats for each ID, in following format:
-      Node{cpus %hitms %stores}
+      Node{cpus %hitms %stores} (For display with HITM types)
+      Node{cpus %peers %stores} (For display with "peer" type)
   - node IDs with list of affected CPUs in following format:
       Node{cpu list}
 
-- 
2.25.1

