Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92762580787
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbiGYWiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237414AbiGYWhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:37:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C0A26114
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:37:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t10-20020a5b07ca000000b0066ec1bb6e2cso9529679ybq.14
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=H0a2QgGLkvpcOm0cYe90CoROXmrxTkH7y8vzWN086S4=;
        b=K3YQEpUoNpE5GRS5XnUnG42/467ByUyEKgSo6qlUFPQQFDYF9KPj//Jxpx8ag54Lid
         h5EqwC0T81hPrxPvKEDqYi5i08NoBV3rkz0iRJGI+khDx6/pI3rYd9hOJIM+doTBzj8u
         Lt/oY6UOkbvCriwulgbHkB7j4LUsqo04/NqWgSPFb43cw1B0blOSOFXgLmCQKhheoUJn
         4vb+FGcFklvt4vvUZaP0nSuCNkMRiqpTPcOjKto8qgqnrB3hWw0WhI1+YvZah7OZAx0E
         q8bA8lD5QFIYnUH515f9Fw5ge7hgBpxJmPZ3Vd95F4dp5T9nfff4yjr1IxNwK0joz440
         wYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=H0a2QgGLkvpcOm0cYe90CoROXmrxTkH7y8vzWN086S4=;
        b=M9LN9URWaywjEWQLLVk7a2ILLE6a4peLZ2BzJvVM/7AvAgFtDuDUOr5TwcdQ46coM3
         JCr7ZsDcOU84k8PSVVoEKd7GbcHwUBL5ybczqtzD3PQ/JeBySuWya0KgocZL+utxNuJy
         OKOZdyziHErFrKdwQMFJ9Uh0aAA9vOZIxUXB8q3wToNntrF9+2VtqaWzdroeJxua1vRY
         ULPXLjyA0gxizzcqJxqioGCUv/jyKteKBAB5P3EKQE62i4Kha90gGo+t4yYza/xRGumj
         OCCeYoSOPGiEzvI6POsBIANm68laSsXY9ZDcy6dgcFco4FPeFIS3ys1kApcEofxR+Lik
         Y9ew==
X-Gm-Message-State: AJIora8aqf6jRG3VEA0AOhLp217daGYqcoWUaHf+vPufpxceHzu33M+z
        qBRvZgfIOUAAZPu42kF6pAg8UIwUUKzE
X-Google-Smtp-Source: AGRyM1tofN3LmCRH6Rznl8FdaUva+JOECMYPnljBD8wI+p6/4/sf4IsLMP+OpKEUIoVKQgDmUuHwdad+XSZC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7fbf:ee64:7f7:3631])
 (user=irogers job=sendgmr) by 2002:a25:9d01:0:b0:66e:9087:4fb9 with SMTP id
 i1-20020a259d01000000b0066e90874fb9mr11498700ybp.159.1658788628829; Mon, 25
 Jul 2022 15:37:08 -0700 (PDT)
Date:   Mon, 25 Jul 2022 15:36:10 -0700
In-Reply-To: <20220725223633.2301737-1-irogers@google.com>
Message-Id: <20220725223633.2301737-10-irogers@google.com>
Mime-Version: 1.0
References: <20220725223633.2301737-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2 09/32] perf vendor events: Update goldmont mapfile.csv
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
index b105d80d2b7d..ef0beab68a90 100644
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

