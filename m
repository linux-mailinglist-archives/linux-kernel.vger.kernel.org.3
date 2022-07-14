Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AF457477F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbiGNIp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbiGNIpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:45:36 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0F13DBF6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:45:31 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Lk7Mg4wzQzFq4B;
        Thu, 14 Jul 2022 16:44:31 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 16:45:28 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <akpm@linux-foundation.org>, <axboe@kernel.dk>, <neilb@suse.de>,
        <johannes.thumshirn@wdc.com>, <jack@suse.cz>,
        <willy@infradead.org>, <mgorman@techsingularity.net>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] writeback: Cleanup inode_to_wb_is_valid()
Date:   Thu, 14 Jul 2022 16:41:47 +0800
Message-ID: <20220714084147.140324-1-xiujianfeng@huawei.com>
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

inode_to_wb_is_valid() is no longer used since commit fe55d563d417
("remove inode_congested()"), remove it.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 include/linux/backing-dev.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index d452071db572..f9f14e385582 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -235,18 +235,6 @@ wb_get_create_current(struct backing_dev_info *bdi, gfp_t gfp)
 	return wb;
 }
 
-/**
- * inode_to_wb_is_valid - test whether an inode has a wb associated
- * @inode: inode of interest
- *
- * Returns %true if @inode has a wb associated.  May be called without any
- * locking.
- */
-static inline bool inode_to_wb_is_valid(struct inode *inode)
-{
-	return inode->i_wb;
-}
-
 /**
  * inode_to_wb - determine the wb of an inode
  * @inode: inode of interest
@@ -345,11 +333,6 @@ wb_get_create_current(struct backing_dev_info *bdi, gfp_t gfp)
 	return &bdi->wb;
 }
 
-static inline bool inode_to_wb_is_valid(struct inode *inode)
-{
-	return true;
-}
-
 static inline struct bdi_writeback *inode_to_wb(struct inode *inode)
 {
 	return &inode_to_bdi(inode)->wb;
-- 
2.17.1

