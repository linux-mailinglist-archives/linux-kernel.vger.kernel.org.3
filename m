Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253B454431F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbiFIFYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiFIFYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:24:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128F62BDC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 22:24:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b6-20020a252e46000000b0065d5168f3f0so19279443ybn.21
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 22:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7XF9Ovw3kggDsMB//JiO35wPNulyyyK2DnQRx8sKbCw=;
        b=Qxt+qHfYhDcOmc8hJ0bwanQhLdkNTTw/fTHYnVI3n9lc9yKskzsAgPUblvzaiKqzki
         f4R+lZJq29nNw2NS9A2gMI8kKaT12s3IhM+pX4QiU0AQrQ0qe/G4kYYOKL4Oz+KPv82X
         7lDgoVC5Fl/2mmrBnJzIwfT/hm0Hp/dNnPONk4i7CseHykg9pWWgTQuRqjzOnWZLYoe9
         kPG0qrkCgz/oKwWwvd0zLDJGFiYnrGgZTbqMxeE3QmbZPzlNqwlr2qca2eSgyrf2s/ej
         5BDSK7xwy0GfLGHT32urHkpiQqk95ILmj57wVUSRiEvC+FoQ38ZkFZH9Rl0lU3I99xqa
         pH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7XF9Ovw3kggDsMB//JiO35wPNulyyyK2DnQRx8sKbCw=;
        b=ygUwdzflJUhO/JP22izNUgX3nFi1yUieK+PNPWclR2uMrsujtL/saK0ZehNb4sHj4H
         sxTtm/S22LFUrUn3uNnT5pmuS2WxcPCCPXAfs/lCgN2LrQnZrENQPyGwZO7pBsUNtN2Q
         NZvZmMGBTeG2J0PHtHMqxNdT3ru33iEbKrAFPtXf5RD5TurcDibqgBrb236t9m+CHnNo
         HShtdoXtlZPCMtU3x28jOz6rbsirNdxVPl7pvVlmXRc4/7nMnYEONyyFlZZAGzD8GP+J
         JKaprkvox3kjxdL4Siu3h0KA5mW7YsjoJJOGm7VUEi4qs3B3gBNkifoPSASjWBT6crJz
         PXxQ==
X-Gm-Message-State: AOAM5331g09Ku7UlAd7UrfVE1yo1I/iX/o5efUfVIO20LtXIOJSK+Bu5
        kxcS9xsm949kFelLDj1QxSE4+9t4stFD
X-Google-Smtp-Source: ABdhPJwf1EjrawTD8TkuztwNA6YeKtP7aL1hFxOD/Pfd+D7027QpFXS+X5Jr8E+OajcbsOHLBLEehH23wdcM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ae20:7578:fb21:976b])
 (user=irogers job=sendgmr) by 2002:a25:2385:0:b0:664:381c:7c98 with SMTP id
 j127-20020a252385000000b00664381c7c98mr1028385ybj.7.1654752241781; Wed, 08
 Jun 2022 22:24:01 -0700 (PDT)
Date:   Wed,  8 Jun 2022 22:23:51 -0700
Message-Id: <20220609052355.1300162-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 0/4] Tidy user rdpmc documentation and testing
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>
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

libperf's perf_mmap__read_self and the addition of arm64 support mean
that the perf_event.h and the rdpmc perf test have become
stale. Refresh the documentation in perf_event.h, remove the x86 rdpmc
test and port the libperf test as a non-architecture specific test.

Address sanitizer testing showed libperf leaking fds when the
perf_event_open failed, add error paths to handle this.

A comment is added to perf_event.h to avoid a divide by zero when
scaling counts if the running time is 0. This was previously discussed
in this thread:
https://lore.kernel.org/lkml/CAP-5=fVRdqvswtyQMg5cB+ntTGda+SAYskjTQednEH-AeZo13g@mail.gmail.com/

v2. Alters the skip in test_stat_user_read for open to always be a
    skip as perf_event_open may fail with EACCES (permissions), ENOSYS
    (not supported) and ENOENT (hypervisor). Adds Rob Herring's
    acked-by on patch 3.

Ian Rogers (4):
  libperf evsel: Open shouldn't leak fd on failure
  perf: Align user space counter reading with code
  perf test: Remove x86 rdpmc test
  perf test: Add user space counter reading tests

 include/uapi/linux/perf_event.h        |  32 +++--
 tools/include/uapi/linux/perf_event.h  |  32 +++--
 tools/lib/perf/evsel.c                 |  17 ++-
 tools/perf/arch/x86/tests/Build        |   1 -
 tools/perf/arch/x86/tests/arch-tests.c |   2 -
 tools/perf/arch/x86/tests/rdpmc.c      | 182 -------------------------
 tools/perf/tests/mmap-basic.c          | 127 ++++++++++++++++-
 7 files changed, 176 insertions(+), 217 deletions(-)
 delete mode 100644 tools/perf/arch/x86/tests/rdpmc.c

-- 
2.36.1.255.ge46751e96f-goog

