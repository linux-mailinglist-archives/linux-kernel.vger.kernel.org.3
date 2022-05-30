Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6AB537A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbiE3LmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbiE3LmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:42:00 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BD86341
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:41:53 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 129so5655751pgc.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lAvFNka/m3Pr7HXS/bNaYQopT2wZ3BtRM1nGnYwWgUI=;
        b=J35JDHdYfL3z47b3U5zMVTOC/j930PY8ubRHzosSBNYhYnetLWQGy+FrMMc42JfKQu
         xsVGdUt8Kmdi6+FM8KoCUxbaC2nTtU5nKNr5hl6ERK3/PFFj/BM3E5bJBpnamfodL+jW
         K84Q0wZrkxDo4iZUlFVBBUu5KQMkw1c0q4TyeQEvVABgb7gk/X/zELEzfKPTUzBnK4ai
         eV7fFCFQhvZd5qAmQti5dQm5vgrGqLzp3bei6g29pRH+dKF7WN316A9bczx4YLvWmFnq
         ro5syfmQVPx43kcYs4HWr2fP+duGwu71YV0wrFhSBe4Hagtz/bY3p+5tGxfWHXvWvkYg
         oy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lAvFNka/m3Pr7HXS/bNaYQopT2wZ3BtRM1nGnYwWgUI=;
        b=F/GR6PwjmT6eUaKsb0JTDUiG87wQniyBpVm+mD8gG4saA1GpWURY+581n9GvqJN9mQ
         bceEJ1+jC4ytwzxhHD+hCrpSZUBVcOWfGbffsTFVlBPOBXoSIjDXl68AiH6RDSDArSvP
         i0U4v6rOqYHhXm2iCYGKZWRwGYvuu3M4iRQREbR/OqKyi0wRwL9flH3q66ueiFVNDKjM
         AgupjWEylTDW/FgrRVkWCnqv/YhSKDIEqiMXw6kd/H6CywqiFRZuCnxK+1Xha7NrNFBQ
         +2lAHXCu9jrpa3SLFN4vLbDVwGUOJsgRCudWa85MOKAwx3CudGtf5l0J4oN6DPhDBOZ7
         LvqQ==
X-Gm-Message-State: AOAM533xJ5hFjN35x8/r17iq+2l8jSLesEXeSKvFxjlWRddjk0KH3G4E
        rkFiEFx8qSNuXvCSVLTgSKdxXNT9G7lTNpFxrFU=
X-Google-Smtp-Source: ABdhPJyICzqM2HpkXHFV0U936Hh64o0w7SC8tQexIpAlh7exp3xGA3kC8nJtJBTHfClC7Y/SrryZkA==
X-Received: by 2002:a63:85c3:0:b0:3f9:dd67:8ddd with SMTP id u186-20020a6385c3000000b003f9dd678dddmr39306452pgd.258.1653910912632;
        Mon, 30 May 2022 04:41:52 -0700 (PDT)
Received: from leo-build-box.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902724700b00161a9df4de8sm8846194pll.145.2022.05.30.04.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 04:41:52 -0700 (PDT)
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
Subject: [PATCH v4 11/12] perf c2c: Use 'peer' as default display for Arm64
Date:   Mon, 30 May 2022 19:40:35 +0800
Message-Id: <20220530114036.3225544-12-leo.yan@linaro.org>
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

Since Arm64 arch doesn't support HITMs flags, this patch changes to use
'peer' as default display if user doesn't specify any type; for other
arches, it still uses 'tot' as default display type if user doesn't
specify it.

This patch changes to call perf_session__new() in an earlier place, so
session environment can be initialized ahead and arch info can be used
for setting display type.

Suggested-by: Ali Saidi <alisaidi@amazon.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 1076bf8684d3..ccfd23103b96 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2878,7 +2878,7 @@ static int setup_callchain(struct evlist *evlist)
 
 static int setup_display(const char *str)
 {
-	const char *display = str ?: "tot";
+	const char *display = str;
 
 	if (!strcmp(display, "tot"))
 		c2c.display = DISPLAY_TOT_HITM;
@@ -3066,27 +3066,39 @@ static int perf_c2c__report(int argc, const char **argv)
 	data.path  = input_name;
 	data.force = symbol_conf.force;
 
+	session = perf_session__new(&data, &c2c.tool);
+	if (IS_ERR(session)) {
+		err = PTR_ERR(session);
+		pr_debug("Error creating perf session\n");
+		goto out;
+	}
+
+	/*
+	 * Use the 'tot' as default display type if user doesn't specify it;
+	 * since Arm64 platform doesn't support HITMs flag, use 'peer' as the
+	 * default display type.
+	 */
+	if (!display) {
+		if (!strcmp(perf_env__arch(&session->header.env), "arm64"))
+			display = "peer";
+		else
+			display = "tot";
+	}
+
 	err = setup_display(display);
 	if (err)
-		goto out;
+		goto out_session;
 
 	err = setup_coalesce(coalesce, no_source);
 	if (err) {
 		pr_debug("Failed to initialize hists\n");
-		goto out;
+		goto out_session;
 	}
 
 	err = c2c_hists__init(&c2c.hists, "dcacheline", 2);
 	if (err) {
 		pr_debug("Failed to initialize hists\n");
-		goto out;
-	}
-
-	session = perf_session__new(&data, &c2c.tool);
-	if (IS_ERR(session)) {
-		err = PTR_ERR(session);
-		pr_debug("Error creating perf session\n");
-		goto out;
+		goto out_session;
 	}
 
 	session->itrace_synth_opts = &itrace_synth_opts;
@@ -3094,7 +3106,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	err = setup_nodes(session);
 	if (err) {
 		pr_err("Failed setup nodes\n");
-		goto out;
+		goto out_session;
 	}
 
 	err = mem2node__init(&c2c.mem2node, &session->header.env);
-- 
2.25.1

