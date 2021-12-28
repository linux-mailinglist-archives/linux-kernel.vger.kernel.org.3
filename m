Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BCB4806DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 07:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhL1Gu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 01:50:29 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:30183 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhL1Gu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 01:50:27 -0500
Received: from kwepemi500005.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JNQ8b58Jqz8vmy;
        Tue, 28 Dec 2021 14:47:59 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi500005.china.huawei.com (7.221.188.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 14:50:26 +0800
Received: from huawei.com (10.174.178.163) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 28 Dec
 2021 14:50:25 +0800
From:   luhuaxin <luhuaxin1@huawei.com>
To:     <paul@paul-moore.com>, <eparis@redhat.com>
CC:     <linux-audit@redhat.com>, <linux-kernel@vger.kernel.org>,
        <fangxiuning@huawei.com>
Subject: [PATCH -next 1/1] audit: ignore userspace log when backlog limit exceeded and backlog_wait_time is 0
Date:   Tue, 28 Dec 2021 14:50:23 +0800
Message-ID: <20211228065023.118744-2-luhuaxin1@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20211228065023.118744-1-luhuaxin1@huawei.com>
References: <20211228065023.118744-1-luhuaxin1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.163]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the backlog exceed the backlog_limit and backlog_wait_time is set
to 0, the process will only sleep for a very short time (jiffies). The
backlog may still exceed backlog_limit in extreme cases.

The more reasonable way to fix this problem is:

1. If backlog_wait_time is set to zero, ignore the log;
2. If backlog_wait_time is set to non-zero, let process sleep for
backlog_wait_time.

The above log limit logic is also the same as that in the existing
audit_log_start function.

Fixes: 8f110f530635 ("[PATCH] audit: ensure userspace is penalized the
  same as the kernel when under pressure")
Signed-off-by: luhuaxin <luhuaxin1@huawei.com>
---
 kernel/audit.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 249e11628..70450f70a 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1545,7 +1545,8 @@ static void audit_receive(struct sk_buff  *skb)
 
 	/* can't block with the ctrl lock, so penalize the sender now */
 	if (audit_backlog_limit &&
-	    (skb_queue_len(&audit_queue) > audit_backlog_limit)) {
+	    (skb_queue_len(&audit_queue) > audit_backlog_limit) &&
+	    audit_backlog_wait_time) {
 		DECLARE_WAITQUEUE(wait, current);
 
 		/* wake kauditd to try and flush the queue */
@@ -1842,9 +1843,8 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 	 *    while holding the mutex, although we do penalize the sender
 	 *    later in audit_receive() when it is safe to block
 	 */
+	long stime = audit_backlog_wait_time;
 	if (!(auditd_test_task(current) || audit_ctl_owner_current())) {
-		long stime = audit_backlog_wait_time;
-
 		while (audit_backlog_limit &&
 		       (skb_queue_len(&audit_queue) > audit_backlog_limit)) {
 			/* wake kauditd to try and flush the queue */
@@ -1872,6 +1872,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 				return NULL;
 			}
 		}
+	} else if (!stime && audit_backlog_limit &&
+		   (skb_queue_len(&audit_queue) > audit_backlog_limit)) {
+		if (audit_rate_check() && printk_ratelimit())
+			pr_warn("audit_backlog=%d > audit_backlog_limit=%d\n",
+				skb_queue_len(&audit_queue),
+				audit_backlog_limit);
+		audit_log_lost("backlog limit exceeded");
+		return NULL;
 	}
 
 	ab = audit_buffer_alloc(ctx, gfp_mask, type);
-- 
2.23.0

