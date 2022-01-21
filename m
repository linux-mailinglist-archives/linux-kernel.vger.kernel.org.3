Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED7C495A25
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378796AbiAUGzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:55:03 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35854 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378777AbiAUGzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:55:01 -0500
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jg98j2gp3zccgv;
        Fri, 21 Jan 2022 14:54:13 +0800 (CST)
Received: from localhost.localdomain (10.175.103.91) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 21 Jan 2022 14:54:58 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <guohanjun@huawei.com>, <jinyao5@huawei.com>
Subject: [PATCH] perf script: Fix printing 'phys_addr' failure issue
Date:   Fri, 21 Jan 2022 14:59:54 +0800
Message-ID: <20220121065954.2121900-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yao Jin <jinyao5@huawei.com>

Perf script was failed to print the phys_addr for SPE profiling.
One 'dummy' event is added by SPE profiling but it doesn't have PHYS_ADDR
attribute set, perf script then exits with error.

Now referring to 'addr', use evsel__do_check_stype() to check the type.

Before:

  # perf record -e arm_spe_0/branch_filter=0,ts_enable=1,pa_enable=1,load_filter=1,jitter=0,\
		store_filter=0,min_latency=0,event_filter=2/ -p 4064384 -- sleep 3
  # perf script -F pid,tid,addr,phys_addr
  Samples for 'dummy:u' event do not have PHYS_ADDR attribute set. Cannot print 'phys_addr' field.

After:

  # perf record -e arm_spe_0/branch_filter=0,ts_enable=1,pa_enable=1,load_filter=1,jitter=0,\
		store_filter=0,min_latency=0,event_filter=2/ -p 4064384 -- sleep 3
  # perf script -F pid,tid,addr,phys_addr
  4064384/4064384 ffff802f921be0d0      2f921be0d0
  4064384/4064384 ffff802f921be0d0      2f921be0d0

Signed-off-by: Yao Jin <jinyao5@huawei.com>
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ecd4f99a6c14..abae8184e171 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -515,7 +515,7 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 		return -EINVAL;
 
 	if (PRINT_FIELD(PHYS_ADDR) &&
-	    evsel__check_stype(evsel, PERF_SAMPLE_PHYS_ADDR, "PHYS_ADDR", PERF_OUTPUT_PHYS_ADDR))
+	    evsel__do_check_stype(evsel, PERF_SAMPLE_PHYS_ADDR, "PHYS_ADDR", PERF_OUTPUT_PHYS_ADDR, allow_user_set))
 		return -EINVAL;
 
 	if (PRINT_FIELD(DATA_PAGE_SIZE) &&
-- 
2.25.1

