Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF46560F29
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 04:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiF3C2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 22:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiF3C2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 22:28:13 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACB1328
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 19:28:09 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656556088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h/RgYaIOqxfF17jSa9I6epPt/ktZzShhlogXm62GIAw=;
        b=OMA3g9fZhnOKDtZEunrzD5CGHPWlUjn8/XGMWmDXyLDR27zHmHzzL+FdNvqbfGYjF5aCyA
        OW5m5jnwn3879CS7LKVwXBXzq/uLP7YkH/XBNMXrnqquu9QSIzwWJ6ujha+HBniCLh291M
        693Zbw0onGxwpNhU1VEb9ntXaovY8mI=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/9] mm, hwpoison: enable 1GB hugepage support (v3)
Date:   Thu, 30 Jun 2022 11:27:46 +0900
Message-Id: <20220630022755.3362349-1-naoya.horiguchi@linux.dev>
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

Here is v3 of "enabling memory error handling on 1GB hugepage" patchset.

I applied feedbacks for v2, thank you very much.  Overall design of the
patchset is unchanged. Please see individual patches for details about
changes.

Patch dependency:

- "mm/memory-failure: disable unpoison once hw error happens"
  (actually the conflict is not logical one, but adding MF_SIMULATED to
   mf_flags conflicts with patch 6/9.)

Previous versions:

- v1: https://lore.kernel.org/linux-mm/20220602050631.771414-1-naoya.horiguchi@linux.dev/T/#u
- v2: https://lore.kernel.org/linux-mm/20220623235153.2623702-1-naoya.horiguchi@linux.dev/T/#u

Thanks,
Naoya Horiguchi
---
Summary:

Naoya Horiguchi (9):
      mm/hugetlb: check gigantic_page_runtime_supported() in return_unused_surplus_pages()
      mm/hugetlb: separate path for hwpoison entry in copy_hugetlb_page_range()
      mm/hugetlb: make pud_huge() and follow_huge_pud() aware of non-present pud entry
      mm, hwpoison, hugetlb: support saving mechanism of raw error pages
      mm, hwpoison: make unpoison aware of raw error info in hwpoisoned hugepage
      mm, hwpoison: set PG_hwpoison for busy hugetlb pages
      mm, hwpoison: make __page_handle_poison returns int
      mm, hwpoison: skip raw hwpoison page in freeing 1GB hugepage
      mm, hwpoison: enable memory error handling on 1GB hugepage

 arch/x86/mm/hugetlbpage.c |   8 ++-
 include/linux/hugetlb.h   |  18 +++++-
 include/linux/mm.h        |   2 +-
 include/linux/swapops.h   |   9 +++
 include/ras/ras_event.h   |   1 -
 mm/hugetlb.c              |  99 ++++++++++++++++++++++---------
 mm/memory-failure.c       | 148 ++++++++++++++++++++++++++++++++++++----------
 7 files changed, 224 insertions(+), 61 deletions(-)
