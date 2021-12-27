Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA78147F9DB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 04:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbhL0DMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 22:12:12 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15978 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbhL0DMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 22:12:05 -0500
Received: from kwepemi100008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JMjL90GKjzZdql;
        Mon, 27 Dec 2021 11:08:49 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 27 Dec 2021 11:12:03 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 27 Dec
 2021 11:12:02 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <mcoquelin.stm32@gmail.com>, <kirill.shutemov@linux.intel.com>,
        <s.hauer@pengutronix.de>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 03/15] ubifs: Fix wrong number of inodes locked by ui_mutex in ubifs_inode comment
Date:   Mon, 27 Dec 2021 11:22:34 +0800
Message-ID: <20211227032246.2886878-4-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211227032246.2886878-1-chengzhihao1@huawei.com>
References: <20211227032246.2886878-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 9ec64962afb1702f75b("ubifs: Implement RENAME_EXCHANGE") and
9e0a1fff8db56eaaebb("ubifs: Implement RENAME_WHITEOUT") are applied,
ubifs_rename locks and changes 4 ubifs inodes, correct the comment
for ui_mutex in ubifs_inode.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/ubifs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index c38066ce9ab0..972e41daff01 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -372,7 +372,7 @@ struct ubifs_gced_idx_leb {
  * @ui_mutex exists for two main reasons. At first it prevents inodes from
  * being written back while UBIFS changing them, being in the middle of an VFS
  * operation. This way UBIFS makes sure the inode fields are consistent. For
- * example, in 'ubifs_rename()' we change 3 inodes simultaneously, and
+ * example, in 'ubifs_rename()' we change 4 inodes simultaneously, and
  * write-back must not write any of them before we have finished.
  *
  * The second reason is budgeting - UBIFS has to budget all operations. If an
-- 
2.31.1

