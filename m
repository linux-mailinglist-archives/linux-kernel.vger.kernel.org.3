Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768ED4EC788
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347459AbiC3O4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244129AbiC3O4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:56:51 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5B249CB8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:55:06 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f10so10306721plr.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FR1FYGjzBBFVsMjKKkaOUa/tpuD2LjaT4A9QUhniUPw=;
        b=6I1kzpLw81ZLlolZkl/RjPaD+BdQRQC/HBh+0/RQ1w0Y0SRH7SYx7nJNgG0kRKd9yL
         jtuZoAA2jUHYyMo8Yhnva/4GT+HWMqg/v6F/jD0dliLoblQpeqR8NeImY/jV4MyMPtE3
         ra6wnisQSJZKXM7sCqPDpcgSjh9pwETskySogCzn6p2I0J3Vw/7oIB9HhF+jNVDiwf9n
         Zr03cdrSe0gEtLpfErESGbvagcgjYLPMJuzcceQu18EdDuBJCYEU8ETfyweM2V1PiO/O
         AIEoWMUzHw4QjSBU8vAV5NKrQjK8m1EaKm6wclNj3+ECSayjXZRv8TwfGX12bXndtKsy
         JJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FR1FYGjzBBFVsMjKKkaOUa/tpuD2LjaT4A9QUhniUPw=;
        b=Z2XLjj5HS+NCRK083hccQRnCdXId1xjmEfS5UhLFL/59M1QTwgU96MoV6Ss+BkiqPJ
         x7gznLKrNfMtnsiu4i21O/5flZHSQgb443I795xbJVUkW380w8pGsYRivLgIu4d18ax5
         cEMb/pH51sbDiVThj2ap3Uc/gh++jOGxgea6IJoD9CZcxnTdh++LepCYCnC0mu5FK0v6
         aQ9uFevC8thhFwTLHj6f2twhpomB/zkzyYdHJaT9np2RvW6Pt/Bh53sxD7QfYsx1QtcU
         wjI+96EdWHaQ82Hwxncu7WFOvy1T8lnxTxRdYMjNtrxqL+f8b62h87WRxbCmZR/og4pJ
         KRiQ==
X-Gm-Message-State: AOAM5321dqhtPfQ1/zzSv4wdOJ7lyq/2WAmrWiZ3mw0gxlrHFlOxAEZq
        I384wiFTtXD2GUpy9GdEbR/xO1v/K6JrOg==
X-Google-Smtp-Source: ABdhPJw4HvO7Gh7pHgNX8rhNx/r/CsKhA4e//A3XD5NLH95YhJJ3Pd64W0SCZufUOy+BAlzj9sqMAw==
X-Received: by 2002:a17:90b:1c07:b0:1c7:5324:c68e with SMTP id oc7-20020a17090b1c0700b001c75324c68emr5600650pjb.202.1648652105388;
        Wed, 30 Mar 2022 07:55:05 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id a71-20020a63904a000000b00398666dcf8esm8236283pge.40.2022.03.30.07.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 07:55:05 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        bodeddub@amazon.com, osalvador@suse.de, mike.kravetz@oracle.com,
        rientjes@google.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        james.morse@arm.com, 21cnbao@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3] arm64: mm: hugetlb: Enable HUGETLB_PAGE_FREE_VMEMMAP for arm64
Date:   Wed, 30 Mar 2022 22:54:00 +0800
Message-Id: <20220330145400.18565-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
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

The infrastructure of freeing vmemmap pages associated with each HugeTLB
page is already there, we can easily enable HUGETLB_PAGE_FREE_VMEMMAP
for arm64, the only thing to be fixed is flush_dcache_page() .

flush_dcache_page() need to be adapted to operate on the head page's
flags since the tail vmemmap pages are mapped with read-only after the
feature is enabled (clear operation is not permitted).

There was some discussions about this in the thread [2], but there was
no conclusion in the end.  And I copied the concern proposed by Anshuman
to here and explain why those concern is superfluous.  It is safe to
enable it for x86_64 as well as arm64.

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
PTEs or splits the PMD entry (which means allocating a PTE page table).  Both
operations do not free any page tables (PTE), so ptdump cannot run into a
UAF on any page tables.  The worst case is just dumping an wrong value.

[1] https://lore.kernel.org/all/20210510030027.56044-1-songmuchun@bytedance.com/
[2] https://lore.kernel.org/all/20210518091826.36937-1-songmuchun@bytedance.com/

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v3:
 - Rework patch's subject.
 - Clarify the feature of HUGETLB_PAGE_FREE_VMEMMAP is already there in the
   current code and easyly be enabled for arm64 into commit log.
 - Add hugetlb_free_vmemmap_enabled() check into flush_dcache_page().

 Thanks for Barry's suggestions.

v2:
 - Update commit message (Mark Rutland).
 - Fix flush_dcache_page().

 arch/arm64/mm/flush.c | 13 +++++++++++++
 fs/Kconfig            |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index a06c6ac770d4..487ab9032c13 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -75,6 +75,19 @@ EXPORT_SYMBOL_GPL(__sync_icache_dcache);
  */
 void flush_dcache_page(struct page *page)
 {
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
+	if (hugetlb_free_vmemmap_enabled() && PageHuge(page))
+		page = compound_head(page);
+
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

