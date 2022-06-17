Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1687954EF9E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 05:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379913AbiFQDEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 23:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379532AbiFQDEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 23:04:09 -0400
Received: from p3plwbeout12-05.prod.phx3.secureserver.net (p3plsmtp12-05-2.prod.phx3.secureserver.net [173.201.192.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AF066229
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 20:04:05 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.142])
        by :WBEOUT: with ESMTP
        id 22HEoNdiiOWGS22HEogv9B; Thu, 16 Jun 2022 20:04:05 -0700
X-CMAE-Analysis: v=2.4 cv=EsoXEQQA c=1 sm=1 tr=0 ts=62abef25
 a=s1hRAmXuQnGNrIj+3lWWVA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=JPEYwPQDsx4A:10 a=FXvPX3liAAAA:8 a=Lo680ACL7Cit5IcG_IsA:9
 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  22HEoNdiiOWGS
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=localhost.localdomain)
        by smtp11.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1o22HD-0005dm-Ey; Fri, 17 Jun 2022 04:04:03 +0100
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     hsinyi@chromium.org
Cc:     Xiongwei.Song@windriver.com, akpm@linux-foundation.org,
        houtao1@huawei.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, m.szyprowski@samsung.com, miaoxie@huawei.com,
        phillip@squashfs.org.uk, squashfs-devel@lists.sourceforge.net,
        willy@infradead.org, yi.zhang@huawei.com, zhengliang6@huawei.com
Subject: [PATCH 4/3] squashfs: support reading fragments in readahead call
Date:   Fri, 17 Jun 2022 04:03:45 +0100
Message-Id: <20220617030345.24712-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220613082802.1301238-4-hsinyi@chromium.org>
References: <20220613082802.1301238-4-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfPiCow8nZGMKKRlPN9OwHQz0KMzh7h8PcNhfepBHfmiPhQLHMBxsruJkRyHbwga5WDPzKqxreM5NLdlZNkI3Vh6XtkqMWdXxIkF+2uLfxN9iygTzveD1
 6V5GcNXYWk/gbEmuX4sc7jY0U3Qj+AmjuELXv24LY87a7bQy75zODR3dYX0Hb1GKW+gdCmksOkTFLiHTA9xgqYIxYKF2mfwmzaE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a function which can be used to read fragments in the
readahead call.

This function is necessary because filesystems built with the -tailends
(or -always-use-fragments) option may have fragments present which
cannot be currently handled.

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/file.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index f0c64ee272d5..3a4cce16d7da 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -497,6 +497,41 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 	return res;
 }
 
+static unsigned int squashfs_readahead_fragment(struct page **page,
+	unsigned int pages, unsigned int expected)
+{
+	struct inode *inode = page[0]->mapping->host;
+	struct squashfs_cache_entry *buffer = squashfs_get_fragment(inode->i_sb,
+		squashfs_i(inode)->fragment_block,
+		squashfs_i(inode)->fragment_size);
+	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
+	unsigned int n, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
+
+	if (buffer->error)
+		goto out;
+
+	expected += squashfs_i(inode)->fragment_offset;
+
+	for (n = 0; n < pages; n++) {
+		unsigned int base = (page[n]->index & mask) << PAGE_SHIFT;
+		unsigned int offset = base + squashfs_i(inode)->fragment_offset;
+
+		if (expected > offset) {
+			unsigned int avail = min_t(unsigned int, expected -
+				offset, PAGE_SIZE);
+
+			squashfs_fill_page(page[n], buffer, offset, avail);
+		}
+
+		unlock_page(page[n]);
+		put_page(page[n]);
+	}
+
+out:
+	squashfs_cache_put(buffer);
+	return buffer->error;
+}
+
 static void squashfs_readahead(struct readahead_control *ractl)
 {
 	struct inode *inode = ractl->mapping->host;
-- 
2.34.1

