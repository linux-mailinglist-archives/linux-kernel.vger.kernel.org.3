Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DAD58F7F0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 08:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiHKGvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 02:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbiHKGvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:51:11 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 043A515715
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:51:08 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 253001E80D32;
        Thu, 11 Aug 2022 14:49:06 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8scMk5p_aKB5; Thu, 11 Aug 2022 14:49:03 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhoujie@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 542771E80CE3;
        Thu, 11 Aug 2022 14:49:03 +0800 (CST)
From:   Zhou jie <zhoujie@nfschina.com>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, kernel@nfschina.com,
        Zhou jie <zhoujie@nfschina.com>
Subject: [PATCH] md:Remove unnecessary void* type casting 
Date:   Thu, 11 Aug 2022 14:51:02 +0800
Message-Id: <20220811065102.4697-1-zhoujie@nfschina.com>
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
 drivers/md/dm-verity-fec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index cea2b3789736..3f19fd89cf98 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -567,14 +567,14 @@ void verity_fec_dtr(struct dm_verity *v)
 
 static void *fec_rs_alloc(gfp_t gfp_mask, void *pool_data)
 {
-	struct dm_verity *v = (struct dm_verity *)pool_data;
+	struct dm_verity *v = pool_data;
 
 	return init_rs_gfp(8, 0x11d, 0, 1, v->fec->roots, gfp_mask);
 }
 
 static void fec_rs_free(void *element, void *pool_data)
 {
-	struct rs_control *rs = (struct rs_control *)element;
+	struct rs_control *rs = element;
 
 	if (rs)
 		free_rs(rs);
-- 
2.18.2

