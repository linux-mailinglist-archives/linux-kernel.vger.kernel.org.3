Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93424610D6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241101AbhK2JNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:13:15 -0500
Received: from esa10.hc1455-7.c3s2.iphmx.com ([139.138.36.225]:46572 "EHLO
        esa10.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243214AbhK2JLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:11:14 -0500
IronPort-SDR: Hr4SnVGmdzJEi886r8vNFgbRveS4t1JvmT9g+bRn1ICj5WdU/SdM12uZwcGqVO3wJXHGiQTH57
 THbNkqv9/KvyIp+vA0gZ4/lOi2X7n0U3Ag5KwPBNzJLlJG//7DP7tbp9zmpZr0yLET2awec4bR
 sCf5MmbwPrSXKI8p3GHqraaXwKiQTyG4jYP8U8NY+Uky/zCTIUzQ6jXTWVPOBeV4OoRndASE7l
 ItzUq+VifCdAiyLPqYTmCNB9K8MPHfSLbSY4PO57wQC+nnhjZeAakRvQAdWOrl85uMnhhpbWjQ
 NItzhR/8qWNk/N+/iJasIjq7
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="42144787"
X-IronPort-AV: E=Sophos;i="5.87,272,1631545200"; 
   d="scan'208";a="42144787"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 29 Nov 2021 18:07:54 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6038CE0403;
        Mon, 29 Nov 2021 18:07:53 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id AFC5C23AEE;
        Mon, 29 Nov 2021 18:07:52 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id A9F5C404AFF17;
        Mon, 29 Nov 2021 18:07:52 +0900 (JST)
From:   Shunsuke <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH v4 0/3] Unify scaling of counters obtained from perf_evsel__read()
Date:   Mon, 29 Nov 2021 18:06:24 +0900
Message-Id: <20211129090627.592149-1-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series unifies the counters that can be obtained from
perf_evsel__read() to "no scaling".
The counter scaling will be done using a function moved from
tools/perf/util.

The first patch move perf_counts_values__scale from tools/perf/util
to tools/lib/perf so that it can be used with libperf.

The second patch removes the scaling process from
perf_mmap__read_self().

The third patch adds a verification test to make sure that it scales
correctly when multiplexed.

---
Previous version at:
https://lore.kernel.org/linux-perf-users/20211109085831.3770594-1-nakamura.shun@fujitsu.com/


Changes in v4:
 - Modify type s8 to type __s8

Changes in v3:
 - Move scaling process from tools/perf/util to tools/lib/perf
 - Remove scaling process from perf_mmap__read_self()
 - Remove scaling process for perf_mmap__read_self
 - Remove test to verify that no division by zero occurs

Changes in v2:
 - Fix not to divide by zero when counter scaling
 - Add test to verify that no division by zero occurs


[1] https://github.com/deater/perf_event_tests/blob/master/tests/rdpmc/rdpmc_multiplexing.c


Shunsuke Nakamura (3):
  libperf: Move perf_counts_values__scale to tools/lib/perf
  libperf: Remove scaling process from perf_mmap__read_self()
  libperf tests: Add test_stat_multiplexing test

 tools/lib/perf/evsel.c              |  19 ++++
 tools/lib/perf/include/perf/evsel.h |   4 +
 tools/lib/perf/libperf.map          |   1 +
 tools/lib/perf/mmap.c               |   2 -
 tools/lib/perf/tests/test-evlist.c  | 157 ++++++++++++++++++++++++++++
 tools/perf/util/evsel.c             |  19 ----
 tools/perf/util/evsel.h             |   3 -
 7 files changed, 181 insertions(+), 24 deletions(-)

-- 
2.25.1

