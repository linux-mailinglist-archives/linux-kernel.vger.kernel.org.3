Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB5E4796C6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhLQWB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:01:57 -0500
Received: from mga11.intel.com ([192.55.52.93]:26496 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230498AbhLQWBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639778508; x=1671314508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h2zjBHw31kxQlzvVTL7vpb6HSLLXWXz/ULtGSJqMjjU=;
  b=XA13eyqAU+lEiYeCuGPJYLbdhXP70jHn3nNxyv9XSod2o/4b9iYiecTX
   61g9h8V3X68c52RnfFABs55HomXh9/P6rxk/l+wnLh3WUoJHcB0EgCDnO
   XC4lr5C//vLSxyACNKe+upMg4lnPv5Wt36mL2VRJ5cQutwPPo1AUESdJ2
   leXRZFTrq0nVloi7/FD3bw2EgBWqotX3OFmN0FpRUlNb+DhrLloeZ9SsT
   fbMHMX2OXGwiAkVtRNRsv7jCGzIWVD9jsLtZF1VibcCjt3kZVIY3anjwq
   TuseeusmH0IWxuYNdZtQbO6XA+0sDozdtj/HZk8Iui+8/r9yfdD8nyYBf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="237381587"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="237381587"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 14:01:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="506928082"
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
Subject: [PATCH v2 03/11] iommu/ioasid: Introduce a helper to check for valid PASIDs
Date:   Fri, 17 Dec 2021 22:01:28 +0000
Message-Id: <20211217220136.2762116-4-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217220136.2762116-1-fenghua.yu@intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pasid_valid() is defined to check if a given PASID is valid.

Suggested-by: Ashok Raj <ashok.raj@intel.com>
Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Define a helper pasid_valid() (Ashok, Jacob, Thomas, Tony)

 include/linux/ioasid.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index e9dacd4b9f6b..2237f64dbaae 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -41,6 +41,10 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_set_data(ioasid_t ioasid, void *data);
+static inline bool pasid_valid(ioasid_t ioasid)
+{
+	return ioasid != INVALID_IOASID;
+}
 
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
@@ -78,5 +82,10 @@ static inline int ioasid_set_data(ioasid_t ioasid, void *data)
 	return -ENOTSUPP;
 }
 
+static inline bool pasid_valid(ioasid_t ioasid)
+{
+	return false;
+}
+
 #endif /* CONFIG_IOASID */
 #endif /* __LINUX_IOASID_H */
-- 
2.34.1

