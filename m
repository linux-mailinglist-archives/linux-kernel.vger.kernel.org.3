Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EE759CF16
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbiHWDEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239803AbiHWDED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:04:03 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475895E64C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 20:02:52 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MBYrn0177zGpn0;
        Tue, 23 Aug 2022 11:00:56 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 23 Aug
 2022 11:02:35 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>
CC:     <lukas.bulwahn@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 0/6] A few fixup patches for hugetlb
Date:   Tue, 23 Aug 2022 11:02:03 +0800
Message-ID: <20220823030209.57434-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
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

Hi everyone,
This series contains a few fixup patches to fix incorrect update of
max_huge_pages, fix WARN_ON(!kobj) in sysfs_create_group() and so on.
More details can be found in the respective changelogs.
Thanks!

---
v2:
 Collect Reviewed-by tag per Mike, Muchun and Fengwei. Thanks!
 Remove err == -EEXIST check and retry logic in 3/6.
 Remove unused local variable dst_entry per Lukas. Thanks!
---
Miaohe Lin (6):
  mm/hugetlb: fix incorrect update of max_huge_pages
  mm/hugetlb: fix WARN_ON(!kobj) in sysfs_create_group()
  mm/hugetlb: fix missing call to restore_reserve_on_error()
  mm: hugetlb_vmemmap: add missing smp_wmb() before set_pte_at()
  mm/hugetlb: fix sysfs group leak in hugetlb_unregister_node()
  mm/hugetlb: make detecting shared pte more reliable

 mm/hugetlb.c         | 61 +++++++++++++++++++++++++++-----------------
 mm/hugetlb_vmemmap.c |  5 ++++
 2 files changed, 42 insertions(+), 24 deletions(-)

-- 
2.23.0

