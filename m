Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BA2591788
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 01:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbiHLXKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 19:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbiHLXKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 19:10:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7D79BB7A
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 16:10:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s15-20020a5b044f000000b00680c4eb89f1so1795817ybp.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 16:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=YiyvC5KcLJL9/nnX+SFeTIrRtpkkdHYbCWBdgzmu8kY=;
        b=Da16TEv/4coRpuTFpJa27ZXTP77mj0yprgQil4DtOi02L2ulStByB/BXJn1UgSQSt2
         ijc4vnzrQBDCVUlDRA6+lVypjyyZzeJqPXE+CyLmPMyLq00MgQM2ZrG4SYrw3I4Tr9Kg
         SF7DXRuh2OEB3Xwd9ZbjQhQYZsIosAlNNfpIesLnV6z6D/kOhbFp1j2t1H+UmtK2z6e5
         ffyNv5Slc693/I/rscqd/qOlaGRqqONonCgtcvoinKGuoE4W0Jr4gyc8MhPJv4/jQ7fD
         Kzz2xVxdwSZqU9Un0j3QpcETvKwqaEdQYXMMzieTf9FuHf7WoMcIvEFQ4KCWCZ5T7TqW
         sdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=YiyvC5KcLJL9/nnX+SFeTIrRtpkkdHYbCWBdgzmu8kY=;
        b=P1s6k+HKnB5vsukfPq4D08i9yRIf3VFdvKYJnZMxgs4Lj55sZO2gviNjk/32+6SP3O
         seUNTiXvQNyPs4rF7CSU9S/N2AHUE8HLO/wnyo4YURGOTfCx9IHKM1NX+ME45icr5tfU
         ezvvIV9MQ+qopvf2hjHvjOJcAvyhqa3WI8wk6qApFdDt6Ofr042//8wPpdBxzvcTh23S
         moQZ2zuL2gMXJOmBrQaaHWnQNOpvc/59iuAqQkmQNmCVewOc23fvNHsDafynlt6WYHWy
         iiy+GGnDPN7SyQMVfidawkwoNqyHBKB2HKof7f3Jvwu2v+xsJB0aL/gsg8hq8mzpkXrl
         VP4Q==
X-Gm-Message-State: ACgBeo2AHFTbOYAt4SzKBx9yojb8Lk7vlM5re7IYXcBurUfV4YdPeVto
        I8haCq6NC8rW3+Gs1QgRFuZ+EmwokZvk
X-Google-Smtp-Source: AA6agR5gweXDu/o9LyYcK9Rge043hhUd0+JgvYx1OMtiTLDz0icypzu5szu4NIxcrgHjRFsQXIapBAxkT+5f
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:d668:2937:8218:c5ec])
 (user=irogers job=sendgmr) by 2002:a81:144f:0:b0:31f:43ce:de37 with SMTP id
 76-20020a81144f000000b0031f43cede37mr5830739ywu.142.1660345799751; Fri, 12
 Aug 2022 16:09:59 -0700 (PDT)
Date:   Fri, 12 Aug 2022 16:09:37 -0700
In-Reply-To: <20220812230949.683239-1-irogers@google.com>
Message-Id: <20220812230949.683239-3-irogers@google.com>
Mime-Version: 1.0
References: <20220812230949.683239-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v5 02/14] perf jevents: Remove the type/version variables
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
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

pmu_events_map has a type variable that is always initialized to "core"
and a version variable that is never read. Remove these from the API as
it is straightforward to add them back when necessary.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 4 ----
 tools/perf/pmu-events/jevents.py         | 6 ------
 tools/perf/pmu-events/pmu-events.h       | 2 --
 tools/perf/tests/expand-cgroup.c         | 2 --
 tools/perf/tests/parse-metric.c          | 2 --
 5 files changed, 16 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index d8cf9283e486..4182a986f505 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -112,15 +112,11 @@ const struct pmu_events_map pmu_events_map[] = {
 	{
 		.arch = "testarch",
 		.cpuid = "testcpu",
-		.version = "v1",
-		.type = "core",
 		.table = pme_test_soc_cpu,
 	},
 	{
 		.arch = 0,
 		.cpuid = 0,
-		.version = 0,
-		.type = 0,
 		.table = 0,
 	},
 };
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index b49a0dd946b7..8e8462cb359b 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -313,8 +313,6 @@ def print_mapping_table(archs: Sequence[str]) -> None:
       _args.output_file.write("""{
 \t.arch = "testarch",
 \t.cpuid = "testcpu",
-\t.version = "v1",
-\t.type = "core",
 \t.table = pme_test_soc_cpu,
 },
 """)
@@ -330,8 +328,6 @@ def print_mapping_table(archs: Sequence[str]) -> None:
             _args.output_file.write(f"""{{
 \t.arch = "{arch}",
 \t.cpuid = "{cpuid}",
-\t.version = "{row[1]}",
-\t.type = "{row[3]}",
 \t.table = {tblname}
 }},
 """)
@@ -340,8 +336,6 @@ def print_mapping_table(archs: Sequence[str]) -> None:
   _args.output_file.write("""{
 \t.arch = 0,
 \t.cpuid = 0,
-\t.version = 0,
-\t.type = 0,
 \t.table = 0,
 }
 };
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 7a360792635f..a491b117c8ac 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -40,8 +40,6 @@ struct pmu_event {
 struct pmu_events_map {
 	const char *arch;
 	const char *cpuid;
-	const char *version;
-	const char *type;		/* core, uncore etc */
 	const struct pmu_event *table;
 };
 
diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index dfefe5b60eb2..dc4038f997d7 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -197,8 +197,6 @@ static int expand_metric_events(void)
 	};
 	const struct pmu_events_map ev_map = {
 		.cpuid		= "test",
-		.version	= "1",
-		.type		= "core",
 		.table		= pme_test,
 	};
 
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 07b6f4ec024f..1b811a26f4ee 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -81,8 +81,6 @@ static struct pmu_event pme_test[] = {
 
 static const struct pmu_events_map map = {
 	.cpuid		= "test",
-	.version	= "1",
-	.type		= "core",
 	.table		= pme_test,
 };
 
-- 
2.37.1.595.g718a3a8f04-goog

