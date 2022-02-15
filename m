Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77574B63C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbiBOGzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:55:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiBOGy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:54:58 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C980727B2E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 22:54:45 -0800 (PST)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JyWyV2QFZzbkSj;
        Tue, 15 Feb 2022 14:53:38 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 14:54:43 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 15 Feb
 2022 14:54:43 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <jlbec@evilplan.org>, <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>, <chenxiaosong2@huawei.com>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>, <qiulaibin@huawei.com>
Subject: [PATCH -next] configfs: fix a race in configfs_{,un}register_subsystem()
Date:   Tue, 15 Feb 2022 15:10:30 +0800
Message-ID: <20220215071030.3067982-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When configfs_register_subsystem() or configfs_unregister_subsystem()
is executing link_group() or unlink_group(),
it is possible that two processes add or delete list concurrently.
Some unfortunate interleavings of them can cause kernel panic.

One of cases is:
A --> B --> C --> D
A <-- B <-- C <-- D

     delete list_head *B        |      delete list_head *C
--------------------------------|-----------------------------------
configfs_unregister_subsystem   |   configfs_unregister_subsystem
  unlink_group                  |     unlink_group
    unlink_obj                  |       unlink_obj
      list_del_init             |         list_del_init
        __list_del_entry        |           __list_del_entry
          __list_del            |             __list_del
            // next == C        |
            next->prev = prev   |
                                |               next->prev = prev
            prev->next = next   |
                                |                 // prev == B
                                |                 prev->next = next

Fix this by adding mutex when calling link_group() or unlink_group(),
but parent configfs_subsystem is NULL when config_item is root.
So I create a mutex configfs_subsystem_mutex.

Fixes: 7063fbf22611 ("[PATCH] configfs: User-driven configuration filesystem")
Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
---
 fs/configfs/dir.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 688f28b0c4f8..170538639533 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -35,6 +35,14 @@
  */
 DEFINE_SPINLOCK(configfs_dirent_lock);
 
+/*
+ * All of link_obj/unlink_obj/link_group/unlink_group require that
+ * subsys->su_mutex is held.
+ * But parent configfs_subsystem is NULL when config_item is root.
+ * Use this mutex when config_item is root.
+ */
+static DEFINE_MUTEX(configfs_subsystem_mutex);
+
 static void configfs_d_iput(struct dentry * dentry,
 			    struct inode * inode)
 {
@@ -1927,7 +1935,9 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 		group->cg_item.ci_name = group->cg_item.ci_namebuf;
 
 	sd = root->d_fsdata;
+	mutex_lock(&configfs_subsystem_mutex);
 	link_group(to_config_group(sd->s_element), group);
+	mutex_unlock(&configfs_subsystem_mutex);
 
 	inode_lock_nested(d_inode(root), I_MUTEX_PARENT);
 
@@ -1952,7 +1962,9 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 	inode_unlock(d_inode(root));
 
 	if (err) {
+		mutex_lock(&configfs_subsystem_mutex);
 		unlink_group(group);
+		mutex_unlock(&configfs_subsystem_mutex);
 		configfs_release_fs();
 	}
 	put_fragment(frag);
@@ -1999,7 +2011,9 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 
 	dput(dentry);
 
+	mutex_lock(&configfs_subsystem_mutex);
 	unlink_group(group);
+	mutex_unlock(&configfs_subsystem_mutex);
 	configfs_release_fs();
 }
 
-- 
2.31.1

