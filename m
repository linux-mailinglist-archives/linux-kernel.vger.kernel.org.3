Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FB7466E78
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244390AbhLCA2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:28:39 -0500
Received: from mga04.intel.com ([192.55.52.120]:59244 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbhLCA2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:28:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="235614044"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="235614044"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 16:25:15 -0800
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="500974830"
Received: from huymcao-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.212.4.213])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 16:25:14 -0800
Date:   Thu, 2 Dec 2021 16:25:13 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] x86/mm: Fix PAGE_KERNEL_IO removal breakage
Message-ID: <20211203002513.fa43j6uvsn2ho4mm@ldmartin-desk2>
References: <20211202144646.23186-1-joro@8bytes.org>
 <20211202155452.jh4qnvpx52r3od67@ldmartin-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211202155452.jh4qnvpx52r3od67@ldmartin-desk2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 07:55:14AM -0800, Lucas De Marchi wrote:
>On Thu, Dec 02, 2021 at 03:46:46PM +0100, Joerg Roedel wrote:
>>From: Joerg Roedel <jroedel@suse.de>
>>
>>The removal of PAGE_KERNEL_IO broke SEV-ES because it changed the
>>mapping of ioremap and some fixmap areas (like the local APIC page)
>>from unencrypted to encrypted. Change those mappings back to
>>be unencrypted.
>>
>>Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>>Fixes: 27dff0f58bde ("x86/mm: Nuke PAGE_KERNEL_IO")
>>Signed-off-by: Joerg Roedel <jroedel@suse.de>
>
>oops, missed the fact PAGE_KERNEL had `| ENC` while PAGE_KERENL_IO
>didn't have it. Thanks for the fixup.

on a second thought, the fact that PAGE_KERNEL is _not_ the same as
PAGE_KERNEL_IO, completely invalidates those 2 patches I sent. It seems
I screwed it up big here.

About the first patch,
6b2a2138cf36 ("drm/i915/gem: Stop using PAGE_KERNEL_IO"),
I didn't notice any regression on the i915
side though. Is it safe to keep it? Otherwise we are probably better
off reverting everything.

I'm wondering why the addition of memory encryption
in 21729f81ce8a ("x86/mm: Provide general kernel support for memory encryption")
didn't break io_mapping_init_wc() though as it had already done a
s/PAGE_KERNEL_IO/PAGE_KERNEL/ in commit
ac96b5566926 ("io-mapping.h: s/PAGE_KERNEL_IO/PAGE_KERNEL/")

thanks
Lucas De Marchi

>
>Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
>
>Lucas De Marchi
>
>>---
>>arch/x86/include/asm/fixmap.h        |  2 +-
>>arch/x86/include/asm/pgtable_types.h | 21 +++++++++++----------
>>arch/x86/mm/ioremap.c                |  2 +-
>>3 files changed, 13 insertions(+), 12 deletions(-)
>>
>>diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
>>index 5e186a69db10..a2eaf265f784 100644
>>--- a/arch/x86/include/asm/fixmap.h
>>+++ b/arch/x86/include/asm/fixmap.h
>>@@ -173,7 +173,7 @@ static inline void __set_fixmap(enum fixed_addresses idx,
>> * supported for MMIO addresses, so make sure that the memory encryption
>> * mask is not part of the page attributes.
>> */
>>-#define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NOCACHE
>>+#define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NOCACHE_NOENC
>>
>>/*
>> * Early memremap routines used for in-place encryption. The mappings created
>>diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
>>index a87224767ff3..fc9b6995cb22 100644
>>--- a/arch/x86/include/asm/pgtable_types.h
>>+++ b/arch/x86/include/asm/pgtable_types.h
>>@@ -208,16 +208,17 @@ enum page_cache_mode {
>>
>>#define __pgprot_mask(x)	__pgprot((x) & __default_kernel_pte_mask)
>>
>>-#define PAGE_KERNEL		__pgprot_mask(__PAGE_KERNEL            | _ENC)
>>-#define PAGE_KERNEL_NOENC	__pgprot_mask(__PAGE_KERNEL            |    0)
>>-#define PAGE_KERNEL_RO		__pgprot_mask(__PAGE_KERNEL_RO         | _ENC)
>>-#define PAGE_KERNEL_EXEC	__pgprot_mask(__PAGE_KERNEL_EXEC       | _ENC)
>>-#define PAGE_KERNEL_EXEC_NOENC	__pgprot_mask(__PAGE_KERNEL_EXEC       |    0)
>>-#define PAGE_KERNEL_ROX		__pgprot_mask(__PAGE_KERNEL_ROX        | _ENC)
>>-#define PAGE_KERNEL_NOCACHE	__pgprot_mask(__PAGE_KERNEL_NOCACHE    | _ENC)
>>-#define PAGE_KERNEL_LARGE	__pgprot_mask(__PAGE_KERNEL_LARGE      | _ENC)
>>-#define PAGE_KERNEL_LARGE_EXEC	__pgprot_mask(__PAGE_KERNEL_LARGE_EXEC | _ENC)
>>-#define PAGE_KERNEL_VVAR	__pgprot_mask(__PAGE_KERNEL_VVAR       | _ENC)
>>+#define PAGE_KERNEL			__pgprot_mask(__PAGE_KERNEL            | _ENC)
>>+#define PAGE_KERNEL_NOENC		__pgprot_mask(__PAGE_KERNEL            |    0)
>>+#define PAGE_KERNEL_RO			__pgprot_mask(__PAGE_KERNEL_RO         | _ENC)
>>+#define PAGE_KERNEL_EXEC		__pgprot_mask(__PAGE_KERNEL_EXEC       | _ENC)
>>+#define PAGE_KERNEL_EXEC_NOENC		__pgprot_mask(__PAGE_KERNEL_EXEC       |    0)
>>+#define PAGE_KERNEL_ROX			__pgprot_mask(__PAGE_KERNEL_ROX        | _ENC)
>>+#define PAGE_KERNEL_NOCACHE		__pgprot_mask(__PAGE_KERNEL_NOCACHE    | _ENC)
>>+#define PAGE_KERNEL_NOCACHE_NOENC	__pgprot_mask(__PAGE_KERNEL_NOCACHE    |    0)
>>+#define PAGE_KERNEL_LARGE		__pgprot_mask(__PAGE_KERNEL_LARGE      | _ENC)
>>+#define PAGE_KERNEL_LARGE_EXEC		__pgprot_mask(__PAGE_KERNEL_LARGE_EXEC | _ENC)
>>+#define PAGE_KERNEL_VVAR		__pgprot_mask(__PAGE_KERNEL_VVAR       | _ENC)
>>
>>#endif	/* __ASSEMBLY__ */
>>
>>diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>>index 3102dda4b152..4fe8d43d53bb 100644
>>--- a/arch/x86/mm/ioremap.c
>>+++ b/arch/x86/mm/ioremap.c
>>@@ -243,7 +243,7 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
>>	 * make sure the memory encryption attribute is enabled in the
>>	 * resulting mapping.
>>	 */
>>-	prot = PAGE_KERNEL;
>>+	prot = PAGE_KERNEL_NOENC;
>>	if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
>>		prot = pgprot_encrypted(prot);
>>
>>-- 
>>2.34.0
>>
