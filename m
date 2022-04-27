Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EECD511025
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 06:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357664AbiD0EcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 00:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350114AbiD0EcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 00:32:04 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F399713EBC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 21:28:54 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651033733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8fVc1RYJLxneaYYpgkElGllkQXs+OIbqjkeJxvpkd40=;
        b=lwmYMM60KvYA71LSYNLhz19i+hcScZCTCQic+ZW7X7VE5wcWypZN19REFGkaLs32k+kFFB
        OCJGDeMbmliV03TMQBNNArpQWaVTnWqDng6mJh3ljBcStrz1uYb/XuQnkO4o0+qmmu+j7m
        6uHBgoF/q6po0EWcO9A1/xZOww+oWvY=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 0/4] mm, hwpoison: improve handling workload related to hugetlb and memory_hotplug
Date:   Wed, 27 Apr 2022 13:28:37 +0900
Message-Id: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset addresses some issues on the workload related to hwpoison,
hugetlb, and memory_hotplug.  The problem in memory hotremove reported by
Miaohe Lin [1] is mentioned in 2/4.  This patch depends on "storing raw
error info" functionality provided by 1/4. This patch also provide delayed
dissolve function too.

Patch 3/4 is to adjust unpoison to new semantics of HPageMigratable for
hwpoisoned hugepage. And 4/4 is the fix for the inconsistent counter issue.

[1] https://lore.kernel.org/linux-mm/20220421135129.19767-1-linmiaohe@huawei.com/

Please let me know if you have any suggestions and comments.

Thanks,
Naoya Horiguchi
---
Summary:

Naoya Horiguchi (4):
      mm, hwpoison, hugetlb: introduce SUBPAGE_INDEX_HWPOISON to save raw error page
      mm,hwpoison,hugetlb,memory_hotplug: hotremove memory section with hwpoisoned hugepage
      mm, hwpoison: add parameter unpoison to get_hwpoison_huge_page()
      mm, memory_hotplug: fix inconsistent num_poisoned_pages on memory hotremove

 include/linux/hugetlb.h | 29 +++++++++++++++++++++++++++--
 mm/hugetlb.c            | 24 ++++++++++++++++++++++--
 mm/memory-failure.c     |  8 ++++++--
 mm/memory_hotplug.c     | 23 +++++++++++------------
 mm/page_alloc.c         |  6 ++++++
 5 files changed, 72 insertions(+), 18 deletions(-)
