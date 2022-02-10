Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D425C4B142A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245205AbiBJRY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:24:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiBJRY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:24:56 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01990E7A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644513898; x=1676049898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eagqL1AoUzAckRlZtQNOqTR4fbpXscTSKvxL87Obws8=;
  b=GptyW4eaH/s+MjexdvXIec27BzLyglFeEKeMEEilXPeyCIv/cbka8myG
   5sEG8m2kP25UpynmgAuYslJSt2FTsMlV65q04o/4t4faxzY8bKxyGUXZU
   AtmUKWOmRWvxZ9CtuEdyM5Xt3mNyz+kYqj+J56If5WQRaghXCG51NYZ3j
   AhlmrgbzkdHbp32XZ/CABhVpTCPWOXsTDhYGyYYNWVATxyjwLGw+HzcDD
   mXoSmf73+8x+9WkHZ3wqyZtJ1v61i2cc4yl8AEEzCBn1F4iJxO3oA+LZQ
   V1Wn22HNhIMBugBPpSc8OTPD41ahsHhtVo6bgJrL3xLfn7VAePgu5x3mo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="247129652"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="247129652"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 09:24:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="629764105"
Received: from agluck-desk3.sc.intel.com ([172.25.222.60])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 09:24:57 -0800
Date:   Thu, 10 Feb 2022 09:24:50 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YgVKYgby67brla9Z@agluck-desk3.sc.intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com>
 <20220209191614.5a3b42d4@jacob-builder>
 <YgU9Bsq8a2NWzBvE@otcwcpicx3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgU9Bsq8a2NWzBvE@otcwcpicx3.sc.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 08:27:50AM -0800, Fenghua Yu wrote:
> Hi, Jacob,
> 
> On Wed, Feb 09, 2022 at 07:16:14PM -0800, Jacob Pan wrote:
> > Hi Fenghua,
> > 
> > On Mon,  7 Feb 2022 15:02:48 -0800, Fenghua Yu <fenghua.yu@intel.com> wrote:
> > 
> > > @@ -1047,8 +1040,6 @@ struct iommu_sva *intel_svm_bind(struct device
> > > *dev, struct mm_struct *mm, void }
> > >  
> > >  	sva = intel_svm_bind_mm(iommu, dev, mm, flags);
> > > -	if (IS_ERR_OR_NULL(sva))
> > > -		intel_svm_free_pasid(mm);
> > If bind fails, the PASID has no IOMMU nor CPU context. It should be safe to
> > free here.
> 
> The PASID can not be freed even if bind fails. The PASID allocated earlier
> (either in this thread or in another thread) might be populated to other
> threads already and being used now.
> 
> Without freeing the PASID on bind failure, the worst case is the PASID might
> not be used in the process (and will be freed on process exit anyway).
> 
> This all matches with the PASID life time described in the commit message.

But what does this mean for the user that failed that intel_svm_bind_mm()?

Here's a scenario:

Process sets up to use PASID capable device #1. Everything works,
so the process has mm->pasid, and the IOMMU has the tables to map
virtual addresses coming from device #1 using that PASID.

Now the same process asks to start using PASID capable device #2,
but there is a failure at intel_svm_bind_mm().

Fenghua is right that we shouldn't free the PASID. It is in use
by at least one thread of the process to access device #1.

But what happens with device #2? Does the caller of intel_svm_bind()
do the right thing with the IS_ERR_OR_NULL return value to let the
user know that device #2 isn't accessible?

-Tony
