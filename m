Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CECD4D881F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242515AbiCNPec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiCNPea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:34:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0839865FE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:33:18 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KHL9H5rwFzBrwW;
        Mon, 14 Mar 2022 23:31:15 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 14 Mar
 2022 23:33:15 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/mlock: remove unneeded start >= vma->vm_end check
Date:   Mon, 14 Mar 2022 23:32:23 +0800
Message-ID: <20220314153223.53753-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

If find_vma returns a vma, it must satisfies that start < vma->vm_end.
Since vma list is sorted in the ascending order, so we will never see
start >= vma->vm_end here. Remove this unneeded check.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/mlock.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index fefa9644d0f9..fe278634ebe3 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -509,8 +509,6 @@ static unsigned long count_mm_mlocked_page_nr(struct mm_struct *mm,
 		return 0;
 
 	for (; vma ; vma = vma->vm_next) {
-		if (start >= vma->vm_end)
-			continue;
 		if (start + len <=  vma->vm_start)
 			break;
 		if (vma->vm_flags & VM_LOCKED) {
-- 
2.23.0

