Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C417A4E4904
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbiCVWR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237813AbiCVWR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:17:27 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F75953B5D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:55 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2dbda4f6331so160960457b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6vrbVWZeWSTE7ExL6L9z77MiqrapvH5PS+af5bIC2bo=;
        b=pft1iLeDozdW+aGLGObBlQ4RXWkQkZNt/AsY15aagO6QDGpISgR1GoRUFWjmimQpCI
         fRq/a5H9rGLIKm9S7rd568cwUVCTUaL7lEYrFxKOLSawGaB8rmt5RyGel8F1ztJNEmmc
         PLCJdph2gEpJ7h8d4TD+frrZQBR8ThPqjgIIWcBRmRbBpqewd9rEupyPSTeIazmPO+sK
         DlIENIaLVp5nUcTO8BWpoNposDuU1CFUNw3oa0G3LqBHrsy0xFSJThxmbz8U/sAwl6Hn
         pz36XeZxDVrgpI8Ow4AvNe6N3dxUeFvOpqdRxK+0v8EV59YXOUa2xA56v54taPBKYNFs
         cAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6vrbVWZeWSTE7ExL6L9z77MiqrapvH5PS+af5bIC2bo=;
        b=VUoiqwTTWHDIGJHWIcCK0WqASHV/hFX+5QFb/HoZ7Xz+MJHSxXq0mBMG42eupowuKq
         7amJqllWI+0fbt2zxwVd6cnMb/5VBW4XMHOqtN9fRxTiW0CKqPmRz8TODXRwuMn/Q4Jb
         SxHFbyJ4txPNfzlEGt8rkhFM7oFDORQLMMePoUQ05DykMNyMRwAI2YP5/nrks9VxPB2j
         HPTTz3OrYcej5HrM9ZeXHQNefalaAHPL+3MC/DnITJOwAWIr8FpfIm/k8dwWAl5WYfBu
         dkF5114dN74llwFZMfhD9eOVfYa/7kpRnTOVwmgg2f8Vbq9AVjlmVbdjlfj4FWiIe6a1
         Ixzw==
X-Gm-Message-State: AOAM533VXmnhv+AFREFVhx+pRc9YWU4kbdkJK4Tm0dgOl7OJhwhSNpS1
        StmUwQ5jE7VLqubqZJL4RlD7Tt9zygaIKsThfM2gd3KFWk2rS2GGdCToMbXsaIMiDVmqDdePzZQ
        OTUx9Dqzjj37EKBHa1wSRv1s/iaTu9VBmOndlNvlek3y5XUp3DFcBCpOnq7a+d65wKk5Als4O
X-Google-Smtp-Source: ABdhPJyYUP0ELMvZXftTbIvTFbsq1bERG/w+ZBHS5SRMTw0bT6eC7BF5oah4p48aG7jyrrv+M8xNgH6fy0KA
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:1817:acc9:c45f:d133])
 (user=eranian job=sendgmr) by 2002:a25:358:0:b0:633:7a26:5ff4 with SMTP id
 85-20020a250358000000b006337a265ff4mr28403773ybd.97.1647987354532; Tue, 22
 Mar 2022 15:15:54 -0700 (PDT)
Date:   Tue, 22 Mar 2022 15:15:16 -0700
In-Reply-To: <20220322221517.2510440-1-eranian@google.com>
Message-Id: <20220322221517.2510440-13-eranian@google.com>
Mime-Version: 1.0
References: <20220322221517.2510440-1-eranian@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v7 12/13] perf tools: Improve error handling of AMD Branch Sampling
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, rafael@kernel.org,
        ravi.bangoria@amd.com, sandipan.das@amd.com
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

Improve the error message printed by perf when perf_event_open() fails on
AMD Zen3 when using the branch sampling feature. In the case of EINVAL, there
are two main reasons: frequency mode or period is smaller than the depth of
the branch sampling buffer (16). The patch checks the parameters of the call
and tries to print a relevant message to explain the error:

$ perf record -b -e cpu/branch-brs/ -c 10 ls
Error:
AMD Branch Sampling does not support sampling period smaller than what is reported in /sys/devices/cpu/caps/branches.

$ perf record -b -e cpu/branch-brs/ ls
Error:
AMD Branch Sampling does not support frequency mode sampling, must pass a fixed sampling period via -c option or cpu/branch-brs,period=xxxx/.

Signed-off-by: Stephane Eranian <eranian@google.com>
[Rebased on commit 9fe8895a27a84 ("perf env: Add perf_env__cpuid, perf_env__{nr_}pmu_mappings")]
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
 tools/perf/util/evsel.c | 43 ++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index e8ff7a4bd490..03f720a85764 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2858,6 +2858,16 @@ static bool is_amd_ibs(struct evsel *evsel)
 	    || (evsel->pmu_name && !strncmp(evsel->pmu_name, "ibs", 3));
 }
 
+static bool is_amd_brs_event(struct evsel *evsel)
+{
+	return (evsel->core.attr.config & 0xff) == 0xc4;
+}
+
+static bool has_amd_brs(struct evsel *evsel)
+{
+	return (evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK);
+}
+
 int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			 int err, char *msg, size_t size)
 {
@@ -2947,6 +2957,28 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 	"We found oprofile daemon running, please stop it and try again.");
 		break;
 	case EINVAL:
+		if (is_amd(arch, cpuid)) {
+			if (is_amd_ibs(evsel)) {
+				if (evsel->core.attr.exclude_kernel)
+					return scnprintf(msg, size,
+	"AMD IBS can't exclude kernel events.  Try running at a higher privilege level.");
+				if (!evsel->core.system_wide)
+					return scnprintf(msg, size,
+	"AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity");
+			}
+			if (has_amd_brs(evsel)) {
+				if (!is_amd_brs_event(evsel))
+					return scnprintf(msg, size,
+	"AMD Branch Sampling can only be used with the cpu/branch-brs,period=xxxx/ event or equivalent encodings.");
+				if (evsel->core.attr.freq)
+					return scnprintf(msg, size,
+	"AMD Branch Sampling does not support frequency mode sampling, must pass a fixed sampling period via -c option or cpu/branch-brs,period=xxxx/.");
+				/* another reason is that the period is too small */
+				return scnprintf(msg, size,
+	"AMD Branch Sampling does not support sampling period smaller than what is reported in /sys/devices/cpu/caps/branches.");
+			}
+		}
+
 		if (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_SIZE && perf_missing_features.code_page_size)
 			return scnprintf(msg, size, "Asking for the code page size isn't supported by this kernel.");
 		if (evsel->core.attr.sample_type & PERF_SAMPLE_DATA_PAGE_SIZE && perf_missing_features.data_page_size)
@@ -2963,17 +2995,6 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size,
 	"Invalid event (%s) in per-thread mode, enable system wide with '-a'.",
 					evsel__name(evsel));
-		if (is_amd(arch, cpuid)) {
-			if (is_amd_ibs(evsel)) {
-				if (evsel->core.attr.exclude_kernel)
-					return scnprintf(msg, size,
-	"AMD IBS can't exclude kernel events.  Try running at a higher privilege level.");
-				if (!evsel->core.system_wide)
-					return scnprintf(msg, size,
-	"AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity");
-			}
-		}
-
 		break;
 	case ENODATA:
 		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
-- 
2.35.1.894.gb6a874cedc-goog

