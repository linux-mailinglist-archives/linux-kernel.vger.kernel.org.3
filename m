Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C307C4C9FBA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239384AbiCBIrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiCBIrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:47:46 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D62EBB08E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:47:03 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z16so1321909pfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n5vkvz8TS8A/TWoh79lH9r9rs5OiOfx+UY7K0dS1wLk=;
        b=wl2TmBKvSygE3gpYnoEtAVUPwIHbIZfqPBnxY1Sa4fLuCtcwbvEh96XNKvJeFoTBGY
         zyMot7wIAREuVKNjfHTA88VWlv/6wBBaV27OciwAirMzkKbi3U6DXHPQZJNwTq/KCk5y
         ziLSLuqBHgOW2ZZA1cncwbUtgLeHqkly3yK1Ihuxndwh9dB9V0HaFAPN0os+jH+uaVuG
         B5A6fCFnCdJQ1QCkqJJnlxeKFGQoDyH6J6zwd+ZEjcHM3VcRV5Wh7QnT2CxbpbMRTf+2
         FfmQGJEQJTRPs9qmuqY5UXoCvSHjnlWnoxAqd1DZ1YgxqRuRXQH7/u5WUjKrvcKNjzaG
         UWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n5vkvz8TS8A/TWoh79lH9r9rs5OiOfx+UY7K0dS1wLk=;
        b=Pvm9eVz/gXK0PsHGol3H5gxSG2kuhzwbdnkfJyHm3XpJtYrvQrxrt5ASQmFtJ714Hr
         7+CfXa2E2VX0/Nv9z6s3+oXZ2td4DT7PF6uWDHunYpiqQ0iG63FydSlHAWVKJYralEdZ
         7I1J7zWdyEiHFEJwfh4u+LYfmPLzxgPhqi8iS3Bzz7NBPv8ViYDsw4f+arFQ4K0rzCxU
         GPb6M+9hx7PnWAjYrP3N26FP8+0Y0TpKhXw+qLCkI6nECOzsxh2Ob6CuGfibGtb9Gglk
         S98UqbblZJ7q6N7H3XnyzfTggzT1g8JylsY6Jok5XqlOPO5np6/PLV4Iv9wwJS7I2o7r
         NExw==
X-Gm-Message-State: AOAM531I5TzIqVtjE7Iv7UedP2H5e3V45JRAkalpTrNPuOFiThIaWOrE
        t5A7Vh0+UlLjx8W4uXA6H7nnDA==
X-Google-Smtp-Source: ABdhPJyAYZXpZGvAJrNyThqIJZ03hBH5XLxTn59gglkVUBWGfIWTNTaemO7wpw61WlPlckKkeVFjrw==
X-Received: by 2002:a05:6a00:de:b0:4e0:ca1a:9f07 with SMTP id e30-20020a056a0000de00b004e0ca1a9f07mr32280686pfj.11.1646210822468;
        Wed, 02 Mar 2022 00:47:02 -0800 (PST)
Received: from FVFYT0MHHV2J.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id s10-20020a63214a000000b003652f4ee81fsm14828816pgm.69.2022.03.02.00.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 00:47:02 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        bodeddub@amazon.com, osalvador@suse.de, mike.kravetz@oracle.com,
        rientjes@google.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        james.morse@arm.com, song.bao.hua@hisilicon.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 RESEND 2/2] arm64: mm: hugetlb: add support for free vmemmap pages of HugeTLB
Date:   Wed,  2 Mar 2022 16:46:24 +0800
Message-Id: <20220302084624.33340-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220302084624.33340-1-songmuchun@bytedance.com>
References: <20220302084624.33340-1-songmuchun@bytedance.com>
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

