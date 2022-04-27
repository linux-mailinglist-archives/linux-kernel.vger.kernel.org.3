Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFE8511CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240702AbiD0Pyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240786AbiD0Pym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:54:42 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9024A56200
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:51:19 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j6so1898485pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dzfHiLB7CMSdbaalokwtZ2LWRfH0lNk/KKqxPTmoSuo=;
        b=h2hw3BAWYLo7gwsVCC3X5xKVrVECZ5NtG0dbvqGGzeGsdOD/9P4Gvrg48lm9oyEmXg
         CEWLgj+2SjFYmTy+H6RF0jwp4ssvdS/OA+aKeQV04IVAse5olhopXzKAth2xnT1LHllq
         a3fCsJrnbJkOc3srjd4djLwGlAomYHH2lz37KT19FJbbloqmaRImethqKa3Gcc/AaOm8
         lZ6ILkEjIWkLCLXIwezktoQhwpg6l5NGOHH15y8bOOmnlDmu8Nv7ukWf2v9eqayK5SYj
         v7RBh0fZA9lbjC1nNNdGwyYiQGAMmfU35c5AS6e6bwvjFTCRQ1JiMPr72X5UFLHkGgLw
         km7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dzfHiLB7CMSdbaalokwtZ2LWRfH0lNk/KKqxPTmoSuo=;
        b=bWJ8QA7sBG5DB/Ijalb3Wy9Hn4Myl/ShXFcIyd9KBSrfqyhe/vYOGR0NHbkfwxIPYR
         AcMjDzgC6q4m2cKyWD0bZ7BFrsQtScTUujE57hoU6bipBz57kJVbC/jz7+jTvXP4szEI
         WVfTseQmrn/X7HPs0+DIfwjv0qOBBcVFmsVhZ2BXM/2fV5zy1bw9PzVlN0KZWnzr90SI
         c7a2zVg0SVrqOY3Vfk9Yd0hrhjMoi1t05SkLpkhULf6bR4Hch5hJLPUTIMA4xmQSiBO+
         Zu3/6Axm5nPqptx29bONlqc3NPi0JG4wFAh02HTbO9KnNrdnOmqO+VhVx5fgvfPGS0wN
         iG4w==
X-Gm-Message-State: AOAM532CC73xwbPfuLMRm6smQpQcoaLVJYsUlbqqCtNuHAt/F5l99ghX
        7TJeuycOovgBB6IRJhAFmiBx6g==
X-Google-Smtp-Source: ABdhPJwd0eP81/BAql0hYsxa5z5vyl3c+tnqi++MAivKD4G8MKe8VdUQPVnigq/v0blD2Kq/Maug+A==
X-Received: by 2002:a63:e80a:0:b0:3c1:6c84:de53 with SMTP id s10-20020a63e80a000000b003c16c84de53mr460981pgh.224.1651074678368;
        Wed, 27 Apr 2022 08:51:18 -0700 (PDT)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id v65-20020a626144000000b0050a839e490bsm19164127pfb.185.2022.04.27.08.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:51:18 -0700 (PDT)
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
Subject: [PATCH v1 08/11] perf c2c: Refactor node header
Date:   Wed, 27 Apr 2022 23:50:10 +0800
Message-Id: <20220427155013.1833222-9-leo.yan@linaro.org>
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

The node header array contains 3 items, each item is used for one of
the 3 flavors for node accessing info.  To extend sorting on other
snooping type and not always stick to HITMs, the second header string
"Node{cpus %hitms %stores}" should be adjusted (e.g. it's changed as
"Node{cpus %peer %stores}").

For this reason, this patch changes the node header array to three
flat variables and uses switch-case in function setup_nodes_header(),
thus it is easier for altering the header string.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index b90696ebfbc9..52542cfec80c 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1653,12 +1653,6 @@ static struct c2c_dimension dim_dso = {
 	.se		= &sort_dso,
 };
 
-static struct c2c_header header_node[3] = {
-	HEADER_LOW("Node"),
-	HEADER_LOW("Node{cpus %hitms %stores}"),
-	HEADER_LOW("Node{cpu list}"),
-};
-
 static struct c2c_dimension dim_node = {
 	.name		= "node",
 	.cmp		= empty_cmp,
@@ -2146,9 +2140,27 @@ static int resort_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
 	return 0;
 }
 
+static struct c2c_header header_node_0 = HEADER_LOW("Node");
+static struct c2c_header header_node_1 = HEADER_LOW("Node{cpus %hitms %stores}");
+static struct c2c_header header_node_2 = HEADER_LOW("Node{cpu list}");
+
 static void setup_nodes_header(void)
 {
-	dim_node.header = header_node[c2c.node_info];
+	switch (c2c.node_info) {
+	case 0:
+		dim_node.header = header_node_0;
+		break;
+	case 1:
+		dim_node.header = header_node_1;
+		break;
+	case 2:
+		dim_node.header = header_node_2;
+		break;
+	default:
+		break;
+	}
+
+	return;
 }
 
 static int setup_nodes(struct perf_session *session)
-- 
2.25.1

