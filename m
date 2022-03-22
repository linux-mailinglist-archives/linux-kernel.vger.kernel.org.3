Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84B44E3760
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbiCVDYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbiCVDY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:24:29 -0400
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3AE5AA53
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:23:00 -0700 (PDT)
X-QQ-mid: bizesmtp89t1647919365tqpcupbm
Received: from localhost.localdomain ( [202.96.137.239])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 22 Mar 2022 11:22:38 +0800 (CST)
X-QQ-SSF: 01400000002000B0B000B00A0000000
X-QQ-FEAT: FXvDfBZI5O7hbJ92J2Pw4+Old7N4baRooH0on/achlelUnAVksJFu+/hbl/m0
        IeBT6OyxULc1zgMpnGkHjsloDS9NDEvAzgX7gbTKID3vRAZewYTpYSwEHwLDF6Eh4bwVqPN
        zWsbRLSdOlKI9/aBDJ3rIj+bACJESNtxJRqgYZP5PgAYdkpWPIn+4L7YCtmBEsU5g5GGckE
        kQ9b+UaZUVHIjYPb8CKFHY++yH4jjRbyVNJBBBtwPhfb4wM6XUnpYwbWavIeUxz2FMss+Jk
        DLmrwSqV7CtS/U6Se9QjR6AvO/EQyFjPiTBFVUMuYqMlTuNX9t9W/Hk72psDwQ56jpYv5Yw
        JncbeWxax2jeBeny9yFxAixMQAl6UDFTtk8GJCi
X-QQ-GoodBg: 2
From:   Yinan Zhang <zhangyinan2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, william.kucharski@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yejiajian2018@email.szu.edu.cn, hanshenghong2019@email.szu.edu.cn,
        caoyixuan2019@email.szu.edu.cn, zhaochongxi2019@email.szu.edu.cn,
        yuhongf@szu.edu.cn, Yinan Zhang <zhangyinan2019@email.szu.edu.cn>
Subject: [PATCH 2/2] mm/vmalloc.c: record the allocator in page_owner when __vmalloc_area_node complete mapping pages to virtual address
Date:   Tue, 22 Mar 2022 11:22:25 +0800
Message-Id: <20220322032225.1402992-2-zhangyinan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220322032225.1402992-1-zhangyinan2019@email.szu.edu.cn>
References: <20220322032225.1402992-1-zhangyinan2019@email.szu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign10
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page owner is for the tracking about who allocated each page.
Recording the allocator in page_owner requires support from vmalloc.

When __vmalloc_area_node complete mapping pages to virtual address,
it means that the memory allocation is successful. At this time,
call set_page_owner_allocator() to record the
allocator (in this patch, it's vmalloc) in page_owner.

This work is coauthored by
	Shenghong Han
	Yixuan Cao
	Chongxi Zhao
	Jiajian Ye
	Yuhong Feng
	Yongqiang Liu

Signed-off-by: Yinan Zhang <zhangyinan2019@email.szu.edu.cn>
---
 mm/vmalloc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b454cf1a261f..c561d40a3f95 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -40,6 +40,7 @@
 #include <linux/uaccess.h>
 #include <linux/hugetlb.h>
 #include <linux/sched/mm.h>
+#include <linux/page_owner.h>
 #include <asm/tlbflush.h>
 #include <asm/shmparam.h>
 
@@ -3051,6 +3052,13 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		goto fail;
 	}
 
+#ifdef CONFIG_PAGE_OWNER
+	int i;
+
+	for (i = 0; i < area->nr_pages; i++)
+		set_page_owner_allocator(area->pages[i], 0, PAGE_OWNER_ALLOCATOR_VMALLOC);
+#endif
+
 	return area->addr;
 
 fail:
-- 
2.25.1



