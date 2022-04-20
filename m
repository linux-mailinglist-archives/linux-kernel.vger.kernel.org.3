Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F111508D9D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380743AbiDTQsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380737AbiDTQsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:48:43 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF404443C4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:45:55 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id s21-20020a0568301e1500b006054da8e72dso1479926otr.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=URrV+dsd5lhQFXRTd4fWBRA4KRFBuCnaYk8CH/+FviM=;
        b=Fy8+zBTsGmtvsa/zjA9PDQ9Tp0zeCRvxzTkNstorrsMrsfFWDOymSR99XkxbPxb62m
         +0q0tL4+CpHCkaiORRAdn+B+FZ+nFZT0nTJL9eHxvZuxIivyXbXTQLxjlXYu89zHEW/6
         EUfohwahexE+asVwENDKab3Y2NDri10nXBIzs8e34QA1dGPq81DXLQ5sRKz/bPwbM2gw
         Yl2bz+G+S39GDvwoHjD85IQPGtu3flIg4/wI7IBqge5vyNcpFub0TRscxgKny3cPC9Nv
         vWfZbvw8cQsZxsvJ3hQLjW3CnedHMwXA5zchx/a/7LK99E6BQQcFeb//WwzCP+Oq3ne0
         EwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=URrV+dsd5lhQFXRTd4fWBRA4KRFBuCnaYk8CH/+FviM=;
        b=vZVSUK8pf08uNpEWdfIUnKedrkVt5Qr2beKmaBQCdlqtXnVMZFcDsOeGyVVojVSUfh
         i2Jk6b1C6wiMNmOj4O6MCK1vjppXyEpB/2dT3ynYmCofKWrLQ6mlJcgVWsI5YavlOAUO
         S7YlQO6Cpddk0695xWtAbSk8W7jjJHsLX5iNxB1n+tMA/eh70j3n//i1o97LqJ46EiJ5
         A2ksSuITa32OGpwcX4qu7LtAJFfMBgBZ3pLASuTE/gbOvzP5adoc+b5Oj44cgCt2wGAC
         cqspe51N2ad8kelryR3Hhj0EK8EKqIUORuB2N/OtJTJygNhDg5/jDyXf6dW4RngR6MR/
         Q4dA==
X-Gm-Message-State: AOAM531P2GaqSE/fImN/famV/1On5m/KZ7V5E+9lF/AzprnVtMTDnG43
        UUResblgPoiZlKXH6k/jwgSCnA==
X-Google-Smtp-Source: ABdhPJy1h6u//AAdgJWO8HEvV5gqZ6bNFKTGGXV/qhGmcU/AzX+AT/qttPl836/51IbTiv5cupS/yA==
X-Received: by 2002:a9d:1928:0:b0:604:13d5:b114 with SMTP id j40-20020a9d1928000000b0060413d5b114mr7810141ota.6.1650473155060;
        Wed, 20 Apr 2022 09:45:55 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id p63-20020a4a4842000000b00329c9188688sm7029817ooa.36.2022.04.20.09.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:45:54 -0700 (PDT)
Date:   Wed, 20 Apr 2022 17:45:25 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
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
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        robin.murphy@arm.com
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YmA4pbgevqln/jSO@myrica>
References: <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YllADL6uMoLllzQo@fyu1.sc.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 15, 2022 at 02:51:08AM -0700, Fenghua Yu wrote:
> From a6444e1e5bd8076f5e5c5e950d3192de327f0c9c Mon Sep 17 00:00:00 2001
> From: Fenghua Yu <fenghua.yu@intel.com>
> Date: Fri, 15 Apr 2022 00:51:33 -0700
> Subject: [RFC PATCH] iommu/sva: Fix PASID use-after-free issue
> 
> A PASID might be still used even though it is freed on mm exit.
> 
> process A:
> 	sva_bind();
> 	ioasid_alloc() = N; // Get PASID N for the mm
> 	fork(): // spawn process B
> 	exit();
> 	ioasid_free(N);
> 
> process B:
> 	device uses PASID N -> failure
> 	sva_unbind();
> 
> Dave Hansen suggests to take a refcount on the mm whenever binding the
> PASID to a device and drop the refcount on unbinding. The mm won't be
> dropped if the PASID is still bound to it.
> 
> Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID allocation and free it on mm exit")
> 
> Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
> Suggested-by: Dave Hansen" <dave.hansen@linux.intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 6 ++++++
>  drivers/iommu/intel/svm.c                       | 4 ++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 22ddd05bbdcd..3fcb842a0df0 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -7,6 +7,7 @@
>  #include <linux/mmu_context.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/slab.h>
> +#include <linux/sched/mm.h>
>  
>  #include "arm-smmu-v3.h"
>  #include "../../iommu-sva-lib.h"
> @@ -363,6 +364,9 @@ arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
>  
>  	mutex_lock(&sva_lock);
>  	handle = __arm_smmu_sva_bind(dev, mm);
> +	/* Take an mm refcount on a successful bind. */
> +	if (!IS_ERR(handle))
> +		mmget(mm);
>  	mutex_unlock(&sva_lock);
>  	return handle;
>  }
> @@ -372,6 +376,8 @@ void arm_smmu_sva_unbind(struct iommu_sva *handle)
>  	struct arm_smmu_bond *bond = sva_to_bond(handle);
>  
>  	mutex_lock(&sva_lock);
> +	/* Drop an mm refcount. */
> +	mmput(bond->mm);

I do like the idea because it will simplify the driver. We can't call
mmput() here, though, because it may call the release() MMU notifier which
will try to grab sva_lock, already held.

I also found another use-after-free in arm_smmu_free_shared_cd(), where we
call arm64_mm_context_put() when the mm could already be freed. There used
to be an mmgrab() preventing this but it went away during a rewrite.

To fix both we could just move mmput() at the end of unbind() but I'd
rather do a proper cleanup removing the release() notifier right away.
Zhangfei, could you try the patch below?

Thanks,
Jean

--- 8< ---

From 4e09c0d71dfb35fc90915bd1e36545027fbf8a03 Mon Sep 17 00:00:00 2001
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Wed, 20 Apr 2022 10:19:24 +0100
Subject: [PATCH] iommu/arm-smmu-v3-sva: Fix PASID and mm use-after-free issues

Commit 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID
allocation and free it on mm exit") frees the PASID earlier than what
the SMMUv3 driver expects. At the moment the SMMU driver handles mm exit
in the release() MMU notifier by quiescing the context descriptor. The
context descriptor is only made invalid in unbind(), after the device
driver ensured the PASID is not used anymore. Releasing the PASID on mm
exit may cause it to be reallocated while it is still used by the
context descriptor.

There is another use-after-free, present since the beginning, where we
call arm64_mm_context_put() without a guarantee that mm_count is held.

Dave Hansen suggests to grab mm_users whenever binding the mm to a
device and drop it on unbinding. With that we can fix both issues and
simplify the driver by removing the release() notifier.

Fixes: 32784a9562fb ("iommu/arm-smmu-v3: Implement iommu_sva_bind/unbind()")
Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 -
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 49 +++++--------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 14 +-----
 3 files changed, 15 insertions(+), 49 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index cd48590ada30..d50d215d946c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -735,7 +735,6 @@ static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 
 extern struct xarray arm_smmu_asid_xa;
 extern struct mutex arm_smmu_asid_lock;
-extern struct arm_smmu_ctx_desc quiet_cd;
 
 int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 			    struct arm_smmu_ctx_desc *cd);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 22ddd05bbdcd..f9dff0f6cdd4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -6,6 +6,7 @@
 #include <linux/mm.h>
 #include <linux/mmu_context.h>
 #include <linux/mmu_notifier.h>
+#include <linux/sched/mm.h>
 #include <linux/slab.h>
 
 #include "arm-smmu-v3.h"
@@ -15,7 +16,6 @@
 struct arm_smmu_mmu_notifier {
 	struct mmu_notifier		mn;
 	struct arm_smmu_ctx_desc	*cd;
-	bool				cleared;
 	refcount_t			refs;
 	struct list_head		list;
 	struct arm_smmu_domain		*domain;
@@ -96,9 +96,14 @@ static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
 	struct arm_smmu_ctx_desc *cd;
 	struct arm_smmu_ctx_desc *ret = NULL;
 
+	/* Prevent mm exit as long as it is used by the context descriptor */
+	mmget(mm);
+
 	asid = arm64_mm_context_get(mm);
-	if (!asid)
-		return ERR_PTR(-ESRCH);
+	if (!asid) {
+		err = -ESRCH;
+		goto out_put_mm;
+	}
 
 	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
 	if (!cd) {
@@ -165,6 +170,8 @@ static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
 	kfree(cd);
 out_put_context:
 	arm64_mm_context_put(mm);
+out_put_mm:
+	mmput(mm);
 	return err < 0 ? ERR_PTR(err) : ret;
 }
 
@@ -173,6 +180,7 @@ static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
 	if (arm_smmu_free_asid(cd)) {
 		/* Unpin ASID */
 		arm64_mm_context_put(cd->mm);
+		mmput(cd->mm);
 		kfree(cd);
 	}
 }
@@ -191,30 +199,6 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
 }
 
-static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
-{
-	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
-	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
-
-	mutex_lock(&sva_lock);
-	if (smmu_mn->cleared) {
-		mutex_unlock(&sva_lock);
-		return;
-	}
-
-	/*
-	 * DMA may still be running. Keep the cd valid to avoid C_BAD_CD events,
-	 * but disable translation.
-	 */
-	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, &quiet_cd);
-
-	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
-	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
-
-	smmu_mn->cleared = true;
-	mutex_unlock(&sva_lock);
-}
-
 static void arm_smmu_mmu_notifier_free(struct mmu_notifier *mn)
 {
 	kfree(mn_to_smmu(mn));
@@ -222,7 +206,6 @@ static void arm_smmu_mmu_notifier_free(struct mmu_notifier *mn)
 
 static const struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
 	.invalidate_range	= arm_smmu_mm_invalidate_range,
-	.release		= arm_smmu_mm_release,
 	.free_notifier		= arm_smmu_mmu_notifier_free,
 };
 
@@ -290,14 +273,8 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	list_del(&smmu_mn->list);
 	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, NULL);
 
-	/*
-	 * If we went through clear(), we've already invalidated, and no
-	 * new TLB entry can have been formed.
-	 */
-	if (!smmu_mn->cleared) {
-		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
-		arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
-	}
+	arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
+	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
 
 	/* Frees smmu_mn */
 	mmu_notifier_put(&smmu_mn->mn);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 627a3ed5ee8f..246670318eda 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -76,12 +76,6 @@ struct arm_smmu_option_prop {
 DEFINE_XARRAY_ALLOC1(arm_smmu_asid_xa);
 DEFINE_MUTEX(arm_smmu_asid_lock);
 
-/*
- * Special value used by SVA when a process dies, to quiesce a CD without
- * disabling it.
- */
-struct arm_smmu_ctx_desc quiet_cd = { 0 };
-
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
 	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
@@ -1047,9 +1041,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	 * (2) Install a secondary CD, for SID+SSID traffic.
 	 * (3) Update ASID of a CD. Atomically write the first 64 bits of the
 	 *     CD, then invalidate the old entry and mappings.
-	 * (4) Quiesce the context without clearing the valid bit. Disable
-	 *     translation, and ignore any translation fault.
-	 * (5) Remove a secondary CD.
+	 * (4) Remove a secondary CD.
 	 */
 	u64 val;
 	bool cd_live;
@@ -1065,10 +1057,8 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	val = le64_to_cpu(cdptr[0]);
 	cd_live = !!(val & CTXDESC_CD_0_V);
 
-	if (!cd) { /* (5) */
+	if (!cd) { /* (4) */
 		val = 0;
-	} else if (cd == &quiet_cd) { /* (4) */
-		val |= CTXDESC_CD_0_TCR_EPD0;
 	} else if (cd_live) { /* (3) */
 		val &= ~CTXDESC_CD_0_ASID;
 		val |= FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid);
-- 
2.35.1

