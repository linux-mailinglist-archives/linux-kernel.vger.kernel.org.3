Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A282D512D93
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343652AbiD1IBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343620AbiD1IAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:00:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9349C9D4DE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:57:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a17-20020a258051000000b00648703d0c56so3841832ybn.22
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YJUrqLDRkW6XFs1LbuKzWxIFMP68m/VaBzEc39ALE+U=;
        b=tiVmLpJYc9sLTq3hljAB9UeCbbmiRtZLd4AP6UgZbKHQT+ILZ5mJdvRU554UMkbcRB
         XVTn/kgY1msKabcL8CxzLh0mKMrDKfB6fgtGuaoEiJjwjb5OYHoWbNZLILU461t3nVw6
         0o88dzuLGTqEK1Y2upaJRZV1w9E3tSzphBJpY1cE+et1msozSnB6jZHT376GCj9xccry
         Rd7urBIDCowMrub+uU99IgAE3kWfvSOR464wFTr/T673XQ5gyoPFWwXMmp+XiLPKXbTN
         RLVEYBt0b4nOVKlgqSq10mE26kb4Jju2+Qrrmf+X+kNv9q3jKyULdJAceUtvZrN7FEzr
         wWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YJUrqLDRkW6XFs1LbuKzWxIFMP68m/VaBzEc39ALE+U=;
        b=6cwbHY086srnuSB8mEoszMP8BCCP8lXBcr9a09V5FobM1TpLXGdZKBBQl7x3dq18PZ
         nuEiME2yMlrXYjJI96iXZQGUrTZ/aPcKGGGAaKE6QkB+qHeif1wTgejKaIu+OFbHHcPp
         18QvT7Z3YCnBBEoq4PV38Dli4833NyHxNA8s3zZMxHo45c+JR4Rb3FB0zPVblmTbY1rl
         H8e4tHtGIj+RzuGA3zQ1KZS+tCqKtBZboZi4a0Xry9LtU0AxDuUau7dBgm6MXQEK+AcK
         PvB8g6EQ1FEn6K5wHv2wKnVAF9Vg4SmldgF6NcWK8dt9/vfTJwQn9R5lQy7m2zdJJ28T
         cFqA==
X-Gm-Message-State: AOAM530gZwx2P+tB4kum6JBrnP5vThnrlhh56YlOtgGrEj1vrhgw5MQy
        xqqZUdAxFlYgQ0amIZbaRmLqe0tbvdqv
X-Google-Smtp-Source: ABdhPJzx0C734IUdOU5ceXOqZse08DmdcPmxgUK0lFcbnPRIHEkmYdfuAV00MGZOKjo3ttr/EjCe6OOIxIpL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:33c3:c9d8:c4fd:e75c])
 (user=irogers job=sendgmr) by 2002:a81:2514:0:b0:2f4:e0e6:d82f with SMTP id
 l20-20020a812514000000b002f4e0e6d82fmr30095090ywl.77.1651132657581; Thu, 28
 Apr 2022 00:57:37 -0700 (PDT)
Date:   Thu, 28 Apr 2022 00:57:25 -0700
In-Reply-To: <20220428075730.797727-1-irogers@google.com>
Message-Id: <20220428075730.797727-2-irogers@google.com>
Mime-Version: 1.0
References: <20220428075730.797727-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 2/7] perf vendor events intel: Update ICL events to v1.13
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Events are generated for Icelake v1.13 with events from:
https://download.01.org/perfmon/ICL/

Using the scripts at:
https://github.com/intel/event-converter-for-linux-perf/

This change updates descriptions and adds INST_DECODED.DECODERS.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/icelake/cache.json    | 41 +------------------
 .../arch/x86/icelake/icl-metrics.json         | 12 ------
 .../pmu-events/arch/x86/icelake/memory.json   | 10 +----
 .../pmu-events/arch/x86/icelake/other.json    | 24 -----------
 .../pmu-events/arch/x86/icelake/pipeline.json | 12 ++++++
 5 files changed, 14 insertions(+), 85 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/icelake/cache.json b/tools/perf/pmu-events/arch/x86/icelake/cache.json
index 375ce490833c..9989f3338f0a 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/cache.json
@@ -563,7 +563,6 @@
         "MSRValue": "0x3FC03C0004",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -578,7 +577,6 @@
         "MSRValue": "0x10003C0004",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -593,7 +591,6 @@
         "MSRValue": "0x4003C0004",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -608,7 +605,6 @@
         "MSRValue": "0x2003C0004",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -623,7 +619,6 @@
         "MSRValue": "0x1003C0004",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -638,7 +633,6 @@
         "MSRValue": "0x1E003C0004",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -653,7 +647,6 @@
         "MSRValue": "0x3FC03C0001",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -668,7 +661,6 @@
         "MSRValue": "0x10003C0001",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -683,7 +675,6 @@
         "MSRValue": "0x4003C0001",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -698,7 +689,6 @@
         "MSRValue": "0x2003C0001",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -713,7 +703,6 @@
         "MSRValue": "0x1003C0001",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -728,7 +717,6 @@
         "MSRValue": "0x1E003C0001",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -743,7 +731,6 @@
         "MSRValue": "0x3FC03C0002",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -758,7 +745,6 @@
         "MSRValue": "0x10003C0002",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -773,7 +759,6 @@
         "MSRValue": "0x4003C0002",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -788,7 +773,6 @@
         "MSRValue": "0x2003C0002",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -803,7 +787,6 @@
         "MSRValue": "0x1003C0002",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -818,7 +801,6 @@
         "MSRValue": "0x1E003C0002",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -833,7 +815,6 @@
         "MSRValue": "0x3FC03C0400",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -848,7 +829,6 @@
         "MSRValue": "0x2003C0400",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -863,7 +843,6 @@
         "MSRValue": "0x1003C0400",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -878,7 +857,6 @@
         "MSRValue": "0x3FC03C0010",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -893,7 +871,6 @@
         "MSRValue": "0x10003C0010",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -908,7 +885,6 @@
         "MSRValue": "0x4003C0010",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -923,7 +899,6 @@
         "MSRValue": "0x2003C0010",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -938,7 +913,6 @@
         "MSRValue": "0x1003C0010",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -953,7 +927,6 @@
         "MSRValue": "0x1E003C0010",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -968,7 +941,6 @@
         "MSRValue": "0x3FC03C0020",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -983,7 +955,6 @@
         "MSRValue": "0x10003C0020",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -998,7 +969,6 @@
         "MSRValue": "0x4003C0020",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -1013,7 +983,6 @@
         "MSRValue": "0x2003C0020",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -1028,7 +997,6 @@
         "MSRValue": "0x1003C0020",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -1043,7 +1011,6 @@
         "MSRValue": "0x1E003C0020",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -1058,7 +1025,6 @@
         "MSRValue": "0x3FC03C2380",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -1073,7 +1039,6 @@
         "MSRValue": "0x4003C8000",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -1088,7 +1053,6 @@
         "MSRValue": "0x2003C8000",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -1103,7 +1067,6 @@
         "MSRValue": "0x1003C8000",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -1118,7 +1081,6 @@
         "MSRValue": "0x1E003C8000",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -1133,7 +1095,6 @@
         "MSRValue": "0x3FC03C0800",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -1308,4 +1269,4 @@
         "Speculative": "1",
         "UMask": "0x4"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
index ea73bc1889ba..622c392f59be 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
@@ -17,18 +17,6 @@
         "MetricGroup": "Ret;Summary",
         "MetricName": "IPC"
     },
-    {
-        "BriefDescription": "Uops Per Instruction",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
-        "MetricGroup": "Pipeline;Ret;Retire",
-        "MetricName": "UPI"
-    },
-    {
-        "BriefDescription": "Instruction per taken branch",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / BR_INST_RETIRED.NEAR_TAKEN",
-        "MetricGroup": "Branches;Fed;FetchBW",
-        "MetricName": "UpTB"
-    },
     {
         "BriefDescription": "Cycles Per Instruction (per Logical Processor)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD)",
diff --git a/tools/perf/pmu-events/arch/x86/icelake/memory.json b/tools/perf/pmu-events/arch/x86/icelake/memory.json
index f045e1f6a868..a6f43cbc2d0a 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/memory.json
@@ -239,7 +239,6 @@
         "MSRValue": "0x3FFFC00004",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -254,7 +253,6 @@
         "MSRValue": "0x3FFFC00001",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -269,7 +267,6 @@
         "MSRValue": "0x3FFFC00002",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -284,7 +281,6 @@
         "MSRValue": "0x3FFFC00400",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -299,7 +295,6 @@
         "MSRValue": "0x3FFFC00010",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -314,7 +309,6 @@
         "MSRValue": "0x3FFFC00020",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -329,7 +323,6 @@
         "MSRValue": "0x3FFFC08000",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -344,7 +337,6 @@
         "MSRValue": "0x3FFFC00800",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -570,4 +562,4 @@
         "Speculative": "1",
         "UMask": "0x40"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/icelake/other.json b/tools/perf/pmu-events/arch/x86/icelake/other.json
index 2e177f95a9cb..3055710595c4 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/other.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/other.json
@@ -45,7 +45,6 @@
         "MSRValue": "0x10004",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -60,7 +59,6 @@
         "MSRValue": "0x184000004",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -75,7 +73,6 @@
         "MSRValue": "0x184000004",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -90,7 +87,6 @@
         "MSRValue": "0x10001",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -105,7 +101,6 @@
         "MSRValue": "0x184000001",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -120,7 +115,6 @@
         "MSRValue": "0x184000001",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -135,7 +129,6 @@
         "MSRValue": "0x10002",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -150,7 +143,6 @@
         "MSRValue": "0x184000002",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -165,7 +157,6 @@
         "MSRValue": "0x184000002",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -180,7 +171,6 @@
         "MSRValue": "0x10400",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -195,7 +185,6 @@
         "MSRValue": "0x184000400",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -210,7 +199,6 @@
         "MSRValue": "0x184000400",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -225,7 +213,6 @@
         "MSRValue": "0x10010",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -240,7 +227,6 @@
         "MSRValue": "0x184000010",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -255,7 +241,6 @@
         "MSRValue": "0x184000010",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -270,7 +255,6 @@
         "MSRValue": "0x10020",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -285,7 +269,6 @@
         "MSRValue": "0x184000020",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -300,7 +283,6 @@
         "MSRValue": "0x184000020",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -315,7 +297,6 @@
         "MSRValue": "0x18000",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -330,7 +311,6 @@
         "MSRValue": "0x184008000",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -345,7 +325,6 @@
         "MSRValue": "0x184008000",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -360,7 +339,6 @@
         "MSRValue": "0x10800",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -375,7 +353,6 @@
         "MSRValue": "0x184000800",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
@@ -390,7 +367,6 @@
         "MSRValue": "0x184000800",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x1"
diff --git a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json b/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
index 2b58cfaaaf39..a017a4727050 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
@@ -452,6 +452,18 @@
         "Speculative": "1",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Instruction decoders utilized in a cycle",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x55",
+        "EventName": "INST_DECODED.DECODERS",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Number of decoders utilized in a cycle when the MITE (legacy decode pipeline) fetches instructions.",
+        "SampleAfterValue": "2000003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Number of instructions retired. Fixed Counter - architectural event",
         "CollectPEBSRecord": "2",
-- 
2.36.0.464.gb9c8b46e94-goog

