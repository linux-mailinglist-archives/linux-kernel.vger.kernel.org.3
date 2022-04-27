Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EBF511E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240816AbiD0PzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240844AbiD0PzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:55:02 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FD95520A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:51:37 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id h12so1884526plf.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/vcydkgfwulbRdhsxwG26aGxHp6JHi+EQHDHh6atTeA=;
        b=fN74pyEweV80SDfA8wca3NLHZxPoe0yH0glecZ2Atg//g8BQ5ztUXkT6gJ3oIcqUzK
         Qp86QY1rL6mAUyRGPB9FvMG3g2RbR5TG41WnweAiRqqCCEFleSki/9dKSBvZ/1J0bpS+
         n3nHNuxKHKu49Py8xK7sxs7fjhz7wQbkfBnUXjmC3P3y88N5YvPSrJIMIIXYzE1vpRqK
         aUzmdlhfepQkk32i+Fsd8MhPQAtLxxVFn/oBOWcAB/O3lOy8ewaBHFBpaS1gk7BLzGk1
         SR12K5AdIo2Qo4bK/CPmRxJedKhDOb6ptd6zTtRendbV2X62P766VlLa0PydKWqZgW72
         IaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/vcydkgfwulbRdhsxwG26aGxHp6JHi+EQHDHh6atTeA=;
        b=C5fsWIlmphXw6CiTTt+jYSp1L7x17MZSeiRbLZIRmSgu3TDxg8BUT3EEeo82MEh/dK
         kaa7+Y9BHqh4x9mhGH4saUJCrdBtDlMvHSpofOwXGF1hPCPznnfrJRC+j9uG/mwUsodd
         i2DJJvDzlMVr29C9AfWnW326KePn2GTB67EOouXKqZF78r/1rx6QH3iznORctBwFcp9J
         95X/UGz03Af6u406ujtlAcRM5pPKjF8d/dBJeiGIi1FU6DsaS/o1I8JkFzh0cM7ABGff
         hcHtA7sb52WKwk4fU5hOFsHZ8pfOZk2sBe0nVu/kGq3ENks7c7dFyXf78cBwYAQ0z/cA
         BnNg==
X-Gm-Message-State: AOAM532ESTrtIFNr/75BVFcl2DgT2zMf1BnIl8HHdC+Oq6FFnmrPHb5X
        i0XM6Bghu1Xi/1YRId8He+oYQw==
X-Google-Smtp-Source: ABdhPJxwW+VNwWrLgfTZFjDrwhfhezzHfN0FF+xjbEz0bjR7HP4PF9HzXsYU+tRWXR0wPggdekjaDA==
X-Received: by 2002:a17:90a:488c:b0:1c7:b62e:8e8c with SMTP id b12-20020a17090a488c00b001c7b62e8e8cmr44056171pjh.157.1651074696628;
        Wed, 27 Apr 2022 08:51:36 -0700 (PDT)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id v65-20020a626144000000b0050a839e490bsm19164127pfb.185.2022.04.27.08.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:51:36 -0700 (PDT)
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
Subject: [PATCH v1 11/11] perf c2c: Use 'peer' as default display for Arm64
Date:   Wed, 27 Apr 2022 23:50:13 +0800
Message-Id: <20220427155013.1833222-12-leo.yan@linaro.org>
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

Since Arm64 arch doesn't support HITMs flags, so use 'peer' as default
if user doesn't specify display type; for other arches, it still uses
'tot' as default display type if user doesn't specify it.

Suggested-by: Ali Saidi <alisaidi@amazon.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index bd4516e486c0..c944631fc505 100644
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

