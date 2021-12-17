Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65764796CB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhLQWCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:02:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:26498 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231137AbhLQWBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639778510; x=1671314510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UnMZO3dIpMprFJhYU1oJBcxLAM+pPp7MOtKZRkV+U7g=;
  b=WO26FheBg1Pje1/l8YZ3TYZHiCSumGFB8YBYuKbU/Golyi6ge2yFL2Tx
   dMd/hhAieM1qK14LoyORbd8ph9moEvAqUkeoh+YriV5HHb+YGGDD+0Axt
   MdanOQXPdKquM1vN4oTxm8UO5S77I2C2I+5g42Ieo1rrKkmBipnJsglJH
   mO+Pe+OQ8GK+Obz/PA5DOWujVT3xar4Rtx3IcHPmNK56JuxBDzl6QOwY9
   k80RAI/mDi5KabIdHOLzsIt6ok+/iE2cLGRQxo4p/kH/+ISXq8yJ57Y9D
   9BC25vFGczcu2iDetGGMkv0sUN87mAB7IkiNIF1Wr2W5Q0j3nN4UWGfeW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="237381600"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="237381600"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 14:01:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="506928102"
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
Subject: [PATCH v2 07/11] sched: Define and initialize a flag to identify valid PASID in the task
Date:   Fri, 17 Dec 2021 22:01:32 +0000
Message-Id: <20211217220136.2762116-8-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217220136.2762116-1-fenghua.yu@intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
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
index 78c351e35fec..41a0b5703f94 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -933,6 +933,9 @@ struct task_struct {
 	/* Recursion prevention for eventfd_signal() */
 	unsigned			in_eventfd_signal:1;
 #endif
+#ifdef CONFIG_IOMMU_SVA
+	unsigned			pasid_activated:1;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 3adad225cc09..cd297926b6f2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -967,6 +967,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
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
2.34.1

