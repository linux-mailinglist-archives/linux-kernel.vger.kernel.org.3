Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB355736B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbiGMMzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbiGMMzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:55:47 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F247392A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:55:47 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ljcyx35yYzFpyM;
        Wed, 13 Jul 2022 20:54:49 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 20:55:45 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <akpm@linux-foundation.org>, <axboe@kernel.dk>, <neilb@suse.de>,
        <johannes.thumshirn@wdc.com>, <jack@suse.cz>,
        <willy@infradead.org>, <mgorman@techsingularity.net>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] writeback: Cleanup bdi_sched_wait()
Date:   Wed, 13 Jul 2022 20:53:14 +0800
Message-ID: <20220713125314.171345-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bdi_sched_wait() is no longer used since commit 839a8e8660b6 ("writeback:
replace custom worker pool implementation with unbound workqueue"),
so remove it.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 include/linux/backing-dev.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index d452071db572..e84b745a6811 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -140,12 +140,6 @@ static inline bool mapping_can_writeback(struct address_space *mapping)
 	return inode_to_bdi(mapping->host)->capabilities & BDI_CAP_WRITEBACK;
 }
 
-static inline int bdi_sched_wait(void *word)
-{
-	schedule();
-	return 0;
-}
-
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 struct bdi_writeback *wb_get_lookup(struct backing_dev_info *bdi,
-- 
2.17.1

