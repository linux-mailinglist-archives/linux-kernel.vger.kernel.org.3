Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7C7500537
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 06:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239825AbiDNEak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 00:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiDNEai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 00:30:38 -0400
Received: from smtpbg152.qq.com (smtpbg152.qq.com [13.245.186.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5777A3DA42
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 21:28:09 -0700 (PDT)
X-QQ-mid: bizesmtp86t1649910479tczcq9j2
Received: from wuhui-virtual-machine.localdoma ( [202.96.137.248])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 14 Apr 2022 12:27:55 +0800 (CST)
X-QQ-SSF: 01400000000000D0P000B00A0000000
X-QQ-FEAT: HoyAXBWgskkCA11j5tmXPuT8ekhcSRgrS/a2ovbNCK3kmt8c6Cd7Sa9jhfEKf
        mEzF/H7vMfXB/WLCOGIVCeXw6NK1TIOzpX5WaenzVORSUllpOK5i+z/dR8jYUD4MVATVUEX
        1MdZ7C0rD+p3CS40t1nYOaRW2pnaKpJBe114tUPo3Zn7869vCIVF5K5j97DnztPJQSdurBj
        by+HDlqoYuj1CXFENhH0pIM+Rbmb6D5latrBfaUC160MAn1dKPWv0v6jxqr8KOMezkS81nw
        SmwKhtqttKYIpKK2GSiaMdfC8bWf0tFgmJ194utq+UNJVvrICuJTOibfpLXYkeiPkwW4T4u
        mmUwibLU6wexBC64Te9aHnjOid0cQ==
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     yejiajian2018@email.szu.edu.cn, sfr@canb.auug.org.au,
        seanga2@gmail.com, zhangyinan2019@email.szu.edu.cn,
        zhaochongxi2019@email.szu.edu.cn, linux-kernel@vger.kernel.org,
        hanshenghong2019@email.szu.edu.cn,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH] tools/vm/page_owner_sort.c: avoid repeated judgments
Date:   Thu, 14 Apr 2022 12:27:44 +0800
Message-Id: <20220414042744.13896-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign8
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed a detail that needs to be adjusted.
When judging whether a page is allocated by vmalloc,
the value of the variable "tmp" was repeatedly judged,
so the code was adjusted.

This work is coauthored by Yinan Zhang, Jiajian Ye, Shenghong Han,
Chongxi Zhao, Yuhong Feng and Yongqiang Liu.

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 tools/vm/page_owner_sort.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index fa2e4d2a9d68..c149427eb1c9 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -444,10 +444,8 @@ static int get_allocator(const char *buf, const char *migrate_info)
 			tmp--;
 		first_line = ++tmp;
 		tmp = strstr(tmp, "alloc_pages");
-		if (tmp) {
-			if (tmp && first_line <= tmp && tmp < second_line)
-				allocator |= ALLOCATOR_VMALLOC;
-		}
+		if (tmp && first_line <= tmp && tmp < second_line)
+			allocator |= ALLOCATOR_VMALLOC;
 	}
 	if (allocator == 0)
 		allocator = ALLOCATOR_OTHERS;
-- 
2.17.1



