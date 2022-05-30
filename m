Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DFD537A13
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbiE3Llz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbiE3Lli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:41:38 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39E9814AC
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:41:24 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j6so10339156pfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ApE/NeSlPlWnYl/NpyzgZlFA0HuzdRIS04YcKMMzVxo=;
        b=q2dlpKKSusIn+OaBINyOpEG4xB0NNWGRBPAhvlIFXok15TJjyDYSD0+pXUlDeorstm
         asGbzowF16bAbaF8SqIUp26oq5yHaGdmWoY2f4BlqlDT+6S9r6oJZRuy14Tc7rowiWLm
         EISgtUFX/JYPpSaKNydnQamKxi3gzuyZ36TSeyc+/AgN7M5urcilcEYUXCohwFCB3gp0
         SEvgqa03U695YwUZ9iIyIRHHq/IEMpjDNKxyN6fUf6Gj7vfHgdki0sTaExsgIVGaLYeH
         /Iy75Unami+FxaHmiQHDXR5n/HVtyfz8nnUgYfKywUsAoL4TDA79VFrSs8ty81I9v4pa
         kbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ApE/NeSlPlWnYl/NpyzgZlFA0HuzdRIS04YcKMMzVxo=;
        b=3M04riowLB8neOXR1Lb+VmME+q5tTCJl3c0fIXWOusB+tYeHVUfJogh89HZhcaQ5bF
         CxckmNKZmcufVkIVMSBJPZxG7K82xyBRLxkCLEnQJ4tdVkP2MuUN0Al5G1elp2fGK61N
         mx63L5B8evv2QqoEXgaoy2XsHYa0AUlc6BWtJY1eg+f8LOrDtaBFHfr0sPqaPaAWfRMM
         aCZHBkayur44SDcpfHf1eEVRBmst3dBparIfWktrYcb6GefE4ud9EiFeJN4TYT5lX95+
         ke4YDZs6WbV15mIEP06e1NQyoI7Bw4c/47uZD/8WqoZJz7JuIjKbZKg2JpSDtZDaP+9m
         UJ9Q==
X-Gm-Message-State: AOAM532FSsxuN1MrP4yRKP+YYjgkmgKlbPpa4gIOKNr6iK5MTBSUUpW8
        StU0zYnQCQD2i0DRzA6OwNUcXw==
X-Google-Smtp-Source: ABdhPJxaA3Ux3pVeIYn5BevMjwHXFeNRGJkOhoU+e0OnLN0KsM0hMsD5OAU8JGDiPp8dKUBLYDHvYQ==
X-Received: by 2002:aa7:86cb:0:b0:518:3e92:f78b with SMTP id h11-20020aa786cb000000b005183e92f78bmr54866598pfo.61.1653910883942;
        Mon, 30 May 2022 04:41:23 -0700 (PDT)
Received: from leo-build-box.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902724700b00161a9df4de8sm8846194pll.145.2022.05.30.04.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 04:41:23 -0700 (PDT)
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
Subject: [PATCH v4 05/12] perf c2c: Add mean dimensions for peer operations
Date:   Mon, 30 May 2022 19:40:29 +0800
Message-Id: <20220530114036.3225544-6-leo.yan@linaro.org>
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

This patch adds two dimensions for the mean value of peer operations.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 85768c526f9d..01a0656537f6 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -55,6 +55,8 @@ struct c2c_hists {
 struct compute_stats {
 	struct stats		 lcl_hitm;
 	struct stats		 rmt_hitm;
+	struct stats		 lcl_peer;
+	struct stats		 rmt_peer;
 	struct stats		 load;
 };
 
@@ -154,6 +156,8 @@ static void *c2c_he_zalloc(size_t size)
 
 	init_stats(&c2c_he->cstats.lcl_hitm);
 	init_stats(&c2c_he->cstats.rmt_hitm);
+	init_stats(&c2c_he->cstats.lcl_peer);
+	init_stats(&c2c_he->cstats.rmt_peer);
 	init_stats(&c2c_he->cstats.load);
 
 	return &c2c_he->he;
@@ -253,6 +257,10 @@ static void compute_stats(struct c2c_hist_entry *c2c_he,
 		update_stats(&cstats->rmt_hitm, weight);
 	else if (stats->lcl_hitm)
 		update_stats(&cstats->lcl_hitm, weight);
+	else if (stats->rmt_peer)
+		update_stats(&cstats->rmt_peer, weight);
+	else if (stats->lcl_peer)
+		update_stats(&cstats->lcl_peer, weight);
 	else if (stats->load)
 		update_stats(&cstats->load, weight);
 }
@@ -1280,6 +1288,8 @@ __func(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp, struct hist_entry *he)	\
 MEAN_ENTRY(mean_rmt_entry,  rmt_hitm);
 MEAN_ENTRY(mean_lcl_entry,  lcl_hitm);
 MEAN_ENTRY(mean_load_entry, load);
+MEAN_ENTRY(mean_rmt_peer_entry, rmt_peer);
+MEAN_ENTRY(mean_lcl_peer_entry, lcl_peer);
 
 static int
 cpucnt_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
@@ -1750,6 +1760,22 @@ static struct c2c_dimension dim_mean_load = {
 	.width		= 8,
 };
 
+static struct c2c_dimension dim_mean_rmt_peer = {
+	.header		= HEADER_SPAN("---------- cycles ----------", "rmt peer", 2),
+	.name		= "mean_rmt_peer",
+	.cmp		= empty_cmp,
+	.entry		= mean_rmt_peer_entry,
+	.width		= 8,
+};
+
+static struct c2c_dimension dim_mean_lcl_peer = {
+	.header		= HEADER_SPAN_LOW("lcl peer"),
+	.name		= "mean_lcl_peer",
+	.cmp		= empty_cmp,
+	.entry		= mean_lcl_peer_entry,
+	.width		= 8,
+};
+
 static struct c2c_dimension dim_cpucnt = {
 	.header		= HEADER_BOTH("cpu", "cnt"),
 	.name		= "cpucnt",
@@ -1835,6 +1861,8 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_node,
 	&dim_mean_rmt,
 	&dim_mean_lcl,
+	&dim_mean_rmt_peer,
+	&dim_mean_lcl_peer,
 	&dim_mean_load,
 	&dim_cpucnt,
 	&dim_srcline,
-- 
2.25.1

