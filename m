Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29B854E0DE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376777AbiFPMcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 08:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiFPMcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:32:51 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8748B1CFC4;
        Thu, 16 Jun 2022 05:32:48 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 25GCUq8Y095041
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Thu, 16 Jun 2022 20:30:52 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 16 Jun 2022 20:30:53 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ke.wang@unisoc.com>
Subject: [RFC PATCHv2] block: set bdi congested when no tag available
Date:   Thu, 16 Jun 2022 20:30:31 +0800
Message-ID: <1655382631-3037-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 25GCUq8Y095041
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

In previous version, block layer will set bdi to be congested when
get_request fail, which may throttle direct_reclaim. Move them back
under current blk-mq design.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
v2: simplify the code
---
---
 block/blk-mq-tag.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 995336a..0cbc445 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -11,6 +11,7 @@
 
 #include <linux/blk-mq.h>
 #include <linux/delay.h>
+#include <linux/backing-dev.h>
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-sched.h"
@@ -126,6 +127,8 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	if (tag != BLK_MQ_NO_TAG)
 		goto found_tag;
 
+	set_bdi_congested(data->q->disk->bdi,BLK_RW_SYNC);
+	set_bdi_congested(data->q->disk->bdi,BLK_RW_ASYNC);
 	if (data->flags & BLK_MQ_REQ_NOWAIT)
 		return BLK_MQ_NO_TAG;
 
@@ -190,6 +193,8 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		blk_mq_put_tag(tags, data->ctx, tag + tag_offset);
 		return BLK_MQ_NO_TAG;
 	}
+	clear_bdi_congested(data->q->disk->bdi,BLK_RW_SYNC);
+	clear_bdi_congested(data->q->disk->bdi,BLK_RW_ASYNC);
 	return tag + tag_offset;
 }
 
-- 
1.9.1

