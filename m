Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D9B4D2D94
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiCILAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiCILAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:00:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67944106CB4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 02:59:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB34F1650;
        Wed,  9 Mar 2022 02:59:24 -0800 (PST)
Received: from [10.163.33.203] (unknown [10.163.33.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58B763FA4D;
        Wed,  9 Mar 2022 02:59:23 -0800 (PST)
Message-ID: <18d695bb-67a8-ac4d-27a2-9bea0630fa6a@arm.com>
Date:   Wed, 9 Mar 2022 16:29:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3 00/30] mm/mmap: Drop protection_map[] and platform's
 __SXXX/__PXXX requirements
Content-Language: en-US
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/22 16:17, Anshuman Khandual wrote:
> protection_map[] is an array based construct that translates given vm_flags
> combination. This array contains page protection map, which is populated by
> the platform via [__S000 .. __S111] and [__P000 .. __P111] exported macros.
> Primary usage for protection_map[] is for vm_get_page_prot(), which is used
> to determine page protection value for a given vm_flags. vm_get_page_prot()
> implementation, could again call platform overrides arch_vm_get_page_prot()
> and arch_filter_pgprot(). Some platforms override protection_map[] that was
> originally built with __SXXX/__PXXX with different runtime values.
> 
> Currently there are multiple layers of abstraction i.e __SXXX/__PXXX macros
> , protection_map[], arch_vm_get_page_prot() and arch_filter_pgprot() built
> between the platform and generic MM, finally defining vm_get_page_prot().
> 
> Hence this series proposes to drop all these abstraction levels and instead
> just move the responsibility of defining vm_get_page_prot() to the platform
> itself making it clean and simple.
> 
> This first introduces ARCH_HAS_VM_GET_PAGE_PROT which enables the platforms
> to define custom vm_get_page_prot(). This starts converting platforms that
> either change protection_map[] or define the overrides arch_filter_pgprot()
> or arch_vm_get_page_prot() which enables for those constructs to be dropped
> off completely. This series then converts remaining platforms which enables
> for __SXXX/__PXXX constructs to be dropped off completely. Finally it drops
> the generic vm_get_page_prot() and then ARCH_HAS_VM_GET_PAGE_PROT as every
> platform now defines their own vm_get_page_prot().
> 
> The series has been inspired from an earlier discuss with Christoph Hellwig
> 
> https://lore.kernel.org/all/1632712920-8171-1-git-send-email-anshuman.khandual@arm.com/
> 
> This series applies on 5.17-rc6 after the following patch.
> 
> https://lore.kernel.org/all/1643004823-16441-1-git-send-email-anshuman.khandual@arm.com/
> 
> This series has been cross built for multiple platforms.
> 
> - Anshuman
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-csky@vger.kernel.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: linux-parisc@vger.kernel.org
> Cc: openrisc@lists.librecores.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Changes in V3:
> 
> - Dropped variable 'i' from sme_early_init() on x86 platform
> - Moved CONFIG_COLDFIRE vm_get_page_prot() inside arch/m68k/mm/mcfmmu.c
> - Moved CONFIG_SUN3 vm_get_page_prot() inside arch/m68k/mm/sun3mmu.c
> - Dropped cachebits for vm_get_page_prot() inside arch/m68k/mm/motorola.c
> - Dropped PAGE_XXX_C definitions from arch/m68k/include/asm/motorola_pgtable.h
> - Used PAGE_XXX instead for vm_get_page_prot() inside arch/m68k/mm/motorola.c
> - Dropped all references to protection_map[] in the tree
> - Replaced s/extensa/xtensa/ on the patch title
> - Moved left over comments from pgtable.h into init.c on nios2 platform
> 
> Changes in V2:
> 
> https://lore.kernel.org/all/1645425519-9034-1-git-send-email-anshuman.khandual@arm.com/
> 
> - Dropped the entire comment block in [PATCH 30/30] per Geert
> - Replaced __P010 (although commented) with __PAGE_COPY on arm platform
> - Replaced __P101 with PAGE_READONLY on um platform
> 
> Changes in V1:
> 
> https://lore.kernel.org/all/1644805853-21338-1-git-send-email-anshuman.khandual@arm.com/
> 
> - Add white spaces around the | operators 
> - Moved powerpc_vm_get_page_prot() near vm_get_page_prot() on powerpc
> - Moved arm64_vm_get_page_prot() near vm_get_page_prot() on arm64
> - Moved sparc_vm_get_page_prot() near vm_get_page_prot() on sparc
> - Compacted vm_get_page_prot() switch cases on all platforms
> -  _PAGE_CACHE040 inclusion is dependent on CPU_IS_040_OR_060
> - VM_SHARED case should return PAGE_NONE (not PAGE_COPY) on SH platform
> - Reorganized VM_SHARED, VM_EXEC, VM_WRITE, VM_READ
> - Dropped the last patch [RFC V1 31/31] which added macros for vm_flags combinations
>   https://lore.kernel.org/all/1643029028-12710-32-git-send-email-anshuman.khandual@arm.com/
> 
> Changes in RFC:
> 
> https://lore.kernel.org/all/1643029028-12710-1-git-send-email-anshuman.khandual@arm.com/
> 
> Anshuman Khandual (29):
>   mm/debug_vm_pgtable: Drop protection_map[] usage
>   mm/mmap: Clarify protection_map[] indices

Hello Andrew,

I am planning to rework this series later, as it is already some what
late for the next merge window. I am wondering if you could consider
just these above two independent patches for v5.18-rc1 ?

- Anshuman
