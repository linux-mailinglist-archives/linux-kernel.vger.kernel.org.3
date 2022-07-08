Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDB756B245
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 07:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbiGHFhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 01:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiGHFhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 01:37:37 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDB526AFC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 22:37:36 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657258654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9bOl8oP64G0XGZtdjv61c28GEDmXYXsYcMM3i5L7xd0=;
        b=mxRxJbqABfnOpidFV+OiF06xQCC6cYvTfH3PMLu8c3Pu1HEW1746yojW4q+4GwJy3QwKhM
        yAZXp3ZxMf/rD9Ca07y87XhXbtE/4hYuSefFofrEbPIxDLOW+fr1h2KJrmuos6bGmnoJLQ
        dhE7oScZxQBBteGyR9sTXqEqAjfV7wk=
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
Subject: [mm-unstable PATCH v5 0/8] mm, hwpoison: enable 1GB hugepage support (v5)
Date:   Fri,  8 Jul 2022 14:36:45 +0900
Message-Id: <20220708053653.964464-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is v5 of "enabling memory error handling on 1GB hugepage" patchset.

I applied feedbacks provided for v4, thank you very much.

Change overview (see changelog in individual patches for details):

- rebased onto mm-everything-2022-07-08-01-43.
- removed the patch "mm/hugetlb: separate path for hwpoison entry in
  copy_hugetlb_page_range()" because it's separately handled and already
  in mm-hotfixes.

- v1: https://lore.kernel.org/linux-mm/20220602050631.771414-1-naoya.horiguchi@linux.dev/T/#u
- v2: https://lore.kernel.org/linux-mm/20220623235153.2623702-1-naoya.horiguchi@linux.dev/T/#u
- v3: https://lore.kernel.org/linux-mm/20220630022755.3362349-1-naoya.horiguchi@linux.dev/T/#u
- v4: https://lore.kernel.org/linux-mm/20220704013312.2415700-1-naoya.horiguchi@linux.dev/T/#u

Thanks,
Naoya Horiguchi
---
Summary:

Naoya Horiguchi (8):
      mm/hugetlb: check gigantic_page_runtime_supported() in return_unused_surplus_pages()
      mm/hugetlb: make pud_huge() and follow_huge_pud() aware of non-present pud entry
      mm, hwpoison, hugetlb: support saving mechanism of raw error pages
      mm, hwpoison: make unpoison aware of raw error info in hwpoisoned hugepage
      mm, hwpoison: set PG_hwpoison for busy hugetlb pages
      mm, hwpoison: make __page_handle_poison returns int
      mm, hwpoison: skip raw hwpoison page in freeing 1GB hugepage
      mm, hwpoison: enable memory error handling on 1GB hugepage

 arch/x86/mm/hugetlbpage.c |   8 ++-
 include/linux/hugetlb.h   |  18 ++++-
 include/linux/mm.h        |   2 +-
 include/linux/swapops.h   |   9 +++
 include/ras/ras_event.h   |   1 -
 mm/hugetlb.c              |  67 +++++++++++++++----
 mm/memory-failure.c       | 165 +++++++++++++++++++++++++++++++++++++---------
 7 files changed, 222 insertions(+), 48 deletions(-)
