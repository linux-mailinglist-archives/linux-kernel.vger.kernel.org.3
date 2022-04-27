Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C04510FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 05:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357566AbiD0Dpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 23:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242616AbiD0Dpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 23:45:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241FD90CF6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:42:30 -0700 (PDT)
Received: from kwepemi100022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kp4L61hnhzfb7Z;
        Wed, 27 Apr 2022 11:41:34 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi100022.china.huawei.com (7.221.188.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 11:42:28 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 11:42:27 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <jolsa@redhat.com>,
        <linux-kernel@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH v2] tracing: Reset the function filter after completing trampoline/graph selftest
Date:   Wed, 27 Apr 2022 11:41:19 +0800
Message-ID: <20220427034119.24668-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 kernel/trace/trace_selftest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index abcadbe933bb..a2d301f58ced 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -895,6 +895,9 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 		ret = -1;
 		goto out;
 	}
+
+	/* Enable tracing on all functions again */
+	ftrace_set_global_filter(NULL, 0, 1);
 #endif
 
 	/* Don't test dynamic tracing, the function tracer already did */
-- 
2.17.1

