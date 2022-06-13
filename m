Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A8854844D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbiFMJsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240506AbiFMJsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:48:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDB113F05;
        Mon, 13 Jun 2022 02:48:10 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LM6C90FjHzgYrW;
        Mon, 13 Jun 2022 17:46:13 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:08 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:07 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [RFC 11/13] perf kwork: Add softirq latency support
Date:   Mon, 13 Jun 2022 17:46:03 +0800
Message-ID: <20220613094605.208401-12-yangjihong1@huawei.com>
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

Implements softirq latency function.

test case:

  # perf kwork lat

    Kwork Name                | Cpu  | Avg delay     | Frequency | Max delay     | Max delay start     | Max delay end       |
   ---------------------------------------------------------------------------------------------------------------------------
    (s)RCU:9                  | 0006 |      1.338 ms |         1 |      1.338 ms |    2072616.369122 s |    2072616.370461 s |
    (s)RCU:9                  | 0005 |      0.945 ms |         2 |      1.757 ms |    2072616.368262 s |    2072616.370020 s |
    (s)RCU:9                  | 0002 |      0.575 ms |        73 |      1.884 ms |    2072616.423139 s |    2072616.425023 s |
    (s)RCU:9                  | 0000 |      0.327 ms |       105 |      1.365 ms |    2072620.344392 s |    2072620.345757 s |
    (s)RCU:9                  | 0001 |      0.233 ms |       711 |      2.862 ms |    2072620.639022 s |    2072620.641885 s |
    (s)NET_RX:3               | 0002 |      0.219 ms |         5 |      0.762 ms |    2072624.174209 s |    2072624.174971 s |
    (s)RCU:9                  | 0004 |      0.176 ms |         4 |      0.265 ms |    2072620.333206 s |    2072620.333472 s |
    (s)RCU:9                  | 0007 |      0.172 ms |      3165 |      2.890 ms |    2072616.385706 s |    2072616.388595 s |
    (s)TIMER:1                | 0000 |      0.168 ms |        11 |      0.307 ms |    2072620.638399 s |    2072620.638706 s |
    (s)RCU:9                  | 0003 |      0.149 ms |       194 |      1.127 ms |    2072620.617286 s |    2072620.618413 s |
    (s)SCHED:7                | 0002 |      0.136 ms |        12 |      0.384 ms |    2072617.261300 s |    2072617.261684 s |
    (s)BLOCK:4                | 0001 |      0.131 ms |        79 |      2.734 ms |    2072620.639022 s |    2072620.641756 s |
    (s)SCHED:7                | 0000 |      0.127 ms |       360 |      0.989 ms |    2072616.386068 s |    2072616.387057 s |
    (s)BLOCK:4                | 0000 |      0.125 ms |        13 |      0.209 ms |    2072620.354356 s |    2072620.354564 s |
    (s)SCHED:7                | 0004 |      0.121 ms |         3 |      0.172 ms |    2072620.333236 s |    2072620.333408 s |
    (s)SCHED:7                | 0003 |      0.113 ms |        82 |      0.226 ms |    2072618.917223 s |    2072618.917449 s |
    (s)SCHED:7                | 0001 |      0.098 ms |       209 |      0.986 ms |    2072620.392020 s |    2072620.393007 s |
    (s)TIMER:1                | 0007 |      0.095 ms |      1550 |      1.274 ms |    2072625.965379 s |    2072625.966653 s |
    (s)TIMER:1                | 0004 |      0.081 ms |         2 |      0.082 ms |    2072620.333187 s |    2072620.333269 s |
    (s)TIMER:1                | 0002 |      0.076 ms |        10 |      0.104 ms |    2072617.261239 s |    2072617.261344 s |
    (s)TIMER:1                | 0003 |      0.065 ms |       245 |      1.023 ms |    2072620.617286 s |    2072620.618309 s |
    (s)SCHED:7                | 0006 |      0.064 ms |         2 |      0.081 ms |    2072616.370310 s |    2072616.370391 s |
    (s)SCHED:7                | 0007 |      0.062 ms |      2753 |      0.473 ms |    2072621.357987 s |    2072621.358460 s |
    (s)TIMER:1                | 0001 |      0.055 ms |       774 |      0.396 ms |    2072617.523145 s |    2072617.523540 s |
    (s)SCHED:7                | 0005 |      0.040 ms |         2 |      0.042 ms |    2072616.369895 s |    2072616.369937 s |
   ---------------------------------------------------------------------------------------------------------------------------
    INFO: 28.605% skipped events (25424 including 2617 raise, 22807 entry, 0 exit)

  # perf kwork lat -C 0,1

    Kwork Name                | Cpu  | Avg delay     | Frequency | Max delay     | Max delay start     | Max delay end       |
   ---------------------------------------------------------------------------------------------------------------------------
    (s)RCU:9                  | 0000 |      0.327 ms |       105 |      1.365 ms |    2072620.344392 s |    2072620.345757 s |
    (s)RCU:9                  | 0001 |      0.233 ms |       711 |      2.862 ms |    2072620.639022 s |    2072620.641885 s |
    (s)TIMER:1                | 0000 |      0.168 ms |        11 |      0.307 ms |    2072620.638399 s |    2072620.638706 s |
    (s)BLOCK:4                | 0001 |      0.131 ms |        79 |      2.734 ms |    2072620.639022 s |    2072620.641756 s |
    (s)SCHED:7                | 0000 |      0.127 ms |       360 |      0.989 ms |    2072616.386068 s |    2072616.387057 s |
    (s)BLOCK:4                | 0000 |      0.125 ms |        13 |      0.209 ms |    2072620.354356 s |    2072620.354564 s |
    (s)SCHED:7                | 0001 |      0.098 ms |       209 |      0.986 ms |    2072620.392020 s |    2072620.393007 s |
    (s)TIMER:1                | 0001 |      0.055 ms |       774 |      0.396 ms |    2072617.523145 s |    2072617.523540 s |
   ---------------------------------------------------------------------------------------------------------------------------
    INFO: 26.410% skipped events (23473 including 795 raise, 22678 entry, 0 exit)

  # perf kwork lat -n SCHED

    Kwork Name                | Cpu  | Avg delay     | Frequency | Max delay     | Max delay start     | Max delay end       |
   ---------------------------------------------------------------------------------------------------------------------------
    (s)SCHED:7                | 0002 |      0.136 ms |        12 |      0.384 ms |    2072617.261300 s |    2072617.261684 s |
    (s)SCHED:7                | 0000 |      0.127 ms |       360 |      0.989 ms |    2072616.386068 s |    2072616.387057 s |
    (s)SCHED:7                | 0004 |      0.121 ms |         3 |      0.172 ms |    2072620.333236 s |    2072620.333408 s |
    (s)SCHED:7                | 0003 |      0.113 ms |        82 |      0.226 ms |    2072618.917223 s |    2072618.917449 s |
    (s)SCHED:7                | 0001 |      0.098 ms |       209 |      0.986 ms |    2072620.392020 s |    2072620.393007 s |
    (s)SCHED:7                | 0006 |      0.064 ms |         2 |      0.081 ms |    2072616.370310 s |    2072616.370391 s |
    (s)SCHED:7                | 0007 |      0.062 ms |      2753 |      0.473 ms |    2072621.357987 s |    2072621.358460 s |
    (s)SCHED:7                | 0005 |      0.040 ms |         2 |      0.042 ms |    2072616.369895 s |    2072616.369937 s |
   ---------------------------------------------------------------------------------------------------------------------------
    INFO: 0.006% skipped events (5 including 5 raise, 0 entry, 0 exit)

  # perf kwork lat -s freq,max

    Kwork Name                | Cpu  | Avg delay     | Frequency | Max delay     | Max delay start     | Max delay end       |
   ---------------------------------------------------------------------------------------------------------------------------
    (s)RCU:9                  | 0007 |      0.172 ms |      3165 |      2.890 ms |    2072616.385706 s |    2072616.388595 s |
    (s)SCHED:7                | 0007 |      0.062 ms |      2753 |      0.473 ms |    2072621.357987 s |    2072621.358460 s |
    (s)TIMER:1                | 0007 |      0.095 ms |      1550 |      1.274 ms |    2072625.965379 s |    2072625.966653 s |
    (s)TIMER:1                | 0001 |      0.055 ms |       774 |      0.396 ms |    2072617.523145 s |    2072617.523540 s |
    (s)RCU:9                  | 0001 |      0.233 ms |       711 |      2.862 ms |    2072620.639022 s |    2072620.641885 s |
    (s)SCHED:7                | 0000 |      0.127 ms |       360 |      0.989 ms |    2072616.386068 s |    2072616.387057 s |
    (s)TIMER:1                | 0003 |      0.065 ms |       245 |      1.023 ms |    2072620.617286 s |    2072620.618309 s |
    (s)SCHED:7                | 0001 |      0.098 ms |       209 |      0.986 ms |    2072620.392020 s |    2072620.393007 s |
    (s)RCU:9                  | 0003 |      0.149 ms |       194 |      1.127 ms |    2072620.617286 s |    2072620.618413 s |
    (s)RCU:9                  | 0000 |      0.327 ms |       105 |      1.365 ms |    2072620.344392 s |    2072620.345757 s |
    (s)SCHED:7                | 0003 |      0.113 ms |        82 |      0.226 ms |    2072618.917223 s |    2072618.917449 s |
    (s)BLOCK:4                | 0001 |      0.131 ms |        79 |      2.734 ms |    2072620.639022 s |    2072620.641756 s |
    (s)RCU:9                  | 0002 |      0.575 ms |        73 |      1.884 ms |    2072616.423139 s |    2072616.425023 s |
    (s)BLOCK:4                | 0000 |      0.125 ms |        13 |      0.209 ms |    2072620.354356 s |    2072620.354564 s |
    (s)SCHED:7                | 0002 |      0.136 ms |        12 |      0.384 ms |    2072617.261300 s |    2072617.261684 s |
    (s)TIMER:1                | 0000 |      0.168 ms |        11 |      0.307 ms |    2072620.638399 s |    2072620.638706 s |
    (s)TIMER:1                | 0002 |      0.076 ms |        10 |      0.104 ms |    2072617.261239 s |    2072617.261344 s |
    (s)NET_RX:3               | 0002 |      0.219 ms |         5 |      0.762 ms |    2072624.174209 s |    2072624.174971 s |
    (s)RCU:9                  | 0004 |      0.176 ms |         4 |      0.265 ms |    2072620.333206 s |    2072620.333472 s |
    (s)SCHED:7                | 0004 |      0.121 ms |         3 |      0.172 ms |    2072620.333236 s |    2072620.333408 s |
    (s)RCU:9                  | 0005 |      0.945 ms |         2 |      1.757 ms |    2072616.368262 s |    2072616.370020 s |
    (s)TIMER:1                | 0004 |      0.081 ms |         2 |      0.082 ms |    2072620.333187 s |    2072620.333269 s |
    (s)SCHED:7                | 0006 |      0.064 ms |         2 |      0.081 ms |    2072616.370310 s |    2072616.370391 s |
    (s)SCHED:7                | 0005 |      0.040 ms |         2 |      0.042 ms |    2072616.369895 s |    2072616.369937 s |
    (s)RCU:9                  | 0006 |      1.338 ms |         1 |      1.338 ms |    2072616.369122 s |    2072616.370461 s |
   ---------------------------------------------------------------------------------------------------------------------------
    INFO: 28.605% skipped events (25424 including 2617 raise, 22807 entry, 0 exit)

  # perf kwork lat --time 2072620.333236,

    Kwork Name                | Cpu  | Avg delay     | Frequency | Max delay     | Max delay start     | Max delay end       |
   ---------------------------------------------------------------------------------------------------------------------------
    (s)RCU:9                  | 0001 |      0.699 ms |       130 |      2.862 ms |    2072620.639022 s |    2072620.641885 s |
    (s)RCU:9                  | 0000 |      0.320 ms |        70 |      1.365 ms |    2072620.344392 s |    2072620.345757 s |
    (s)NET_RX:3               | 0002 |      0.298 ms |         3 |      0.762 ms |    2072624.174209 s |    2072624.174971 s |
    (s)RCU:9                  | 0002 |      0.297 ms |        13 |      0.687 ms |    2072622.126201 s |    2072622.126888 s |
    (s)RCU:9                  | 0003 |      0.271 ms |        17 |      1.127 ms |    2072620.617286 s |    2072620.618413 s |
    (s)TIMER:1                | 0000 |      0.166 ms |         8 |      0.307 ms |    2072620.638399 s |    2072620.638706 s |
    (s)RCU:9                  | 0004 |      0.146 ms |         3 |      0.253 ms |    2072621.357331 s |    2072621.357584 s |
    (s)SCHED:7                | 0003 |      0.143 ms |        15 |      0.197 ms |    2072625.973321 s |    2072625.973519 s |
    (s)TIMER:1                | 0003 |      0.137 ms |        16 |      1.023 ms |    2072620.617286 s |    2072620.618309 s |
    (s)RCU:9                  | 0005 |      0.133 ms |         1 |      0.133 ms |    2072626.530482 s |    2072626.530615 s |
    (s)BLOCK:4                | 0001 |      0.131 ms |        79 |      2.734 ms |    2072620.639022 s |    2072620.641756 s |
    (s)BLOCK:4                | 0000 |      0.125 ms |        13 |      0.209 ms |    2072620.354356 s |    2072620.354564 s |
    (s)SCHED:7                | 0001 |      0.121 ms |        15 |      0.986 ms |    2072620.392020 s |    2072620.393007 s |
    (s)SCHED:7                | 0004 |      0.121 ms |         3 |      0.172 ms |    2072620.333236 s |    2072620.333408 s |
    (s)SCHED:7                | 0000 |      0.115 ms |       269 |      0.987 ms |    2072624.176905 s |    2072624.177892 s |
    (s)SCHED:7                | 0002 |      0.109 ms |         7 |      0.140 ms |    2072625.966227 s |    2072625.966368 s |
    (s)RCU:9                  | 0007 |      0.095 ms |      1526 |      1.333 ms |    2072620.616224 s |    2072620.617557 s |
    (s)TIMER:1                | 0007 |      0.094 ms |      1546 |      1.274 ms |    2072625.965379 s |    2072625.966653 s |
    (s)TIMER:1                | 0004 |      0.079 ms |         1 |      0.079 ms |    2072621.357313 s |    2072621.357393 s |
    (s)TIMER:1                | 0002 |      0.072 ms |         7 |      0.082 ms |    2072620.845190 s |    2072620.845272 s |
    (s)TIMER:1                | 0001 |      0.070 ms |         9 |      0.149 ms |    2072620.360584 s |    2072620.360734 s |
    (s)SCHED:7                | 0007 |      0.068 ms |      1959 |      0.473 ms |    2072621.357987 s |    2072621.358460 s |
    (s)SCHED:7                | 0005 |      0.038 ms |         1 |      0.038 ms |    2072626.530536 s |    2072626.530573 s |
   ---------------------------------------------------------------------------------------------------------------------------
    INFO: 17.800% skipped events (15821 including 1602 raise, 14219 entry, 0 exit)

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 84e318eea832..e0ffd3291b3a 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -816,6 +816,20 @@ static struct kwork_class kwork_irq = {
 };
 
 static struct kwork_class kwork_softirq;
+static int process_softirq_raise_event(struct perf_tool *tool,
+				       struct evsel *evsel,
+				       struct perf_sample *sample,
+				       struct machine *machine)
+{
+	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
+
+	if (kwork->tp_handler->raise_event)
+		return kwork->tp_handler->raise_event(kwork, &kwork_softirq,
+						      evsel, sample, machine);
+
+	return 0;
+}
+
 static int process_softirq_entry_event(struct perf_tool *tool,
 				       struct evsel *evsel,
 				       struct perf_sample *sample,
@@ -845,7 +859,7 @@ static int process_softirq_exit_event(struct perf_tool *tool,
 }
 
 const struct evsel_str_handler softirq_tp_handlers[] = {
-	{ "irq:softirq_raise", NULL, },
+	{ "irq:softirq_raise", process_softirq_raise_event, },
 	{ "irq:softirq_entry", process_softirq_entry_event, },
 	{ "irq:softirq_exit",  process_softirq_exit_event, },
 };
-- 
2.30.GIT

