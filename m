Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6364A01ED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351383AbiA1U3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:29:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:39617 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351203AbiA1U3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643401764; x=1674937764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qFGT50wtzxZn0pd/mKB4aYLdN6vzUrpmDy6Ee1GufQU=;
  b=MyVHjF3IQmBgQUnxxJT+xsh1UWM5/hb83VseagQE0K+XgrsCOjtq+pd0
   jEdG8KTEJG4uIsEArs7HpvatIVJ83yhHyMNL7OjNsjgBScfOvq7xPc9Lm
   Bpv9A4CyLzjyHlxIUWMEUroncjw5gAv+goE3IyqWJ2nhGnEgbg5aKBwRf
   jKq9rerqh6kfD+m2x8oy2c8NYWvE/1oNXZ9Yq7rr05l0GE3uT4c1xJl9c
   qGPsiI8sxceAHN2NaIQ3yjXBOWTE2a33oJrYf92/p4yYafVi18i+wJlzv
   0F4g+nF3uyThdfftv/RysPcuf3vKchMQvnbIEOvNMsAEwpYXNc1j890D0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="227170810"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="227170810"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 12:29:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="618827718"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jan 2022 12:29:23 -0800
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
Subject: [PATCH v3 11/11] docs: x86: Change documentation for SVA (Shared Virtual Addressing)
Date:   Fri, 28 Jan 2022 12:29:05 -0800
Message-Id: <20220128202905.2274672-12-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128202905.2274672-1-fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
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
v3:
- Remove PASID refcount description (Thomas).

v2:
- Update life cycle info (Tony and Thomas).
- Update initial PASID value to INVALID_IOASID on fork().

 Documentation/x86/sva.rst | 53 ++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/Documentation/x86/sva.rst b/Documentation/x86/sva.rst
index 076efd51ef1f..1a22020735a3 100644
--- a/Documentation/x86/sva.rst
+++ b/Documentation/x86/sva.rst
@@ -104,18 +104,47 @@ The MSR must be configured on each logical CPU before any application
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
+all threads in unbind, free the PASID lazily only on mm exit.
+
+If a process does a close(2) of the device file descriptor and munmap(2)
+of the device MMIO portal, then the driver will unbind the device. The
+PASID is still marked VALID in the PASID_MSR for any threads in the
+process that accessed the device. But this is harmless as without the
+MMIO portal they cannot submit new work to the device.
 
 Relationships
 =============
-- 
2.35.0

