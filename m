Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9E6544D1F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244638AbiFINIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242601AbiFINIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:08:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46749255BC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 06:08:32 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LJkrJ0Hq3zgY9W;
        Thu,  9 Jun 2022 21:06:40 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 9 Jun
 2022 21:08:30 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <jglisse@redhat.com>
CC:     <apopple@nvidia.com>, <jgg@ziepe.ca>, <akpm@linux-foundation.org>,
        <rcampbell@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] lib/test_hmm: avoid accessing uninitialized pages
Date:   Thu, 9 Jun 2022 21:08:35 +0800
Message-ID: <20220609130835.35110-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
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

If make_device_exclusive_range() fails or returns pages marked for
exclusive access less than required, remaining fields of pages will
left uninitialized. So dmirror_atomic_map() will access those yet
uninitialized fields of pages. To fix it, do dmirror_atomic_map()
iff all pages are marked for exclusive access (we will break if
mapped is less than required anyway) so we won't access those
uninitialized fields of pages.

Fixes: b659baea7546 ("mm: selftests for exclusive device memory")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 lib/test_hmm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 7930853e7fc5..e3965cafd27c 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -797,7 +797,7 @@ static int dmirror_exclusive(struct dmirror *dmirror,
 
 	mmap_read_lock(mm);
 	for (addr = start; addr < end; addr = next) {
-		unsigned long mapped;
+		unsigned long mapped = 0;
 		int i;
 
 		if (end < addr + (ARRAY_SIZE(pages) << PAGE_SHIFT))
@@ -806,7 +806,13 @@ static int dmirror_exclusive(struct dmirror *dmirror,
 			next = addr + (ARRAY_SIZE(pages) << PAGE_SHIFT);
 
 		ret = make_device_exclusive_range(mm, addr, next, pages, NULL);
-		mapped = dmirror_atomic_map(addr, next, pages, dmirror);
+		/*
+		 * Do dmirror_atomic_map() iff all pages are marked for
+		 * exclusive access to avoid accessing uninitialized
+		 * fields of pages.
+		 */
+		if (ret == (next - addr) >> PAGE_SHIFT)
+			mapped = dmirror_atomic_map(addr, next, pages, dmirror);
 		for (i = 0; i < ret; i++) {
 			if (pages[i]) {
 				unlock_page(pages[i]);
-- 
2.23.0

