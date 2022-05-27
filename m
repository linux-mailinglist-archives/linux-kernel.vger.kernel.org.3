Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096C9535773
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 04:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbiE0CHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 22:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiE0CG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 22:06:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E3866CB2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:06:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 82-20020a250255000000b0065a58668d5dso1023933ybc.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=t432bOj9HNNyvwVqFkTcjkKR+K0Bmhu30IV4FVjsgoY=;
        b=b3JXmJSg81a9cCK4Qjk0xcyCb+s5bCsYHXtaTB/4K+Hl98m0MtxyYoobjDFBTB7CFB
         HK26ktpzNug4q4LPiNU/r4aRz3Cd1IFlwQ1riNeU7GWInC/YcT0FrdS4RclYpbP797Hg
         Oa49gKiCb5LTpVK+EC5OdYiEFzh4nzZwdR3sI7Gf7Kw5upguEhIkLAkMTEabl5sM4X8H
         buwqsT9qzsltd5mDKZaIByOHs59VhFUg2m0EG9xZK60XvvM8+Ti1SK1454iDDcUTk0XT
         ZvoKuDWvEzZRG/ZfJs0qkFmkmu1lG/7ILKFrlD7hqqPcJdE7ohUgAUl+67rxn9cTw+Qh
         4FqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=t432bOj9HNNyvwVqFkTcjkKR+K0Bmhu30IV4FVjsgoY=;
        b=FNqm7TtVYHKaVAcEF0lnTYEbnqq3NGPa6HZU6k4P7hhqEALp1qEiLiTJAkL3QCdrXE
         dIeAy/XDDONNTfjfNZEx8jlUbxjl98++an7tVE9XCoZv8X/GBN8m9xNFKx23ZIV7YniR
         Ajcse+YpbxjkJra/roaWHylMuwp33NEXrUOdOODaxdSK7PwmNTq88UGAmFXcAFVUEsHx
         fWiC0WE4uxGKxboSWzKlMZpnOssOQ2AjnGX36o3P8raPQh7AFOl/rHa6fOaKb9SocOEL
         38ted9WD4iESGBTolIsGyZjBvV8S18vhlHncYvfYL2FzoCDGKGcsi4OJDKFzfpAHuhcZ
         e/oQ==
X-Gm-Message-State: AOAM533yjvG9XntrFhSBYCtm89dhwRPwZwBUgWh52OBR3eDGdTbH3LCP
        5+CPhvfPhv+xWWKy3QBbQcJd12gfxnlX
X-Google-Smtp-Source: ABdhPJzEVEPw+BMNvtb1jZpBoUKmkT3ERjQ/T4WthU6YPLykYRzhQAmiFOkVgzeG1dhQrUwWnlZiClN6c/y4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4b39:e167:e698:7d4])
 (user=irogers job=sendgmr) by 2002:a25:e788:0:b0:64d:87c1:8fa with SMTP id
 e130-20020a25e788000000b0064d87c108famr38666633ybh.302.1653617217585; Thu, 26
 May 2022 19:06:57 -0700 (PDT)
Date:   Thu, 26 May 2022 19:06:53 -0700
Message-Id: <20220527020653.4160884-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH] perf expr: Allow exponents on floating point values
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the optional exponent component through to strtod that already
supports it. We already have exponents in ScaleUnit and so this adds
uniformity.

Reported-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 2 ++
 tools/perf/util/expr.l  | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index d54c5371c6a6..5c0032fe93ae 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -97,6 +97,8 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	ret |= test(ctx, "2.2 > 2.2", 0);
 	ret |= test(ctx, "2.2 < 1.1", 0);
 	ret |= test(ctx, "1.1 > 2.2", 0);
+	ret |= test(ctx, "1.1e10 < 1.1e100", 1);
+	ret |= test(ctx, "1.1e2 > 1.1e-2", 1);
 
 	if (ret) {
 		expr__ctx_free(ctx);
diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 0a13eb20c814..4dc8edbfd9ce 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -91,7 +91,7 @@ static int literal(yyscan_t scanner)
 }
 %}
 
-number		([0-9]+\.?[0-9]*|[0-9]*\.?[0-9]+)
+number		([0-9]+\.?[0-9]*|[0-9]*\.?[0-9]+)(e-?[0-9]+)?
 
 sch		[-,=]
 spec		\\{sch}
-- 
2.36.1.124.g0e6072fb45-goog

