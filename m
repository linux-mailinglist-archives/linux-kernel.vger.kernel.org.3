Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B7B52BE7A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238830AbiEROof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238821AbiEROoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:44:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECE71D500C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:44:21 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L3G2R5H4nzhZ2S;
        Wed, 18 May 2022 22:43:43 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 22:44:19 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 22:44:18 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <hubcap@omnibond.com>
CC:     <devel@lists.orangefs.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <liuyongqiang13@huawei.com>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH -next] orangefs: return the more nuanced writeback error on close()
Date:   Wed, 18 May 2022 22:57:59 +0800
Message-ID: <20220518145759.2488632-1-chenxiaosong2@huawei.com>
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

As filemap_check_errors() only report -EIO or -ENOSPC, we return more nuanced
writeback error -(file->f_mapping->wb_err & MAX_ERRNO).

  filemap_write_and_wait
    filemap_write_and_wait_range
      filemap_check_errors
        -ENOSPC or -EIO
  filemap_check_wb_err
    errseq_check
      return -(file->f_mapping->wb_err & MAX_ERRNO)

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/orangefs/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index 86810e5d7914..5c9f0ad7e317 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -545,10 +545,10 @@ static int orangefs_flush(struct file *file, fl_owner_t id)
 	int r;
 
 	r = filemap_write_and_wait_range(file->f_mapping, 0, LLONG_MAX);
-	if (r > 0)
-		return 0;
-	else
-		return r;
+	/* get more nuanced writeback errors */
+	if (r)
+		r = filemap_check_wb_err(file->f_mapping, 0);
+	return r;
 }
 
 /** ORANGEFS implementation of VFS file operations */
-- 
2.31.1

