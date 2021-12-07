Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38D646B5B8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhLGI2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:28:38 -0500
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137]:56389 "EHLO
        esa11.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232533AbhLGI2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:28:35 -0500
IronPort-SDR: V1PkT6XcDhfvFp+cnqx4vFGxqJbbyvRZupBiOohqtiYc4hyZ9evHMbH85I9d34d8L2L6OGQa1b
 2e/jv+w+jQMkRUEPMmeGNfQaewz4TW9CFPR6MU9op/AqZrq1SGJ6nU8yRazkKKtZdtv/8+6DRi
 Lms17icV1OGcCLa+PGMvXo0ssRXs0jjtQoZfPfNx6ki2VQvYH/n4fp7odmGLku70nAbwuqMMy5
 GVLKf8++vRPe4nCAeemSiy0ewoEHg8eShae7vLQwAmjtYacrDm8IB+Gy1NuH/NTF31ODBTuVB1
 QfzsWV163z52akhTQbLpdmAs
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="35077438"
X-IronPort-AV: E=Sophos;i="5.87,293,1631545200"; 
   d="scan'208";a="35077438"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 07 Dec 2021 17:25:02 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 421C61FA823;
        Tue,  7 Dec 2021 17:25:02 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 19C7DFF2B;
        Tue,  7 Dec 2021 17:25:01 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id 03EA24007AF2B;
        Tue,  7 Dec 2021 17:25:01 +0900 (JST)
From:   Shunsuke <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH v5 0/3] libperf: Unify scaling of counters obtained from perf_evsel__read()
Date:   Tue,  7 Dec 2021 17:22:42 +0900
Message-Id: <20211207082245.604654-1-nakamura.shun@fujitsu.com>
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
https://lore.kernel.org/linux-perf-users/20211129090627.592149-1-nakamura.shun@fujitsu.com/

Changes in v5:
 - Update tools/lib/perf/Documentation/libperf.txt

Changes in v4:
 - Modify type s8 to type __s8

Changes in v3:
 - Move scaling process from tools/perf/util to tools/lib/perf
 - Remove scaling process from perf_mmap__read_self()
 - Remove test to verify that no division by zero occurs

Changes in v2:
 - Fix not to divide by zero when counter scaling
 - Add test to verify that no division by zero occurs


[1] https://github.com/deater/perf_event_tests/blob/master/tests/rdpmc/rdpmc_multiplexing.c


Shunsuke Nakamura (3):
  libperf: Move perf_counts_values__scale to tools/lib/perf
  libperf: Remove scaling process from perf_mmap__read_self()
  libperf tests: Add test_stat_multiplexing test

 tools/lib/perf/Documentation/libperf.txt |   2 +
 tools/lib/perf/evsel.c                   |  19 +++
 tools/lib/perf/include/perf/evsel.h      |   4 +
 tools/lib/perf/libperf.map               |   1 +
 tools/lib/perf/mmap.c                    |   2 -
 tools/lib/perf/tests/test-evlist.c       | 157 +++++++++++++++++++++++
 tools/perf/util/evsel.c                  |  19 ---
 tools/perf/util/evsel.h                  |   3 -
 8 files changed, 183 insertions(+), 24 deletions(-)

-- 
2.25.1

