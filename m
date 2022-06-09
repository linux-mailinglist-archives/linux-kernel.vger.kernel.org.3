Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEFA544932
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243237AbiFIKiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243077AbiFIKhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:37:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44D8211133;
        Thu,  9 Jun 2022 03:36:50 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJgRH0tBwz67ycH;
        Thu,  9 Jun 2022 18:33:15 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 9 Jun 2022 12:36:48 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 11:36:45 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <brking@us.ibm.com>, <hare@suse.de>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 16/18] scsi: core: Add scsi_alloc_request_hwq()
Date:   Thu, 9 Jun 2022 18:29:17 +0800
Message-ID: <1654770559-101375-17-git-send-email-john.garry@huawei.com>
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

Add a variant of scsi_alloc_request() which allocates a request for a
specific hw queue.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/scsi_lib.c  | 12 ++++++++++++
 include/scsi/scsi_cmnd.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 8c8b4c6767d9..443afaf52c14 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1137,6 +1137,18 @@ struct request *scsi_alloc_request(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(scsi_alloc_request);
 
+struct request *scsi_alloc_request_hwq(struct request_queue *q,
+		unsigned int op, blk_mq_req_flags_t flags, unsigned int hwq)
+{
+	struct request *rq;
+
+	rq = blk_mq_alloc_request_hctx(q, op, flags, hwq);
+	if (!IS_ERR(rq))
+		scsi_initialize_rq(rq);
+	return rq;
+}
+EXPORT_SYMBOL_GPL(scsi_alloc_request_hwq);
+
 /*
  * Only called when the request isn't completed by SCSI, and not freed by
  * SCSI
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index e47df5836070..e69bb6baad47 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -394,4 +394,7 @@ extern void scsi_build_sense(struct scsi_cmnd *scmd, int desc,
 struct request *scsi_alloc_request(struct request_queue *q,
 		unsigned int op, blk_mq_req_flags_t flags);
 
+struct request *scsi_alloc_request_hwq(struct request_queue *q,
+		unsigned int op, blk_mq_req_flags_t flags, unsigned int hwq);
+
 #endif /* _SCSI_SCSI_CMND_H */
-- 
2.26.2

