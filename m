Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26335710D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 05:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiGLD3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 23:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiGLD3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 23:29:14 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7600220FB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:29:12 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657596550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SRovk8wtv0SCrBvCW7pv00a70qBozC/WLLueur0dCSg=;
        b=CNiWcLW3ZOHLe9NZM9y6i6+ebMvY8NDAFQQLvcKrloqpkisgzsBCi8VMolDMGdFGKMCaTn
        385CFwTZEUAaxV/M8bJTXiwV8tnZ1sbblYj+SNU7G2XinZvP4A8PxDPgtgGckkSVqyIi7S
        xZ0g+CD2bsnZ/hQKrosRlbzEYjY5AdY=
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
Subject: [mm-unstable PATCH v6 0/8] mm, hwpoison: enable 1GB hugepage support (v6)
Date:   Tue, 12 Jul 2022 12:28:50 +0900
Message-Id: <20220712032858.170414-1-naoya.horiguchi@linux.dev>
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

Here is v6 of "enabling memory error handling on 1GB hugepage" patchset.

I applied feedbacks provided for v5 (thank you, Miaohe).
All changes (on 1/8, 3/8, and 4/8) are minor ones.

- v1: https://lore.kernel.org/linux-mm/20220602050631.771414-1-naoya.horiguchi@linux.dev/T/#u
- v2: https://lore.kernel.org/linux-mm/20220623235153.2623702-1-naoya.horiguchi@linux.dev/T/#u
- v3: https://lore.kernel.org/linux-mm/20220630022755.3362349-1-naoya.horiguchi@linux.dev/T/#u
- v4: https://lore.kernel.org/linux-mm/20220704013312.2415700-1-naoya.horiguchi@linux.dev/T/#u
- v5: https://lore.kernel.org/linux-mm/20220708053653.964464-1-naoya.horiguchi@linux.dev/T/#u

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
 include/linux/hugetlb.h   |  17 ++++-
 include/linux/mm.h        |   2 +-
 include/linux/swapops.h   |   9 +++
 include/ras/ras_event.h   |   1 -
 mm/hugetlb.c              |  58 +++++++++++++----
 mm/memory-failure.c       | 162 +++++++++++++++++++++++++++++++++++++---------
 7 files changed, 209 insertions(+), 48 deletions(-)
