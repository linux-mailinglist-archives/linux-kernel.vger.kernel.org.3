Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D774B12BD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244173AbiBJQ2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:28:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiBJQ2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:28:13 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1AB98
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644510494; x=1676046494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DGhm09HzjY8rDyG0mR3sFd/viujCm4K2akDYcHlitZo=;
  b=M5/EZc67DX7To/SxDbew/htzeWOrR2CqiFBoWW9Jg63Ij8EnrHoZRSOW
   g1ePUP3GHtVoTLGENSfzqsrT7xbAXQywTxs1YfIgRfmCLfDp/I6drsGw8
   fW53vFRMf8xqBu7ZGyFz+edjVEvPAUbIwn9faMPUNV89HNlH8H3hUu7su
   rdia/nE6AxR7LNvrW5UdufjUkEAwE61X81/lIUW8M1Ye8iWU8qwrU5JcD
   IAfVBwYf0BdVveESjXd/GUHMQJfQ/IIhbKkCqrudeSEomehIl0uiXDO4m
   GGzsgdgnpUXLiHGTKD5UFzDrZBOiVkD1An5Yz/84YK2UkUp6pZjwROAlq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="247115433"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="247115433"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 08:27:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="701747201"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 08:27:56 -0800
Date:   Thu, 10 Feb 2022 08:27:50 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YgU9Bsq8a2NWzBvE@otcwcpicx3.sc.intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com>
 <20220209191614.5a3b42d4@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209191614.5a3b42d4@jacob-builder>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jacob,

On Wed, Feb 09, 2022 at 07:16:14PM -0800, Jacob Pan wrote:
> Hi Fenghua,
> 
> On Mon,  7 Feb 2022 15:02:48 -0800, Fenghua Yu <fenghua.yu@intel.com> wrote:
> 
> > @@ -1047,8 +1040,6 @@ struct iommu_sva *intel_svm_bind(struct device
> > *dev, struct mm_struct *mm, void }
> >  
> >  	sva = intel_svm_bind_mm(iommu, dev, mm, flags);
> > -	if (IS_ERR_OR_NULL(sva))
> > -		intel_svm_free_pasid(mm);
> If bind fails, the PASID has no IOMMU nor CPU context. It should be safe to
> free here.

The PASID can not be freed even if bind fails. The PASID allocated earlier
(either in this thread or in another thread) might be populated to other
threads already and being used now.

Without freeing the PASID on bind failure, the worst case is the PASID might
not be used in the process (and will be freed on process exit anyway).

This all matches with the PASID life time described in the commit message.

Thanks.

-Fenghua
