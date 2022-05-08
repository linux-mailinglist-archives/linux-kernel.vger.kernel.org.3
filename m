Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D1951EC76
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 11:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiEHJ3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 05:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiEHJ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 05:28:55 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA18E0F7
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 02:24:52 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id k14so9698013pga.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 02:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5BXrzgVYvBGmdSlnVtQEfhW9GvqhlJo5cHBeUasgrT0=;
        b=m/cdnGfmFdCyz4qMJ0TDedpp4hXKvP4FdzdgVPwdRA1JPMyl3HH2PXSs/zqmjUK8Yj
         j8LLh7IwZZE2asbvtbREP1KYtwMzE8ZaIAOZHKe13HpEeROLSUxD29VQZ753AAcupuPr
         4WXZeM+Agimptk0ri1iS7S/VTB5ON/yhUDfGxeGixUP8diFW0gPYwMd94tk3VDrpDsHp
         fclXv5S2hWlTszfCAm+rHAUmOqVkXBPbcAvKR7bHveM+VZ4yw+kgDE8nEojKhPZ2R+R4
         HY4/stC/o9G1CJPbZ3bIZabeWDJTmg5ddkgT7zoW+JEn2QGhfID6UE+FGnJr0Agy67zo
         8mWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5BXrzgVYvBGmdSlnVtQEfhW9GvqhlJo5cHBeUasgrT0=;
        b=VXUNnP3xfDhEh/b/H43cDwsu8RIyd8A6k8HSTqBSRD8rQBIVnnT8d54Ye5EpvW0mJe
         DbPsnwEDJBYEm+QzD9OY0ooH15b52A82ahvaNJNcKrgBzG1Ira1OK6HKW9FkoDVYitZe
         RNxXrJmcWwau8l2a+mHO2WPwAs4ozyhPRviHFqb/fehE6QVXs6JEruv4uOHSFX6jM5ij
         XC0pPy4elWasRaN+jCaxrAaZpSpRK1H6YANopVeNZ7200m5GJNXyH/wj2rlNrpEZReEy
         jMG+MpnF0VljaVVQyhZ9oWNvwMeXSEprbH220BAgdKGBVLdgM79LL1JmZUpv5BtV3OJL
         k4Kg==
X-Gm-Message-State: AOAM532u/HxRSWDS5WcWMd6SnuzHMgFGM2fpYzNFbqPqgLvrjPwLW/7k
        Yn+5cUy7eHh2Ve4u4jj8X5TEiQ==
X-Google-Smtp-Source: ABdhPJxOaWtOaVBRUtO1R715aj1dzFF6MiY8rXICAcPeEyvZK4qcijUvkS/3X+ACJ2ULeHrFJ0ha7Q==
X-Received: by 2002:a05:6a00:ad0:b0:4e1:2d96:2ab0 with SMTP id c16-20020a056a000ad000b004e12d962ab0mr11095296pfl.3.1652001891834;
        Sun, 08 May 2022 02:24:51 -0700 (PDT)
Received: from localhost.localdomain (104-237-153-19.ip.linodeusercontent.com. [104.237.153.19])
        by smtp.gmail.com with ESMTPSA id t63-20020a638142000000b003c14af505f7sm6155088pgd.15.2022.05.08.02.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 02:24:51 -0700 (PDT)
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
Subject: [PATCH v2 04/11] perf mem: Add statistics for peer snooping
Date:   Sun,  8 May 2022 17:23:39 +0800
Message-Id: <20220508092346.255826-5-leo.yan@linaro.org>
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

Since we have added the flag PERF_MEM_SNOOPX_PEER to support cache
snooping from peer core or cluster, this patch is to add statistics for
this new flag.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/util/mem-events.c | 11 ++++++++++-
 tools/perf/util/mem-events.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 5dca1882c284..6cd2b6ffb4a4 100644
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
@@ -567,10 +568,17 @@ do {				\
 			if (lvl & P(LVL, IO))  stats->ld_io++;
 			if (lvl & P(LVL, LFB)) stats->ld_fbhit++;
 			if (lvl & P(LVL, L1 )) stats->ld_l1hit++;
-			if (lvl & P(LVL, L2 )) stats->ld_l2hit++;
+			if (lvl & P(LVL, L2)) {
+				if (snoopx & P(SNOOPX, PEER))
+					stats->ld_peer++;
+				else
+					stats->ld_l2hit++;
+			}
 			if (lvl & P(LVL, L3 )) {
 				if (snoop & P(SNOOP, HITM))
 					HITM_INC(lcl_hitm);
+				else if (snoopx & P(SNOOPX, PEER))
+					stats->ld_peer++;
 				else
 					stats->ld_llchit++;
 			}
@@ -661,6 +669,7 @@ void c2c_add_stats(struct c2c_stats *stats, struct c2c_stats *add)
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

