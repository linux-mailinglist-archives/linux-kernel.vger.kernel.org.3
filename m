Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D53053B2DA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 07:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiFBFHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 01:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiFBFHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 01:07:04 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5950EBC8A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 22:07:00 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654146416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SCBnvwHlKpwI3ER7b6V0rjnJzAjOrcaxxPRFAdzr+/8=;
        b=Wqew7a2yEOyPVrNX8SfcrVfbJq2orOlXM/nzLrt3Ryv+vT9tST+pgV0NgHoQvCIWDZjSWS
        iCCFmVMbsi26tS2jSGe9W2lwLl80Sop0b4lYLjNztTVZmVNul2atyE9mL+zcs9PlmlzwVP
        SdnKokjCsV+7B52H7zulystM7Pht1Aw=
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
Subject: [PATCH v1 0/5] mm, hwpoison: enable 1GB hugepage support
Date:   Thu,  2 Jun 2022 14:06:26 +0900
Message-Id: <20220602050631.771414-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset enables memory error handling on 1GB hugepage.

"Save raw error page" patch (1/4 of patchset [1]) is necessary, so it's
included in this series (the remaining part of hotplug related things are
still in progress).  Patch 2/5 solves issues in a corner case of hugepage
handling, which might not be the main target of this patchset, but slightly
related.  It was posted separately [2] but depends on 1/5, so I group them
together.

Patch 3/5 to 5/5 are main part of this series and fix a small issue about
handling 1GB hugepage, which I hope will be workable.

[1]: https://lore.kernel.org/linux-mm/20220427042841.678351-1-naoya.horiguchi@linux.dev/T/#u

[2]: https://lore.kernel.org/linux-mm/20220511151955.3951352-1-naoya.horiguchi@linux.dev/T/

Please let me know if you have any suggestions and comments.

Thanks,
Naoya Horiguchi
---
Summary:

Naoya Horiguchi (5):
      mm, hwpoison, hugetlb: introduce SUBPAGE_INDEX_HWPOISON to save raw error page
      mm,hwpoison: set PG_hwpoison for busy hugetlb pages
      mm, hwpoison: make __page_handle_poison returns int
      mm, hwpoison: skip raw hwpoison page in freeing 1GB hugepage
      mm, hwpoison: enable memory error handling on 1GB hugepage

 include/linux/hugetlb.h | 24 ++++++++++++++++++++++++
 include/linux/mm.h      |  2 +-
 include/ras/ras_event.h |  1 -
 mm/hugetlb.c            |  9 +++++++++
 mm/memory-failure.c     | 48 +++++++++++++++++++++---------------------------
 5 files changed, 55 insertions(+), 29 deletions(-)
