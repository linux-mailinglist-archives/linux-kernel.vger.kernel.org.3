Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F2F52BE10
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238771AbiEROnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238718AbiEROnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:43:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FF5B36CD;
        Wed, 18 May 2022 07:43:13 -0700 (PDT)
Received: from kwepemi500004.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L3G0D3htQzgYJF;
        Wed, 18 May 2022 22:41:48 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi500004.china.huawei.com (7.221.188.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 22:43:10 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 22:43:09 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <sfrench@samba.org>
CC:     <linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
        <linux-kernel@vger.kernel.org>, <chenxiaosong2@huawei.com>,
        <liuyongqiang13@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH -next] cifs: return the more nuanced writeback error on close()
Date:   Wed, 18 May 2022 22:56:49 +0800
Message-ID: <20220518145649.2487377-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
 fs/cifs/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index d511a78383c3..559f59a047c2 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2777,8 +2777,11 @@ int cifs_flush(struct file *file, fl_owner_t id)
 		rc = filemap_write_and_wait(inode->i_mapping);
 
 	cifs_dbg(FYI, "Flush inode %p file %p rc %d\n", inode, file, rc);
-	if (rc)
+	if (rc) {
+		/* get more nuanced writeback errors */
+		rc = filemap_check_wb_err(file->f_mapping, 0);
 		trace_cifs_flush_err(inode->i_ino, rc);
+	}
 	return rc;
 }
 
-- 
2.31.1

