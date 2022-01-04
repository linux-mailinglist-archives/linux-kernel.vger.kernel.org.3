Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988C6483F53
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 10:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiADJm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 04:42:59 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17321 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiADJmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 04:42:54 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JSnh00ND1z9s1Z;
        Tue,  4 Jan 2022 17:41:52 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 17:42:53 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500015.china.huawei.com
 (7.185.36.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 4 Jan
 2022 17:42:52 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
To:     <rostedt@goodmis.org>
CC:     <xiexiuqi@huawei.com>, <cj.chengjian@huawei.com>,
        <liwei391@huawei.com>, <bristot@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] tracing/osnoise: Fix sparse warning in function start_kthread
Date:   Tue, 4 Jan 2022 17:48:29 +0800
Message-ID: <20220104094829.334872-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change main to main_func to fix following sparse warning:

kernel/trace/trace_osnoise.c: In function ‘start_kthread’:
kernel/trace/trace_osnoise.c:1674:8: warning: ‘main’ is usually a function [-Wmain]
  void *main = osnoise_main;
        ^~~~

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 kernel/trace/trace_osnoise.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 7520d43aed55..2bebf31d4baf 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1691,17 +1691,17 @@ static void stop_per_cpu_kthreads(void)
 static int start_kthread(unsigned int cpu)
 {
 	struct task_struct *kthread;
-	void *main = osnoise_main;
+	void *main_func = osnoise_main;
 	char comm[24];
 
 	if (timerlat_enabled()) {
 		snprintf(comm, 24, "timerlat/%d", cpu);
-		main = timerlat_main;
+		main_func = timerlat_main;
 	} else {
 		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
 
-	kthread = kthread_create_on_cpu(main, NULL, cpu, comm);
+	kthread = kthread_create_on_cpu(main_func, NULL, cpu, comm);
 
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
-- 
2.25.1

