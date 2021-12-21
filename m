Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9928A47BCBB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbhLUJSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:18:33 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:59146 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236327AbhLUJSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:18:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V.KCb05_1640078307;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V.KCb05_1640078307)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Dec 2021 17:18:27 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     ying.huang@intel.com, dave.hansen@linux.intel.com, ziy@nvidia.com,
        shy828301@gmail.com, zhongjiang-ali@linux.alibaba.com,
        xlpang@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add a new scheme to support demotion on tiered memory system
Date:   Tue, 21 Dec 2021 17:18:02 +0800
Message-Id: <cover.1640077468.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now on tiered memory system with different memory types, the reclaim path in
shrink_page_list() already support demoting pages to slow memory node instead
of discarding the pages. However, at that time the fast memory node memory
wartermark is already tense, which will increase the memory allocation latency
during page demotion. So a new method from user space demoting cold pages
proactively will be more helpful.

We can rely on the DAMON in user space to help to monitor the cold memory on
fast memory node, and demote the cold pages to slow memory node proactively to
keep the fast memory node in a healthy state.

This patch set introduces a new scheme named DAMOS_DEMOTE to support this feature,
and works well from my testing. Any comments are welcome. Thanks.


Baolin Wang (2):
  mm: Export the alloc_demote_page() function
  mm/damon: Add a new scheme to support demotion on tiered memory system

 include/linux/damon.h |   3 +
 mm/damon/dbgfs.c      |   1 +
 mm/damon/vaddr.c      | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/internal.h         |   1 +
 mm/vmscan.c           |   2 +-
 5 files changed, 162 insertions(+), 1 deletion(-)

-- 
1.8.3.1

