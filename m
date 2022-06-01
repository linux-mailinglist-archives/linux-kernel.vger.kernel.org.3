Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D70E53A4D0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244672AbiFAMXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbiFAMX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:23:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185063B3C9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:23:25 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LCpD73fdjzgYWl;
        Wed,  1 Jun 2022 20:21:43 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 20:23:23 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 20:23:22 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <hughd@google.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH 1/4] mm/shmem: check return value of shmem_init_inodecache
Date:   Wed, 1 Jun 2022 20:44:14 +0800
Message-ID: <20220601124417.2872001-2-chenwandun@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601124417.2872001-1-chenwandun@huawei.com>
References: <20220601124417.2872001-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will result in null pointer access if shmem_init_inodecache fail,
so check return value of shmem_init_inodecache

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 mm/shmem.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index d55dd972023a..80c361c3d82c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3776,11 +3776,13 @@ static void shmem_init_inode(void *foo)
 	inode_init_once(&info->vfs_inode);
 }
 
-static void shmem_init_inodecache(void)
+static struct kmem_cache *shmem_init_inodecache(void)
 {
 	shmem_inode_cachep = kmem_cache_create("shmem_inode_cache",
 				sizeof(struct shmem_inode_info),
 				0, SLAB_PANIC|SLAB_ACCOUNT, shmem_init_inode);
+
+	return shmem_inode_cachep;
 }
 
 static void shmem_destroy_inodecache(void)
@@ -3924,7 +3926,10 @@ void __init shmem_init(void)
 {
 	int error;
 
-	shmem_init_inodecache();
+	if (!shmem_init_inodecache()) {
+		error = -ENOMEM;
+		goto out2;
+	}
 
 	error = register_filesystem(&shmem_fs_type);
 	if (error) {
-- 
2.25.1

