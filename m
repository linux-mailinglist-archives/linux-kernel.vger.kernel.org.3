Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9876151EC7A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 11:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244271AbiEHJae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 05:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiEHJaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 05:30:06 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C70B10FD2
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 02:26:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id i1so11339972plg.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 02:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sv1aE7FqnI8CKL/sxONnHhH4U4DVSrjLXubYrt9Z0fU=;
        b=PNObX5zzmqLePczW+hBwWlq1W7MvUHr0f52SYFReY+/Ki1myeXly338eeRZantdZr5
         RQb9ALEOb9P3wyOUaltvW77ApV7chGgjxSjGheF9qb17aZ4OortrEWjtaYV+dF5RpuG/
         s1dZ67CG45dMetd/1fYblcyEzV96vF0rJxR1MomaQDJB+HBydIpfb5IpgV8QCtqd1918
         LDPy/hJUGMLY7PNjU8DGJLQ/na+V/WEkUBaHQYoiNzj+APLOJit/z3McF9A5MmWxZy38
         4iyN4kDHz8AIh425Y7cdU8SHM0PMl+yLGjW+oFVL0PPT9yrJ5rKAtoir0tmQXb26seeR
         wglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sv1aE7FqnI8CKL/sxONnHhH4U4DVSrjLXubYrt9Z0fU=;
        b=jnNiF8AdR6PfYQ6j8H3uiqrzjtToYzcmc8mG/hHZuHwpaEtAxyhKtBLaX/tMRdhgbd
         IccYexFcH68QyvRaEUqkc0mYKmyltL8qJUiYVzoM5ATKH9l2di46ai8eb2Shp/HNI5K/
         Z4BnoPL4x2vR9e5wotBiMs77MmNVuT3H6/7+nSbytm+AXksFDfJEhtOpIpsV01ZWZ7Ng
         usc8W2hiWWvSPNeYoWrh1dxj9n0EsmJfxFc2ul1FLeQzDX3Dmx0RutfmDDhSU1RrefLk
         OJh9gY8bnbu9DQkj6yEJ7eBtc3TYLopcXdyE/s0kEreU3U3DVOThT09/3DlDNmcy4ZGY
         RsqQ==
X-Gm-Message-State: AOAM532wKgVxyRsopG76BQ+FQwBEoayp3yIWeRMOP+BRSDrF78WJMDPb
        FDZYDjXDThr0h6bp2OkCU2xBAg==
X-Google-Smtp-Source: ABdhPJyY4JJvoKWLet/PsVWyBKDJibBPszt7mSL4y2hyFxP/9UiEh7EcnVn8+VjkDGeDqa8ZDURHVA==
X-Received: by 2002:a17:90b:3903:b0:1dc:8fe0:df4d with SMTP id ob3-20020a17090b390300b001dc8fe0df4dmr12804471pjb.191.1652001964510;
        Sun, 08 May 2022 02:26:04 -0700 (PDT)
Received: from localhost.localdomain (104-237-153-19.ip.linodeusercontent.com. [104.237.153.19])
        by smtp.gmail.com with ESMTPSA id t63-20020a638142000000b003c14af505f7sm6155088pgd.15.2022.05.08.02.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 02:26:04 -0700 (PDT)
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
Subject: [PATCH v2 11/11] perf c2c: Use 'peer' as default display for Arm64
Date:   Sun,  8 May 2022 17:23:46 +0800
Message-Id: <20220508092346.255826-12-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508092346.255826-1-leo.yan@linaro.org>
References: <20220508092346.255826-1-leo.yan@linaro.org>
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

Since Arm64 arch doesn't support HITMs flags, so use 'peer' as default
if user doesn't specify display type; for other arches, it still uses
'tot' as default display type if user doesn't specify it.

Suggested-by: Ali Saidi <alisaidi@amazon.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 9b6d2a9553e1..774da4a60c08 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2787,7 +2787,7 @@ static int setup_callchain(struct evlist *evlist)
 
 static int setup_display(const char *str)
 {
-	const char *display = str ?: "tot";
+	const char *display = str;
 
 	if (!strcmp(display, "tot"))
 		c2c.display = DISPLAY_TOT_HITM;
@@ -2973,9 +2973,6 @@ static int perf_c2c__report(int argc, const char **argv)
 	data.path  = input_name;
 	data.force = symbol_conf.force;
 
-	err = setup_display(display);
-	if (err)
-		goto out;
 
 	err = setup_coalesce(coalesce, no_source);
 	if (err) {
@@ -2996,6 +2993,22 @@ static int perf_c2c__report(int argc, const char **argv)
 		goto out;
 	}
 
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
+	err = setup_display(display);
+	if (err)
+		goto out_session;
+
 	session->itrace_synth_opts = &itrace_synth_opts;
 
 	err = setup_nodes(session);
-- 
2.25.1

