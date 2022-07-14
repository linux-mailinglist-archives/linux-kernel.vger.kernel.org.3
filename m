Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAA157430D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 06:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbiGNE3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 00:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbiGNE2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 00:28:02 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CFE2FFC7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 21:24:36 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657772675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CM1fnHF5+SZu84iYIKJ8/xtAtt5Of29zh4flgmzpzHg=;
        b=BwviJmTV1NrutOKVW7t2ZR6/VQYai6/hAH0p6/moeb7eViAcHkhWJ74cRMf/BH6aWMBfOt
        JTXER4Pykc+d0ZrjjBIFmZ9MbvYJR0obkimJH7iVtGyJTVv3Re+3nv86VDVzq29/4mFDg3
        m+chYuz91PWa0PJiptIsKIaUEdj78/w=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [mm-unstable PATCH v7 1/8] mm/hugetlb: check gigantic_page_runtime_supported() in return_unused_surplus_pages()
Date:   Thu, 14 Jul 2022 13:24:13 +0900
Message-Id: <20220714042420.1847125-2-naoya.horiguchi@linux.dev>
In-Reply-To: <20220714042420.1847125-1-naoya.horiguchi@linux.dev>
References: <20220714042420.1847125-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

I found a weird state of 1GB hugepage pool, caused by the following
procedure:

  - run a process reserving all free 1GB hugepages,
  - shrink free 1GB hugepage pool to zero (i.e. writing 0 to
    /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages), then
  - kill the reserving process.

, then all the hugepages are free *and* surplus at the same time.

  $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
  3
  $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/free_hugepages
  3
  $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/resv_hugepages
  0
  $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/surplus_hugepages
  3

This state is resolved by reserving and allocating the pages then
freeing them again, so this seems not to result in serious problem.
But it's a little surprising (shrinking pool suddenly fails).

This behavior is caused by hstate_is_gigantic() check in
return_unused_surplus_pages(). This was introduced so long ago in 2008
by commit aa888a74977a ("hugetlb: support larger than MAX_ORDER"), and
at that time the gigantic pages were not supposed to be allocated/freed
at run-time.  Now kernel can support runtime allocation/free, so let's
check gigantic_page_runtime_supported() together.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
v4 -> v5:
- drop additional gigantic_page_runtime_supported() checks.

v2 -> v3:
- Fixed typo in patch description,
- add !gigantic_page_runtime_supported() check instead of removing
  hstate_is_gigantic() check (suggested by Miaohe and Muchun)
- add a few more !gigantic_page_runtime_supported() check in
  set_max_huge_pages() (by Mike).
---
 mm/hugetlb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a4506ed1f1db..cf8ccee7654c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2432,8 +2432,7 @@ static void return_unused_surplus_pages(struct hstate *h,
 	/* Uncommit the reservation */
 	h->resv_huge_pages -= unused_resv_pages;
 
-	/* Cannot return gigantic pages currently */
-	if (hstate_is_gigantic(h))
+	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		goto out;
 
 	/*
-- 
2.25.1

