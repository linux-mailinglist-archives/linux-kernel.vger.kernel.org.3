Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936C258F791
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 08:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiHKGZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 02:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbiHKGZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:25:30 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CAE647B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:25:28 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h132so16330479pgc.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ebMhPOgPdxNfvlY85+nAZskPxRzP2ghlEVJJ1E1oyUc=;
        b=vj9+6oNnAi7uLqVKvvMGh2qAuSjp1ErBI/z4QkxS5D1mIKOVqQ259VuKC6/0hlY/9V
         54Ckua2g5EXMPdwrUj/XqyYixTXD0Fi1iqFNgUsqoYCExmqiXKHY4PymYTlnAQNX5YOd
         3C659mNeoN3eI5I7M3sWh2CC451jQaAmO6kM9blCCp7RDwsP4Iffxa+FryTx02HgcB66
         ollVh+NB9qlEa0sZQjwlRJwDVme+09R1DE8fcpQMvKbTR8naT0zIAOWOggL+EJxmRLJM
         5W5qFCUAEWS3gJ/8zPoHRoXgYX0JZfvf9Kyv3MisJaFp0Wk8tLsMNCzy6LQhuv2i2eRs
         wQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ebMhPOgPdxNfvlY85+nAZskPxRzP2ghlEVJJ1E1oyUc=;
        b=QfgtzvjEMaIT3itswO8DSR56hqKpOLuEMFhkZBuwuBs2nu+cWul83Ae1R+ehOO6HJD
         nccGGhL28HPf3AZ8B30qEXZBsncBt12ozD6bbr0/ZpoxJDCWrccKCmXm+14mUVFPJEdB
         pZl6Cv6eI1MNv0GQBzxy+2jv/vzQ6zqW4ROBPggpxDh4bRl/UNraJgqw8OeSGNrsCkAK
         dCzA1YgBv9YWMvGgV8bRXQL5rRbVDc3GHKszehXB088MUUzlihf053eWhZ1j8MRtftY7
         cBPxDD4eyjGh+1Y6914fvcr1cdGTvBK6afQBpxcnoMO3fe05vtA0Um5TAzAfpvm+sV45
         wolA==
X-Gm-Message-State: ACgBeo2Hds2ZE6ErKRY46TSjECiuquPXDMxkV0wAuhZi1+8zdl96+YYy
        c/fC17TX5zD/HrR+hfsw0ZxDtA==
X-Google-Smtp-Source: AA6agR4/PjCm08YMwDXbKhFnNdjaP+vD0p4+ZpfjsSbJ4s+1+1ac1j2kkTAC6YPSAF8bgIh3nr+BfQ==
X-Received: by 2002:a63:1e11:0:b0:41c:d233:31f8 with SMTP id e17-20020a631e11000000b0041cd23331f8mr25650950pge.228.1660199127837;
        Wed, 10 Aug 2022 23:25:27 -0700 (PDT)
Received: from leoy-yangtze.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090a55cc00b001f506009036sm2766926pjm.49.2022.08.10.23.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 23:25:27 -0700 (PDT)
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
Subject: [PATCH v6 04/15] perf mem: Add statistics for peer snooping
Date:   Thu, 11 Aug 2022 14:24:40 +0800
Message-Id: <20220811062451.435810-5-leo.yan@linaro.org>
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

Since the flag PERF_MEM_SNOOPX_PEER is added to support cache snooping
from peer cache line, it can come from a peer core, a peer cluster, or
a remote NUMA node.

This patch adds statistics for the flag PERF_MEM_SNOOPX_PEER.  Note, we
take PERF_MEM_SNOOPX_PEER as an affiliated info, it needs to cooperate
with cache level statistics.  Therefore, we account the load operations
for both the cache level's metrics (e.g. ld_l2hit, ld_llchit, etc.) and
peer related metrics when flag PERF_MEM_SNOOPX_PEER is set.

So three new metrics are introduced: 'lcl_peer' is for local cache
access, the metric 'rmt_peer' is for remote access (includes remote DRAM
and any caches in remote node), and the metric 'tot_peer' is accounting
the sum value of 'lcl_peer' and 'rmt_peer'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Ian Rogers <irogers@google.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/util/mem-events.c | 28 +++++++++++++++++++++++++---
 tools/perf/util/mem-events.h |  3 +++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 5dca1882c284..764883183519 100644
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
@@ -544,6 +545,12 @@ do {				\
 	stats->tot_hitm++;	\
 } while (0)
 
+#define PEER_INC(__f)		\
+do {				\
+	stats->__f++;		\
+	stats->tot_peer++;	\
+} while (0)
+
 #define P(a, b) PERF_MEM_##a##_##b
 
 	stats->nr_entries++;
@@ -567,12 +574,20 @@ do {				\
 			if (lvl & P(LVL, IO))  stats->ld_io++;
 			if (lvl & P(LVL, LFB)) stats->ld_fbhit++;
 			if (lvl & P(LVL, L1 )) stats->ld_l1hit++;
-			if (lvl & P(LVL, L2 )) stats->ld_l2hit++;
+			if (lvl & P(LVL, L2)) {
+				stats->ld_l2hit++;
+
+				if (snoopx & P(SNOOPX, PEER))
+					PEER_INC(lcl_peer);
+			}
 			if (lvl & P(LVL, L3 )) {
 				if (snoop & P(SNOOP, HITM))
 					HITM_INC(lcl_hitm);
 				else
 					stats->ld_llchit++;
+
+				if (snoopx & P(SNOOPX, PEER))
+					PEER_INC(lcl_peer);
 			}
 
 			if (lvl & P(LVL, LOC_RAM)) {
@@ -597,10 +612,14 @@ do {				\
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
+				PEER_INC(rmt_peer);
+			}
 		}
 
 		if ((lvl & P(LVL, MISS)))
@@ -664,6 +683,9 @@ void c2c_add_stats(struct c2c_stats *stats, struct c2c_stats *add)
 	stats->lcl_hitm		+= add->lcl_hitm;
 	stats->rmt_hitm		+= add->rmt_hitm;
 	stats->tot_hitm		+= add->tot_hitm;
+	stats->lcl_peer		+= add->lcl_peer;
+	stats->rmt_peer		+= add->rmt_peer;
+	stats->tot_peer		+= add->tot_peer;
 	stats->rmt_hit		+= add->rmt_hit;
 	stats->lcl_dram		+= add->lcl_dram;
 	stats->rmt_dram		+= add->rmt_dram;
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 8a8b568baeee..12372309d60e 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -78,6 +78,9 @@ struct c2c_stats {
 	u32	lcl_hitm;            /* count of loads with local HITM  */
 	u32	rmt_hitm;            /* count of loads with remote HITM */
 	u32	tot_hitm;            /* count of loads with local and remote HITM */
+	u32	lcl_peer;            /* count of loads with local peer cache */
+	u32	rmt_peer;            /* count of loads with remote peer cache */
+	u32	tot_peer;            /* count of loads with local and remote peer cache */
 	u32	rmt_hit;             /* count of loads with remote hit clean; */
 	u32	lcl_dram;            /* count of loads miss to local DRAM */
 	u32	rmt_dram;            /* count of loads miss to remote DRAM */
-- 
2.34.1

