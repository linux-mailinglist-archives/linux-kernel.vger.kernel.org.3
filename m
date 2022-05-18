Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263B452B211
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiERF6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 01:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiERF6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 01:58:13 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F16BCE9D
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 22:58:12 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q4so799188plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 22:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z4lTY/GzRRypZHLQuY+nt/UwaUEznuMFvg2DfwVGtLM=;
        b=zdcnWymyjuilU1Jd/t/lJelM02FmLdPbFsjUdXk020fOzEJiHsCzDgEddZEESvVMmQ
         FPM0VOVN38SBmLjS/yAcXADwq4s3AVe7Ntk9MWxiTfkYRXqXvhXM4ENzBn1RCfNrKqi+
         fdjtUWNAs7jBqmkZORsbbhYVJejpF40qQnlWf4QhOWngbjLl2hTBXRI4yLsAqwwFcjG6
         7nQmNJCughaI9mS0vp9/eGGopwDed6vr1xxNdB/DX99gyp9PO76Bhv4tKaRZ/xORruS5
         67i+LshX4ayLXzGRI8d7vMlJy04/Jv834tuimrVuvx0l4msduuCiZRGL7rXR12gK/JWu
         FdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z4lTY/GzRRypZHLQuY+nt/UwaUEznuMFvg2DfwVGtLM=;
        b=LuhVUGywYN7+Ou+Pr9IDFS2YHK1E9xbDkjjEV6EdduAx77yUG8vwwbpLVRgbwdz99N
         LDHAvXXZRKXsePub34IA3K58rylVfwvWx5mjsy5A4bwfk42vR+ZorGNuUZyiJat4Kb8j
         h40Af/g9VBy3oIs/0GKxsgPCF/6ZJXIWS6OJYkTPsMrkk91/S4K3SAv9R7LbLOKbmxKi
         ioy+woSMAEL2SOCNGLVPRvwwXfK6eHv1rYmpGhkOdJnNvpOpfEoWl0mY6SO3T0ljHps3
         A+gmmULqxgTcuS5nThq2aJvC2O/fluG1cA1RH6osYLmQtOB991nztVxPvJEI1seoO9rf
         DAAw==
X-Gm-Message-State: AOAM5309cAuDQOtbzVDI3p8onyNTHbGMajl9r41nI5HGMFVExDx/VClW
        v3PFY7s+jkFIx6T4BedVnU5iwg==
X-Google-Smtp-Source: ABdhPJwQ0mij6QeWkXBfKbkmUGHRpZ4Cm4CMybPQhK8klrSKl9ZrvPcxg4ytbDPiZ7+rKo+tjJFmsg==
X-Received: by 2002:a17:902:f814:b0:161:505d:a4f4 with SMTP id ix20-20020a170902f81400b00161505da4f4mr18539665plb.6.1652853491650;
        Tue, 17 May 2022 22:58:11 -0700 (PDT)
Received: from localhost.localdomain (n058152048195.netvigator.com. [58.152.48.195])
        by smtp.gmail.com with ESMTPSA id cp16-20020a170902e79000b0015e8d4eb2c2sm627127plb.268.2022.05.17.22.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 22:58:11 -0700 (PDT)
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
Subject: [PATCH v3 04/11] perf mem: Add statistics for peer snooping
Date:   Wed, 18 May 2022 13:57:22 +0800
Message-Id: <20220518055729.1869566-5-leo.yan@linaro.org>
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

Since the flag PERF_MEM_SNOOPX_PEER is added to support cache snooping
from peer cache line, it can come from a peer core, a peer cluster, or
a remote NUMA node.

This patch adds statistics for the flag PERF_MEM_SNOOPX_PEER.  Note, we
take PERF_MEM_SNOOPX_PEER as an affiliated info, it needs to cooperate
with cache level statistics.  Therefore, we account the load operations
for both the cache level's metrics (e.g. ld_l2hit, ld_llchit, etc.) and
the metric 'ld_peer' when flag PERF_MEM_SNOOPX_PEER is set.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/util/mem-events.c | 22 +++++++++++++++++++---
 tools/perf/util/mem-events.h |  1 +
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 5dca1882c284..9de0eb3a1200 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -525,6 +525,7 @@ int c2c_decode_stats(struct c2c_stats *stats, struct mem_info *mi)
 	u64 op     = data_src->mem_op;
 	u64 lvl    = data_src->mem_lvl;
 	u64 snoop  = data_src->mem_snoop;
+	u64 snoopx = data_src->mem_snoopx;
 	u64 lock   = data_src->mem_lock;
 	u64 blk    = data_src->mem_blk;
 	/*
@@ -567,18 +568,28 @@ do {				\
 			if (lvl & P(LVL, IO))  stats->ld_io++;
 			if (lvl & P(LVL, LFB)) stats->ld_fbhit++;
 			if (lvl & P(LVL, L1 )) stats->ld_l1hit++;
-			if (lvl & P(LVL, L2 )) stats->ld_l2hit++;
+			if (lvl & P(LVL, L2)) {
+				stats->ld_l2hit++;
+
+				if (snoopx & P(SNOOPX, PEER))
+					stats->ld_peer++;
+			}
 			if (lvl & P(LVL, L3 )) {
 				if (snoop & P(SNOOP, HITM))
 					HITM_INC(lcl_hitm);
 				else
 					stats->ld_llchit++;
+
+				if (snoopx & P(SNOOPX, PEER))
+					stats->ld_peer++;
 			}
 
 			if (lvl & P(LVL, LOC_RAM)) {
 				stats->lcl_dram++;
 				if (snoop & P(SNOOP, HIT))
 					stats->ld_shared++;
+				else if (snoopx & P(SNOOPX, PEER))
+					stats->ld_peer++;
 				else
 					stats->ld_excl++;
 			}
@@ -597,10 +608,14 @@ do {				\
 		if ((lvl & P(LVL, REM_CCE1)) ||
 		    (lvl & P(LVL, REM_CCE2)) ||
 		     mrem) {
-			if (snoop & P(SNOOP, HIT))
+			if (snoop & P(SNOOP, HIT)) {
 				stats->rmt_hit++;
-			else if (snoop & P(SNOOP, HITM))
+			} else if (snoop & P(SNOOP, HITM)) {
 				HITM_INC(rmt_hitm);
+			} else if (snoopx & P(SNOOPX, PEER)) {
+				stats->rmt_hit++;
+				stats->ld_peer++;
+			}
 		}
 
 		if ((lvl & P(LVL, MISS)))
@@ -661,6 +676,7 @@ void c2c_add_stats(struct c2c_stats *stats, struct c2c_stats *add)
 	stats->ld_l1hit		+= add->ld_l1hit;
 	stats->ld_l2hit		+= add->ld_l2hit;
 	stats->ld_llchit	+= add->ld_llchit;
+	stats->ld_peer		+= add->ld_peer;
 	stats->lcl_hitm		+= add->lcl_hitm;
 	stats->rmt_hitm		+= add->rmt_hitm;
 	stats->tot_hitm		+= add->tot_hitm;
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 8a8b568baeee..4879b841c841 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -75,6 +75,7 @@ struct c2c_stats {
 	u32	ld_l1hit;            /* count of loads that hit L1D */
 	u32	ld_l2hit;            /* count of loads that hit L2D */
 	u32	ld_llchit;           /* count of loads that hit LLC */
+	u32	ld_peer;             /* count of loads that hit peer core or cluster cache */
 	u32	lcl_hitm;            /* count of loads with local HITM  */
 	u32	rmt_hitm;            /* count of loads with remote HITM */
 	u32	tot_hitm;            /* count of loads with local and remote HITM */
-- 
2.25.1

