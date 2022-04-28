Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7F5512D94
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343642AbiD1IBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343566AbiD1IAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:00:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774C420BCE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:57:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v17-20020a056902029100b006484d85132eso3874061ybh.14
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=aWXs7tlDmLJHSQO53Aym6NUN4C7h72VmadxmXNi60Js=;
        b=FQHRb3R+5Myf8ESfHH7Po0fapuavknmhxe3M/TFNoGxvENuRUAwhwcxfNs3kReIKxQ
         PV37Tc0ymAZx+Oh4QT9W1+qjaPo9GNSut71JxduWEFfE4QteV2lgOYZ8rSOQmqv6y/rV
         ahDeTW1oPlxi0GBsP2Q8y84pqrsD1PxCYgCzd4ZeadwgzPlJkOQ7n8tNRtMVhKxQNvzF
         Ef4H7DpFUDe7WSzBkLsG4sV5o4j50FuinoKDmRMMwdQ3cxFitZm5Z2z/wxLLHnW44YVo
         vLXJ5tKwqsgSy7WwIF1x08arUzimwpkTk5c43APmghWXlc3V0b0AvY0sw9iWKKuFAAMX
         osrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=aWXs7tlDmLJHSQO53Aym6NUN4C7h72VmadxmXNi60Js=;
        b=GSK2p+SplAmHjBUpcb60Ap7NsweN3Y6reLm9dvVGtNYd/3N6pEVDiXAtHo4fbmgIvn
         pi++Iq/zhb6QsGw0lC4FKe0Dp+dKOfhSrqYdFdG5EmXdxSJdco/JLUc26xrYMr813DmQ
         xsQ1ASvvzIDuFADy3xDyjk5/SINzfdIlj54Z89YKYduhw44JXuwZnJr5qY2CmS33ztYE
         Z1ixtVLgvn7qigs7c8XO0F1ySWzK8sX2Kh8VbtlsoH5sn44ysw4VO/1L6ehbngBhB/Q3
         6Hl3isMiJTW6K+2xP745oAtwNgiuU63KMIQgjNtfXpb1mZVbOGBnb9OpEcrGOziPJKi7
         OtlA==
X-Gm-Message-State: AOAM532Ow6IbqkeaGB67vxLK3hb9axaqtHfUl8U2ti5iBj5GTWsYo0RP
        p1q4FJ7DvkTFfIoAXtJPpAV1TwvHLpIz
X-Google-Smtp-Source: ABdhPJxDIk3QKasliCsKfnHaJgN5Ab7zOiWZYn7+gHLiWdq/d44t62IRJV1JsvnE0Mdumt6M0YlMV7tn2WC0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:33c3:c9d8:c4fd:e75c])
 (user=irogers job=sendgmr) by 2002:a81:5210:0:b0:2ef:21e3:54dd with SMTP id
 g16-20020a815210000000b002ef21e354ddmr31517002ywb.438.1651132655481; Thu, 28
 Apr 2022 00:57:35 -0700 (PDT)
Date:   Thu, 28 Apr 2022 00:57:24 -0700
Message-Id: <20220428075730.797727-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 1/7] perf vendor events intel: Update CLX events to v1.15
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Events are generated for CascadeLake Server v1.15 with
events from:
https://download.01.org/perfmon/CLX/

Using the scripts at:
https://github.com/intel/event-converter-for-linux-perf/

This change updates descriptions, adds INST_DECODED.DECODERS and
corrects a counter mask in UOPS_RETIRED.TOTAL_CYCLES.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/cascadelakex/cache.json          | 1164 +----------------
 .../arch/x86/cascadelakex/memory.json         |  702 +---------
 .../arch/x86/cascadelakex/other.json          |  156 +--
 .../arch/x86/cascadelakex/pipeline.json       |   14 +-
 .../arch/x86/cascadelakex/uncore-other.json   |    4 +-
 5 files changed, 17 insertions(+), 2023 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/cache.json b/tools=
/perf/pmu-events/arch/x86/cascadelakex/cache.json
index aa906a7fa520..fcaa487b8737 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/cache.json
@@ -611,7 +611,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -624,7 +623,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -637,7 +635,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -650,7 +647,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -663,7 +659,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -676,7 +671,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -689,7 +683,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -702,7 +695,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -715,7 +707,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -728,7 +719,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -741,7 +731,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -754,7 +743,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -767,7 +755,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -780,7 +767,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -793,7 +779,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -806,7 +791,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -819,7 +803,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -832,7 +815,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -845,7 +827,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -858,7 +839,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -871,7 +851,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -884,7 +863,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -897,7 +875,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -910,7 +887,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -923,7 +899,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -936,7 +911,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -949,7 +923,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -962,7 +935,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -975,7 +947,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -988,7 +959,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1001,7 +971,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1014,7 +983,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1027,7 +995,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1040,7 +1007,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1053,7 +1019,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1066,7 +1031,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1079,7 +1043,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1092,7 +1055,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1105,7 +1067,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1118,7 +1079,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1131,7 +1091,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1144,7 +1103,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1157,7 +1115,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1170,7 +1127,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1183,7 +1139,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1196,7 +1151,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1209,7 +1163,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1222,7 +1175,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1235,7 +1187,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1248,7 +1199,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1261,7 +1211,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1274,7 +1223,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1287,7 +1235,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1300,7 +1247,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1313,7 +1259,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1326,7 +1271,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1339,7 +1283,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1352,7 +1295,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1365,7 +1307,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1378,7 +1319,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1391,7 +1331,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1404,7 +1343,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1417,7 +1355,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1430,7 +1367,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1443,7 +1379,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1456,7 +1391,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1469,7 +1403,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1482,7 +1415,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1495,7 +1427,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1508,7 +1439,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1521,7 +1451,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1534,7 +1463,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1547,7 +1475,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1560,7 +1487,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1573,7 +1499,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1586,7 +1511,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1599,7 +1523,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1612,7 +1535,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1625,7 +1547,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1638,7 +1559,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1651,7 +1571,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1664,7 +1583,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1677,7 +1595,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1690,7 +1607,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1703,7 +1619,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1716,7 +1631,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1729,7 +1643,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1742,7 +1655,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1755,7 +1667,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1768,7 +1679,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1781,7 +1691,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1794,7 +1703,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1807,7 +1715,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1820,7 +1727,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1833,7 +1739,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1846,7 +1751,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1859,7 +1763,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1872,7 +1775,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1885,7 +1787,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1898,7 +1799,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1911,7 +1811,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1924,7 +1823,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1937,7 +1835,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1950,7 +1847,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1963,7 +1859,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1976,7 +1871,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1989,7 +1883,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2002,7 +1895,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2015,7 +1907,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C07F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2028,7 +1919,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C07F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2041,7 +1931,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C07F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2054,7 +1943,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C07F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2067,7 +1955,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C07F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2080,7 +1967,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C07F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2093,7 +1979,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C07F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2106,7 +1991,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C07F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2119,7 +2003,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F800807F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2132,7 +2015,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10000807F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2145,7 +2027,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8000807F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2158,7 +2039,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4000807F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2171,7 +2051,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000807F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2184,7 +2063,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000807F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2197,7 +2075,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800807F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2210,7 +2087,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F802007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2223,7 +2099,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10002007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2236,7 +2111,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8002007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2249,7 +2123,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4002007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2262,7 +2135,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1002007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2275,7 +2147,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2002007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2288,7 +2159,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x802007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2301,7 +2171,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F800407F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2314,7 +2183,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10000407F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2327,7 +2195,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8000407F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2340,7 +2207,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4000407F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2353,7 +2219,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000407F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2366,7 +2231,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000407F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2379,7 +2243,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800407F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2392,7 +2255,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F801007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2405,7 +2267,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10001007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2418,7 +2279,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8001007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2431,7 +2291,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4001007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2444,7 +2303,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1001007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2457,7 +2315,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2001007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2470,7 +2327,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x801007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2483,7 +2339,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2496,7 +2351,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2509,7 +2363,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2522,7 +2375,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2535,7 +2387,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2548,7 +2399,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2561,7 +2411,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2574,7 +2423,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2587,7 +2435,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2600,7 +2447,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2613,7 +2459,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2626,7 +2471,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2639,7 +2483,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2652,7 +2495,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2665,7 +2507,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2678,7 +2519,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2691,7 +2531,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2704,7 +2543,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2717,7 +2555,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2730,7 +2567,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2743,7 +2579,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2756,7 +2591,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2769,7 +2603,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2782,7 +2615,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2795,7 +2627,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2808,7 +2639,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2821,7 +2651,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2834,7 +2663,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2847,7 +2675,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2860,7 +2687,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2873,7 +2699,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2886,7 +2711,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2899,7 +2723,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2912,7 +2735,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2925,7 +2747,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2938,7 +2759,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2951,7 +2771,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2964,7 +2783,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2977,7 +2795,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2990,7 +2807,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3003,7 +2819,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3016,7 +2831,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3029,7 +2843,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3042,7 +2855,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3055,7 +2867,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3068,7 +2879,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3081,7 +2891,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3094,7 +2903,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3107,7 +2915,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3120,7 +2927,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3133,7 +2939,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3146,7 +2951,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3159,7 +2963,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3172,7 +2975,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3185,7 +2987,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3198,7 +2999,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3211,7 +3011,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3224,7 +3023,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3237,7 +3035,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3250,7 +3047,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3263,7 +3059,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3276,7 +3071,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3289,7 +3083,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3302,7 +3095,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3315,7 +3107,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3328,7 +3119,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3341,7 +3131,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3354,7 +3143,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3367,7 +3155,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3380,7 +3167,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3393,7 +3179,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3406,7 +3191,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3419,7 +3203,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3432,7 +3215,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3445,7 +3227,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3458,7 +3239,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3471,7 +3251,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3484,7 +3263,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3497,7 +3275,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3510,7 +3287,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3523,7 +3299,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3536,7 +3311,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3549,7 +3323,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3562,7 +3335,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3575,7 +3347,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3588,7 +3359,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3601,7 +3371,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3614,7 +3383,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3627,7 +3395,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3640,7 +3407,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3653,7 +3419,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3666,7 +3431,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3679,7 +3443,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3692,7 +3455,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3705,7 +3467,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3718,7 +3479,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3731,7 +3491,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3744,7 +3503,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3757,7 +3515,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3770,7 +3527,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3783,7 +3539,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3796,7 +3551,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3809,7 +3563,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3822,7 +3575,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3835,7 +3587,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3848,7 +3599,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3861,7 +3611,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3874,7 +3623,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3887,7 +3635,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3900,7 +3647,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3913,7 +3659,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3926,7 +3671,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3939,7 +3683,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3952,7 +3695,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3965,7 +3707,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3978,7 +3719,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3991,7 +3731,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4004,7 +3743,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4017,7 +3755,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4030,7 +3767,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4043,7 +3779,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4056,7 +3791,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4069,7 +3803,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4082,7 +3815,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4095,7 +3827,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4108,7 +3839,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4121,7 +3851,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4134,7 +3863,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4147,7 +3875,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4160,7 +3887,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4173,7 +3899,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4186,7 +3911,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4199,7 +3923,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4212,7 +3935,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4225,7 +3947,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4238,7 +3959,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4251,7 +3971,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4264,7 +3983,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4277,7 +3995,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4290,7 +4007,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4303,7 +4019,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4316,7 +4031,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4329,7 +4043,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4342,7 +4055,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4355,7 +4067,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4368,7 +4079,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4381,7 +4091,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4394,7 +4103,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4407,7 +4115,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4420,7 +4127,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4433,7 +4139,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4446,7 +4151,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4459,7 +4163,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80088000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4472,7 +4175,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000088000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4485,7 +4187,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800088000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4498,7 +4199,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400088000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4511,7 +4211,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100088000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4524,7 +4223,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200088000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4537,7 +4235,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80088000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4550,7 +4247,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80208000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4563,7 +4259,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000208000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4576,7 +4271,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800208000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4589,7 +4283,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400208000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4602,7 +4295,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100208000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4615,7 +4307,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200208000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4628,7 +4319,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80208000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4641,7 +4331,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80048000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4654,7 +4343,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000048000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4667,7 +4355,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800048000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4680,7 +4367,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400048000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4693,7 +4379,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100048000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4706,7 +4391,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200048000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4719,7 +4403,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80048000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4732,7 +4415,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80108000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4745,7 +4427,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000108000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4758,7 +4439,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800108000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4771,7 +4451,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400108000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4784,7 +4463,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100108000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4797,7 +4475,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200108000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4810,7 +4487,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80108000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4823,7 +4499,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4836,7 +4511,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4849,7 +4523,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4862,7 +4535,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4875,7 +4547,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4888,7 +4559,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4901,7 +4571,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4914,7 +4583,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4927,7 +4595,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4940,7 +4607,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4953,7 +4619,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4966,7 +4631,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4979,7 +4643,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4992,7 +4655,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5005,7 +4667,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5018,7 +4679,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5031,7 +4691,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5044,7 +4703,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5057,7 +4715,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5070,7 +4727,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5083,7 +4739,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5096,7 +4751,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5109,7 +4763,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5122,7 +4775,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5135,7 +4787,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5148,7 +4799,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5161,7 +4811,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5174,7 +4823,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5187,7 +4835,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5200,7 +4847,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5213,7 +4859,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5226,7 +4871,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5239,7 +4883,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5252,7 +4895,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5265,7 +4907,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5278,7 +4919,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5291,7 +4931,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5304,7 +4943,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5317,7 +4955,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5330,7 +4967,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5343,7 +4979,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5356,7 +4991,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5369,7 +5003,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5382,7 +5015,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5395,7 +5027,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5408,7 +5039,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5421,7 +5051,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5434,7 +5063,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5447,7 +5075,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5460,7 +5087,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5473,7 +5099,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5486,7 +5111,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5499,7 +5123,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5512,7 +5135,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5525,7 +5147,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5538,7 +5159,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5551,7 +5171,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5564,7 +5183,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5577,7 +5195,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5590,7 +5207,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5603,7 +5219,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5616,7 +5231,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5629,7 +5243,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5642,7 +5255,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5655,7 +5267,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5668,7 +5279,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5681,7 +5291,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5694,7 +5303,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5707,7 +5315,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5720,7 +5327,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5733,7 +5339,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5746,7 +5351,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5759,7 +5363,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5772,7 +5375,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5785,7 +5387,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5798,7 +5399,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5811,7 +5411,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5824,7 +5423,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5837,7 +5435,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5850,7 +5447,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5863,7 +5459,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5876,7 +5471,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5889,7 +5483,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5902,7 +5495,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5915,7 +5507,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5928,7 +5519,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5941,7 +5531,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5954,7 +5543,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5967,7 +5555,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5980,7 +5567,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5993,7 +5579,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6006,7 +5591,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6019,7 +5603,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6032,7 +5615,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6045,7 +5627,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6058,7 +5639,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6071,7 +5651,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6084,7 +5663,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6097,7 +5675,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6110,7 +5687,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6123,7 +5699,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6136,7 +5711,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6149,7 +5723,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6162,7 +5735,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6175,7 +5747,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6188,7 +5759,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6201,7 +5771,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6214,7 +5783,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6227,7 +5795,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6240,7 +5807,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6253,7 +5819,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6266,7 +5831,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6279,7 +5843,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6292,7 +5855,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6305,7 +5867,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6318,7 +5879,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6331,7 +5891,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6344,7 +5903,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6357,7 +5915,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6370,7 +5927,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6383,7 +5939,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6396,7 +5951,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6409,7 +5963,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6422,7 +5975,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6435,7 +5987,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6448,7 +5999,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6461,7 +6011,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6474,7 +6023,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6487,7 +6035,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6500,7 +6047,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6513,7 +6059,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6526,7 +6071,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6539,7 +6083,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6552,7 +6095,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6565,7 +6107,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6578,7 +6119,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6591,7 +6131,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6604,7 +6143,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6617,7 +6155,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6630,7 +6167,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6643,7 +6179,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6656,7 +6191,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6669,7 +6203,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6682,7 +6215,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6695,7 +6227,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6708,7 +6239,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6721,7 +6251,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6734,7 +6263,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6747,7 +6275,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6760,7 +6287,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6773,7 +6299,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6786,7 +6311,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6799,7 +6323,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6812,7 +6335,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6825,7 +6347,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6838,7 +6359,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6851,7 +6371,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6864,7 +6383,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6877,7 +6395,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6890,7 +6407,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6903,7 +6419,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6916,7 +6431,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6929,7 +6443,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6942,7 +6455,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6955,7 +6467,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6968,7 +6479,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6981,7 +6491,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6994,7 +6503,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7007,7 +6515,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7020,7 +6527,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7033,7 +6539,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7046,7 +6551,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7059,7 +6563,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7072,7 +6575,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7085,7 +6587,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7098,7 +6599,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7111,7 +6611,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7124,7 +6623,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7137,7 +6635,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7150,7 +6647,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7328,7 +6824,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7342,7 +6837,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7356,7 +6850,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7370,7 +6863,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7384,7 +6876,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7398,7 +6889,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7412,7 +6902,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7426,7 +6915,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7440,7 +6928,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7454,7 +6941,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7468,7 +6954,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7482,7 +6967,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7496,7 +6980,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7510,7 +6993,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7524,7 +7006,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7538,7 +7019,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7552,7 +7032,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7566,7 +7045,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7580,7 +7058,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7594,7 +7071,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7608,7 +7084,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7622,7 +7097,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7636,7 +7110,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7650,7 +7123,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7664,7 +7136,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7678,7 +7149,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7692,7 +7162,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7706,7 +7175,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7720,7 +7188,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7734,7 +7201,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7748,7 +7214,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7762,7 +7227,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7776,7 +7240,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7790,7 +7253,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7804,7 +7266,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7818,7 +7279,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7832,7 +7292,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7846,7 +7305,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7860,7 +7318,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7874,7 +7331,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7888,7 +7344,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7902,7 +7357,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7916,7 +7370,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7930,7 +7383,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7944,7 +7396,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7958,7 +7409,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7972,7 +7422,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7986,7 +7435,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8000,7 +7448,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8014,7 +7461,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8028,7 +7474,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8042,7 +7487,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8056,7 +7500,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8070,7 +7513,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8084,7 +7526,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8098,7 +7539,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8112,7 +7552,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8126,7 +7565,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8140,7 +7578,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8154,7 +7591,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8168,7 +7604,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8182,7 +7617,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8196,7 +7630,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8210,7 +7643,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8224,7 +7656,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8238,7 +7669,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8252,7 +7682,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8266,7 +7695,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8280,7 +7708,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8294,7 +7721,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8308,7 +7734,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8322,7 +7747,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8336,7 +7760,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8350,7 +7773,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8364,7 +7786,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8378,7 +7799,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8392,7 +7812,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8406,7 +7825,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8420,7 +7838,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8434,7 +7851,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8448,7 +7864,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8462,7 +7877,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8476,7 +7890,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8490,7 +7903,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8504,7 +7916,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8518,7 +7929,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8532,7 +7942,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8546,7 +7955,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8560,7 +7968,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8574,7 +7981,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8588,7 +7994,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8602,7 +8007,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8616,7 +8020,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8630,7 +8033,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8644,7 +8046,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8658,7 +8059,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8672,7 +8072,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8686,7 +8085,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8700,7 +8098,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8714,7 +8111,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8728,7 +8124,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8742,7 +8137,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8756,7 +8150,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8770,7 +8163,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8784,7 +8176,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8798,7 +8189,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8812,7 +8202,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8826,7 +8215,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8840,7 +8228,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8854,7 +8241,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8868,7 +8254,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8882,7 +8267,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8896,7 +8280,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8910,7 +8293,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8924,7 +8306,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8938,7 +8319,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8952,7 +8332,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8966,7 +8345,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8980,7 +8358,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8994,7 +8371,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9008,7 +8384,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9022,7 +8397,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9036,7 +8410,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9050,7 +8423,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9064,7 +8436,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9078,7 +8449,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9092,7 +8462,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9106,7 +8475,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9120,7 +8488,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9134,7 +8501,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9148,7 +8514,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9162,7 +8527,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9176,7 +8540,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9190,7 +8553,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9204,7 +8566,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9218,7 +8579,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9232,7 +8592,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9246,7 +8605,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9260,7 +8618,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9274,7 +8631,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9288,7 +8644,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9302,7 +8657,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x107F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9316,7 +8670,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C07F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9330,7 +8683,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C07F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9344,7 +8696,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C07F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9358,7 +8709,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C07F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9372,7 +8722,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C07F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9386,7 +8735,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C07F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9400,7 +8748,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C07F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9414,7 +8761,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C07F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9428,7 +8774,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F800807F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9442,7 +8787,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10000807F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9456,7 +8800,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8000807F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9470,7 +8813,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4000807F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9484,7 +8826,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000807F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9498,7 +8839,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000807F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9512,7 +8852,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800807F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9526,7 +8865,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F802007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9540,7 +8878,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10002007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9554,7 +8891,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8002007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9568,7 +8904,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4002007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9582,7 +8917,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1002007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9596,7 +8930,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2002007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9610,7 +8943,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x802007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9624,7 +8956,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F800407F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9638,7 +8969,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10000407F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9652,7 +8982,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8000407F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9666,7 +8995,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4000407F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9680,7 +9008,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000407F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9694,7 +9021,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000407F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9708,7 +9034,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800407F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9722,7 +9047,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F801007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9736,7 +9060,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10001007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9750,7 +9073,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8001007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9764,7 +9086,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4001007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9778,7 +9099,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1001007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9792,7 +9112,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2001007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9806,7 +9125,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x801007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9820,7 +9138,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F804007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9834,7 +9151,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9848,7 +9164,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9862,7 +9177,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F800207F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9876,7 +9190,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10000207F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9890,7 +9203,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8000207F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9904,7 +9216,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4000207F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9918,7 +9229,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000207F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9932,7 +9242,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000207F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9946,7 +9255,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800207F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9960,7 +9268,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9974,7 +9281,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9988,7 +9294,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10002,7 +9307,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10016,7 +9320,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10030,7 +9333,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10044,7 +9346,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10058,7 +9359,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10072,7 +9372,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10086,7 +9385,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10100,7 +9398,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10114,7 +9411,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10128,7 +9424,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10142,7 +9437,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10156,7 +9450,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10170,7 +9463,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10184,7 +9476,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10198,7 +9489,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10212,7 +9502,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10226,7 +9515,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10240,7 +9528,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10254,7 +9541,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10268,7 +9554,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10282,7 +9567,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10296,7 +9580,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10310,7 +9593,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10324,7 +9606,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10338,7 +9619,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10352,7 +9632,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10366,7 +9645,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10380,7 +9658,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10394,7 +9671,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10408,7 +9684,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10422,7 +9697,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10436,7 +9710,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10450,7 +9723,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10464,7 +9736,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10478,7 +9749,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10492,7 +9762,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10506,7 +9775,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10520,7 +9788,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10534,7 +9801,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10548,7 +9814,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10562,7 +9827,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10576,7 +9840,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10590,7 +9853,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10604,7 +9866,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10618,7 +9879,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10632,7 +9892,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10646,7 +9905,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10660,7 +9918,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10674,7 +9931,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10688,7 +9944,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10702,7 +9957,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10716,7 +9970,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10730,7 +9983,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10744,7 +9996,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10758,7 +10009,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10772,7 +10022,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10786,7 +10035,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10800,7 +10048,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10814,7 +10061,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10828,7 +10074,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10842,7 +10087,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10856,7 +10100,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10870,7 +10113,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10884,7 +10126,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10898,7 +10139,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10912,7 +10152,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10926,7 +10165,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10940,7 +10178,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10954,7 +10191,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10968,7 +10204,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10982,7 +10217,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -10996,7 +10230,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11010,7 +10243,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11024,7 +10256,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11038,7 +10269,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11052,7 +10282,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11066,7 +10295,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11080,7 +10308,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11094,7 +10321,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11108,7 +10334,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11122,7 +10347,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11136,7 +10360,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11150,7 +10373,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11164,7 +10386,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11178,7 +10399,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11192,7 +10412,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11206,7 +10425,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11220,7 +10438,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11234,7 +10451,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11248,7 +10464,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11262,7 +10477,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11276,7 +10490,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11290,7 +10503,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11304,7 +10516,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11318,7 +10529,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11332,7 +10542,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11346,7 +10555,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11360,7 +10568,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11374,7 +10581,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11388,7 +10594,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11402,7 +10607,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11416,7 +10620,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11430,7 +10633,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11444,7 +10646,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11458,7 +10659,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11472,7 +10672,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11486,7 +10685,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11500,7 +10698,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11514,7 +10711,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11528,7 +10724,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11542,7 +10737,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11556,7 +10750,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11570,7 +10763,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11584,7 +10776,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11598,7 +10789,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11612,7 +10802,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11626,7 +10815,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11640,7 +10828,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11654,7 +10841,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11668,7 +10854,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11682,7 +10867,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11696,7 +10880,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11710,7 +10893,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11724,7 +10906,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11738,7 +10919,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11752,7 +10932,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11766,7 +10945,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11780,7 +10958,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11794,7 +10971,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11808,7 +10984,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11822,7 +10997,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11836,7 +11010,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11850,7 +11023,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11864,7 +11036,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11878,7 +11049,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11892,7 +11062,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11906,7 +11075,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11920,7 +11088,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11934,7 +11101,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11948,7 +11114,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11962,7 +11127,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11976,7 +11140,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -11990,7 +11153,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12004,7 +11166,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12018,7 +11179,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12032,7 +11192,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12046,7 +11205,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12060,7 +11218,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12074,7 +11231,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12088,7 +11244,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12102,7 +11257,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12116,7 +11270,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12130,7 +11283,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12144,7 +11296,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12158,7 +11309,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12172,7 +11322,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12186,7 +11335,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12200,7 +11348,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12214,7 +11361,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12228,7 +11374,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12242,7 +11387,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12256,7 +11400,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12270,7 +11413,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12284,7 +11426,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12298,7 +11439,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12312,7 +11452,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12326,7 +11465,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12340,7 +11478,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12354,7 +11491,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12368,7 +11504,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12382,7 +11517,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12396,7 +11530,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12410,7 +11543,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12424,7 +11556,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12438,7 +11569,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12452,7 +11582,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12466,7 +11595,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12480,7 +11608,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12494,7 +11621,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12508,7 +11634,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12522,7 +11647,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12536,7 +11660,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12550,7 +11673,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12564,7 +11686,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12578,7 +11699,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12592,7 +11712,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x18000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12606,7 +11725,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12620,7 +11738,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12634,7 +11751,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12648,7 +11764,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12662,7 +11777,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12676,7 +11790,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12690,7 +11803,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12704,7 +11816,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12718,7 +11829,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80088000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12732,7 +11842,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000088000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12746,7 +11855,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800088000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12760,7 +11868,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400088000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12774,7 +11881,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100088000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12788,7 +11894,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200088000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12802,7 +11907,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80088000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12816,7 +11920,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80208000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12830,7 +11933,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000208000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12844,7 +11946,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800208000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12858,7 +11959,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400208000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12872,7 +11972,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100208000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12886,7 +11985,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200208000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12900,7 +11998,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80208000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12914,7 +12011,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80048000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12928,7 +12024,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000048000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12942,7 +12037,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800048000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12956,7 +12050,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400048000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12970,7 +12063,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100048000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12984,7 +12076,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200048000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -12998,7 +12089,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80048000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13012,7 +12102,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80108000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13026,7 +12115,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000108000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13040,7 +12128,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800108000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13054,7 +12141,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400108000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13068,7 +12154,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100108000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13082,7 +12167,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200108000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13096,7 +12180,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80108000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13110,7 +12193,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13124,7 +12206,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13138,7 +12219,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13152,7 +12232,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80028000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13166,7 +12245,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000028000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13180,7 +12258,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800028000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13194,7 +12271,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400028000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13208,7 +12284,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100028000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13222,7 +12297,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200028000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13236,7 +12310,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80028000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13250,7 +12323,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13264,7 +12336,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13278,7 +12349,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13292,7 +12362,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13306,7 +12375,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13320,7 +12388,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13334,7 +12401,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13348,7 +12414,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13362,7 +12427,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13376,7 +12440,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13390,7 +12453,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13404,7 +12466,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13418,7 +12479,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13432,7 +12492,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13446,7 +12505,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13460,7 +12518,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13474,7 +12531,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13488,7 +12544,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13502,7 +12557,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13516,7 +12570,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13530,7 +12583,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13544,7 +12596,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13558,7 +12609,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13572,7 +12622,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13586,7 +12635,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13600,7 +12648,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13614,7 +12661,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13628,7 +12674,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13642,7 +12687,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13656,7 +12700,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13670,7 +12713,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13684,7 +12726,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13698,7 +12739,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13712,7 +12752,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13726,7 +12765,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13740,7 +12778,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13754,7 +12791,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13768,7 +12804,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13782,7 +12817,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13796,7 +12830,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13810,7 +12843,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13824,7 +12856,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13838,7 +12869,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13852,7 +12882,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13866,7 +12895,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13880,7 +12908,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13894,7 +12921,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13908,7 +12934,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13922,7 +12947,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13936,7 +12960,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13950,7 +12973,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13964,7 +12986,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13978,7 +12999,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13992,7 +13012,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14006,7 +13025,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14020,7 +13038,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14034,7 +13051,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14048,7 +13064,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14062,7 +13077,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14076,7 +13090,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14090,7 +13103,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14104,7 +13116,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14118,7 +13129,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14132,7 +13142,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14146,7 +13155,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14160,7 +13168,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14174,7 +13181,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14188,7 +13194,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14202,7 +13207,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14216,7 +13220,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14230,7 +13233,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14244,7 +13246,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14258,7 +13259,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14272,7 +13272,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14286,7 +13285,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14300,7 +13298,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14314,7 +13311,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14328,7 +13324,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14342,7 +13337,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14356,7 +13350,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14370,7 +13363,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14384,7 +13376,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14398,7 +13389,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14412,7 +13402,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14426,7 +13415,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14440,7 +13428,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14454,7 +13441,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14468,7 +13454,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14482,7 +13467,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14496,7 +13480,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14510,7 +13493,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14524,7 +13506,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14538,7 +13519,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14552,7 +13532,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14566,7 +13545,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14580,7 +13558,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14594,7 +13571,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14608,7 +13584,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14622,7 +13597,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14636,7 +13610,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14650,7 +13623,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14664,7 +13636,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14678,7 +13649,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14692,7 +13662,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14706,7 +13675,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14720,7 +13688,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14734,7 +13701,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14748,7 +13714,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14762,7 +13727,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14776,7 +13740,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14790,7 +13753,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14804,7 +13766,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14818,7 +13779,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14832,7 +13792,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14846,7 +13805,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14860,7 +13818,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14874,7 +13831,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14888,7 +13844,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14902,7 +13857,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14916,7 +13870,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14930,7 +13883,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14944,7 +13896,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14958,7 +13909,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14972,7 +13922,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -14986,7 +13935,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15000,7 +13948,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15014,7 +13961,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15028,7 +13974,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15042,7 +13987,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15056,7 +14000,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15070,7 +14013,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15084,7 +14026,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15098,7 +14039,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15112,7 +14052,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15126,7 +14065,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15140,7 +14078,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15154,7 +14091,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15168,7 +14104,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15182,7 +14117,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15196,7 +14130,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15210,7 +14143,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15224,7 +14156,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15238,7 +14169,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15252,7 +14182,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15266,7 +14195,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15280,7 +14208,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15294,7 +14221,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15308,7 +14234,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15322,7 +14247,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15336,7 +14260,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15350,7 +14273,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15364,7 +14286,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15378,7 +14299,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15392,7 +14312,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15406,7 +14325,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15420,7 +14338,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15434,7 +14351,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15448,7 +14364,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15462,7 +14377,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15476,7 +14390,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15490,7 +14403,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15504,7 +14416,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15518,7 +14429,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15532,7 +14442,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15546,7 +14455,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15560,7 +14468,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15574,7 +14481,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15588,7 +14494,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15602,7 +14507,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15616,7 +14520,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15630,7 +14533,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15644,7 +14546,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15658,7 +14559,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15672,7 +14572,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15686,7 +14585,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15700,7 +14598,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15714,7 +14611,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15728,7 +14624,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15742,7 +14637,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15756,7 +14650,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15770,7 +14663,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15784,7 +14676,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15798,7 +14689,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15812,7 +14702,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15826,7 +14715,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15840,7 +14728,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15854,7 +14741,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15868,7 +14754,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15882,7 +14767,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15896,7 +14780,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15910,7 +14793,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15924,7 +14806,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15938,7 +14819,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15952,7 +14832,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1003C0100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15966,7 +14845,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8007C0100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15980,7 +14858,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2003C0100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -15994,7 +14871,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x803C0100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16008,7 +14884,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80080100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16022,7 +14897,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16036,7 +14910,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800080100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16050,7 +14923,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16064,7 +14936,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16078,7 +14949,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16092,7 +14962,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16106,7 +14975,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80200100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16120,7 +14988,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000200100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16134,7 +15001,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800200100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16148,7 +15014,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400200100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16162,7 +15027,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100200100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16176,7 +15040,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200200100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16190,7 +15053,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80200100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16204,7 +15066,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80040100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16218,7 +15079,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16232,7 +15092,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800040100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16246,7 +15105,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16260,7 +15118,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16274,7 +15131,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16288,7 +15144,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16302,7 +15157,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80100100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16316,7 +15170,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16330,7 +15183,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800100100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16344,7 +15196,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16358,7 +15209,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16372,7 +15222,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16386,7 +15235,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16400,7 +15248,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16414,7 +15261,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16428,7 +15274,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16442,7 +15287,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16456,7 +15300,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16470,7 +15313,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16484,7 +15326,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16498,7 +15339,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16512,7 +15352,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16526,7 +15365,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -16576,4 +15414,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/memory.json b/tool=
s/perf/pmu-events/arch/x86/cascadelakex/memory.json
index ae55c35c2f19..36042010d768 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/memory.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/memory.json
@@ -236,7 +236,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -249,7 +248,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -262,7 +260,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -275,7 +272,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -288,7 +284,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -301,7 +296,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -314,7 +308,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -327,7 +320,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -340,7 +332,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -353,7 +344,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -366,7 +356,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -379,7 +368,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -392,7 +380,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -405,7 +392,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -418,7 +404,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -431,7 +416,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -444,7 +428,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -457,7 +440,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -470,7 +452,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -483,7 +464,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -496,7 +476,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -509,7 +488,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -522,7 +500,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -535,7 +512,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -548,7 +524,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -561,7 +536,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -574,7 +548,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -587,7 +560,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -600,7 +572,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -613,7 +584,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -626,7 +596,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -639,7 +608,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -652,7 +620,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -665,7 +632,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -678,7 +644,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -691,7 +656,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -704,7 +668,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -717,7 +680,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -730,7 +692,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -743,7 +704,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -756,7 +716,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -769,7 +728,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -782,7 +740,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -795,7 +752,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -808,7 +764,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -821,7 +776,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -834,7 +788,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -847,7 +800,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -860,7 +812,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -873,7 +824,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -886,7 +836,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -899,7 +848,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -912,7 +860,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -925,7 +872,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -938,7 +884,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -951,7 +896,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -964,7 +908,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -977,7 +920,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -990,7 +932,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1003,7 +944,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1016,7 +956,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1029,7 +968,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1042,7 +980,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1055,7 +992,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1068,7 +1004,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1081,7 +1016,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1094,7 +1028,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1107,7 +1040,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1120,7 +1052,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1133,7 +1064,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1146,7 +1076,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1159,7 +1088,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1172,7 +1100,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1185,7 +1112,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1198,7 +1124,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1211,7 +1136,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC0007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1224,7 +1148,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C0007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1237,7 +1160,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C0007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1250,7 +1172,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C0007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1263,7 +1184,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C0007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1276,7 +1196,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1289,7 +1208,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1302,7 +1220,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C0007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1315,7 +1232,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC0007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1328,7 +1244,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F840007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1341,7 +1256,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10040007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1354,7 +1268,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8040007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1367,7 +1280,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4040007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1380,7 +1292,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1040007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1393,7 +1304,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2040007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1406,7 +1316,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x6040007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1419,7 +1328,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x840007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1432,7 +1340,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B8007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1445,7 +1352,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F900007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1458,7 +1364,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10100007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1471,7 +1376,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8100007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1484,7 +1388,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4100007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1497,7 +1400,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1100007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1510,7 +1412,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2100007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1523,7 +1424,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x900007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1536,7 +1436,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1549,7 +1448,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1562,7 +1460,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1575,7 +1472,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1588,7 +1484,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1601,7 +1496,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1614,7 +1508,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1627,7 +1520,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1640,7 +1532,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1653,7 +1544,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1666,7 +1556,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1679,7 +1568,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1692,7 +1580,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1705,7 +1592,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1718,7 +1604,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1731,7 +1616,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1744,7 +1628,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1757,7 +1640,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1770,7 +1652,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1783,7 +1664,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1796,7 +1676,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1809,7 +1688,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1822,7 +1700,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1835,7 +1712,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1848,7 +1724,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1861,7 +1736,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1874,7 +1748,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1887,7 +1760,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1900,7 +1772,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1913,7 +1784,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1926,7 +1796,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1939,7 +1808,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1952,7 +1820,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1965,7 +1832,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1978,7 +1844,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1991,7 +1856,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2004,7 +1868,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2017,7 +1880,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2030,7 +1892,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2043,7 +1904,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2056,7 +1916,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2069,7 +1928,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2082,7 +1940,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2095,7 +1952,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2108,7 +1964,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2121,7 +1976,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2134,7 +1988,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2147,7 +2000,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2160,7 +2012,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2173,7 +2024,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2186,7 +2036,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2199,7 +2048,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2212,7 +2060,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2225,7 +2072,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2238,7 +2084,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2251,7 +2096,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2264,7 +2108,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2277,7 +2120,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2290,7 +2132,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2303,7 +2144,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2316,7 +2156,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2329,7 +2168,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2342,7 +2180,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2355,7 +2192,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2368,7 +2204,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2381,7 +2216,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2394,7 +2228,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2407,7 +2240,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2420,7 +2252,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2433,7 +2264,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2446,7 +2276,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2459,7 +2288,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2472,7 +2300,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2485,7 +2312,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2498,7 +2324,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2511,7 +2336,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2524,7 +2348,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2537,7 +2360,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2550,7 +2372,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2563,7 +2384,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2576,7 +2396,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2589,7 +2408,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2602,7 +2420,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2615,7 +2432,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2628,7 +2444,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2641,7 +2456,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2654,7 +2468,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2667,7 +2480,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2680,7 +2492,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2693,7 +2504,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2706,7 +2516,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2719,7 +2528,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2732,7 +2540,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2745,7 +2552,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2758,7 +2564,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2771,7 +2576,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2784,7 +2588,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2797,7 +2600,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2810,7 +2612,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2823,7 +2624,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2836,7 +2636,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2849,7 +2648,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2862,7 +2660,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2875,7 +2672,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2888,7 +2684,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2901,7 +2696,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC08000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2914,7 +2708,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC08000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2927,7 +2720,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2940,7 +2732,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2953,7 +2744,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2966,7 +2756,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2979,7 +2768,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2992,7 +2780,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3005,7 +2792,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3018,7 +2804,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3031,7 +2816,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3044,7 +2828,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3057,7 +2840,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B808000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3070,7 +2852,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3083,7 +2864,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3096,7 +2876,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3109,7 +2888,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3122,7 +2900,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3135,7 +2912,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3148,7 +2924,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3161,7 +2936,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3174,7 +2948,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3187,7 +2960,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3200,7 +2972,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3213,7 +2984,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3226,7 +2996,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3239,7 +3008,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3252,7 +3020,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3265,7 +3032,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3278,7 +3044,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3291,7 +3056,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3304,7 +3068,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3317,7 +3080,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3330,7 +3092,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3343,7 +3104,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3356,7 +3116,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3369,7 +3128,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3382,7 +3140,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3395,7 +3152,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3408,7 +3164,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3421,7 +3176,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3434,7 +3188,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3447,7 +3200,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3460,7 +3212,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3473,7 +3224,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3486,7 +3236,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3499,7 +3248,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3512,7 +3260,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3525,7 +3272,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3538,7 +3284,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3551,7 +3296,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3564,7 +3308,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3577,7 +3320,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3590,7 +3332,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3603,7 +3344,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3616,7 +3356,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3629,7 +3368,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3642,7 +3380,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3655,7 +3392,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3668,7 +3404,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3681,7 +3416,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3694,7 +3428,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3707,7 +3440,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3720,7 +3452,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3733,7 +3464,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3746,7 +3476,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3759,7 +3488,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3772,7 +3500,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3785,7 +3512,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3798,7 +3524,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3811,7 +3536,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3824,7 +3548,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3837,7 +3560,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3850,7 +3572,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3863,7 +3584,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3876,7 +3596,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3889,7 +3608,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3902,7 +3620,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3915,7 +3632,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3928,7 +3644,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3941,7 +3656,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3954,7 +3668,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3967,7 +3680,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3980,7 +3692,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -3993,7 +3704,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4006,7 +3716,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4019,7 +3728,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4032,7 +3740,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4045,7 +3752,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4058,7 +3764,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4071,7 +3776,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4084,7 +3788,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4097,7 +3800,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4110,7 +3812,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4123,7 +3824,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4136,7 +3836,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4149,7 +3848,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4162,7 +3860,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4175,7 +3872,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4188,7 +3884,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4201,7 +3896,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4214,7 +3908,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4227,7 +3920,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4240,7 +3932,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4253,7 +3944,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4266,7 +3956,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4279,7 +3968,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4292,7 +3980,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4305,7 +3992,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4318,7 +4004,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4331,7 +4016,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4344,7 +4028,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4357,7 +4040,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4370,7 +4052,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4383,7 +4064,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4396,7 +4076,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4409,7 +4088,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4422,7 +4100,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4435,7 +4112,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4448,7 +4124,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4461,7 +4136,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4474,7 +4148,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4487,7 +4160,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4500,7 +4172,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4513,7 +4184,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4526,7 +4196,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4539,7 +4208,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4552,7 +4220,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4565,7 +4232,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4578,7 +4244,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4591,7 +4256,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4604,7 +4268,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4617,7 +4280,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4630,7 +4292,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4643,7 +4304,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4656,7 +4316,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4669,7 +4328,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4682,7 +4340,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4695,7 +4352,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4708,7 +4364,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4721,7 +4376,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4734,7 +4388,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4747,7 +4400,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4760,7 +4412,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4773,7 +4424,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4826,7 +4476,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4840,7 +4489,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4854,7 +4502,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4868,7 +4515,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4882,7 +4528,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4896,7 +4541,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4910,7 +4554,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4924,7 +4567,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4938,7 +4580,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4952,7 +4593,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4966,7 +4606,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4980,7 +4619,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -4994,7 +4632,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5008,7 +4645,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5022,7 +4658,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5036,7 +4671,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5050,7 +4684,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5064,7 +4697,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5078,7 +4710,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5092,7 +4723,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5106,7 +4736,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5120,7 +4749,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5134,7 +4762,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5148,7 +4775,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5162,7 +4788,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5176,7 +4801,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5190,7 +4814,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5204,7 +4827,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5218,7 +4840,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5232,7 +4853,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5246,7 +4866,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5260,7 +4879,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5274,7 +4892,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5288,7 +4905,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5302,7 +4918,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5316,7 +4931,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5330,7 +4944,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5344,7 +4957,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5358,7 +4970,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5372,7 +4983,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5386,7 +4996,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5400,7 +5009,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5414,7 +5022,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5428,7 +5035,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5442,7 +5048,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5456,7 +5061,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5470,7 +5074,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5484,7 +5087,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5498,7 +5100,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5512,7 +5113,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5526,7 +5126,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5540,7 +5139,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5554,7 +5152,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5568,7 +5165,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5582,7 +5178,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5596,7 +5191,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5610,7 +5204,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5624,7 +5217,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5638,7 +5230,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5652,7 +5243,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5666,7 +5256,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5680,7 +5269,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5694,7 +5282,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5708,7 +5295,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5722,7 +5308,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5736,7 +5321,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5750,7 +5334,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5764,7 +5347,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5778,7 +5360,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5792,7 +5373,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5806,7 +5386,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5820,7 +5399,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5834,7 +5412,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5848,7 +5425,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5862,7 +5438,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5876,7 +5451,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC0007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5890,7 +5464,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C0007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5904,7 +5477,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C0007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5918,7 +5490,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C0007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5932,7 +5503,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C0007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5946,7 +5516,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5960,7 +5529,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5974,7 +5542,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C0007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -5988,7 +5555,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC0007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6002,7 +5568,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F840007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6016,7 +5581,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10040007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6030,7 +5594,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8040007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6044,7 +5607,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4040007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6058,7 +5620,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1040007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6072,7 +5633,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2040007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6086,7 +5646,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x6040007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6100,7 +5659,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x840007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6114,7 +5672,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B8007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6128,7 +5685,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F900007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6142,7 +5698,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10100007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6156,7 +5711,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8100007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6170,7 +5724,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4100007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6184,7 +5737,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1100007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6198,7 +5750,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2100007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6212,7 +5763,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x900007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6226,7 +5776,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6240,7 +5789,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6254,7 +5802,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6268,7 +5815,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6282,7 +5828,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6296,7 +5841,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6310,7 +5854,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6324,7 +5867,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6338,7 +5880,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6352,7 +5893,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6366,7 +5906,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6380,7 +5919,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6394,7 +5932,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6408,7 +5945,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6422,7 +5958,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6436,7 +5971,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6450,7 +5984,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6464,7 +5997,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6478,7 +6010,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6492,7 +6023,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6506,7 +6036,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6520,7 +6049,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6534,7 +6062,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6548,7 +6075,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6562,7 +6088,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6576,7 +6101,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6590,7 +6114,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6604,7 +6127,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6618,7 +6140,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6632,7 +6153,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6646,7 +6166,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6660,7 +6179,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6674,7 +6192,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6688,7 +6205,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6702,7 +6218,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6716,7 +6231,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6730,7 +6244,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6744,7 +6257,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6758,7 +6270,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6772,7 +6283,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6786,7 +6296,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6800,7 +6309,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6814,7 +6322,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6828,7 +6335,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6842,7 +6348,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6856,7 +6361,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6870,7 +6374,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6884,7 +6387,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6898,7 +6400,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6912,7 +6413,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6926,7 +6426,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6940,7 +6439,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6954,7 +6452,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6968,7 +6465,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6982,7 +6478,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -6996,7 +6491,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7010,7 +6504,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7024,7 +6517,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7038,7 +6530,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7052,7 +6543,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7066,7 +6556,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7080,7 +6569,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7094,7 +6582,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7108,7 +6595,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7122,7 +6608,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7136,7 +6621,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7150,7 +6634,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7164,7 +6647,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7178,7 +6660,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7192,7 +6673,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7206,7 +6686,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7220,7 +6699,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7234,7 +6712,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7248,7 +6725,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7262,7 +6738,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7276,7 +6751,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7290,7 +6764,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7304,7 +6777,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7318,7 +6790,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7332,7 +6803,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7346,7 +6816,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7360,7 +6829,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7374,7 +6842,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7388,7 +6855,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7402,7 +6868,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7416,7 +6881,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7430,7 +6894,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7444,7 +6907,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7458,7 +6920,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7472,7 +6933,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7486,7 +6946,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7500,7 +6959,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7514,7 +6972,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7528,7 +6985,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7542,7 +6998,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7556,7 +7011,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7570,7 +7024,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7584,7 +7037,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7598,7 +7050,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7612,7 +7063,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7626,7 +7076,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7640,7 +7089,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7654,7 +7102,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7668,7 +7115,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7682,7 +7128,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7696,7 +7141,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC08000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7710,7 +7154,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC08000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7724,7 +7167,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7738,7 +7180,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7752,7 +7193,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7766,7 +7206,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7780,7 +7219,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7794,7 +7232,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7808,7 +7245,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7822,7 +7258,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7836,7 +7271,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7850,7 +7284,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7864,7 +7297,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B808000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7878,7 +7310,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7892,7 +7323,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7906,7 +7336,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7920,7 +7349,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7934,7 +7362,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7948,7 +7375,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7962,7 +7388,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7976,7 +7401,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -7990,7 +7414,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8004,7 +7427,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8018,7 +7440,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8032,7 +7453,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8046,7 +7466,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8060,7 +7479,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8074,7 +7492,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8088,7 +7505,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8102,7 +7518,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8116,7 +7531,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8130,7 +7544,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8144,7 +7557,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8158,7 +7570,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8172,7 +7583,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8186,7 +7596,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8200,7 +7609,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8214,7 +7622,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8228,7 +7635,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8242,7 +7648,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8256,7 +7661,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8270,7 +7674,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8284,7 +7687,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8298,7 +7700,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8312,7 +7713,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8326,7 +7726,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8340,7 +7739,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8354,7 +7752,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8368,7 +7765,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8382,7 +7778,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8396,7 +7791,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8410,7 +7804,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8424,7 +7817,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8438,7 +7830,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8452,7 +7843,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8466,7 +7856,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8480,7 +7869,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8494,7 +7882,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8508,7 +7895,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8522,7 +7908,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8536,7 +7921,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8550,7 +7934,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8564,7 +7947,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8578,7 +7960,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8592,7 +7973,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8606,7 +7986,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8620,7 +7999,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8634,7 +8012,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8648,7 +8025,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8662,7 +8038,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8676,7 +8051,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8690,7 +8064,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8704,7 +8077,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8718,7 +8090,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8732,7 +8103,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8746,7 +8116,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8760,7 +8129,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8774,7 +8142,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8788,7 +8155,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8802,7 +8168,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8816,7 +8181,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8830,7 +8194,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8844,7 +8207,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8858,7 +8220,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8872,7 +8233,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8886,7 +8246,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8900,7 +8259,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8914,7 +8272,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8928,7 +8285,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8942,7 +8298,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8956,7 +8311,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8970,7 +8324,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8984,7 +8337,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -8998,7 +8350,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9012,7 +8363,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9026,7 +8376,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9040,7 +8389,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9054,7 +8402,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9068,7 +8415,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9082,7 +8428,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9096,7 +8441,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9110,7 +8454,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9124,7 +8467,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9138,7 +8480,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9152,7 +8493,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9166,7 +8506,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9180,7 +8519,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9194,7 +8532,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9208,7 +8545,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9222,7 +8558,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9236,7 +8571,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9250,7 +8584,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9264,7 +8597,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9278,7 +8610,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9292,7 +8623,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9306,7 +8636,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9320,7 +8649,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9334,7 +8662,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9348,7 +8675,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9362,7 +8688,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9376,7 +8701,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBC000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9390,7 +8714,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9404,7 +8727,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83C000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9418,7 +8740,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9432,7 +8753,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9446,7 +8766,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103FC00100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9460,7 +8779,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x83FC00100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9474,7 +8792,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9488,7 +8805,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9502,7 +8818,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9516,7 +8831,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9530,7 +8844,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9544,7 +8857,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9558,7 +8870,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9572,7 +8883,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9586,7 +8896,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x604000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9600,7 +8909,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9614,7 +8922,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63B800100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9628,7 +8935,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F90000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9642,7 +8948,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1010000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9656,7 +8961,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x810000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9670,7 +8974,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x410000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9684,7 +8987,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x110000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9698,7 +9000,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x210000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9712,7 +9013,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -9914,4 +9214,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x40"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/other.json b/tools=
/perf/pmu-events/arch/x86/cascadelakex/other.json
index bb23a91b0127..60d8a99813b9 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/other.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/other.json
@@ -78,7 +78,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -91,7 +90,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -104,7 +102,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -117,7 +114,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -130,7 +126,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -143,7 +138,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -156,7 +150,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -169,7 +162,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -182,7 +174,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -195,7 +186,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -208,7 +198,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -221,7 +210,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -234,7 +222,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -247,7 +234,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -260,7 +246,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -273,7 +258,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -286,7 +270,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -299,7 +282,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -312,7 +294,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -325,7 +306,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -338,7 +318,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -351,7 +330,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -364,7 +342,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -377,7 +354,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -390,7 +366,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -403,7 +378,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -416,7 +390,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -429,7 +402,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -442,7 +414,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -455,7 +426,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -468,7 +438,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -481,7 +450,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -494,7 +462,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -507,7 +474,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x107F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -520,7 +486,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F804007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -533,7 +498,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x804007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -546,7 +510,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004007F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -559,7 +522,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F800207F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -572,7 +534,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10000207F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -585,7 +546,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8000207F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -598,7 +558,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4000207F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -611,7 +570,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000207F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -624,7 +582,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000207F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -637,7 +594,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800207F7",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -650,7 +606,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -663,7 +618,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -676,7 +630,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -689,7 +642,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -702,7 +654,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -715,7 +666,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -728,7 +678,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -741,7 +690,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -754,7 +702,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -767,7 +714,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -780,7 +726,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -793,7 +738,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -806,7 +750,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -819,7 +762,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -832,7 +774,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -845,7 +786,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -858,7 +798,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -871,7 +810,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -884,7 +822,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -897,7 +834,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -910,7 +846,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -923,7 +858,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -936,7 +870,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -949,7 +882,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -962,7 +894,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -975,7 +906,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -988,7 +918,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1001,7 +930,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1014,7 +942,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1027,7 +954,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1040,7 +966,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1053,7 +978,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1066,7 +990,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1079,7 +1002,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1092,7 +1014,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1105,7 +1026,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1118,7 +1038,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1131,7 +1050,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1144,7 +1062,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1157,7 +1074,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1170,7 +1086,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1183,7 +1098,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1196,7 +1110,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1209,7 +1122,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1222,7 +1134,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x18000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1235,7 +1146,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1248,7 +1158,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1261,7 +1170,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1274,7 +1182,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80028000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1287,7 +1194,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000028000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1300,7 +1206,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800028000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1313,7 +1218,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400028000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1326,7 +1230,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100028000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1339,7 +1242,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200028000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1352,7 +1254,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80028000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1365,7 +1266,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1378,7 +1278,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1391,7 +1290,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1404,7 +1302,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1417,7 +1314,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1430,7 +1326,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1443,7 +1338,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1456,7 +1350,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1469,7 +1362,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1482,7 +1374,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1495,7 +1386,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1508,7 +1398,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1521,7 +1410,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1534,7 +1422,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1547,7 +1434,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1560,7 +1446,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1573,7 +1458,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1586,7 +1470,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1599,7 +1482,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1612,7 +1494,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1625,7 +1506,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1638,7 +1518,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1651,7 +1530,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1664,7 +1542,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1677,7 +1554,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1690,7 +1566,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1703,7 +1578,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1716,7 +1590,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1729,7 +1602,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1742,7 +1614,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1755,7 +1626,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1768,7 +1638,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1781,7 +1650,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1794,7 +1662,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1807,7 +1674,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1820,7 +1686,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1833,7 +1698,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1846,7 +1710,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1859,7 +1722,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1872,7 +1734,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1885,7 +1746,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1898,7 +1758,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1911,7 +1770,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1924,7 +1782,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1937,7 +1794,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1950,7 +1806,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80400100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1963,7 +1818,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1976,7 +1830,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1989,7 +1842,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F80020100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2002,7 +1854,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2015,7 +1866,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x800020100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2028,7 +1878,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2041,7 +1890,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2054,7 +1902,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2067,8 +1914,7 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
index 12eabae3e224..79fda10ec4bb 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
@@ -416,6 +416,16 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Instruction decoders utilized in a cycle",
+        "Counter": "0,1,2,3",
+        "CounterHTOff": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x55",
+        "EventName": "INST_DECODED.DECODERS",
+        "PublicDescription": "Number of decoders utilized in a cycle when =
the MITE (legacy decode pipeline) fetches instructions.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Instructions retired from execution.",
         "Counter": "Fixed counter 0",
@@ -969,7 +979,7 @@
         "BriefDescription": "Cycles with less than 10 actually retired uop=
s.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3,4,5,6,7",
-        "CounterMask": "10",
+        "CounterMask": "16",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
         "Invert": "1",
@@ -977,4 +987,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json =
b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
index 03575ef9f4c3..aa460d0c4851 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
@@ -606,7 +606,7 @@
         "EventCode": "0x5C",
         "EventName": "UNC_CHA_SNOOP_RESP.RSP_FWD_WB",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a transaction with the opcode ty=
pe Rsp*Fwd*WB Snoop Response was received which indicates the data was writ=
ten back to it's home socket, and the cacheline was forwarded to the reques=
tor socket.  This snoop response is only used in >=3D 4 socket systems.  It=
 is used when a snoop HITM's in a remote caching agent and it directly forw=
ards data to a requestor, and simultaneously returns data to it's home sock=
et to be written back to memory.",
+        "PublicDescription": "Counts when a transaction with the opcode ty=
pe Rsp*Fwd*WB Snoop Response was received which indicates the data was writ=
ten back to its home socket, and the cacheline was forwarded to the request=
or socket.  This snoop response is only used in >=3D 4 socket systems.  It =
is used when a snoop HITM's in a remote caching agent and it directly forwa=
rds data to a requestor, and simultaneously returns data to its home socket=
 to be written back to memory.",
         "UMask": "0x20",
         "Unit": "CHA"
     },
@@ -616,7 +616,7 @@
         "EventCode": "0x5C",
         "EventName": "UNC_CHA_SNOOP_RESP.RSP_WBWB",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a transaction with the opcode ty=
pe Rsp*WB Snoop Response was received which indicates which indicates the d=
ata was written back to it's home.  This is returned when a non-RFO request=
 hits a cacheline in the Modified state. The Cache can either downgrade the=
 cacheline to a S (Shared) or I (Invalid) state depending on how the system=
 has been configured.  This reponse will also be sent when a cache requests=
 E (Exclusive) ownership of a cache line without receiving data, because th=
e cache must acquire ownership.",
+        "PublicDescription": "Counts when a transaction with the opcode ty=
pe Rsp*WB Snoop Response was received which indicates which indicates the d=
ata was written back to its home.  This is returned when a non-RFO request =
hits a cacheline in the Modified state. The Cache can either downgrade the =
cacheline to a S (Shared) or I (Invalid) state depending on how the system =
has been configured.  This response will also be sent when a cache requests=
 E (Exclusive) ownership of a cache line without receiving data, because th=
e cache must acquire ownership.",
         "UMask": "0x10",
         "Unit": "CHA"
     },
--=20
2.36.0.464.gb9c8b46e94-goog

