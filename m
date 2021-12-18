Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF51A479A3B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 11:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhLRKXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 05:23:43 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:30139 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbhLRKXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 05:23:39 -0500
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JGMMN5vZDz8vtm;
        Sat, 18 Dec 2021 18:21:20 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 18 Dec 2021 18:23:36 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sat, 18 Dec
 2021 18:23:36 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <mcoquelin.stm32@gmail.com>, <kirill.shutemov@linux.intel.com>,
        <Artem.Bityutskiy@nokia.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>
Subject: [PATCH v4 04/13] ubifs: Add missing iput if do_tmpfile() failed in rename whiteout
Date:   Sat, 18 Dec 2021 18:35:03 +0800
Message-ID: <20211218103512.370420-5-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211218103512.370420-1-chengzhihao1@huawei.com>
References: <20211218103512.370420-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

whiteout inode should be put when do_tmpfile() failed if inode has been
initialized. Otherwise we will get following warning during umount:
  UBIFS error (ubi0:0 pid 1494): ubifs_assert_failed [ubifs]: UBIFS
  assert failed: c->bi.dd_growth == 0, in fs/ubifs/super.c:1930
  VFS: Busy inodes after unmount of ubifs. Self-destruct in 5 seconds.

Fixes: 9e0a1fff8db56ea ("ubifs: Implement RENAME_WHITEOUT")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 2735ad1affed..2cbc5f05f671 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -432,6 +432,8 @@ static int do_tmpfile(struct inode *dir, struct dentry *dentry,
 	make_bad_inode(inode);
 	if (!instantiated)
 		iput(inode);
+	else if (whiteout)
+		iput(*whiteout);
 out_budg:
 	ubifs_release_budget(c, &req);
 	if (!instantiated)
-- 
2.31.1

