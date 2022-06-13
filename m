Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820455483D5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241265AbiFMJtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241089AbiFMJs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:48:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8799618B2C;
        Mon, 13 Jun 2022 02:48:24 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LM6Cz1M2dzjXfR;
        Mon, 13 Jun 2022 17:46:55 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:08 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:08 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [RFC 12/13] perf kwork: Add workqueue latency support
Date:   Mon, 13 Jun 2022 17:46:04 +0800
Message-ID: <20220613094605.208401-13-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20220613094605.208401-1-yangjihong1@huawei.com>
References: <20220613094605.208401-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implements workqueue latency function.

test case:

  # perf kwork -k workqueue lat

    Kwork Name                | Cpu  | Avg delay     | Frequency | Max delay     | Max delay start     | Max delay end       |
   ---------------------------------------------------------------------------------------------------------------------------
    (w)0xffff888101c5cc00     | 0001 |   5120.387 ms |         1 |   5120.387 ms |    2072619.309237 s |    2072624.429624 s |
    (w)0xffff8883333e9040     | 0002 |      2.331 ms |         1 |      2.331 ms |    2072618.029512 s |    2072618.031844 s |
    (w)0xffff888332fe9040     | 0000 |      0.724 ms |         5 |      1.628 ms |    2072620.638985 s |    2072620.640613 s |
    (w)0xffff8883333ea180     | 0002 |      0.675 ms |         6 |      2.007 ms |    2072624.174209 s |    2072624.176216 s |
    (w)0xffff888102e44400     | 0001 |      0.400 ms |         1 |      0.400 ms |    2072625.965284 s |    2072625.965684 s |
    (w)0xffffffff82f7da00     | 0000 |      0.392 ms |         7 |      0.822 ms |    2072621.627843 s |    2072621.628665 s |
    (w)0xffff8881035a83d8     | 0000 |      0.352 ms |         3 |      0.827 ms |    2072620.650451 s |    2072620.651278 s |
    (w)0xffff888100e65c80     | 0001 |      0.318 ms |        78 |      1.228 ms |    2072620.504051 s |    2072620.505279 s |
    (w)0xffff8881035a81e8     | 0004 |      0.285 ms |         1 |      0.285 ms |    2072621.357437 s |    2072621.357722 s |
    (w)0xffff888102fc14a0     | 0002 |      0.279 ms |         5 |      0.319 ms |    2072618.029425 s |    2072618.029744 s |
    (w)0xffff8883335e9040     | 0003 |      0.271 ms |         2 |      0.293 ms |    2072618.917354 s |    2072618.917647 s |
    (w)0xffffffff8305ca48     | 0003 |      0.268 ms |         2 |      0.292 ms |    2072618.917407 s |    2072618.917699 s |
    (w)0xffffffff8305c990     | 0003 |      0.256 ms |         1 |      0.256 ms |    2072625.973445 s |    2072625.973701 s |
    (w)0xffff888102e444b8     | 0001 |      0.254 ms |         1 |      0.254 ms |    2072626.173289 s |    2072626.173542 s |
    (w)0xffff888332fea180     | 0000 |      0.252 ms |       346 |      2.237 ms |    2072620.339623 s |    2072620.341860 s |
    (w)0xffff8883331e9040     | 0001 |      0.226 ms |         2 |      0.234 ms |    2072625.965354 s |    2072625.965588 s |
    (w)0xffff888100e65c80     | 0000 |      0.217 ms |        10 |      0.705 ms |    2072620.339040 s |    2072620.339745 s |
    (w)0xffff888333de9040     | 0007 |      0.179 ms |         8 |      0.374 ms |    2072619.565271 s |    2072619.565645 s |
   ---------------------------------------------------------------------------------------------------------------------------
    INFO: 0.024% skipped events (21 including 11 raise, 10 entry, 0 exit)

  # perf kwork -k workqueue lat -s freq,avg

    Kwork Name                | Cpu  | Avg delay     | Frequency | Max delay     | Max delay start     | Max delay end       |
   ---------------------------------------------------------------------------------------------------------------------------
    (w)0xffff888332fea180     | 0000 |      0.252 ms |       346 |      2.237 ms |    2072620.339623 s |    2072620.341860 s |
    (w)0xffff888100e65c80     | 0001 |      0.318 ms |        78 |      1.228 ms |    2072620.504051 s |    2072620.505279 s |
    (w)0xffff888100e65c80     | 0000 |      0.217 ms |        10 |      0.705 ms |    2072620.339040 s |    2072620.339745 s |
    (w)0xffff888333de9040     | 0007 |      0.179 ms |         8 |      0.374 ms |    2072619.565271 s |    2072619.565645 s |
    (w)0xffffffff82f7da00     | 0000 |      0.392 ms |         7 |      0.822 ms |    2072621.627843 s |    2072621.628665 s |
    (w)0xffff8883333ea180     | 0002 |      0.675 ms |         6 |      2.007 ms |    2072624.174209 s |    2072624.176216 s |
    (w)0xffff888332fe9040     | 0000 |      0.724 ms |         5 |      1.628 ms |    2072620.638985 s |    2072620.640613 s |
    (w)0xffff888102fc14a0     | 0002 |      0.279 ms |         5 |      0.319 ms |    2072618.029425 s |    2072618.029744 s |
    (w)0xffff8881035a83d8     | 0000 |      0.352 ms |         3 |      0.827 ms |    2072620.650451 s |    2072620.651278 s |
    (w)0xffff8883335e9040     | 0003 |      0.271 ms |         2 |      0.293 ms |    2072618.917354 s |    2072618.917647 s |
    (w)0xffffffff8305ca48     | 0003 |      0.268 ms |         2 |      0.292 ms |    2072618.917407 s |    2072618.917699 s |
    (w)0xffff8883331e9040     | 0001 |      0.226 ms |         2 |      0.234 ms |    2072625.965354 s |    2072625.965588 s |
    (w)0xffff888101c5cc00     | 0001 |   5120.387 ms |         1 |   5120.387 ms |    2072619.309237 s |    2072624.429624 s |
    (w)0xffff8883333e9040     | 0002 |      2.331 ms |         1 |      2.331 ms |    2072618.029512 s |    2072618.031844 s |
    (w)0xffff888102e44400     | 0001 |      0.400 ms |         1 |      0.400 ms |    2072625.965284 s |    2072625.965684 s |
    (w)0xffff8881035a81e8     | 0004 |      0.285 ms |         1 |      0.285 ms |    2072621.357437 s |    2072621.357722 s |
    (w)0xffffffff8305c990     | 0003 |      0.256 ms |         1 |      0.256 ms |    2072625.973445 s |    2072625.973701 s |
    (w)0xffff888102e444b8     | 0001 |      0.254 ms |         1 |      0.254 ms |    2072626.173289 s |    2072626.173542 s |
   ---------------------------------------------------------------------------------------------------------------------------
    INFO: 0.024% skipped events (21 including 11 raise, 10 entry, 0 exit)

  # perf kwork -k workqueue lat -C 1

    Kwork Name                | Cpu  | Avg delay     | Frequency | Max delay     | Max delay start     | Max delay end       |
   ---------------------------------------------------------------------------------------------------------------------------
    (w)0xffff888101c5cc00     | 0001 |   5120.387 ms |         1 |   5120.387 ms |    2072619.309237 s |    2072624.429624 s |
    (w)0xffff888102e44400     | 0001 |      0.400 ms |         1 |      0.400 ms |    2072625.965284 s |    2072625.965684 s |
    (w)0xffff888100e65c80     | 0001 |      0.318 ms |        78 |      1.228 ms |    2072620.504051 s |    2072620.505279 s |
    (w)0xffff888102e444b8     | 0001 |      0.254 ms |         1 |      0.254 ms |    2072626.173289 s |    2072626.173542 s |
    (w)0xffff8883331e9040     | 0001 |      0.226 ms |         2 |      0.234 ms |    2072625.965354 s |    2072625.965588 s |
   ---------------------------------------------------------------------------------------------------------------------------
    INFO: 0.006% skipped events (5 including 3 raise, 2 entry, 0 exit)

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index e0ffd3291b3a..7e3da243ccd8 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -935,6 +935,20 @@ static struct kwork_class kwork_softirq = {
 };
 
 static struct kwork_class kwork_workqueue;
+static int process_workqueue_activate_work_event(struct perf_tool *tool,
+						 struct evsel *evsel,
+						 struct perf_sample *sample,
+						 struct machine *machine)
+{
+	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
+
+	if (kwork->tp_handler->raise_event)
+		return kwork->tp_handler->raise_event(kwork, &kwork_workqueue,
+						    evsel, sample, machine);
+
+	return 0;
+}
+
 static int process_workqueue_execute_start_event(struct perf_tool *tool,
 						 struct evsel *evsel,
 						 struct perf_sample *sample,
@@ -964,7 +978,7 @@ static int process_workqueue_execute_end_event(struct perf_tool *tool,
 }
 
 const struct evsel_str_handler workqueue_tp_handlers[] = {
-	{ "workqueue:workqueue_activate_work", NULL, },
+	{ "workqueue:workqueue_activate_work", process_workqueue_activate_work_event, },
 	{ "workqueue:workqueue_execute_start", process_workqueue_execute_start_event, },
 	{ "workqueue:workqueue_execute_end",   process_workqueue_execute_end_event, },
 };
-- 
2.30.GIT

