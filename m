Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A5E55FFAB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiF2MQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiF2MQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:16:20 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF35B31385
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:16:12 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 398E61E80D50;
        Wed, 29 Jun 2022 20:14:59 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3bFxVlbecXPS; Wed, 29 Jun 2022 20:14:56 +0800 (CST)
Received: from localhost.localdomain (unknown [112.65.12.78])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 5E0DC1E80D11;
        Wed, 29 Jun 2022 20:14:56 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     dushistov@mail.ru
Cc:     linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com, Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] fs: Add space after ',' and Fix typo
Date:   Wed, 29 Jun 2022 20:16:06 +0800
Message-Id: <20220629121606.9727-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add blank space after ','.
Change 'maped' to 'mapped'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 fs/ufs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index a873de7dec1c..3265ab820815 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -54,7 +54,7 @@ static int ufs_block_to_path(struct inode *inode, sector_t i_block, unsigned off
 	int n = 0;
 
 
-	UFSD("ptrs=uspi->s_apb = %d,double_blocks=%ld \n",ptrs,double_blocks);
+	UFSD("ptrs=uspi->s_apb = %d, double_blocks=%ld \n", ptrs, double_blocks);
 	if (i_block < direct_blocks) {
 		offsets[n++] = i_block;
 	} else if ((i_block -= direct_blocks) < indirect_blocks) {
@@ -469,7 +469,7 @@ static int ufs_getfrag_block(struct inode *inode, sector_t fragment, struct buff
 
 static int ufs_writepage(struct page *page, struct writeback_control *wbc)
 {
-	return block_write_full_page(page,ufs_getfrag_block,wbc);
+	return block_write_full_page(page, ufs_getfrag_block, wbc);
 }
 
 static int ufs_read_folio(struct file *file, struct folio *folio)
@@ -521,7 +521,7 @@ static int ufs_write_end(struct file *file, struct address_space *mapping,
 
 static sector_t ufs_bmap(struct address_space *mapping, sector_t block)
 {
-	return generic_block_bmap(mapping,block,ufs_getfrag_block);
+	return generic_block_bmap(mapping, block, ufs_getfrag_block);
 }
 
 const struct address_space_operations ufs_aops = {
@@ -1088,7 +1088,7 @@ static int ufs_alloc_lastblock(struct inode *inode, loff_t size)
 	       clean_bdev_bh_alias(bh);
 	       /*
 		* we do not zeroize fragment, because of
-		* if it maped to hole, it already contains zeroes
+		* if it mapped to hole, it already contains zeroes
 		*/
 	       set_buffer_uptodate(bh);
 	       mark_buffer_dirty(bh);
-- 
2.25.1

