Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76495585828
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 05:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239803AbiG3DGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 23:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiG3DGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 23:06:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3FE50064;
        Fri, 29 Jul 2022 20:06:24 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lvq1Z1zN2zWfLT;
        Sat, 30 Jul 2022 11:02:26 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 30 Jul 2022 11:06:22 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 30 Jul 2022 11:06:21 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <colin.i.king@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <pc@us.ibm.com>, <yhs@fb.com>, <andrii.nakryiko@gmail.com>,
        <songliubraving@fb.com>, <yangjihong1@huawei.com>
Subject: [PATCH v2 2/7] perf kwork: Replace hard-coded initialization of nr_tracepoints with ARRAY_SIZE macro
Date:   Sat, 30 Jul 2022 11:03:30 +0800
Message-ID: <20220730030335.78203-3-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20220730030335.78203-1-yangjihong1@huawei.com>
References: <20220730030335.78203-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ARRAY_SIZE macro to replace hard-coded initialization of nr_tracepoints
for future changes.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index ff17711a554a..2143280c2e95 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -817,7 +817,7 @@ static void irq_work_name(struct kwork_work *work, char *buf, int len)
 static struct kwork_class kwork_irq = {
 	.name           = "irq",
 	.type           = KWORK_CLASS_IRQ,
-	.nr_tracepoints = 2,
+	.nr_tracepoints = ARRAY_SIZE(irq_tp_handlers),
 	.tp_handlers    = irq_tp_handlers,
 	.class_init     = irq_class_init,
 	.work_init      = irq_work_init,
@@ -938,7 +938,7 @@ static void softirq_work_name(struct kwork_work *work, char *buf, int len)
 static struct kwork_class kwork_softirq = {
 	.name           = "softirq",
 	.type           = KWORK_CLASS_SOFTIRQ,
-	.nr_tracepoints = 3,
+	.nr_tracepoints = ARRAY_SIZE(softirq_tp_handlers),
 	.tp_handlers    = softirq_tp_handlers,
 	.class_init     = softirq_class_init,
 	.work_init      = softirq_work_init,
@@ -1035,7 +1035,7 @@ static void workqueue_work_name(struct kwork_work *work, char *buf, int len)
 static struct kwork_class kwork_workqueue = {
 	.name           = "workqueue",
 	.type           = KWORK_CLASS_WORKQUEUE,
-	.nr_tracepoints = 3,
+	.nr_tracepoints = ARRAY_SIZE(workqueue_tp_handlers),
 	.tp_handlers    = workqueue_tp_handlers,
 	.class_init     = workqueue_class_init,
 	.work_init      = workqueue_work_init,
-- 
2.30.GIT

