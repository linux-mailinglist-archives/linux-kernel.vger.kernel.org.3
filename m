Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1383533834
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbiEYIS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiEYISQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:18:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A91F67
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:18:14 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L7P4w3tGnzQkNZ;
        Wed, 25 May 2022 16:15:12 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 16:18:12 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <naoya.horiguchi@nec.com>
CC:     <peterx@redhat.com>, <apopple@nvidia.com>, <ying.huang@intel.com>,
        <david@redhat.com>, <songmuchun@bytedance.com>, <hch@lst.de>,
        <dhowells@redhat.com>, <cl@linux.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v3 0/4] A few cleanup and fixup patches for migration
Date:   Wed, 25 May 2022 16:18:18 +0800
Message-ID: <20220525081822.53547-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
This series contains a few patches to remove unneeded lock page and
PageMovable check, reduce the rcu lock duration. Also we fix potential
pte_unmap on an not mapped pte. More details can be found in the
respective changelogs. Thanks!

---
v3:
[PATCH 1/4] mm/migration: reduce the rcu lock duration
  add the analysis that the original race condition isn't possible now
  alsoreduce the rcu lock duration in kernel_migrate_pages
[PATCH 2/4] mm/migration: remove unneeded lock page and PageMovable check
  let free_pages_prepare() clear PG_isolated for us
[PATCH 3/4] mm/migration: return errno when isolate_huge_page failed
  rename isolate_huge_page to isolate_hugetlb
[PATCH 4/4] mm/migration: fix potential pte_unmap on an not mapped pte
  collect Reviewed-by tag
v2:
  collect Reviewed-by tag
  make isolate_huge_page consistent with isolate_lru_page
  add hugetlbfs variant of hugetlb_migration_entry_wait
v1:
  rebase [1] on mainline.

[1] https://lore.kernel.org/lkml/20220304093409.25829-2-linmiaohe@huawei.com/T/
---
Miaohe Lin (4):
  mm: reduce the rcu lock duration
  mm/migration: remove unneeded lock page and PageMovable check
  mm/migration: return errno when isolate_huge_page failed
  mm/migration: fix potential pte_unmap on an not mapped pte

 include/linux/hugetlb.h |  6 +++---
 include/linux/swapops.h | 12 ++++++++----
 mm/gup.c                |  2 +-
 mm/hugetlb.c            | 15 +++++++--------
 mm/memory-failure.c     |  2 +-
 mm/mempolicy.c          |  5 ++---
 mm/migrate.c            | 40 +++++++++++++++++++++++++---------------
 7 files changed, 47 insertions(+), 35 deletions(-)

-- 
2.23.0

