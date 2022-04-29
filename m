Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0283A51584B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381463AbiD2WWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbiD2WW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:22:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DB4C4025
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651270749; x=1682806749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aAa0fJ78qBc0C3dnZn0iaoTUqMqzLiZJoB88GhSk4m8=;
  b=kq3/XT2qRZJ2IliJoSuGnvoQa6O6B2bhKaWJjclkY/zEOGqvM6xbxLfr
   NuaMbZcZCuNpaiiSSeWch8KU81OeCycG8vskXrywu7Tc4WJ3x1p2cc6VW
   GWJsyElp4lXu16Hq4SkGVozSE1bS3cxLx6AED39xRjNa2Y3LTK3SDuzs9
   Rv5/f3v1q6WeZdFlprH7x8/HYgm31FEkx/5zuDjFiCh1ZJZbun6dNl1hw
   wlPC+V9ZJCjv8j2UJiuxIqc5j2ci9gdka3Kv90tlg91lSdf4Mos7McYLF
   kS/1JEXsvh0Oqg4SYMdu+ZFH7oh9ViqLrKdfp5I6mB79x2E57kG8dzixT
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="291959968"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="291959968"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 15:19:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="597551432"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 15:19:09 -0700
Date:   Fri, 29 Apr 2022 15:19:39 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, robin.murphy@arm.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, zhangfei.gao@linaro.org,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <Ymxke+ihgwNy3BCE@fyu1.sc.intel.com>
References: <YmavoKkVu+hd+x0M@myrica>
 <22b659c7-e972-7a56-2bd7-8df3b4820d4e@intel.com>
 <YmbO/l5IwfBCHrl8@myrica>
 <8c044e49-74bb-df56-8a60-663013c0910e@intel.com>
 <YmgiQZZyFxsJ+9um@myrica>
 <63582490-a794-fd11-0380-44b27cc660b7@intel.com>
 <YmpSv48aPIbVXqGi@myrica>
 <044595e6-e5d0-26c2-af8e-fc9d06906179@linux.intel.com>
 <YmvtVRlwVJjStXc0@fyu1.sc.intel.com>
 <Ymv3fC4xXqe+oMRK@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymv3fC4xXqe+oMRK@myrica>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jean and Baolu,

On Fri, Apr 29, 2022 at 03:34:36PM +0100, Jean-Philippe Brucker wrote:
> On Fri, Apr 29, 2022 at 06:51:17AM -0700, Fenghua Yu wrote:
> > Hi, Baolu,
> > 
> > On Fri, Apr 29, 2022 at 03:53:57PM +0800, Baolu Lu wrote:
> > > On 2022/4/28 16:39, Jean-Philippe Brucker wrote:
> > > > > The address space is what the OOM killer is after.  That gets refcounted
> > > > > with mmget()/mmput()/mm->mm_users.  The OOM killer is satiated by the
> > > > > page freeing done in __mmput()->exit_mmap().
> > > > > 
> > > > > Also, all the VMAs should be gone after exit_mmap().  So, even if
> > > > > vma->vm_file was holding a reference to a device driver, that reference
> > > > > should be gone by the time __mmdrop() is actually freeing the PASID.
> > > > 
> > > > I agree with all that. The concern was about tearing down the PASID in the
> > > > IOMMU and device from the release() MMU notifier, which would happen in
> > > > exit_mmap(). But doing the teardown at or before __mmdrop() is fine. And
> > > > since the IOMMU drivers need to hold mm->mm_count anyway between bind()
> > > > and unbind(), I think Fenghua's fix works.
> > > 
> > > But I didn't find mmgrab()/mmdrop() get called in both arm and intel
> > > IOMMU drivers.
> > > 
> > > $ git grep mmgrab drivers/iommu/
> > > [no output]
> > > 
> > > Do we need to add these in a separated fix patch, or I missed anything
> > > here?
> > 
> > On both ARM and X86, sva_bind() calls mmu_notifier_register()->mmgrab() and
> > sva_unbind() calls mmu_notifier_unregister()/mmu_notifier_put()->mmdrop().
> 
> Yes, although for Arm I realized the mmu_notifier grab wasn't sufficient
> so I sent a separate fix that should go in 5.18 as well
> https://lore.kernel.org/linux-iommu/20220426130444.300556-1-jean-philippe@linaro.org/
> The Arm driver still touches the arch mm context after mmu_notifier_put().
> I don't think X86 has that problem.

I think so too. On X86, the mm is not used after mmu_notifier_unregister().

In case of supervisor mode SVM (i.e. svm is bound to init_mm), the code
is right too because init_mm and its PASID cannot be dropped and
mmu_notifier_register()/mmu_notifier_unregister() are not called.

So I think no extra fix patch is needed on X86.

Thanks.

-Fenghua
