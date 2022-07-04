Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C679564B32
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 03:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiGDBdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 21:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiGDBdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 21:33:35 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AF5FF9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 18:33:34 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656898412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZNgH5eHPcnq/+3rKXXS1c6RWQGb3F3eUFrPlWLShXcQ=;
        b=SpdN77/fOWWRpW2V7H7g0MG8DDqDeCF63c2jnfpMye/4Uc3Hjg9f13RAOZQYPDt0PsZpE5
        t0ZUWIC9KbfO+TAHF0ACpR8RgeJdBfDJKlR5zTnbjWNvbhE/npSw//SM2TXvlpr5YvZxGW
        Kep2gOytBblyp3HQ7Nv6aGA3vQoyPk4=
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
Subject: [mm-unstable PATCH v4 2/9] mm/hugetlb: separate path for hwpoison entry in copy_hugetlb_page_range()
Date:   Mon,  4 Jul 2022 10:33:05 +0900
Message-Id: <20220704013312.2415700-3-naoya.horiguchi@linux.dev>
In-Reply-To: <20220704013312.2415700-1-naoya.horiguchi@linux.dev>
References: <20220704013312.2415700-1-naoya.horiguchi@linux.dev>
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

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Originally copy_hugetlb_page_range() handles migration entries and hwpoisoned
entries in similar manner.  But recently the related code path has more code
for migration entries, and when is_writable_migration_entry() was converted
to !is_readable_migration_entry(), hwpoison entries on source processes got
to be unexpectedly updated (which is legitimate for migration entries, but
not for hwpoison entries).  This results in unexpected serious issues like
kernel panic when forking processes with hwpoison entries in pmd.

Separate the if branch into one for hwpoison entries and one for migration
entries.

Fixes: 6c287605fd56 ("mm: remember exclusively mapped anonymous pages with PG_anon_exclusive")
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Cc: <stable@vger.kernel.org> # 5.18
---
v3 -> v4:
- replact set_huge_swap_pte_at() with set_huge_pte_at()
---
 mm/hugetlb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bdc4499f324b..ad621688370b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4803,8 +4803,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 * sharing with another vma.
 			 */
 			;
-		} else if (unlikely(is_hugetlb_entry_migration(entry) ||
-				    is_hugetlb_entry_hwpoisoned(entry))) {
+		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry))) {
+			bool uffd_wp = huge_pte_uffd_wp(entry);
+
+			if (!userfaultfd_wp(dst_vma) && uffd_wp)
+				entry = huge_pte_clear_uffd_wp(entry);
+			set_huge_pte_at(dst, addr, dst_pte, entry);
+		} else if (unlikely(is_hugetlb_entry_migration(entry))) {
 			swp_entry_t swp_entry = pte_to_swp_entry(entry);
 			bool uffd_wp = huge_pte_uffd_wp(entry);
 
-- 
2.25.1

