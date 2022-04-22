Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3DF50B35B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445675AbiDVJAk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 22 Apr 2022 05:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiDVJAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:00:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8320B532E8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 01:57:44 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kl7X90KbtzFqfD;
        Fri, 22 Apr 2022 16:55:05 +0800 (CST)
Received: from dggpemm100007.china.huawei.com (7.185.36.116) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 16:57:21 +0800
Received: from dggpemm500022.china.huawei.com (7.185.36.162) by
 dggpemm100007.china.huawei.com (7.185.36.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 16:57:21 +0800
Received: from dggpemm500022.china.huawei.com ([7.185.36.162]) by
 dggpemm500022.china.huawei.com ([7.185.36.162]) with mapi id 15.01.2375.024;
 Fri, 22 Apr 2022 16:57:21 +0800
From:   liusongtang <liusongtang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nixiaoming <nixiaoming@huawei.com>,
        "Liuyang (Young,C)" <young.liuyang@huawei.com>,
        liusongtang <liusongtang@huawei.com>,
        "mgorman@suse.de" <mgorman@suse.de>
Subject: 
Thread-Index: AdhWJvbUleEgbnxeQpScQoDlY7nhUA==
Date:   Fri, 22 Apr 2022 08:57:21 +0000
Message-ID: <388eaecb1ceb46bf8eb861055e64d399@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.243]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liusongtang <liusongtang@huawei.com>
Date: Thu, 21 Apr 2022 17:44:07 +0800
Subject: [PATCH] mm: reduce Committed_AS if memory protection is changed to
 PROT_NONE

If PROT_WRITE is set, the size of vm area will be added to Committed_AS.
However, if memory protection is changed to PROT_NONE,
the corresponding physical memory will not be used, but Committed_AS still
count the size of the PROT_NONE memory.

This patch reduce Committed_AS and free the corresponding memory if
memory protection is changed to PROT_NONE.

Signed-off-by: liusongtang <liusongtang@huawei.com>
---
 mm/mprotect.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index b69ce7a..c3121e6 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -497,6 +497,12 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
        }

 success:
+       if ((newflags & (VM_READ | VM_WRITE | VM_EXEC | VM_LOCKED | VM_ACCOUNT)) == VM_ACCOUNT) {
+               zap_page_range(vma, start, end - start);
+               newflags &= ~VM_ACCOUNT;
+               vm_unacct_memory((end - start) >> PAGE_SHIFT);
+       }
+
        /*
         * vm_flags and vm_page_prot are protected by the mmap_lock
         * held in write mode.
--
2.12.3
