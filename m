Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE31950279E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349848AbiDOJxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbiDOJxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:53:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4248B6E6B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650016242; x=1681552242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=k0+BB6ioS9sg4ZQkLIJuljI7na5dCngyl54RvX7fbN8=;
  b=hvEqWuLeRQ5mjL3060IaVYT6YPp2x6jdINCBQrCyJQzBFuH0wxOBg3CN
   9hha7IJ49RjtxnQd2AeZhPRUxZF9AnbmtImAOvuzPHQEdEEDqFbTlnMZ9
   m+UjVL63mmdDImm3JgQAIJ1KsrXxPQ8iYgJw745aseoNfXG50/xtSSkJE
   OuJ2pR9MqkABWOMmBALQBH1oXpjHs95E8QHuQy/coL+pcsAppkk0JvUsb
   ram+ASwu9H8GvEZFs37zKDx+lvlMpnC4a/zc3ADdCN0OqFbX/4yzd9nue
   4XQsmHIjqZ5XkSn/SE7dd2uLhyhuJqkKTT57YP+BPTpx6veSuR5ebpasy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="262883274"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="262883274"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 02:50:42 -0700
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="553089696"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 02:50:41 -0700
Date:   Fri, 15 Apr 2022 02:51:08 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YllADL6uMoLllzQo@fyu1.sc.intel.com>
References: <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 06:08:09PM +0800, zhangfei.gao@foxmail.com wrote:
> 
> On 2022/4/12 下午11:35, zhangfei.gao@foxmail.com wrote:
> > Hi, Fenghua
> > 
> > On 2022/4/12 下午9:41, Fenghua Yu wrote:
> > > Hi, Zhangfei,
> > > 
> > > On Tue, Apr 12, 2022 at 03:04:09PM +0800, zhangfei.gao@foxmail.com
> > > wrote:
> > > > 
> > > > On 2022/4/11 下午10:52, Dave Hansen wrote:
> > > > > On 4/11/22 07:44, zhangfei.gao@foxmail.com wrote:
> > > > > > On 2022/4/11 下午10:36, Dave Hansen wrote:
> > > > > > > On 4/11/22 07:20, zhangfei.gao@foxmail.com wrote:
> > Agree with Dave, I think user space should not be broken.
> > 
> > Thanks
> 
> Any plan about this regression?
> Currently I need this patch to workaround the issue.
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 22ddd05bbdcd..2d74ac53d11c 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -4,6 +4,7 @@
>   */
> 
>  #include <linux/mm.h>
> +#include <linux/sched/mm.h>
>  #include <linux/mmu_context.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/slab.h>
> @@ -363,6 +364,7 @@ arm_smmu_sva_bind(struct device *dev, struct mm_struct
> *mm, void *drvdata)
> 
>         mutex_lock(&sva_lock);
>         handle = __arm_smmu_sva_bind(dev, mm);
> +       mmget(mm);
>         mutex_unlock(&sva_lock);
>         return handle;
>  }
> @@ -377,6 +379,7 @@ void arm_smmu_sva_unbind(struct iommu_sva *handle)
>                 arm_smmu_mmu_notifier_put(bond->smmu_mn);
>                 kfree(bond);
>         }
> +       mmput(bond->mm);
>         mutex_unlock(&sva_lock);
>  }

Could you please review and/or test this patch? It's supposed to fix
the PASID issue on both ARM and X86.

From a6444e1e5bd8076f5e5c5e950d3192de327f0c9c Mon Sep 17 00:00:00 2001
From: Fenghua Yu <fenghua.yu@intel.com>
Date: Fri, 15 Apr 2022 00:51:33 -0700
Subject: [RFC PATCH] iommu/sva: Fix PASID use-after-free issue

A PASID might be still used even though it is freed on mm exit.

process A:
	sva_bind();
	ioasid_alloc() = N; // Get PASID N for the mm
	fork(): // spawn process B
	exit();
	ioasid_free(N);

process B:
	device uses PASID N -> failure
	sva_unbind();

Dave Hansen suggests to take a refcount on the mm whenever binding the
PASID to a device and drop the refcount on unbinding. The mm won't be
dropped if the PASID is still bound to it.

Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID allocation and free it on mm exit")

Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
Suggested-by: Dave Hansen" <dave.hansen@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 6 ++++++
 drivers/iommu/intel/svm.c                       | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 22ddd05bbdcd..3fcb842a0df0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -7,6 +7,7 @@
 #include <linux/mmu_context.h>
 #include <linux/mmu_notifier.h>
 #include <linux/slab.h>
+#include <linux/sched/mm.h>
 
 #include "arm-smmu-v3.h"
 #include "../../iommu-sva-lib.h"
@@ -363,6 +364,9 @@ arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
 
 	mutex_lock(&sva_lock);
 	handle = __arm_smmu_sva_bind(dev, mm);
+	/* Take an mm refcount on a successful bind. */
+	if (!IS_ERR(handle))
+		mmget(mm);
 	mutex_unlock(&sva_lock);
 	return handle;
 }
@@ -372,6 +376,8 @@ void arm_smmu_sva_unbind(struct iommu_sva *handle)
 	struct arm_smmu_bond *bond = sva_to_bond(handle);
 
 	mutex_lock(&sva_lock);
+	/* Drop an mm refcount. */
+	mmput(bond->mm);
 	if (refcount_dec_and_test(&bond->refs)) {
 		list_del(&bond->list);
 		arm_smmu_mmu_notifier_put(bond->smmu_mn);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 23a38763c1d1..345a0d5d7922 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -403,6 +403,8 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 		goto free_sdev;
 
 	list_add_rcu(&sdev->list, &svm->devs);
+	/* Take an mm refcount on binding mm. */
+	mmget(mm);
 success:
 	return &sdev->sva;
 
@@ -465,6 +467,8 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
 				kfree(svm);
 			}
 		}
+		/* Drop an mm reference on unbinding mm. */
+		mmput(mm);
 	}
 out:
 	return ret;
-- 
2.32.0

