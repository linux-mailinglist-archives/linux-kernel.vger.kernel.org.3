Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662FC48E46D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbiANGvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiANGvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:51:10 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856F7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:51:10 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y10-20020a2586ca000000b006116aaeeee6so16173659ybm.21
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LDwm4hnT7Bk0Sbi/T1/8Yk0x2iaTja6ZT3of8YSmJeU=;
        b=XPw44X2fTrMNJiw8DtD81VSxYEHznaWrOMYhAqhnKENIrDnI2ZOwKWuFDbYybuJNMO
         wwpkbhM+3xjm9kV4oF+24DgQoduuwR5nRbgDi+xsy2hYZbnACROcTjjij5n7KLQQg05V
         sOtX47QqVDZ1uIlpirCPy9h+6tYUFUrxL+MdApk9G2dIGLii+hpqiF2keRdeHfMq3KGm
         hTssq+cIHPz6d5RE+t/2U3OUzANWn4sO4BcYXk2MpSigpRNfrfWGmNqBIQ1MAqMx9iEh
         TeCJLApid4xAcs/x0kmGFORzwav2sVvD4aM/qOat0XRabrx4MOk8Zv8xjGe6w5ihv3e4
         H5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LDwm4hnT7Bk0Sbi/T1/8Yk0x2iaTja6ZT3of8YSmJeU=;
        b=lSJqZ1Eptyow7VLmQiPxkq64uazYIYACLO/JMjT5E+4rBATH4Acsj+HG1/S1ih5WZ4
         MDtlFaxBZcCzkzK0CQJWQ99kMYs8GVdFCPl1ccJoEWB8sKjZuTAUvfCyc1U1CabZOQvS
         AKLoNf127+Yd0j7a1uqOEQ6qwwhE2tHRPM86HvraBU7sUDOkIL4ie8ERGH30C3GReVef
         h1VitVx37+mOakjp7+YJTUL6SXzWj45zb03y0u5nFcYLhkzhJmO0OM4a+RsxhEpi0BYe
         bA0av+awxY9QjuhIF4B7wjFRj2LAsUI+fks3NQPhRml67SMuS95+UJkU9zC/wBn/Nvvg
         Zo7g==
X-Gm-Message-State: AOAM533rdcqMACsVqhhxhyXheDbf823kRZeLevbaq00yu11xZDl7+rLj
        jHqavEbd/LfQWEa+v9IzwvAuc5cqDoDM
X-Google-Smtp-Source: ABdhPJwFeqSCtfOlYXdrcLc5Y8RJDAM3kwLMD0StphbD7/oIG+kCDuB1Q+cEqG0wNfBfli2R9A2Ixv7mqsYD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:de36:7cc:6c7a:b7cd])
 (user=irogers job=sendgmr) by 2002:a25:2cc7:: with SMTP id
 s190mr4039605ybs.186.1642143069821; Thu, 13 Jan 2022 22:51:09 -0800 (PST)
Date:   Thu, 13 Jan 2022 22:51:05 -0800
Message-Id: <20220114065105.1806542-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH] libperf tests: Update a use of the new cpumap api.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Colin Ian King <colin.king@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a build breakage.

Fixes: 6d18804b963b ("perf cpumap: Give CPUs their own type")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/tests/test-evlist.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index e7afff12c35a..b3479dfa9a1c 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -334,7 +334,8 @@ static int test_mmap_cpus(void)
 	};
 	cpu_set_t saved_mask;
 	char path[PATH_MAX];
-	int id, err, cpu, tmp;
+	int id, err, tmp;
+	struct perf_cpu cpu;
 	union perf_event *event;
 	int count = 0;
 
@@ -377,7 +378,7 @@ static int test_mmap_cpus(void)
 		cpu_set_t mask;
 
 		CPU_ZERO(&mask);
-		CPU_SET(cpu, &mask);
+		CPU_SET(cpu.cpu, &mask);
 
 		err = sched_setaffinity(0, sizeof(mask), &mask);
 		__T("sched_setaffinity failed", err == 0);
-- 
2.34.1.703.g22d0c6ccf7-goog

