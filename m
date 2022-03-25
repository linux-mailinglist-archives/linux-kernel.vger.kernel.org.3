Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2ED4E6D65
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 05:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358261AbiCYEo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 00:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244039AbiCYEo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 00:44:56 -0400
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E89A5E154;
        Thu, 24 Mar 2022 21:43:19 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="67012657"
X-IronPort-AV: E=Sophos;i="5.90,209,1643641200"; 
   d="scan'208";a="67012657"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Mar 2022 13:43:17 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8B145E07EC;
        Fri, 25 Mar 2022 13:43:15 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 38E4B28715B5;
        Fri, 25 Mar 2022 13:43:14 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id 0192F403FAAB5;
        Fri, 25 Mar 2022 13:43:13 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [RFC PATCH v2 0/7] libperf: Add interface for overflow check of sampling events
Date:   Fri, 25 Mar 2022 13:38:22 +0900
Message-Id: <20220325043829.224045-1-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds interface for overflow check of sampling events
to libperf.

First patch fixes a typo in the error message that I noticed.

Second patch move 'open_flags' from tools/perf to evsel::open_flags.

Third patch adds a interface to perform IOC_REFRESH and IOC_PERIOD.

Fourth patch introduce perf_{evsel, evlist}__open_opt() with extensible
structure opts.

Fifth patch adds a interface to check overflowed events.

Sixth and seventh patch adds tests.

---
Previous version at:
https://lore.kernel.org/linux-perf-users/20220225103114.144239-1-nakamura.shun@fujitsu.com/

Changes in v2:
 - Delete perf_evsel__set_close_on_exec() function
 - Introduce perf_{evsel, evlist}__open_opt() with extensible structure
   opts
 - Fix perf_evsel__set_signal() to a internal function
 - Add bool type argument to perf_evsel__check_{fd, fd_cpu}() to indicate
   overflow results


Shunsuke Nakamura (7):
  libperf tests: Fix typo in the error message
  libperf: Move 'open_flags' from tools/perf to evsel::open_flags
  libperf: Add perf_evsel__{refresh, period}() functions
  libperf: Introduce perf_{evsel, evlist}__open_opt with extensible
    struct opts
  libperf: Add perf_evsel__check_overflow() functions
  libperf test: Add test_stat_overflow()
  libperf test: Add test_stat_overflow_event()

 tools/lib/perf/Documentation/libperf.txt |  22 +++
 tools/lib/perf/evlist.c                  |  20 +++
 tools/lib/perf/evsel.c                   | 210 ++++++++++++++++++++++-
 tools/lib/perf/include/internal/evsel.h  |   2 +
 tools/lib/perf/include/perf/evlist.h     |   3 +
 tools/lib/perf/include/perf/evsel.h      |  35 ++++
 tools/lib/perf/internal.h                |  44 +++++
 tools/lib/perf/libperf.map               |   8 +
 tools/lib/perf/tests/test-evlist.c       | 135 ++++++++++++++-
 tools/lib/perf/tests/test-evsel.c        | 111 ++++++++++++
 tools/perf/util/evsel.c                  |  16 +-
 tools/perf/util/evsel.h                  |   1 -
 12 files changed, 588 insertions(+), 19 deletions(-)

-- 
2.25.1

