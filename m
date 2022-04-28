Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE603512D8D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbiD1IBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343633AbiD1IBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:01:01 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA5620BCE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:57:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb7d137101so39808687b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=/Lw05Cs9fDmjLlyIrxN05E7hhLF70QDHkPxPWC8Omc0=;
        b=bgZOX3tOGFqO6HzG7+7om197eTXK7uchI9uC3mP7hBWSdkLh4m4e6s5aMaBeS+3/n2
         Q3wf0jgVtH73Jpg0sHsKuSl3ywGBLfNFyTxRYgWRaybxuAosLTp7pVtVe2W/0T6xcCtY
         DhLFDVQBU7d8XIPUccFsiG6k6ZJAOXtuXXVyI6+8rIs4EK4qM+U9nSfMOHurrxh+1bWj
         0GZzeFI3ipsnbT8QXdHmY8ZYxj3pKLnOrq7n6oBQJDNQEDAj/US5FE/w2lnSUJ7tvVq6
         Jrge4EJByoD4b2HsU/mQFdnkpyJ6ocSXYceDMkKxe/jDUWYye3VrSI6GFjn6TymFtjuF
         BXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=/Lw05Cs9fDmjLlyIrxN05E7hhLF70QDHkPxPWC8Omc0=;
        b=uaoAwxhNC/OBvoRmiSLvpRlWOPLkyeUJ93w3tHX0zW52mauDpEfWikTEiMVA6Cd7bY
         gtOIci529z/b3f5ZvqpTpOyNpFXVTPslPoJwH5cBEqeeXMEAISA+0vC/F/XWjtJMONPC
         dkH1a1eCOcZFGh/3opSUqdjo+ESEa8IQWiJew0T+G4qc4KOpsXUWq1h2t9KM0K2gNUwC
         yHkHFiyoOorRhq1eMQhHSPNJT2mHGYzJGg719lesMPIUiaxWiPKQJRA2D+4o7lSndXJo
         5cnSugUrvlDYTOCBVYNWQX5qJTyZvO68qDrQJTPwnFaYQqmSZ0wqxOyOO79WD9dOJWB/
         PRYw==
X-Gm-Message-State: AOAM5326wf9UkM9Keb8RHipRK1Rulx1++CqQ8MjUn+4t4axBdCXu31yF
        qv1IenYBeaqZt602yRK1miu6xndEjXpu
X-Google-Smtp-Source: ABdhPJwRfFWwui3XGy/vz3dSaVwibRTVcJFx8idtfdq9EUqaKlfEsU45jyTJn1ZQM/OpZHjFJbnScs2na+pe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:33c3:c9d8:c4fd:e75c])
 (user=irogers job=sendgmr) by 2002:a25:bcc7:0:b0:648:d728:d39 with SMTP id
 l7-20020a25bcc7000000b00648d7280d39mr6178476ybm.514.1651132664196; Thu, 28
 Apr 2022 00:57:44 -0700 (PDT)
Date:   Thu, 28 Apr 2022 00:57:28 -0700
In-Reply-To: <20220428075730.797727-1-irogers@google.com>
Message-Id: <20220428075730.797727-5-irogers@google.com>
Mime-Version: 1.0
References: <20220428075730.797727-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 5/7] perf vendor events intel: Update SKX events to v1.27
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Events are generated for Skylake Server v1.27 with
events from:
https://download.01.org/perfmon/SKX/

Using the scripts at:
https://github.com/intel/event-converter-for-linux-perf/

This change updates descriptions, adds INST_DECODED.DECODERS and
corrects a counter mask in UOPS_RETIRED.TOTAL_CYCLES.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/skylakex/cache.json   | 74 +------------------
 .../pmu-events/arch/x86/skylakex/memory.json  | 74 +------------------
 .../arch/x86/skylakex/pipeline.json           | 14 +++-
 .../arch/x86/skylakex/uncore-other.json       |  4 +-
 4 files changed, 16 insertions(+), 150 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/skylakex/cache.json b/tools/per=
f/pmu-events/arch/x86/skylakex/cache.json
index 6639e18a7068..e21010c0df41 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/cache.json
@@ -750,7 +750,6 @@
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
@@ -763,7 +762,6 @@
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
@@ -776,7 +774,6 @@
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
@@ -789,7 +786,6 @@
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
@@ -802,7 +798,6 @@
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
@@ -815,7 +810,6 @@
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
@@ -828,7 +822,6 @@
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
@@ -841,7 +834,6 @@
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
@@ -854,7 +846,6 @@
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
@@ -867,7 +858,6 @@
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
@@ -880,7 +870,6 @@
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
@@ -893,7 +882,6 @@
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
@@ -906,7 +894,6 @@
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
@@ -919,7 +906,6 @@
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
@@ -932,7 +918,6 @@
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
@@ -945,7 +930,6 @@
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
@@ -958,7 +942,6 @@
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
@@ -971,7 +954,6 @@
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
@@ -984,7 +966,6 @@
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
@@ -997,7 +978,6 @@
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
@@ -1010,7 +990,6 @@
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
@@ -1023,7 +1002,6 @@
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
@@ -1036,7 +1014,6 @@
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
@@ -1049,7 +1026,6 @@
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
@@ -1062,7 +1038,6 @@
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
@@ -1075,7 +1050,6 @@
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
@@ -1088,7 +1062,6 @@
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
@@ -1101,7 +1074,6 @@
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
@@ -1114,7 +1086,6 @@
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
@@ -1127,7 +1098,6 @@
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
@@ -1140,7 +1110,6 @@
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
@@ -1153,7 +1122,6 @@
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
@@ -1166,7 +1134,6 @@
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
@@ -1179,7 +1146,6 @@
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
@@ -1192,7 +1158,6 @@
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
@@ -1205,7 +1170,6 @@
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
@@ -1218,7 +1182,6 @@
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
@@ -1231,7 +1194,6 @@
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
@@ -1244,7 +1206,6 @@
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
@@ -1257,7 +1218,6 @@
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
@@ -1270,7 +1230,6 @@
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
@@ -1283,7 +1242,6 @@
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
@@ -1296,7 +1254,6 @@
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
@@ -1309,7 +1266,6 @@
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
@@ -1322,7 +1278,6 @@
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
@@ -1335,7 +1290,6 @@
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
@@ -1348,7 +1302,6 @@
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
@@ -1361,7 +1314,6 @@
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
@@ -1374,7 +1326,6 @@
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
@@ -1387,7 +1338,6 @@
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
@@ -1400,7 +1350,6 @@
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
@@ -1413,7 +1362,6 @@
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
@@ -1426,7 +1374,6 @@
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
@@ -1439,7 +1386,6 @@
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
@@ -1452,7 +1398,6 @@
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
@@ -1465,7 +1410,6 @@
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
@@ -1478,7 +1422,6 @@
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
@@ -1491,7 +1434,6 @@
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
@@ -1504,7 +1446,6 @@
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
@@ -1517,7 +1458,6 @@
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
@@ -1530,7 +1470,6 @@
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
@@ -1543,7 +1482,6 @@
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
@@ -1556,7 +1494,6 @@
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
@@ -1569,7 +1506,6 @@
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
@@ -1582,7 +1518,6 @@
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
@@ -1595,7 +1530,6 @@
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
@@ -1608,7 +1542,6 @@
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
@@ -1621,7 +1554,6 @@
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
@@ -1634,7 +1566,6 @@
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
@@ -1647,7 +1578,6 @@
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
@@ -1660,7 +1590,6 @@
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
@@ -1673,7 +1602,6 @@
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
@@ -1723,4 +1651,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/memory.json b/tools/pe=
rf/pmu-events/arch/x86/skylakex/memory.json
index 60c286b4fe54..a570fe3e7a2d 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/memory.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/memory.json
@@ -275,7 +275,6 @@
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
@@ -288,7 +287,6 @@
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
@@ -301,7 +299,6 @@
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
@@ -314,7 +311,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63FC00491",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -327,7 +323,6 @@
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
@@ -340,7 +335,6 @@
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
@@ -353,7 +347,6 @@
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
@@ -366,7 +359,6 @@
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
@@ -379,7 +371,6 @@
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
@@ -392,7 +383,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63FC00490",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -405,7 +395,6 @@
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
@@ -418,7 +407,6 @@
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
@@ -431,7 +419,6 @@
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
@@ -444,7 +431,6 @@
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
@@ -457,7 +443,6 @@
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
@@ -470,7 +455,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63FC00120",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -483,7 +467,6 @@
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
@@ -496,7 +479,6 @@
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
@@ -509,7 +491,6 @@
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
@@ -522,7 +503,6 @@
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
@@ -535,7 +515,6 @@
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
@@ -548,7 +527,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63FC00122",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -561,7 +539,6 @@
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
@@ -574,7 +551,6 @@
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
@@ -587,7 +563,6 @@
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
@@ -600,7 +575,6 @@
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
@@ -613,7 +587,6 @@
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
@@ -626,7 +599,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63FC00004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -639,7 +611,6 @@
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
@@ -652,7 +623,6 @@
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
@@ -665,7 +635,6 @@
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
@@ -678,7 +647,6 @@
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
@@ -691,7 +659,6 @@
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
@@ -704,7 +671,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63FC00001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -717,7 +683,6 @@
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
@@ -730,7 +695,6 @@
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
@@ -743,7 +707,6 @@
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
@@ -756,7 +719,6 @@
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
@@ -769,7 +731,6 @@
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
@@ -782,7 +743,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63FC00002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -795,7 +755,6 @@
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
@@ -808,7 +767,6 @@
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
@@ -821,7 +779,6 @@
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
@@ -834,7 +791,6 @@
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
@@ -847,7 +803,6 @@
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
@@ -860,7 +815,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63FC00400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -873,7 +827,6 @@
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
@@ -886,7 +839,6 @@
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
@@ -899,7 +851,6 @@
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
@@ -912,7 +863,6 @@
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
@@ -925,7 +875,6 @@
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
@@ -938,7 +887,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63FC00010",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -951,7 +899,6 @@
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
@@ -964,7 +911,6 @@
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
@@ -977,7 +923,6 @@
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
@@ -990,7 +935,6 @@
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
@@ -1003,7 +947,6 @@
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
@@ -1016,7 +959,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63FC00020",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1029,7 +971,6 @@
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
@@ -1042,7 +983,6 @@
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
@@ -1055,7 +995,6 @@
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
@@ -1068,7 +1007,6 @@
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
@@ -1081,7 +1019,6 @@
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
@@ -1094,7 +1031,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63FC00080",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1107,7 +1043,6 @@
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
@@ -1120,7 +1055,6 @@
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
@@ -1133,7 +1067,6 @@
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
@@ -1146,7 +1079,6 @@
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
@@ -1159,7 +1091,6 @@
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
@@ -1172,7 +1103,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x63FC00100",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1185,7 +1115,6 @@
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
@@ -1198,7 +1127,6 @@
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
@@ -1400,4 +1328,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x40"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json b/tools/=
perf/pmu-events/arch/x86/skylakex/pipeline.json
index 12eabae3e224..79fda10ec4bb 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
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
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json b/to=
ols/perf/pmu-events/arch/x86/skylakex/uncore-other.json
index 567d86434839..aa0f67613c4a 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
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
or socket.  This snoop response is only used in &gt;=3D 4 socket systems.  =
It is used when a snoop HITM's in a remote caching agent and it directly fo=
rwards data to a requestor, and simultaneously returns data to its home soc=
ket to be written back to memory.",
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

