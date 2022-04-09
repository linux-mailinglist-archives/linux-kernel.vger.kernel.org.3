Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1664FA672
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 11:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237852AbiDIJei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 05:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiDIJeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 05:34:37 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511A3D52
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 02:32:30 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kb8yj16b5z1HBPl;
        Sat,  9 Apr 2022 17:31:57 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 9 Apr
 2022 17:32:27 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ying.huang@intel.com>, <songmuchun@bytedance.com>,
        <hch@infradead.org>, <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 0/9] A few cleanup and fixup patches for vmscan
Date:   Sat, 9 Apr 2022 17:32:26 +0800
Message-ID: <20220409093235.59205-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
This series contains a few patches to remove obsolete comment, introduce
helper to remove duplicated code and so no. Also we take all base pages
of THP into account in rare race condition. More details can be found in
the respective changelogs. Thanks!

---
v2:
  patch 1/9: drop code change and add a comment about MADV_FREE
  patch 2/9: simplify the code further and change to goto keep_locked
  patch 3/9: use folio, remove unneeded inline and break craze long lines
  patch 5/9: activate swap-backed executable folios after first usage too
  patch 9/9: new cleanup patch splitted from 5/9
  Many thanks Huang Ying, Matthew Wilcox, Christoph Hellwig, Muchun Song
  for review!
---
Miaohe Lin (9):
  mm/vmscan: add a comment about MADV_FREE pages check in
    folio_check_dirty_writeback
  mm/vmscan: remove unneeded can_split_huge_page check
  mm/vmscan: introduce helper function reclaim_page_list()
  mm/vmscan: save a bit of stack space in shrink_lruvec
  mm/vmscan: activate swap-backed executable folios after first usage
  mm/vmscan: take all base pages of THP into account when race with
    speculative reference
  mm/vmscan: take min_slab_pages into account when try to call
    shrink_node
  mm/vmscan: remove obsolete comment in kswapd_run
  mm/vmscan: use helper folio_is_file_lru()

 mm/vmscan.c | 92 ++++++++++++++++++++++++++---------------------------
 1 file changed, 45 insertions(+), 47 deletions(-)

-- 
2.23.0

