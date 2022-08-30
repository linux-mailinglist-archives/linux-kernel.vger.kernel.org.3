Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF1D5A637D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiH3Mg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiH3Mgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:36:39 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6DBD7D1C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:36:38 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MH6CZ3n1Bz1N7J3;
        Tue, 30 Aug 2022 20:32:58 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 30 Aug
 2022 20:36:36 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 6/6] mm, hwpoison: cleanup some obsolete comments
Date:   Tue, 30 Aug 2022 20:36:04 +0800
Message-ID: <20220830123604.25763-7-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220830123604.25763-1-linmiaohe@huawei.com>
References: <20220830123604.25763-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

1.Remove meaningless comment in kill_proc(). That doesn't tell anything.
2.Fix the wrong function name get_hwpoison_unless_zero(). It should be
get_page_unless_zero().
3.The gate keeper for free hwpoison page has moved to check_new_page().
Update the corresponding comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fb6a10005109..df3bf266eebf 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -277,7 +277,7 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 		 * to SIG_IGN, but hopefully no one will do that?
 		 */
 		ret = send_sig_mceerr(BUS_MCEERR_AO, (void __user *)tk->addr,
-				      addr_lsb, t);  /* synchronous? */
+				      addr_lsb, t);
 	if (ret < 0)
 		pr_info("Error sending signal to %s:%d: %d\n",
 			t->comm, t->pid, ret);
@@ -1246,9 +1246,9 @@ static int __get_hwpoison_page(struct page *page, unsigned long flags)
 		return ret;
 
 	/*
-	 * This check prevents from calling get_hwpoison_unless_zero()
-	 * for any unsupported type of page in order to reduce the risk of
-	 * unexpected races caused by taking a page refcount.
+	 * This check prevents from calling get_page_unless_zero() for any
+	 * unsupported type of page in order to reduce the risk of unexpected
+	 * races caused by taking a page refcount.
 	 */
 	if (!HWPoisonHandlable(head, flags))
 		return -EBUSY;
@@ -2025,7 +2025,7 @@ int memory_failure(unsigned long pfn, int flags)
 	/*
 	 * We need/can do nothing about count=0 pages.
 	 * 1) it's a free page, and therefore in safe hand:
-	 *    prep_new_page() will be the gate keeper.
+	 *    check_new_page() will be the gate keeper.
 	 * 2) it's part of a non-compound high order page.
 	 *    Implies some kernel user: cannot stop them from
 	 *    R/W the page; let's pray that the page has been
-- 
2.23.0

