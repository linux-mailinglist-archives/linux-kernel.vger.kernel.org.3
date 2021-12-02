Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC66466753
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359284AbhLBP7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:59:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:8736 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359218AbhLBP6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:58:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236544909"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="236544909"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 07:55:15 -0800
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="597209997"
Received: from islamsam-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.212.121.22])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 07:55:14 -0800
Date:   Thu, 2 Dec 2021 07:55:14 -0800
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
Message-ID: <20211202155452.jh4qnvpx52r3od67@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20211202144646.23186-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211202144646.23186-1-joro@8bytes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 03:46:46PM +0100, Joerg Roedel wrote:
>From: Joerg Roedel <jroedel@suse.de>
>
>The removal of PAGE_KERNEL_IO broke SEV-ES because it changed the
>mapping of ioremap and some fixmap areas (like the local APIC page)
>from unencrypted to encrypted. Change those mappings back to
>be unencrypted.
>
>Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>Fixes: 27dff0f58bde ("x86/mm: Nuke PAGE_KERNEL_IO")
>Signed-off-by: Joerg Roedel <jroedel@suse.de>

oops, missed the fact PAGE_KERNEL had `| ENC` while PAGE_KERENL_IO
didn't have it. Thanks for the fixup.

Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

Lucas De Marchi

>---
> arch/x86/include/asm/fixmap.h        |  2 +-
> arch/x86/include/asm/pgtable_types.h | 21 +++++++++++----------
> arch/x86/mm/ioremap.c                |  2 +-
> 3 files changed, 13 insertions(+), 12 deletions(-)
>
>diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
>index 5e186a69db10..a2eaf265f784 100644
>--- a/arch/x86/include/asm/fixmap.h
>+++ b/arch/x86/include/asm/fixmap.h
>@@ -173,7 +173,7 @@ static inline void __set_fixmap(enum fixed_addresses idx,
>  * supported for MMIO addresses, so make sure that the memory encryption
>  * mask is not part of the page attributes.
>  */
>-#define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NOCACHE
>+#define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NOCACHE_NOENC
>
> /*
>  * Early memremap routines used for in-place encryption. The mappings created
>diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
>index a87224767ff3..fc9b6995cb22 100644
>--- a/arch/x86/include/asm/pgtable_types.h
>+++ b/arch/x86/include/asm/pgtable_types.h
>@@ -208,16 +208,17 @@ enum page_cache_mode {
>
> #define __pgprot_mask(x)	__pgprot((x) & __default_kernel_pte_mask)
>
>-#define PAGE_KERNEL		__pgprot_mask(__PAGE_KERNEL            | _ENC)
>-#define PAGE_KERNEL_NOENC	__pgprot_mask(__PAGE_KERNEL            |    0)
>-#define PAGE_KERNEL_RO		__pgprot_mask(__PAGE_KERNEL_RO         | _ENC)
>-#define PAGE_KERNEL_EXEC	__pgprot_mask(__PAGE_KERNEL_EXEC       | _ENC)
>-#define PAGE_KERNEL_EXEC_NOENC	__pgprot_mask(__PAGE_KERNEL_EXEC       |    0)
>-#define PAGE_KERNEL_ROX		__pgprot_mask(__PAGE_KERNEL_ROX        | _ENC)
>-#define PAGE_KERNEL_NOCACHE	__pgprot_mask(__PAGE_KERNEL_NOCACHE    | _ENC)
>-#define PAGE_KERNEL_LARGE	__pgprot_mask(__PAGE_KERNEL_LARGE      | _ENC)
>-#define PAGE_KERNEL_LARGE_EXEC	__pgprot_mask(__PAGE_KERNEL_LARGE_EXEC | _ENC)
>-#define PAGE_KERNEL_VVAR	__pgprot_mask(__PAGE_KERNEL_VVAR       | _ENC)
>+#define PAGE_KERNEL			__pgprot_mask(__PAGE_KERNEL            | _ENC)
>+#define PAGE_KERNEL_NOENC		__pgprot_mask(__PAGE_KERNEL            |    0)
>+#define PAGE_KERNEL_RO			__pgprot_mask(__PAGE_KERNEL_RO         | _ENC)
>+#define PAGE_KERNEL_EXEC		__pgprot_mask(__PAGE_KERNEL_EXEC       | _ENC)
>+#define PAGE_KERNEL_EXEC_NOENC		__pgprot_mask(__PAGE_KERNEL_EXEC       |    0)
>+#define PAGE_KERNEL_ROX			__pgprot_mask(__PAGE_KERNEL_ROX        | _ENC)
>+#define PAGE_KERNEL_NOCACHE		__pgprot_mask(__PAGE_KERNEL_NOCACHE    | _ENC)
>+#define PAGE_KERNEL_NOCACHE_NOENC	__pgprot_mask(__PAGE_KERNEL_NOCACHE    |    0)
>+#define PAGE_KERNEL_LARGE		__pgprot_mask(__PAGE_KERNEL_LARGE      | _ENC)
>+#define PAGE_KERNEL_LARGE_EXEC		__pgprot_mask(__PAGE_KERNEL_LARGE_EXEC | _ENC)
>+#define PAGE_KERNEL_VVAR		__pgprot_mask(__PAGE_KERNEL_VVAR       | _ENC)
>
> #endif	/* __ASSEMBLY__ */
>
>diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>index 3102dda4b152..4fe8d43d53bb 100644
>--- a/arch/x86/mm/ioremap.c
>+++ b/arch/x86/mm/ioremap.c
>@@ -243,7 +243,7 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
> 	 * make sure the memory encryption attribute is enabled in the
> 	 * resulting mapping.
> 	 */
>-	prot = PAGE_KERNEL;
>+	prot = PAGE_KERNEL_NOENC;
> 	if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
> 		prot = pgprot_encrypted(prot);
>
>-- 
>2.34.0
>
