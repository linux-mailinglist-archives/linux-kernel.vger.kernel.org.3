Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024855811C7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbiGZLSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiGZLSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:18:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C7D30F49
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:18:41 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LsZ9t42VDzgYwF;
        Tue, 26 Jul 2022 19:16:50 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 19:18:39 +0800
Received: from zelda.huawei.com (10.175.103.14) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 19:18:38 +0800
From:   WangJingjin <wangjingjin1@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>, <daniel@iogearbox.net>,
        <song@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <zhengbin13@huawei.com>,
        <gaochao49@huawei.com>, <wangjingjin1@huawei.com>
Subject: [PATCH -next] ftrace: Fix build error whithout CONFIG_MODULES
Date:   Tue, 26 Jul 2022 19:35:38 +0800
Message-ID: <20220726113538.2992790-1-wangjingjin1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.103.14]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build errors on kernel/trace/ftrace.c:
    ‘ops_references_rec’ defined but not used.

Fixes: 53cd885bc5c3 ("ftrace: Allow IPMODIFY and DIRECT ops on the same function")
Signed-off-by: Wang Jingjin <wangjingjin1@huawei.com>
---
 kernel/trace/ftrace.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index bc921a3f7ea8..16d3d3884e17 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1861,8 +1861,6 @@ static void ftrace_hash_rec_enable_modify(struct ftrace_ops *ops,
 	ftrace_hash_rec_update_modify(ops, filter_hash, 1);
 }

-static bool ops_references_ip(struct ftrace_ops *ops, unsigned long ip);
-
 /*
  * Try to update IPMODIFY flag on each ftrace_rec. Return 0 if it is OK
  * or no-needed to update, -EBUSY if it detects a conflict of the flag
@@ -3108,6 +3106,7 @@ static inline int ops_traces_mod(struct ftrace_ops *ops)
 		ftrace_hash_empty(ops->func_hash->notrace_hash);
 }

+#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) || defined(CONFIG_MODULES)
 /*
  * Check if the current ops references the given ip.
  *
@@ -3137,19 +3136,7 @@ ops_references_ip(struct ftrace_ops *ops, unsigned long ip)

 	return true;
 }
-
-/*
- * Check if the current ops references the record.
- *
- * If the ops traces all functions, then it was already accounted for.
- * If the ops does not trace the current record function, skip it.
- * If the ops ignores the function via notrace filter, skip it.
- */
-static bool
-ops_references_rec(struct ftrace_ops *ops, struct dyn_ftrace *rec)
-{
-	return ops_references_ip(ops, rec->ip);
-}
+#endif

 static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 {
@@ -6818,6 +6805,19 @@ static int ftrace_get_trampoline_kallsym(unsigned int symnum,

 static LIST_HEAD(ftrace_mod_maps);

+/*
+ * Check if the current ops references the record.
+ *
+ * If the ops traces all functions, then it was already accounted for.
+ * If the ops does not trace the current record function, skip it.
+ * If the ops ignores the function via notrace filter, skip it.
+ */
+static bool
+ops_references_rec(struct ftrace_ops *ops, struct dyn_ftrace *rec)
+{
+	return ops_references_ip(ops, rec->ip);
+}
+
 static int referenced_filters(struct dyn_ftrace *rec)
 {
 	struct ftrace_ops *ops;
--
2.25.1

