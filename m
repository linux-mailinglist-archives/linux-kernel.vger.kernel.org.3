Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF81C55A87A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbiFYJ2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiFYJ2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:28:21 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DD4B860
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:28:20 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LVTBR14TTz1KC0w;
        Sat, 25 Jun 2022 17:26:07 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 25 Jun
 2022 17:28:17 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <shy828301@gmail.com>, <zokeefe@google.com>, <aarcange@redhat.com>,
        <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 0/7] A few cleanup patches for khugepaged
Date:   Sat, 25 Jun 2022 17:28:09 +0800
Message-ID: <20220625092816.4856-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
This series contains a few cleaup patches to remove unneeded return
value, use helper macro, fix typos and so on. More details can be
found in the respective changelogs. Thanks!
---
v2
  rebase on linux-next-20220624
  collect Reviewed-by tag per Yang Shi, Zach. Thanks.
  tweak commit log of 1/7
  avoid relocking mmap_sem and adjust "swapped_in++" in 2/7
  add comment for nr_none and NR_SHMEM in 4/7
  align args with the opening brace in 5/7 and 6/7
  do free_swap_cache before put_page in 7/7
---
Miaohe Lin (7):
  mm/khugepaged: remove unneeded shmem_huge_enabled() check
  mm/khugepaged: stop swapping in page when VM_FAULT_RETRY occurs
  mm/khugepaged: trivial typo and codestyle cleanup
  mm/khugepaged: minor cleanup for collapse_file
  mm/khugepaged: use helper macro __ATTR_RW
  mm/khugepaged: remove unneeded return value of
    khugepaged_add_pte_mapped_thp()
  mm/khugepaged: try to free transhuge swapcache when possible

 include/linux/swap.h |   5 ++
 mm/khugepaged.c      | 137 ++++++++++++++++++++-----------------------
 mm/swap.h            |   5 --
 3 files changed, 69 insertions(+), 78 deletions(-)

-- 
2.23.0

