Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FFD49E276
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241182AbiA0MjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:39:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39800 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiA0MjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:39:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22C9D61AB8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9E8C340EA;
        Thu, 27 Jan 2022 12:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643287141;
        bh=nP7BCHcZqaThejM5/UQJpmdfSwu/TFysIZsnQzFuZrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SJIDhWJJkUHd9k+b+s4AXsQgC1rbsgyJTErSQr7bDZqIalXWnX8llx0MTv/0HBzaM
         y4BPl77GLIOGQ8g3805IyG0/MGy/UaiwTdZnbjAUt2sVvEG4JrRB8TQZAueJzWlYIJ
         6w6vvQvjpv8LWuRcA+f+OscOxiULj1Mcr//Qujr6ubPXGynWFFFWTRE4oAalwUCPyf
         TM8uTHSIQzLStkH2haO4Z0zJyNSkHVh2YT6QrAqk/+w4qsLALuMyb7c8fm1Rlyospv
         IKN2qJNyplnFvO8PNZJTwW1oTAHitUSVDgeaaTw/skhCNN5Vwybqo0e5nusPOgSAdl
         jthrgwgv0ao9A==
Date:   Thu, 27 Jan 2022 14:38:53 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, akpm@linux-foundation.org
Subject: Re: [RFC V1 00/31] mm/mmap: Drop protection_map[] and platform's
 __SXXX/__PXXX requirements
Message-ID: <YfKSXXTZOa9FYug8@kernel.org>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Mon, Jan 24, 2022 at 06:26:37PM +0530, Anshuman Khandual wrote:
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

I generally like the idea, I just think the conversion can be more straight
forward. Rather than adding ARCH_HAS_VM_GET_PAGE_PROT and then dropping it,
why won't me make the generic vm_get_page_prot() __weak, then add per-arch
implementation and in the end drop the generic one?
 
> The last patch demonstrates how vm_flags combination indices can be defined
> as macros and be replaces across all platforms (if required, not done yet).
> 
> The series has been inspired from an earlier discuss with Christoph Hellwig
> 
> https://lore.kernel.org/all/1632712920-8171-1-git-send-email-anshuman.khandual@arm.com/
> 
> This series applies on 5.17-rc1 after the following patch.
> 
> https://lore.kernel.org/all/1643004823-16441-1-git-send-email-anshuman.khandual@arm.com/
> 
> This has been cross built for multiple platforms. I would like to get some
> early feed back on this proposal. All reviews and suggestions welcome.
> 
> Hello Christoph,
> 
> I have taken the liberty to preserve your authorship on the x86 patch which
> is borrowed almost as is from our earlier discussion. I have also added you
> as 'Suggested-by:' on the patch that adds config ARCH_HAS_VM_GET_PAGE_PROT.
> Nonetheless please feel free to correct me for any other missing authorship
> attributes I should have added. Thank you.
> 
> - Anshuman
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> 
> Anshuman Khandual (30):
>   mm/debug_vm_pgtable: Directly use vm_get_page_prot()
>   mm/mmap: Clarify protection_map[] indices
>   mm/mmap: Add new config ARCH_HAS_VM_GET_PAGE_PROT
>   powerpc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
>   arm64/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
>   sparc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
>   mips/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
>   m68k/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
>   arm/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
>   mm/mmap: Drop protection_map[]
>   mm/mmap: Drop arch_filter_pgprot()
>   mm/mmap: Drop arch_vm_get_page_pgprot()
>   s390/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
>   riscv/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
>   alpha/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
>   sh/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
>   arc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
>   csky/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
>   extensa/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
>   parisc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
>   openrisc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
>   um/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
>   microblaze/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
>   nios2/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
>   hexagon/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
>   nds32/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
>   ia64/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
>   mm/mmap: Drop generic vm_get_page_prot()
>   mm/mmap: Drop ARCH_HAS_VM_GET_PAGE_PROT
>   mm/mmap: Define macros for vm_flags access permission combinations
> 
> Christoph Hellwig (1):
>   x86/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
> 
>  arch/alpha/include/asm/pgtable.h          | 17 -----
>  arch/alpha/mm/init.c                      | 41 +++++++++++
>  arch/arc/include/asm/pgtable-bits-arcv2.h | 17 -----
>  arch/arc/mm/mmap.c                        | 41 +++++++++++
>  arch/arm/include/asm/pgtable.h            | 18 -----
>  arch/arm/mm/mmu.c                         | 50 +++++++++++--
>  arch/arm64/Kconfig                        |  1 -
>  arch/arm64/include/asm/mman.h             |  3 +-
>  arch/arm64/include/asm/pgtable-prot.h     | 18 -----
>  arch/arm64/include/asm/pgtable.h          |  2 +-
>  arch/arm64/mm/mmap.c                      | 50 +++++++++++++
>  arch/csky/include/asm/pgtable.h           | 18 -----
>  arch/csky/mm/init.c                       | 41 +++++++++++
>  arch/hexagon/include/asm/pgtable.h        | 24 -------
>  arch/hexagon/mm/init.c                    | 42 +++++++++++
>  arch/ia64/include/asm/pgtable.h           | 17 -----
>  arch/ia64/mm/init.c                       | 43 ++++++++++-
>  arch/m68k/include/asm/mcf_pgtable.h       | 59 ---------------
>  arch/m68k/include/asm/motorola_pgtable.h  | 22 ------
>  arch/m68k/include/asm/sun3_pgtable.h      | 22 ------
>  arch/m68k/mm/init.c                       | 87 +++++++++++++++++++++++
>  arch/m68k/mm/motorola.c                   | 44 +++++++++++-
>  arch/microblaze/include/asm/pgtable.h     | 17 -----
>  arch/microblaze/mm/init.c                 | 41 +++++++++++
>  arch/mips/include/asm/pgtable.h           | 22 ------
>  arch/mips/mm/cache.c                      | 65 ++++++++++-------
>  arch/nds32/include/asm/pgtable.h          | 17 -----
>  arch/nds32/mm/mmap.c                      | 41 +++++++++++
>  arch/nios2/include/asm/pgtable.h          | 16 -----
>  arch/nios2/mm/init.c                      | 41 +++++++++++
>  arch/openrisc/include/asm/pgtable.h       | 18 -----
>  arch/openrisc/mm/init.c                   | 41 +++++++++++
>  arch/parisc/include/asm/pgtable.h         | 20 ------
>  arch/parisc/mm/init.c                     | 41 +++++++++++
>  arch/powerpc/include/asm/mman.h           |  3 +-
>  arch/powerpc/include/asm/pgtable.h        | 19 -----
>  arch/powerpc/mm/mmap.c                    | 47 ++++++++++++
>  arch/riscv/include/asm/pgtable.h          | 16 -----
>  arch/riscv/mm/init.c                      | 41 +++++++++++
>  arch/s390/include/asm/pgtable.h           | 17 -----
>  arch/s390/mm/mmap.c                       | 41 +++++++++++
>  arch/sh/include/asm/pgtable.h             | 17 -----
>  arch/sh/mm/mmap.c                         | 43 +++++++++++
>  arch/sparc/include/asm/mman.h             |  1 -
>  arch/sparc/include/asm/pgtable_32.h       | 19 -----
>  arch/sparc/include/asm/pgtable_64.h       | 19 -----
>  arch/sparc/mm/init_32.c                   | 41 +++++++++++
>  arch/sparc/mm/init_64.c                   | 71 +++++++++++++-----
>  arch/um/include/asm/pgtable.h             | 17 -----
>  arch/um/kernel/mem.c                      | 41 +++++++++++
>  arch/x86/Kconfig                          |  1 -
>  arch/x86/include/asm/pgtable.h            |  5 --
>  arch/x86/include/asm/pgtable_types.h      | 19 -----
>  arch/x86/include/uapi/asm/mman.h          | 14 ----
>  arch/x86/mm/Makefile                      |  2 +-
>  arch/x86/mm/mem_encrypt_amd.c             |  4 --
>  arch/x86/mm/pgprot.c                      | 71 ++++++++++++++++++
>  arch/xtensa/include/asm/pgtable.h         | 18 -----
>  arch/xtensa/mm/init.c                     | 41 +++++++++++
>  include/linux/mm.h                        | 45 ++++++++++--
>  include/linux/mman.h                      |  4 --
>  mm/Kconfig                                |  3 -
>  mm/debug_vm_pgtable.c                     | 27 +++----
>  mm/mmap.c                                 | 22 ------
>  64 files changed, 1150 insertions(+), 636 deletions(-)
>  create mode 100644 arch/x86/mm/pgprot.c
> 
> -- 
> 2.25.1
> 
> 

-- 
Sincerely yours,
Mike.
