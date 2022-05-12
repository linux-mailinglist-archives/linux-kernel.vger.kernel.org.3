Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405D1524C38
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353473AbiELL6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344488AbiELL6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:58:44 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC6E8FD40
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:58:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VD-jm4z_1652356714;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VD-jm4z_1652356714)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 May 2022 19:58:40 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@yulong.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: fix buffer copy overflow of ztailpacking feature
Date:   Thu, 12 May 2022 19:58:33 +0800
Message-Id: <20220512115833.24175-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got some KASAN report as below:

[   46.959738] ==================================================================
[   46.960430] BUG: KASAN: use-after-free in z_erofs_shifted_transform+0x2bd/0x370
[   46.960430] Read of size 4074 at addr ffff8880300c2f8e by task fssum/188
...
[   46.960430] Call Trace:
[   46.960430]  <TASK>
[   46.960430]  dump_stack_lvl+0x41/0x5e
[   46.960430]  print_report.cold+0xb2/0x6b7
[   46.960430]  ? z_erofs_shifted_transform+0x2bd/0x370
[   46.960430]  kasan_report+0x8a/0x140
[   46.960430]  ? z_erofs_shifted_transform+0x2bd/0x370
[   46.960430]  kasan_check_range+0x14d/0x1d0
[   46.960430]  memcpy+0x20/0x60
[   46.960430]  z_erofs_shifted_transform+0x2bd/0x370
[   46.960430]  z_erofs_decompress_pcluster+0xaae/0x1080

The root cause is that the tail pcluster won't be a complete filesystem
block anymore. So if ztailpacking is used, the second part of an
uncompresed tail pcluster may not be ``rq->pageofs_out``.

Fixes: ab749badf9f4 ("erofs: support unaligned data decompression")
Fixes: cecf864d3d76 ("erofs: support inline data decompression")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 0f445f7e1df8..6dca1900c733 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -320,6 +320,7 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
 	const unsigned int righthalf = min_t(unsigned int, rq->outputsize,
 					     PAGE_SIZE - rq->pageofs_out);
+	const unsigned int lefthalf = rq->outputsize - righthalf;
 	unsigned char *src, *dst;
 
 	if (nrpages_out > 2) {
@@ -342,10 +343,10 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 	if (nrpages_out == 2) {
 		DBG_BUGON(!rq->out[1]);
 		if (rq->out[1] == *rq->in) {
-			memmove(src, src + righthalf, rq->pageofs_out);
+			memmove(src, src + righthalf, lefthalf);
 		} else {
 			dst = kmap_atomic(rq->out[1]);
-			memcpy(dst, src + righthalf, rq->pageofs_out);
+			memcpy(dst, src + righthalf, lefthalf);
 			kunmap_atomic(dst);
 		}
 	}
-- 
2.24.4

