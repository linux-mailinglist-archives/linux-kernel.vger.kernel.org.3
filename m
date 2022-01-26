Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5CA49C076
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbiAZBKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:10:44 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17811 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiAZBKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:10:44 -0500
Received: from kwepemi100016.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Jk5GV55QFz9sWV;
        Wed, 26 Jan 2022 09:09:22 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100016.china.huawei.com (7.221.188.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 09:10:42 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 26 Jan
 2022 09:10:41 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v2] blk-mq: fix missing blk_account_io_done() in error path
Date:   Wed, 26 Jan 2022 09:21:32 +0800
Message-ID: <20220126012132.3111551-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If blk_mq_request_issue_directly() failed from
blk_insert_cloned_request(), the request will be accounted start.
Currently, blk_insert_cloned_request() is only called by dm, and such
request won't be accounted done by dm.

In normal path, io will be accounted start from blk_mq_bio_to_request(),
when the request is allocated, and such io will be accounted done from
__blk_mq_end_request_acct() whether it succeeded or failed. Thus add
blk_account_io_done() to fix the problem.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
Changes in v2:
 - change the subject from dm to blk-mq

 block/blk-mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d73bc219a7fa..d73490fe200d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2922,6 +2922,8 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 	 */
 	blk_mq_run_dispatch_ops(rq->q,
 			ret = blk_mq_request_issue_directly(rq, true));
+	if (ret)
+		blk_account_io_done(rq, ktime_get_ns());
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_insert_cloned_request);
-- 
2.31.1

