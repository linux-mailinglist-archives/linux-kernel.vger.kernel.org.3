Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DBC5A5D87
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiH3H71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiH3H7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:59:22 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973E1D25E7;
        Tue, 30 Aug 2022 00:59:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VNk9CQA_1661846328;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VNk9CQA_1661846328)
          by smtp.aliyun-inc.com;
          Tue, 30 Aug 2022 15:59:14 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] block: remove bio_check_ro
Date:   Tue, 30 Aug 2022 15:58:48 +0800
Message-Id: <1661846328-107799-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Song <liusong@linux.alibaba.com>

Partially revert make "bio_check_ro" only return false, and may generate
at most one warning print.

From the commit log of a32e236eb9, it has been stated that it is
compatible with the old lvm tool, so there is a high probability that
this alarm will not really be noticed, so it is better to remove it
directly.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 block/blk-core.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a0d1104..811c2dc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -487,20 +487,6 @@ static int __init fail_make_request_debugfs(void)
 late_initcall(fail_make_request_debugfs);
 #endif /* CONFIG_FAIL_MAKE_REQUEST */
 
-static inline bool bio_check_ro(struct bio *bio)
-{
-	if (op_is_write(bio_op(bio)) && bdev_read_only(bio->bi_bdev)) {
-		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
-			return false;
-		pr_warn("Trying to write to read-only block-device %pg\n",
-			bio->bi_bdev);
-		/* Older lvm-tools actually trigger this */
-		return false;
-	}
-
-	return false;
-}
-
 static noinline int should_fail_bio(struct bio *bio)
 {
 	if (should_fail_request(bdev_whole(bio->bi_bdev), bio->bi_iter.bi_size))
@@ -722,8 +708,7 @@ void submit_bio_noacct(struct bio *bio)
 
 	if (should_fail_bio(bio))
 		goto end_io;
-	if (unlikely(bio_check_ro(bio)))
-		goto end_io;
+
 	if (!bio_flagged(bio, BIO_REMAPPED)) {
 		if (unlikely(bio_check_eod(bio)))
 			goto end_io;
-- 
1.8.3.1

