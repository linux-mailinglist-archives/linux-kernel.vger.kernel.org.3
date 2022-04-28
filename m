Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2AB512853
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 02:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239305AbiD1A5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 20:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiD1A5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 20:57:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9431161289
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651107263; x=1682643263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mF7e3wMds3iUFV1P2ZkCmb7Bzuyagf/LHBu67W4SX68=;
  b=PkrfzqxkFncV6KhyUA5dnUrlmL+A1gqG6jyE0H8Tlx5KE2own+NGfgbj
   oQM6AkgGb16IvfKZmX0XavfDCSG2xl0imzLbCJsMp6myWaOtnOloCYNjW
   q/rabWQvLbG6IOyZidS1nb8cABPA/eVZrpDnKFoCSS6tr2AOo6SLmiwhv
   4MukE65ETO7uhODb7A6Ras3L3kiVKl/S0h1lrqKZLmaCAUZk9FTPVXvKY
   /xfRy+/x9k7QDogrEo1JZpOJAaPmij7XJ+ZLwM6CT1x7oluMpCHp80H+f
   IOF7amD/9lmdF7KMYYjW13UkmP/2zbxC0eugyFNK17/3y+/1hEXyxcTuh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="264966700"
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="264966700"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 17:54:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="559317565"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 17:54:22 -0700
Date:   Wed, 27 Apr 2022 17:54:57 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
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
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <Ymnl4S6ukb8kgwaq@fyu1.sc.intel.com>
References: <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica>
 <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica>
 <20220425083444.00af5674@jacob-builder>
 <YmbIjnHtibY7n4Wb@myrica>
 <YmdzFFx7fN586jcf@fyu1.sc.intel.com>
 <51514a02-0de9-2f9e-ec0e-c86e147fa74c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51514a02-0de9-2f9e-ec0e-c86e147fa74c@linaro.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dave and Jean,

On Tue, Apr 26, 2022 at 01:04:45PM +0800, Zhangfei Gao wrote:
> 
> 
> On 2022/4/26 下午12:20, Fenghua Yu wrote:
> > Hi, Jean and Zhangfei,
> > 
> > On Mon, Apr 25, 2022 at 05:13:02PM +0100, Jean-Philippe Brucker wrote:
> > > Could we move mm_pasid_drop() to __mmdrop() instead of __mmput()?  For Arm
> > > we do need to hold the mm_count until unbind(), and mmgrab()/mmdrop() is
> > > also part of Lu's rework [1].
> > Is this a right fix for the issue? Could you please test it on ARM?
> > I don't have an ARM machine.
> > 
> > Thanks.
> > 
> > -Fenghua
> > 
> >  From 84aa68f6174439d863c40cdc2db0e1b89d620dd0 Mon Sep 17 00:00:00 2001
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > Date: Fri, 15 Apr 2022 00:51:33 -0700
> > Subject: [PATCH] iommu/sva: Fix PASID use-after-free issue
> > 
> > A PASID might be still used on ARM after it is freed in __mmput().
> > 
> > process:
> > 	open()->sva_bind()->ioasid_alloc() = N; // Get PASID N for the mm
> > 	exit();
> > 	exit_mm()->__mmput()->mm_pasid_drop()->mm->pasid = -1; // PASID -1
> > 	exit_files()->release(dev)->sva_unbind()->use mm->pasid; // Failure
> > 
> > To avoid the use-after-free issue, free the PASID after no device uses it,
> > i.e. after all devices are unbound from the mm.
> > 
> > sva_bind()/sva_unbind() call mmgrab()/mmdrop() to track mm->mm_count.
> > __mmdrop() is called only after mm->mm_count is zero. So freeing the PASID
> > in __mmdrop() guarantees the PASID is safely freed only after no device
> > is bound to the mm.
> > 
> > Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID allocation and free it on mm exit")
> > 
> > Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
> > Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Thanks for the fix.
> 
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> 
> 
> > ---
> >   kernel/fork.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 9796897560ab..35a3beff140b 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -792,6 +792,7 @@ void __mmdrop(struct mm_struct *mm)
> >   	mmu_notifier_subscriptions_destroy(mm);
> >   	check_mm(mm);
> >   	put_user_ns(mm->user_ns);
> > +	mm_pasid_drop(mm);
> >   	free_mm(mm);
> >   }
> >   EXPORT_SYMBOL_GPL(__mmdrop);
> > @@ -1190,7 +1191,6 @@ static inline void __mmput(struct mm_struct *mm)
> >   	}
> >   	if (mm->binfmt)
> >   		module_put(mm->binfmt->module);
> > -	mm_pasid_drop(mm);
> >   	mmdrop(mm);
> >   }
> 

Is this patch a good fix? Will you help push the fix into upstream?

Thank you very much!

-Fenghua
