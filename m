Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA69A5A260B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343849AbiHZKpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbiHZKpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:45:14 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1824213DFA;
        Fri, 26 Aug 2022 03:45:04 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 032F41E80D93;
        Fri, 26 Aug 2022 18:40:48 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id R_UdhJc9Y01Z; Fri, 26 Aug 2022 18:40:45 +0800 (CST)
Received: from localhost.localdomain (unknown [58.247.180.115])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 5A0AA1E80D54;
        Fri, 26 Aug 2022 18:40:44 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com, yuzhe@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH v3] block: Fix spelling mistakes in comments
Date:   Fri, 26 Aug 2022 18:44:32 +0800
Message-Id: <20220826104432.4613-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220705022617.12555-1-jiaming@nfschina.com>
References: <20220705022617.12555-1-jiaming@nfschina.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling of dones't and waitting in comments.
Fix tense mistakes of hold and finsh in comments.
Use underline to connecting reconfig and mutex.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
v3: Resolve conflicts when applying patches.
---
---
 drivers/md/raid5-cache.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 058d82e..a4a84a0 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -125,7 +125,7 @@ struct r5l_log {
 					 * reclaimed.  if it's 0, reclaim spaces
 					 * used by io_units which are in
 					 * IO_UNIT_STRIPE_END state (eg, reclaim
-					 * dones't wait for specific io_unit
+					 * doesn't wait for specific io_unit
 					 * switching to IO_UNIT_STRIPE_END
 					 * state) */
 	wait_queue_head_t iounit_wait;
@@ -1326,12 +1326,12 @@ static void r5l_write_super_and_discard_space(struct r5l_log *log,
 	 * Discard could zero data, so before discard we must make sure
 	 * superblock is updated to new log tail. Updating superblock (either
 	 * directly call md_update_sb() or depend on md thread) must hold
-	 * reconfig mutex. On the other hand, raid5_quiesce is called with
-	 * reconfig_mutex hold. The first step of raid5_quiesce() is waiting
-	 * for all IO finish, hence waiting for reclaim thread, while reclaim
-	 * thread is calling this function and waiting for reconfig mutex. So
+	 * reconfig_mutex. On the other hand, raid5_quiesce is called with
+	 * reconfig_mutex held. The first step of raid5_quiesce() is waiting
+	 * for all IO to finish, hence waiting for reclaim thread, while reclaim
+	 * thread is calling this function and waiting for reconfig_mutex. So
 	 * there is a deadlock. We workaround this issue with a trylock.
-	 * FIXME: we could miss discard if we can't take reconfig mutex
+	 * FIXME: we could miss discard if we can't take reconfig_mutex
 	 */
 	set_mask_bits(&mddev->sb_flags, 0,
 		BIT(MD_SB_CHANGE_DEVS) | BIT(MD_SB_CHANGE_PENDING));
-- 
2.11.0

