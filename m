Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBA64ACD43
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241058AbiBHBDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245428AbiBGXD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:03:28 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A878FC0612A4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644275007; x=1675811007;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DwxW5/6A2LJ1fHtlYVK+GKZ2vtOtxuAcvM3oIKFzkB0=;
  b=cz312uHPI8KhkT9+pB1LlhpdGOKlSgYyAslPkjbgjReuv85UIx13SMcU
   ycr0VsQav+Kj46XO/h+JXVvenojCF0VTXVRHA8vQB/2X7VlsSfiW5Aaai
   pM9PFu38/aDm+y6cR8kFtLWtjbIpSYKrC0ScUc1S/jIBwQG4O6uM9YVXj
   jQN/Ptk8jV/NxwvwR2d1nWZ7iLAhq2WXQhh+EUqGaR4uXpX8bNsLzXE4a
   od3HH2mz9tyLyGCTdieHTbcI1+N2Rhry2uqaBwYUBfNasgZuOnmBDQHeh
   egM62cJdVzHr2TfYS5C1QRTdCnELNbfvdGxz3z/Ad1d1WjAag5MHN12GT
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="229474999"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="229474999"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 15:03:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="540323991"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga008.jf.intel.com with ESMTP; 07 Feb 2022 15:03:01 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
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
Subject: [PATCH v4 00/11] Re-enable ENQCMD and PASID MSR
Date:   Mon,  7 Feb 2022 15:02:43 -0800
Message-Id: <20220207230254.3342514-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
v4:
- Update commit message in patch #4 (Thomas).
- Update commit message in patch #5 (Thomas).
- Add "Reviewed-by: Thomas Gleixner <tglx@linutronix.de>" in patch #1-#3
  and patch #6-#9 (Thomas).
- Rebased to 5.17-rc3.

v3 can be found at https://lore.kernel.org/lkml/20220128202905.2274672-7-fenghua.yu@intel.com/T/#m039e1a201e9894d99b117fa6005bc05724a5a4bb

v3:
- Rename mm_pasid_get() to mm_pasid_set() in patch #5 (Thomas).
- Remove ioasid_get() because it's not used any more when the IOASID
  is freed on mm exit in patch #5 (Thomas).
- Remove PASID's refcount exercise in ioasid_put() and rename
  ioasid_put() to ioasid_free() in patch #5 and #11 (Thomas).
- Add Acked-by: Josh Poimboeuf <jpoimboe@redhat.com> in patch #10.

v2 can be found at https://lore.kernel.org/lkml/20211217220136.2762116-1-fenghua.yu@intel.com/

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

 Documentation/x86/sva.rst                     | 53 ++++++++++++++----
 arch/x86/include/asm/disabled-features.h      |  7 ++-
 arch/x86/kernel/fpu/core.c                    |  7 +++
 arch/x86/kernel/traps.c                       | 55 +++++++++++++++++++
 drivers/iommu/Kconfig                         |  6 +-
 drivers/iommu/Makefile                        |  2 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  5 +-
 drivers/iommu/intel/Kconfig                   |  2 +-
 drivers/iommu/intel/iommu.c                   |  4 +-
 drivers/iommu/intel/svm.c                     |  9 ---
 drivers/iommu/ioasid.c                        | 39 ++-----------
 drivers/iommu/iommu-sva-lib.c                 | 39 ++++---------
 drivers/iommu/iommu-sva-lib.h                 |  7 +--
 include/linux/ioasid.h                        | 21 +++----
 include/linux/mm_types.h                      |  2 +-
 include/linux/sched.h                         |  3 +
 include/linux/sched/mm.h                      | 26 +++++++++
 kernel/fork.c                                 | 15 +++--
 mm/init-mm.c                                  |  4 ++
 tools/objtool/arch/x86/decode.c               | 11 +++-
 20 files changed, 197 insertions(+), 120 deletions(-)

-- 
2.35.1

