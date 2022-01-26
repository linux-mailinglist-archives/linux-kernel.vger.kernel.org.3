Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B72849C645
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiAZJ0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:26:33 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:32122 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbiAZJ0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:26:30 -0500
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JkJDg2FrVz8wYP;
        Wed, 26 Jan 2022 17:23:31 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 26 Jan
 2022 17:26:28 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/highmem: remove unnecessary done label
Date:   Wed, 26 Jan 2022 17:25:42 +0800
Message-ID: <20220126092542.64659-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary done label to simplify the code.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/highmem.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/highmem.c b/mm/highmem.c
index 762679050c9a..0cc0c4da7ed9 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -736,11 +736,11 @@ void *page_address(const struct page *page)
 		list_for_each_entry(pam, &pas->lh, list) {
 			if (pam->page == page) {
 				ret = pam->virtual;
-				goto done;
+				break;
 			}
 		}
 	}
-done:
+
 	spin_unlock_irqrestore(&pas->lock, flags);
 	return ret;
 }
@@ -773,13 +773,12 @@ void set_page_address(struct page *page, void *virtual)
 		list_for_each_entry(pam, &pas->lh, list) {
 			if (pam->page == page) {
 				list_del(&pam->list);
-				spin_unlock_irqrestore(&pas->lock, flags);
-				goto done;
+				break;
 			}
 		}
 		spin_unlock_irqrestore(&pas->lock, flags);
 	}
-done:
+
 	return;
 }
 
-- 
2.23.0

