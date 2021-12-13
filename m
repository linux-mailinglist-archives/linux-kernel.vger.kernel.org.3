Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE67F472D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbhLMN16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:27:58 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29188 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhLMN1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:27:55 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JCMhP43nxz972c;
        Mon, 13 Dec 2021 21:25:41 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 21:27:52 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
        <longman@redhat.com>, <boqun.feng@gmail.com>
CC:     <wangweiyang2@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <keescook@chromium.org>
Subject: [PATCH -next] lockdep: Use memset_startat() helper in reinit_class()
Date:   Mon, 13 Dec 2021 21:26:18 +0800
Message-ID: <20211213132618.105737-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use memset_startat() helper to simplify the code, there is no functional
change in this patch.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/locking/lockdep.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4a882f83aeb9..89b3df51fd98 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6011,13 +6011,10 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 
 static void reinit_class(struct lock_class *class)
 {
-	void *const p = class;
-	const unsigned int offset = offsetof(struct lock_class, key);
-
 	WARN_ON_ONCE(!class->lock_entry.next);
 	WARN_ON_ONCE(!list_empty(&class->locks_after));
 	WARN_ON_ONCE(!list_empty(&class->locks_before));
-	memset(p + offset, 0, sizeof(*class) - offset);
+	memset_startat(class, 0, key);
 	WARN_ON_ONCE(!class->lock_entry.next);
 	WARN_ON_ONCE(!list_empty(&class->locks_after));
 	WARN_ON_ONCE(!list_empty(&class->locks_before));
-- 
2.17.1

