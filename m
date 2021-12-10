Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A6846F9DF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 05:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbhLJEd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 23:33:58 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:27244 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbhLJEd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 23:33:57 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20211210043021epoutp0227dcb7992626727588344e5fa7ef838e~-Sm0DnDsP1464614646epoutp02a
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 04:30:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20211210043021epoutp0227dcb7992626727588344e5fa7ef838e~-Sm0DnDsP1464614646epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639110621;
        bh=1WQr2Y8MYF8sruKFGR4d/7BNH/yybB1i3l0gwdtfDnk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Mn7d4ifTmgcBA7+68+ktdtCnXsp2YtDEvia19mmaYKqnNerRyklQ1adysSObstEBW
         dwcsewaC+q70hyDlMPifSRYWy6+uBIKA0BmgHVhC5Smnnlwpg16BnPSb1Ddmu4yMWR
         YjOD6/l42nIampYBXWEWJiL+bg6IR6/YkiHD/BVY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211210043021epcas1p1fd07cfb709c731555a12b627fef979ea~-SmzqMNbl3148531485epcas1p1Z;
        Fri, 10 Dec 2021 04:30:21 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.248]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4J9Hy33PLKz4x9Pr; Fri, 10 Dec
        2021 04:30:19 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.EC.28648.9D7D2B16; Fri, 10 Dec 2021 13:30:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211210043017epcas1p38cc53389a50e33752e97618498b18f33~-SmwezbV70559705597epcas1p3a;
        Fri, 10 Dec 2021 04:30:17 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211210043017epsmtrp117479785bcd9d7f120ca356b2ee1bad6~-SmweBAU52262922629epsmtrp1a;
        Fri, 10 Dec 2021 04:30:17 +0000 (GMT)
X-AuditID: b6c32a39-ff1ff70000006fe8-33-61b2d7d9ba62
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.3C.08738.9D7D2B16; Fri, 10 Dec 2021 13:30:17 +0900 (KST)
Received: from hj514.kim-office (unknown [10.253.100.146]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211210043017epsmtip134b602642ef91a994b9a41d935b099b5~-SmwUuJtp1241312413epsmtip1S;
        Fri, 10 Dec 2021 04:30:17 +0000 (GMT)
From:   Hyeong-Jun Kim <hj514.kim@samsung.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Hyeong-Jun Kim <hj514.kim@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Youngjin Gil <youngjin.gil@samsung.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: compress: fix potential deadlock of compress file
Date:   Fri, 10 Dec 2021 13:30:12 +0900
Message-Id: <20211210043012.180588-1-hj514.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmnu7N65sSDdY1G1ucnnqWyWJ6x0E2
        iyfrZzFbXFrkbnF51xw2iy3/jrBazNj/lN2B3WPTqk42j90LPjN59G1ZxejxeZNcAEtUtk1G
        amJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0AFKCmWJOaVA
        oYDE4mIlfTubovzSklSFjPziElul1IKUnAKzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyML6eW
        MRa8kK+4OHMXYwNjg0QXIyeHhICJxIemi0xdjFwcQgI7GCWur/jECJIQEvjEKDG5nRMi8ZlR
        ov/BNnaYjoknTzNBFO1ilLizLAOi6D2jxPr7p5hBEmwCOhIfZq0EmyQiYC/x+ft1FpAiZoEj
        jBLrvk0GmsTBISzgIbF3nT5IDYuAqsTMp1fAenkFrCVm9L1ghlgmLzHz0nd2iLigxMmZT1hA
        bGagePPW2cwgMyUETrFLHL+wGuo6F4nPG/8wQdjCEq+Ob4GKS0m87G+Dsusljl/5xArR3MIo
        8XjpK0aQgySALn1/yQLEZBbQlFi/Sx+iXFFi5++5jBB7+STefe1hhajmlehoE4IoUZbYfPcw
        G4QtKfF00V9GCNtD4uzNlayQsIqVWLDnP9sERvlZSL6ZheSbWQiLFzAyr2IUSy0ozk1PLTYs
        MIXHaXJ+7iZGcBLUstzBOP3tB71DjEwcjIcYJTiYlUR4b1zdmCjEm5JYWZValB9fVJqTWnyI
        0RQYvhOZpUST84FpOK8k3tDE0sDEzMjEwtjS2ExJnPe5//REIYH0xJLU7NTUgtQimD4mDk6p
        BiZ7sTlFE17saXk9UduwuOFzwbnAgiuKr3zsQzqmti/6cK+/KVbJNeYQ35WCvcIhji8TL86w
        49ilqMBx/unxtKaVXrJZyZFWx2wP8LNe1PXr3y+13riGWXaPrm92kBXjBz2FRY7m/HGrL7AK
        5Vnz/fnuVm7uu/xByLqEu25ucYfPeIZXeR8V+VnNEnh4yg29qCef+nsXTFeQ25UkYbtnh7Of
        1h+/uSJ6hz6ybpaYbb38Fuddb5f1IrM32N3RdBP5npZSMWGb6csn1odOCwu8PtPO/f3wu0cT
        Pp2d/VBU/c+/Ex803bMPca7wN4kzfvtky0HunMv18uk+fG5NEUb1tzQ2CUrPqVyff6/W6pf9
        XyWW4oxEQy3mouJEAGnM3OkLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsWy7bCSnO7N65sSDQ4ul7c4PfUsk8X0joNs
        Fk/Wz2K2uLTI3eLyrjlsFlv+HWG1mLH/KbsDu8emVZ1sHrsXfGby6NuyitHj8ya5AJYoLpuU
        1JzMstQifbsErowvp5YxFryQr7g4cxdjA2ODRBcjJ4eEgInExJOnmboYuTiEBHYwSrStms3c
        xcgBlJCUmLe+HMIUljh8uBii5C2jxMS/Z1lAetkEdCQ+zFrJCGKLCDhK/Hq9iBWkiFngBKNE
        8+NfjCDNwgIeEnvX6YPUsAioSsx8eoUZxOYVsJaY0feCGeIGeYmZl76zQ8QFJU7OfAI2nxko
        3rx1NvMERr5ZSFKzkKQWMDKtYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIDkstrR2M
        e1Z90DvEyMTBeIhRgoNZSYT3xtWNiUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8s
        Sc1OTS1ILYLJMnFwSjUw7floEalm+0NRM179FeO65LJENYmKzllKa9OPcj2T5L2056zWU6kF
        PIk+1+ucPst/vfxT5ek/eZaG9W9enI0+P2PnOcPrN2UPXH7QpRu2I43789ojSi0eMpd2/7rw
        tyK4sz6B55zi/ORHP/cY3XXYx3Ry8sK1jTc4bFL0TYsL4kxO9XvP/Vpv5bi3dtfCL1rnpy/q
        lX5/4OHU1c/Tsyd0r5KvbtY9UbNAV+Fu+BvR1g+L20onH0l8uu3dofWM/1dxf5M8HGT+oiWi
        YmXM8VuGTexF092ZvvN+WCzNUJqR2BO84HxklPWcQymPQk6whJfkbP276lDp28dK76PWKTjk
        u/dMEWhNfrTfUHLO5t+1N5VYijMSDbWYi4oTAcEwqg66AgAA
X-CMS-MailID: 20211210043017epcas1p38cc53389a50e33752e97618498b18f33
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211210043017epcas1p38cc53389a50e33752e97618498b18f33
References: <CGME20211210043017epcas1p38cc53389a50e33752e97618498b18f33@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential deadlock between writeback process and a process
performing write_begin() or write_cache_pages() while trying to write
same compress file, but not compressable, as below:

[Process A] - doing checkpoint
[Process B]                     [Process C]
f2fs_write_cache_pages()
- lock_page() [all pages in cluster, 0-31]
- f2fs_write_multi_pages()
 - f2fs_write_raw_pages()
  - f2fs_write_single_data_page()
   - f2fs_do_write_data_page()
     - return -EAGAIN [f2fs_trylock_op() failed]
   - unlock_page(page) [e.g., page 0]
                                - generic_perform_write()
                                 - f2fs_write_begin()
                                  - f2fs_prepare_compress_overwrite()
                                   - prepare_compress_overwrite()
                                    - lock_page() [e.g., page 0]
                                    - lock_page() [e.g., page 1]
   - lock_page(page) [e.g., page 0]

Since there is no compress process, it is no longer necessary to hold
locks on every pages in cluster within f2fs_write_raw_pages().

This patch changes f2fs_write_raw_pages() to release all locks first
and then perform write same as the non-compress file in
f2fs_write_cache_pages().

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Hyeong-Jun Kim <hj514.kim@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Youngjin Gil <youngjin.gil@samsung.com>
---
 fs/f2fs/compress.c | 50 ++++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 7588e4e817b8..5aae63b5eb5c 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1467,25 +1467,38 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 					enum iostat_type io_type)
 {
 	struct address_space *mapping = cc->inode->i_mapping;
-	int _submitted, compr_blocks, ret;
-	int i = -1, err = 0;
+	int _submitted, compr_blocks, ret, i;
 
 	compr_blocks = f2fs_compressed_blocks(cc);
-	if (compr_blocks < 0) {
-		err = compr_blocks;
-		goto out_err;
+
+	for (i = 0; i < cc->cluster_size; i++) {
+		if (!cc->rpages[i])
+			continue;
+
+		redirty_page_for_writepage(wbc, cc->rpages[i]);
+		unlock_page(cc->rpages[i]);
 	}
 
+	if (compr_blocks < 0)
+		return compr_blocks;
+
 	for (i = 0; i < cc->cluster_size; i++) {
 		if (!cc->rpages[i])
 			continue;
 retry_write:
+		lock_page(cc->rpages[i]);
+
 		if (cc->rpages[i]->mapping != mapping) {
+continue_unlock:
 			unlock_page(cc->rpages[i]);
 			continue;
 		}
 
-		BUG_ON(!PageLocked(cc->rpages[i]));
+		if (!PageDirty(cc->rpages[i]))
+			goto continue_unlock;
+
+		if (!clear_page_dirty_for_io(cc->rpages[i]))
+			goto continue_unlock;
 
 		ret = f2fs_write_single_data_page(cc->rpages[i], &_submitted,
 						NULL, NULL, wbc, io_type,
@@ -1500,26 +1513,15 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 				 * avoid deadlock caused by cluster update race
 				 * from foreground operation.
 				 */
-				if (IS_NOQUOTA(cc->inode)) {
-					err = 0;
-					goto out_err;
-				}
+				if (IS_NOQUOTA(cc->inode))
+					return 0;
 				ret = 0;
 				cond_resched();
 				congestion_wait(BLK_RW_ASYNC,
 						DEFAULT_IO_TIMEOUT);
-				lock_page(cc->rpages[i]);
-
-				if (!PageDirty(cc->rpages[i])) {
-					unlock_page(cc->rpages[i]);
-					continue;
-				}
-
-				clear_page_dirty_for_io(cc->rpages[i]);
 				goto retry_write;
 			}
-			err = ret;
-			goto out_err;
+			return ret;
 		}
 
 		*submitted += _submitted;
@@ -1528,14 +1530,6 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 	f2fs_balance_fs(F2FS_M_SB(mapping), true);
 
 	return 0;
-out_err:
-	for (++i; i < cc->cluster_size; i++) {
-		if (!cc->rpages[i])
-			continue;
-		redirty_page_for_writepage(wbc, cc->rpages[i]);
-		unlock_page(cc->rpages[i]);
-	}
-	return err;
 }
 
 int f2fs_write_multi_pages(struct compress_ctx *cc,
-- 
2.25.1

