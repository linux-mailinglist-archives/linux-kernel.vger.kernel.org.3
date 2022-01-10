Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A8848971C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244559AbiAJLOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:14:09 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16698 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244515AbiAJLNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:13:19 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JXWLb2MMrzZf6f;
        Mon, 10 Jan 2022 19:09:43 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 19:13:17 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 10 Jan
 2022 19:13:16 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
CC:     <hch@lst.de>, <james.smart@broadcom.com>,
        <martin.petersen@oracle.com>
Subject: [PATCH -next] scsi: efct: don't use GFP_KERNEL under spin lock
Date:   Mon, 10 Jan 2022 19:18:38 +0800
Message-ID: <20220110111838.965480-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GFP_KERNEL/GFP_DMA can't be used under a spin lock, according the
comment of els_ios_lock, it's used to protect els ios list, so we
can move down the spin lock to avoid using this flag under the lock.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 8f406ef72859 ("scsi: elx: libefc: Extended link Service I/O handling")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/scsi/elx/libefc/efc_els.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/elx/libefc/efc_els.c b/drivers/scsi/elx/libefc/efc_els.c
index 7bb4f9aad2c8..cec6a2f649b3 100644
--- a/drivers/scsi/elx/libefc/efc_els.c
+++ b/drivers/scsi/elx/libefc/efc_els.c
@@ -46,18 +46,14 @@ efc_els_io_alloc_size(struct efc_node *node, u32 reqlen, u32 rsplen)
 
 	efc = node->efc;
 
-	spin_lock_irqsave(&node->els_ios_lock, flags);
-
 	if (!node->els_io_enabled) {
 		efc_log_err(efc, "els io alloc disabled\n");
-		spin_unlock_irqrestore(&node->els_ios_lock, flags);
 		return NULL;
 	}
 
 	els = mempool_alloc(efc->els_io_pool, GFP_ATOMIC);
 	if (!els) {
 		atomic_add_return(1, &efc->els_io_alloc_failed_count);
-		spin_unlock_irqrestore(&node->els_ios_lock, flags);
 		return NULL;
 	}
 
@@ -74,7 +70,6 @@ efc_els_io_alloc_size(struct efc_node *node, u32 reqlen, u32 rsplen)
 					      &els->io.req.phys, GFP_KERNEL);
 	if (!els->io.req.virt) {
 		mempool_free(els, efc->els_io_pool);
-		spin_unlock_irqrestore(&node->els_ios_lock, flags);
 		return NULL;
 	}
 
@@ -88,6 +83,8 @@ efc_els_io_alloc_size(struct efc_node *node, u32 reqlen, u32 rsplen)
 		els = NULL;
 	}
 
+	spin_lock_irqsave(&node->els_ios_lock, flags);
+
 	if (els) {
 		/* initialize fields */
 		els->els_retries_remaining = EFC_FC_ELS_DEFAULT_RETRIES;
-- 
2.25.1

