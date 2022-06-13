Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B1F548428
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241296AbiFMJuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241198AbiFMJtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:49:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9449C1AD87;
        Mon, 13 Jun 2022 02:49:21 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LM6F424gNzjXfK;
        Mon, 13 Jun 2022 17:47:52 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:05 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:04 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [RFC 04/13] perf kwork: Add workqueue record support
Date:   Mon, 13 Jun 2022 17:45:56 +0800
Message-ID: <20220613094605.208401-5-yangjihong1@huawei.com>
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

Record workqueue events workqueue:workqueue_activate_work,
workqueue:workqueue_execute_start & workqueue:workqueue_execute_end

Record all events:

  # perf kwork record -o perf_kwork.date -- sleep 1
  [ perf record: Woken up 0 times to write data ]
  [ perf record: Captured and wrote 0.839 MB perf_kwork.date ]

  # perf evlist -i perf_kwork.date
  irq:irq_handler_entry
  irq:irq_handler_exit
  irq:softirq_raise
  irq:softirq_entry
  irq:softirq_exit
  workqueue:workqueue_activate_work
  workqueue:workqueue_execute_start
  workqueue:workqueue_execute_end
  dummy:HG

Record workqueue events:

  # perf kwork -k workqueue record -o perf_kwork.date -- sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.080 MB perf_kwork.date ]

  # perf evlist -i perf_kwork.date
  workqueue:workqueue_activate_work
  workqueue:workqueue_execute_start
  workqueue:workqueue_execute_end
  dummy:HG

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 0da554e04f16..cda6fcbc6e41 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -27,6 +27,7 @@
 enum kwork_class_type {
 	KWORK_CLASS_IRQ,
 	KWORK_CLASS_SOFTIRQ,
+	KWORK_CLASS_WORKQUEUE,
 	KWORK_CLASS_MAX,
 };
 
@@ -93,9 +94,22 @@ static struct kwork_class kwork_softirq = {
 	.tp_handlers    = softirq_tp_handlers,
 };
 
+const struct evsel_str_handler workqueue_tp_handlers[] = {
+	{ "workqueue:workqueue_activate_work", NULL, },
+	{ "workqueue:workqueue_execute_start", NULL, },
+	{ "workqueue:workqueue_execute_end",   NULL, },
+};
+
+static struct kwork_class kwork_workqueue = {
+	.name           = "workqueue",
+	.nr_tracepoints = 3,
+	.tp_handlers    = workqueue_tp_handlers,
+};
+
 static struct kwork_class *kwork_class_supported_list[KWORK_CLASS_MAX] = {
 	[KWORK_CLASS_IRQ]	= &kwork_irq,
 	[KWORK_CLASS_SOFTIRQ]	= &kwork_softirq,
+	[KWORK_CLASS_WORKQUEUE] = &kwork_workqueue,
 };
 
 static void setup_event_list(struct perf_kwork *kwork,
-- 
2.30.GIT

