Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB85F537A10
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiE3Ll1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbiE3LlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:41:14 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F46813E9
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:41:10 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g67so2337943pfb.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h8h+dOa5UXWEE0M1AXGeUja2PScbi3m/14Ye0UYGzpI=;
        b=aOe0sxeZZ3mOj0Cr7eUZd6cMma69nGUO55Otyh2VVIlBOWRgpcdeLZEafs83PKh/VL
         vtBOZ6xDlWoUF46lwZxNIPPnc+Ekd2iHetayug+sfRdpqIHIzBja5IVBCsPPw0bBNeqJ
         yc9oh4u5n87wPvgsND0bnmTKbFy6ysJbylSQtmbvJS2jteohoTzKC4NMlZFMMZApv+rX
         d7iMQTf+6STuriEOFXYUdT303pf6G8e2SZtDd3z1C+9f0cnkr3nRjP2TWtRABc6H8nRC
         Oz3cv/7NYRKpgIPE8AuRF2gVB0t/+hksPqrotZo33wKMK4m+UKIAiyqmPQvil0eHS8aP
         5ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h8h+dOa5UXWEE0M1AXGeUja2PScbi3m/14Ye0UYGzpI=;
        b=Pvf/6FsV3rAOTMRZR8akvAbu3q6aL/E5OZXGJU1tviDIQB7I5y6AAbp2KPMFo1Ld97
         zNHl5j+ULPIOjT4U5D5r+V3kc0ZPdepsAsrmGbA9CYXnjKoST2C4A82FUFqsv+6X+5LF
         LMNRI7seeX1yKm5VbCnRUSTpSXMYGMJCz7FSDmrWfWcoet/AoavZOtd9MCqE0DsUASAr
         KdAfsKuTIEVpJPg5f/JA5IpyYWnj0HZewPsTqsKr9xGayoJXzYPcwT+F8YN/yQcaZZzi
         ER3npPRxOApxHWy5fzGvtC1l/xAEaJcP2NSiKDvumiPKj+08uil3jWmR6CjkZQtdzbDV
         LAjA==
X-Gm-Message-State: AOAM530GeYHLwQfQ7VeQgXt5xtsrj9p0cZ3fRH3Y/H69f8MRnc0B3Rs8
        Vd7ENBN/K8/425xlEJB46Wzn2g==
X-Google-Smtp-Source: ABdhPJyyY2z+LEUijMFV1bpmsqO0SFh/jX4VeU6hiEEwV+q9m0sYnCVjVpbejR2vwdIPBTX457L7wQ==
X-Received: by 2002:a05:6a00:2402:b0:4e1:46ca:68bd with SMTP id z2-20020a056a00240200b004e146ca68bdmr56506321pfh.70.1653910869257;
        Mon, 30 May 2022 04:41:09 -0700 (PDT)
Received: from leo-build-box.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902724700b00161a9df4de8sm8846194pll.145.2022.05.30.04.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 04:41:09 -0700 (PDT)
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
Subject: [PATCH v4 02/12] perf c2c: Output statistics for peer snooping
Date:   Mon, 30 May 2022 19:40:26 +0800
Message-Id: <20220530114036.3225544-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220530114036.3225544-1-leo.yan@linaro.org>
References: <20220530114036.3225544-1-leo.yan@linaro.org>
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

This patch outputs statistics for peer snooping for whole trace events
and global shared cache line.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index e8280973d7b8..ac389432c15f 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2202,6 +2202,8 @@ static void print_c2c__display_stats(FILE *out)
 	fprintf(out, "  Load LLC Misses                   : %10d\n", llc_misses);
 	fprintf(out, "  Load access blocked by data       : %10d\n", stats->blk_data);
 	fprintf(out, "  Load access blocked by address    : %10d\n", stats->blk_addr);
+	fprintf(out, "  Load HIT Local Peer               : %10d\n", stats->lcl_peer);
+	fprintf(out, "  Load HIT Remote Peer              : %10d\n", stats->rmt_peer);
 	fprintf(out, "  LLC Misses to Local DRAM          : %10.1f%%\n", ((double)stats->lcl_dram/(double)llc_misses) * 100.);
 	fprintf(out, "  LLC Misses to Remote DRAM         : %10.1f%%\n", ((double)stats->rmt_dram/(double)llc_misses) * 100.);
 	fprintf(out, "  LLC Misses to Remote cache (HIT)  : %10.1f%%\n", ((double)stats->rmt_hit /(double)llc_misses) * 100.);
@@ -2230,6 +2232,7 @@ static void print_shared_cacheline_info(FILE *out)
 	fprintf(out, "  L1D hits on shared lines          : %10d\n", stats->ld_l1hit);
 	fprintf(out, "  L2D hits on shared lines          : %10d\n", stats->ld_l2hit);
 	fprintf(out, "  LLC hits on shared lines          : %10d\n", stats->ld_llchit + stats->lcl_hitm);
+	fprintf(out, "  Load hits on peer cache or nodes  : %10d\n", stats->lcl_peer + stats->rmt_peer);
 	fprintf(out, "  Locked Access on shared lines     : %10d\n", stats->locks);
 	fprintf(out, "  Blocked Access on shared lines    : %10d\n", stats->blk_data + stats->blk_addr);
 	fprintf(out, "  Store HITs on shared lines        : %10d\n", stats->store);
-- 
2.25.1

