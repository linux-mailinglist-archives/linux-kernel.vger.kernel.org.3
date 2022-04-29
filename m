Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2C4514B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbiD2NyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376432AbiD2NyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:54:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC5F4F447
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651240248; x=1682776248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I1IC3ER1bbr2Gmvx8B3VxE2I1iNqvQIOt1Apf8a8gjM=;
  b=Q+R2uzwBMxC0zni3P1Ice41Jm3MswIW3NLiAtrj/h/bVxDLffWHKH37x
   /GmWZyDwiXwgHieorh/pXGRqkllXqP2i+C2CfzLONwL2o3dkQu1WNoMRW
   rR6Cv9gniF1wnz4LA7rz+2hRx9dyWhc5CjhjAjZM25t0iAwC+cXAfYkaq
   qtywpsJ1HHl3HHUTQ9GJe4/H1ZbDGlCAyCGw4+f5QGt5Nxwqmln7ERifS
   6I/4ld0N6b7aYp6xhXoWY3f8F8SgmdLlSb9nKspf7Op6ZtpP2rQk+dd7A
   vOcZV3ntnMyFq5tHmhBihNBjeWFgx1O4s03QsCstOG9cQNGPTwkB7sBGr
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="254034670"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="254034670"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 06:50:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="560349710"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 06:50:47 -0700
Date:   Fri, 29 Apr 2022 06:51:17 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
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
Message-ID: <YmvtVRlwVJjStXc0@fyu1.sc.intel.com>
References: <Yman5hLomw9/c+bi@myrica>
 <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica>
 <22b659c7-e972-7a56-2bd7-8df3b4820d4e@intel.com>
 <YmbO/l5IwfBCHrl8@myrica>
 <8c044e49-74bb-df56-8a60-663013c0910e@intel.com>
 <YmgiQZZyFxsJ+9um@myrica>
 <63582490-a794-fd11-0380-44b27cc660b7@intel.com>
 <YmpSv48aPIbVXqGi@myrica>
 <044595e6-e5d0-26c2-af8e-fc9d06906179@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <044595e6-e5d0-26c2-af8e-fc9d06906179@linux.intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Baolu,

On Fri, Apr 29, 2022 at 03:53:57PM +0800, Baolu Lu wrote:
> On 2022/4/28 16:39, Jean-Philippe Brucker wrote:
> > > The address space is what the OOM killer is after.  That gets refcounted
> > > with mmget()/mmput()/mm->mm_users.  The OOM killer is satiated by the
> > > page freeing done in __mmput()->exit_mmap().
> > > 
> > > Also, all the VMAs should be gone after exit_mmap().  So, even if
> > > vma->vm_file was holding a reference to a device driver, that reference
> > > should be gone by the time __mmdrop() is actually freeing the PASID.
> > 
> > I agree with all that. The concern was about tearing down the PASID in the
> > IOMMU and device from the release() MMU notifier, which would happen in
> > exit_mmap(). But doing the teardown at or before __mmdrop() is fine. And
> > since the IOMMU drivers need to hold mm->mm_count anyway between bind()
> > and unbind(), I think Fenghua's fix works.
> 
> But I didn't find mmgrab()/mmdrop() get called in both arm and intel
> IOMMU drivers.
> 
> $ git grep mmgrab drivers/iommu/
> [no output]
> 
> Do we need to add these in a separated fix patch, or I missed anything
> here?

On both ARM and X86, sva_bind() calls mmu_notifier_register()->mmgrab() and
sva_unbind() calls mmu_notifier_unregister()/mmu_notifier_put()->mmdrop().

So mm->mm_count are already counted in existing ARM and X86 binding and
unbinding. The fix patch just frees the PASID in __mmdrop() after
no more mm->mm_count.

There is no need to add extra  mmgrab() and mmdrop() pair.

Thanks.

-Fenghua

 
