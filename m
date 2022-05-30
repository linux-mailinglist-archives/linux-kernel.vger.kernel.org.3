Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F308E537A11
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbiE3Lld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbiE3LlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:41:15 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C8A813DD
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:41:14 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a10so1528037pju.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zq0qvzL6ixxtSc1desUKY/GqDh2eKKGtTiiw0hsNusc=;
        b=VfNAdhbV0jFONXt1B7SQddxTBFQ+3fSxQK1MzL3gKczosuKMmaGnbuJ9a5XDy+zBYY
         8dHnFNZh5ibfTj1W9lWoq6qntJ0g2/f8H+D1rTTpuYNBp38v9ZiuQsyDwOywdt9ADwzn
         tVN6mPTKpgfTnRgRFc8L0B7DV0iUlhx2SJ5RB0oWYVEy8+dfZ0t/l4Mo5om+PVkszw4X
         Lp1WAA4vqA170eTWV9Pza7ENN5IU+jfjjSkqKp1gu3E3NO2i4Z+YpiXcF5bRQikvYZ5o
         LCAHpWny63Kws0mggGZH/mvNpNIeFNuW14ZyvlRrcpRDvTghkomUWXIKmfBt6l/8BtUY
         6qaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zq0qvzL6ixxtSc1desUKY/GqDh2eKKGtTiiw0hsNusc=;
        b=7j8/EkfvcUVyLIBGE0GzENYVyW/Z81MduiWQqEBadGSvEVDbz9abzLP90pH48jVae9
         4N3RD9y09DV3rE6Fqag+tJgz6a9JdlkUgeTP1eXNMsVa7OSaVbZBhtZA1T3KY9V/MKue
         y+kUVLfv+I7/wRdqR5oHpqKzgCrgOYXlfKwqDx2FAXA49UPMwEouYlwu1A0n1GiSsQf7
         4B1v2DmukCluZFxWzYfsjH3JUA04yoWZs+QGjtXvGoaTl10PAYRrUDaaGFUCbvUHBsD+
         XJwIR7LM86VzWnpWZhLDLD/jdFNIhLJrr7ldzeOAXAyn2NbpSXBgIPG2uy/SjDLqM7u3
         J04Q==
X-Gm-Message-State: AOAM531p9AP8P62EmCk7IzzGvE9iMLHZDe2/PU4nPjSw5tADqcSZ2/f2
        2qKa3nVKS8FEpU0kaMp4nEt5Hg==
X-Google-Smtp-Source: ABdhPJx+K0aH11exUZTln+DH+rdVec4FwT6m0DdgBV/J+m62OQm/P2TGApRMgTML6BGJAd61DdYXDw==
X-Received: by 2002:a17:903:2282:b0:163:c6c8:65c3 with SMTP id b2-20020a170903228200b00163c6c865c3mr7956024plh.120.1653910874106;
        Mon, 30 May 2022 04:41:14 -0700 (PDT)
Received: from leo-build-box.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902724700b00161a9df4de8sm8846194pll.145.2022.05.30.04.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 04:41:13 -0700 (PDT)
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
Subject: [PATCH v4 03/12] perf c2c: Add dimensions for peer load operations
Date:   Mon, 30 May 2022 19:40:27 +0800
Message-Id: <20220530114036.3225544-4-leo.yan@linaro.org>
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

This patch adds three dimensions for peer load operations of 'lcl_peer',
'rmt_peer' and 'tot_peer'.  These three dimensions will be used in the
shared data cache line table.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index ac389432c15f..2d7991d372a6 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -650,6 +650,9 @@ __f ## _cmp(struct perf_hpp_fmt *fmt __maybe_unused,			\
 
 STAT_FN(rmt_hitm)
 STAT_FN(lcl_hitm)
+STAT_FN(rmt_peer)
+STAT_FN(lcl_peer)
+STAT_FN(tot_peer)
 STAT_FN(store)
 STAT_FN(st_l1hit)
 STAT_FN(st_l1miss)
@@ -1360,6 +1363,30 @@ static struct c2c_dimension dim_rmt_hitm = {
 	.width		= 7,
 };
 
+static struct c2c_dimension dim_tot_peer = {
+	.header		= HEADER_SPAN("------- Load Peer -------", "Total", 2),
+	.name		= "tot_peer",
+	.cmp		= tot_peer_cmp,
+	.entry		= tot_peer_entry,
+	.width		= 7,
+};
+
+static struct c2c_dimension dim_lcl_peer = {
+	.header		= HEADER_SPAN_LOW("Local"),
+	.name		= "lcl_peer",
+	.cmp		= lcl_peer_cmp,
+	.entry		= lcl_peer_entry,
+	.width		= 7,
+};
+
+static struct c2c_dimension dim_rmt_peer = {
+	.header		= HEADER_SPAN_LOW("Remote"),
+	.name		= "rmt_peer",
+	.cmp		= rmt_peer_cmp,
+	.entry		= rmt_peer_entry,
+	.width		= 7,
+};
+
 static struct c2c_dimension dim_cl_rmt_hitm = {
 	.header		= HEADER_SPAN("----- HITM -----", "Rmt", 1),
 	.name		= "cl_rmt_hitm",
@@ -1672,6 +1699,9 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_tot_hitm,
 	&dim_lcl_hitm,
 	&dim_rmt_hitm,
+	&dim_tot_peer,
+	&dim_lcl_peer,
+	&dim_rmt_peer,
 	&dim_cl_lcl_hitm,
 	&dim_cl_rmt_hitm,
 	&dim_tot_stores,
-- 
2.25.1

