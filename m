Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73448537A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbiE3LlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235806AbiE3LlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:41:06 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6E4419A3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:41:05 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d22so10085646plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jjmrioi65tdvpnatZVOByjLto3yXdnCU74U03aRx/ek=;
        b=dbovKyStqncZhviVmQ4s01Kz4FWR7dngHlpCcH+X9FLPjv/wnbG94Ns4SYZB8YCW1r
         dU16yO4rVV/AAV/zVo9MtcFm/zmkItHUiqgbfAecAc6vLKDa7r+YXq0Fs+eF0P3QDvuB
         lhjIdpJZK9zEL4cQCTrFRJ65n+NdLrx5xN0zFAzVZqZgU8ov04EZh0dYaKO6BJ3+X5hA
         XUhKYk3QN/g7FKLze2o8VxViadQaYKmQyxbB0eulrQb8U3oBv2k9FrJWJ26JdOrJa0c3
         lfkiZaJ8rcnhBcOMue1KIeNIAiWjCMTRSbaDQRknQrPWkYtE+l/KOuIfJeCjC9QdE21Q
         9viQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jjmrioi65tdvpnatZVOByjLto3yXdnCU74U03aRx/ek=;
        b=PnTNoWVMHu938W4GwpVYoh9a/0QZgQgjECeRYSldRFes4qYotDy7oQhZumr1f4k3RW
         KtWvtxImQEOPG6EYV21ge62eBtDZ1hLaIZoQOxleU/3zHHBnP2RulTvbwHLmyok/EAmz
         douji26z5XYFOTboS4xwKn+EZNIlSo37sR8i6fYaRQZsFj0yD9E30ERJTN7+8VOsITAF
         IReaYw0xw1wzk2Xm8+plkhM72qLioLXJKIKRSJuVpHW39hIWgxmGhBJY3EudLz/xk4nF
         zXzZ0FwISlQDdvgaqQNeRInfIKorBDc6BdAtOIDyEgkk9kABQMWlv9kdNAb6Ad75wml5
         qdUQ==
X-Gm-Message-State: AOAM532z6hyRfyRl6l981953iZTO4NN9EU/bEg4tvch9Qa8GFEyOq9IF
        +yKykWZ2xBbOO04V66Y5yoWwUw==
X-Google-Smtp-Source: ABdhPJzcu2PXhaLkP/I7hnZpbOEuiIqD4SEi5tXzqvqWMLMUzV3tk7gJxBQRR3kWPrSNQJX+wi1oPQ==
X-Received: by 2002:a17:902:ec85:b0:161:cff5:17c8 with SMTP id x5-20020a170902ec8500b00161cff517c8mr56097594plg.62.1653910864468;
        Mon, 30 May 2022 04:41:04 -0700 (PDT)
Received: from leo-build-box.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902724700b00161a9df4de8sm8846194pll.145.2022.05.30.04.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 04:41:04 -0700 (PDT)
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
Subject: [PATCH v4 01/12] perf mem: Add statistics for peer snooping
Date:   Mon, 30 May 2022 19:40:25 +0800
Message-Id: <20220530114036.3225544-2-leo.yan@linaro.org>
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
2.25.1

