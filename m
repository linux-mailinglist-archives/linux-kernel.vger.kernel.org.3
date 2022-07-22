Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348D757E9CF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbiGVWg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbiGVWey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:34:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39489BB5FB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:33:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j11-20020a05690212cb00b006454988d225so4672927ybu.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=grgWYZAS9PjMatja/c9H0OK+Bbs2KHSHnp8InGroq0Q=;
        b=A4Ul1/UfviKd5d5XMXdSOLA6twvNRaUv2UeiPfTWBSa1lYGGGHuiQ116t317QyxTGU
         vul+ilJutunyAnddO1gYKmBhd0/4CoyEq6npigYasA+uXCtWj1kko/GEWIhQrbmNLgJc
         8cgh0u6F3a+FBli/LDTIyv3pkKWcjrs8eNAR/5wFzPFvD0fcURC73oA/+3kLbGfEvbaI
         B/o5CCXnfFx5z2AUZVvmlBjUlE1/rfgWmxQBqfE9XSRF7iTu7I0H4N4T/MVJTjdl7yeF
         MKSGbScL6eGNm3WzhaencIdFwBDALYjktVX/ZM1rK9jlnPje3Vcq8LdiAHylOZkgc3Ag
         1yWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=grgWYZAS9PjMatja/c9H0OK+Bbs2KHSHnp8InGroq0Q=;
        b=QJsb6ms2jtsuOB1qacjTPbbIkoUWi9nYS8GJFRApTc5JpH4Q9a3tofMYNC20g5FTs1
         4LuV2wa4tKOztM1WMzqYW/H4D7bGdLjiypRlCh3+lVDz9r/Z9f2gdVYsV//sCMhTeErF
         CLGr97TTik8i3lE4gYcRgWVmx91RSIVCa3fFQJN/AS8VASTJApzWJWTRcrW5PBGIi2GQ
         kEL80VeZ3oAuV4zxEU7oPICZXy9LF4wM4GRhNUQQ9yMzRtisjXvZcy3KFyiKd4I76com
         OcWAeHt9+2oL/ZRAk1DViCxV2Db5PNHu+MJPuje9aoUIa4ReIad+Z9ycc3Mow5Sdq8ie
         eDVw==
X-Gm-Message-State: AJIora8ZBDcNRj6r4WAM/JG8CeQjjDJ61t0pXV6RcOJKGpZZFIipTFhl
        J5xtcwjDEYjg4cWUAs1CVcF6pXgIsaO6
X-Google-Smtp-Source: AGRyM1uDRJ2JNXuJmXDBJ3X/7+ng0R+jQrCJ2cgrh+xFx/kNhhXFHeTH15B6F6nqNm+/VxWtvbL/xIem8MjZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7543:ead8:55fa:3980])
 (user=irogers job=sendgmr) by 2002:a25:dd0:0:b0:670:85ee:166a with SMTP id
 199-20020a250dd0000000b0067085ee166amr1866883ybn.539.1658529234964; Fri, 22
 Jul 2022 15:33:54 -0700 (PDT)
Date:   Fri, 22 Jul 2022 15:32:33 -0700
In-Reply-To: <20220722223240.1618013-1-irogers@google.com>
Message-Id: <20220722223240.1618013-25-irogers@google.com>
Mime-Version: 1.0
References: <20220722223240.1618013-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v1 24/31] perf vendor events: Update Intel silvermont
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
index 0ed0c1ad122b..d224d59e3c72 100644
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

