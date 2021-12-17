Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7C54796C4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhLQWBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:01:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:26492 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhLQWBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639778508; x=1671314508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NHuCxyOdESdoiv75buH1o0WjIBI3bzfAYUCIy2K5lYI=;
  b=bAy93BPmwYowB7KeNRrC4s/ALFrqq1l/E7P4pje1pJUxkJaDeuaUspF3
   lkkyXyNHRZPdD7zsYjGzviK1/ACB3gsvQ0rOmk/ekQgma0JV19Ngm9jhF
   ZfUvpNVCVnxpe/ahWFJAFar5ze0OEonkujPpiVnu0ANUjBbxLUVwo1ftW
   CM9+lcPaB4UrncoMdujJWxUapQiGzfUE/W+L+tZotOri0nehDADrjDh2F
   k0A5kYC5nPl+3xEKNwf+nS3j9NRoVMtm+IKhtP/LyEuCngxxr6QptYKLv
   5jCUhtD7krXMB6aOLdrzDzzyoypHzP7exRd67/wEVXf7accZ90o1iec6r
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="237381585"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="237381585"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 14:01:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="506928076"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2021 14:01:47 -0800
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
Subject: [PATCH v2 02/11] mm: Change CONFIG option for mm->pasid field
Date:   Fri, 17 Dec 2021 22:01:27 +0000
Message-Id: <20211217220136.2762116-3-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217220136.2762116-1-fenghua.yu@intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This currently depends on CONFIG_IOMMU_SUPPORT. But it is only
needed when CONFIG_IOMMU_SVA option is enabled.

Change the CONFIG guards around definition and initialization
of mm->pasid field.

Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Change condition to more accurate CONFIG_IOMMU_SVA (Jacob and Tony)

 include/linux/mm_types.h | 2 +-
 kernel/fork.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c3a6e6209600..6d92121d5bd9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -643,7 +643,7 @@ struct mm_struct {
 #endif
 		struct work_struct async_put_work;
 
-#ifdef CONFIG_IOMMU_SUPPORT
+#ifdef CONFIG_IOMMU_SVA
 		u32 pasid;
 #endif
 	} __randomize_layout;
diff --git a/kernel/fork.c b/kernel/fork.c
index 3244cc56b697..b33c52021d4e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1020,7 +1020,7 @@ static void mm_init_owner(struct mm_struct *mm, struct task_struct *p)
 
 static void mm_init_pasid(struct mm_struct *mm)
 {
-#ifdef CONFIG_IOMMU_SUPPORT
+#ifdef CONFIG_IOMMU_SVA
 	mm->pasid = INIT_PASID;
 #endif
 }
-- 
2.34.1

