Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478B749D639
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbiAZXfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbiAZXfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:35:42 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445A0C061748
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:35:42 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i10-20020a25540a000000b0061391789216so2505615ybb.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u40v3A88SWtp2fNVtkTaXKsA+Kiha4KEARLMzlKkiKY=;
        b=p2QpXTExJCnX5hpOvaf1fzVp1xLUKwaOWgEZY830jsEJ3yK/LxXcI7GIRPOF4tKk3n
         z9NDdSe/2a0IiHYHO86WOqIi7zl3CoNsw9ECPgAfJoM2r0qzWVd68Bb63oUVk5pUnXK9
         LyDZsYFrSJS0lgc1yofzcmtopGrhv9NfojkrAqoVmE42OdQqQEBJzZT7ch1Ur36gRzNK
         1at7MCEw7iJp/U44+Bee11PZ0prW96u6DhLouWFO7gmDoi+MvR0pTPDA3zT61oqlRO3Z
         ZxP3pB5Yp5cAB6vjUJUAgdEONvoPEMSqkvoWF202GikL/dF73kfQE0lHISE7tAbDS25l
         f+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u40v3A88SWtp2fNVtkTaXKsA+Kiha4KEARLMzlKkiKY=;
        b=ZUsTZ1vwiCME6+A58e/Yf2Ih1WwYB3413/YKsMbXBh93PqDDLSAs5bh1dvVF//PVu+
         vVjIdpBW0h3Pq/deS5D48wJ5vcxHLWHP7tTzWgrzz8KoUc5cVCZ9xyfb6GPY9bxOvzrd
         6RR0ACFEk4cCGIo5deRWwwWtzC5H5ilAOEIEd4UKOLKd2qiNnNG6uWygvv4YLFihL4yG
         zm3JUioSBFwRbhtUGQ2FqfJOpX7zcvKQtFTfLsAudaXWDqlYgXFo6DmIamRyUqMuhxPS
         yLsjh7hUCFV+3z8q0SPOlDBtJGtIPWOHFv2PI1WfhzQEYrMz0A4O8o1mAZt68QscNVCs
         q5xA==
X-Gm-Message-State: AOAM530ED5S1hXhHUfdTe3RP0Eftvirb1ZKXNyRT8Jg4Mktp0cWSZRrl
        hkBHmBunJfRYZyeB6W5ZBsvqSuFv0I+kXLk+KuDWZZ1LEsjxfmjB9/ceY1DXOhlv+R9qLOH3Nqt
        GxU6NGYylJi4DWWkhLW3kZeiDy4xF1jhOb9eaWmM0H0TPQaCBo8whCROEVkyCIDCw8ZgdW5rQ
X-Google-Smtp-Source: ABdhPJx5XZY7CZy40sb6duptOtKlCR4iTr34mPC8dxRYof/X8BI78AdP3uavEVtGo7F2SfNqVw2I9JruAqor
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:9ce0:6f20:c145:eac])
 (user=eranian job=sendgmr) by 2002:a0d:f244:: with SMTP id
 b65mr1ywf.2.1643240141001; Wed, 26 Jan 2022 15:35:41 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:34:52 -0800
In-Reply-To: <20220126233454.3362047-1-eranian@google.com>
Message-Id: <20220126233454.3362047-12-eranian@google.com>
Mime-Version: 1.0
References: <20220126233454.3362047-1-eranian@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v5 11/13] perf tools: Improve IBS error handling
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

This patch improves the error message returned on failed
perf_event_open() on AMD when using IBS.

Output of executing 'perf record -e ibs_op// true' BEFORE this patch:

The sys_perf_event_open() syscall returned with 22 (Invalid argument)for event (ibs_op//u).
/bin/dmesg | grep -i perf may provide additional information.

Output after:

AMD IBS can't exclude kernel events.  Try running at a higher privilege level.

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
index 14b0e7ffa2c7..a9d506ec3ab9 100644
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
2.35.0.rc0.227.g00780c9af4-goog

