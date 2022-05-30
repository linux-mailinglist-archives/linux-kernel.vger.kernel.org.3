Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF656537A16
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiE3LmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbiE3Llv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:41:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35CCC3F
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:41:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a10so1528037pju.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iz4biW4IDZ4QF/Qhrw0FBXVfKeF/4pqPrsK4LZ1UsOg=;
        b=okSUF0PGgdTegKALKNn8jtLiWYsEUlcbtTa0US/Oc+8m9/jSGz1aUHw9fjo4qE/TDE
         SJVv0RXU0EOYhRhTIF/1X6lHKcFgPIjYCXfcz9JJM2FszSrzZ/WXTvzf6xr7WrHgSn1r
         MaSEBxjLxSncG5bCMXgSyWlnp80kuoqc3m15Z6DIorcRa7GPmIO5SXEfB6jXBKpWuKrI
         +S76GX0q6aXX/b5a9Xgz3Wbq/eYd7ktscxUk0DwAR3X//xj8dUaigYTXozIMdHb8EQRw
         bPc5gUeimG1ObEzhYuyOLWnypgUQUazRUQ6fflSTWo7jzkF38FYbw7nljAIaHZm0XVrQ
         iCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iz4biW4IDZ4QF/Qhrw0FBXVfKeF/4pqPrsK4LZ1UsOg=;
        b=raSe5CAeCfjeBYUcYNcSaMBJB+KLLkch+cG3seKS0A/OLsz9isQ5f9RMaFaaYBufUz
         9ciXxXZ67r6sii5x0gU7l5zQn76eEqhn32VEAIyTzMYHyKxek/OIH6R2FE8XSw6Ka3Nz
         RriVp/BFF2xtKW7GuJTak06FucKyvhzAFmd40TxSvxSa/t8/8P/5ebFSu5Yc8NBh3MuM
         D5D8ObL4f9IW5Vk4UtIQB7Va0fWcZRB3HMBmOS5KPCnzLU1vtXnheCBrcMNtqdKCJ+SU
         1lAEy2SjxX4BBYafr31FQbRVJ0MWdOkXomAFovcZLVLsXMaVn/HXBEPyD6t/Upi5U6U+
         m4TA==
X-Gm-Message-State: AOAM5327dIpXZxpnXZWkEOsY01vHIrb02NU0722e60wmaU5NNHJWz1+R
        i+OtGYlZj1B6ydaxsvrLcLbbqg==
X-Google-Smtp-Source: ABdhPJxaqvLQtMDeUqaJoddPBV920ZEhBaxkPVNe8EoeMNOCtUBEdgTUy7ChmatTR+i027oqfxAOUw==
X-Received: by 2002:a17:903:22ca:b0:163:e2b6:e10b with SMTP id y10-20020a17090322ca00b00163e2b6e10bmr4540757plg.28.1653910898269;
        Mon, 30 May 2022 04:41:38 -0700 (PDT)
Received: from leo-build-box.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902724700b00161a9df4de8sm8846194pll.145.2022.05.30.04.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 04:41:37 -0700 (PDT)
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
Subject: [PATCH v4 08/12] perf c2c: Refactor node header
Date:   Mon, 30 May 2022 19:40:32 +0800
Message-Id: <20220530114036.3225544-9-leo.yan@linaro.org>
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
index d3608d24bea4..e76219034588 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1723,12 +1723,6 @@ static struct c2c_dimension dim_dso = {
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
@@ -2229,9 +2223,27 @@ static int resort_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
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

