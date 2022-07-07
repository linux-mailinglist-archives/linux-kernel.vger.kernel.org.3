Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F147856AEBB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236789AbiGGWsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbiGGWse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:48:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CB324B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 15:48:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z9-20020a258689000000b0066e38ab7122so9661374ybk.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 15:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eCmCH4ia+FpOlh6Qbg9jUQqKcntQY3qXlKfzy4/h0lc=;
        b=TN6tkuvWIZfPHJMHNfnojVmKgFrCGV9JCbnlcN1rKkt09Ajuq5uScFkFaRIaUSZ5K2
         fI+Ad47Yaci0VzXw3y8cTK61A5iogaE7BCGDiamC59iVLBrT/YDDJJ4lJZlZtO3SWTbK
         +X2DkVc7jFilCAshlOBA7rYLyOra8AC3Jkwx8xE8uYIZloIg4fyQ12p5WQez6UFbQ7Qp
         bo6Bwl9N3R1w1o+urMfEB/eliWmFTsX7xu0O8klNHk+exLpD45lmt9WDj5gzIGIMtzax
         FqpVTecJ7tvR4y+VZmtEQZZ5xvdJBKmkt7q6dT3rQgmVmORX2CA+5rbC3ExfrujoCb4o
         O86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eCmCH4ia+FpOlh6Qbg9jUQqKcntQY3qXlKfzy4/h0lc=;
        b=NtqUUJfIuZ1szDiDLCNQcTPS+L+DO88AQTjPnHZsqF+cwv5YtTncnuWmyDDaruFOkW
         tNyaCOjqvjK0BnKjrX4/ajdOQ1db3AJEYreo0YJFJ7bhPMJ186JqbJ2LGoeGixVsLurc
         tuRvHYlVPs+nSb7zz9sfPoYbFuQ6xIkhWMLcLdD9k9q1+vYKY8v49dq+4qp5r05AzCOp
         UYoPuDqsYFxSgTtzl+p8BJT9suxGRET9puk5hIVL+M07+xMJzMxquxmzAzT1MwCO2Xs7
         kglIfp+xcs19XNeUBWs+7uSDCWG/vCjR1D0YQTuANj6mgp6uV/IkfT7lu/Idpg8j5AmY
         dXfQ==
X-Gm-Message-State: AJIora+8jADryUpd13f5xa3oKOWnh4PEEWHUWZGN3nTFiR3Bwb35rVLd
        6v+D0TiWMWOmJV6338E2h5zHZGOOgaFj
X-Google-Smtp-Source: AGRyM1uMnSSCPUo7n0DmTUbpm1FIc7kPw54Vssxv5GRxmjytG8QzV8DjfLn4ZN+KpK1ndM8pnmztVSn+Omx1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bf75:f79:d509:a8d1])
 (user=irogers job=sendgmr) by 2002:a0d:cbd8:0:b0:31d:a46:a1ee with SMTP id
 n207-20020a0dcbd8000000b0031d0a46a1eemr602758ywd.201.1657234112381; Thu, 07
 Jul 2022 15:48:32 -0700 (PDT)
Date:   Thu,  7 Jul 2022 15:48:22 -0700
Message-Id: <20220707224822.420722-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] perf vendor events intel: Synchronize cpuids with 01.org
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>
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

Reduce rows in mapfile.csv by folding the cpuid regular expressions.
Make the cpuids match mapfile.csv on 01.org:
  https://download.01.org/perfmon/mapfile.csv

Note, this reduces the number of cpuids for icelake while increasing the
number of cpuids for goldmont.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 37 ++++++----------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index f5a382421a60..66dad6947627 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,49 +1,32 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-56,v5,broadwellde,core
-GenuineIntel-6-3D,v17,broadwell,core
-GenuineIntel-6-47,v17,broadwell,core
+GenuineIntel-6-(3D|47),v17,broadwell,core
 GenuineIntel-6-4F,v10,broadwellx,core
-GenuineIntel-6-1C,v4,bonnell,core
-GenuineIntel-6-26,v4,bonnell,core
-GenuineIntel-6-27,v4,bonnell,core
-GenuineIntel-6-36,v4,bonnell,core
-GenuineIntel-6-35,v4,bonnell,core
-GenuineIntel-6-5C,v8,goldmont,core
+GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
+GenuineIntel-6-5[CF],v8,goldmont,core
 GenuineIntel-6-7A,v1,goldmontplus,core
-GenuineIntel-6-3C,v24,haswell,core
-GenuineIntel-6-45,v24,haswell,core
-GenuineIntel-6-46,v24,haswell,core
+GenuineIntel-6-(3C|45|46),v24,haswell,core
 GenuineIntel-6-3F,v17,haswellx,core
 GenuineIntel-6-3A,v18,ivybridge,core
 GenuineIntel-6-3E,v19,ivytown,core
 GenuineIntel-6-2D,v20,jaketown,core
-GenuineIntel-6-57,v9,knightslanding,core
-GenuineIntel-6-85,v9,knightslanding,core
-GenuineIntel-6-1E,v2,nehalemep,core
-GenuineIntel-6-1F,v2,nehalemep,core
-GenuineIntel-6-1A,v2,nehalemep,core
+GenuineIntel-6-(57|85),v9,knightslanding,core
+GenuineIntel-6-1[AEF],v2,nehalemep,core
 GenuineIntel-6-2E,v2,nehalemex,core
-GenuineIntel-6-[4589]E,v24,skylake,core
-GenuineIntel-6-A[56],v24,skylake,core
-GenuineIntel-6-37,v13,silvermont,core
-GenuineIntel-6-4D,v13,silvermont,core
-GenuineIntel-6-4C,v13,silvermont,core
+GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v24,skylake,core
+GenuineIntel-6-(37|4C|4D),v14,silvermont,core
 GenuineIntel-6-2A,v15,sandybridge,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
 GenuineIntel-6-25,v2,westmereep-sp,core
 GenuineIntel-6-2F,v2,westmereex,core
 GenuineIntel-6-55-[01234],v1,skylakex,core
 GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
-GenuineIntel-6-7D,v1,icelake,core
 GenuineIntel-6-7E,v1,icelake,core
 GenuineIntel-6-8[CD],v1,tigerlake,core
-GenuineIntel-6-A7,v1,icelake,core
-GenuineIntel-6-6A,v1,icelakex,core
-GenuineIntel-6-6C,v1,icelakex,core
+GenuineIntel-6-6[AC],v1,icelakex,core
 GenuineIntel-6-86,v1,tremontx,core
 GenuineIntel-6-96,v1,elkhartlake,core
-GenuineIntel-6-97,v1,alderlake,core
-GenuineIntel-6-9A,v1,alderlake,core
+GenuineIntel-6-9[7A],v1,alderlake,core
 GenuineIntel-6-8F,v1,sapphirerapids,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
-- 
2.37.0.rc0.161.g10f37bed90-goog

