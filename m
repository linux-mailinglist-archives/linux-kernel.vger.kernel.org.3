Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE6252B171
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiEREU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiEREUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:20:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DC721256
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:20:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2fefb9975c5so9978257b3.21
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kOmtF4LnMuuQ/gYjp/xxv4tsoB08CtJrje0cWKy7hYw=;
        b=hWhJnnH0w5iGS/GIOoqC3YyLdpf9RPFFxzQRXWn1cfjUu8CCUQ1G7gXpOXinWF6KWe
         65MKumXCZHhuUk9OJ8M4piP7avxlCnYNiked6F5G2gyK8kcbS/qAQ2x+6DEJYCbOMmUo
         ah+X6RrmXP+37TkuQkEEkmKiyfPRd+ypteVXqhZDrUi2Ifv79IjRInSdotFycX3lsK0m
         1NuobwHUtsTDL76MFgHI7oVdPrVGSXLFBGyFL4Tk7UiiaNrCqYpLNBa5k0jsDf20xaDu
         Vl5KgOsedi8KooEKXJR1RlkcfrtwKO68u3HhhVDIQs+7x51wHPoG+vw8FhYDWEmGWMzS
         BPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kOmtF4LnMuuQ/gYjp/xxv4tsoB08CtJrje0cWKy7hYw=;
        b=urz24yatCGiLl/hUOJcxVhJYl5IB/Qb1U+ovTMvL9A1TGUJaQL5dNTW6jGMpK3oA8Q
         WACeMXFJWJSx30HSZsg3jalm/uwxNtH7JokXzGIy9yJrADjRFMLiPPo/UPJpt83yXr1m
         GOZYGPhEv/rh7JkntD1fBB/rFbmzqoTvRKwi4dLPfrMfo8ua/eEVic9F4aiEZuGTcIK9
         jRVPli5vqKvkkhuBP2eSVLgQihGFLVhBv6t/jpw6qw+25/UAfqqbg35TAT5YkCMbE+My
         YUj9vqIheKCqNcybr4qX//BKL4dAZHJKa/MZIJ2rBWbzd7dhZe6P+/3WI2sUPvc70Vmq
         0L9A==
X-Gm-Message-State: AOAM5323MRvzBx28WQI8Oxlfn1Rb5jIN59hznEUApmd+myIRUXxdEiAW
        ESb1F35xY5feC/TaEDPT2KeYq7cvc9jf
X-Google-Smtp-Source: ABdhPJwa1yFHsKuws2qp1gAJ3FcCd+gq92TewZjLW654L9XrDnT3QHmktY5N+Lwvws51YRwziIVR33ixRnIZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a5a1:af73:fe09:fd5])
 (user=irogers job=sendgmr) by 2002:a25:8b81:0:b0:64b:3ea3:5cd with SMTP id
 j1-20020a258b81000000b0064b3ea305cdmr24520130ybl.542.1652847642452; Tue, 17
 May 2022 21:20:42 -0700 (PDT)
Date:   Tue, 17 May 2022 21:20:23 -0700
In-Reply-To: <20220518042027.836799-1-irogers@google.com>
Message-Id: <20220518042027.836799-5-irogers@google.com>
Mime-Version: 1.0
References: <20220518042027.836799-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 4/8] perf test: Basic mmap use skip
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

If opening the event fails for basic mmap with EACCES it is more
likely permission related that a true error. Mark the test as skip
in this case and add a skip reason.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/mmap-basic.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index c3c17600f29c..30bbe144648a 100644
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
@@ -83,6 +83,10 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 		evsels[i] = evsel__newtp("syscalls", name);
 		if (IS_ERR(evsels[i])) {
 			pr_debug("evsel__new(%s)\n", name);
+			if (PTR_ERR(evsels[i]) == -EACCES) {
+				/* Permissions failure, flag the failure as a skip. */
+				err = TEST_SKIP;
+			}
 			goto out_delete_evlist;
 		}
 
@@ -166,4 +170,14 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
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

