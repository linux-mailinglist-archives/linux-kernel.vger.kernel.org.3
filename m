Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174CA58665F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiHAIbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiHAIbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:31:01 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C75F1FCDB
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:30:59 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LxBBD4WJxzGpJ8;
        Mon,  1 Aug 2022 16:29:40 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 1 Aug 2022 16:30:56 +0800
Received: from zelda.huawei.com (10.175.103.14) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 1 Aug 2022 16:30:55 +0800
From:   Wang Jingjin <wangjingjin1@huawei.com>
To:     <rostedt@goodmis.org>
CC:     <daniel@iogearbox.net>, <gaochao49@huawei.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <song@kernel.org>, <wangjingjin1@huawei.com>,
        <zhengbin13@huawei.com>, <cj.chengjian@huawei.com>
Subject: [PATCH v2 -next] ftrace: Fix build error whithout CONFIG_MODULES
Date:   Mon, 1 Aug 2022 16:47:45 +0800
Message-ID: <20220801084745.1187987-1-wangjingjin1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220726113538.2992790-1-wangjingjin1@huawei.com>
References: <20220726113538.2992790-1-wangjingjin1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.103.14]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
v2:
- delete function - ops_references_rec
- move function - ops_references_ip above the "#ifdef CONFIG_MODULES"
 kernel/trace/ftrace.c | 79 ++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 46 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index bc921a3f7ea8..aa5e29e40da8 100644
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
@@ -3108,49 +3106,6 @@ static inline int ops_traces_mod(struct ftrace_ops *ops)
 		ftrace_hash_empty(ops->func_hash->notrace_hash);
 }

-/*
- * Check if the current ops references the given ip.
- *
- * If the ops traces all functions, then it was already accounted for.
- * If the ops does not trace the current record function, skip it.
- * If the ops ignores the function via notrace filter, skip it.
- */
-static bool
-ops_references_ip(struct ftrace_ops *ops, unsigned long ip)
-{
-	/* If ops isn't enabled, ignore it */
-	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
-		return false;
-
-	/* If ops traces all then it includes this function */
-	if (ops_traces_mod(ops))
-		return true;
-
-	/* The function must be in the filter */
-	if (!ftrace_hash_empty(ops->func_hash->filter_hash) &&
-	    !__ftrace_lookup_ip(ops->func_hash->filter_hash, ip))
-		return false;
-
-	/* If in notrace hash, we ignore it too */
-	if (ftrace_lookup_ip(ops->func_hash->notrace_hash, ip))
-		return false;
-
-	return true;
-}
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
-
 static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 {
 	bool init_nop = ftrace_need_init_nop();
@@ -6812,6 +6767,38 @@ static int ftrace_get_trampoline_kallsym(unsigned int symnum,
 	return -ERANGE;
 }

+#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) || defined(CONFIG_MODULES)
+/*
+ * Check if the current ops references the given ip.
+ *
+ * If the ops traces all functions, then it was already accounted for.
+ * If the ops does not trace the current record function, skip it.
+ * If the ops ignores the function via notrace filter, skip it.
+ */
+static bool
+ops_references_ip(struct ftrace_ops *ops, unsigned long ip)
+{
+	/* If ops isn't enabled, ignore it */
+	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
+		return false;
+
+	/* If ops traces all then it includes this function */
+	if (ops_traces_mod(ops))
+		return true;
+
+	/* The function must be in the filter */
+	if (!ftrace_hash_empty(ops->func_hash->filter_hash) &&
+	    !__ftrace_lookup_ip(ops->func_hash->filter_hash, ip))
+		return false;
+
+	/* If in notrace hash, we ignore it too */
+	if (ftrace_lookup_ip(ops->func_hash->notrace_hash, ip))
+		return false;
+
+	return true;
+}
+#endif
+
 #ifdef CONFIG_MODULES

 #define next_to_ftrace_page(p) container_of(p, struct ftrace_page, next)
@@ -6824,7 +6811,7 @@ static int referenced_filters(struct dyn_ftrace *rec)
 	int cnt = 0;

 	for (ops = ftrace_ops_list; ops != &ftrace_list_end; ops = ops->next) {
-		if (ops_references_rec(ops, rec)) {
+		if (ops_references_ip(ops, rec->ip)) {
 			if (WARN_ON_ONCE(ops->flags & FTRACE_OPS_FL_DIRECT))
 				continue;
 			if (WARN_ON_ONCE(ops->flags & FTRACE_OPS_FL_IPMODIFY))
--
2.25.1

