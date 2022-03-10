Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62D64D4804
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 14:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242400AbiCJN0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 08:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbiCJN0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 08:26:12 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8E914D275
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 05:25:08 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KDqWz6Bjpzdb7R;
        Thu, 10 Mar 2022 21:23:43 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 10 Mar
 2022 21:25:06 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <Herbert.van.den.Bergh@oracle.com>, <chris.mason@oracle.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/mlock: fix potential imbalanced rlimit ucounts adjustment
Date:   Thu, 10 Mar 2022 21:24:17 +0800
Message-ID: <20220310132417.41189-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

user_shm_lock forgets to set allowed to 0 when get_ucounts fails. So
the later user_shm_unlock might do the extra dec_rlimit_ucounts. Fix
this by resetting allowed to 0.

Fixes: 5ed44a401ddf ("do not limit locked memory when RLIMIT_MEMLOCK is RLIM_INFINITY")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/mlock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mlock.c b/mm/mlock.c
index 29372c0eebe5..efd2dd2943de 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -733,6 +733,7 @@ int user_shm_lock(size_t size, struct ucounts *ucounts)
 	}
 	if (!get_ucounts(ucounts)) {
 		dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
+		allowed = 0;
 		goto out;
 	}
 	allowed = 1;
-- 
2.23.0

