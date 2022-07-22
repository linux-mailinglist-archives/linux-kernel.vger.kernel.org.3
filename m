Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51C557E9AF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbiGVWc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236722AbiGVWcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:32:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CEBA6FB6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:32:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u15-20020a25ab0f000000b0066e49f6c461so4626726ybi.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JzNZf8+4+AkLiixfXHUf0Tr6YoyJNaYpbyf1w4wer88=;
        b=HXPy3Q7C5JFeD8geWVrtDOj5m6jzJnHuooELgwjqkoEsM6EpZlzGFOVPo3skzttWlr
         cJIB67AwmO/WGtRlA/FMWxH+BK+c5D+DgOePQaQZSuUY+yWjtgLB7KaOe9E+Fwqpzy20
         DLkYKAH1mf4XQ6OeECdDAu0CqxqxwFrFJ1uwS9eaJwioqAKgz1n4pJuhc8OIfxnNuAxO
         4bzQ7Om4x7Z/yve2h5KXPdofNZYLkt69gE8YtMNBY70mUKv8YOBRgtHC/3VJFOPuBmLc
         ShJnpd2AXE0MX8Qu1aG7wTrWiHjV9fi3jUvgmvr31uNjr3KRHcUTm7xopWVzW2YLPbef
         LNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JzNZf8+4+AkLiixfXHUf0Tr6YoyJNaYpbyf1w4wer88=;
        b=4VhBoJX7Of3KiPfXUBOpFV7rwzM588V+/9t+ogHgWO/sHB8UbyDU9vzEHPesOejxob
         puT4EP9qlDmKFmFRi4qfZI3iOeoNTYuMqBfvY31XshCBZRg3onEiGbnklXtM4Jpa+1u6
         vMQN6xSIegNWvutpJ8vVbhdgvOWoMiCz+DpRDc7Hc/G3iq9x8gHK3qsviaTwEQkY+0DJ
         KJuTa0WDJHNvFwOT/CfnkGtB1d9qvR2erIxKLD8iyrxhFFRhyePY2p7FU1+sdnd27v7B
         4sEoa+Is9/Yg9ZR/Iael49sgWnOeUZ+/bPnUSsrneB5VhObgLMjLO+VYbzLFrA+/94Ka
         aBKQ==
X-Gm-Message-State: AJIora+09jGUM5GktAWhLJQCGqZhRPac8BB+D9RCmuTjGSQeKGCS8H3T
        CjAAAOOm/MwecB0k/+nT60YeRc7ianLl
X-Google-Smtp-Source: AGRyM1sruwnZKnwPtWtUp67BF9nG0vn8EGplXYGSTiGzRcjThQ4rRs1uXZWCqLqnEtEJOLMHCXDfsGB61dKk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7543:ead8:55fa:3980])
 (user=irogers job=sendgmr) by 2002:a0d:da02:0:b0:31c:a0e9:4165 with SMTP id
 c2-20020a0dda02000000b0031ca0e94165mr1717253ywe.439.1658529173232; Fri, 22
 Jul 2022 15:32:53 -0700 (PDT)
Date:   Fri, 22 Jul 2022 15:32:10 -0700
In-Reply-To: <20220722223240.1618013-1-irogers@google.com>
Message-Id: <20220722223240.1618013-2-irogers@google.com>
Mime-Version: 1.0
References: <20220722223240.1618013-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v1 01/31] perf test: Avoid sysfs state affecting fake events
From:   Ian Rogers <irogers@google.com>
To:     perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Icelake has a slots event, on my Skylakex I have CPU events in sysfs
of topdown-slots-issued and topdown-total-slots. Legacy event parsing
would try to use '-' to separate parts of an event and so
perf_pmu__parse_init sets 'slots' to be a PMU_EVENT_SYMBOL_SUFFIX2. As
such parsing the slots event for a fake PMU fails as a
PMU_EVENT_SYMBOL_SUFFIX2 isn't made into the PE_PMU_EVENT_FAKE token.
Resolve this issue by test initializing the PMU parsing state before
every parse. This must be done every parse as the state is removes after
each parse_events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 478b33825790..263cbb67c861 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -812,6 +812,15 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
 	for (cur = strchr(dup, '@') ; cur; cur = strchr(++cur, '@'))
 		*cur = '/';
 
+	if (fake_pmu) {
+		/*
+		 * Every call to __parse_events will try to initialize the PMU
+		 * state from sysfs and then clean it up at the end. Reset the
+		 * PMU events to the test state so that we don't pick up
+		 * erroneous prefixes and suffixes.
+		 */
+		perf_pmu__test_parse_init();
+	}
 	ret = __parse_events(evlist, dup, error, fake_pmu);
 	free(dup);
 
-- 
2.37.1.359.gd136c6c3e2-goog

