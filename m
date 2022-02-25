Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278D34C427A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbiBYKgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239591AbiBYKgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:36:40 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Feb 2022 02:36:08 PST
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73F52399FF;
        Fri, 25 Feb 2022 02:36:08 -0800 (PST)
IronPort-SDR: mF18xzTCaAF9LizDX+nLBTJqAkHxAuMIqcLxSk0viGbRNjnMM7Q4e7FzSMKi5AzkbBY4QyoLsG
 ke91y1/gSqHpyu3ImsQap9BFetH/KjsUsqL9zXTfHMHjCTKNZ6TA6whir4+c7mEFweE93k1JNY
 hZTe4shcAL5a4UyPpdzUuvtzk53Fnh2SY1GyKxkEfveOhfMrdSnm9dHnw7A9GwfQeTh9tCWyV5
 kKNFA9NEYskKp09bGLsQ0P8SSNI3C9WSGwNW66mi6FExupn7qQXhdfrHcP4XRSpKu6+ACrRXIo
 C8NmtOoJzEoP43z4Rh8O0lVr
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="64248419"
X-IronPort-AV: E=Sophos;i="5.90,136,1643641200"; 
   d="scan'208";a="64248419"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Feb 2022 19:35:03 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id A224BE8CF7;
        Fri, 25 Feb 2022 19:35:01 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id DD0EF14258;
        Fri, 25 Feb 2022 19:35:00 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id D810D40124EED;
        Fri, 25 Feb 2022 19:35:00 +0900 (JST)
From:   Shunsuke <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [RFC PATCH 0/7] libperf: Add overflow detection of sampling events
Date:   Fri, 25 Feb 2022 19:31:07 +0900
Message-Id: <20220225103114.144239-1-nakamura.shun@fujitsu.com>
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

From: Shunsuke Nakamura <nakamura.shun@fujitsu.com>

This patch series adds sampling event overflow detection capability
to libperf.

First patch fixes a typo in the error message that I noticed.

Second patch  adds a interface to set PERF_FLAG_FD_CLOEXEC

Third patch adds a interface to perform IOC_REFRESH and IOC_PERIOD.

Fourth patch adds a interface to set the signal handler.

Fifth patch adds a interface to detect overflowed events.

Sixth and seventh patch adds tests.

Shunsuke Nakamura (7):
  libperf tests: Fix typo in the error message "evsel" -> "evlist"
  libperf: Add perf_evsel__set_close_on_exec() function
  libperf: Add perf_evsel__refresh()/period() functions
  libperf: Add perf_evsel__set_signal() functions
  libperf: Add perf_evsel__check_fd() functions
  libperf test: Add test_stat_overflow()
  libperf test: Add test_detect_overflow_event()

 tools/lib/perf/Documentation/libperf.txt |  12 ++
 tools/lib/perf/evsel.c                   | 215 ++++++++++++++++++++++-
 tools/lib/perf/include/internal/evsel.h  |   2 +
 tools/lib/perf/include/perf/evsel.h      |  14 ++
 tools/lib/perf/libperf.map               |   9 +
 tools/lib/perf/tests/test-evlist.c       | 127 ++++++++++++-
 tools/lib/perf/tests/test-evsel.c        | 110 ++++++++++++
 tools/perf/util/evsel.c                  |  16 +-
 tools/perf/util/evsel.h                  |   1 -
 9 files changed, 487 insertions(+), 19 deletions(-)

-- 
2.31.1

