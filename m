Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88A64AA650
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 04:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379288AbiBEDvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 22:51:08 -0500
Received: from mga09.intel.com ([134.134.136.24]:60261 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbiBEDvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 22:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644033066; x=1675569066;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TJ0yFP3NTl42q8F9fgT2ctU0dtnIA2YCDkI5HuQPmm4=;
  b=RgGHKAZzUQhxh5El2xOBw4gFno53kNhf+PSOtdUqKtmTY29JMFF4tLeZ
   mKSDqg8LHXpcYuh+70isMp4DdyZafO6KG/hgr/JbvJgRv64QzeUYl6PGj
   EIEh+IgpYjXnEoOzDXKFLfLDkZ49h4gDDxBmUWv0Q1zvOKKhmRt6lMeTe
   6C0Ypv45wGTSMWErsz3jWOrNgKDf53xODhkrHkWgiT8+rfjtnBtdvFpt3
   qa83hkl1oWPe47jxqFZAHZ/vS2lhOveAVinCSxD9d7PoTe5x0EaQYKKyF
   Cs//J7z5WDQHrT+GCcKu8SA+sZ/tWU/Km0EmiL91c4SttbGk0O9SMTdvI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="248247305"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="248247305"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 19:51:06 -0800
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="699886297"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.148]) ([10.254.215.148])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 19:51:02 -0800
Message-ID: <6ace7131-4671-6956-944f-df01e5d63470@linux.intel.com>
Date:   Sat, 5 Feb 2022 11:50:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-6-fenghua.yu@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220128202905.2274672-6-fenghua.yu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 2022/1/29 4:28, Fenghua Yu wrote:
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 92fea3fbbb11..ef03b2176bbd 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4781,7 +4781,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
>   link_failed:
>   	spin_unlock_irqrestore(&device_domain_lock, flags);
>   	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
> -		ioasid_put(domain->default_pasid);
> +		ioasid_free(domain->default_pasid);
>   
>   	return ret;
>   }
> @@ -4811,7 +4811,7 @@ static void aux_domain_remove_dev(struct dmar_domain *domain,
>   	spin_unlock_irqrestore(&device_domain_lock, flags);
>   
>   	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
> -		ioasid_put(domain->default_pasid);
> +		ioasid_free(domain->default_pasid);
>   }
>   
>   static int prepare_domain_attach_device(struct iommu_domain *domain,

The domain->default_pasid is not relevant to SVA and it's being cleaned
up by another series. No need to take care of it in this series.

Best regards,
baolu
