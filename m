Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A8B469588
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242997AbhLFMVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:21:10 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:45257 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243026AbhLFMUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:20:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UzdSTBP_1638793027;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UzdSTBP_1638793027)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 Dec 2021 20:17:16 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] erofs: Replace zero-length array with flexible-array member
Date:   Mon,  6 Dec 2021 20:17:02 +0800
Message-Id: <20211206121702.221331-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a regular need in the kernel to provide a way to declare
having a dynamically sized set of trailing elements in a structure.

Kernel code should always use `flexible array members' [1] for these
cases. The older style of one-element or zero-length arrays should
no longer be used [2].

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.15/process/deprecated.html#zero-length-and-one-element-arrays

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index f4506a642a12..dda79afb901d 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -209,7 +209,7 @@ struct erofs_xattr_ibody_header {
 	__le32 h_reserved;
 	__u8   h_shared_count;
 	__u8   h_reserved2[7];
-	__le32 h_shared_xattrs[0];      /* shared xattr id array */
+	__le32 h_shared_xattrs[];       /* shared xattr id array */
 };
 
 /* Name indexes */
@@ -226,7 +226,7 @@ struct erofs_xattr_entry {
 	__u8   e_name_index;    /* attribute name index */
 	__le16 e_value_size;    /* size of attribute value */
 	/* followed by e_name and e_value */
-	char   e_name[0];       /* attribute name */
+	char   e_name[];        /* attribute name */
 };
 
 static inline unsigned int erofs_xattr_ibody_size(__le16 i_xattr_icount)
-- 
2.24.4

