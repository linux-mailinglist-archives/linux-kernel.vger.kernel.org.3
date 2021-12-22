Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D954547D098
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244456AbhLVLOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:14:53 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:46872 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244450AbhLVLOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:14:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V.QKPtU_1640171689;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V.QKPtU_1640171689)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Dec 2021 19:14:50 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     ying.huang@intel.com, dave.hansen@linux.intel.com, ziy@nvidia.com,
        shy828301@gmail.com, zhongjiang-ali@linux.alibaba.com,
        xlpang@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add a new scheme to support demotion on tiered memory system
Date:   Wed, 22 Dec 2021 19:14:39 +0800
Message-Id: <cover.1640171137.git.baolin.wang@linux.alibaba.com>
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

Changes from v1:
 - Reuse the demote_page_list().
 - Fix some comments style issues.
 - Move the DAMOS_DEMOTE definition to the correct place.
 - Rename some function name.
 - Change to return void type for damos_isolate_page().
 - Remove unnecessary PAGE_ALIGN() in damos_demote().
 - Fix the return value for damos_demote().

Baolin Wang (2):
  mm: Export the demote_page_list() function
  mm/damon: Add a new scheme to support demotion on tiered memory system

 include/linux/damon.h |   3 ++
 mm/damon/dbgfs.c      |   1 +
 mm/damon/vaddr.c      | 147 ++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/internal.h         |   2 +
 mm/vmscan.c           |   4 +-
 5 files changed, 155 insertions(+), 2 deletions(-)

-- 
1.8.3.1

