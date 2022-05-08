Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56A051EC73
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 11:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiEHJ2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 05:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiEHJ2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 05:28:11 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668CBE024
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 02:24:21 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id bo5so9860381pfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 02:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R3Yh9OX4NzFrM6RxjNS5jxXjJZrys2g1AGRWw+4sxiM=;
        b=L4aZnxorx/5K/FyzCOaMHHqDwYoXCyPffirpg0K/9WeDHWfajrXwsrMWutnDbImL7l
         iq1vyg5TEd9ikVUAPyJa6VAYUbvw476mXhzVBvA6cxj9NI9xqQl+HTudKf7aqR/nIZux
         Uqbq1Mpxy5jdPUmXTrXmD+XqG77VEdOD8766V2kk2oz8zTdj5Yh0Q2w4prglJuOmbPsn
         eyvltP5lKuWV62LmTo4o3C9N9/uA4rF0bxNE9kTQwHjxN0Y1YWKV8GNBDaT4/Jrz7QI0
         M3ncfb3tBn7IRLzQ51pMwSHgT1Xw/aRoXTlcPnlFd3bwUuN0wmItkHY/q2eCwdlFaIP1
         pg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R3Yh9OX4NzFrM6RxjNS5jxXjJZrys2g1AGRWw+4sxiM=;
        b=DMUcnoxfxIH+UYrmlUb+3oG5fzlEbMDxkvdc5qdRn1OyR0T8eswXwwX3rwFXdbnPjd
         SyLR7cr4qbR1Fc52tI2zyT6CLCINGpMlDAwTEymltp++AARhiIuy16H859Yo6kXlQxja
         MAy3ROJcK+/MbX8By6lfnOCxfihs8LODB+ehMd9pWisfY0y/2ChrC2zwTA8M/YmhvicE
         E4uulmmkXrt18zsrSW1kkZQsY+7YBaK5iKo1L9l2AErsS5uXJyqV8FHWqSvbywXypKO1
         AzDM5dDds+f+WHRdHPdcuRkBAqSIrZnbVQKLyBAV+eAq6pcztCdRpnNROSY+EpCmZwGH
         6Ong==
X-Gm-Message-State: AOAM531CYJ+bqFLYfp6662JDoNepRMTW3xKZ7fioC43wTEkuk2d9/wYt
        AN9uk54JYiOazWPBCvXcppOYbA==
X-Google-Smtp-Source: ABdhPJwSzCeWNy6Ymqaq6+EvL9I5Yp5OEdF3qIuc/kEa+YbQ8tadZpsCQGbYQMVn7ElcZrDXN1bc0w==
X-Received: by 2002:a65:6e0d:0:b0:3c6:12af:15b4 with SMTP id bd13-20020a656e0d000000b003c612af15b4mr9084353pgb.338.1652001860809;
        Sun, 08 May 2022 02:24:20 -0700 (PDT)
Received: from localhost.localdomain (104-237-153-19.ip.linodeusercontent.com. [104.237.153.19])
        by smtp.gmail.com with ESMTPSA id t63-20020a638142000000b003c14af505f7sm6155088pgd.15.2022.05.08.02.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 02:24:20 -0700 (PDT)
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
Subject: [PATCH v2 01/11] perf mem: Add stats for store operation with no available memory level
Date:   Sun,  8 May 2022 17:23:36 +0800
Message-Id: <20220508092346.255826-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508092346.255826-1-leo.yan@linaro.org>
References: <20220508092346.255826-1-leo.yan@linaro.org>
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

Sometimes we don't know memory store operations happen on exactly which
memory (or cache) level, the memory level flag is set to PERF_MEM_LVL_NA
in this case; a practical example is Arm SPE AUX trace sets this flag
for all store operations due to absent info for cache level.

This patch is to add a new item "st_na" in structure c2c_stats to add
statistics for store operations with no available cache level.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/mem-events.c | 3 +++
 tools/perf/util/mem-events.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index db5225caaabe..5dca1882c284 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -621,6 +621,8 @@ do {				\
 		}
 		if (lvl & P(LVL, MISS))
 			if (lvl & P(LVL, L1)) stats->st_l1miss++;
+		if (lvl & P(LVL, NA))
+			stats->st_na++;
 	} else {
 		/* unparsable data_src? */
 		stats->noparse++;
@@ -647,6 +649,7 @@ void c2c_add_stats(struct c2c_stats *stats, struct c2c_stats *add)
 	stats->st_noadrs	+= add->st_noadrs;
 	stats->st_l1hit		+= add->st_l1hit;
 	stats->st_l1miss	+= add->st_l1miss;
+	stats->st_na		+= add->st_na;
 	stats->load		+= add->load;
 	stats->ld_excl		+= add->ld_excl;
 	stats->ld_shared	+= add->ld_shared;
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 916242f8020a..8a8b568baeee 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -63,6 +63,7 @@ struct c2c_stats {
 	u32	st_noadrs;           /* cacheable store with no address */
 	u32	st_l1hit;            /* count of stores that hit L1D */
 	u32	st_l1miss;           /* count of stores that miss L1D */
+	u32	st_na;               /* count of stores with memory level is not available */
 	u32	load;                /* count of all loads in trace */
 	u32	ld_excl;             /* exclusive loads, rmt/lcl DRAM - snp none/miss */
 	u32	ld_shared;           /* shared loads, rmt/lcl DRAM - snp hit */
-- 
2.25.1

