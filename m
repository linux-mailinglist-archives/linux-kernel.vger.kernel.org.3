Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BF45ACA7C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbiIEGWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbiIEGWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:22:10 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADAC2D1E7
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 23:22:08 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662358927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/EmRqq41ljuA3anBfMzi/BhpJJzz0kXo70oG+iPsn5E=;
        b=k6f/GYzvNxbLuVoryjBSqJ4aoEL1gkkHoKbO7iCbgYit3VfsN+mI8HxrK/YzgxPreJDQHN
        DxJjk+fY5fYUqFnJ1KqCiyosUq09fCcUuEcc78RfisgpjwpW8YFbg2ZGe5T7R3j9LYZqSX
        ezeHiP6xfO16WFVz5evIVc7uhhZJBzs=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] mm, hwpoison: improve handling workload related to hugetlb and memory_hotplug
Date:   Mon,  5 Sep 2022 15:21:33 +0900
Message-Id: <20220905062137.1455537-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset tries to solve the issue among memory_hotplug, hugetlb and
hwpoison.  Based on the discussion on v1, this version goes in the
direction of changing the behavior of memory hotplug for hwpoison:

  - hwpoison pages should not prevent memory hotremove,
  - memory block with hwpoison pages should not be onlined.

I tested both with ACPI-based and sysfs-based memory hotplug, and passed
basic testcases.

Any comments and feedbacks would be appreciated.

Thanks,
Naoya Horiguchi

v1: https://lore.kernel.org/linux-mm/20220427042841.678351-1-naoya.horiguchi@linux.dev/T
---
Summary:

Naoya Horiguchi (4):
      mm,hwpoison,hugetlb,memory_hotplug: hotremove memory section with hwpoisoned hugepage
      mm/hwpoison: move definitions of num_poisoned_pages_* to memory-failure.c
      mm/hwpoison: pass pfn to num_poisoned_pages_*()
      mm/hwpoison: introduce per-memory_block hwpoison counter

 arch/parisc/kernel/pdt.c |  5 ++---
 drivers/base/memory.c    | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/memory.h   |  3 +++
 include/linux/mm.h       | 12 ++++++++++++
 include/linux/swapops.h  | 25 -------------------------
 mm/internal.h            |  8 --------
 mm/memory-failure.c      | 45 +++++++++++++++++++++++----------------------
 mm/memory_hotplug.c      | 22 +++++++++++-----------
 mm/sparse.c              |  2 --
 9 files changed, 87 insertions(+), 71 deletions(-)
