Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EBE4CD11E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbiCDJfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237322AbiCDJfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:35:47 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A0118644A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 01:34:59 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K92hf14JLzBrt6;
        Fri,  4 Mar 2022 17:33:06 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 4 Mar
 2022 17:34:56 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <shy828301@gmail.com>,
        <willy@infradead.org>, <ying.huang@intel.com>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>,
        <ave.hansen@linux.intel.com>, <o451686892@gmail.com>,
        <almasrymina@google.com>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 00/16] A few cleanup and fixup patches for migration
Date:   Fri, 4 Mar 2022 17:33:53 +0800
Message-ID: <20220304093409.25829-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
This series contains a few patches to remove unneeded variables, jump
label and use helper to simplify the code. Also we fix some bugs such
as page refcounts leak , pte_unmap on an not mapped pte and so on. More
details can be found in the respective changelogs. Thanks!

Miaohe Lin (16):
  mm/migration: remove unneeded local variable mapping_locked
  mm/migration: remove unneeded out label
  mm/migration: remove unneeded local variable page_lru
  mm/migration: reduce the rcu lock duration
  mm/migration: fix the confusing PageTransHuge check
  mm/migration: use helper function vma_lookup() in
    add_page_for_migration
  mm/migration: use helper macro min_t in do_pages_stat
  mm/migration: avoid unneeded nodemask_t initialization
  mm/migration: remove some duplicated codes in migrate_pages
  mm/migration: remove PG_writeback handle in folio_migrate_flags
  mm/migration: remove unneeded lock page and PageMovable check
  mm/migration: fix potential page refcounts leak in migrate_pages
  mm/migration: return errno when isolate_huge_page failed
  mm/migration: fix potential invalid node access for reclaim-based
    migration
  mm/migration: fix possible do_pages_stat_array racing with memory
    offline
  mm/migration: fix potential pte_unmap on an not mapped pte

 include/linux/migrate.h |   2 +-
 include/linux/swapops.h |   4 +-
 mm/filemap.c            |  10 +--
 mm/hugetlb.c            |   2 +-
 mm/migrate.c            | 138 ++++++++++++++++------------------------
 5 files changed, 65 insertions(+), 91 deletions(-)

-- 
2.23.0

