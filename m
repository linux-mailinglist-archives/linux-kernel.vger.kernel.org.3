Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F4D583524
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 00:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbiG0WJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 18:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbiG0WJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 18:09:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830E75B7B4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:09:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r64-20020a254443000000b006707b7c2baeso219850yba.16
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=ovZhJIxgdJH49c8kTre80GpVXNtXD5bgPtRx2U3bGEw=;
        b=rpaMcjr5DJLovAYVAm3cFaPqVi0T1Sdoa0qTb4VvJiFzvEkpHRRIfmUFWyFTkVbhWT
         fYVWIvp1FV8XrS0r4G3RpnTZHQbmZttCCwnq1kWtEJiAJ2wCNbQiXF6RxqUplB5gXta1
         sF0BeQk9WjPl7I3EmXvrwRO0ZsI8xGnOPiwA/zCpyFtuEmipQr1HoLrw2CWBIYDOryeO
         6e0dIzenufkzd5HCSQIUzQvbHWMSpHJp2n3li9Nfsp9wMJjQnHRxf9vuGyMGwK3WUwoP
         9q1DOR90mQdOPtobO7e8pye6l5zCTtRV3gf3+VcO5HZs8+Y15le+QAEMJXytLUn4ridR
         +bRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=ovZhJIxgdJH49c8kTre80GpVXNtXD5bgPtRx2U3bGEw=;
        b=qxOGPd00LGIgLqa89hsbZzk0gZ2vIHMckfdVkxbd0cTY/m8XZDYXjsT7VaF3XUh0cg
         o6Hjwz6jwqHh+QSlM1qoD06FMTxEV72Wt1aSiHgtrD1IK/w9XmEHPrW6n4t0QRzyXiuk
         YLJKxBe6Vm9wcJSFzTu/A2XOnYVKG5kelEYNyy393byJcIyZGM+8cACPpLJCY1/sDJgh
         JjNwdZ0LC5yOYCqmtUEqREsZ7OVejUX3oOFHRsekDUrlFisqUQ0EYgbTC7m3GwAUSNWf
         0/BOaRmfLHGC8m9J3AB+ih7DxKG5HYPnaKcHA1BHJVNdzarz8XeXqmolJC1ozRoY3XAy
         yQZw==
X-Gm-Message-State: AJIora99Gdf96BXjYxJyERE5i3sfAqf682vevc21QUmDAPhDu2FQEukn
        rJuzqpnT4yNZWs/q/0dzSdFaO6RarKX4
X-Google-Smtp-Source: AGRyM1sAblaihNLDF24QNt0brWAspb5ZQSDT2A0r3PkPdRhfuL69JMPsvhPi2t0FIBqcReDKnp8nysCrr5tJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:882a:af57:8cb6:6f9e])
 (user=irogers job=sendgmr) by 2002:a0d:f503:0:b0:31d:5651:b564 with SMTP id
 e3-20020a0df503000000b0031d5651b564mr21448508ywf.449.1658959744790; Wed, 27
 Jul 2022 15:09:04 -0700 (PDT)
Date:   Wed, 27 Jul 2022 15:08:10 -0700
In-Reply-To: <20220727220832.2865794-1-irogers@google.com>
Message-Id: <20220727220832.2865794-9-irogers@google.com>
Mime-Version: 1.0
References: <20220727220832.2865794-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v3 08/30] perf vendor events: Update goldmont mapfile.csv
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align end of file whitespace with what is generated by:
https://github.com/intel/event-converter-for-linux-perf/blob/master/downloa=
d_and_gen.py

Modify mapfile.csv to have a missing goldmont cpuid.
Event json remains at v13, there are no goldmont metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/goldmont/cache.json          | 2 +-
 tools/perf/pmu-events/arch/x86/goldmont/floating-point.json | 2 +-
 tools/perf/pmu-events/arch/x86/goldmont/frontend.json       | 2 +-
 tools/perf/pmu-events/arch/x86/goldmont/memory.json         | 2 +-
 tools/perf/pmu-events/arch/x86/goldmont/pipeline.json       | 2 +-
 tools/perf/pmu-events/arch/x86/goldmont/virtual-memory.json | 2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv                  | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/goldmont/cache.json b/tools/per=
f/pmu-events/arch/x86/goldmont/cache.json
index 0b887d73b7f3..ed957d4f9c6d 100644
--- a/tools/perf/pmu-events/arch/x86/goldmont/cache.json
+++ b/tools/perf/pmu-events/arch/x86/goldmont/cache.json
@@ -1300,4 +1300,4 @@
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/goldmont/floating-point.json b/=
tools/perf/pmu-events/arch/x86/goldmont/floating-point.json
index bb364a04a75f..37174392a510 100644
--- a/tools/perf/pmu-events/arch/x86/goldmont/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/goldmont/floating-point.json
@@ -30,4 +30,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/goldmont/frontend.json b/tools/=
perf/pmu-events/arch/x86/goldmont/frontend.json
index 120ff65897c0..216da6e121c8 100644
--- a/tools/perf/pmu-events/arch/x86/goldmont/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/goldmont/frontend.json
@@ -79,4 +79,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/goldmont/memory.json b/tools/pe=
rf/pmu-events/arch/x86/goldmont/memory.json
index 6252503f68a1..9f6f0328249e 100644
--- a/tools/perf/pmu-events/arch/x86/goldmont/memory.json
+++ b/tools/perf/pmu-events/arch/x86/goldmont/memory.json
@@ -31,4 +31,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/goldmont/pipeline.json b/tools/=
perf/pmu-events/arch/x86/goldmont/pipeline.json
index 5dba4313013f..42ff0b134aeb 100644
--- a/tools/perf/pmu-events/arch/x86/goldmont/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/goldmont/pipeline.json
@@ -354,7 +354,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.SMC",
-        "PublicDescription": "Counts the number of times that the processo=
r detects that a program is writing to a code section and has to perform a =
machine clear because of that modification.  Self-modifying code (SMC) caus=
es a severe penalty in all Intel architecture processors.",
+        "PublicDescription": "Counts the number of times that the processo=
r detects that a program is writing to a code section and has to perform a =
machine clear because of that modification.  Self-modifying code (SMC) caus=
es a severe penalty in all Intel(R) architecture processors.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
diff --git a/tools/perf/pmu-events/arch/x86/goldmont/virtual-memory.json b/=
tools/perf/pmu-events/arch/x86/goldmont/virtual-memory.json
index d5e89c74a9be..2e17e02e1463 100644
--- a/tools/perf/pmu-events/arch/x86/goldmont/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/goldmont/virtual-memory.json
@@ -75,4 +75,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 195c61157da7..17047a972c16 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -6,7 +6,7 @@ GenuineIntel-6-56,v23,broadwellde,core
 GenuineIntel-6-4F,v19,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.16,cascadelakex,core
 GenuineIntel-6-96,v1.03,elkhartlake,core
-GenuineIntel-6-5C,v8,goldmont,core
+GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1,goldmontplus,core
 GenuineIntel-6-3C,v24,haswell,core
 GenuineIntel-6-45,v24,haswell,core
--=20
2.37.1.359.gd136c6c3e2-goog

