Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EA047E939
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 22:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350392AbhLWVzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 16:55:48 -0500
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:49408 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhLWVzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 16:55:41 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 0W3lnGyoSbyf90W3lnnXk1; Thu, 23 Dec 2021 22:55:40 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 23 Dec 2021 22:55:40 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     axboe@kernel.dk, chaitanya.kulkarni@wdc.com, damien.lemoal@wdc.com,
        ming.lei@redhat.com, Johannes.Thumshirn@wdc.com,
        shinichiro.kawasaki@wdc.com, jiangguoqing@kylinos.cn
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] null_blk: Use bitmap_zalloc() when applicable
Date:   Thu, 23 Dec 2021 22:55:36 +0100
Message-Id: <3e68598defed010efb864ea55887d88ed0da02cc.1640296433.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'nq->tag_map' is a bitmap. So use bitmap_zalloc() to simplify code and
improve the semantic.

Also change the corresponding kfree() into bitmap_free() to keep
consistency.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/block/null_blk/main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 6be6ccd4a28f..9e058e0aa668 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1661,7 +1661,7 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 static void cleanup_queue(struct nullb_queue *nq)
 {
-	kfree(nq->tag_map);
+	bitmap_free(nq->tag_map);
 	kfree(nq->cmds);
 }
 
@@ -1790,14 +1790,13 @@ static const struct block_device_operations null_rq_ops = {
 static int setup_commands(struct nullb_queue *nq)
 {
 	struct nullb_cmd *cmd;
-	int i, tag_size;
+	int i;
 
 	nq->cmds = kcalloc(nq->queue_depth, sizeof(*cmd), GFP_KERNEL);
 	if (!nq->cmds)
 		return -ENOMEM;
 
-	tag_size = ALIGN(nq->queue_depth, BITS_PER_LONG) / BITS_PER_LONG;
-	nq->tag_map = kcalloc(tag_size, sizeof(unsigned long), GFP_KERNEL);
+	nq->tag_map = bitmap_zalloc(nq->queue_depth, GFP_KERNEL);
 	if (!nq->tag_map) {
 		kfree(nq->cmds);
 		return -ENOMEM;
-- 
2.32.0

