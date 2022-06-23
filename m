Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525D5557D15
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiFWNcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiFWNcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:32:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFB23E0C2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:32:34 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LTLjj53M0zdfwY;
        Thu, 23 Jun 2022 21:30:49 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 21:32:32 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 23 Jun
 2022 21:32:32 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <liam.howlett@oracle.com>,
        <quic_qiancai@quicinc.com>, <yuzhao@google.com>
Subject: [PATCH -next] mm/mmap: fix error return code in do_mas_align_munmap()
Date:   Thu, 23 Jun 2022 21:42:37 +0800
Message-ID: <20220623134237.2127440-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return error code when munmap_sidetree() fails in do_mas_align_munmap().

Fixes: 81f5504dfb36 ("mm/mmap: change do_mas_align_munmap() to avoid preallocations for sidetree")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 mm/mmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1bdf56804048..bb978061a790 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2427,7 +2427,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 
 			mas_set(mas, end);
 			split = mas_prev(mas, 0);
-			if (munmap_sidetree(split, &mas_detach))
+			error = munmap_sidetree(split, &mas_detach);
+			if (error)
 				goto munmap_sidetree_failed;
 
 			count++;
@@ -2435,7 +2436,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 				vma = split;
 			break;
 		}
-		if (munmap_sidetree(next, &mas_detach))
+		error = munmap_sidetree(next, &mas_detach);
+		if (error)
 			goto munmap_sidetree_failed;
 
 		count++;
-- 
2.25.1

