Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249DC50B454
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446194AbiDVJsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446208AbiDVJsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:48:09 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Apr 2022 02:45:11 PDT
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0433CA4A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:45:10 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="50466635"
X-IronPort-AV: E=Sophos;i="5.90,281,1643641200"; 
   d="scan'208";a="50466635"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP; 22 Apr 2022 18:44:04 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 88985D3EAB;
        Fri, 22 Apr 2022 18:44:03 +0900 (JST)
Received: from oym-om1.fujitsu.com (oym-om1.o.css.fujitsu.com [10.85.58.161])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id CB39EE663A;
        Fri, 22 Apr 2022 18:44:02 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by oym-om1.fujitsu.com (Postfix) with ESMTP id 7C07940483741;
        Fri, 22 Apr 2022 18:44:02 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 0/7] libperf: Add interface for overflow check of sampling events
Date:   Fri, 22 Apr 2022 18:38:26 +0900
Message-Id: <20220422093833.340873-1-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds interface for overflow check of sampling events
to libperf.

First patch move 'open_flags' from tools/perf to evsel::open_flags.

Second patch introduce perf_{evsel, evlist}__open_opt() with extensible
structure opts.

Third patch add support for overflow handling of sampling events.

Fourth patch adds a interface to check overflowed events.

Fifth patch adds a interface to perform IOC_REFRESH and IOC_PERIOD.

Sixth and seventh patch adds tests.


---
Previous version at:
https://lore.kernel.org/linux-perf-users/20220325043829.224045-1-nakamura.shun@fujitsu.com/

Changes in v1:
 - Move initialization/reference of evsel->open_flags from the first
   patch to the second patch
 - Move signal-related handling and related fields of the opts
   structure from the second patch to the third patch
 - Move _GNU_SOURCE from test-evlist.c to Makefile
 - Delete *_cpu() function
 - Refactor the fourth patch
 - Fix test to use real-time signals instead of standard signals

Changes in RFC v2:
 - Delete perf_evsel__set_close_on_exec() function
 - Introduce perf_{evsel, evlist}__open_opt() with extensible structure
   opts
 - Fix perf_evsel__set_signal() to a internal function
 - Add bool type argument to perf_evsel__check_{fd, fd_cpu}() to indicate
   overflow results


Shunsuke Nakamura (7):
  libperf: Move 'open_flags' from tools/perf to evsel::open_flags
  libperf: Introduce perf_{evsel, evlist}__open_opt with extensible
    struct opts
  libperf: Add support for overflow handling of sampling events
  libperf: Add perf_evsel__has_fd() functions
  libperf: Add perf_evsel__{refresh, period}() functions
  libperf test: Add test_stat_overflow()
  libperf test: Add test_stat_overflow_event()

 tools/lib/perf/Documentation/libperf.txt |  17 +++
 tools/lib/perf/Makefile                  |   1 +
 tools/lib/perf/evlist.c                  |  20 +++
 tools/lib/perf/evsel.c                   | 166 ++++++++++++++++++++++-
 tools/lib/perf/include/internal/evsel.h  |   2 +
 tools/lib/perf/include/perf/evlist.h     |   3 +
 tools/lib/perf/include/perf/evsel.h      |  29 ++++
 tools/lib/perf/internal.h                |  44 ++++++
 tools/lib/perf/libperf.map               |   5 +
 tools/lib/perf/tests/test-evlist.c       | 112 ++++++++++++++-
 tools/lib/perf/tests/test-evsel.c        | 108 +++++++++++++++
 tools/perf/util/evsel.c                  |  16 ++-
 tools/perf/util/evsel.h                  |   1 -
 13 files changed, 508 insertions(+), 16 deletions(-)

-- 
2.25.1

