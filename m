Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058ED58F7FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 08:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbiHKG5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 02:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbiHKG5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:57:45 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FE968B9A5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:57:44 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 51CBB1E80CE3;
        Thu, 11 Aug 2022 14:55:42 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HguBMh2ZK_8d; Thu, 11 Aug 2022 14:55:39 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhoujie@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 46E801E80D32;
        Thu, 11 Aug 2022 14:55:39 +0800 (CST)
From:   Zhou jie <zhoujie@nfschina.com>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, kernel@nfschina.com,
        Zhou jie <zhoujie@nfschina.com>
Subject: [PATCH] remove unnecessary void* type casting
Date:   Thu, 11 Aug 2022 14:57:38 +0800
Message-Id: <20220811065738.5120-1-zhoujie@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary void* type casting

Signed-off-by: Zhou jie <zhoujie@nfschina.com>
---
 drivers/md/dm-linear.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 76b486e4d2be..5637c480216a 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -71,7 +71,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 static void linear_dtr(struct dm_target *ti)
 {
-	struct linear_c *lc = (struct linear_c *) ti->private;
+	struct linear_c *lc = ti->private;
 
 	dm_put_device(ti, lc->dev);
 	kfree(lc);
@@ -119,7 +119,7 @@ static void linear_status(struct dm_target *ti, status_type_t type,
 	case STATUSTYPE_IMA:
 		DMEMIT_TARGET_NAME_VERSION(ti->type);
 		DMEMIT(",device_name=%s,start=%llu;", lc->dev->name,
-		       (unsigned long long)lc->start);
+		       lc->start);
 		break;
 	}
 }
-- 
2.18.2

