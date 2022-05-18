Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2101452B20E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiERF7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 01:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiERF6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 01:58:48 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AB3C0396
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 22:58:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n18so818060plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 22:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o0tYGv5gKzzwAKbeBtiGIhGw8+poYiZW6V66JN4rF/Y=;
        b=Jmj34sGWh4dN6sVL1KcsVd5Ko6DxtA2ljfd7CxuyhF0iUnOPhJmr2jY9Jr4u0QQ15+
         tht1CE1RtsOzKeg6g9OeQd8lluEuraX0SPjxQ+Ql84rNDcEXBJGwTrH+Tpe3hNdyk6rB
         jh26SGTW8V0fnzBmjXSvV/r/LkwqA6pU832kpVBTQgwDAubo+aUt0IOvC9ElMg/RABtF
         4pcZb1ZLnvGX3/k8qVUnPT5Ougk+NC9SxeKU1o4Os/e+SAEWrqrbZtAn4auU5x4zt0mz
         zDLFUf6abxMtF8s3JTr4GXFaVcpY308IwERcMvZNT31n9wEZYyjvnphXCIW1idmPzJf0
         kwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o0tYGv5gKzzwAKbeBtiGIhGw8+poYiZW6V66JN4rF/Y=;
        b=T681Lxo3RZVWomsUW4A3rgBNO0AmmDnd8FQB673KKhdh3KOb6BzVlluIPf/IiiJYkv
         LM03jgGUJvdHsBGFewH50QDoO42DI38M11yO3TbcQe/R1WJV3otvI6O5xm3DkT8MMEeC
         WmnSwp2oc06s2aEOjpM5YRPwtLLjpcagdb39bMJDbjGMWRfGOB64dF0L17xeDXcNXure
         RbqPMoVHhCbjbD2YIOiCVmqobRL9+VaHuPYWqVqJp1poZ0CkBSbpSGBjzxmhB86iOMZB
         qROebdKGmbf1YpT0gm6iS/h0fk5q+hmsJTUE9sIl/iep1Gti9gB0uBG76fQxSPCrMNKt
         zk7A==
X-Gm-Message-State: AOAM533QRvwkoigMhEKJEVzXmVKrE9qlfzd6u3Nx6eetTZGBNUcpMxFv
        8UCSNeBuHnkZZrGcuVYhwoPl/Q==
X-Google-Smtp-Source: ABdhPJwmo4MX8EtkpMW+wz6uUQ0J0zamBatqn6h0/7O/GiKhQ482py0wwHuBMX+OYGXPQpJEJSSkWQ==
X-Received: by 2002:a17:903:41c1:b0:161:bec6:b308 with SMTP id u1-20020a17090341c100b00161bec6b308mr2581103ple.161.1652853526569;
        Tue, 17 May 2022 22:58:46 -0700 (PDT)
Received: from localhost.localdomain (n058152048195.netvigator.com. [58.152.48.195])
        by smtp.gmail.com with ESMTPSA id cp16-20020a170902e79000b0015e8d4eb2c2sm627127plb.268.2022.05.17.22.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 22:58:46 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Like Xu <likexu@tencent.com>, Alyssa Ross <hi@alyssa.is>,
        Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adam Li <adamli@amperemail.onmicrosoft.com>,
        Li Huafei <lihuafei1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 11/11] perf c2c: Use 'peer' as default display for Arm64
Date:   Wed, 18 May 2022 13:57:29 +0800
Message-Id: <20220518055729.1869566-12-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518055729.1869566-1-leo.yan@linaro.org>
References: <20220518055729.1869566-1-leo.yan@linaro.org>
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

Since Arm64 arch doesn't support HITMs flags, so use 'peer' as default
if user doesn't specify display type; for other arches, it still uses
'tot' as default display type if user doesn't specify it.

Suggested-by: Ali Saidi <alisaidi@amazon.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 3bd422c5e8ae..042431b7b6ba 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2785,7 +2785,7 @@ static int setup_callchain(struct evlist *evlist)
 
 static int setup_display(const char *str)
 {
-	const char *display = str ?: "tot";
+	const char *display = str;
 
 	if (!strcmp(display, "tot"))
 		c2c.display = DISPLAY_TOT_HITM;
@@ -2971,9 +2971,6 @@ static int perf_c2c__report(int argc, const char **argv)
 	data.path  = input_name;
 	data.force = symbol_conf.force;
 
-	err = setup_display(display);
-	if (err)
-		goto out;
 
 	err = setup_coalesce(coalesce, no_source);
 	if (err) {
@@ -2994,6 +2991,22 @@ static int perf_c2c__report(int argc, const char **argv)
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

