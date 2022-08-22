Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A5059CC16
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 01:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbiHVXVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 19:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238636AbiHVXVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:21:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE82455091
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661210502; x=1692746502;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TKnRFyZojBDepq0MeETIBlamkN8wx2nn6IJckBft1yI=;
  b=d1jR9gwwuFgxsAoXJ82JqHvIZrDTBCF2GYorEBjMCX8bKNa/da4CdVbI
   A04yOkAB1fDCIO1sk/6/jwN3mh1IXLpqiSnXDD0lh66DnLgp6OGAyA8vT
   czCwFi5eIL256b4se0F1d1LsBOPnMymKQ0l28XdNjAQ0vAUTMbduMpSfS
   CtSb3Dyr9OS4lV4MA6d2WTRpbOijGxbpVlb0UKIy7OdSEfLXZsIa0MXIv
   +45bPW8t4avRCG4CcjJVzwclQAQZMXqxWxI1zOpfvAX68MEPCa9q1aZ8v
   g34MIuAj/ETqdr6kwzgFRUGwur3yxnYkUHVPw6NjcEtUxKK4A7uMNg6Q9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="294828253"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="294828253"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 16:21:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="559935988"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 16:21:42 -0700
Date:   Mon, 22 Aug 2022 16:24:54 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/2] iommu: Use the user PGD for SVA if PTI is enabled
Message-ID: <20220822162454.490ad1f2@jacob-builder>
In-Reply-To: <09bccb93-2c0e-4962-0c46-c84c22fa140d@intel.com>
References: <20220822201213.352289-1-jacob.jun.pan@linux.intel.com>
        <20220822201213.352289-3-jacob.jun.pan@linux.intel.com>
        <09bccb93-2c0e-4962-0c46-c84c22fa140d@intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Mon, 22 Aug 2022 15:31:20 -0700, Dave Hansen <dave.hansen@intel.com>
wrote:

> On 8/22/22 13:12, Jacob Pan wrote:
> > @@ -394,7 +395,9 @@ static struct iommu_sva *intel_svm_bind_mm(struct
> > intel_iommu *iommu, sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
> >  			PASID_FLAG_SUPERVISOR_MODE : 0;
> >  	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ?
> > PASID_FLAG_FL5LP : 0;
> > -	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd,
> > mm->pasid, +
> > +	pgd = static_cpu_has(X86_FEATURE_PTI) ?
> > kernel_to_user_pgdp(mm->pgd) : mm->pgd;
> > +	ret = intel_pasid_setup_first_level(iommu, dev, pgd, mm->pasid,
> >  					    FLPT_DEFAULT_DID, sflags);
> >  
> 
> This X86_FEATURE_PTI should really be done within a helper.
> 
> I'd probably do this with a *new* helper since all of the existing
> kernel_to_user_pgdp() users seem to be within a PTI #ifdef.
> 
> Maybe something like:
> 
> pgd_t *mm_user_pgd(struct mm_struct *mm)
> {
> #ifdef CONFIG_PAGE_TABLE_ISOLATION
> 	if (cpu_feature_enabled(X86_FEATURE_PTI))
> 		return kernel_to_user_pgdp(mm->pgd);
> #endif
> 	return mm->pgd;
> }
> 
Sounds good. I thought about a helper also, thinking there are so many other
cpu_has(X86_FEATURE_PTI) checks already :)

> That #ifdef could even go away if your kernel_to_user_pgdp() stub from
> patch 1/2 was available.  I'm not sure it's worth it though.
I will remove 1/2 and keep the uniform style of the existing helpers.

Thanks for the suggestion,

Jacob
