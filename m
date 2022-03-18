Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435F44DC913
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbiCQOnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbiCQOnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:43:08 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8307C200947
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:41:50 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KK8q43V09z1GCTj;
        Thu, 17 Mar 2022 22:36:48 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 22:41:47 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <baolin.wang@linux.alibaba.com>,
        <ying.huang@intel.com>, <songmuchun@bytedance.com>,
        <apopple@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 00/11] A few cleanup and fixup patches for migration
Date:   Fri, 18 Mar 2022 19:16:58 +0800
Message-ID: <20220318111709.60311-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
This series contains a few patches to remove unneeded variables, jump
label and use helper to simplify the code. Also we fix some bugs such
as page refcounts leak , invalid node access and so on. More details
can be found in the respective changelogs. Thanks!

---
v1->v2:
  collect reviewed-by tag
  fix some commit log
  remove unneeded nr_failed assignment per Huang Ying
  getting the types correct to use min() per Andrew
  delay some patches to make this easier to move forward
  Thanks Muchun, Baolin, Zi Yan,Huang Ying, Andrew, Alistair for review!
---
Miaohe Lin (11):
  mm/migration: remove unneeded local variable mapping_locked
  mm/migration: remove unneeded out label
  mm/migration: remove unneeded local variable page_lru
  mm/migration: fix the confusing PageTransHuge check
  mm/migration: use helper function vma_lookup() in
    add_page_for_migration
  mm/migration: use helper macro min in do_pages_stat
  mm/migration: avoid unneeded nodemask_t initialization
  mm/migration: remove some duplicated codes in migrate_pages
  mm/migration: fix potential page refcounts leak in migrate_pages
  mm/migration: fix potential invalid node access for reclaim-based
    migration
  mm/migration: fix possible do_pages_stat_array racing with memory
    offline

 mm/migrate.c | 94 +++++++++++++++++++++++-----------------------------
 1 file changed, 42 insertions(+), 52 deletions(-)

-- 
2.23.0

