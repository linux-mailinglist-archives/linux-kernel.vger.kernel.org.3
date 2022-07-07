Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9709256A708
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 17:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbiGGPfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 11:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiGGPe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 11:34:59 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9438825C74
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 08:34:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31c858e18c8so93594437b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 08:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JPNq22s4Sy/o1YYPxoUMk+4EEOxIdHQBfK6EdFJLOOg=;
        b=SQE2A23hnNI/zu3R8uKGwTvomwdPbUSNZQV/asqSSPx3/cSgi3s0m5iH5rJxmNXeX2
         TZXk3Y8C22+PbPrk0GFwWIgPORiflwRkXMnWZMqWoE7jiUVIXn2vSPj4USBaFn0idP0c
         cxSSFBSOXzzDdMUAaPX1iGGuG1Oxi9H9YCWxKSyIMSVbJUyoVa5nyo9RdfDRVxYLxdSW
         arH1ngRM2kfRw/srdMpTSthm7rndRlWxF0981zsYwcYUsr75PcaQnWbupazsMRy0iqhY
         eurVD3D0VAOQ2+13JmneX+X+6gIUAKX4b5y4Zr8665YQw4CyRljbzIieuQICXlYDzePe
         nVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JPNq22s4Sy/o1YYPxoUMk+4EEOxIdHQBfK6EdFJLOOg=;
        b=ZBjSwz7HFflBCXUuvaR7L2pAiIsBst7veEmQtfUrZYCSHReD9aTPw5SOPmfo6rCUPO
         UBDvzLbSZ5cgyXg59vFb5tlHDSUNkcqogWBftCHOdvAC5qYIPRtffk4h20zD5IhgY90z
         hHJR/DYE0jGA20nptBYVdWLT7AxXPnZk4pLgaMtIcTs1q4+Ltq9+6hWfdUHRGv4dD2Td
         EjdBIzyNReVAiV+YmFuwA+phTxWM6bXPWb232y2T1Usvl2RXISP6M8V118UH4rufEiRH
         6Otb8+lU4lWr2bgbmIxcu4jeNywDEMpWiCbWY4kI5XCTRu/i3Be4Ni4ahsUiWKl3hHQ0
         T3bg==
X-Gm-Message-State: AJIora8WD8s4IS6DrFX6CpQXJR1ZYgbMBzLMueedhi1QDeNZ1M0+5GtR
        Nk9r72CwMSRvD20ziq3FEQ6mIE9c8sGQ
X-Google-Smtp-Source: AGRyM1s63ZP4o3pRUGb4fsS16tmXLtlehiakB7y0YWBb2jjFDknJa8L16HQjDapCN2DRg5MB+PXZU+UGbiCy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bf75:f79:d509:a8d1])
 (user=irogers job=sendgmr) by 2002:a25:1f44:0:b0:66c:8185:7c2e with SMTP id
 f65-20020a251f44000000b0066c81857c2emr48521849ybf.629.1657208097823; Thu, 07
 Jul 2022 08:34:57 -0700 (PDT)
Date:   Thu,  7 Jul 2022 08:34:48 -0700
Message-Id: <20220707153449.202409-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH 1/2] perf test: Add debug line to diagnose broken metrics
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
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

Printing out the metric name and architecture makes finding the source
of a failure easier.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index f13368569d8b..478b33825790 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -1115,6 +1115,7 @@ static int test__parsing_fake(struct test_suite *test __maybe_unused,
 				break;
 			if (!pe->metric_expr)
 				continue;
+			pr_debug("Found metric '%s' for '%s'\n", pe->metric_name, map->cpuid);
 			err = metric_parse_fake(pe->metric_expr);
 			if (err)
 				return err;
-- 
2.37.0.rc0.161.g10f37bed90-goog

