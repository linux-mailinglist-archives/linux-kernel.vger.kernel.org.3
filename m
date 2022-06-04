Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448DB53D572
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350497AbiFDE3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350511AbiFDE3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:29:19 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A748B3C4B4
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 21:29:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n18so8142960plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 21:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cBhbTEYatQ8ux5y6Tpm1b5eQI3hSdv3I21ABVLF0r08=;
        b=dcvR1ANBqSOcKf51hqH6H0v6zOnzmnkR/oLFzoAEAvU13u0xKzrgHAQwuMri4diNgI
         mfWGPl+UjyyLTf2OBC5ws956ToQUq8dJWCAOWQ0ufXvdSA9AWIWDAMreOm0+bJa4FGXL
         aXmN6JhYPJvOivg4qDie7U7ICCUKwgQMIUCNCkyeWqQPteMm2CXUVNMETV0qy8uBCroW
         njfvK4WUhKEtmm8+HJIM/MP5y8KJrRopMBGF1tJMVKjLkbPEIdXEzDR+9aZPIF+Qf4E9
         ld/oajDzXRjaPEbNt3bRCMrNhIE+eVwIwiI27D0pqS0YuRmDmiK9clh4AsWzCBc3BQWx
         razA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cBhbTEYatQ8ux5y6Tpm1b5eQI3hSdv3I21ABVLF0r08=;
        b=K4IxW/+KdRfohg4iIt6tDEdEqeTKeaf5dvbtsfP/IiGRNMWPoQvpbRh1SSTNqNkLTh
         DgEW8aPeptU5cuPGuvYJ7q9hZ3bS08Zrsd40Eb25D1n9IOD9jmS1NFXQ+THyS5T9RbS/
         YStUX+1EmTaDpC8cbb2YKJLFMDstUz0/9CqBLrCWUAnBa7hXrjaLAPEfet1XdVYQwelJ
         F1dFoz11eyCGf4yZ1B1y0i1SCwowj0P1lRv/lCkzkQ9Wlul7wRijmstKGSLyZw0xvt4A
         hrDJ8XmsCWlYDdapPfX9JFBn27suUaFsQuGMI512s05nsh/jDWXeU412eqWOOvyl0GZw
         N7hw==
X-Gm-Message-State: AOAM532yhJy96BO55opgTYmA2aMcrirvm+qgUV01L8tPANSZs2z8wmbd
        3dVmhthur6CG1a0zgGRdYSMhow==
X-Google-Smtp-Source: ABdhPJyuff1MpGI19MYjeS04VgDFA9owXedQ5UnzZqdBdb8CRUrn0oriKxkV+W2Ki7Al6QxG3tm9sQ==
X-Received: by 2002:a17:90b:380b:b0:1e6:67f6:f70c with SMTP id mq11-20020a17090b380b00b001e667f6f70cmr16631863pjb.120.1654316957049;
        Fri, 03 Jun 2022 21:29:17 -0700 (PDT)
Received: from leo-build-box.lan (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm6152916pll.304.2022.06.03.21.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 21:29:16 -0700 (PDT)
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
Subject: [PATCH v5 06/17] perf mem: Add statistics for peer snooping
Date:   Sat,  4 Jun 2022 12:28:09 +0800
Message-Id: <20220604042820.2270916-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604042820.2270916-1-leo.yan@linaro.org>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
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
2.25.1

