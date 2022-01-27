Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C2749DE5C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbiA0Jpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:45:39 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:32124 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238840AbiA0Jpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:45:36 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JkwcB5Bnzz8wf1;
        Thu, 27 Jan 2022 17:42:34 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 17:45:33 +0800
Received: from huawei.com (10.175.124.27) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 27 Jan
 2022 17:45:32 +0800
From:   Laibin Qiu <qiulaibin@huawei.com>
To:     <axboe@kernel.dk>, <andriy.shevchenko@linux.intel.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alex_y_xu@yahoo.ca>
Subject: [PATCH -next] blk-mq: Fix wrong wakeup batch configuration which will cause hang
Date:   Thu, 27 Jan 2022 18:00:47 +0800
Message-ID: <20220127100047.1763746-1-qiulaibin@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 180dccb0dba4f ("blk-mq: fix tag_get wait task can't be
awakened") will recalculating wake_batch when inc or dec active_queues
to avoid wake_batch is > hctx_max_depth. At the same time, in order to
not affect performance as much as possible, the minimum wakeup batch is
set to 4. But when the QD is small (such as QD=1), if inc or dec
active_queues will increase wakeup batch, which will lead to hang.

Fix this problem with the following strategies:
QD          :  >= 32 | < 32
---------------------------------
wakeup batch:  8~4   | 3~1

Fixes: 180dccb0dba4f ("blk-mq: fix tag_get wait task can't be awakened")
Link: https://lore.kernel.org/linux-block/78cafe94-a787-e006-8851-69906f0c2128@huawei.com/T/#t
Reported-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
---
 lib/sbitmap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 6220fa67fb7e..09d293c30fd2 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -488,9 +488,13 @@ void sbitmap_queue_recalculate_wake_batch(struct sbitmap_queue *sbq,
 					    unsigned int users)
 {
 	unsigned int wake_batch;
+	unsigned int min_batch;
+	unsigned int depth = (sbq->sb.depth + users - 1) / users;
 
-	wake_batch = clamp_val((sbq->sb.depth + users - 1) /
-			users, 4, SBQ_WAKE_BATCH);
+	min_batch = sbq->sb.depth >= (4 * SBQ_WAIT_QUEUES) ? 4 : 1;
+
+	wake_batch = clamp_val(depth / SBQ_WAIT_QUEUES,
+			min_batch, SBQ_WAKE_BATCH);
 	__sbitmap_queue_update_wake_batch(sbq, wake_batch);
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_recalculate_wake_batch);
-- 
2.22.0

