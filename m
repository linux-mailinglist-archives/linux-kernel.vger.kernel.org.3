Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3175150D0BD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 11:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbiDXJNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 05:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiDXJNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 05:13:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA4B66C96
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 02:10:42 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KmMn24jxnzhYT6;
        Sun, 24 Apr 2022 17:10:30 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 24 Apr
 2022 17:10:40 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <david@redhat.com>, <apopple@nvidia.com>,
        <surenb@google.com>, <minchan@kernel.org>, <peterx@redhat.com>,
        <sfr@canb.auug.org.au>, <naoya.horiguchi@nec.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v3 0/3] A few fixup patches for mm
Date:   Sun, 24 Apr 2022 17:11:02 +0800
Message-ID: <20220424091105.48374-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
This series contains a few patches to avoid mapping random data if swap
read fails and fix lost swap bits in unuse_pte. Also we free hwpoison and
swapin error entry in madvise_free_pte_range. More details can be found
in the respective changelogs. Thanks!

---
v3:
  collect Acked-by tag per David
  remove unneeded pte wrprotect per David
v2:
  make the terminology consistent and collect Acked-by tag per David
  fix lost swap bits in unuse_pte per Peter
  free hwpoison and swapin error entry per Alistair
  Many thanks Alistair, David and Peter for review!
---
Miaohe Lin (3):
  mm/swapfile: unuse_pte can map random data if swap read fails
  mm/swapfile: Fix lost swap bits in unuse_pte()
  mm/madvise: free hwpoison and swapin error entry in
    madvise_free_pte_range

 include/linux/swap.h    |  7 ++++++-
 include/linux/swapops.h | 10 ++++++++++
 mm/madvise.c            | 13 ++++++++-----
 mm/memory.c             |  5 ++++-
 mm/swapfile.c           | 21 ++++++++++++++++++---
 5 files changed, 46 insertions(+), 10 deletions(-)

-- 
2.23.0

