Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6630470C35
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344318AbhLJVHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344440AbhLJVG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:06:58 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D595DC061D76
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:03:16 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id j204-20020a2523d5000000b005c21574c704so18395489ybj.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9AW/h2EH8FSwaTBPSLp2XOJkstPgBdV4XDrQyfa2080=;
        b=ZtztBcoWdSinY1qP3jjGUUIugfCD0TL1OcDdPLUvqCB8qPtiCqT1hPq2G23DL6tem4
         fsPLamM+X2bbze8F/S/q6xomxZfRviiOk9QG5dpHmxGXm4Pa5gmtlSFAVWxYY0CpINGG
         Jd2czuVkjrs9sVO9vvh8/aemdU/h5IHo0SDbC5lr8Yevg70VuETm1SHKR6Ht/PALbfJY
         H8ljeHPVPSRHHpwi6ucUOwsmIYS4LfTKRnqDScQnDCZHHheORYGCw2LpOBU9uqD4EDp7
         FTq3nARis+mvhrLFWv4iFaEoy6bdyRckVx06aCLSa8QnbxaNvHUoVFd7aMZeuh8WvEee
         0rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9AW/h2EH8FSwaTBPSLp2XOJkstPgBdV4XDrQyfa2080=;
        b=lZK9h5Efp47QLGkebSoc/liAkvvb0xgB3LtMEoPUOKPngkqlBtqkKhemegWxBlgYDV
         fn5c302NYqcpzoiDtc1oEEgDvXyvvnVTvp2OCHfOMfdAPnpQ6jZH+314c/XbfrCr3CSv
         iAm2EqRK5t4tOsAxR/SOtBLB4H76440/BBqFp7PrFHiE2dDXPr47EhgRjX8EhIgXvkUk
         Ii1HSWIHZW786XiZB/AbJmtmXfdWtQD4miXQ5Ne4tHlLaRaQfhbAXJmt055hgYYpzQK0
         hlv0AwlnEWYqBdH4jeYaltLXst13R6lV86BfRyKSVKvsvxflg0NTjfsb7ABXvoAIgFnD
         tQfA==
X-Gm-Message-State: AOAM531lMr45VjCkSfsi2a3vpQfwCOiQXfgiLb3xqI0KZ1ysaaWJvJr7
        8HK9vhw2r39Lc1xTMBNmlh4VOg61vNwZrVw+nCJD3MGHk3Xn64/h0IxJQ0l4OgIDUUgWg1YYiY8
        oRRnmb2rbd+rdTPDBLNFg1ONwz2ESO5q/fp4Q0RfyXMGqnYbRBofFPaPL35foe3Mju3/DOHWr
X-Google-Smtp-Source: ABdhPJzUY2dP8oB9I7DI7J8NcTtl23vkIv2aIVi16e6vDx/eqDIAOsBc8pmZBZzkGn+DiBfbBASi8GxsH5/A
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:7416:17a6:6678:d4d5])
 (user=eranian job=sendgmr) by 2002:a25:903:: with SMTP id 3mr17532259ybj.378.1639170195958;
 Fri, 10 Dec 2021 13:03:15 -0800 (PST)
Date:   Fri, 10 Dec 2021 13:02:27 -0800
In-Reply-To: <20211210210229.2991238-1-eranian@google.com>
Message-Id: <20211210210229.2991238-13-eranian@google.com>
Mime-Version: 1.0
References: <20211210210229.2991238-1-eranian@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 12/14] perf tools: Improve IBS error handling
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

This patch improves the error message returned on failed
perf_event_open() on AMD when using IBS.

Output of executing 'perf record -e ibs_op// true' BEFORE this patch:

The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (ibs_op//u).
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
---
 tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bb122979ef2c..ff9a755b869f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2852,9 +2852,22 @@ static bool find_process(const char *name)
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
 
@@ -2950,6 +2963,17 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
 		if (perf_missing_features.aux_output)
 			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
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
2.34.1.173.g76aa8bc2d0-goog

