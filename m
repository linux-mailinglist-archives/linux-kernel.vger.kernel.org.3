Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB0454843C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241216AbiFMJtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241095AbiFMJs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:48:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA5418B2E;
        Mon, 13 Jun 2022 02:48:24 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LM6Cz09KxzjXf5;
        Mon, 13 Jun 2022 17:46:55 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:04 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:03 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [RFC 02/13] perf kwork: Add irq record support
Date:   Mon, 13 Jun 2022 17:45:54 +0800
Message-ID: <20220613094605.208401-3-yangjihong1@huawei.com>
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

Record interrupt events irq:irq_handler_entry & irq_handler_exit:

Record irq events:

  # perf kwork record -o perf_kwork.date -- sleep 1
  [ perf record: Woken up 0 times to write data ]
  [ perf record: Captured and wrote 0.524 MB perf_kwork.date ]

  # perf evlist -i perf_kwork.date
  irq:irq_handler_entry
  irq:irq_handler_exit
  dummy:HG

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index b89e41fcc568..822904b2597e 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -25,6 +25,7 @@
 #include <linux/zalloc.h>
 
 enum kwork_class_type {
+	KWORK_CLASS_IRQ,
 	KWORK_CLASS_MAX,
 };
 
@@ -68,7 +69,19 @@ struct perf_kwork {
 	const char *sort_order;
 };
 
+const struct evsel_str_handler irq_tp_handlers[] = {
+	{ "irq:irq_handler_entry", NULL, },
+	{ "irq:irq_handler_exit",  NULL, },
+};
+
+static struct kwork_class kwork_irq = {
+	.name           = "irq",
+	.nr_tracepoints = 2,
+	.tp_handlers    = irq_tp_handlers,
+};
+
 static struct kwork_class *kwork_class_supported_list[KWORK_CLASS_MAX] = {
+	[KWORK_CLASS_IRQ]	= &kwork_irq,
 };
 
 static void setup_event_list(struct perf_kwork *kwork,
-- 
2.30.GIT

