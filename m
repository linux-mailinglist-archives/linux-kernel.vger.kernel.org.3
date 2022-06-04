Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7473853D57E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350538AbiFDEa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350485AbiFDEa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:30:29 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E75037A15
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 21:30:14 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id u2so8572910pfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 21:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mEFlFeeA00qEqb9LWsCR/H03DROXEysxyYTT9NYmxGw=;
        b=gY/grWkYeRkDT8C7n0psacv/dDTzjFOJfyxwCH+JA0W66HH0s18LuFSdfhcBxnaIDL
         YRKqNgMyP0teOFDDDn/HurG/sj8qwIU/JHhMXzjNWpf63PkIB01mHrdQssa0vDKCa/kf
         dswqLn1WZ4M5h1aD+zwbFMW8goTiJNAYxG2iTFf/fFYbPDVMxW0K+AXgECr2XCCQYNIq
         abO4TagNT9t0xExs2VQZo872jcaSGqQK5OGyAgsXTblX7zeKp2UXdgxWN0FhP5e8zucH
         f81SlHbf2tKSN4wUKhuMM5CSHGJEVpx+lj7mNcWHSw8ZyVxWov0jRmaPeOiV+T9aAd3n
         mfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mEFlFeeA00qEqb9LWsCR/H03DROXEysxyYTT9NYmxGw=;
        b=heKbdczM9RZiRoPy3KtOVJErLULFdc0+rO4SCqOVnhU+Pjzm38G8Rt0GhqaO1WhZyY
         stLzorYp78MUCMrq0EQKR5UAVILmphurujbS7jyrl+tKORsxam2er1DRhywajwTKM3xo
         j7GVekfX31mIvDVg9SDkMBpmAyBDk9QKRV9CoVBlmlzQL9mFUZZXmEPaxAU7kyYJs0Qy
         mohPm1N3zdKeV/mUu1plzbG8ZURzQecSVmST4k8LND90CCEJJzvDxa3IYtbUyyqf5RL+
         TH8dPIXbNJjMlfg23hnJhzBkoLi/wXnvLTMsgdcqV+Mj+bIY/AryFgn9eeOa4F/RRNPM
         IcYQ==
X-Gm-Message-State: AOAM533AKdjioCi/4XfsHjLV2LJJQMParV6qSeazzQkt63MEAAD74EcQ
        c3aqBehkOsXgmSUKwn49+hpzlw==
X-Google-Smtp-Source: ABdhPJzvXOFNWK7bNyRRG915P4OXjXVgN5kgUlqrCQoa2iaMsq9GaRWPoGqvI7pt2VJRFCoJge9o1A==
X-Received: by 2002:a05:6a00:2187:b0:50c:ef4d:ef3b with SMTP id h7-20020a056a00218700b0050cef4def3bmr13019979pfi.83.1654317013439;
        Fri, 03 Jun 2022 21:30:13 -0700 (PDT)
Received: from leo-build-box.lan (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm6152916pll.304.2022.06.03.21.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 21:30:13 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 16/17] perf c2c: Use 'peer' as default display for Arm64
Date:   Sat,  4 Jun 2022 12:28:19 +0800
Message-Id: <20220604042820.2270916-17-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604042820.2270916-1-leo.yan@linaro.org>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
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
Acked-by: Ian Rogers <irogers@google.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index f7a961e55a92..653e13b5037e 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2878,7 +2878,7 @@ static int setup_callchain(struct evlist *evlist)
 
 static int setup_display(const char *str)
 {
-	const char *display = str ?: "tot";
+	const char *display = str;
 
 	if (!strcmp(display, "tot"))
 		c2c.display = DISPLAY_TOT_HITM;
@@ -3068,27 +3068,39 @@ static int perf_c2c__report(int argc, const char **argv)
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
@@ -3096,7 +3108,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	err = setup_nodes(session);
 	if (err) {
 		pr_err("Failed setup nodes\n");
-		goto out;
+		goto out_session;
 	}
 
 	err = mem2node__init(&c2c.mem2node, &session->header.env);
-- 
2.25.1

