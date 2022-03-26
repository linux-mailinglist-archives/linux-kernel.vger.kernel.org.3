Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086834E7EC8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 04:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiCZDcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 23:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiCZDcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 23:32:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6F59E9C7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 20:30:36 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KQPZL62dMzfZPk
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 11:28:58 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 26 Mar 2022 11:30:34 +0800
Received: from huawei.com (10.90.53.225) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 26 Mar
 2022 11:30:33 +0800
From:   fengyubo <fengyubo3@huawei.com>
To:     <hirofumi@mail.parknet.co.jp>
CC:     <linux-kernel@vger.kernel.org>, <fengyubo3@huawei.com>
Subject: [PATCH -next] fatfs: remove redundant judgment
Date:   Sat, 26 Mar 2022 11:30:18 +0800
Message-ID: <1648265418-76563-1-git-send-email-fengyubo3@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yubo Feng <fengyubo3@huawei.com>

iput() has already judged the incoming parameter, so there is no need to
repeat outside.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yubo Feng <fengyubo3@huawei.com>
---
 fs/fat/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index a6f1c6d426d1..da8619148590 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1888,10 +1888,8 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 		fat_msg(sb, KERN_INFO, "Can't find a valid FAT filesystem");
 
 out_fail:
-	if (fsinfo_inode)
-		iput(fsinfo_inode);
-	if (fat_inode)
-		iput(fat_inode);
+	iput(fsinfo_inode);
+	iput(fat_inode);
 	unload_nls(sbi->nls_io);
 	unload_nls(sbi->nls_disk);
 	fat_reset_iocharset(&sbi->options);
-- 
2.17.1

