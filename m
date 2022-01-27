Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4F749DE0D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbiA0JdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:33:04 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35877 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238657AbiA0Jcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:32:54 -0500
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JkwN06Cjrzcck7;
        Thu, 27 Jan 2022 17:32:00 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 27 Jan
 2022 17:32:51 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/mmzone.h: remove unused macros
Date:   Thu, 27 Jan 2022 17:32:10 +0800
Message-ID: <20220127093210.62293-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove pgdat_page_nr, nid_page_nr and NODE_MEM_MAP. They are unused now.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/mmzone.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aed44e9b5d89..6c004256d943 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -920,12 +920,6 @@ typedef struct pglist_data {
 
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
 #define node_spanned_pages(nid)	(NODE_DATA(nid)->node_spanned_pages)
-#ifdef CONFIG_FLATMEM
-#define pgdat_page_nr(pgdat, pagenr)	((pgdat)->node_mem_map + (pagenr))
-#else
-#define pgdat_page_nr(pgdat, pagenr)	pfn_to_page((pgdat)->node_start_pfn + (pagenr))
-#endif
-#define nid_page_nr(nid, pagenr) 	pgdat_page_nr(NODE_DATA(nid),(pagenr))
 
 #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)
 #define node_end_pfn(nid) pgdat_end_pfn(NODE_DATA(nid))
@@ -1101,7 +1095,6 @@ static inline struct pglist_data *NODE_DATA(int nid)
 {
 	return &contig_page_data;
 }
-#define NODE_MEM_MAP(nid)	mem_map
 
 #else /* CONFIG_NUMA */
 
-- 
2.23.0

