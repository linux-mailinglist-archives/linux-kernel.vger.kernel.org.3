Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D801551B83C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 08:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiEEG4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 02:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242125AbiEEGzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 02:55:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF1B47045
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 23:52:04 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kv48v6qXczfbFN;
        Thu,  5 May 2022 14:50:55 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 14:52:00 +0800
From:   Yuanzheng Song <songyuanzheng@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Yuanzheng Song <songyuanzheng@huawei.com>
Subject: [PATCH] mm: usercopy: move the virt_addr_valid() below the is_vmalloc_addr()
Date:   Thu, 5 May 2022 07:10:37 +0000
Message-ID: <20220505071037.4121100-1-songyuanzheng@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

The is_kmap_addr() and the is_vmalloc_addr() in the check_heap_object()
will not work, because the virt_addr_valid() will exclude the kmap and
vmalloc regions. So let's move the virt_addr_valid() below
the is_vmalloc_addr().

Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>
---
 mm/usercopy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index ac8a093e90c1..baeacc735b83 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -163,9 +163,6 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 {
 	struct folio *folio;
 
-	if (!virt_addr_valid(ptr))
-		return;
-
 	if (is_kmap_addr(ptr)) {
 		unsigned long page_end = (unsigned long)ptr | (PAGE_SIZE - 1);
 
@@ -190,6 +187,9 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 		return;
 	}
 
+	if (!virt_addr_valid(ptr))
+		return;
+
 	folio = virt_to_folio(ptr);
 
 	if (folio_test_slab(folio)) {
-- 
2.25.1

