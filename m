Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC194A01EF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351402AbiA1U3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:29:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:61402 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351204AbiA1U3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643401764; x=1674937764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xDQdQWuDTNQebXOoM6D02Rc8q/BYhAiS+q/XkCoK6F4=;
  b=i1plt4OhLMJ85KzTGU/cGGwV3DNaKV8y9OKSg4pFdsWApLmErHvUVBIK
   20l75JR5tLv3iYg7ldj+5TPl7zJG9uK23q5Knz26JtBwYWDaEk5qSMNbf
   lwFCA2PazYn7iRsTvSS9gnxLxp1jg7sfiCPGxhTDUJI3NSzLUj7aeKwQu
   bX5vOE+TwxxErQ+yfS9+QAQ7kxIzEsaLYW2w28h4lfj3KvdsCmNsZ1Pww
   OGHSHZ3d5XYWt6sMDDXLenQbYfDb4rvkxmd1dPgQCdM6wgZk3wRYx4Gqg
   lyQGTsj04kQ2bvmMXb/nUZJXhA3TlNV8R3FBSekm/YcCS6BOTDvKzUqll
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="234578010"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="234578010"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 12:29:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="618827707"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jan 2022 12:29:22 -0800
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
Subject: [PATCH v3 07/11] sched: Define and initialize a flag to identify valid PASID in the task
Date:   Fri, 28 Jan 2022 12:29:01 -0800
Message-Id: <20220128202905.2274672-8-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128202905.2274672-1-fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Add a new single bit field to the task structure to track whether this task
has initialized the IA32_PASID MSR to the mm's PASID.

Initialize the field to zero when creating a new task with fork/clone.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Change condition to more accurate CONFIG_IOMMU_SVA (Jacob)

 include/linux/sched.h | 3 +++
 kernel/fork.c         | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f5b2be39a78c..812e40c5bde5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -938,6 +938,9 @@ struct task_struct {
 	/* Recursion prevention for eventfd_signal() */
 	unsigned			in_eventfd_signal:1;
 #endif
+#ifdef CONFIG_IOMMU_SVA
+	unsigned			pasid_activated:1;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
diff --git a/kernel/fork.c b/kernel/fork.c
index c03c6682464c..51fd1df994b7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -968,6 +968,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->use_memdelay = 0;
 #endif
 
+#ifdef CONFIG_IOMMU_SVA
+	tsk->pasid_activated = 0;
+#endif
+
 #ifdef CONFIG_MEMCG
 	tsk->active_memcg = NULL;
 #endif
-- 
2.35.0

