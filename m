Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8CF579722
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbiGSKCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbiGSKBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:01:43 -0400
X-Greylist: delayed 14445 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Jul 2022 03:01:32 PDT
Received: from smtp.smtpout.orange.fr (smtp-11.smtpout.orange.fr [80.12.242.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281E837FB1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:01:31 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id Dk2foAsyDdt6qDk2foOVNb; Tue, 19 Jul 2022 12:01:30 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 19 Jul 2022 12:01:30 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        ocfs2-devel@oss.oracle.com
Subject: [PATCH 1/3] ocfs2: Remove some useless functions
Date:   Tue, 19 Jul 2022 12:01:23 +0200
Message-Id: <bd6796635e58f9c47cf857573c3b9474a00ce26a.1658224839.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__ocfs2_node_map_set_bit() and __ocfs2_node_map_set_bit() are just
wrapper around set_bit() and clear_bit().

The leading __ also makes think that these functions are non-atomic just
like __set_bit() and __clear_bit().

So, just remove these wrappers and call set_bit() and clear_bit()
directly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/ocfs2/heartbeat.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/fs/ocfs2/heartbeat.c b/fs/ocfs2/heartbeat.c
index 9099d8fc7599..1d72e0788943 100644
--- a/fs/ocfs2/heartbeat.c
+++ b/fs/ocfs2/heartbeat.c
@@ -24,11 +24,6 @@
 
 #include "buffer_head_io.h"
 
-static inline void __ocfs2_node_map_set_bit(struct ocfs2_node_map *map,
-					    int bit);
-static inline void __ocfs2_node_map_clear_bit(struct ocfs2_node_map *map,
-					      int bit);
-
 /* special case -1 for now
  * TODO: should *really* make sure the calling func never passes -1!!  */
 static void ocfs2_node_map_init(struct ocfs2_node_map *map)
@@ -65,12 +60,6 @@ void ocfs2_do_node_down(int node_num, void *data)
 	ocfs2_recovery_thread(osb, node_num);
 }
 
-static inline void __ocfs2_node_map_set_bit(struct ocfs2_node_map *map,
-					    int bit)
-{
-	set_bit(bit, map->map);
-}
-
 void ocfs2_node_map_set_bit(struct ocfs2_super *osb,
 			    struct ocfs2_node_map *map,
 			    int bit)
@@ -79,16 +68,10 @@ void ocfs2_node_map_set_bit(struct ocfs2_super *osb,
 		return;
 	BUG_ON(bit >= map->num_nodes);
 	spin_lock(&osb->node_map_lock);
-	__ocfs2_node_map_set_bit(map, bit);
+	set_bit(bit, map->map);
 	spin_unlock(&osb->node_map_lock);
 }
 
-static inline void __ocfs2_node_map_clear_bit(struct ocfs2_node_map *map,
-					      int bit)
-{
-	clear_bit(bit, map->map);
-}
-
 void ocfs2_node_map_clear_bit(struct ocfs2_super *osb,
 			      struct ocfs2_node_map *map,
 			      int bit)
@@ -97,7 +80,7 @@ void ocfs2_node_map_clear_bit(struct ocfs2_super *osb,
 		return;
 	BUG_ON(bit >= map->num_nodes);
 	spin_lock(&osb->node_map_lock);
-	__ocfs2_node_map_clear_bit(map, bit);
+	clear_bit(bit, map->map);
 	spin_unlock(&osb->node_map_lock);
 }
 
-- 
2.34.1

