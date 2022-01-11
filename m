Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A18E48A4E6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 02:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346200AbiAKBTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 20:19:24 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31085 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243319AbiAKBTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 20:19:23 -0500
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JXt6q1D8wz1FCcr;
        Tue, 11 Jan 2022 09:15:47 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 09:19:21 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 11 Jan
 2022 09:19:21 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
CC:     <hch@lst.de>, <james.smart@broadcom.com>,
        <martin.petersen@oracle.com>
Subject: [PATCH -next v2] scsi: efct: don't use GFP_KERNEL under spin lock
Date:   Tue, 11 Jan 2022 09:24:41 +0800
Message-ID: <20220111012441.3232527-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
v2:
  move up unlock to just protect list_add_tail()
---
 drivers/scsi/elx/libefc/efc_els.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/elx/libefc/efc_els.c b/drivers/scsi/elx/libefc/efc_els.c
index 7bb4f9aad2c8..84bc81d7ce76 100644
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
 
@@ -94,10 +89,11 @@ efc_els_io_alloc_size(struct efc_node *node, u32 reqlen, u32 rsplen)
 
 		/* add els structure to ELS IO list */
 		INIT_LIST_HEAD(&els->list_entry);
+		spin_lock_irqsave(&node->els_ios_lock, flags);
 		list_add_tail(&els->list_entry, &node->els_ios_list);
+		spin_unlock_irqrestore(&node->els_ios_lock, flags);
 	}
 
-	spin_unlock_irqrestore(&node->els_ios_lock, flags);
 	return els;
 }
 
-- 
2.25.1

