Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0285A598396
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244879AbiHRNBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244604AbiHRNAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:00:45 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BA3659C2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:00:45 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4M7lMJ62f5zGpcF;
        Thu, 18 Aug 2022 20:59:08 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 18 Aug
 2022 21:00:42 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 3/6] mm, hwpoison: fix extra put_page() in soft_offline_page()
Date:   Thu, 18 Aug 2022 21:00:13 +0800
Message-ID: <20220818130016.45313-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220818130016.45313-1-linmiaohe@huawei.com>
References: <20220818130016.45313-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

When hwpoison_filter() refuses to soft offline a page, the page refcnt
incremented previously by MF_COUNT_INCREASED would have been consumed
via get_hwpoison_page() if ret <= 0. So the put_ref_page() here will
put the extra one. Remove it to fix the issue.

Fixes: 9113eaf331bf ("mm/memory-failure.c: add hwpoison_filter for soft offline")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 0c5ad7505b99..7023c3d81273 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2591,8 +2591,6 @@ int soft_offline_page(unsigned long pfn, int flags)
 	if (hwpoison_filter(page)) {
 		if (ret > 0)
 			put_page(page);
-		else
-			put_ref_page(ref_page);
 
 		mutex_unlock(&mf_mutex);
 		return -EOPNOTSUPP;
-- 
2.23.0

