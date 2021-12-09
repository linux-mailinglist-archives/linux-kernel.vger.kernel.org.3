Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2239846ED1E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbhLIQhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:37:03 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:55009 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236830AbhLIQhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:37:01 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V-4XSLS_1639067604;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0V-4XSLS_1639067604)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 00:33:26 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 1/2] mm/damon/dbgfs: Avoid target_ids display wrong pid value
Date:   Fri, 10 Dec 2021 00:33:16 +0800
Message-Id: <008dfc6bc5edb802f759227111f5a0eff153e279.1639066954.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1639066954.git.xhao@linux.alibaba.com>
References: <cover.1639066954.git.xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of pid_vnr() is pid_t type which is defined by 'int', this may
get a wrong pid value, if we set the return value type as 'unsigned long'.
So there fix it.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/dbgfs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 991b7fa0e858..97eebfb70ddf 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -281,17 +281,15 @@ static inline bool targetid_is_pid(const struct damon_ctx *ctx)
 static ssize_t sprint_target_ids(struct damon_ctx *ctx, char *buf, ssize_t len)
 {
 	struct damon_target *t;
-	unsigned long id;
-	int written = 0;
+	int id, written = 0;
 	int rc;
 
 	damon_for_each_target(t, ctx) {
-		id = t->id;
 		if (targetid_is_pid(ctx))
 			/* Show pid numbers to debugfs users */
-			id = (unsigned long)pid_vnr((struct pid *)id);
+			id = (int)pid_vnr((struct pid *)t->id);
 
-		rc = scnprintf(&buf[written], len - written, "%lu ", id);
+		rc = scnprintf(&buf[written], len - written, "%d ", id);
 		if (!rc)
 			return -ENOMEM;
 		written += rc;
-- 
2.31.0

