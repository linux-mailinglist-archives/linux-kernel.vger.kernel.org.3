Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDBE5A68C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiH3Qux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiH3Qug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:50:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B177D123
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:50:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v5-20020a2583c5000000b006964324be8cso171965ybm.14
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=hBJ0yO7Shj4BOGRLl4iwSJQIsSnhkgtQ+YJ6SsJa66s=;
        b=qLhpv1pwxbgqPpQ/o53COjLTCFhozgslqRyNRpITJlmata42GDlLUxhGoYQs+ODC1t
         8fT2Qshih9HmV/rWmz320OxcWmiHAJlyFWeZ5ZZn4bUQGNUiZxotR1stKeFzbnY5ZpIN
         G1LthDIugdVVlBwJdWdv8C82rIECXtDmSp/0giPmpiEUEjNGrzUuFYbIfD8TSbz2xNY2
         5rNgIWjMoUwCnoAvub4HPlmth9XcXSQTkKdox5kgwDqjedAvR0y9GZ1kwpn+kwLDOvJ1
         ce94hLNJDKiOEWOnbzsy7bmCxCMeRv4ML+AsMNiPHUh2+SWedFGS8Bp8+2tkZBmA5Z/H
         YYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=hBJ0yO7Shj4BOGRLl4iwSJQIsSnhkgtQ+YJ6SsJa66s=;
        b=2jBkVGlMBX2CrJwDxJ/y58D6orwS5i/DKDySaCBAlmp+xP3erpH0/byHqETn92drUk
         PAV60xlc9OOToYEnW+dqD67AROn0nFLKQJBMj5nyu5JC4S1+x4ckvJp4dMrk++rGBdKy
         k9tpcBc3+FY4jW808HUYJP7NfCQ7Fml53uz033XAZ8uXIWAY/NsXXnq5wjGPm6EmCyVe
         eeaulQB7pJP3i2yJ6xQUI//jLNUVmbyl3GKeNz7MqVsD1/LgL8JkUVF4C2eiIhUhWxGg
         8wgdoe07KCMZ2sdkeCi5bG17Ix/9M/Z4J7ZIsqpShdxJWCuqWJtNQVge9LrZmXRjBd/m
         EG4A==
X-Gm-Message-State: ACgBeo1V5L78KYbYujshvXWUL7C/z7Bu1nJCNcbNQ4fQ7wgVrjs9y/zd
        5z232uhSPpemMkmZmFbkl7KiEdrU2Euk
X-Google-Smtp-Source: AA6agR7UyxomsBLPG4p8omYHrO7FAUbdartUodh6cv14m+BTaKEMB043Thyn84iNKaNbktnxPEd7cmy4vJq+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:902c:b0fa:dec9:8767])
 (user=irogers job=sendgmr) by 2002:a25:3207:0:b0:69a:ba91:9dd with SMTP id
 y7-20020a253207000000b0069aba9109ddmr9781255yby.34.1661878191610; Tue, 30 Aug
 2022 09:49:51 -0700 (PDT)
Date:   Tue, 30 Aug 2022 09:48:46 -0700
In-Reply-To: <20220830164846.401143-1-irogers@google.com>
Message-Id: <20220830164846.401143-9-irogers@google.com>
Mime-Version: 1.0
References: <20220830164846.401143-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v1 8/8] perf test: Add basic core_wide expression test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com
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

Add basic test for coverage, similar to #smt_on.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index db736ed49556..8bd719766814 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -158,6 +158,9 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	{
 		struct cpu_topology *topology = cpu_topology__new();
 		bool smton = smt_on(topology);
+		bool corewide = core_wide(/*system_wide=*/false,
+					  /*user_requested_cpus=*/false,
+					  topology);
 
 		cpu_topology__delete(topology);
 		expr__ctx_clear(ctx);
@@ -168,6 +171,16 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 		TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
 							  smton ? "EVENT1" : "EVENT2",
 							  (void **)&val_ptr));
+
+		expr__ctx_clear(ctx);
+		TEST_ASSERT_VAL("find ids",
+				expr__find_ids("EVENT1 if #core_wide else EVENT2",
+					NULL, ctx) == 0);
+		TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
+		TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
+							  corewide ? "EVENT1" : "EVENT2",
+							  (void **)&val_ptr));
+
 	}
 	/* The expression is a constant 1.0 without needing to evaluate EVENT1. */
 	expr__ctx_clear(ctx);
-- 
2.37.2.672.g94769d06f0-goog

