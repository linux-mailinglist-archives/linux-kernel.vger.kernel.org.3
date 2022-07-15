Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823415769F0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 00:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiGOWfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 18:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiGOWf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 18:35:27 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5F76BC03
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:35:26 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id o5-20020a170902d4c500b0016c643623e8so2730722plg.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Uj8SeARJLMyg9DKNAY9bhB9140qxBdG/Kjci8bJYAcA=;
        b=B3mv3BlHwHMDgtvov1Ex0MLQMTBHWfAjEw5B98QgJ10P4WsUB7Hy0Iuv/h2Ddm22Yd
         1kAx+gsJSeNNS7hcFZwLJ0Iy6NKjM9EOSq2DLHkp4shetdd+QkMRP3pV0XDUM+hw6lK4
         lJFoo13P+QpUdXVaNQ8uhiUfMo0VJOy97oxhIGpucim/MJ0PWEy9+Un8UZXO1ovLjdKT
         tJGIGgWQHw7p4syJxZFPHxZXtg7aZcTtmjfhxezdgJ5mlAHRU2L15GkM5bjq65pr2z0p
         mTP/FUyRJTeZbS5Grbv4Xnv+r76K2lIJATz41DbiHYp3n/83gCEkHvAU6kC/Vl/X6wVe
         7ilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Uj8SeARJLMyg9DKNAY9bhB9140qxBdG/Kjci8bJYAcA=;
        b=7IPB8yEGxMWCsBCmHkP00kLC4c1z86PJfDLjhPxYGRDAMqimrOWLWmyxyPOa5jMAOx
         GVcCwlJRdjnIIYJp/Jm001ZwPvapK9WU6E0mK/dVzrc37FoCoSfZEy+hF+1jACjtADw/
         qWg+ES3Yo0xn6PtHSbNlokMLLkRU91XTCooYh7zppQUFu6yxG+gYqnnJTP08ujp1h3tM
         gca7Z1M3UaA89YOYUNq4KQXcHLZ2hnTy/1LKUcvuowlg2PnlmoF5w6pq2BQPrWREM2lS
         K9Rrlyzi+nm9JyKAAzRORra2vgt2nnPnSAKMzrskmsShvkI+1zZET0zxdcD1J1kebPIU
         qtTQ==
X-Gm-Message-State: AJIora/sezHhl/z74mdM53czZ0Lh0RtFDYa5IReMwFNh/wUOurAr9Kv9
        zYJy5Q1Z5RkAO9unMbccF/az1IP08oqB
X-Google-Smtp-Source: AGRyM1uSAOMdbZrHCTFno/wdibRMWE6UTsIa2Rm/sYU3ri4fJ2Yh2RItC7fxs2mk+32HpyRDzEtGwQOnAUzb
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:72de:b499:63be:efe1])
 (user=irogers job=sendgmr) by 2002:a05:6a00:2347:b0:52a:cf39:59a5 with SMTP
 id j7-20020a056a00234700b0052acf3959a5mr15760131pfj.28.1657924526164; Fri, 15
 Jul 2022 15:35:26 -0700 (PDT)
Date:   Fri, 15 Jul 2022 15:35:19 -0700
Message-Id: <20220715223521.3389971-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v3 0/2] Add arch TSC frequency information
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

The first patch adds support for deriving from /proc/cpuinfo and adds
tests. The second patch from Kan Liang derives it from CPUID available
on newer Intel processors as discussed here:
https://lore.kernel.org/lkml/20220527040407.4193232-1-irogers@google.com/#t

v2. Adds warnings to make clear if things have changed/broken on future
    Intel platforms. It also adds caching and an Intel specific that a
    value is computed.

Ian Rogers (1):
  perf metrics: Add literal for system TSC frequency

Kan Liang (1):
  perf tsc: Add arch TSC frequency information

 tools/perf/arch/x86/util/cpuid.h  | 34 +++++++++++++++++
 tools/perf/arch/x86/util/header.c | 27 ++++++--------
 tools/perf/arch/x86/util/tsc.c    | 33 ++++++++++++++++
 tools/perf/tests/expr.c           | 15 ++++++++
 tools/perf/util/expr.c            | 62 +++++++++++++++++++++++++++++++
 tools/perf/util/tsc.h             |  1 +
 6 files changed, 156 insertions(+), 16 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/cpuid.h

-- 
2.37.0.170.g444d1eabd0-goog

