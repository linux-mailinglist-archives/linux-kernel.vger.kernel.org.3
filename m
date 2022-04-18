Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B2C504D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 09:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbiDRHnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 03:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiDRHnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 03:43:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E0517E38
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 00:41:01 -0700 (PDT)
Received: from kwepemi100019.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Khf4R05hyzhXY1;
        Mon, 18 Apr 2022 15:40:54 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi100019.china.huawei.com (7.221.188.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 15:40:59 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 15:40:59 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <jolsa@redhat.com>
CC:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] tracing: Reset the function filter after completing trampoline/graph selftest
Date:   Mon, 18 Apr 2022 15:39:58 +0800
Message-ID: <20220418073958.104029-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The direct trampoline and graph coexistence test sets global_ops to
trace only 'trace_selftest_dynamic_test_func', but does not reset it
after the test is completed, resulting in the function filter being set
already after the system starts. Although it can be reset through the
tracefs interface, it is more or less confusing to the user, and we
should reset it to trace all functions after the trampoline/graph test
completes.

Fixes: 130c08065848 ("tracing: Add trampoline/graph selftest")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 kernel/trace/trace_selftest.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index abcadbe933bb..e89f72571f8e 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -866,12 +866,12 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	ret = register_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
 				     (unsigned long) trace_direct_tramp);
 	if (ret)
-		goto out;
+		goto reset_filter;
 
 	ret = register_ftrace_graph(&fgraph_ops);
 	if (ret) {
 		warn_failed_init_tracer(trace, ret);
-		goto out;
+		goto reset_filter;
 	}
 
 	DYN_FTRACE_TEST_NAME();
@@ -887,14 +887,18 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	ret = unregister_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
 				       (unsigned long) trace_direct_tramp);
 	if (ret)
-		goto out;
+		goto reset_filter;
 
 	tracing_start();
 
 	if (!ret && !count) {
 		ret = -1;
-		goto out;
+		goto reset_filter;
 	}
+
+reset_filter:
+	/* Enable tracing on all functions again */
+	ftrace_set_global_filter(NULL, 0, 1);
 #endif
 
 	/* Don't test dynamic tracing, the function tracer already did */
-- 
2.17.1

