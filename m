Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC7F58ADC8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbiHEQAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238497AbiHEQAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CD421C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659715208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=I84jJZh3uMy8OjbvjnM/V7a2QEPXmVsEuIStQ5Ektjw=;
        b=U9oBtOfDFZDcPLfhFSPmRWkrEyYBV2GzyjYfhVDwpWqvv51vNnEaSiWhQ0QK2wN1uHL24D
        xKFo89MxBfCecU6uU4EHbgeh2VjRwpT0VJ4yXiV2+R9e5TppW1+nFh88Wxofnl8TlGHXzN
        XhZGVT1CofBFxMWOTdSp0DdhfcixHw4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-evv8nOt-PEKAmk78xPeHlA-1; Fri, 05 Aug 2022 12:00:07 -0400
X-MC-Unique: evv8nOt-PEKAmk78xPeHlA-1
Received: by mail-qt1-f198.google.com with SMTP id a6-20020ac86106000000b0033f73d965acso2185921qtm.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 09:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=I84jJZh3uMy8OjbvjnM/V7a2QEPXmVsEuIStQ5Ektjw=;
        b=A+I2P72mxfVL0tR6b/rp7FJptV/QAeZl6dCSQQAN8km4uykUGE2X4FoCGaoEs2tB5k
         8F/MflOPU2o9RrQbnC6hLPcmEFy1eehHNa0xWJtPo4PFGLRTS3Rc5XE634vY7ouFkv61
         8QOLOgavEAEySaiAk31YwTG/x4qJWAIaNc04Oj+oQtFsP2LvQMSBlUBAUlE9YzNG+nlm
         1t851ZV2M0TMJbYuuwuA2HLOqGowOy6AOIMl3Bv7e3z7k2N2hbuS1NgLmtHXstJRUQQY
         eOYCvcnsHYXmxO2YYuSJZpTwPVUbNXvErPtOcAtt+gWWaVuuZpVsoTIu+BvknxFcK909
         fSLA==
X-Gm-Message-State: ACgBeo0Dy3O3YHyXJU+5FSg40VLwDp8hnIWpnIHRl5GD0DclAVMr8Jgo
        yUIJN8ibRmLLkVeo0u6OqsU1u/C8lANoA8yrPxJndTbevqBygcsCZMU5WjLcBuBhscEbuXaxO5J
        B6bVFkM9YzycewQ59nPZekhkzPg1+YC4r6CXse53qkENNsHOgcJzYuK+hXfzt3zXhjHIyQzCsMg
        ==
X-Received: by 2002:a05:622a:4c7:b0:31f:dd6:93ca with SMTP id q7-20020a05622a04c700b0031f0dd693camr6296157qtx.526.1659715206447;
        Fri, 05 Aug 2022 09:00:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6PHOhKBqkOUNsdNVGM60zSMR0a7lfTCil/iE/ktiqNKF6nIKAk9dOBI8Mxu+yZTUrPUrRYRw==
X-Received: by 2002:a05:622a:4c7:b0:31f:dd6:93ca with SMTP id q7-20020a05622a04c700b0031f0dd693camr6296114qtx.526.1659715206125;
        Fri, 05 Aug 2022 09:00:06 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id r19-20020ac84253000000b0033b9c5c27dfsm2743047qtm.16.2022.08.05.09.00.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Aug 2022 09:00:05 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2] mm/smaps: Don't access young/dirty bit if pte unpresent
Date:   Fri,  5 Aug 2022 12:00:03 -0400
Message-Id: <20220805160003.58929-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These bits should only be valid when the ptes are present.  Introducing two
booleans for it and set it to false when !pte_present() for both pte and
pmd accountings.

The bug is found during code reading and no real world issue reported, but
logically such an error can cause incorrect readings for either smaps or
smaps_rollup output on quite a few fields.

For example, it could cause over-estimate on values like Shared_Dirty,
Private_Dirty, Referenced.  Or it could also cause under-estimate on values
like LazyFree, Shared_Clean, Private_Clean.

Cc: Konstantin Khlebnikov <khlebnikov@openvz.org>
Cc: Huang Ying <ying.huang@intel.com>
Fixes: b1d4d9e0cbd0 ("proc/smaps: carefully handle migration entries")
Fixes: c94b6923fa0a ("/proc/PID/smaps: Add PMD migration entry parsing")
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/proc/task_mmu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 9913f3be9fd2..d56c65f98d00 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -527,10 +527,12 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	struct vm_area_struct *vma = walk->vma;
 	bool locked = !!(vma->vm_flags & VM_LOCKED);
 	struct page *page = NULL;
-	bool migration = false;
+	bool migration = false, young = false, dirty = false;
 
 	if (pte_present(*pte)) {
 		page = vm_normal_page(vma, addr, *pte);
+		young = pte_young(*pte);
+		dirty = pte_dirty(*pte);
 	} else if (is_swap_pte(*pte)) {
 		swp_entry_t swpent = pte_to_swp_entry(*pte);
 
@@ -560,8 +562,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	if (!page)
 		return;
 
-	smaps_account(mss, page, false, pte_young(*pte), pte_dirty(*pte),
-		      locked, migration);
+	smaps_account(mss, page, false, young, dirty, locked, migration);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -572,11 +573,13 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct vm_area_struct *vma = walk->vma;
 	bool locked = !!(vma->vm_flags & VM_LOCKED);
 	struct page *page = NULL;
-	bool migration = false;
+	bool migration = false, young = false, dirty = false;
 
 	if (pmd_present(*pmd)) {
 		/* FOLL_DUMP will return -EFAULT on huge zero page */
 		page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
+		young = pmd_young(*pmd);
+		dirty = pmd_dirty(*pmd);
 	} else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
 		swp_entry_t entry = pmd_to_swp_entry(*pmd);
 
@@ -596,8 +599,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	else
 		mss->file_thp += HPAGE_PMD_SIZE;
 
-	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd),
-		      locked, migration);
+	smaps_account(mss, page, true, young, dirty, locked, migration);
 }
 #else
 static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
-- 
2.32.0

