Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43ACB54C357
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243874AbiFOISc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbiFOIS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:18:28 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBF2275DB;
        Wed, 15 Jun 2022 01:18:24 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id KGI00017;
        Wed, 15 Jun 2022 16:18:17 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2308.27; Wed, 15 Jun 2022 16:18:19 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] block: Directly use ida_alloc()/free()
Date:   Wed, 15 Jun 2022 04:18:16 -0400
Message-ID: <20220615081816.4342-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   2022615161817e7cde56c8b56f5d215d9d2f0915e296f
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ida_alloc()/ida_free() instead of
ida_simple_get()/ida_simple_remove().
The latter is deprecated and more verbose.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 block/blk-core.c  | 4 ++--
 block/blk-sysfs.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 06ff5bbfe8f6..eb86c756a7fd 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -448,7 +448,7 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
 
 	q->last_merge = NULL;
 
-	q->id = ida_simple_get(&blk_queue_ida, 0, 0, GFP_KERNEL);
+	q->id = ida_alloc(&blk_queue_ida, GFP_KERNEL);
 	if (q->id < 0)
 		goto fail_srcu;
 
@@ -498,7 +498,7 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
 fail_split:
 	bioset_exit(&q->bio_split);
 fail_id:
-	ida_simple_remove(&blk_queue_ida, q->id);
+	ida_free(&blk_queue_ida, q->id);
 fail_srcu:
 	if (alloc_srcu)
 		cleanup_srcu_struct(q->srcu);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 14607565d781..2ed9e7d52b47 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -799,7 +799,7 @@ static void blk_release_queue(struct kobject *kobj)
 	if (blk_queue_has_srcu(q))
 		cleanup_srcu_struct(q->srcu);
 
-	ida_simple_remove(&blk_queue_ida, q->id);
+	ida_free(&blk_queue_ida, q->id);
 	call_rcu(&q->rcu_head, blk_free_queue_rcu);
 }
 
-- 
2.27.0

