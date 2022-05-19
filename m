Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22DB52D2F7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbiESMua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiESMuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:50:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF0CBA98C
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:50:19 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L3qPj11TNzQkLs;
        Thu, 19 May 2022 20:47:21 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 20:50:15 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>, <rcampbell@nvidia.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v4 0/5] A few fixup patches for mm
Date:   Thu, 19 May 2022 20:50:25 +0800
Message-ID: <20220519125030.21486-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
This series contains a few patches to avoid mapping random data if swap
read fails and fix lost swap bits in unuse_pte. Also we free hwpoison and
swapin error entry in madvise_free_pte_range and so on. More details can
be found in the respective changelogs. Thanks!

---
v4:
  collect Reviewed-by per Naoya and David. Thanks for review!
  fix infinite loop when swap in shmem error. Thanks Naoya for reporting
the issue!
v3:
  collect Acked-by tag per David
  remove unneeded pte wrprotect per David
v2:
  make the terminology consistent and collect Acked-by tag per David
  fix lost swap bits in unuse_pte per Peter
  free hwpoison and swapin error entry per Alistair
  Many thanks Alistair, David and Peter for review!
---
Miaohe Lin (5):
  mm/swapfile: unuse_pte can map random data if swap read fails
  mm/swapfile: Fix lost swap bits in unuse_pte()
  mm/madvise: free hwpoison and swapin error entry in
    madvise_free_pte_range
  mm/shmem: fix infinite loop when swap in shmem error at swapoff time
  mm: filter out swapin error entry in shmem mapping

 include/linux/swap.h    |  7 ++++++-
 include/linux/swapops.h | 10 ++++++++++
 mm/madvise.c            | 18 ++++++++++++------
 mm/memory.c             |  5 ++++-
 mm/shmem.c              | 39 +++++++++++++++++++++++++++++++++++++++
 mm/swap_state.c         |  3 +++
 mm/swapfile.c           | 21 ++++++++++++++++++---
 7 files changed, 92 insertions(+), 11 deletions(-)

-- 
2.23.0

