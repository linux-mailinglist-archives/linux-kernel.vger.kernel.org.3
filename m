Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA8E52B161
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiEREU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiEREUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:20:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027D431239
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:20:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i17-20020a259d11000000b0064cd3084085so902543ybp.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MAjYUcMF8cvSpD3IrXmmGZ0bseIJMHTYZTi0/EOkzbY=;
        b=hv3dMBW1DzxUFqDSoqbUa/6gJniNJqbIIJNdZQcmA7P+ITyZmLb6I5NNftuPGDYfGW
         okMSyVlMbNG3+WuXeFKmZQs4JS4kvG9SmunFGg6AvF1NQVTEiLeA8wNRh+wmBTVlB3v4
         iF4940Rek9QdNEqLGRRe+xga0x1HVwIJWCmmDepx2hLrScQOcbl+Kg6jkBTPjuPMoqS5
         FZSRfzmxjAuIoRWS8Pt2+M/ImhPMQ0MLNojnqR1RHXD8bFKa9hGQ1iC2XIIKLE4OuLkE
         km7Scd7JnQ7jbphbMcPhJk+uiojuwneha8rMzg0EFkY6rGZR5rNAdC/cqDaFMglmH5rw
         anUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MAjYUcMF8cvSpD3IrXmmGZ0bseIJMHTYZTi0/EOkzbY=;
        b=uyNmnWia0rccFY9l8KWJmcozOyUeNvgUf3DKDKepjWn23zJLxWUXQqWF6+/lU4ssLO
         oHgdiqS7Ooj3RNaVDi22OO918yUKDEQvZEhxN6yhTYJiJr8DCA+o3+rzY4lz5Wf0aAtu
         XM2oP/QJ8gPXHRgmiyRGZxTy5L1J3WvndlhFhY9TdD3v5Qw3ng1G7moX2kcsPNIZWMa1
         IkafhL+PxyeeP8aYG6FjoZYZ/tfhiCud43vmVH1WbbCA3Nk0sJeK1Q271CrR6wmDUy/g
         l4wPWZZVLJMxB6qQGN2pxlWDnSqvueXJPS6DwZy87grRQu8WdARnDtoFkHHOHAClvC0H
         pdbA==
X-Gm-Message-State: AOAM5322IfcdhuGXmz4UXZ9FIoc6cZMPrmg5aIHAobiCsdkSMDjINwl7
        abKkKDXouP+e+CIkFaiGLiyTxaUjeSRt
X-Google-Smtp-Source: ABdhPJz/Y25em1LQBTduunNiZnS002a0H+EyC5tCC0TQ93KtFWaUz8g3VoSCuofQQQbf9zZEVQ5oPizqZzlx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a5a1:af73:fe09:fd5])
 (user=irogers job=sendgmr) by 2002:a25:c7d0:0:b0:64d:a15e:7599 with SMTP id
 w199-20020a25c7d0000000b0064da15e7599mr13472934ybe.251.1652847644539; Tue, 17
 May 2022 21:20:44 -0700 (PDT)
Date:   Tue, 17 May 2022 21:20:24 -0700
In-Reply-To: <20220518042027.836799-1-irogers@google.com>
Message-Id: <20220518042027.836799-6-irogers@google.com>
Mime-Version: 1.0
References: <20220518042027.836799-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 5/8] perf test: Parse events tidy terms_test
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

Remove an unused variables. Make structs const. Fix checkpatch issue wrt
unsigned not being with an int.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index e71efadb24f5..7e802666d2d5 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1980,11 +1980,10 @@ static struct evlist_test test__events_pmu[] = {
 
 struct terms_test {
 	const char *str;
-	__u32 type;
 	int (*check)(struct list_head *terms);
 };
 
-static struct terms_test test__terms[] = {
+static const struct terms_test test__terms[] = {
 	[0] = {
 		.str   = "config=10,config1,config2=3,umask=1,read,r0xead",
 		.check = test__checkterms_simple,
@@ -2112,7 +2111,7 @@ static int test_events(struct evlist_test *events, unsigned cnt)
 	return ret2;
 }
 
-static int test_term(struct terms_test *t)
+static int test_term(const struct terms_test *t)
 {
 	struct list_head terms;
 	int ret;
@@ -2139,13 +2138,12 @@ static int test_term(struct terms_test *t)
 	return ret;
 }
 
-static int test_terms(struct terms_test *terms, unsigned cnt)
+static int test_terms(const struct terms_test *terms, int cnt)
 {
 	int ret = 0;
-	unsigned i;
 
-	for (i = 0; i < cnt; i++) {
-		struct terms_test *t = &terms[i];
+	for (int i = 0; i < cnt; i++) {
+		const struct terms_test *t = &terms[i];
 
 		pr_debug("running test %d '%s'\n", i, t->str);
 		ret = test_term(t);
-- 
2.36.0.550.gb090851708-goog

