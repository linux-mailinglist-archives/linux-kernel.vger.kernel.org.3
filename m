Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B124AD13A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbiBHFrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbiBHFrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:47:01 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFE2C0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 21:47:00 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id r64-20020a17090a43c600b001b8854e682eso1635409pjg.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 21:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n5vkvz8TS8A/TWoh79lH9r9rs5OiOfx+UY7K0dS1wLk=;
        b=xwZoeurRxp/Fg3bZboK4CN/h1HC/Vg2P1EBa4IptVjAPnMpbRK/gio8e46NPXbSFaC
         7fG0yYZX49kvJAtJ0Xe950EL3Vp5mjFK7BNO/w/tRA56PqaFarWT8v2+ygtfpPcdWzCT
         nY72MZd8q+CnrSKehtl2HKAhjf8HtybkzD5pQJIBsz5UlxbuQs7tqGX7usdbQ8Tsn4fl
         7wFKlJe79Mz5TYLqmSpHZzQdae3GXihCcJ55cRmOdmR/DLkDAjpioTH0xKQEz9IlfzB1
         GK9SsuSPHgMK/ahmN/M80aN8lch8JBxQrPJJY9wcYjmb1wHwae6WoN4279nhb0tzFeUc
         EmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n5vkvz8TS8A/TWoh79lH9r9rs5OiOfx+UY7K0dS1wLk=;
        b=ikx2BGB+VFkR81yMorYrifUUB1thjREUwS/OASrnL1Bfjupi9610/MS0wZH471G/Jk
         Iz5lZbp2YmyOSmr0q843EXF7NeF3dJ5uW66EWxVItM3A0xr7PobXs82I1r/vEn4ROKtN
         C7FifsugErwj+bBqEYYAjjB2GXParPmEu5cwb1494SUcT5eSP/Krb+WoR6gwfXFYQ4LC
         OewDajZZEKBzT+Q5NMcNx2blOSevXqlarDE2umLId8XC02Gek9y+TNkUNRINlmBHWhBS
         ORwn6WgBroPQ0/ZTUC5a0z9DUY4dOEs8iD5EEl26cbhKZF7WQZI6sxtW8Vt1pnEcVbNS
         kqIA==
X-Gm-Message-State: AOAM532RbHPtsq2NsUfxwprg4RKfYdnRHZ7HcA2ErX7esICFnxkvFpCd
        GWDLfMtGb6FLPF0B1ErX2VLgIA==
X-Google-Smtp-Source: ABdhPJxqPkFZwo6hekZ7v7KbQ6pLZIIZTjzsBs5X3gMiMmQSytNbA1jYRKeJ5f2FlbHZ9x6l3r+NOA==
X-Received: by 2002:a17:90b:3ec8:: with SMTP id rm8mr2633625pjb.207.1644299219989;
        Mon, 07 Feb 2022 21:46:59 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id 20sm1160680pjf.15.2022.02.07.21.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 21:46:59 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        bodeddub@amazon.com, osalvador@suse.de, mike.kravetz@oracle.com,
        rientjes@google.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        james.morse@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 2/2] arm64: mm: hugetlb: add support for free vmemmap pages of HugeTLB
Date:   Tue,  8 Feb 2022 13:46:32 +0800
Message-Id: <20220208054632.66534-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220208054632.66534-1-songmuchun@bytedance.com>
References: <20220208054632.66534-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The feature of minimizing overhead of struct page associated with each
HugeTLB page aims to free its vmemmap pages (used as struct page) to
save memory, where is ~14GB/16GB per 1TB HugeTLB pages (2MB/1GB type).
In short, when a HugeTLB page is allocated or freed, the vmemmap array
representing the range associated with the page will need to be remapped.
When a page is allocated, vmemmap pages are freed after remapping.
When a page is freed, previously discarded vmemmap pages must be
allocated before remapping.  More implementations and details can be
found here [1].

The preparation of freeing vmemmap pages associated with each HugeTLB
page is ready, so we can support this feature for arm64 now.  The
flush_dcache_page() need to be adapted to operate on the head page's
flags since the tail vmemmap pages are mapped with read-only after
the feature is enabled (clear operation is not permitted).

There was some discussions about this in the thread [2], but there was
no conclusion in the end.  And I copied the concern proposed by Anshuman
to here.

1st concern:
'''
But what happens when a hot remove section's vmemmap area (which is
being teared down) is nearby another vmemmap area which is either created
or being destroyed for HugeTLB alloc/free purpose. As you mentioned
HugeTLB pages inside the hot remove section might be safe. But what about
other HugeTLB areas whose vmemmap area shares page table entries with
vmemmap entries for a section being hot removed ? Massive HugeTLB alloc
/use/free test cycle using memory just adjacent to a memory hotplug area,
which is always added and removed periodically, should be able to expose
this problem.
'''

Answer: At the time memory is removed, all HugeTLB pages either have been
migrated away or dissolved.  So there is no race between memory hot remove
and free_huge_page_vmemmap().  Therefore, HugeTLB pages inside the hot
remove section is safe.  Let's talk your question "what about other
HugeTLB areas whose vmemmap area shares page table entries with vmemmap
entries for a section being hot removed ?", the question is not
established.  The minimal granularity size of hotplug memory 128MB (on
arm64, 4k base page), any HugeTLB smaller than 128MB is within a section,
then, there is no share PTE page tables between HugeTLB in this section
and ones in other sections and a HugeTLB page could not cross two
sections.  In this case, the section cannot be freed.  Any HugeTLB bigger
than 128MB (section size) whose vmemmap pages is an integer multiple of
2MB (PMD-mapped).  As long as:

  1) HugeTLBs are naturally aligned, power-of-two sizes
  2) The HugeTLB size >= the section size
  3) The HugeTLB size >= the vmemmap leaf mapping size

Then a HugeTLB will not share any leaf page table entries with *anything
else*, but will share intermediate entries.  In this case, at the time memory
is removed, all HugeTLB pages either have been migrated away or dissolved.
So there is also no race between memory hot remove and
free_huge_page_vmemmap().

2nd concern:
'''
differently, not sure if ptdump would require any synchronization.

Dumping an wrong value is probably okay but crashing because a page table
entry is being freed after ptdump acquired the pointer is bad. On arm64,
ptdump() is protected against hotremove via [get|put]_online_mems().
'''

Answer: The ptdump should be fine since vmemmap_remap_free() only exchanges
PTEs or split the PMD entry (which means allocating a PTE page table).  Both
operations do not free any page tables (PTE), so ptdump cannot run into a
UAF on any page tables.  The wrost case is just dumping an wrong value.

[1] https://lore.kernel.org/all/20210510030027.56044-1-songmuchun@bytedance.com/
[2] https://lore.kernel.org/all/20210518091826.36937-1-songmuchun@bytedance.com/

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
Changes in v2:
 - Update commit message (Mark Rutland).
 - Fix flush_dcache_page().

 arch/arm64/mm/flush.c | 14 ++++++++++++++
 fs/Kconfig            |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index a06c6ac770d4..705484a9b9df 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -75,6 +75,20 @@ EXPORT_SYMBOL_GPL(__sync_icache_dcache);
  */
 void flush_dcache_page(struct page *page)
 {
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+	/*
+	 * Only the head page's flags of HugeTLB can be cleared since the tail
+	 * vmemmap pages associated with each HugeTLB page are mapped with
+	 * read-only when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is enabled (more
+	 * details can refer to vmemmap_remap_pte()).  Although
+	 * __sync_icache_dcache() only set PG_dcache_clean flag on the head
+	 * page struct, some tail page structs still can see the flag since
+	 * the head vmemmap page frame is reused (more details can refer to
+	 * the comments above page_fixed_fake_head()).
+	 */
+	if (PageHuge(page))
+		page = compound_head(page);
+#endif
 	if (test_bit(PG_dcache_clean, &page->flags))
 		clear_bit(PG_dcache_clean, &page->flags);
 }
diff --git a/fs/Kconfig b/fs/Kconfig
index 7a2b11c0b803..04cfd5bf5ec9 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -247,7 +247,7 @@ config HUGETLB_PAGE
 
 config HUGETLB_PAGE_FREE_VMEMMAP
 	def_bool HUGETLB_PAGE
-	depends on X86_64
+	depends on X86_64 || ARM64
 	depends on SPARSEMEM_VMEMMAP
 
 config HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON
-- 
2.11.0

