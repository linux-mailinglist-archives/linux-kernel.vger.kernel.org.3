Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB7258582F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 05:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239861AbiG3DGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 23:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbiG3DG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 23:06:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F4D50064;
        Fri, 29 Jul 2022 20:06:26 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lvq400Yv2zmVBT;
        Sat, 30 Jul 2022 11:04:32 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 30 Jul 2022 11:06:24 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 30 Jul 2022 11:06:23 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <colin.i.king@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <pc@us.ibm.com>, <yhs@fb.com>, <andrii.nakryiko@gmail.com>,
        <songliubraving@fb.com>, <yangjihong1@huawei.com>
Subject: [PATCH v2 5/7] perf kwork: Strdup function name in workqueue_work_init
Date:   Sat, 30 Jul 2022 11:03:33 +0800
Message-ID: <20220730030335.78203-6-yangjihong1@huawei.com>
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

perf_session has been deleted when report, maps data in session has been free,
we need to copy duplicate of workqueue function symbol for future use.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index d6c09044a929..33bcab2aafcd 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -1021,7 +1021,7 @@ static void workqueue_work_init(struct kwork_class *class,
 	work->cpu = sample->cpu;
 	work->id = evsel__intval(evsel, sample, "work");
 	work->name = function_addr == 0 ? NULL :
-		machine__resolve_kernel_addr(machine, &function_addr, &modp);
+		strdup(machine__resolve_kernel_addr(machine, &function_addr, &modp));
 }
 
 static void workqueue_work_name(struct kwork_work *work, char *buf, int len)
-- 
2.30.GIT

