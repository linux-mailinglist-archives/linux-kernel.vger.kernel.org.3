Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C975229E5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241310AbiEKCaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241243AbiEKC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:29:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D7921A973
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652236180; x=1683772180;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G/TcLlTYfxbVJzq7dK3DevQwhZHsYFLz0w7V7nky4mc=;
  b=fhjDZ4oSkjyg9xY5MZ+umL4KUuJ7Cai3bELL+rpEWwLigA3nlLOuytKR
   fj+YcwnK0c8gHohHNa7qdSwPQQvRrx732cKZ7Z19UNKhVKVzMGtZ9ZBu5
   GaTNdOAaQ8k/8pCvBFti+zCDl5cdVByq73qZOYNK/2qC2cQvoDu8Q4x61
   SAp1RmG7ysoybZ2JopjQOTQzd5xYUXtvpAZnHmkaZI5m1/z8rFTxzhOK2
   CRRMOs5oB2HNe+Q+lmywncG/t0x74DoM2vMfjlJNADF4N1JHaDMrPfq39
   bkxtrWyNWSkrXjqkX+Dl5AtpvXvMDvhNmz2EqqQfofieUcE9EcaA7KhP+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="251610731"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="251610731"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 19:29:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="602747391"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 May 2022 19:29:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 05415508; Wed, 11 May 2022 05:28:00 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFCv2 00/10] Linear Address Masking enabling
Date:   Wed, 11 May 2022 05:27:40 +0300
Message-Id: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all. Here's long overdue update on LAM enabling.

# Description #

Linear Address Masking[1] (LAM) modifies the checking that is applied to
64-bit linear addresses, allowing software to use of the untranslated
address bits for metadata.

The patchset brings support for LAM for userspace addresses.

The most sensitive part of enabling is change in tlb.c, where CR3 flags
get set. Please take a look that what I'm doing makes sense.

The feature competes for bits with 5-level paging: LAM_U48 makes it
impossible to map anything about 47-bits. The patchset made these
capability mutually exclusive: whatever used first wins. LAM_U57 can be
combined with mappings above 47-bits.

[1] ISE, Chapter 14.
https://software.intel.com/content/dam/develop/external/us/en/documents-tps/architecture-instruction-set-extensions-programming-reference.pdf

# What's new #

The main change is interface rework. It is now arch_prctl(2)-based and
suppose to be extendable to CET.

QEMU implementation is also updated. It can now be applied onto current
master branch. QEMU patch as it is was rejected by upstream, but it is
functinal and can be used for testing.

Please take a look. Any suggestions are welcome.

v2:
  - Rebased onto v5.18-rc1
  - New arch_prctl(2)-based API
  - Expose status of LAM (or other thread features) in
    /proc/$PID/arch_status.

Kirill A. Shutemov (10):
  x86/mm: Fix CR3_ADDR_MASK
  x86: CPUID and CR3/CR4 flags for Linear Address Masking
  x86: Introduce userspace API to handle per-thread features
  x86/mm: Introduce X86_THREAD_LAM_U48 and X86_THREAD_LAM_U57
  x86/mm: Provide untagged_addr() helper
  x86/uaccess: Remove tags from the address before checking
  x86/mm: Handle tagged memory accesses from kernel threads
  x86/mm: Make LAM_U48 and mappings above 47-bits mutually exclusive
  x86/mm: Add userspace API to enable Linear Address Masking
  x86: Expose thread features status in /proc/$PID/arch_status

 arch/x86/include/asm/cpufeatures.h          |   1 +
 arch/x86/include/asm/elf.h                  |   3 +-
 arch/x86/include/asm/mmu.h                  |   1 +
 arch/x86/include/asm/mmu_context.h          |  13 +++
 arch/x86/include/asm/page_32.h              |   3 +
 arch/x86/include/asm/page_64.h              |  20 ++++
 arch/x86/include/asm/processor-flags.h      |   2 +-
 arch/x86/include/asm/processor.h            |   3 +
 arch/x86/include/asm/tlbflush.h             |   5 +
 arch/x86/include/asm/uaccess.h              |  15 ++-
 arch/x86/include/uapi/asm/prctl.h           |   8 ++
 arch/x86/include/uapi/asm/processor-flags.h |   6 +
 arch/x86/kernel/Makefile                    |   2 +
 arch/x86/kernel/fpu/xstate.c                |  47 --------
 arch/x86/kernel/proc.c                      |  63 ++++++++++
 arch/x86/kernel/process.c                   |  56 +++++++++
 arch/x86/kernel/process.h                   |   2 +
 arch/x86/kernel/process_64.c                |  46 ++++++++
 arch/x86/kernel/sys_x86_64.c                |   5 +-
 arch/x86/mm/hugetlbpage.c                   |   6 +-
 arch/x86/mm/mmap.c                          |   9 +-
 arch/x86/mm/tlb.c                           | 123 +++++++++++++++++---
 22 files changed, 367 insertions(+), 72 deletions(-)
 create mode 100644 arch/x86/kernel/proc.c

-- 
2.35.1

