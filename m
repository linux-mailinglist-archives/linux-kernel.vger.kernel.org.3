Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E3358F798
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 08:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbiHKG0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 02:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbiHKG0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:26:11 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101687C1B0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:26:06 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t22so16865974pjy.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yX+GwOcQgu1/f98JNOfLTYqRyUQAYNUlTATo/eQwKAI=;
        b=HZ0HBemuTdMQwFcxMQMiy1ewF6Q+l84dc6q8lA9gr85l7CPXqHPbDCjFXcxa2HtZ2D
         u2sLuam2rpoUDZZ5AN87wqX+11GC0cumbKIVuJs/ajkyXdFNLLh1SIzujemf8QGyiBzz
         jffsQ8Vh0ZGDI0qVqoYGDfpYX9UfhzfZPOeWn5gZ6gHT5oOi2CdAe1FKX4X/eXzjiklJ
         FZLW52hkBHeAiz1l4bjEl6P2nnuiqsGbPnYh4O2c590Ua39Y9TFlg66R+8TSWfHkMkfh
         4hRQfEUfZmAZ0djjbzVcqQXav0RcTzDIHud3XjY3O7SLKtof9lu9lWtkEs2ebPeCERE+
         kyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yX+GwOcQgu1/f98JNOfLTYqRyUQAYNUlTATo/eQwKAI=;
        b=nR9wkPJhvmmzaA6Q4x1pbJbj1KFLNpfQlDE04iDanPao1WicZTL5Q4D1GYtU8qk8RD
         4slczP3fwv7Q/KNmUUhGKYIfS8Nx2neBZcSQdLRxNXAGj7tIJ4QrOkFUpQCGshhRviYv
         fmPGeoqvNowY/rhgpRuH2FByX8D1XzV5G7DZEW+reaJDsPewt3/9Kx6/NX+gygKz0Hll
         FhmHPrritiKkIsHeEt5rWipGGON9CvidUGQyNIc/toUA6oNS3Ai12SUBJ/8yIjQ3mZxK
         CNMoJro6kKYzHNMSsbd5X4RgJU9pV43pCRvKA9LZgYL12jOIrTSjsdurJP0uH/aVHkpX
         vIfQ==
X-Gm-Message-State: ACgBeo1kLt+vR5gZ+gYsatBUAw6WYvmrTxs2COuTc2tf71FNKhdlOnem
        JA65WJ8Rws3MCXUC6N+5VbZdHQ==
X-Google-Smtp-Source: AA6agR4p+EoOtegbOAceuvLzmnP44Ejnh+ZZxWz7HMVe3IW3df7He3O9mk1nH2Li37fCh27Z/ez7wg==
X-Received: by 2002:a17:90b:198a:b0:1f5:2f97:12a0 with SMTP id mv10-20020a17090b198a00b001f52f9712a0mr7004901pjb.97.1660199165402;
        Wed, 10 Aug 2022 23:26:05 -0700 (PDT)
Received: from leoy-yangtze.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090a55cc00b001f506009036sm2766926pjm.49.2022.08.10.23.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 23:26:04 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ian Rogers <irogers@google.com>, Like Xu <likexu@tencent.com>,
        German Gomez <german.gomez@arm.com>,
        Timothy Hayes <timothy.hayes@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 11/15] perf c2c: Refactor node header
Date:   Thu, 11 Aug 2022 14:24:47 +0800
Message-Id: <20220811062451.435810-12-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220811062451.435810-1-leo.yan@linaro.org>
References: <20220811062451.435810-1-leo.yan@linaro.org>
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

The node header array contains 3 items, each item is used for one of
the 3 flavors for node accessing info.  To extend sorting on other
snooping type and not always stick to HITMs, the second header string
"Node{cpus %hitms %stores}" should be adjusted (e.g. it's changed as
"Node{cpus %peer %stores}").

For this reason, this patch changes the node header array to three
flat variables and uses switch-case in function setup_nodes_header(),
thus it is easier for altering the header string.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Ian Rogers <irogers@google.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 66ff834516a2..49a9b8480b41 100644
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
2.34.1

