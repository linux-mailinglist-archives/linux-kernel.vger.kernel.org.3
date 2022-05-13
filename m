Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF923525A7E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 06:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376948AbiEMEFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 00:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376928AbiEMEFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 00:05:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30C529B01E
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:05:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b6-20020a5b0b46000000b006457d921729so6252611ybr.23
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eQLC4xvJjx0IxiV0N/NcBewb/ng8rVX8YxuFDVrzqJ4=;
        b=XH9POhPcsHh4jg4xxmYN8TGVRB/U7SkOA3DVDNu8P65CflDZqAA7Y+crfFelRDSjJD
         SpPa7TZMucTLUXd80n0haYz8edAh5pZOJHGfDq4a2u6Cy6RL1lYDgN/pUkD827TAyWwv
         pL/Z39Ifo7YgGaqxWGuHtCCbO5oRsiDGXTcHa/sxPFTAcbntiJxqcTd37hqdT53tdS7v
         S96OdTM3CKeG341lz3+Ff33aDILA8kLpUhgV+4unE7cZaBynbHDrGxGLDl1xSkfWgZAJ
         5v4o/k1WOVkQ1WJsuBFdby2ThuixYWMGLSlHPifYxZBy+f5Dbdcsv3a68oKZra9JnMWS
         cwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eQLC4xvJjx0IxiV0N/NcBewb/ng8rVX8YxuFDVrzqJ4=;
        b=jOr5GhNoIB0mcNlqKPqyLXn+2UlNSqsm5i090E5kHfNsURtDG8vnnOKjWZ/Hj1boDg
         Pb2ChhlWFEYzMyhW9ziJHL77WS8L4GwZeHuyZUQljTl0NpzDEM1ca1egm0Zo9vVsN2Ox
         Q096GD3vOlTpAQwB+lO7Dn2THt+qppBx7pjtprzBm8V5zKfkZVNWucchJndILMPdfZ8/
         uWOu3hMYOqpq4X2atenaVXofykdzpR9Y7u9CImtGznbP6yf0YBheQ1YTM6KLMhiqDcfS
         ObqkMVSgFwfm9J70rQ/TT7L1qdD+m1xxNhnEKrbvGwlm+pQQTnRxINvveoD2bTmHNpgF
         Yqtg==
X-Gm-Message-State: AOAM5324Ey+lVNGFFtwvI590K3OiH5IBp2VsRuxVcEJHtMIB4TTyLzMN
        tJO+MmgJeemBIIMXs2l2Q5OtRgrlUupd
X-Google-Smtp-Source: ABdhPJzyGskPGkpPISS9h8ZWQklnv7XS0yI+qMgu8OSSe6Pf2ExA8jQP6cgqgcYEZ70BN0ziUPOhyo4wrv9b
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9b61:c91f:ca29:ae54])
 (user=irogers job=sendgmr) by 2002:a81:23d8:0:b0:2f8:be91:f46f with SMTP id
 j207-20020a8123d8000000b002f8be91f46fmr3701717ywj.131.1652414727907; Thu, 12
 May 2022 21:05:27 -0700 (PDT)
Date:   Thu, 12 May 2022 21:05:13 -0700
In-Reply-To: <20220513040519.1499333-1-irogers@google.com>
Message-Id: <20220513040519.1499333-2-irogers@google.com>
Mime-Version: 1.0
References: <20220513040519.1499333-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH 1/7] perf test: Skip reason for suites with 1 test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Marco Elver <elver@google.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
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

When a suite has just 1 subtest, the subtest number is given as -1 to
avoid indented printing. When this subtest number is seen for the skip
reason, use the reason of the first test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index fac3717d9ba1..33fcafa0fa79 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -137,10 +137,10 @@ static bool has_subtests(const struct test_suite *t)
 
 static const char *skip_reason(const struct test_suite *t, int subtest)
 {
-	if (t->test_cases && subtest >= 0)
-		return t->test_cases[subtest].skip_reason;
+	if (!t->test_cases)
+		return NULL;
 
-	return NULL;
+	return t->test_cases[subtest >= 0 ? subtest : 0].skip_reason;
 }
 
 static const char *test_description(const struct test_suite *t, int subtest)
-- 
2.36.0.550.gb090851708-goog

