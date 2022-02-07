Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1170D4ACCF1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244957AbiBHBDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245429AbiBGXD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:03:28 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B981C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644275008; x=1675811008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZQuX/1pAiBPvBMAccFCq7xa5FLVExUm2Q9ePeODXOtk=;
  b=SKs62tmIVcjwb0eMnIX0peBq2WYQNZIG5/PdO/LsRYwJcowtHffnn8+R
   sL9AN/FyR33ic6NrNn/b9qho9Vq/rX73dbR50cpfiaIDRNm1x01By4mYA
   ilSl2z+kI0PYM05FIXZ079yOmLQJpCvIwmQBr+/rCGeTpDobtu72o+/R2
   6fqRcL+U88kLO12SWVybyvoW4WdzD5vnyrU6/cvmhWdXghzdBbs+q3eXS
   1TAZ/5Ta4h8I9ufU672xR8wHz0a3fYgwH3db9JGRPh9oi1xiDySzkxRtP
   8L5TfLuodKcqqneGCNt5U4OhvUpRETKocyya/rDd8B7lOHsDzbTgcA2e5
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="229475005"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="229475005"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 15:03:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="540324016"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga008.jf.intel.com with ESMTP; 07 Feb 2022 15:03:02 -0800
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
Subject: [PATCH v4 02/11] mm: Change CONFIG option for mm->pasid field
Date:   Mon,  7 Feb 2022 15:02:45 -0800
Message-Id: <20220207230254.3342514-3-fenghua.yu@intel.com>
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

This currently depends on CONFIG_IOMMU_SUPPORT. But it is only
needed when CONFIG_IOMMU_SVA option is enabled.

Change the CONFIG guards around definition and initialization
of mm->pasid field.

Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
v4:
- Add "Reviewed-by: Thomas Gleixner <tglx@linutronix.de>" (Thomas).

v2:
- Change condition to more accurate CONFIG_IOMMU_SVA (Jacob and Tony)

 include/linux/mm_types.h | 2 +-
 kernel/fork.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5140e5feb486..c5cbfd7915ad 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -631,7 +631,7 @@ struct mm_struct {
 #endif
 		struct work_struct async_put_work;
 
-#ifdef CONFIG_IOMMU_SUPPORT
+#ifdef CONFIG_IOMMU_SVA
 		u32 pasid;
 #endif
 	} __randomize_layout;
diff --git a/kernel/fork.c b/kernel/fork.c
index d75a528f7b21..6ee7551d3bd2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1021,7 +1021,7 @@ static void mm_init_owner(struct mm_struct *mm, struct task_struct *p)
 
 static void mm_init_pasid(struct mm_struct *mm)
 {
-#ifdef CONFIG_IOMMU_SUPPORT
+#ifdef CONFIG_IOMMU_SVA
 	mm->pasid = INIT_PASID;
 #endif
 }
-- 
2.35.1

