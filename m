Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CB947AA92
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhLTNsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:48:21 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:30080 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbhLTNsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:48:18 -0500
Received: from kwepemi100008.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JHgnf3bHtz1DK93;
        Mon, 20 Dec 2021 21:45:10 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 21:48:16 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 20 Dec
 2021 21:48:15 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <mcoquelin.stm32@gmail.com>, <kirill.shutemov@linux.intel.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>
Subject: [PATCH v5 01/14] ubifs: rename_whiteout: Fix double free for whiteout_ui->data
Date:   Mon, 20 Dec 2021 21:59:38 +0800
Message-ID: <20211220135951.4075801-2-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211220135951.4075801-1-chengzhihao1@huawei.com>
References: <20211220135951.4075801-1-chengzhihao1@huawei.com>
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

'whiteout_ui->data' will be freed twice if space budget fail for
rename whiteout operation as following process:

rename_whiteout
  dev = kmalloc
  whiteout_ui->data = dev
  kfree(whiteout_ui->data)  // Free first time
  iput(whiteout)
    ubifs_free_inode
      kfree(ui->data)	    // Double free!

KASAN reports:
==================================================================
BUG: KASAN: double-free or invalid-free in ubifs_free_inode+0x4f/0x70
Call Trace:
  kfree+0x117/0x490
  ubifs_free_inode+0x4f/0x70 [ubifs]
  i_callback+0x30/0x60
  rcu_do_batch+0x366/0xac0
  __do_softirq+0x133/0x57f

Allocated by task 1506:
  kmem_cache_alloc_trace+0x3c2/0x7a0
  do_rename+0x9b7/0x1150 [ubifs]
  ubifs_rename+0x106/0x1f0 [ubifs]
  do_syscall_64+0x35/0x80

Freed by task 1506:
  kfree+0x117/0x490
  do_rename.cold+0x53/0x8a [ubifs]
  ubifs_rename+0x106/0x1f0 [ubifs]
  do_syscall_64+0x35/0x80

The buggy address belongs to the object at ffff88810238bed8 which
belongs to the cache kmalloc-8 of size 8
==================================================================

Let ubifs_free_inode() free 'whiteout_ui->data'. BTW, delete unused
assignment 'whiteout_ui->data_len = 0', process 'ubifs_evict_inode()
-> ubifs_jnl_delete_inode() -> ubifs_jnl_write_inode()' doesn't need it
(because 'inc_nlink(whiteout)' won't be excuted by 'goto out_release',
 and the nlink of whiteout inode is 0).

Fixes: 9e0a1fff8db56ea ("ubifs: Implement RENAME_WHITEOUT")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/dir.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 7c61d0ec0159..cfa8881d8cca 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1425,8 +1425,6 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 		err = ubifs_budget_space(c, &wht_req);
 		if (err) {
-			kfree(whiteout_ui->data);
-			whiteout_ui->data_len = 0;
 			iput(whiteout);
 			goto out_release;
 		}
-- 
2.31.1

