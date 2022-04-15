Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9687E502136
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 06:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349383AbiDOEV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 00:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbiDOEVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 00:21:25 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50107ADD7E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 21:18:57 -0700 (PDT)
Date:   Fri, 15 Apr 2022 13:18:48 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649996335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rl3sJ0XRlQIg8Gg43fwrBWpDvE8dJjHgrOhVyk/MSC8=;
        b=aM+/T+HofxzaGmEWiEGC3Ssm5s2AGIukaI8iWQrdo4qauFuK+eJtUA/3zxmLBsKx+Lvnws
        sW8O7sprEvwrfP5JOXbu07F1kIFPN7M8akoerStcHSwtLlOaiFvDsHeuaqVt25M5eXS4em
        mC02Pw/6Q//DWiO06W7ilUoSVQ6hA8M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        naoya.horiguchi@nec.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/3] mm, hugetlb, hwpoison: separate branch for free and
 in-use hugepage
Message-ID: <20220415041848.GA3034499@ik1-406-35019.vs.sakura.ne.jp>
References: <20220408135323.1559401-1-naoya.horiguchi@linux.dev>
 <20220408135323.1559401-2-naoya.horiguchi@linux.dev>
 <5b665bcd-57f8-85ae-b0c4-c055875dbfff@oracle.com>
 <20e677e5-01aa-f8c0-0ce1-bf33da58b7ec@huawei.com>
 <20220415021233.GA3357039@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220415021233.GA3357039@hori.linux.bs1.fc.nec.co.jp>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

We know that HPageFreed pages should have page refcount 0, so
get_page_unless_zero() always fails and returns 0.  So explicitly separate
the branch based on page state for minor optimization and better readability.

Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
Suggested-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/hugetlb.c        | 4 +++-
 mm/memory-failure.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e38cbfdf3e61..3638f166e554 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6786,7 +6786,9 @@ int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
 	spin_lock_irq(&hugetlb_lock);
 	if (PageHeadHuge(page)) {
 		*hugetlb = true;
-		if (HPageFreed(page) || HPageMigratable(page))
+		if (HPageFreed(page))
+			ret = 0;
+		else if (HPageMigratable(page))
 			ret = get_page_unless_zero(page);
 		else
 			ret = -EBUSY;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5e3ad640f5bb..661079a37f29 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1517,7 +1517,9 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 	if (flags & MF_COUNT_INCREASED) {
 		ret = 1;
 		count_increased = true;
-	} else if (HPageFreed(head) || HPageMigratable(head)) {
+	} else if (HPageFreed(head)) {
+		ret = 0;
+	} else if (HPageMigratable(head)) {
 		ret = get_page_unless_zero(head);
 		if (ret)
 			count_increased = true;
-- 
2.23.0

