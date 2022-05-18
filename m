Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF99852B167
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiEREUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiEREUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:20:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA5D21251
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:20:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o7-20020a256b47000000b0064ddc3bea70so914249ybm.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LvpJiUnSFpCiFAKE98nz9J5XPUyrNRc2U9N5mJnm5Hg=;
        b=Oju5r4aDWZ9Zqud5nYsTAl9JheS1ktMe0jzOrH9p2XeVTlhAYnaTONZuQnfO+3bjYp
         X12uYnhd/xGMi6E9AoSxjGdshhG1nM2sP2HCK8KnCu6Qdv1eLHfGgchPUcUgMzrMzm20
         hQ2pXes2b6MoGLLnjMAWEcCYiB8/Poy7ITRbwbIoX4qU4sLyZUF+ZcZ8m/Tg75C61Nw7
         W7867SE05iBb4gL3GcZ9Ro5E527A/V1EdYVfuvZikEFN8anOJ+r0b27zabd+GC0Qt3NF
         sD+xZrmcBXLBQ0lwBW0oc1lFNkPi+yTU4z1BD+LvMGfrJ3AKw/PUDMGl87JZTnaVO5HT
         f6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LvpJiUnSFpCiFAKE98nz9J5XPUyrNRc2U9N5mJnm5Hg=;
        b=pbAxrE4TEYVga5QIhD7lBrxBMeDl4so/j1PMBr1I0Dkq/3kaJoDYDUMjW+atMtw8/f
         tbFYg7NmPt8tG+bH2bGU9J3gj+mEIfgIf6a/pnoguhIEXeN0/kemHBP2ddcZ0KFSUbKq
         4RsCiNv9i41o5f8u7qA8qcnu9KwDWuYIHSSyWhb0x2XTjsrcpivpRo84bhIl8UIrBRWm
         U7Xxw1fzqyewmQfCX0/5SMV5+xT7ObhjFoWJalIQG0VwXW/X+zqNO5bDDnGvLxdYh99f
         evHhvaEzM2NHxiHJap2SYAFNj/lCp3J8LhdxabWdeUNJZYwHWsR2TqNEa7hKLD35smF/
         09Iw==
X-Gm-Message-State: AOAM533Bx0I/8LbZtaHmrjyE+R4X0MPukt4uJfiPUoCoRG2Vr6QfV2iE
        YKQ4MfWrTiur0tuB646159q/HWDiReuw
X-Google-Smtp-Source: ABdhPJxa786aBoSAGP95NfMFnlI9dLOPTNSKBMoSDyj9KewGk9Xm9VagNfnviFtvuciptpIl68JDMEXQG9Go
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a5a1:af73:fe09:fd5])
 (user=irogers job=sendgmr) by 2002:a25:bd05:0:b0:64d:6ee0:f503 with SMTP id
 f5-20020a25bd05000000b0064d6ee0f503mr17703514ybk.415.1652847635670; Tue, 17
 May 2022 21:20:35 -0700 (PDT)
Date:   Tue, 17 May 2022 21:20:20 -0700
In-Reply-To: <20220518042027.836799-1-irogers@google.com>
Message-Id: <20220518042027.836799-2-irogers@google.com>
Mime-Version: 1.0
References: <20220518042027.836799-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 1/8] perf test: Skip reason for suites with 1 test
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

Reviewed-by: John Garry <john.garry@huawei.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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

