Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F99E56B6F0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbiGHKKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbiGHKKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:10:10 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A73083F3C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 03:10:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VIj9CqI_1657275002;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VIj9CqI_1657275002)
          by smtp.aliyun-inc.com;
          Fri, 08 Jul 2022 18:10:07 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Liu Jinbao <liujinbao1@xiaomi.com>
Subject: [PATCH] erofs: avoid consecutive detection for Highmem memory
Date:   Fri,  8 Jul 2022 18:10:01 +0800
Message-Id: <20220708101001.21242-1-hsiangkao@linux.alibaba.com>
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

Currently, vmap()s are avoided if physical addresses are
consecutive for decompressed buffers.

I observed that is very common for 4KiB pclusters since the
numbers of decompressed pages are almost 2 or 3.

However, such detection doesn't work for Highmem pages on
32-bit machines, let's fix it now.

Reported-by: Liu Jinbao <liujinbao1@xiaomi.com>
Fixes: 7fc45dbc938a ("staging: erofs: introduce generic decompression backend")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 6dca1900c733..45be8f4aeb68 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -91,14 +91,18 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
 
 		if (page) {
 			__clear_bit(j, bounced);
-			if (kaddr) {
-				if (kaddr + PAGE_SIZE == page_address(page))
+			if (!PageHighMem(page)) {
+				if (!i) {
+					kaddr = page_address(page);
+					continue;
+				}
+				if (kaddr &&
+				    kaddr + PAGE_SIZE == page_address(page)) {
 					kaddr += PAGE_SIZE;
-				else
-					kaddr = NULL;
-			} else if (!i) {
-				kaddr = page_address(page);
+					continue;
+				}
 			}
+			kaddr = NULL;
 			continue;
 		}
 		kaddr = NULL;
-- 
2.24.4

