Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F84E59B78E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 04:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiHVC3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 22:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbiHVC3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 22:29:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A301EC55
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 19:29:08 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M9x7s4Sn8znTfY;
        Mon, 22 Aug 2022 10:26:49 +0800 (CST)
Received: from dggphis33418.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 10:29:05 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <paul@paul-moore.com>, <eparis@redhat.com>, <mszeredi@redhat.com>,
        <jack@suse.cz>, <amir73il@gmail.com>, <cuigaosheng1@huawei.com>
CC:     <linux-audit@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH next] audit: fix potential double free on error path from fsnotify_add_inode_mark
Date:   Mon, 22 Aug 2022 10:29:05 +0800
Message-ID: <20220822022905.1949007-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audit_alloc_mark() assign pathname to audit_mark->path, on error path
from fsnotify_add_inode_mark(), fsnotify_put_mark will free memory
of audit_mark->path, but the caller of audit_alloc_mark will free
the pathname again, so there will be double free problem.

Fix this by resetting audit_mark->path to NULL pointer on error path
from fsnotify_add_inode_mark().

Fixes: 7b1293234084d ("fsnotify: Add group pointer in fsnotify_init_mark()")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 kernel/audit_fsnotify.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 6432a37ac1c9..c565fbf66ac8 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -102,6 +102,7 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 
 	ret = fsnotify_add_inode_mark(&audit_mark->mark, inode, 0);
 	if (ret < 0) {
+		audit_mark->path = NULL;
 		fsnotify_put_mark(&audit_mark->mark);
 		audit_mark = ERR_PTR(ret);
 	}
-- 
2.25.1

