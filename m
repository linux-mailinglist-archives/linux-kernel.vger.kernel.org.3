Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBE04796CA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhLQWCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:02:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:26498 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230514AbhLQWBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639778509; x=1671314509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TQwS440v7IbXqfoaDLFqxTIfDX/CqMUM6Yd9UQpEfkM=;
  b=mIsEDPgkD6OT7Ly2jNONj0ryFJbw+1opi891FL15RdfrzIViMwnqqyvP
   BfyzIRDv3D+w0cpTOR5AxA3wrlxHnWCp/EsqEnwijy2ZUul5jnnMRt+E7
   12CmYoc564mwxabRHNNdbacvdrPJxmcfZBayhlpW7aTG/+8r4Pkh/qROa
   oXDrptkE4RwXibnZ7SPeuVC/ObS0wd7qyhVnLwapfw4f20vCuRvapJp+F
   3MaroBD6UIWiOWmjfqnWDVszmpy3KyksGAsqiML1Sht28BJqtAnCKG40l
   ECwAIrmiNTUH/Pu2aKASonxIL4C4D/lSaQcLIKDE7qN1ih/snngzKSaJ0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="237381594"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="237381594"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 14:01:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="506928098"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2021 14:01:49 -0800
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
Subject: [PATCH v2 06/11] x86/fpu: Clear PASID when copying fpstate
Date:   Fri, 17 Dec 2021 22:01:31 +0000
Message-Id: <20211217220136.2762116-7-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217220136.2762116-1-fenghua.yu@intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel must allocate a Process Address Space ID (PASID) on behalf of
each process which will use ENQCMD and program it into the new MSR to
communicate the process identity to platform hardware. ENQCMD uses the
PASID stored in this MSR to tag requests from this process.

The PASID state must be cleared on fork() since fork creates a
new address space.

For clone(), it would be functionally OK to copy the PASID. However,
clearing it is _also_ functionally OK since any PASID use will trigger
the #GP handler to populate the MSR.

Copying the PASID state has two main downsides:
 * It requires differentiating fork() and clone() in the code,
   both in the FPU code and keeping tsk->pasid_activated consistent.
 * It guarantees that the PASID is out of its init state, which
   incurs small but non-zero cost on every XSAVE/XRSTOR.

The main downside of clearing the PASID at fpstate copy is the future,
one-time #GP for the thread.

Use the simplest approach: clear the PASID state both on clone() and
fork().  Rely on the #GP handler for MSR population in children.

Also, just clear the PASID bit from xfeatures if XSAVE is supported.
This will have no effect on systems that do not have PASID support.  It
is virtually zero overhead because 'dst_fpu' was just written and
the whole thing is cache hot.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Rewrite changelog (Dave Hansen).
- Move xfeature tweaking into fpu_clone() and make it unconditional
  if XSAVE is supported (Dave Hansen).

 arch/x86/kernel/fpu/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 8ea306b1bf8e..13fc0ea52237 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -518,6 +518,13 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags)
 		fpu_inherit_perms(dst_fpu);
 	fpregs_unlock();
 
+	/*
+	 * Children never inherit PASID state.
+	 * Force it to have its init value:
+	 */
+	if (use_xsave())
+		dst_fpu->fpstate->regs.xsave.header.xfeatures &= ~XFEATURE_MASK_PASID;
+
 	trace_x86_fpu_copy_src(src_fpu);
 	trace_x86_fpu_copy_dst(dst_fpu);
 
-- 
2.34.1

