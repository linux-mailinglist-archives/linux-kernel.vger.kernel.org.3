Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F1B596A98
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbiHQHpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbiHQHpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:45:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B54D79A55
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:45:31 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M70NK59XJzcffs;
        Wed, 17 Aug 2022 15:42:25 +0800 (CST)
Received: from CHINA (10.175.102.38) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 17 Aug
 2022 15:45:28 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4 -next] fault-injection: make some stack filter attrs more readable
Date:   Wed, 17 Aug 2022 08:03:31 +0000
Message-ID: <20220817080332.1052710-4-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817080332.1052710-1-weiyongjun1@huawei.com>
References: <20220817080332.1052710-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attributes of stack filter are show as unsigned decimal, such
as 'require-start', 'require-end'. This patch change to
show them as unsigned hexadecimal for more readable.

Before:
  $ echo 0xffffffffc0257000 > /sys/kernel/debug/failslab/require-start
  $ cat /sys/kernel/debug/failslab/require-start
  18446744072638263296

After:
  $ echo 0xffffffffc0257000 > /sys/kernel/debug/failslab/require-start
  $ cat /sys/kernel/debug/failslab/require-start
  0xffffffffc0257000

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 lib/fault-inject.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index 515fc5aaf032..deca05e7c9b3 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -179,6 +179,14 @@ static void debugfs_create_ul(const char *name, umode_t mode,
 
 #ifdef CONFIG_FAULT_INJECTION_STACKTRACE_FILTER
 
+DEFINE_SIMPLE_ATTRIBUTE(fops_xl, debugfs_ul_get, debugfs_ul_set, "0x%llx\n");
+
+static void debugfs_create_xl(const char *name, umode_t mode,
+			      struct dentry *parent, unsigned long *value)
+{
+	debugfs_create_file(name, mode, parent, value, &fops_xl);
+}
+
 static int debugfs_stacktrace_depth_set(void *data, u64 val)
 {
 	*(unsigned long *)data =
@@ -223,10 +231,10 @@ struct dentry *fault_create_debugfs_attr(const char *name,
 #ifdef CONFIG_FAULT_INJECTION_STACKTRACE_FILTER
 	debugfs_create_stacktrace_depth("stacktrace-depth", mode, dir,
 					&attr->stacktrace_depth);
-	debugfs_create_ul("require-start", mode, dir, &attr->require_start);
-	debugfs_create_ul("require-end", mode, dir, &attr->require_end);
-	debugfs_create_ul("reject-start", mode, dir, &attr->reject_start);
-	debugfs_create_ul("reject-end", mode, dir, &attr->reject_end);
+	debugfs_create_xl("require-start", mode, dir, &attr->require_start);
+	debugfs_create_xl("require-end", mode, dir, &attr->require_end);
+	debugfs_create_xl("reject-start", mode, dir, &attr->reject_start);
+	debugfs_create_xl("reject-end", mode, dir, &attr->reject_end);
 #endif /* CONFIG_FAULT_INJECTION_STACKTRACE_FILTER */
 
 	attr->dname = dget(dir);
-- 
2.34.1

