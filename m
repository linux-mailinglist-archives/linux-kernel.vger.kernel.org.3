Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52467525A80
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 06:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376985AbiEMEF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 00:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376942AbiEMEFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 00:05:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E043929B03F
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:05:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m136-20020a25268e000000b0064b233e03d1so6254267ybm.14
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YnV5trOl0KkVtbfV7+spiE3dNbfJVrO/n7Q27X48qls=;
        b=KAfbU78oWArs3iQP9D8et6l1CENXxZLiD9Xik6r+YK9/Y+/IH5m66bvk4kXon9QT6U
         iwTuHDJFwZl26xdQGjsV1ZaiDEs+NYnJYEp8Q3nmgQNFhHbSkPy4zTtUcjzfBtPyNfqa
         lK8jKjh0H/ufSKjJZsrNC7RTrTXILvWs0vWq2vHWeJrF8hOjWgv0n6GK7kIRb6lgFGWP
         DyRCxS9NBPZvXyz5NwQcWajq7bgxRjYEAZO6T/BV1h0aCCiVjsWl9ltuLGs2IGCC1Fss
         4LCysmf+P+eo/W2hlrke/e+IL2kRaSZ0ozPYYuQizhGpO5j0i+alxiq/l+3ADDmy5gfi
         nqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YnV5trOl0KkVtbfV7+spiE3dNbfJVrO/n7Q27X48qls=;
        b=11xIuTrOXRYYo2TMA83kWZ3vHh4bGCyU0rHaD7cWKbvRFYDBojNn9TztOMETqqsVWU
         Ylk6dAawCiIFBjj60J1Vvg1Jh96X3JvOF8niSUDC5pRYwN7J8XOxSLnr0xfXvyP37lXd
         uz01xRosaZAuK3g+VR/8wNviPE1FzjTgxkZkiMiYABc1DoGKhoNG20pTOImfXAe81bFy
         E8LepFIjUwO73JYaNWIhOuqBZaWSYrFuvz7NmvM2kOruHI8dKpfNsnQWExrdpqmV/7wO
         KKomTnoCwm8QSCA9b9LrB23C3AYqOFgy/x/UrXEq9COltWnvZLeQ6kuBNxpNlWKc29fg
         zFNw==
X-Gm-Message-State: AOAM533mrjfLUvVTDU27f6kap6xX+GC89I9Rw6hjl4dFRYudHXPQjxKx
        KmVWb/A6sjFsoaYugiJeSRSY4t0uonaG
X-Google-Smtp-Source: ABdhPJwQBA1Wj8Te1Bc3ceC61d+MP096QHfl+4mpcj4AdvZwLGmUgP2gIQyb1UNvQW9zY/RiSQ98mZ49Df3J
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9b61:c91f:ca29:ae54])
 (user=irogers job=sendgmr) by 2002:a25:e606:0:b0:648:402e:598a with SMTP id
 d6-20020a25e606000000b00648402e598amr2974368ybh.170.1652414733975; Thu, 12
 May 2022 21:05:33 -0700 (PDT)
Date:   Thu, 12 May 2022 21:05:16 -0700
In-Reply-To: <20220513040519.1499333-1-irogers@google.com>
Message-Id: <20220513040519.1499333-5-irogers@google.com>
Mime-Version: 1.0
References: <20220513040519.1499333-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH 4/7] perf test: Basic mmap use skip
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If opening the first event fails for basic mmap it is more likely
permission related that a true error. Mark the test as skip in this
case and add a skip reason.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/mmap-basic.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index c3c17600f29c..32f0a63fa157 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -31,7 +31,7 @@
  */
 static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
-	int err = -1;
+	int err = TEST_FAIL;
 	union perf_event *event;
 	struct perf_thread_map *threads;
 	struct perf_cpu_map *cpus;
@@ -83,6 +83,14 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 		evsels[i] = evsel__newtp("syscalls", name);
 		if (IS_ERR(evsels[i])) {
 			pr_debug("evsel__new(%s)\n", name);
+			if (i == 0) {
+				/*
+				 * Failure to open first event is more likely
+				 * related to permissions so flag the failure as
+				 * a skip.
+				 */
+				err = TEST_SKIP;
+			}
 			goto out_delete_evlist;
 		}
 
@@ -166,4 +174,14 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 	return err;
 }
 
-DEFINE_SUITE("Read samples using the mmap interface", basic_mmap);
+static struct test_case tests__basic_mmap[] = {
+	TEST_CASE_REASON("Read samples using the mmap interface",
+			 basic_mmap,
+			 "permissions"),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__basic_mmap = {
+	.desc = "Read samples using the mmap interface",
+	.test_cases = tests__basic_mmap,
+};
-- 
2.36.0.550.gb090851708-goog

