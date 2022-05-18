Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3CF52B20C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiERF6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 01:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiERF56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 01:57:58 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460AB427C7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 22:57:57 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id nr2-20020a17090b240200b001df2b1bfc40so4610691pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 22:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R3Yh9OX4NzFrM6RxjNS5jxXjJZrys2g1AGRWw+4sxiM=;
        b=Q9kNuOfARJjI7J2EZ3CQdmbELpBY7kE9qwf16TgG7SyMG/EaO482O2dRGzygG3Qba3
         hN3UHWLkcxibOZ5vWaDprr/jh1M3P98J5SrkRAQDrSvytLP/PJnff4jxR27ofiKkNw14
         DtUaPf9Y4TAYD/zj53xxWh5Jep2wNitoQppJza/b5i7O61rYhAt/8H4HKA+Wj0ouUbiU
         6mT9ceOkJcgQlVm0qOUD6aOoassvRQ4x/cqKOylEm6aNfhfDfo2ZirhUScfFy5ZSyc3T
         s4YdGZJu7vE97vS3Ey21S9XYvoqcQy7RVDuPH8m9jb51AV1Vnz1BtgVnqgJwEfuFQ6CW
         Nqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R3Yh9OX4NzFrM6RxjNS5jxXjJZrys2g1AGRWw+4sxiM=;
        b=0IYfryQgNtRhKdN5sAq5XV/JC8KegSPmeotYVfnVUYJW2+UsPe/hxVckEuy5NhN/uP
         iopmMA5OPsxAs8OAHcmVeVkl5VhPlCgRffwouAsfTIuPQ4FGjmZ5L34nuIMh1yF37bc0
         LhljRMIUb2Aj0VXmQUzrk8HtZaip5c3SxGHqFWtrYts3dn26S+Jb2CZ4zX3WetzpscBR
         UgzS14sq4LNfbQZo5WbKxps7L9VbLifmukV0bkZwD0o7CXOURbJ60m4kmI5dVoJd08rS
         pMXBSpFzov5Vws+f8U1YboHQpR83DXAyiusj8nKGkHE7AjnFZwCVYJ4fyeFN9eEhKlYm
         QDVg==
X-Gm-Message-State: AOAM531UaKCFMj6AF8eDFPnDoAnstpyAu3qmOSJ9Z9V5ScPlXMJGl+jB
        ZSeeuL6Dxn2TWsK2V0A79MrnTw==
X-Google-Smtp-Source: ABdhPJzPngsGLuQdR64JeGW2aemQuom6mDEtOMNq065AcCRk3pQugE+b2l8ky5d8GPhVnfdT6j2e1A==
X-Received: by 2002:a17:90b:4b48:b0:1de:af4f:7e13 with SMTP id mi8-20020a17090b4b4800b001deaf4f7e13mr28275660pjb.146.1652853476613;
        Tue, 17 May 2022 22:57:56 -0700 (PDT)
Received: from localhost.localdomain (n058152048195.netvigator.com. [58.152.48.195])
        by smtp.gmail.com with ESMTPSA id cp16-20020a170902e79000b0015e8d4eb2c2sm627127plb.268.2022.05.17.22.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 22:57:56 -0700 (PDT)
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
Subject: [PATCH v3 01/11] perf mem: Add stats for store operation with no available memory level
Date:   Wed, 18 May 2022 13:57:19 +0800
Message-Id: <20220518055729.1869566-2-leo.yan@linaro.org>
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

