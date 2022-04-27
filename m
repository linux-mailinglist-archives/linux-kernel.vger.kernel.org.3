Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D606512123
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbiD0Py4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240740AbiD0Pys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:54:48 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B499755218
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:51:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso2098577pjj.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88bbCk2ERYh6ocqftQtDENMk2Clg/XqHfHpE0jpLddU=;
        b=s83lkLksIUw8ngM7Tyq59eA4QD43e/DNUuirs4yzjdEUPGyJd9J1EPuqIZYpEm/E2a
         /35yDMvpNeOSfLpENywPsTdCITlb5EYJlaER73sUmG/2V63kr9N6OA1w7atZdNpgEIOG
         nPcP7Ui8oeioiaoqkPQuE1qBwXwluoQLP1WxPXG6vbkTMSErVqFHBYbRO+vK4KTWq7Ob
         SKnuMAJX+SsD2vj+uMk/ew2OTxkGItXFlzbXBOIu2RqrrJ8r9iECZHgDyMYsdLsBF49b
         f0ohV4mcDTiOIIrnlFkOHV+015HCNvPJXPIjrKOgrooM8hn9B0USG41fDXP2m0KpFvyq
         hsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88bbCk2ERYh6ocqftQtDENMk2Clg/XqHfHpE0jpLddU=;
        b=B32cL6OcBXAbf/c9AsFdMJp+XZODkqopBskYuhNwStNWrzIah2BHCl1zFX9G7zReYB
         6/xfEnIUIW/WRLILKZUEPBFc6jughw2Ds0lFPM2Ty6wDoLUW17ps2PAoXzb2ZVM6tfg0
         TgT5JD5Q2AD8GqzXvKIehqYCLf5nKrWWbTiAseqn802Irx06Q45xRy2piGaZzDu/IIJc
         B0o2/vEZRLWabww/bJ32DHNoNpVewoL3dUK4HXRLhDDxPLdgsfsEaWmydI4JeqCYijAv
         HcD7HJlnAb7tg7cYzZsIXYziLojCeNxXfZkJ3DIOz4tGtZhyGS77DxlYAfgMsybG01Rw
         ugeg==
X-Gm-Message-State: AOAM531dOx8Fqro0RJFTaxbfnjRy/fJO8F/jJUBH3FTEzLt/wWFcqDpG
        tibGb7WKgy01swpy8yc8jfgl8g==
X-Google-Smtp-Source: ABdhPJwYE1C1HRFhiAteWQw5NTe3sYOsMFFZ2w/7k6RfFUYNlXJpoH4zgI18iSg0W8q4Yw/eEx1ewA==
X-Received: by 2002:a17:90b:3145:b0:1d9:ab18:910e with SMTP id ip5-20020a17090b314500b001d9ab18910emr10949105pjb.57.1651074690736;
        Wed, 27 Apr 2022 08:51:30 -0700 (PDT)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id v65-20020a626144000000b0050a839e490bsm19164127pfb.185.2022.04.27.08.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:51:30 -0700 (PDT)
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
Subject: [PATCH v1 10/11] perf c2c: Update documentation for new display option 'peer'
Date:   Wed, 27 Apr 2022 23:50:12 +0800
Message-Id: <20220427155013.1833222-11-leo.yan@linaro.org>
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

Since the new display option 'peer' is introduced, this patch is to
update the documentation to reflect it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/Documentation/perf-c2c.txt | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index b39e3f3df272..aa560ce1a192 100644
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
   Store Refs - L1 Hit, L1 Miss, Any Lvl
   - % of store accesses that hit L1, missed L1 and any cache level for given
     offset within cacheline
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

