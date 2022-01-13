Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2695048D1D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 06:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiAMFSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 00:18:53 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:41620 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229456AbiAMFSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 00:18:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V1i7JHA_1642051126;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V1i7JHA_1642051126)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Jan 2022 13:18:50 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: fix fsdax partition offset handling
Date:   Thu, 13 Jan 2022 13:18:45 +0800
Message-Id: <20220113051845.244461-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After seeking time on testing today upstream fsdax, I found it
actually doesn't work well as below:

[  186.492983] ------------[ cut here ]------------
[  186.493629] WARNING: CPU: 1 PID: 205 at fs/iomap/iter.c:33 iomap_iter+0x2f6/0x310

The problem is that m_dax_part_off should be applied to physical
addresses and very sorry about that I didn't catch this eariler.

Anyway, let's fix it up now. Also, I need to find a way to set up
a standalone testcase to look after this later.

Fixes: de2051147771 ("fsdax: shift partition offset handling into the file systems")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index fa7ddb7ad980..226a57c57ee6 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -252,12 +252,10 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		return ret;
 
 	iomap->offset = map.m_la;
-	if (flags & IOMAP_DAX) {
+	if (flags & IOMAP_DAX)
 		iomap->dax_dev = mdev.m_daxdev;
-		iomap->offset += mdev.m_dax_part_off;
-	} else {
+	else
 		iomap->bdev = mdev.m_bdev;
-	}
 	iomap->length = map.m_llen;
 	iomap->flags = 0;
 	iomap->private = NULL;
@@ -284,6 +282,8 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	} else {
 		iomap->type = IOMAP_MAPPED;
 		iomap->addr = mdev.m_pa;
+		if (flags & IOMAP_DAX)
+			iomap->addr += mdev.m_dax_part_off;
 	}
 	return 0;
 }
-- 
2.24.4

