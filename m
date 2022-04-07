Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDD94F7803
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242120AbiDGHsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242360AbiDGHsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:48:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FE9C31F7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:46:22 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KYtjD4l6dzdZjC;
        Thu,  7 Apr 2022 15:45:52 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Apr
 2022 15:46:20 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>, <mcgrof@kernel.org>,
        <xiaowei66@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ftrace: Fix build warning
Date:   Thu, 7 Apr 2022 15:46:12 +0800
Message-ID: <20220407074612.16608-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_SYSCTL and CONFIG_DYNAMIC_FTRACE is n, build warns:

kernel/trace/ftrace.c:7912:13: error: ‘is_permanent_ops_registered’ defined but not used [-Werror=unused-function]
 static bool is_permanent_ops_registered(void)
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/trace/ftrace.c:89:12: error: ‘last_ftrace_enabled’ defined but not used [-Werror=unused-variable]
 static int last_ftrace_enabled;
            ^~~~~~~~~~~~~~~~~~~

Move is_permanent_ops_registered() to ifdef block and mark last_ftrace_enabled as
__maybe_unused to fix this.

Fixes: 7cde53da38a3 ("ftrace: move sysctl_ftrace_enabled to ftrace.c")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/trace/ftrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a5efbbc289b4..db8d553728b6 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -86,7 +86,7 @@ struct ftrace_ops ftrace_list_end __read_mostly = {
 
 /* ftrace_enabled is a method to turn ftrace on or off */
 int ftrace_enabled __read_mostly;
-static int last_ftrace_enabled;
+static int __maybe_unused last_ftrace_enabled;
 
 /* Current function tracing op */
 struct ftrace_ops *function_trace_op __read_mostly = &ftrace_list_end;
@@ -7909,6 +7909,7 @@ int unregister_ftrace_function(struct ftrace_ops *ops)
 }
 EXPORT_SYMBOL_GPL(unregister_ftrace_function);
 
+#ifdef CONFIG_SYSCTL
 static bool is_permanent_ops_registered(void)
 {
 	struct ftrace_ops *op;
@@ -7921,7 +7922,6 @@ static bool is_permanent_ops_registered(void)
 	return false;
 }
 
-#ifdef CONFIG_SYSCTL
 static int
 ftrace_enable_sysctl(struct ctl_table *table, int write,
 		     void *buffer, size_t *lenp, loff_t *ppos)
-- 
2.17.1

