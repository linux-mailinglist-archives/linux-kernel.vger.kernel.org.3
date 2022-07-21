Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759C057D516
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiGUUtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiGUUtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:49:33 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729548FD74
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 13:49:32 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id Ed6uo8JLSQUcTEd6vof0bm; Thu, 21 Jul 2022 22:49:31 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 21 Jul 2022 22:49:31 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     akpm@linux-foundation.org, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        ocfs2-devel@oss.oracle.com
Subject: [PATCH v2 1/3] ocfs2: Remove some useless functions
Date:   Thu, 21 Jul 2022 22:49:25 +0200
Message-Id: <bd1429c84ec7d174c96dbb67a2b42b1b456d9394.1658436259.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658436259.git.christophe.jaillet@wanadoo.fr>
References: <cover.1658436259.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__ocfs2_node_map_set_bit() and __ocfs2_node_map_clear_bit() are just
wrapper around set_bit() and clear_bit().

The leading __ also makes think that these functions are non-atomic just
like __set_bit() and __clear_bit().

So, just remove these wrappers and call set_bit() and clear_bit()
directly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
v1 -> v2
- fix a typo in the log message
- add R-b tag
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

