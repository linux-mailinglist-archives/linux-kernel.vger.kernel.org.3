Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4915D46F864
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbhLJBZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:25:19 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:28297 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhLJBZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:25:18 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J9Cm92FczzbklW;
        Fri, 10 Dec 2021 09:21:29 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 09:21:43 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <miguel.ojeda.sandonis@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <wangweiyang2@huawei.com>
Subject: [PATCH -next] trace.h: Use memset_startat helper in trace_iterator_reset
Date:   Fri, 10 Dec 2021 09:22:45 +0800
Message-ID: <20211210012245.207489-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of memset_startat helper to simplify the code, there should be
no functional change as a result of this patch.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/trace/trace.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 38715aa6cfdf..cde9c0710317 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1926,14 +1926,7 @@ extern struct trace_iterator *tracepoint_print_iter;
  */
 static __always_inline void trace_iterator_reset(struct trace_iterator *iter)
 {
-	const size_t offset = offsetof(struct trace_iterator, seq);
-
-	/*
-	 * Keep gcc from complaining about overwriting more than just one
-	 * member in the structure.
-	 */
-	memset((char *)iter + offset, 0, sizeof(struct trace_iterator) - offset);
-
+	memset_startat(iter, 0, seq);
 	iter->pos = -1;
 }
 
-- 
2.17.1

