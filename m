Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAD755D748
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345416AbiF1LJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345404AbiF1LJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:09:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4052B1BF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:08:59 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LXMHb1TVJzcm42;
        Tue, 28 Jun 2022 19:07:07 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 19:08:56 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <naoya.horiguchi@nec.com>, <linmiaohe@huawei.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>, <gaochao49@huawei.com>
Subject: [PATCH -next] mm/memory-failure: fix redefinition of mf_generic_kill_procs
Date:   Tue, 28 Jun 2022 19:21:43 +0800
Message-ID: <20220628112143.1170473-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_HUGETLB_PAGE=n, building fails:

mm/memory-failure.c:1805:19: error: redefinition of ‘mf_generic_kill_procs’
 static inline int mf_generic_kill_procs(unsigned long long pfn, int flags,
                   ^~~~~~~~~~~~~~~~~~~~~
mm/memory-failure.c:1564:12: note: previous definition of ‘mf_generic_kill_procs’ was here
 static int mf_generic_kill_procs(unsigned long long pfn, int flags,

This patch fixes that.

Fixes: 4184e8d7d056 ("mm-factor-helpers-for-memory_failure_dev_pagemap-fix")
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 mm/memory-failure.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 001fead45f30..c9931c676335 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1801,13 +1801,6 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 }

 #else
-
-static inline int mf_generic_kill_procs(unsigned long long pfn, int flags,
-					struct dev_pagemap *pgmap)
-{
-	return 0;
-}
-
 static inline int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb)
 {
 	return 0;
--
2.31.1

