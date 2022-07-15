Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEB2575B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiGOGRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiGOGRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:17:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EF1DB3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:17:05 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lkh1C0SQDzlVvF;
        Fri, 15 Jul 2022 14:15:27 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Jul 2022 14:17:03 +0800
From:   Yuanzheng Song <songyuanzheng@huawei.com>
To:     <sj@kernel.org>, <akpm@linux-foundation.org>
CC:     <damon@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/damon/reclaim: fix 'enabled' is incorrectly set because 'system_wq' is not initialized
Date:   Fri, 15 Jul 2022 06:16:09 +0000
Message-ID: <20220715061609.48463-1-songyuanzheng@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'enabled' will be incorrectly set because the 'system_wq'
might not initialized yet. This results in 'enabled=true',
but the 'damon_reclaim_timer' is inactive. So fix it by moving
the judgment logic of the 'damon_reclaim_initialized' to the
start position of the enable_store().

Fixes: 294928293813 ("mm/damon/reclaim: schedule 'damon_reclaim_timer' only after 'system_wq' is initialized")
Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>
---
 mm/damon/reclaim.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index e69b807fefe4..b13d5a02bf2e 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -374,13 +374,14 @@ static bool damon_reclaim_initialized;
 static int damon_reclaim_enabled_store(const char *val,
 		const struct kernel_param *kp)
 {
-	int rc = param_set_bool(val, kp);
-
-	if (rc < 0)
-		return rc;
+	int rc;
 
 	/* system_wq might not initialized yet */
 	if (!damon_reclaim_initialized)
+		return -EINVAL;
+
+	rc = param_set_bool(val, kp);
+	if (rc < 0)
 		return rc;
 
 	schedule_delayed_work(&damon_reclaim_timer, 0);
-- 
2.25.1

