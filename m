Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7A251EC79
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 11:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbiEHJaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 05:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbiEHJaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 05:30:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0636AE42
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 02:25:54 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso10408605pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 02:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pA8VGKLqfC1iE6+6bQ/jXfFhVZ9BK9x1Q5PgdGMEwUw=;
        b=o1kaOjdAJXoA13wgpRDroI+Fl8hHKaQs8EhTo0Yqb7MGBx3xgv0bq0MaA0WYAINjvy
         d0ecuNyvqQUFk9BwrUWfyaRVDgcFZEXDAr8+ioN8A1h7BTEGumwApLqPI+LqNpexhxtm
         4n7J2YAzfOYzL/6rpES13/6ZVJFmMTuU3xu+Lx9RjNwmY/MnWLgdFPRJt6LO8s+TthXE
         sb/hg9cvw4QIq0ke0WFfpVu6qBk0cOF7PWXftlL8kPqKck1kwe8AKbd4zbdEQpfzUvik
         hyWX64JrYWKCImRlljyFN5r06WXO1oLkNlZyCE560hCYy4nzm9nLM1mINYTPvmTIsP9u
         z6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pA8VGKLqfC1iE6+6bQ/jXfFhVZ9BK9x1Q5PgdGMEwUw=;
        b=4UPpoNCoCuEUUh2Hp1m7rJUfU1TMhP6HhlbgZJjD6iQRx5NBGElc4DmW2cMN7KM2KW
         eBtqmLnGVUPoVls2SrSdJx427fBDGFNLiwqn7dJ4RfQokPJGDQ4kHwE2cHeeC6Gg2BFb
         lsZwS6HWsczGEckuEYYdtc3fn1R06c1UCL70Zq4pBj3f/Xg+gKSRNnzrZHJEdtS1jLs2
         QDNtr0qA47Ipqf5uag35Bfl3o+pj7IsJX+3pEI1S8JonApixzjoU1Hv4uR5cshSd6Lwy
         MX6EkN0Qx/I12dmykWt6IStlBe8Yz6rsiuRYTU+GWXOaZUBDUKc1G51+Z/+Yb9pB02Y5
         z/SA==
X-Gm-Message-State: AOAM532R3CKI+7uDQ7AvL3kuw8ZruB+fd7ZjWwy6nCs/JkX5+f/5pJ8o
        a/kxb4Yeb5s6EncT1RFxAG+gpw==
X-Google-Smtp-Source: ABdhPJwui8DZgaze6hcC7r2eMntLFZnk7YtY0J3c/fZHAndBTbFAsu+eMqOuEbIA9rE2ygup7hbe5w==
X-Received: by 2002:a17:903:41c9:b0:15e:b449:ce9a with SMTP id u9-20020a17090341c900b0015eb449ce9amr11289572ple.136.1652001954095;
        Sun, 08 May 2022 02:25:54 -0700 (PDT)
Received: from localhost.localdomain (104-237-153-19.ip.linodeusercontent.com. [104.237.153.19])
        by smtp.gmail.com with ESMTPSA id t63-20020a638142000000b003c14af505f7sm6155088pgd.15.2022.05.08.02.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 02:25:53 -0700 (PDT)
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
Subject: [PATCH v2 10/11] perf c2c: Update documentation for new display option 'peer'
Date:   Sun,  8 May 2022 17:23:45 +0800
Message-Id: <20220508092346.255826-11-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508092346.255826-1-leo.yan@linaro.org>
References: <20220508092346.255826-1-leo.yan@linaro.org>
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
Tested-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/Documentation/perf-c2c.txt | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 6f69173731aa..cc98a7e774f6 100644
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
 
@@ -211,6 +218,9 @@ For each offset in the 2) list we display following data:
   HITM - Rmt, Lcl
   - % of Remote/Local HITM accesses for given offset within cacheline
 
+  Snoop Peer
+  - % of peer accesses for given offset within cacheline
+
   Store Refs - L1 Hit, L1 Miss, N/A
   - % of store accesses that hit L1, missed L1 and N/A (no available) memory
     level for given offset within cacheline
@@ -227,8 +237,9 @@ For each offset in the 2) list we display following data:
   Code address
   - code address responsible for the accesses
 
-  cycles - rmt hitm, lcl hitm, load
-    - sum of cycles for given accesses - Remote/Local HITM and generic load
+  cycles - rmt hitm, lcl hitm, load, peer
+    - sum of cycles for given accesses - Remote/Local HITM, generic load and
+      peer access
 
   cpu cnt
     - number of cpus that participated on the access
@@ -251,7 +262,8 @@ The 'Node' field displays nodes that accesses given cacheline
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

