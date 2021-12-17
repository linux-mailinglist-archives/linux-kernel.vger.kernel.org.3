Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802C64796C2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhLQWBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:01:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:26492 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhLQWBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639778507; x=1671314507;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0jm2eAYVlDkuiCKKJYYzdwdod6o9ZLQ3TVZ+0dw78z8=;
  b=PHljiFdMrr4lTv7Esqhi6Nn/Li5hDbPM3sXHS0WPzcuYEuK7xj8SH+b2
   m6VZ/r8KT0Kt5072rS2vPgrJzX/5Be95FQ4S3t8CLIUuhaU555AAxx1ts
   7a32ZtcXvn7MbJA6F4yl0rvBNIxZFePlAHBQgwGHCtTQzr/vI2JMNpKfN
   qtkp+wGGukzWcdutdYgyuBJugbFEyv0k65xSkxPEpmvWPdKK7p1lzQm9Y
   wN2/uXIVSQvUS2ejxi5z8p5fGo2Dwas9Qnq0PE5k06qXhVcaVRwk+ju/r
   mMOYuj8iG4LTRwwxnh+9Jdmr2uDPXPRkT6YpJOvT6RrrP3XdhPq3oN9me
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="237381581"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="237381581"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 14:01:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="506928069"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2021 14:01:46 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     iommu@lists.linux-foundation.org, "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 00/11] Re-enable ENQCMD and PASID MSR
Date:   Fri, 17 Dec 2021 22:01:25 +0000
Message-Id: <20211217220136.2762116-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problems in the old code to manage SVM (Shared Virtual Memory) devices
and the PASID (Process Address Space ID) led to that code being
disabled.

Subsequent discussions resulted in a far simpler approach:

1) PASID life cycle is from first allocation by a process until that
   process exits.
2) All tasks begin with PASID disabled
3) The #GP fault handler tries to fix faulting ENQCMD instructions very
   early (thus avoiding complexities of the XSAVE infrastructure)

Change Log:
v2:
- Free PASID on mm exit instead of in exit(2) or unbind() (Thomas, AndyL,
  PeterZ)
- Directly write IA32_PASID MSR in fixup while local IRQ is still disabled
  (Thomas)
- Simplify handling ENQCMD in objtool (PeterZ and Josh)
- Define mm_pasid_get(), mm_pasid_drop(), and mm_pasid_init() in mm and
  call the functions from IOMMU (Dave Hansen).
- A few changes in the #GP fixup function (Dave Hansen, Tony Luck).
- Initial PASID value is changed to INVALID_PASID (Ashok Raj and
  Jacob Pan).
- Add mm_pasid_init(), mm_pasid_get(), and mm_pasid_drop() functions in mm.
  So the mm's PASID operations are generic for both X86 and ARM
  (Dave Hansen).
- Rename CONFIG_IOMMU_SVA_LIB to more useful and accurate
  CONFIG_IOMMU_SVA
- Use CONFIG_IOMMU_SVA for PASID processing condition (Jacob)
- The patch that cleans up old update_pasid() function is in upstream
  now (commit: 00ecd5401349 "iommu/vt-d: Clean up unused PASID updating
  functions") and therefore it's removed from this version.

v1 can be found at https://lore.kernel.org/lkml/20210920192349.2602141-1-fenghua.yu@intel.com/T/#md6d542091da1d1159eda0a44a16e57d0c0dfb209

Fenghua Yu (10):
  iommu/sva: Rename CONFIG_IOMMU_SVA_LIB to CONFIG_IOMMU_SVA
  mm: Change CONFIG option for mm->pasid field
  iommu/ioasid: Introduce a helper to check for valid PASIDs
  kernel/fork: Initialize mm's PASID
  iommu/sva: Assign a PASID to mm on PASID allocation and free it on mm
    exit
  x86/fpu: Clear PASID when copying fpstate
  x86/traps: Demand-populate PASID MSR via #GP
  x86/cpufeatures: Re-enable ENQCMD
  tools/objtool: Check for use of the ENQCMD instruction in the kernel
  docs: x86: Change documentation for SVA (Shared Virtual Addressing)

Peter Zijlstra (1):
  sched: Define and initialize a flag to identify valid PASID in the
    task

 Documentation/x86/sva.rst                     | 58 +++++++++++++++----
 arch/x86/include/asm/disabled-features.h      |  7 ++-
 arch/x86/kernel/fpu/core.c                    |  7 +++
 arch/x86/kernel/traps.c                       | 55 ++++++++++++++++++
 drivers/iommu/Kconfig                         |  6 +-
 drivers/iommu/Makefile                        |  2 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  5 +-
 drivers/iommu/intel/Kconfig                   |  2 +-
 drivers/iommu/intel/svm.c                     |  9 ---
 drivers/iommu/iommu-sva-lib.c                 | 39 ++++---------
 drivers/iommu/iommu-sva-lib.h                 |  7 +--
 include/linux/ioasid.h                        |  9 +++
 include/linux/mm_types.h                      |  2 +-
 include/linux/sched.h                         |  3 +
 include/linux/sched/mm.h                      | 26 +++++++++
 kernel/fork.c                                 | 15 +++--
 mm/init-mm.c                                  |  4 ++
 tools/objtool/arch/x86/decode.c               | 11 +++-
 18 files changed, 194 insertions(+), 73 deletions(-)

-- 
2.34.1

