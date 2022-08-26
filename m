Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ED45A1F66
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 05:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbiHZDUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 23:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244560AbiHZDU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 23:20:28 -0400
X-Greylist: delayed 638 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 Aug 2022 20:20:25 PDT
Received: from oem-W330-H30 (unknown [180.167.10.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B461D73939;
        Thu, 25 Aug 2022 20:20:25 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
        by oem-W330-H30 (8.15.2/8.15.2/Debian-8) with ESMTP id 27Q39ULS011217;
        Fri, 26 Aug 2022 11:09:30 +0800
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com, yuzhe@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH v3] md/raid5-cache: Resolve patch confilcts
Date:   Fri, 26 Aug 2022 11:08:00 +0800
Message-Id: <20220826030800.10583-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220705022617.12555-1-jiaming@nfschina.com>
References: <20220705022617.12555-1-jiaming@nfschina.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,FSL_HELO_NON_FQDN_1,
        HELO_NO_DOMAIN,HELO_OEM,RDNS_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolve conflicts when applying patches.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
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

