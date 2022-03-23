Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43344E575B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343513AbiCWRYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238674AbiCWRYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:24:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BDF7C173
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:22:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4249C60B6B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 17:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EDCC340E8;
        Wed, 23 Mar 2022 17:22:42 +0000 (UTC)
Date:   Wed, 23 Mar 2022 17:22:38 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ariel Marcovitch <arielmarcovitch@gmail.com>
Cc:     akpm@linux-foundation.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: False positive kmemleak report for dtb properties names on
 powerpc
Message-ID: <YjtXXlnbEp64eL0T@arm.com>
References: <9dd08bb5-f39e-53d8-f88d-bec598a08c93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dd08bb5-f39e-53d8-f88d-bec598a08c93@gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ariel,

On Fri, Feb 18, 2022 at 09:45:51PM +0200, Ariel Marcovitch wrote:
> I was running a powerpc 32bit kernel (built using
> qemu_ppc_mpc8544ds_defconfig
> buildroot config, with enabling DEBUGFS+KMEMLEAK+HIGHMEM in the kernel
> config)
> on qemu and invoked the kmemleak scan (twice. for some reason the first time
> wasn't enough).
[...]
> I got 97 leak reports, all similar to the following:
[...]
> memblock_alloc lets kmemleak know about the allocated memory using
> kmemleak_alloc_phys (in mm/memblock.c:memblock_alloc_range_nid()).
> 
> The problem is with the following code (mm/kmemleak.c):
> 
> ```c
> 
> void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
>                                gfp_t gfp)
> {
>         if (!IS_ENABLED(CONFIG_HIGHMEM) || PHYS_PFN(phys) < max_low_pfn)
>                 kmemleak_alloc(__va(phys), size, min_count, gfp);
> }
> 
> ```
> 
> When CONFIG_HIGHMEM is enabled, the pfn of the allocated memory is checked
> against max_low_pfn, to make sure it is not in the HIGHMEM zone.
> 
> However, when called through unflatten_device_tree(), max_low_pfn is not yet
> initialized in powerpc.
> 
> max_low_pfn is initialized (when NUMA is disabled) in
> arch/powerpc/mm/mem.c:mem_topology_setup() which is called only after
> unflatten_device_tree() is called in the same function (setup_arch()).
> 
> Because max_low_pfn is global it is 0 before initialization, so as far as
> kmemleak_alloc_phys() is concerned, every memory is HIGHMEM (: and the
> allocated memory is not tracked by kmemleak, causing references to objects
> allocated later with kmalloc() to be ignored and these objects are marked as
> leaked.

Thanks for digging into this. It looks like the logic doesn't work (not
sure whether it ever worked).

> I actually tried to find out whether this happen on other arches as well,
> and it seems like arm64 also have this problem when dtb is used instead of
> acpi, although I haven't had the chance to confirm this.

arm64 doesn't enable CONFIG_HIGHMEM, so it's not affected.

> I don't suppose I can just shuffle the calls in setup_arch() around, so I
> wanted to hear your opinions first

I think it's better if we change the logic than shuffling the calls.
IIUC MEMBLOCK_ALLOC_ACCESSIBLE means that __va() works on the phys
address return by memblock, so something like below (untested):

-------------8<----------------------
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 7580baa76af1..f3599e857c13 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1127,8 +1127,7 @@ EXPORT_SYMBOL(kmemleak_no_scan);
 void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
 			       gfp_t gfp)
 {
-	if (!IS_ENABLED(CONFIG_HIGHMEM) || PHYS_PFN(phys) < max_low_pfn)
-		kmemleak_alloc(__va(phys), size, min_count, gfp);
+	kmemleak_alloc(__va(phys), size, min_count, gfp);
 }
 EXPORT_SYMBOL(kmemleak_alloc_phys);
 
diff --git a/mm/memblock.c b/mm/memblock.c
index b12a364f2766..2515bd4331e8 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1397,7 +1397,7 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 	 * Skip kmemleak for those places like kasan_init() and
 	 * early_pgtable_alloc() due to high volume.
 	 */
-	if (end != MEMBLOCK_ALLOC_NOLEAKTRACE)
+	if (end == MEMBLOCK_ALLOC_ACCESSIBLE)
 		/*
 		 * The min_count is set to 0 so that memblock allocated
 		 * blocks are never reported as leaks. This is because many
-------------8<----------------------

But I'm not sure whether we'd now miss some genuine allocations where
the memblock limit is different from MEMBLOCK_ALLOC_ACCESSIBLE but still
within the lowmem limit. If the above works, we can probably get rid of
some other kmemleak callbacks in the kernel.

Adding Mike for any input on memblock.

-- 
Catalin
