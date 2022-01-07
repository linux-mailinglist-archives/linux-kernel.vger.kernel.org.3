Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3998486F1B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344646AbiAGAwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:52:35 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:44653 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344587AbiAGAwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:52:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V17mLiK_1641516750;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V17mLiK_1641516750)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Jan 2022 08:52:31 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] block: fix old-style declaration
Date:   Fri,  7 Jan 2022 08:52:28 +0800
Message-Id: <20220107005228.103927-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the 'inline' keyword to the front of 'void'.

Remove a warning found by clang(make W=1 LLVM=1)
./include/linux/blk-mq.h:259:1: warning: ‘inline’ is not at beginning of
declaration

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 include/linux/blk-mq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index f40a05ecca4a..d319ffa59354 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -256,7 +256,7 @@ static inline unsigned short req_get_ioprio(struct request *req)
  * @rq: The request to move
  * @prev: The request preceding @rq in @src (NULL if @rq is the head)
  */
-static void inline rq_list_move(struct request **src, struct request **dst,
+static inline void rq_list_move(struct request **src, struct request **dst,
 				struct request *rq, struct request *prev)
 {
 	if (prev)
-- 
2.20.1.7.g153144c

