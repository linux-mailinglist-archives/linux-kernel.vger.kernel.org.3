Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412C650DE87
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiDYLQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241704AbiDYLPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:15:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310292A26E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:12:11 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kn2Qd3VjxzhYlG;
        Mon, 25 Apr 2022 19:11:53 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 19:12:08 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ying.huang@intel.com>, <iamjoonsoo.kim@lge.com>, <hch@lst.de>,
        <osalvador@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v3 0/6] A few cleanup and fixup patches for vmscan
Date:   Mon, 25 Apr 2022 19:12:26 +0800
Message-ID: <20220425111232.23182-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
v3:
  patch 1/9: collect Reviewed-by tag and add a period in the comment.
  patch 2/9: dropped
  patch 3/9: use folio_putback_lru()
  patch 4/9: dropped
  patch 5/9: collect Reviewed-by tag
  patch 7/9: splitted out to make it easier to move forward
v2:
  patch 1/9: drop code change and add a comment about MADV_FREE
  patch 2/9: simplify the code further and change to goto keep_locked
  patch 3/9: use folio, remove unneeded inline and break craze long lines
  patch 5/9: activate swap-backed executable folios after first usage too
  patch 9/9: new cleanup patch splitted from 5/9
  Many thanks Huang Ying, Matthew Wilcox, Christoph Hellwig, Muchun Song
  for review!
---

Miaohe Lin (6):
  mm/vmscan: add a comment about MADV_FREE pages check in
    folio_check_dirty_writeback
  mm/vmscan: introduce helper function reclaim_page_list()
  mm/vmscan: activate swap-backed executable folios after first usage
  mm/vmscan: take all base pages of THP into account when race with
    speculative reference
  mm/vmscan: remove obsolete comment in kswapd_run
  mm/vmscan: use helper folio_is_file_lru()

 mm/vmscan.c | 64 +++++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

-- 
2.23.0

