Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6F24796C7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhLQWCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:02:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:26506 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231181AbhLQWBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639778512; x=1671314512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jOdSxuEtbkAQOM8wsD7B/5P8akQ7YsOBzOXhYbomw+g=;
  b=jLdSpHPkPFRJOXBaJuVcQ/Pa3Vdia25j5Kfdk+imj/sWXyUhOCjgvpYo
   x/JQLOd4xHNp+4nfy9UKNjQSBSYFrsiNlmrHava8GmBAJJrgrSeRLiO50
   bQBFI8Q6SCaZ0bIKjNz3PPw35AlPRrlFnVfx6H5FVX0iYrUNSnm9WzAoM
   z1U0+7OyxZ8+HLR7N+gdwMT6iLg9hgg+THpuEgKqaXpIYfmYx3QmjQ2ZB
   kZiiGtNIfhRoZQJfeo+0WxiMEd4BU2NLiAuTxqBZnTd48Zwr7sYULdzi/
   ZWBy13OacXU8DyMu2PO1MZX9tFVUfkLOkR3g/AZrYKEQcXERwuH3c8ItD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="237381605"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="237381605"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 14:01:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="506928113"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2021 14:01:51 -0800
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
Subject: [PATCH v2 11/11] docs: x86: Change documentation for SVA (Shared Virtual Addressing)
Date:   Fri, 17 Dec 2021 22:01:36 +0000
Message-Id: <20211217220136.2762116-12-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217220136.2762116-1-fenghua.yu@intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since allocating, freeing and fixing up PASID are changed, the
documentation is updated to reflect the changes.

Originally-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Update life cycle info (Tony and Thomas).
- Update initial PASID value to INVALID_IOASID on fork().

 Documentation/x86/sva.rst | 58 +++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 12 deletions(-)

diff --git a/Documentation/x86/sva.rst b/Documentation/x86/sva.rst
index 076efd51ef1f..92341f26e525 100644
--- a/Documentation/x86/sva.rst
+++ b/Documentation/x86/sva.rst
@@ -104,18 +104,52 @@ The MSR must be configured on each logical CPU before any application
 thread can interact with a device. Threads that belong to the same
 process share the same page tables, thus the same MSR value.
 
-PASID is cleared when a process is created. The PASID allocation and MSR
-programming may occur long after a process and its threads have been created.
-One thread must call iommu_sva_bind_device() to allocate the PASID for the
-process. If a thread uses ENQCMD without the MSR first being populated, a #GP
-will be raised. The kernel will update the PASID MSR with the PASID for all
-threads in the process. A single process PASID can be used simultaneously
-with multiple devices since they all share the same address space.
-
-One thread can call iommu_sva_unbind_device() to free the allocated PASID.
-The kernel will clear the PASID MSR for all threads belonging to the process.
-
-New threads inherit the MSR value from the parent.
+PASID Life Cycle Management
+==========================
+
+PASID is initialized as INVALID_IOASID (-1) when a process is created.
+
+Only processes that access SVA-capable devices need to have a PASID
+allocated. This allocation happens when a process opens/binds an SVA-capable
+device but finds no PASID for this process. Subsequent binds of the same, or
+other devices will share the same PASID.
+
+Although the PASID is allocated to the process by opening a device,
+it is not active in any of the threads of that process. It's loaded to the
+IA32_PASID MSR lazily when a thread tries to submit a work descriptor
+to a device using the ENQCMD.
+
+That first access will trigger a #GP fault because the IA32_PASID MSR
+has not been initialized with the PASID value assigned to the process
+when the device was opened. The Linux #GP handler notes that a PASID has
+been allocated for the process, and so initializes the IA32_PASID MSR
+and returns so that the ENQCMD instruction is re-executed.
+
+On fork(2) or exec(2) the PASID is removed from the process as it no
+longer has the same address space that it had when the device was opened.
+
+On clone(2) the new task shares the same address space, so will be
+able to use the PASID allocated to the process. The IA32_PASID is not
+preemptively initialized as the PASID value might not be allocated yet or
+the kernel does not know whether this thread is going to access the device
+and the cleared IA32_PASID MSR reduces context switch overhead by xstate
+init optimization. Since #GP faults have to be handled on any threads that
+were created before the PASID was assigned to the mm of the process, newly
+created threads might as well be treated in a consistent way.
+
+Due to complexity of freeing the PASID and clearing all IA32_PASID MSRs in
+all threads in unbind, free the PASID lazily only on mm exit. Track the
+PASID's reference count in the following way:
+
+- Initialize the PASID's reference to 1 when the PASID is first allocated
+  to the mm. The reference is held for the rest life time of the mm until
+  it's dropped to 0 and the PASID is freed on mm exit.
+
+If a process does a close(2) of the device file descriptor and munmap(2)
+of the device MMIO portal, then the driver will unbind the device. The
+PASID is still marked VALID in the PASID_MSR for any threads in the
+process that accessed the device. But this is harmless as without the
+MMIO portal they cannot submit new work to the device.
 
 Relationships
 =============
-- 
2.34.1

