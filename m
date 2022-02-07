Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4EE4ACD36
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344767AbiBHBD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245462AbiBGXDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:03:31 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED64C061A73
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644275010; x=1675811010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dcqYJ5g1xNlLeHNxm7HxWP+rdA8fELICnTfN3W2xdQk=;
  b=nmxgbLL7NVf4C7n7n+dmL/SvxJCdR3DK3O9e+nGiQHuRduZHji/eblaF
   8tFqFMwC3IaAN8mYQAqOQr65Uq5WuUndZKkhgoVBilU9GmsePCtNZBfxi
   zzgBgwSV1ZZ0GpuspS3yPZHr2ZndL+OQcsyx+KF+fRdhhWPvBO9lN2+GP
   p2Bti4keTRuSZw1/F96IpCg5hgUAwB4bSfCBX//rZNufdTzCArDHH6kHN
   JNTOit6n6qgFyLRxpPs1CNzoSQ6RK7ZscKWEZijzluba6XaxMyYlAouQh
   cc6MG+nb23kZOWY4fRfHwPL+eWCHJjdcej/G0dgLNZSLgjCDh4cWSUPzt
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="229475020"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="229475020"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 15:03:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="540324091"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga008.jf.intel.com with ESMTP; 07 Feb 2022 15:03:06 -0800
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
Subject: [PATCH v4 09/11] x86/cpufeatures: Re-enable ENQCMD
Date:   Mon,  7 Feb 2022 15:02:52 -0800
Message-Id: <20220207230254.3342514-10-fenghua.yu@intel.com>
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

Since ENQCMD is handled by #GP fix up, it can be re-enabled.

The ENQCMD feature can only be used if CONFIG_INTEL_IOMMU_SVM is set. Add
X86_FEATURE_ENQCMD to the disabled features mask as appropriate so that
cpu_feature_enabled() can be used to check the feature.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
v4:
- Add "Reviewed-by: Thomas Gleixner <tglx@linutronix.de>" (Thomas).

v2:
- Update the commit message (Tony).

 arch/x86/include/asm/disabled-features.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 8f28fafa98b3..1231d63f836d 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -56,8 +56,11 @@
 # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
 #endif
 
-/* Force disable because it's broken beyond repair */
-#define DISABLE_ENQCMD		(1 << (X86_FEATURE_ENQCMD & 31))
+#ifdef CONFIG_INTEL_IOMMU_SVM
+# define DISABLE_ENQCMD		0
+#else
+# define DISABLE_ENQCMD		(1 << (X86_FEATURE_ENQCMD & 31))
+#endif
 
 #ifdef CONFIG_X86_SGX
 # define DISABLE_SGX	0
-- 
2.35.1

