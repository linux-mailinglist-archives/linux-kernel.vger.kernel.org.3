Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0807E57D9C1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 07:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbiGVFXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 01:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGVFW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 01:22:56 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF94D868BE;
        Thu, 21 Jul 2022 22:22:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VK3pGzr_1658467343;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VK3pGzr_1658467343)
          by smtp.aliyun-inc.com;
          Fri, 22 Jul 2022 13:22:49 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: avoid potential infinite loop in __blk_mq_alloc_request
Date:   Fri, 22 Jul 2022 13:22:23 +0800
Message-Id: <1658467343-55843-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Song <liusong@linux.alibaba.com>

If "blk_mq_get_tag" returns BLK_MQ_NO_TAG because the value of
"tags->nr_reserved_tags" is 0, it will fall into an infinite loop in
"__blk_mq_alloc_requests", so borrow BLK_MQ_REQ_NOWAIT to exit the loop.

Because "blk_mq_alloc_data" objects are allocated on the stack, changing
the content of flags will not generate extra impact.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 block/blk-mq-tag.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 2dcd738..6f1d6e6 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -139,6 +139,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	if (data->flags & BLK_MQ_REQ_RESERVED) {
 		if (unlikely(!tags->nr_reserved_tags)) {
 			WARN_ON_ONCE(1);
+			data->flags |= BLK_MQ_REQ_NOWAIT;
 			return BLK_MQ_NO_TAG;
 		}
 		bt = &tags->breserved_tags;
-- 
1.8.3.1

