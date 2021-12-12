Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED374719C9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 12:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhLLLcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 06:32:13 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:45927 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230156AbhLLLcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 06:32:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V-JXZGi_1639308729;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V-JXZGi_1639308729)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 12 Dec 2021 19:32:10 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, ying.huang@intel.com,
        dave.hansen@linux.intel.com
Cc:     ziy@nvidia.com, shy828301@gmail.com, baolin.wang@linux.alibaba.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] Add speculative numa fault support
Date:   Sun, 12 Dec 2021 19:31:56 +0800
Message-Id: <cover.1639306956.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This RFC patch set adds speculative numa fault support for some scenarios,
like tiered memory system. On tiered memory system, it will rely on the
numa balancing to promote slow and hot memory to fast memory to improve
performance. So we can promote several sequential pages on slow memory
in advance according to the data locality for some workloads to improve
the performance.

So now how much pages need to be promoted to fast memory is the best? 
Now this RFC patch set only implements a basic and simple mechanism to
speculate the numa fault window for each VMA. It will introduce a new
atomic member for each VMA to record the numa fault window information,
which is used to determine if it is a sequential stream to expand or
reduance the numa fault window.

Now I can see about 6% improvement when testing mysql on tiered memory
system, more data can be found in patch 1. Looking forword to comments
and suggestion to make the algorithm more robust and suitable for more
scenarios. Thanks in advance.

Note: this patch set is based on the patch set implemented the tiered memory
promotion[1].

[1]
https://lore.kernel.org/lkml/87bl2gsnrd.fsf@yhuang6-desk2.ccr.corp.intel.com/T/

Baolin Wang (4):
  mm: Add speculative numa fault support
  mm: Add a debug interface to control the range of speculative numa
    fault
  mm: Add speculative numa fault stats
  mm: Update the speculative pages' accessing time

 include/linux/mm_types.h      |   3 +
 include/linux/vm_event_item.h |   1 +
 mm/memory.c                   | 222 ++++++++++++++++++++++++++++++++--
 mm/vmstat.c                   |   1 +
 4 files changed, 216 insertions(+), 11 deletions(-)

-- 
2.27.0

