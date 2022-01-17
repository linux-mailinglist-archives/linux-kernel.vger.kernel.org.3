Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CE1490436
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbiAQIoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:44:04 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:31163 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238330AbiAQIn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:43:57 -0500
Received: from kwepemi500001.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Jcljv0xfNz8wNn;
        Mon, 17 Jan 2022 16:41:07 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500001.china.huawei.com (7.221.188.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 16:43:54 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 17 Jan
 2022 16:43:54 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH RESEND 3/3] blk-mq: allow hardware queue to get more tag while sharing a tag set
Date:   Mon, 17 Jan 2022 16:54:55 +0800
Message-ID: <20220117085455.2269760-4-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220117085455.2269760-1-yukuai3@huawei.com>
References: <20220117085455.2269760-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are multiple active queues while sharing a tag set, the
avaliable driver tag for each queue is fair share currently. However,
we found this way cause performance degradation in our environment:

A virtual machine which has 12 scsi disks on the same scsi host, each
disk represents a network disk on host machine. In virtual machine, each
disk will issue a sg io about every 15s, which will cause active queues
to be 12 before the disk is idle(blk_mq_tag_idle() is called), and io
performance is bad due to short of driver tag during that time.

Thus if there are no hctx ever failed to get driver tag, don't limit the
available driver tags as fair share. And if someone do failed to get
driver tag, fall back to fair share.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index 948791ea2a3e..4b059221b265 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -352,6 +352,10 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 	if (bt->sb.depth == 1)
 		return true;
 
+	/* Don't use fair share untill some hctx failed to get driver tag */
+	if (!atomic_read(&hctx->tags->pending_queues))
+		return true;
+
 	if (blk_mq_is_shared_tags(hctx->flags)) {
 		struct request_queue *q = hctx->queue;
 
-- 
2.31.1

