Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB3C579553
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbiGSIg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236914AbiGSIg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:36:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33B824F17
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:36:25 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LnBsc71crzVgTS;
        Tue, 19 Jul 2022 16:32:36 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 16:36:24 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <akpm@linux-foundation.org>, <jack@suse.cz>, <neilb@suse.de>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] bdi: remove enum wb_congested_state
Date:   Tue, 19 Jul 2022 16:33:49 +0800
Message-ID: <20220719083349.87547-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enum wb_congested_state and the member 'congested' in bdi_writeback is
useless since commit a88f2096d5a2 ("remove congestion tracking framework"),
so remove it.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 include/linux/backing-dev-defs.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index e863c88df95f..ae12696ec492 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -28,11 +28,6 @@ enum wb_state {
 	WB_start_all,		/* nr_pages == 0 (all) work pending */
 };
 
-enum wb_congested_state {
-	WB_async_congested,	/* The async (write) queue is getting full */
-	WB_sync_congested,	/* The sync queue is getting full */
-};
-
 enum wb_stat_item {
 	WB_RECLAIMABLE,
 	WB_WRITEBACK,
@@ -122,8 +117,6 @@ struct bdi_writeback {
 	atomic_t writeback_inodes;	/* number of inodes under writeback */
 	struct percpu_counter stat[NR_WB_STAT_ITEMS];
 
-	unsigned long congested;	/* WB_[a]sync_congested flags */
-
 	unsigned long bw_time_stamp;	/* last time write bw is updated */
 	unsigned long dirtied_stamp;
 	unsigned long written_stamp;	/* pages written at bw_time_stamp */
-- 
2.17.1

