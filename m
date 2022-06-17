Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE77D54F0BB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 07:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380169AbiFQFrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 01:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiFQFq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:46:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF7266C9C;
        Thu, 16 Jun 2022 22:46:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B76E01FAF7;
        Fri, 17 Jun 2022 05:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655444815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3nN0uwMwYHIGnvGf1je2kTJf72RD7LvC05n350gAJao=;
        b=M8mPJFXaFRl8/xy8Tz42A0gFlxI4KziLyoj++3uQDgNavMd6xnlh2txXAnkRy8hkDsTzh1
        B0YGRyP0LGre7vtdrdxltbCmtMNWAA9WwY0oUOoxkwm++eFZXkAt22XEwZn3FOWCiffSEA
        Z5LTjH3ey/rK6EDbp8+0XxnxxM0HP2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655444815;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3nN0uwMwYHIGnvGf1je2kTJf72RD7LvC05n350gAJao=;
        b=y9n6WNPT2pFDQWR9Lis2ZM020dZ/WkbveEmcOy9KbJPQXT1iS+gVKpL2e5noqK5OD3RXPd
        HRMGwxNk/JhyCZDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18B741330D;
        Fri, 17 Jun 2022 05:46:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F6AlA08VrGJmVAAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 17 Jun 2022 05:46:55 +0000
Date:   Fri, 17 Jun 2022 07:46:53 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mike.kravetz@oracle.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v2 2/2] mm: memory_hotplug: introduce
 SECTION_CANNOT_OPTIMIZE_VMEMMAP
Message-ID: <YqwVTT+50vt5WpeG@localhost.localdomain>
References: <20220520025538.21144-1-songmuchun@bytedance.com>
 <20220520025538.21144-3-songmuchun@bytedance.com>
 <53024884-0182-df5f-9ca2-00652c64ce36@redhat.com>
 <YqqqPjkh9r8ZrH0r@localhost.localdomain>
 <24d5ec20-9c9e-93aa-11f4-c4619f51f7d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24d5ec20-9c9e-93aa-11f4-c4619f51f7d1@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 09:30:33AM +0200, David Hildenbrand wrote:
> IIRC, that was used to skip these patches on the offlining path before
> we provided the ranges to offline_pages().

Yeah, it was designed for that purpose back then.

> I'd not mess with PG_reserved, and give them a clearer name, to not
> confuse them with other, ordinary, vmemmap pages that are not
> self-hosted (maybe in the future we might want to flag all vmemmap pages
> with a new type?).

Not sure whether a new type is really needed, or to put it another way, I
cannot see the benefit.

> 
> I'd just try reusing the flag PG_owner_priv_1. And eventually, flag all
> (v)memmap pages with a type PG_memmap. However, the latter would be
> optional and might not be strictly required
> 
> 
> So what think could make sense is
> 
> /* vmemmap pages that are self-hosted and cannot be optimized/freed. */
> PG_vmemmap_self_hosted = PG_owner_priv_1,

Sure, I just lightly tested the below, and seems to work, but not sure
whether that is what you are referring to.
@Munchun: thoughts?

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index e66f7aa3191d..a4556afd7bda 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -193,6 +193,11 @@ enum pageflags {
 
 	/* Only valid for buddy pages. Used to track pages that are reported */
 	PG_reported = PG_uptodate,
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+	/* For self-hosted memmap pages */
+	PG_vmemmap_self_hosted = PG_owner_priv_1,
+#endif
 };
 
 #define PAGEFLAGS_MASK		((1UL << NR_PAGEFLAGS) - 1)
@@ -628,6 +633,10 @@ PAGEFLAG_FALSE(SkipKASanPoison, skip_kasan_poison)
  */
 __PAGEFLAG(Reported, reported, PF_NO_COMPOUND)
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+PAGEFLAG(Vmemmap_self_hosted, vmemmap_self_hosted, PF_ANY)
+#endif
+
 /*
  * On an anonymous page mapped into a user virtual memory area,
  * page->mapping points to its anon_vma, not to a struct address_space;
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 1089ea8a9c98..e2de7ed27e9e 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -101,6 +101,14 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
 {
 	unsigned long vmemmap_addr = (unsigned long)head;
 	unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;
+	struct mem_section *ms = __pfn_to_section(page_to_pfn(head));
+	struct page *memmap;
+
+	memmap = sparse_decode_mem_map(ms->section_mem_map,
+				       pfn_to_section_nr(page_to_pfn(head)));
+
+	if (PageVmemmap_self_hosted(memmap))
+		return;
 
 	vmemmap_pages = hugetlb_optimize_vmemmap_pages(h);
 	if (!vmemmap_pages)
@@ -199,10 +207,10 @@ static struct ctl_table hugetlb_vmemmap_sysctls[] = {
 static __init int hugetlb_vmemmap_sysctls_init(void)
 {
 	/*
-	 * If "memory_hotplug.memmap_on_memory" is enabled or "struct page"
-	 * crosses page boundaries, the vmemmap pages cannot be optimized.
+	 * If "struct page" crosses page boundaries, the vmemmap pages cannot
+	 * be optimized.
 	 */
-	if (!mhp_memmap_on_memory() && is_power_of_2(sizeof(struct page)))
+	if (is_power_of_2(sizeof(struct page)))
 		register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
 
 	return 0;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1213d0c67a53..863966c2c6f1 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -45,8 +45,6 @@
 #ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
 static int memmap_on_memory_set(const char *val, const struct kernel_param *kp)
 {
-	if (hugetlb_optimize_vmemmap_enabled())
-		return 0;
 	return param_set_bool(val, kp);
 }
 
@@ -1032,6 +1030,7 @@ int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
 {
 	unsigned long end_pfn = pfn + nr_pages;
 	int ret;
+	int i;
 
 	ret = kasan_add_zero_shadow(__va(PFN_PHYS(pfn)), PFN_PHYS(nr_pages));
 	if (ret)
@@ -1039,6 +1038,12 @@ int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
 
 	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_UNMOVABLE);
 
+	/*
+	 * Let us flag self-hosted memmap
+	 */
+	for (i = 0; i < nr_pages; i++)
+		SetPageVmemmap_self_hosted(pfn_to_page(pfn + i));
+
 	/*
 	 * It might be that the vmemmap_pages fully span sections. If that is
 	 * the case, mark those sections online here as otherwise they will be


-- 
Oscar Salvador
SUSE Labs
