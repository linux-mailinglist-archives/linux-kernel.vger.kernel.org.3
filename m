Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9DF59967C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347257AbiHSHx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345865AbiHSHxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:53:54 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD36995E4C;
        Fri, 19 Aug 2022 00:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vIxxM
        CB3Kbo1suOSCWxUTAkIasvejZxcJgO9tarL/Ns=; b=GbqO1B4zTYyyEDPrv6g8m
        n57zMF3zeanLvOykEigbrMOPHAUhwfQQp/hYJ5I/vMRKnewxnXoIr3erRFi/BW/t
        VK0u0FqIL9ShetV+CUXbvWxylh6+DogXN9S3iAnLRSs7jL3tQ9ITka7aeARKoHRe
        kw0ZoP9kP+pmZX1yOgZLC0=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp2 (Coremail) with SMTP id GtxpCgCXi+dXQf9i0q+CWg--.44783S2;
        Fri, 19 Aug 2022 15:52:58 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     jack@suse.cz, axboe@kernel.dk
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH] fs/reiserfs: replace ternary operator with min() and min_t()
Date:   Fri, 19 Aug 2022 15:52:40 +0800
Message-Id: <20220819075240.3199477-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgCXi+dXQf9i0q+CWg--.44783S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr4rXFWfur1UKF47WF4UJwb_yoW5WryfpF
        4xAr18KFWDGryDWFn7Zwn8Aw1Sq3sxJa1jqrWkZrWIva93tw1fJr4fKry3KFW8trZ3Xw1S
        qr4kKr1Fy34rJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UCPfLUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbiyAVg+1p7HaIJdgABs2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix the following coccicheck warning:

fs/reiserfs/prints.c:459: WARNING opportunity for min().
fs/reiserfs/resize.c:100: WARNING opportunity for min().
fs/reiserfs/super.c:2508: WARNING opportunity for min().
fs/reiserfs/super.c:2557: WARNING opportunity for min().

min() and min_t() macro is defined in include/linux/minmax.h.
It avoids multiple evaluations of the arguments when non-constant and
performs strict type-checking.

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 fs/reiserfs/prints.c | 2 +-
 fs/reiserfs/resize.c | 2 +-
 fs/reiserfs/super.c  | 7 ++-----
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/reiserfs/prints.c b/fs/reiserfs/prints.c
index 30319dc33c18..84a194b77f19 100644
--- a/fs/reiserfs/prints.c
+++ b/fs/reiserfs/prints.c
@@ -456,7 +456,7 @@ static int print_internal(struct buffer_head *bh, int first, int last)
 		to = B_NR_ITEMS(bh);
 	} else {
 		from = first;
-		to = last < B_NR_ITEMS(bh) ? last : B_NR_ITEMS(bh);
+		to = min_t(int, last, B_NR_ITEMS(bh));
 	}
 
 	reiserfs_printk("INTERNAL NODE (%ld) contains %z\n", bh->b_blocknr, bh);
diff --git a/fs/reiserfs/resize.c b/fs/reiserfs/resize.c
index 8096c74c38ac..7b498a0d060b 100644
--- a/fs/reiserfs/resize.c
+++ b/fs/reiserfs/resize.c
@@ -97,7 +97,7 @@ int reiserfs_resize(struct super_block *s, unsigned long block_count_new)
 		 * using the copy_size var below allows this code to work for
 		 * both shrinking and expanding the FS.
 		 */
-		copy_size = bmap_nr_new < bmap_nr ? bmap_nr_new : bmap_nr;
+		copy_size = min(bmap_nr_new, bmap_nr);
 		copy_size =
 		    copy_size * sizeof(struct reiserfs_list_bitmap_node *);
 		for (i = 0; i < JOURNAL_NUM_BITMAPS; i++) {
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index c88cd2ce0665..da1e72494e30 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -2504,9 +2504,7 @@ static ssize_t reiserfs_quota_read(struct super_block *sb, int type, char *data,
 		len = i_size - off;
 	toread = len;
 	while (toread > 0) {
-		tocopy =
-		    sb->s_blocksize - offset <
-		    toread ? sb->s_blocksize - offset : toread;
+		tocopy = min_t(unsigned long, sb->s_blocksize - offset, toread);
 		tmp_bh.b_state = 0;
 		/*
 		 * Quota files are without tails so we can safely
@@ -2554,8 +2552,7 @@ static ssize_t reiserfs_quota_write(struct super_block *sb, int type,
 		return -EIO;
 	}
 	while (towrite > 0) {
-		tocopy = sb->s_blocksize - offset < towrite ?
-		    sb->s_blocksize - offset : towrite;
+		tocopy = min_t(unsigned long, sb->s_blocksize - offset, towrite);
 		tmp_bh.b_state = 0;
 		reiserfs_write_lock(sb);
 		err = reiserfs_get_block(inode, blk, &tmp_bh, GET_BLOCK_CREATE);
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

