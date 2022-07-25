Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE1B580778
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237294AbiGYWgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237240AbiGYWgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:36:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00D925C77
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:36:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b18-20020a25bb52000000b0067128e66131so3446482ybk.18
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JzNZf8+4+AkLiixfXHUf0Tr6YoyJNaYpbyf1w4wer88=;
        b=tnK2CIQUOLdZ4NZbW8ydd9eU6zUbz9glKlcJuST5dbUiptR3O3ThSFAQ0hzTsFgi/M
         NowDcyhR/WYcZKYDTuF1UVqvddi196NDL7h9B56XWeG81+krSHJrJ8UIe+OYUoEtgkBT
         Sjw5ZB1LhlZbf00O4oBY8b54KtTpH66DLTo0T3iej+xnCLkeqC4UcUaH96Z6w/Cdtgu6
         O9HrspLmFrWmdNqUYZ9oBf6BeyX/dTlc9k4AFkpyvt0AkV3/YxTnega/9g4bPTYQMixZ
         GF/DdFwc+4dnmAs5s9jzaL5f72uVil7XyXEWodIPwFGAaEdqOMb5E3LBKqG8ePhK1q5y
         c+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JzNZf8+4+AkLiixfXHUf0Tr6YoyJNaYpbyf1w4wer88=;
        b=fcnnoh6Imt9TQmC7zKsOcc89wxRdtPGCkP+nXaLfr+VJWUIMhFbUylHBpRJ9DZSyE9
         bi5pnUmNNzdwdpz5RlkxcQI393aV7g8KnDmEDXlDmYAVDWYSBTcUuJnGsHATJwJvRKOY
         YlpbeUWqZq53RQftZYrmdlO6f1kr2mhJheO6Ass8yE0osBJYefqifGbo51B8c+hT8z+R
         ekhFNV78mAxBfEDlzHkzi7jpExMQsZ1x9LdkfBu9avvh+/39f8RYRNFgGKfyTn6ZKX10
         YAORrbsQloTNS6Qo5eSIl/a1PVFFwI4SSHImHcLUW/YWqOic9VKDFUg8h9j2Eoro+wS6
         14Jw==
X-Gm-Message-State: AJIora+LML1tyIo2dK2BL4PkEKBn8cXUv/xvQ1UuuoLYtXDn9y3EZhun
        vEWGUSvak1tZZv5YGWw++SV+kwFmXZ10
X-Google-Smtp-Source: AGRyM1vrR5j1FUsCLO6h9AJRqbE3AEW5WaFKcvcXiCX4fT2x1gRBbyeIwKk70N2Wu6tK3NlPhG7Ygx/KIhDa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7fbf:ee64:7f7:3631])
 (user=irogers job=sendgmr) by 2002:a81:250f:0:b0:31c:3c38:d3cc with SMTP id
 l15-20020a81250f000000b0031c3c38d3ccmr11998077ywl.306.1658788607534; Mon, 25
 Jul 2022 15:36:47 -0700 (PDT)
Date:   Mon, 25 Jul 2022 15:36:02 -0700
In-Reply-To: <20220725223633.2301737-1-irogers@google.com>
Message-Id: <20220725223633.2301737-2-irogers@google.com>
Mime-Version: 1.0
References: <20220725223633.2301737-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2 01/32] perf test: Avoid sysfs state affecting fake events
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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

