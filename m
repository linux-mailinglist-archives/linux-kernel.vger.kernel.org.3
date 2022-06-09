Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8C35448FD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242306AbiFIKgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239865AbiFIKgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:36:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E593A1C4715;
        Thu,  9 Jun 2022 03:36:01 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJgNw0PSvz689Nq;
        Thu,  9 Jun 2022 18:31:12 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 12:35:59 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:35:56 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <brking@us.ibm.com>, <hare@suse.de>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 01/18] blk-mq: Add a flag for reserved requests
Date:   Thu, 9 Jun 2022 18:29:02 +0800
Message-ID: <1654770559-101375-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a flag for reserved requests so that drivers may know this for any
special handling.

The 'reserved' argument in blk_mq_ops.timeout callback could now be
replaced by using this flag.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 block/blk-mq.c         | 6 ++++++
 include/linux/blk-mq.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e9bf950983c7..23f2eafb09ca 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -474,6 +474,9 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 	if (!(data->rq_flags & RQF_ELV))
 		blk_mq_tag_busy(data->hctx);
 
+	if (data->flags & BLK_MQ_REQ_RESERVED)
+		data->rq_flags |= RQF_RESV;
+
 	/*
 	 * Try batched alloc if we want more than 1 tag.
 	 */
@@ -586,6 +589,9 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	else
 		data.rq_flags |= RQF_ELV;
 
+	if (flags & BLK_MQ_REQ_RESERVED)
+		data.rq_flags |= RQF_RESV;
+
 	ret = -EWOULDBLOCK;
 	tag = blk_mq_get_tag(&data);
 	if (tag == BLK_MQ_NO_TAG)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e2d9daf7e8dd..6d81fe10e850 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -57,6 +57,7 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_TIMED_OUT		((__force req_flags_t)(1 << 21))
 /* queue has elevator attached */
 #define RQF_ELV			((__force req_flags_t)(1 << 22))
+#define RQF_RESV			((__force req_flags_t)(1 << 23))
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
@@ -823,6 +824,11 @@ static inline bool blk_mq_need_time_stamp(struct request *rq)
 	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS | RQF_ELV));
 }
 
+static inline bool blk_mq_is_reserved_rq(struct request *rq)
+{
+	return rq->rq_flags & RQF_RESV;
+}
+
 /*
  * Batched completions only work when there is no I/O error and no special
  * ->end_io handler.
-- 
2.26.2

