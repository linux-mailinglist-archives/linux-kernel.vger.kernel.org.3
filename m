Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C195E47F9E1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 04:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbhL0DMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 22:12:23 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:30114 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbhL0DMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 22:12:09 -0500
Received: from kwepemi100003.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JMjLF0ws5z1DKFt;
        Mon, 27 Dec 2021 11:08:53 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100003.china.huawei.com (7.221.188.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 27 Dec 2021 11:12:07 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 27 Dec
 2021 11:12:07 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <mcoquelin.stm32@gmail.com>, <kirill.shutemov@linux.intel.com>,
        <s.hauer@pengutronix.de>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 08/15] ubifs: setflags: Make dirtied_ino_d 8 bytes aligned
Date:   Mon, 27 Dec 2021 11:22:39 +0800
Message-ID: <20211227032246.2886878-9-chengzhihao1@huawei.com>
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

Make 'ui->data_len' aligned with 8 bytes before it is assigned to
dirtied_ino_d. Since 8871d84c8f8b0c6b("ubifs: convert to fileattr")
applied, 'setflags()' only affects regular files and directories, only
xattr inode, symlink inode and special inode(pipe/char_dev/block_dev)
have none- zero 'ui->data_len' field, so assertion
'!(req->dirtied_ino_d & 7)' cannot fail in ubifs_budget_space().
To avoid assertion fails in future evolution(eg. setflags can operate
special inodes), it's better to make dirtied_ino_d 8 bytes aligned,
after all aligned size is still zero for regular files.

Fixes: 1e51764a3c2ac05a ("UBIFS: add new flash file system")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index c6a863487780..71bcebe45f9c 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -108,7 +108,7 @@ static int setflags(struct inode *inode, int flags)
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	struct ubifs_budget_req req = { .dirtied_ino = 1,
-					.dirtied_ino_d = ui->data_len };
+			.dirtied_ino_d = ALIGN(ui->data_len, 8) };
 
 	err = ubifs_budget_space(c, &req);
 	if (err)
-- 
2.31.1

