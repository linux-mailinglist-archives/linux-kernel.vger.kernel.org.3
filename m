Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FDB5B2C4D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 04:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiIIC55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 22:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIIC5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 22:57:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A150B7EDA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 19:57:51 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MP0v767GHzmVM4;
        Fri,  9 Sep 2022 10:54:11 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 9 Sep
 2022 10:57:48 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <axboe@kernel.dk>
CC:     <dhowells@redhat.com>, <vbabka@suse.cz>, <willy@infradead.org>,
        <akpm@linux-foundation.org>, <zhanglianjie@uniontech.com>,
        <neilb@suse.de>, <jack@suse.cz>, <bvanassche@acm.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] writeback: remove unused macro DIRTY_FULL_SCOPE
Date:   Fri, 9 Sep 2022 10:57:11 +0800
Message-ID: <20220909025711.32012-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's introduced but never used. Remove it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/writeback.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 3f045f6d6c4f..06f9291b6fd5 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -17,20 +17,12 @@ struct bio;
 DECLARE_PER_CPU(int, dirty_throttle_leaks);
 
 /*
- * The 1/4 region under the global dirty thresh is for smooth dirty throttling:
- *
- *	(thresh - thresh/DIRTY_FULL_SCOPE, thresh)
- *
- * Further beyond, all dirtier tasks will enter a loop waiting (possibly long
- * time) for the dirty pages to drop, unless written enough pages.
- *
  * The global dirty threshold is normally equal to the global dirty limit,
  * except when the system suddenly allocates a lot of anonymous memory and
  * knocks down the global dirty threshold quickly, in which case the global
  * dirty limit will follow down slowly to prevent livelocking all dirtier tasks.
  */
 #define DIRTY_SCOPE		8
-#define DIRTY_FULL_SCOPE	(DIRTY_SCOPE / 2)
 
 struct backing_dev_info;
 
-- 
2.23.0

