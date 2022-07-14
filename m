Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53450574300
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 06:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbiGNE3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 00:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbiGNE16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 00:27:58 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00532DAA2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 21:24:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657772670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xQRsmn7swl66NP0Iw4Ku2ejbuHCkGHauBdCb0zlzQVE=;
        b=ejASHl+KCFyL1imH7kiMKDXq8Wfv2Pitub7kRyvA/Twyjh7AJBnRNDc/vYFv1B7bHtSAak
        wyslMFEobQ8ovTkit4N/LxXB7kxWANyKY30YLWrFU6QJ4pcMU0o7RA/GtCZdo/gjBuAJZo
        hSRFcK0Ta6nbPs8e182PdB8fxxXv8CY=
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
Subject: [mm-unstable PATCH v7 0/8] mm, hwpoison: enable 1GB hugepage support (v7)
Date:   Thu, 14 Jul 2022 13:24:12 +0900
Message-Id: <20220714042420.1847125-1-naoya.horiguchi@linux.dev>
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

Here is v7 of "enabling memory error handling on 1GB hugepage" patchset.

I applied feedbacks provided for v6 (thank you, Miaohe).
There're a few improvements on on 3/8 and 4/8.

- v1: https://lore.kernel.org/linux-mm/20220602050631.771414-1-naoya.horiguchi@linux.dev/T/#u
- v2: https://lore.kernel.org/linux-mm/20220623235153.2623702-1-naoya.horiguchi@linux.dev/T/#u
- v3: https://lore.kernel.org/linux-mm/20220630022755.3362349-1-naoya.horiguchi@linux.dev/T/#u
- v4: https://lore.kernel.org/linux-mm/20220704013312.2415700-1-naoya.horiguchi@linux.dev/T/#u
- v5: https://lore.kernel.org/linux-mm/20220708053653.964464-1-naoya.horiguchi@linux.dev/T/#u
- v6: https://lore.kernel.org/linux-mm/20220712032858.170414-1-naoya.horiguchi@linux.dev/T/#u

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
 mm/hugetlb.c              |  58 +++++++++++----
 mm/memory-failure.c       | 179 ++++++++++++++++++++++++++++++++++++++--------
 7 files changed, 226 insertions(+), 48 deletions(-)
