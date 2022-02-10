Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AA54B157F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiBJSqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:46:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343524AbiBJSqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:46:07 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12377F47
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 10:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644518768; x=1676054768;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rwYtZDJpiN5pbfbdwSd8f9sWHmJpVk7KWW+5mNsUYHk=;
  b=F7tmy2vBDwfS7DOk+vQdGY6TgPZzQVpBv/j1aZWQTjE57vwXStQV3jkU
   CGAy5C5nkq+WSoW4fbh54uqzfyv1Wpj5IexIj37Ovc8bGjwLodxnMKXNF
   1hVJtjDvFFI4Bem10pQfc9Ygkts9KBT/Hy59rNiEj+oRUQnKRKIQBtO+/
   +H0tb1xNKop3JfdLjZV5TKDOM9jNlUyKQ1wIfBIKHQLQPoEZOumN6HKiv
   ku7kRVWwQHunFfpaa810zCKYKQK+D6QbL10kfgQ6wbJ6QJycUvKXfaEbW
   x20Pv9qWEFjOz0szWcH/jqGPobwPp6Ggi1pdnx1se9WJzvuWsdmCn6IX2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="229531437"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="229531437"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 10:46:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="537402098"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 10:46:07 -0800
Date:   Thu, 10 Feb 2022 10:49:04 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <20220210104904.6c6131f2@jacob-builder>
In-Reply-To: <20220209191614.5a3b42d4@jacob-builder>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
        <20220207230254.3342514-6-fenghua.yu@intel.com>
        <20220209191614.5a3b42d4@jacob-builder>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Feb 2022 19:16:14 -0800, Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:

> Hi Fenghua,
> 
> On Mon,  7 Feb 2022 15:02:48 -0800, Fenghua Yu <fenghua.yu@intel.com>
> wrote:
> 
> > @@ -1047,8 +1040,6 @@ struct iommu_sva *intel_svm_bind(struct device
> > *dev, struct mm_struct *mm, void }
> >  
> >  	sva = intel_svm_bind_mm(iommu, dev, mm, flags);
> > -	if (IS_ERR_OR_NULL(sva))
> > -		intel_svm_free_pasid(mm);  
> If bind fails, the PASID has no IOMMU nor CPU context. It should be safe
> to free here.
> 
Actually, here we cannot tell if the bind is the first of the mm so I think
this is fine.

Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

> Thanks,
> 
> Jacob


Thanks,

Jacob
