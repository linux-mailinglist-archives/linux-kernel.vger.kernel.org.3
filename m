Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41D94AA748
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 08:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357701AbiBEHML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 02:12:11 -0500
Received: from mga18.intel.com ([134.134.136.126]:42996 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229835AbiBEHMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 02:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644045129; x=1675581129;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qHvqdITzBAglMG363Se0HM+YGOVHexjxQRvG2eU8Hto=;
  b=cjvYk7Nnnge49ut0WcgI1bhUZiJSq71XQYlL6jXxC+g/xihzJEK+dm3c
   8s1iVOfdnsc34MFRMXkSMTcM1nFm9vc5dOev2ChRXyV3C33oa4ndqDN8Y
   XJ4rxNGh+XbMBoFOM1yFio2kCkVaasLH+WVaEU/qqJ+p7nnmRRaC31oLB
   RpzNrWPIXqG5ALT5jv1rssgx/m4PgEUmlOID9y+PqoP5HhlsMasnKp0eJ
   GURuZwZemYNnLdT9PI4j569/FqOeziWNDB6thV9/A53YHV/5R8duIvgCW
   6U+IiYC9DqDuPKQ7A4/FTDCDniEgSLdaYvY1s4qJNGw6hYB/2a3k/KHZs
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="232061189"
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="232061189"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 23:12:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="677304617"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 04 Feb 2022 23:12:04 -0800
Message-ID: <01fee139-873c-347c-b8e4-f6af52dca168@linux.intel.com>
Date:   Sat, 5 Feb 2022 15:10:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-6-fenghua.yu@intel.com>
 <6ace7131-4671-6956-944f-df01e5d63470@linux.intel.com>
 <Yf4Gtm5pu+e2whSE@otcwcpicx3.sc.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <Yf4Gtm5pu+e2whSE@otcwcpicx3.sc.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/22 1:10 PM, Fenghua Yu wrote:
> Hi, Baolu,
> On Sat, Feb 05, 2022 at 11:50:59AM +0800, Lu Baolu wrote:
>> Hi Fenghua,
>>
>> On 2022/1/29 4:28, Fenghua Yu wrote:
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index 92fea3fbbb11..ef03b2176bbd 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -4781,7 +4781,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
>>>    link_failed:
>>>    	spin_unlock_irqrestore(&device_domain_lock, flags);
>>>    	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
>>> -		ioasid_put(domain->default_pasid);
>>> +		ioasid_free(domain->default_pasid);
>>>    	return ret;
>>>    }
>>> @@ -4811,7 +4811,7 @@ static void aux_domain_remove_dev(struct dmar_domain *domain,
>>>    	spin_unlock_irqrestore(&device_domain_lock, flags);
>>>    	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
>>> -		ioasid_put(domain->default_pasid);
>>> +		ioasid_free(domain->default_pasid);
>>>    }
>>>    static int prepare_domain_attach_device(struct iommu_domain *domain,
>>
>> The domain->default_pasid is not relevant to SVA and it's being cleaned
>> up by another series. No need to take care of it in this series.
> 
> Because ioasid_put() is renamed to ioasid_free() in this patch, without
> above changes, this series cannot be compiled.
> 
> Thomas and I discussed how to handle aux_domain while you will remove
> the entire aux_domain code (https://lore.kernel.org/lkml/87zgnf29op.ffs@tglx/).
> The above changes are minimal and temporary changes to compile this series.
> The changes will be removed along with the entire aux_domain by your
> removing aux_domain series later in 5.18.

Okay. Make sense to me.

Best regards,
baolu
