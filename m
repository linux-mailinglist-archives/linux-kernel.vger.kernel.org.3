Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF074502882
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352491AbiDOKx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352481AbiDOKxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:53:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B3D69486
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 03:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650019845; x=1681555845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FcSxV9zaoQXd7xmHux0rD+oliTDOyHpL0739/2mzHhw=;
  b=f//JHa/rTGkRWG8NszTBkGgEQQcv0CVQPAw2lKqDj0tIp1f/JFNQw19b
   mGX8I6kWP9/TlbpayYcsikWUn8MCE612K1YJ6z9DYAgjbFqcILbBf8kb0
   /E6I58VEnKmOmiK8634TPsm8NHpgZOi/UOuL/2ZiYGcUc2wndQ6f9E9y5
   sGuASkkdigHh6eNpVjWHKH+M2Kz3D0SH/mLe6eDsHnR5QYtTeHG/FwJk3
   IpMjYJz6nllvHkHP2xV609fcTFY+EykIwt+tydw3AO/lq15VHT3zwVDAm
   DMumg1BMeg/BGqDBeC0EUMMDsjmqV+IAxJPYlYwfr3g6LvSuzZPhjNF+7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="250434823"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="250434823"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 03:50:45 -0700
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="574306314"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 03:50:44 -0700
Date:   Fri, 15 Apr 2022 03:50:36 -0700
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
Message-ID: <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
References: <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com>
 <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Zhangfei,

On Fri, Apr 15, 2022 at 06:14:09PM +0800, zhangfei.gao@foxmail.com wrote:
> 
> 
> On 2022/4/15 下午5:51, Fenghua Yu wrote:
> > On Thu, Apr 14, 2022 at 06:08:09PM +0800, zhangfei.gao@foxmail.com wrote:
> > > On 2022/4/12 下午11:35, zhangfei.gao@foxmail.com wrote:
> > > > Hi, Fenghua
> > > > 
> > > > On 2022/4/12 下午9:41, Fenghua Yu wrote:
> >  From a6444e1e5bd8076f5e5c5e950d3192de327f0c9c Mon Sep 17 00:00:00 2001
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > Date: Fri, 15 Apr 2022 00:51:33 -0700
> > Subject: [RFC PATCH] iommu/sva: Fix PASID use-after-free issue
> > 
> > A PASID might be still used even though it is freed on mm exit.
> > 
> > process A:
> > 	sva_bind();
> > 	ioasid_alloc() = N; // Get PASID N for the mm
> > 	fork(): // spawn process B
> > 	exit();
> > 	ioasid_free(N);
> > 
> > process B:
> > 	device uses PASID N -> failure
> > 	sva_unbind();
> > 
> > Dave Hansen suggests to take a refcount on the mm whenever binding the
> > PASID to a device and drop the refcount on unbinding. The mm won't be
> > dropped if the PASID is still bound to it.
> > 
> > Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID allocation and free it on mm exit")
> > 
> > Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
> > Suggested-by: Dave Hansen" <dave.hansen@linux.intel.com>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > ---
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 6 ++++++
> >   drivers/iommu/intel/svm.c                       | 4 ++++
> >   2 files changed, 10 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > index 22ddd05bbdcd..3fcb842a0df0 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > @@ -7,6 +7,7 @@
> >   #include <linux/mmu_context.h>
> >   #include <linux/mmu_notifier.h>
> >   #include <linux/slab.h>
> > +#include <linux/sched/mm.h>
> >   #include "arm-smmu-v3.h"
> >   #include "../../iommu-sva-lib.h"
> > @@ -363,6 +364,9 @@ arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
> >   	mutex_lock(&sva_lock);
> >   	handle = __arm_smmu_sva_bind(dev, mm);
> > +	/* Take an mm refcount on a successful bind. */
> > +	if (!IS_ERR(handle))
> > +		mmget(mm);
> >   	mutex_unlock(&sva_lock);
> >   	return handle;
> >   }
> > @@ -372,6 +376,8 @@ void arm_smmu_sva_unbind(struct iommu_sva *handle)
> >   	struct arm_smmu_bond *bond = sva_to_bond(handle);
> >   	mutex_lock(&sva_lock);
> > +	/* Drop an mm refcount. */
> > +	mmput(bond->mm);
> >   	if (refcount_dec_and_test(&bond->refs)) {
> >   		list_del(&bond->list);
> >   		arm_smmu_mmu_notifier_put(bond->smmu_mn);
> > diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> > index 23a38763c1d1..345a0d5d7922 100644
> > --- a/drivers/iommu/intel/svm.c
> > +++ b/drivers/iommu/intel/svm.c
> > @@ -403,6 +403,8 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
> >   		goto free_sdev;
> >   	list_add_rcu(&sdev->list, &svm->devs);
> > +	/* Take an mm refcount on binding mm. */
> > +	mmget(mm);
> >   success:
> >   	return &sdev->sva;
> > @@ -465,6 +467,8 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
> >   				kfree(svm);
> >   			}
> >   		}
> > +		/* Drop an mm reference on unbinding mm. */
> > +		mmput(mm);
> >   	}
> >   out:
> >   	return ret;
> This patch can not be applied on 5.18-rc2 for intel part.

What error do you see? Could you please send to me errors?

I download this patch from:
https://lore.kernel.org/lkml/YllADL6uMoLllzQo@fyu1.sc.intel.com/raw
git am to either v5.18-rc2 or the latest upstream without any issue.

> It should work for arm.
> 
> In fact I have a similar patch at hand but pending since I found an issue.
> 
> I start & stop nginx via this cmd.
> //start
> sudo sbin/nginx                    // this alloc an ioasid=1
> //stop
> sudo sbin/nginx -s quit    // this does not free ioasid=1, but still alloc
> ioasid=2.
> So ioasid will keep allocated but not freed if continue start/stop nginx, 
> though not impact the nginx function.
> 
> stop nginx with -s quit still calls
> src/core/nginx.c
> main -> ngx_ssl_init -> openssl engine:    bind_fn -> ... -> alloc asid
> But openssl engine: ENGINE_free is not called
> 
> Still in checking nginx code.
> 
> Or do you test with nginx?

On my X86 machine, nginx doesn't trigger the kernel sva binding function
to allocate ioasid. I tried pre- nstalled nginx/openssl and also tried my built
a few versions of nginx/openssl. nginx does call OPENSSL_init_ssl() but
doesn't go to the binding function. Don't know if it's my configuration issue.
Maybe you can give me some advice?

I test the patch with a few internal test tools and observe mmget()/mmput()
works fine in various cases.

Thanks.

-Fenghua 
