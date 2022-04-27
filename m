Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1633512051
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240499AbiD0Pzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240476AbiD0Pxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:53:50 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE0755203
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:50:33 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m14-20020a17090a34ce00b001d5fe250e23so2085685pjf.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ds190eK1hF3mnV/9rzLoVn8f2hvZpOofdeWPJk4Nig=;
        b=DJ8WK8/MfkEWAxkzOYR0O+uGljGuI6lUvURUjar+hVr531fZ20WDuUUZoCCZUnDv3k
         UulRnJtX6ZIljWuh2oGp8i20qQCW82/ZwrA65HUyfWT5Pg16UOBvSI2adM7DUc23OCu/
         NVPvLaQakLyrfiBYxOy8p37SYYw3pjbdZn4gFXFKopiADnn4nScI4MIaXBT0j5V2534K
         Bw31wIR0CDeGO1R/3jiwtLer56JFk1cbKjbEPVrn3xTVMDmg7+2ROzcz5BNBTmHrmw9b
         ZOkRADL30ZX0l2qglgA+lvjDTBwCNCsNQsAZkz+sW1NJBWkvnwmr3QAISeSkQvsvYEny
         j1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ds190eK1hF3mnV/9rzLoVn8f2hvZpOofdeWPJk4Nig=;
        b=REVB1w02t6oN/P8jPnqDuMqc4t4nAh73z/m9CQn3k0JFSZ9XVKivx3sOzyQS57NmXl
         QmQybAhcQeSejv3d9l3+R+EWR2T7H8F7Jkg+Vu+1Th3mENVY3Y0MFucOL3Z8G2nw7RVp
         c77kKbbWgtTHls8GYdpfPNCzmaKyomkRTPar89rN4hgs98J+ows8hhINBEiKz+nr0Log
         sAYMB/+EzeGwrB8DFPnygz6JnNfBN8M7QQNl4evtEZILF/6MceYwkW38ailz057ueDNv
         ts//Delotk9N5R1c5Puiv12CdVvCMUruPCsRs7tFchNgP2eI5TcvVgjFMfiFezODCpBt
         /hJA==
X-Gm-Message-State: AOAM533djM5BQOSEsaeFE7YhQwmkG2BktWJ2uILxC3l2wdpII8D1WyB7
        1QFO2H10qBA5Tfz0prEYmV1cwy2uLrqM7tXX
X-Google-Smtp-Source: ABdhPJxs9q+KRD6xkQQHFqJA5vSQD4CDnrT/aXmHWfAnqz6ngaQaPxqetFe3TYdkynsX8FdMQojCRQ==
X-Received: by 2002:a17:903:24f:b0:15c:e3b8:a640 with SMTP id j15-20020a170903024f00b0015ce3b8a640mr23410022plh.5.1651074632710;
        Wed, 27 Apr 2022 08:50:32 -0700 (PDT)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id v65-20020a626144000000b0050a839e490bsm19164127pfb.185.2022.04.27.08.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:50:32 -0700 (PDT)
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
Subject: [PATCH v1 01/11] perf mem: Add any cache level statistics for store operation
Date:   Wed, 27 Apr 2022 23:50:03 +0800
Message-Id: <20220427155013.1833222-2-leo.yan@linaro.org>
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

Sometimes we don't know memory store operations happen on exactly which
cache level, so set the memory level flag PERF_MEM_LVLNUM_ANY_CACHE for
this case.  An usage case is that Arm SPE trace data sets this flag for
all the store operations due to we have no sufficient info for cache
level.

This patch is to add a new item "st_anylvl" in structure c2c_stats so
that support any cache level statistics for store operations.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/util/mem-events.c | 4 ++++
 tools/perf/util/mem-events.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index db5225caaabe..bfbac365e1e4 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -527,6 +527,7 @@ int c2c_decode_stats(struct c2c_stats *stats, struct mem_info *mi)
 	u64 snoop  = data_src->mem_snoop;
 	u64 lock   = data_src->mem_lock;
 	u64 blk    = data_src->mem_blk;
+	u64 lvl_num = data_src->mem_lvl_num;
 	/*
 	 * Skylake might report unknown remote level via this
 	 * bit, consider it when evaluating remote HITMs.
@@ -621,6 +622,8 @@ do {				\
 		}
 		if (lvl & P(LVL, MISS))
 			if (lvl & P(LVL, L1)) stats->st_l1miss++;
+		if (lvl_num == P(LVLNUM, ANY_CACHE))
+			stats->st_anylvl++;
 	} else {
 		/* unparsable data_src? */
 		stats->noparse++;
@@ -647,6 +650,7 @@ void c2c_add_stats(struct c2c_stats *stats, struct c2c_stats *add)
 	stats->st_noadrs	+= add->st_noadrs;
 	stats->st_l1hit		+= add->st_l1hit;
 	stats->st_l1miss	+= add->st_l1miss;
+	stats->st_anylvl	+= add->st_anylvl;
 	stats->load		+= add->load;
 	stats->ld_excl		+= add->ld_excl;
 	stats->ld_shared	+= add->ld_shared;
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 916242f8020a..e0e8057c52e8 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -63,6 +63,7 @@ struct c2c_stats {
 	u32	st_noadrs;           /* cacheable store with no address */
 	u32	st_l1hit;            /* count of stores that hit L1D */
 	u32	st_l1miss;           /* count of stores that miss L1D */
+	u32	st_anylvl;           /* count of stores with any cache level */
 	u32	load;                /* count of all loads in trace */
 	u32	ld_excl;             /* exclusive loads, rmt/lcl DRAM - snp none/miss */
 	u32	ld_shared;           /* shared loads, rmt/lcl DRAM - snp hit */
-- 
2.25.1

