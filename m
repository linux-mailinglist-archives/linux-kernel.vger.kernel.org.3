Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07D74FA59E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 09:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbiDIHkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 03:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiDIHki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 03:40:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2177167C3
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 00:38:30 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kb6Pk50hwzgYQm;
        Sat,  9 Apr 2022 15:36:42 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 9 Apr
 2022 15:38:28 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <shy828301@gmail.com>,
        <willy@infradead.org>, <ying.huang@intel.com>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>,
        <dave.hansen@linux.intel.com>, <o451686892@gmail.com>,
        <jhubbard@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <osalvador@suse.de>, <david@redhat.com>, <sfr@canb.auug.org.au>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 0/4] A few cleanup and fixup patches for migration
Date:   Sat, 9 Apr 2022 15:38:42 +0800
Message-ID: <20220409073846.22286-1-linmiaohe@huawei.com>
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

Hi everyone,
This series contains a few patches to remove unneeded lock page and
PageMovable check, reduce the rcu lock duration. Also we fix potential
pte_unmap on an not mapped pte. More details can be found in the
respective changelogs. Thanks!

---
v1:
  rebase [1] on mainline.

[1] https://lore.kernel.org/lkml/20220304093409.25829-2-linmiaohe@huawei.com/T/
---
Miaohe Lin (4):
  mm/migration: reduce the rcu lock duration
  mm/migration: remove unneeded lock page and PageMovable check
  mm/migration: return errno when isolate_huge_page failed
  mm/migration: fix potential pte_unmap on an not mapped pte

 include/linux/migrate.h |  2 +-
 include/linux/swapops.h |  4 ++--
 mm/filemap.c            | 10 +++++-----
 mm/hugetlb.c            |  2 +-
 mm/migrate.c            | 31 +++++++++++++------------------
 5 files changed, 22 insertions(+), 27 deletions(-)

-- 
2.23.0

