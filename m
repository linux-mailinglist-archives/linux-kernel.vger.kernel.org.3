Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4810E5499FB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbiFMR2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbiFMR1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:27:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600FE1146A0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:43:43 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LMB6F1gG9zjXYh;
        Mon, 13 Jun 2022 20:42:13 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 20:43:41 +0800
Received: from huawei.com (10.174.178.102) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 13 Jun
 2022 20:43:40 +0800
From:   linshengwang <linshengwang1@huawei.com>
To:     <almaz.alexandrovich@paragon-software.com>,
        <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linshengwang1@huawei.com>
Subject: [PATCH -next] fs/ntfs3: Remove unused function 'attr_must_be_resident'
Date:   Mon, 13 Jun 2022 20:43:39 +0800
Message-ID: <20220613124339.552-1-linshengwang1@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.102]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Shengwang <linshengwang1@huawei.com>

It is introduced by commit be71b5cba2e6 ("fs/ntfs3:
Add attrib operations"), but never used, so remove it.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lin Shengwang <linshengwang1@huawei.com>
---
 fs/ntfs3/attrib.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index fc0623b029e6..3df0c3f5ec72 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -54,33 +54,6 @@ static inline u64 get_pre_allocated(u64 size)
 	return ret;
 }

-/*
- * attr_must_be_resident
- *
- * Return: True if attribute must be resident.
- */
-static inline bool attr_must_be_resident(struct ntfs_sb_info *sbi,
-					 enum ATTR_TYPE type)
-{
-	const struct ATTR_DEF_ENTRY *de;
-
-	switch (type) {
-	case ATTR_STD:
-	case ATTR_NAME:
-	case ATTR_ID:
-	case ATTR_LABEL:
-	case ATTR_VOL_INFO:
-	case ATTR_ROOT:
-	case ATTR_EA_INFO:
-		return true;
-	default:
-		de = ntfs_query_def(sbi, type);
-		if (de && (de->flags & NTFS_ATTR_MUST_BE_RESIDENT))
-			return true;
-		return false;
-	}
-}
-
 /*
  * attr_load_runs - Load all runs stored in @attr.
  */
--
2.17.1


