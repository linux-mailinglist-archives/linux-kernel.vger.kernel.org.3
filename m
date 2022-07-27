Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EC0583539
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 00:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbiG0WMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 18:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbiG0WLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 18:11:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF5D606A2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:09:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r64-20020a254443000000b006707b7c2baeso220990yba.16
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5e6HWfs1SkPqYIQUoHpxkfHvDU0TH9v/J1FBs30MsCg=;
        b=dmCKrRvLxDgfDOA7gJDXPRREKyRR+6V8Cpy3dG5OdYlMWRVWzh/iFO6AfDmGLvOW6o
         IhDhhYw1LqXbP22Cf0O1t2Do/clsrR+Iw1f0RyYKXSVwVEHN+fqvNv03wsjCpoq68RUg
         1XoA5MYMoLdfrw9ur7HY1Y17wIRRozzW4h44owbMJpfTcB0eK3ZUxFPNt5WDhyUCVL68
         f521ap9Y0ut3CyDcovudXoH38MTSeqaHtL8eoQOk3X5zSqVnwfXLg3Clx/vznCQo59aU
         kBzCJza6AuRIYPFEi1uso20e57KOsjNnjLU8e4Ocr9R15MVXEbim32t7qWFlxx/zQ/Co
         VCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5e6HWfs1SkPqYIQUoHpxkfHvDU0TH9v/J1FBs30MsCg=;
        b=3zs00lavPLYc9Smgqf0Cb3OZEHyAtNxX4xe/fcvzrv8+nkuqjCRMkmVALFs11iE9XD
         3kPMrX8OfN81urr5yvUocj/krfcsDT8YhwaR5sV16yKLUOKeuF+unk03jhlhqOHGFhvJ
         XVWGNUBBScfVUpsDSbiafYC1fd9/AHLCmuTzXRuOsk14Le12vo3Kpe7m/1EMgEUEunPt
         FoVbsXkhcPbTLIkb9yElzRhcI+TS+YrTdYauhwkugNaAd5xYe58PVDVW1hzWMWa1Yx8r
         q4bPJSGe11wLITkorMLHcfx0nrHzkUA0Q53zl0kGJT/RCGC32Gkm3UgJRVWDX1aFhFch
         7VpQ==
X-Gm-Message-State: AJIora8UWVisMjQTj/t+TG69znZK7XGr//ZMmeB/LJIoR6dPp3s5ffEY
        H7RCyUjthU4HnaVM8g5Kz1qfR6AUbWFV
X-Google-Smtp-Source: AGRyM1scfzyD/SGvx7bEmSdZVscFfZVfwFGGgNxe3iHhQd2TG/zjQpKe48mhRc1wxSgqYTeL6aurRyGAr1XX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:882a:af57:8cb6:6f9e])
 (user=irogers job=sendgmr) by 2002:a81:6e02:0:b0:321:cce0:b268 with SMTP id
 j2-20020a816e02000000b00321cce0b268mr1964112ywc.233.1658959785901; Wed, 27
 Jul 2022 15:09:45 -0700 (PDT)
Date:   Wed, 27 Jul 2022 15:08:25 -0700
In-Reply-To: <20220727220832.2865794-1-irogers@google.com>
Message-Id: <20220727220832.2865794-24-irogers@google.com>
Mime-Version: 1.0
References: <20220727220832.2865794-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v3 23/30] perf vendor events: Update Intel silvermont
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

Update to v14, the metrics are based on TMA 4.4 full.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py

to download and generate the latest events and metrics. Manually
copy the silvermont files into perf and update mapfile.csv. Other
than aligning whitespace this change just folds the mapfile.csv
entries for silvertmont onto one line.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv                    | 4 +---
 tools/perf/pmu-events/arch/x86/silvermont/cache.json          | 2 +-
 tools/perf/pmu-events/arch/x86/silvermont/floating-point.json | 2 +-
 tools/perf/pmu-events/arch/x86/silvermont/frontend.json       | 2 +-
 tools/perf/pmu-events/arch/x86/silvermont/memory.json         | 2 +-
 tools/perf/pmu-events/arch/x86/silvermont/other.json          | 2 +-
 tools/perf/pmu-events/arch/x86/silvermont/pipeline.json       | 2 +-
 tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json | 2 +-
 8 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 317ae526e376..2dc86cf445f9 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -21,11 +21,9 @@ GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v3,nehalemex,core
 GenuineIntel-6-2A,v17,sandybridge,core
 GenuineIntel-6-8F,v1.04,sapphirerapids,core
+GenuineIntel-6-(37|4C|4D),v14,silvermont,core
 GenuineIntel-6-[4589]E,v24,skylake,core
 GenuineIntel-6-A[56],v24,skylake,core
-GenuineIntel-6-37,v13,silvermont,core
-GenuineIntel-6-4D,v13,silvermont,core
-GenuineIntel-6-4C,v13,silvermont,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
 GenuineIntel-6-25,v2,westmereep-sp,core
 GenuineIntel-6-2F,v2,westmereex,core
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/cache.json b/tools/perf/pmu-events/arch/x86/silvermont/cache.json
index e16e1d910e4a..7959504dff29 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/cache.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/cache.json
@@ -807,4 +807,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/floating-point.json b/tools/perf/pmu-events/arch/x86/silvermont/floating-point.json
index 1d75b35694ac..aa4faf110512 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/floating-point.json
@@ -8,4 +8,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/frontend.json b/tools/perf/pmu-events/arch/x86/silvermont/frontend.json
index a4c98e43f677..43e5e48f7212 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/frontend.json
@@ -71,4 +71,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/memory.json b/tools/perf/pmu-events/arch/x86/silvermont/memory.json
index 5e21fc3fd078..0f5fba43da4c 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/memory.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/memory.json
@@ -8,4 +8,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/other.json b/tools/perf/pmu-events/arch/x86/silvermont/other.json
index 16d16a1ce6de..4db59d84c144 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/other.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/other.json
@@ -17,4 +17,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json b/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
index 03a4c7f26698..e42a37eabc17 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
@@ -313,4 +313,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json b/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json
index f4b8a1ef48f6..b50cee3a5e4c 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json
@@ -66,4 +66,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x3"
     }
-]
\ No newline at end of file
+]
-- 
2.37.1.359.gd136c6c3e2-goog

