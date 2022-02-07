Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991984ACD32
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344696AbiBHBDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245441AbiBGXD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:03:29 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAE8C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644275009; x=1675811009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qAN6i2tcGpKHAdLmfykkJrrQYTFoSpMh8/ZHA7l/RSs=;
  b=GpP7HVsV0ZT44Q5jMpLdlHIl/lreOIp502LymK7yz2L5lx8uTeLcNobf
   FE2YGwq+yLLs7g0Y7mXF4QBSCF7whIi4u4tkwhOxn3LO7S0EtV73tq27k
   p9UMKLvR56USnH13L286N7eqdmDqxMTh+aMPqSXOKksd5t3tinXW1LSNO
   p4DJAhCWqLvYpziUD2R8XCrOy4cI/mQxnK2JJU044eq2mG48CLtLHzxrJ
   4Pg4L8W7CUZXcO7eSZW62csizyxwZYQpFe9pO3sw39vkYFPSQDZXkhlrU
   FiQuU4uwudCFlEnNQDa5sxsJjm7BBVpdNYzwQ2+/yPsvvXKGFKOAEFqk0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="229475017"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="229475017"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 15:03:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="540324076"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga008.jf.intel.com with ESMTP; 07 Feb 2022 15:03:05 -0800
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
Subject: [PATCH v4 07/11] sched: Define and initialize a flag to identify valid PASID in the task
Date:   Mon,  7 Feb 2022 15:02:50 -0800
Message-Id: <20220207230254.3342514-8-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207230254.3342514-1-fenghua.yu@intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
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

From: Peter Zijlstra <peterz@infradead.org>

Add a new single bit field to the task structure to track whether this task
has initialized the IA32_PASID MSR to the mm's PASID.

Initialize the field to zero when creating a new task with fork/clone.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
v4:
- Add "Reviewed-by: Thomas Gleixner <tglx@linutronix.de>" (Thomas).

v2:
- Change condition to more accurate CONFIG_IOMMU_SVA (Jacob)

 include/linux/sched.h | 3 +++
 kernel/fork.c         | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 75ba8aa60248..4e5de3aed410 100644
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
2.35.1

