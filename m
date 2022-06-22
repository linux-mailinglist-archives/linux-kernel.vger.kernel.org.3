Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718575551F1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376479AbiFVRGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355762AbiFVRGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:06:30 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0173ED3D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:06:29 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LSqXK6139zDsMQ;
        Thu, 23 Jun 2022 01:05:53 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 23 Jun
 2022 01:06:27 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <shy828301@gmail.com>, <willy@infradead.org>, <zokeefe@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 00/16] A few cleanup patches for huge_memory
Date:   Thu, 23 Jun 2022 01:06:11 +0800
Message-ID: <20220622170627.19786-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
This series contains a few cleaup patches to remove duplicated codes,
add/use helper functions, fix some obsolete comments and so on. More
details can be found in the respective changelogs. Thanks!
---
This patch set is based on linux-next-20220621.
---
Miaohe Lin (16):
  mm/huge_memory: use flush_pmd_tlb_range in move_huge_pmd
  mm/huge_memory: access vm_page_prot with READ_ONCE in
    remove_migration_pmd
  mm/huge_memory: fix comment of __pud_trans_huge_lock
  mm/huge_memory: use helper touch_pud in huge_pud_set_accessed
  mm/huge_memory: use helper touch_pmd in huge_pmd_set_accessed
  mm/huge_memory: rename mmun_start to haddr in remove_migration_pmd
  mm/huge_memory: minor cleanup for split_huge_pages_pid
  mm/huge_memory: use helper macro __ATTR_RW
  mm/huge_memory: fix comment in zap_huge_pud
  mm/huge_memory: check pmd_present first in is_huge_zero_pmd
  mm/huge_memory: try to free subpage in swapcache when possible
  mm/huge_memory: minor cleanup for split_huge_pages_all
  mm/huge_memory: add helper __get_deferred_split_queue
  mm/huge_memory: fix comment of page_deferred_list
  mm/huge_memory: correct comment of prep_transhuge_page
  mm/huge_memory: comment the subtle logic in __split_huge_pmd

 include/linux/huge_mm.h |   6 +-
 mm/huge_memory.c        | 121 ++++++++++++++++------------------------
 2 files changed, 52 insertions(+), 75 deletions(-)

-- 
2.23.0

