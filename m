Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10144AE40E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386797AbiBHWZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386874AbiBHVRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:17:20 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F213FC0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:17:19 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q199-20020a252ad0000000b0061e113c9953so257466ybq.18
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XenqmXleccybpW6tauROr+uyQr3Aow8wYknpY7cyN4o=;
        b=gRInUedMBFu4RCwxude+HLD90BW8l2ZI8mFca/kltWg371JlYLIBMWMbAMzSuQmw7u
         Qi8pj0cGI9jy7DVl5fDM2MHbSIdL6w+iLq0sdeYLh9oRTKUKA/E4QJKgylzv1AF7yDqB
         J4N1iKfNYXwUxKlrdrAsVX1uJFRoARxW8IYWkU/hD3f2xY6/TyRdrreFmpoQ1jENGUIE
         ItuevWzJQ+YAIUegro0s8jXxgQxTNg1BsgJANoJGkXXbLSJEe2R29OGgWt4YcrC4LLBN
         fNQwzMWwvnHRs4xNh7zKqlFYJJtz5Y03ufouQsNYe9klgiUsQ1nz6kfc/oKW2rc8ZCzx
         SX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XenqmXleccybpW6tauROr+uyQr3Aow8wYknpY7cyN4o=;
        b=r4G18Zo/9gx055gTXiNKsI1vYN+cJxvUH8jhKBpWAtoNQYBBsJxBe5AtPGEe4VJIg/
         hDzzWQT6sjvH1S8CPAVqnrq5FvfFv2Jwo0iYVpLu9Y5wF+Xxh4SjCBxBkLyicVy8md6c
         S9OPp5jZ2lio5CdJ6On3Wq8nUW10qEkVaB8kQDqja6L5VCItIXG86fe6NBT+/GBdZ2Cj
         bD+mKnzbDuEZHDLl5IzMKbV4mVGi/wIg+Ry9DE6ap5REdbncjyM1r+wyQdP/69MlBBpd
         71gwiWlzSClALDohD+E1E9yPdgem2R48NXpF7jcBz3qrSWP7VDLPG3iaQwW5pbRMWhA6
         wPEg==
X-Gm-Message-State: AOAM530YSOobHdmpH9E+e90quLKC46oAANtHhYselXJOgniTtnEQiGby
        h/njw18c6DjTR4SvJuJ4WsilOA/89bP1a8IHkYzu71Gf90DjFpuXDOxM9HP5Bs8nCO0XVthZFaU
        kzDA8F4aNU4Z72wlojpRuvBpNP6Ol1aE9JUVuEP2uCK1Q6JsF1J6HVqvjTHa3h1GHgraBkQvc
X-Google-Smtp-Source: ABdhPJzIZgA6dXUwM0NAYtLt4hdqaYI3F874SQXFKePsPfh0W0XbyBxDauA/Fd396Gng+Kf61QspPBVXxHhk
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:6875:3c51:69be:6e2c])
 (user=eranian job=sendgmr) by 2002:a81:c607:: with SMTP id
 l7mr6851336ywi.265.1644355039100; Tue, 08 Feb 2022 13:17:19 -0800 (PST)
Date:   Tue,  8 Feb 2022 13:16:35 -0800
In-Reply-To: <20220208211637.2221872-1-eranian@google.com>
Message-Id: <20220208211637.2221872-11-eranian@google.com>
Mime-Version: 1.0
References: <20220208211637.2221872-1-eranian@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 10/12] perf tools: Improve IBS error handling
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com
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

From: Kim Phillips <kim.phillips@amd.com>

improve the error message returned on failed perf_event_open() on AMD when
using IBS.

Output of executing 'perf record -e ibs_op// true' BEFORE this patch:

The sys_perf_event_open() syscall returned with 22 (Invalid argument)for event (ibs_op//u).
/bin/dmesg | grep -i perf may provide additional information.

Output after:

AMD IBS cannot exclude kernel events.  Try running at a higher privilege level.

Output of executing 'sudo perf record -e ibs_op// true' BEFORE this patch:

Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (ibs_op//).
/bin/dmesg | grep -i perf may provide additional information.

Output after:

Error:
AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Richter <robert.richter@amd.com>
Cc: Stephane Eranian <eranian@google.com>
---
 tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 22d3267ce294..d42f63a484df 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2847,9 +2847,22 @@ static bool find_process(const char *name)
 	return ret ? false : true;
 }
 
+static bool is_amd(const char *arch, const char *cpuid)
+{
+	return arch && !strcmp("x86", arch) && cpuid && strstarts(cpuid, "AuthenticAMD");
+}
+
+static bool is_amd_ibs(struct evsel *evsel)
+{
+	return evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name, "ibs", 3);
+}
+
 int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			 int err, char *msg, size_t size)
 {
+	struct perf_env *env = evsel__env(evsel);
+	const char *arch = perf_env__arch(env);
+	const char *cpuid = perf_env__cpuid(env);
 	char sbuf[STRERR_BUFSIZE];
 	int printed = 0, enforced = 0;
 
@@ -2949,6 +2962,17 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size,
 	"Invalid event (%s) in per-thread mode, enable system wide with '-a'.",
 					evsel__name(evsel));
+		if (is_amd(arch, cpuid)) {
+			if (is_amd_ibs(evsel)) {
+				if (evsel->core.attr.exclude_kernel)
+					return scnprintf(msg, size,
+	"AMD IBS can't exclude kernel events.  Try running at a higher privilege level.");
+				if (!evsel->core.system_wide)
+					return scnprintf(msg, size,
+	"AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity");
+			}
+		}
+
 		break;
 	case ENODATA:
 		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
-- 
2.35.0.263.gb82422642f-goog

