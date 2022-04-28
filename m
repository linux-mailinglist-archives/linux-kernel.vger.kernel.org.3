Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9C0513B28
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350677AbiD1SDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbiD1SDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:03:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDCB6C96B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651168834; x=1682704834;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gcCHMN2R3ZV830nUOD2eh8/g6lV0UH2wZKBz4H8GihI=;
  b=EmwrMBEphGyq3saHhXruDZu5beJRXACzXeOA0V5s5iPzrUejMnCUNQE4
   GAH5YDcvCIXGL/YUIBYAI7FfYAzA6+baK5HmsJu2u+f4NPxKlv4yxmRjZ
   /dF3QMnoS8a9ZkzuKIv7lWgj9NnbuXQ6hLkg/VZxP+br+gARPBQE98Etp
   t2gafOlcU2ycmh/abo+QEs/CiuZVFrCD9+xcqVGXdhNxMGgXw3iu6Vj3j
   COPHd8d0c24KedHKW3SsmwJRmsHMbfFMEdzV1ga8cHDzFCAqkUZY5VW+U
   VhDd4cTJMQAbjEU6hKbFPMucpAa6JxK4Tth6Y8uPPLPj8vWuIvS3Gt3Vd
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="266528768"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="266528768"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 11:00:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="596910482"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga001.jf.intel.com with ESMTP; 28 Apr 2022 11:00:33 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "Zhangfei Gao" <zhangfei.gao@linaro.org>,
        "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>, "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Zhangfei Gao <zhangfei.gao@foxmail.com>
Subject: [PATCH v2] iommu/sva: Fix PASID use-after-free issue
Date:   Thu, 28 Apr 2022 11:00:41 -0700
Message-Id: <20220428180041.806809-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PASID is being freed too early.  It needs to stay around until after
device drivers that might be using it have had a chance to clear it out
of the hardware.

As a reminder:

mmget() /mmput()  refcount the mm's address space
mmgrab()/mmdrop() refcount the mm itself

The PASID is currently tied to the life of the mm's address space and
freed in __mmput().  This makes logical sense because the PASID can't be
used once the address space is gone.

But, this misses an important point: even after the address space is
gone, the PASID will still be programmed into a device.  Device drivers
might, for instance, still need to flush operations that are outstanding
and need to use that PASID.  They do this at file->release() time.

Device drivers call the IOMMU driver to hold a reference on the mm itself
and drop it at file->release() time.  But, the IOMMU driver holds a
reference on the mm itself, not the address space.  The address space
(and the PASID) is long gone by the time the driver tries to clean up.
This is effectively a use-after-free bug on the PASID.

To fix this, move the PASID free operation from __mmput() to __mmdrop().
This ensures that the IOMMU driver's existing mmgrab() keeps the PASID
allocated until it drops its mm reference.

Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID allocation and free it on mm exit")

Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
Tested-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---

v2:
- Dave Hansen rewrites the change log.
- Add Tested-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
- Add Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

The original patch was posted and discussed in:
https://lore.kernel.org/lkml/YmdzFFx7fN586jcf@fyu1.sc.intel.com/

 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 9796897560ab..35a3beff140b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -792,6 +792,7 @@ void __mmdrop(struct mm_struct *mm)
 	mmu_notifier_subscriptions_destroy(mm);
 	check_mm(mm);
 	put_user_ns(mm->user_ns);
+	mm_pasid_drop(mm);
 	free_mm(mm);
 }
 EXPORT_SYMBOL_GPL(__mmdrop);
@@ -1190,7 +1191,6 @@ static inline void __mmput(struct mm_struct *mm)
 	}
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
-	mm_pasid_drop(mm);
 	mmdrop(mm);
 }
 
-- 
2.32.0

