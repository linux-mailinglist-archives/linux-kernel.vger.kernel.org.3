Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79884E4907
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238251AbiCVWRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbiCVWR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:17:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BC85370C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 190-20020a2505c7000000b00629283fec72so15593011ybf.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2fFnNoJQ3H9hVlBp1UXUfdC5Kvmn9rISGKDSRRVelmI=;
        b=FeK8lZX/ROxlGZdXcfs3viVelDZve+bBs7HH6xjHv4eJzGcbkdJsHU3ntygvtCUVdv
         NkJDOEKDSVaTVVsIpTZvk2RI17GNfD/pBO6FMzyEfAAbKW81vTjR5OG4LDX28/UbGB7/
         GwS0ShbbmF6ggSA0boU17tSlUhud+E45xsmvm2cLow8VusQXIHaREHjTh7IB91L018Kj
         2l3o0VFKO2Nsot2yfkJ6lw7/CZXbVQeSRXc0FYiGtpKMxtpVSQgObgpjSNFtzlC+RA1A
         y5H4DxQtg+OLmsSv2AILaNhpYcEaomltUcM87D/LWfe6DNXBZ2T1iUBKz3sRh9N2mrmY
         tT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2fFnNoJQ3H9hVlBp1UXUfdC5Kvmn9rISGKDSRRVelmI=;
        b=A7FV1NgXXvmLSJoBqEa3NWG2ZRz1y8J8iu4lNMQOZEr5UNPOSYyLB94HKen0r7GiXv
         1ihEeOs5gGpVjw0gtZy5rh+7d8W3h8QZexCT6XPetFe00IAdecjfN66ADFPGpwGuSYta
         EoCDqvfFlUtMlG3LCV5Pbfqpbn/zjPEeU8S2ZyrBgf7kjVRaxnPboyPX2Jpa+jLNPwNe
         Fsw3f/949xDn/2EiO+jfBRXwyQvZAdGS8BHK5VmZ2PG3uLpsxZmC0MzX/rWaDDs4tRmJ
         k7pNWCBZPrgFk7EM3Zd+5F0ZoQnt/6iyQna694FOPt5lBVl+qs3huBa4/TgncUsOGxPs
         eAbw==
X-Gm-Message-State: AOAM5321/Kfn71b4OejGjQElFXZR6GowXZ7cXUlWo3c/wLpS+d5Zb+yz
        wK4d83TUq+aeoGCgHj9bzmoiYMpCYAg0DuwrsjVKBQpL/vCNPfNTPbXwxQcEGmIi81DELVWSgeI
        NCLE9/QH4cW2R7Y63W6Vj5v56WQerBK+el7QUED+OqPRDR17tc+ic+3wx8O+MVtxakFAuyLWf
X-Google-Smtp-Source: ABdhPJw3TC+WRfnFqahAcvGue3nO6s3yog1WpVhe27t0TXbnHPo6u9I//9ZYQkF2rNY9FfXGVLe011cHC51i
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:1817:acc9:c45f:d133])
 (user=eranian job=sendgmr) by 2002:a25:3246:0:b0:633:af97:a3eb with SMTP id
 y67-20020a253246000000b00633af97a3ebmr25789591yby.274.1647987352324; Tue, 22
 Mar 2022 15:15:52 -0700 (PDT)
Date:   Tue, 22 Mar 2022 15:15:15 -0700
In-Reply-To: <20220322221517.2510440-1-eranian@google.com>
Message-Id: <20220322221517.2510440-12-eranian@google.com>
Mime-Version: 1.0
References: <20220322221517.2510440-1-eranian@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v7 11/13] perf tools: Improve IBS error handling
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
 tools/perf/util/evsel.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 14b0e7ffa2c7..e8ff7a4bd490 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2847,9 +2847,23 @@ static bool find_process(const char *name)
 	return ret ? false : true;
 }
 
+static bool is_amd(const char *arch, const char *cpuid)
+{
+	return arch && !strcmp("x86", arch) && cpuid && strstarts(cpuid, "AuthenticAMD");
+}
+
+static bool is_amd_ibs(struct evsel *evsel)
+{
+	return evsel->core.attr.precise_ip
+	    || (evsel->pmu_name && !strncmp(evsel->pmu_name, "ibs", 3));
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
 
@@ -2949,6 +2963,17 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
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
2.35.1.894.gb6a874cedc-goog

