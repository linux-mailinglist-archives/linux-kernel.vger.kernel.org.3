Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6F5512D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343675AbiD1IBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245729AbiD1IA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:00:59 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4D19D4DB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:57:42 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2eb7d137101so39808127b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Hsajmj8rLYwGirl54xhdCr+0mU8psc9kLRKuOF6PETM=;
        b=ezJ/JH5GRKqZf/kWWOOu7pDI3tmXFS5KJmoitPcHXqGcXm5y0JJ1z9s11uMD3zYeEx
         gf63elo41d9uuakPVxvPcOS/cqNKH7GX1aKwjmnCHjGaUdqcO7CnxLO3eU2IYDGhMWRX
         ZfkMeQmS4NvdzCk+melYzpRRAaGQSdIiYCsqJPPu4UeIhmJVkJZDxsmnIiN5W/0DqodM
         8zNyemFhFwlcuRJRDQRIlZuXSs+GSmMruhsKdKagnoO6KflcZ/KeXNkjuOL/snnS8gTx
         dQiNbDEC151s2U3vRjPlkyYhNe8z1Sv+8oOO4jPZlQ4bcsKzpaoCD8mRtc/qF37KyGyh
         09Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Hsajmj8rLYwGirl54xhdCr+0mU8psc9kLRKuOF6PETM=;
        b=TMJybXLc3q7xRVBldNtENbxf4qsQdXEvrn/3xwjxJOsEYcyY8p8VINTJee+qkCUn0Y
         rOylhATUFgIIjsd6KsFtjaoTl+HoePg9WVsjH89Q8XlTxUWv1ux2Bd7LpzMyh8idMgPD
         0ujHxNUQ2bzOi9HgcBKkcc6E0FNOjtHhRkJy4myZ7I+KElo5y3MqIrsV3o2vQGzB6oOj
         dZcexZLXQccvXHEQ7Deki+6PA7UkQ426O2I3POpTdfWSwn9pSF6b2FiG2RTGMm/rYX6T
         /u0xoBCnCIE/NgfQ/DCHh9/1siSuGk8wXNkT4JTqmPDJpyg95inzl9ODpXc7kGY3K9t+
         fuRg==
X-Gm-Message-State: AOAM533fUhgVAHv1MV5P7Xf71fVawfjFCgoPlzMuIUUn/kyivPFxRbnf
        Yl4lNwJ2JhUoAzDAx79geZrv/lxYPsM7
X-Google-Smtp-Source: ABdhPJx6rb7zplTiky/7Hlke6XyoxGKYkXYh0XN7DJFeu4/ALAtJmrIjFzshDfxlKBiJU2+6zFParU1fLyv2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:33c3:c9d8:c4fd:e75c])
 (user=irogers job=sendgmr) by 2002:a25:9e89:0:b0:63c:ad37:a5de with SMTP id
 p9-20020a259e89000000b0063cad37a5demr29526430ybq.342.1651132661846; Thu, 28
 Apr 2022 00:57:41 -0700 (PDT)
Date:   Thu, 28 Apr 2022 00:57:27 -0700
In-Reply-To: <20220428075730.797727-1-irogers@google.com>
Message-Id: <20220428075730.797727-4-irogers@google.com>
Mime-Version: 1.0
References: <20220428075730.797727-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 4/7] perf vendor events intel: Update SKL events to v53
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

Events are generated for Skylake v53 with
events from:
https://download.01.org/perfmon/SKL/

Using the scripts at:
https://github.com/intel/event-converter-for-linux-perf/

This change updates descriptions, adds INST_DECODED.DECODERS and
corrects a counter mask in UOPS_RETIRED.TOTAL_CYCLES.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/skylake/cache.json    | 174 +-----------------
 .../pmu-events/arch/x86/skylake/memory.json   |  90 +--------
 .../pmu-events/arch/x86/skylake/pipeline.json |  14 +-
 3 files changed, 14 insertions(+), 264 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/skylake/cache.json b/tools/perf/pmu-events/arch/x86/skylake/cache.json
index c5d9a4ed10d7..c3183819bf52 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/cache.json
@@ -701,7 +701,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -714,7 +713,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC01C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -727,7 +725,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10001C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -740,7 +737,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4001C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -753,7 +749,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2001C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -766,7 +761,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x801C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -779,7 +773,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1001C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -792,7 +785,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x401C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -805,7 +797,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC0080004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -818,7 +809,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -831,7 +821,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -844,7 +833,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -857,7 +845,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -870,7 +857,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -883,7 +869,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x40080004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -896,7 +881,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC0040004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -909,7 +893,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -922,7 +905,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -935,7 +917,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -948,7 +929,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -961,7 +941,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -974,7 +953,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x40040004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -987,7 +965,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC0100004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1000,7 +977,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1013,7 +989,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1026,7 +1001,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1039,7 +1013,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1052,7 +1025,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1065,7 +1037,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x40100004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1078,7 +1049,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC0400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1091,7 +1061,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1104,7 +1073,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1117,7 +1085,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1130,7 +1097,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1143,7 +1109,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1156,7 +1121,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x40400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1169,7 +1133,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC0020004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1182,7 +1145,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1195,7 +1157,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1208,7 +1169,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1221,7 +1181,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1234,7 +1193,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1247,7 +1205,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x40020004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1260,7 +1217,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1273,7 +1229,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC01C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1286,7 +1241,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10001C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1299,7 +1253,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4001C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1312,7 +1265,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2001C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1325,7 +1277,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x801C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1338,7 +1289,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1001C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1351,7 +1301,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x401C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1364,7 +1313,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC0080001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1377,7 +1325,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1390,7 +1337,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1403,7 +1349,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1416,7 +1361,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1429,7 +1373,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1442,7 +1385,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x40080001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1455,7 +1397,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC0040001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1468,7 +1409,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1481,7 +1421,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1494,7 +1433,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1507,7 +1445,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1520,7 +1457,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1533,7 +1469,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x40040001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1546,7 +1481,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC0100001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1559,7 +1493,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1572,7 +1505,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1585,7 +1517,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1598,7 +1529,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1611,7 +1541,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1624,7 +1553,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x40100001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1637,7 +1565,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC0400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1650,7 +1577,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1663,7 +1589,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1676,7 +1601,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1689,7 +1613,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1702,7 +1625,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1715,7 +1637,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x40400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1728,7 +1649,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC0020001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1741,7 +1661,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1754,7 +1673,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1767,7 +1685,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1780,7 +1697,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1793,7 +1709,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1806,7 +1721,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x40020001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1819,7 +1733,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1832,7 +1745,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC01C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1845,7 +1757,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10001C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1858,7 +1769,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4001C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1871,7 +1781,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2001C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1884,7 +1793,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x801C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1897,7 +1805,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1001C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1910,7 +1817,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x401C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1923,7 +1829,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC0080002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1936,7 +1841,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000080002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1949,7 +1853,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400080002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1962,7 +1865,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200080002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1975,7 +1877,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1988,7 +1889,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100080002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2001,7 +1901,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x40080002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2014,7 +1913,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC0040002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2027,7 +1925,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000040002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2040,7 +1937,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400040002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2053,7 +1949,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200040002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2066,7 +1961,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80040002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2079,7 +1973,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100040002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2092,7 +1985,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x40040002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2105,7 +1997,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC0100002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2118,7 +2009,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000100002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2131,7 +2021,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400100002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2144,7 +2033,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200100002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2157,7 +2045,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80100002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2170,7 +2057,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100100002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2183,7 +2069,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x40100002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2196,7 +2081,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC0400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2209,7 +2093,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2222,7 +2105,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2235,7 +2117,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2248,7 +2129,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2261,7 +2141,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2274,7 +2153,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x40400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2287,7 +2165,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC0020002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2300,7 +2177,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000020002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2313,7 +2189,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400020002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2326,7 +2201,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200020002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2339,7 +2213,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80020002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2352,7 +2225,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100020002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2365,7 +2237,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x40020002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2378,7 +2249,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x18000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2391,7 +2261,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC01C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2404,7 +2273,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10001C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2417,7 +2285,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4001C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2430,7 +2297,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2001C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2443,7 +2309,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x801C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2456,7 +2321,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1001C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2469,7 +2333,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x401C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2482,7 +2345,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC0088000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2495,7 +2357,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000088000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2508,7 +2369,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400088000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2521,7 +2381,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200088000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2534,7 +2393,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80088000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2547,7 +2405,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100088000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2560,7 +2417,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x40088000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2573,7 +2429,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC0048000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2586,7 +2441,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000048000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2599,7 +2453,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400048000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2612,7 +2465,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200048000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2625,7 +2477,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80048000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2638,7 +2489,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100048000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2651,7 +2501,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x40048000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2664,7 +2513,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC0108000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2677,7 +2525,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000108000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2690,7 +2537,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400108000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2703,7 +2549,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200108000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2716,7 +2561,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80108000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2729,7 +2573,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100108000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2742,7 +2585,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x40108000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2755,7 +2597,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC0408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2768,7 +2609,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2781,7 +2621,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2794,7 +2633,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2807,7 +2645,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2820,7 +2657,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2833,7 +2669,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x40408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2846,7 +2681,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC0028000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2859,7 +2693,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1000028000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2872,7 +2705,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x400028000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2885,7 +2717,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x200028000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2898,7 +2729,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80028000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2911,7 +2741,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100028000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2924,7 +2753,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x40028000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -2974,4 +2802,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/skylake/memory.json b/tools/perf/pmu-events/arch/x86/skylake/memory.json
index 8500fc65e0e8..74ea4ccb4c9a 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/memory.json
@@ -275,7 +275,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x20001C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -288,7 +287,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000080004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -301,7 +299,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000040004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -314,7 +311,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000100004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -327,7 +323,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFC400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -340,7 +335,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -353,7 +347,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -366,7 +359,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -379,7 +371,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -392,7 +383,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x203C400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -405,7 +395,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -418,7 +407,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x7C400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -431,7 +419,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC4000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -444,7 +431,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -457,7 +443,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -470,7 +455,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -483,7 +467,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -496,7 +479,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2004000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -509,7 +491,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -522,7 +503,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x44000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -535,7 +515,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -548,7 +527,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000020004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -561,7 +539,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x20001C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -574,7 +551,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000080001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -587,7 +563,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000040001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -600,7 +575,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000100001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -613,7 +587,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFC400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -626,7 +599,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -639,7 +611,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -652,7 +623,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -665,7 +635,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -678,7 +647,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x203C400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -691,7 +659,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -704,7 +671,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x7C400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -717,7 +683,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC4000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -730,7 +695,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -743,7 +707,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -756,7 +719,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -769,7 +731,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -782,7 +743,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2004000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -795,7 +755,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -808,7 +767,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x44000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -821,7 +779,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -834,7 +791,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000020001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -847,7 +803,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x20001C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -860,7 +815,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000080002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -873,7 +827,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000040002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -886,7 +839,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000100002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -899,7 +851,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFC400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -912,7 +863,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -925,7 +875,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -938,7 +887,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -951,7 +899,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -964,7 +911,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x203C400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -977,7 +923,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -990,7 +935,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x7C400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1003,7 +947,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC4000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1016,7 +959,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1029,7 +971,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1042,7 +983,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1055,7 +995,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1068,7 +1007,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2004000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1081,7 +1019,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1094,7 +1031,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x44000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1107,7 +1043,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1120,7 +1055,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000020002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1133,7 +1067,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x20001C8000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1146,7 +1079,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000088000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1159,7 +1091,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000048000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1172,7 +1103,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000108000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1185,7 +1115,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFC408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1198,7 +1127,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x103C408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1211,7 +1139,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x43C408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1224,7 +1151,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x23C408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1237,7 +1163,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0xBC408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1250,7 +1175,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x203C408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1263,7 +1187,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x13C408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1276,7 +1199,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x7C408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1289,7 +1211,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FC4008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1302,7 +1223,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1004008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1315,7 +1235,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x404008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1328,7 +1247,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x204008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1341,7 +1259,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1354,7 +1271,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2004008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1367,7 +1283,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1380,7 +1295,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x44008000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1393,7 +1307,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1406,7 +1319,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x2000028000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1608,4 +1520,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x40"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/skylake/pipeline.json b/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
index 12eabae3e224..79fda10ec4bb 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
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
+        "PublicDescription": "Number of decoders utilized in a cycle when the MITE (legacy decode pipeline) fetches instructions.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Instructions retired from execution.",
         "Counter": "Fixed counter 0",
@@ -969,7 +979,7 @@
         "BriefDescription": "Cycles with less than 10 actually retired uops.",
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
-- 
2.36.0.464.gb9c8b46e94-goog

