Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3949E54C256
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244042AbiFOHGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiFOHGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:06:02 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B027A1582E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:06:01 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LNGX653pSzjYB2;
        Wed, 15 Jun 2022 15:04:54 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 15:05:59 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 15 Jun
 2022 15:05:59 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>, <daehojeong@google.com>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH -next] f2fs: fix build error too many arguments to functions
Date:   Wed, 15 Jun 2022 15:04:22 +0800
Message-ID: <20220615070422.214106-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_F2FS_FS_COMPRESSION is not set.

make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-, will be failed, like this:
fs/f2fs/data.c: In function ‘f2fs_finish_read_bio’:
fs/f2fs/data.c:136:5: error: too many arguments to function ‘f2fs_end_read_compressed_page’
     f2fs_end_read_compressed_page(page, true, 0,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from fs/f2fs/data.c:25:0:
fs/f2fs/f2fs.h:4228:20: note: declared here
 static inline void f2fs_end_read_compressed_page(struct page *page,
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/f2fs/data.c:138:4: error: too many arguments to function ‘f2fs_put_page_dic’
    f2fs_put_page_dic(page, in_softirq);
    ^~~~~~~~~~~~~~~~~
In file included from fs/f2fs/data.c:25:0:
fs/f2fs/f2fs.h:4233:20: note: declared here
 static inline void f2fs_put_page_dic(struct page *page)
                    ^~~~~~~~~~~~~~~~~
fs/f2fs/data.c: In function ‘f2fs_handle_step_decompress’:
fs/f2fs/data.c:241:4: error: too many arguments to function ‘f2fs_end_read_compressed_page’
    f2fs_end_read_compressed_page(page, PageError(page),
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from fs/f2fs/data.c:25:0:
fs/f2fs/f2fs.h:4228:20: note: declared here
 static inline void f2fs_end_read_compressed_page(struct page *page,
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[2]: *** [fs/f2fs/data.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [fs/f2fs] Error 2

Since commit 1b565702dffe ("f2fs: handle decompress only post processing in softirq") 
had changed the definition of function "f2fs_end_read_compressed_page()" and "f2fs_put_page_dic()",
but forgot the other definitions in f2fs.h warpped by #else /* CONFIG_F2FS_FS_COMPRESSION */.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 1b565702dffe("f2fs: handle decompress only post processing in softirq")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 fs/f2fs/f2fs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b42fcca030e2..0811a9335dde 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4225,12 +4225,12 @@ static inline struct page *f2fs_compress_control_page(struct page *page)
 static inline int f2fs_init_compress_mempool(void) { return 0; }
 static inline void f2fs_destroy_compress_mempool(void) { }
 static inline void f2fs_decompress_cluster(struct decompress_io_ctx *dic) { }
-static inline void f2fs_end_read_compressed_page(struct page *page,
-						bool failed, block_t blkaddr)
+static inline void f2fs_end_read_compressed_page(struct page *page, bool failed,
+				block_t blkaddr, bool in_softirq)
 {
 	WARN_ON_ONCE(1);
 }
-static inline void f2fs_put_page_dic(struct page *page)
+static inline void f2fs_put_page_dic(struct page *page, bool in_softirq)
 {
 	WARN_ON_ONCE(1);
 }
-- 
2.17.1

