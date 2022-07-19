Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C17B579724
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbiGSKCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbiGSKCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:02:00 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339503B972
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:01:43 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id Dk2qo321pxaQ2Dk2roiSAR; Tue, 19 Jul 2022 12:01:41 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 19 Jul 2022 12:01:41 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        ocfs2-devel@oss.oracle.com
Subject: [PATCH 2/3] ocfs2: Remove a useless spinlock
Date:   Tue, 19 Jul 2022 12:01:35 +0200
Message-Id: <8ba7004d330cbe5f626539a8a3bff696d0c4285e.1658224839.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <bd6796635e58f9c47cf857573c3b9474a00ce26a.1658224839.git.christophe.jaillet@wanadoo.fr>
References: <bd6796635e58f9c47cf857573c3b9474a00ce26a.1658224839.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'node_map_lock' is a spinlock only used to protect calls to set_bit(),
clear_bit() and test_bit().

{set|clear}_bit() are already atomic and don't need this extra spinlock.
test_bit() only reads the bitmap for a given bit.

Remove this useless spinlock.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
test_bit() is NOT documented as an atomic function. However, I can't see
how it could return a wrong result here.

So review with care. There is maybe something I don't think about that is
lurking here.
---
 fs/ocfs2/heartbeat.c | 11 ++++-------
 fs/ocfs2/ocfs2.h     |  2 --
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/ocfs2/heartbeat.c b/fs/ocfs2/heartbeat.c
index 1d72e0788943..4863ad35c242 100644
--- a/fs/ocfs2/heartbeat.c
+++ b/fs/ocfs2/heartbeat.c
@@ -35,7 +35,6 @@ static void ocfs2_node_map_init(struct ocfs2_node_map *map)
 
 void ocfs2_init_node_maps(struct ocfs2_super *osb)
 {
-	spin_lock_init(&osb->node_map_lock);
 	ocfs2_node_map_init(&osb->osb_recovering_orphan_dirs);
 }
 
@@ -67,9 +66,8 @@ void ocfs2_node_map_set_bit(struct ocfs2_super *osb,
 	if (bit==-1)
 		return;
 	BUG_ON(bit >= map->num_nodes);
-	spin_lock(&osb->node_map_lock);
+
 	set_bit(bit, map->map);
-	spin_unlock(&osb->node_map_lock);
 }
 
 void ocfs2_node_map_clear_bit(struct ocfs2_super *osb,
@@ -79,9 +77,8 @@ void ocfs2_node_map_clear_bit(struct ocfs2_super *osb,
 	if (bit==-1)
 		return;
 	BUG_ON(bit >= map->num_nodes);
-	spin_lock(&osb->node_map_lock);
+
 	clear_bit(bit, map->map);
-	spin_unlock(&osb->node_map_lock);
 }
 
 int ocfs2_node_map_test_bit(struct ocfs2_super *osb,
@@ -89,13 +86,13 @@ int ocfs2_node_map_test_bit(struct ocfs2_super *osb,
 			    int bit)
 {
 	int ret;
+
 	if (bit >= map->num_nodes) {
 		mlog(ML_ERROR, "bit=%d map->num_nodes=%d\n", bit, map->num_nodes);
 		BUG();
 	}
-	spin_lock(&osb->node_map_lock);
+
 	ret = test_bit(bit, map->map);
-	spin_unlock(&osb->node_map_lock);
 	return ret;
 }
 
diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
index 740b64238312..1df193b97c30 100644
--- a/fs/ocfs2/ocfs2.h
+++ b/fs/ocfs2/ocfs2.h
@@ -302,8 +302,6 @@ struct ocfs2_super
 
 	u32 *slot_recovery_generations;
 
-	spinlock_t node_map_lock;
-
 	u64 root_blkno;
 	u64 system_dir_blkno;
 	u64 bitmap_blkno;
-- 
2.34.1

