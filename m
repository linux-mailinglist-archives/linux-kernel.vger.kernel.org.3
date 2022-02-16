Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDCC4B842A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiBPJPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:15:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiBPJP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:15:28 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97C4217F9F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:15:15 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JzC1W51Wdz9sfB;
        Wed, 16 Feb 2022 17:13:35 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 16 Feb
 2022 17:15:12 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 0/8] A few cleanup and fixup patches for memory failure
Date:   Wed, 16 Feb 2022 17:14:23 +0800
Message-ID: <20220216091431.39406-1-linmiaohe@huawei.com>
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

Hi,
This series contains a few patches to simplify the code logic, remove
unneeded variable and remove obsolete comment. Also we fix race changing
page more robustly in memory_failure. More details can be found in the
respective changelogs. Thanks!

---
v1->v2:
  Collect Acked-by tag and fix review comment.
  Thanks Naoya.
---
Miaohe Lin (8):
  mm/memory-failure.c: minor clean up for memory_failure_dev_pagemap
  mm/memory-failure.c: catch unexpected -EFAULT from vma_address()
  mm/memory-failure.c: rework the signaling logic in kill_proc
  mm/memory-failure.c: fix race with changing page more robustly
  mm/memory-failure.c: remove PageSlab check in hwpoison_filter_dev
  mm/memory-failure.c: rework the try_to_unmap logic in
    hwpoison_user_mappings()
  mm/memory-failure.c: remove obsolete comment in __soft_offline_page
  mm/memory-failure.c: remove unnecessary PageTransTail check

 mm/memory-failure.c | 87 +++++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 50 deletions(-)

-- 
2.23.0

