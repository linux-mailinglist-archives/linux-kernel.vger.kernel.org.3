Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D965557E9B9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbiGVWeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbiGVWdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:33:43 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3119BA4EA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:33:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2eb7d137101so49046397b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=nI/NmLxFINDhMd/akVgcMLTKY8y4maTSUmteL7UR1os=;
        b=AQMGgrzCTfWYaPJ2WjfbTPNAy9LNaMu+rHDth68saO38UsWlMCdEAHuz7icUMQLmFT
         d60ogGfCUiH0HwBC822AGjbubBzZzet+iv+TFu6ctBvLVY7omlc6Am84svrpLlLjzZ+6
         rtwEayjUkDJQ8k1i6AffR445P82+QMmWqvlCILsw+J4YWD1GDpSHmKY9LIqqfGNZSS6w
         imDZzRb29hq8lR4iXzsJVP4dVgPBV6x7PSDXVyBoo7yZk1eR5424PvQc3uJk1EAt7U7A
         lESihdL0TqYDBBYRJh26nOKMQKmh4uETu5YhDUpFiygRY/PA/qnyjX+Gx2UZEITzRO5s
         IBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=nI/NmLxFINDhMd/akVgcMLTKY8y4maTSUmteL7UR1os=;
        b=jZ8u7h2bsAD635g4nmr/r1OvyK3LuPBwLJQrPPbqdYo5DH9EEv314STpdy8XUEvoTQ
         DXGMA8NjCJfyDlTKSX2NYMrRue1Z8cRFQry7Abp9Be1b4HIRDDA2nHuR9sYlrZ6Sj10H
         TbbZECPj9SDsy4a7v9wXeHlzTXGBPL6TTlaVYD3y2RF+ZHAztmjecKYo8CUqRLggJgyI
         7VR1s07sZB3+SxKnz2EHdKfsyODLHwJIhZIdp1T12n+otiYnbsdgm3VeOknivcfGSBwu
         i5OSURsND7P7UuknVCaQTImkWW+ivMZFcWLTly32AW7akHA6D9DUbB5pI3yb3YFcqdKZ
         XD+A==
X-Gm-Message-State: AJIora96Y8DHa3BfYIkNvxxnEdaGlkC4e3XXBZBXkwsggR6vhpyuCzFE
        trmRH4x0lCyTs53YYXJFXwtdm4aIJcWo
X-Google-Smtp-Source: AGRyM1uuBI4r0F9D+PcmY+QbCygEwFJ70M3Z0T21sdgaHCsW2W4BB1jG5jmwHgDiJujhsAUulHenJMpB2gVM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7543:ead8:55fa:3980])
 (user=irogers job=sendgmr) by 2002:a25:1f46:0:b0:670:f3ab:234 with SMTP id
 f67-20020a251f46000000b00670f3ab0234mr1804594ybf.181.1658529195220; Fri, 22
 Jul 2022 15:33:15 -0700 (PDT)
Date:   Fri, 22 Jul 2022 15:32:18 -0700
In-Reply-To: <20220722223240.1618013-1-irogers@google.com>
Message-Id: <20220722223240.1618013-10-irogers@google.com>
Mime-Version: 1.0
References: <20220722223240.1618013-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v1 09/31] perf vendor events: Update goldmont mapfile.csv
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

