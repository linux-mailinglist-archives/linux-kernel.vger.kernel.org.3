Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA02154B76E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238881AbiFNRPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiFNRPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:15:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B5A2408B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=1Bzt2bKl4WU2vNDcoULTc+6F61x+SG15/cRuXCESmPo=; b=MX2jPZNmmlcx+uQn/6/l3v/tWG
        WJ4Is+63PHvrRPcUVmy1ZbZML4HzypfGHTNpeYGuYeBTbR+95L8udd03n1PxhG7wkQHPQA8akiwVI
        pW4O86PHps+lE8JYA4GqT0tzRSanfiRWiCFd/ubsQXliXN3GIyfoGRvRuFmB5nJc1qoC2Yl3yjPHc
        XAq4sq654iswYy00Q18sXBK26n0D58oRPQYjGc7pbJyoR2TR85WIlLeYecOwbCvTKDPosrdYqBfIS
        JoTWIB6D/FOV0wxe5X2/2596IsZrJ28bxFctWX+TKCaQ+TOsd8TdcadSaWBsZCmNn8AIdeu8c8YNk
        XuN7Py6g==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1A8a-000Lea-0S; Tue, 14 Jun 2022 17:15:33 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Daeho Jeong <daehojeong@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH] f2fs: fix stubs when F2FS_FS_COMPRESSION is not enabled
Date:   Tue, 14 Jun 2022 10:15:26 -0700
Message-Id: <20220614171526.31756-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build errors when F2FS_FS_COMPRESSION is not set:

../fs/f2fs/data.c: In function ‘f2fs_finish_read_bio’:
../fs/f2fs/data.c:136:5: error: too many arguments to function ‘f2fs_end_read_compressed_page’
     f2fs_end_read_compressed_page(page, true, 0,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from ../fs/f2fs/data.c:25:0:
../fs/f2fs/f2fs.h:4228:20: note: declared here
 static inline void f2fs_end_read_compressed_page(struct page *page,
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../fs/f2fs/data.c:138:4: error: too many arguments to function ‘f2fs_put_page_dic’
    f2fs_put_page_dic(page, in_softirq);
    ^~~~~~~~~~~~~~~~~
In file included from ../fs/f2fs/data.c:25:0:
../fs/f2fs/f2fs.h:4233:20: note: declared here
 static inline void f2fs_put_page_dic(struct page *page)
                    ^~~~~~~~~~~~~~~~~
../fs/f2fs/data.c: In function ‘f2fs_handle_step_decompress’:
../fs/f2fs/data.c:241:4: error: too many arguments to function ‘f2fs_end_read_compressed_page’
    f2fs_end_read_compressed_page(page, PageError(page),
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from ../fs/f2fs/data.c:25:0:
../fs/f2fs/f2fs.h:4228:20: note: declared here
 static inline void f2fs_end_read_compressed_page(struct page *page,
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

../fs/f2fs/data.c: In function ‘f2fs_finish_read_bio’:
../fs/f2fs/data.c:138:4: error: too many arguments to function ‘f2fs_put_page_dic’
    f2fs_put_page_dic(page, in_softirq);
    ^~~~~~~~~~~~~~~~~
In file included from ../fs/f2fs/data.c:25:0:
../fs/f2fs/f2fs.h:4234:20: note: declared here
 static inline void f2fs_put_page_dic(struct page *page)
                    ^~~~~~~~~~~~~~~~~

Fixes: 1b565702dffe ("f2fs: handle decompress only post processing in softirq")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Daeho Jeong <daehojeong@google.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
---
 fs/f2fs/f2fs.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4226,11 +4226,12 @@ static inline int f2fs_init_compress_mem
 static inline void f2fs_destroy_compress_mempool(void) { }
 static inline void f2fs_decompress_cluster(struct decompress_io_ctx *dic) { }
 static inline void f2fs_end_read_compressed_page(struct page *page,
-						bool failed, block_t blkaddr)
+						bool failed, block_t blkaddr,
+						bool in_softirq)
 {
 	WARN_ON_ONCE(1);
 }
-static inline void f2fs_put_page_dic(struct page *page)
+static inline void f2fs_put_page_dic(struct page *page, bool in_softirq)
 {
 	WARN_ON_ONCE(1);
 }
