Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CB147AA98
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhLTNsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:48:32 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:30150 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbhLTNsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:48:22 -0500
Received: from kwepemi100004.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JHgpf3hTBz8vyJ;
        Mon, 20 Dec 2021 21:46:02 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100004.china.huawei.com (7.221.188.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 21:48:20 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 20 Dec
 2021 21:48:20 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <mcoquelin.stm32@gmail.com>, <kirill.shutemov@linux.intel.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>
Subject: [PATCH v5 07/14] ubifs: Rectify space amount budget for mkdir/tmpfile operations
Date:   Mon, 20 Dec 2021 21:59:44 +0800
Message-ID: <20211220135951.4075801-8-chengzhihao1@huawei.com>
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

UBIFS should make sure the flash has enough space to store dirty (Data
that is newer than disk) data (in memory), space budget is exactly
designed to do that. If space budget calculates less data than we need,
'make_reservation()' will do more work(return -ENOSPC if no free space
lelf, sometimes we can see "cannot reserve xxx bytes in jhead xxx, error
-28" in ubifs error messages) with ubifs inodes locked, which may effect
other syscalls.

A simple way to decide how much space do we need when make a budget:
See how much space is needed by 'make_reservation()' in ubifs_jnl_xxx()
function according to corresponding operation.

It's better to report ENOSPC in ubifs_budget_space(), as early as we can.

Fixes: 474b93704f32163 ("ubifs: Implement O_TMPFILE")
Fixes: 1e51764a3c2ac05 ("UBIFS: add new flash file system")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/dir.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index ebdc9aa04cbb..7ae48f273feb 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -428,15 +428,18 @@ static int ubifs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 {
 	struct inode *inode;
 	struct ubifs_info *c = dir->i_sb->s_fs_info;
-	struct ubifs_budget_req req = { .new_ino = 1, .new_dent = 1};
+	struct ubifs_budget_req req = { .new_ino = 1, .new_dent = 1,
+					.dirtied_ino = 1};
 	struct ubifs_budget_req ino_req = { .dirtied_ino = 1 };
 	struct ubifs_inode *ui;
 	int err, instantiated = 0;
 	struct fscrypt_name nm;
 
 	/*
-	 * Budget request settings: new dirty inode, new direntry,
-	 * budget for dirtied inode will be released via writeback.
+	 * Budget request settings: new inode, new direntry, changing the
+	 * parent directory inode.
+	 * Allocate budget separately for new dirtied inode, the budget will
+	 * be released via writeback.
 	 */
 
 	dbg_gen("dent '%pd', mode %#hx in dir ino %lu",
@@ -979,7 +982,8 @@ static int ubifs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	struct ubifs_inode *dir_ui = ubifs_inode(dir);
 	struct ubifs_info *c = dir->i_sb->s_fs_info;
 	int err, sz_change;
-	struct ubifs_budget_req req = { .new_ino = 1, .new_dent = 1 };
+	struct ubifs_budget_req req = { .new_ino = 1, .new_dent = 1,
+					.dirtied_ino = 1};
 	struct fscrypt_name nm;
 
 	/*
-- 
2.31.1

