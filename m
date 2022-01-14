Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B08048E2E0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 04:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbiANDNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 22:13:37 -0500
Received: from mga04.intel.com ([192.55.52.120]:36017 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238885AbiANDNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 22:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642130015; x=1673666015;
  h=cc:subject:to:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Szmsi12k0LI7khEwP6fZbgXfWxt5yjoq0TShGWuPc+o=;
  b=ee7+WMhAbDKX5x3TFYIZq0aUI8TNxfTveC/cQxVnYFqS4jOwE23Gc4ME
   NTPpAd8u4WAcxo8oN4NbsgjAXIhdXsNzn69AP0K7CHEgdGNM5mAHvlvvG
   Q7U+eyKwFZ3o5rZvql9rszCRiDanzrdZp39DwqdRCmLG4CigU0UqC+dTc
   qXo7/CfW0BzUUBH0GVJ7q9l0ElsaqgxrM1Iu+zne5caLUpXgvH9p39TLB
   P6oh+rKoq6ali/kjuOnbFzUoDBCnQe4GZOl5bOfBpmLJlY3DGe0EuSF+b
   UzBTo8BiaA/ZYss9UcOpYLUsbCPEap2RYpA9+jkgtFz+Yhi3LnQZKexrx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="242989193"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="242989193"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 19:13:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="529971183"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 13 Jan 2022 19:13:33 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>
Subject: Re: [PATCH] iommu/vt-d: Fix PCI bus rescan device hot add
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1642080198-10971-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <b2139255-2463-c62f-4746-8df7f3f49221@linux.intel.com>
 <20220113191122.53bc6ac0@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1b8d3145-c404-e952-e61e-5cdc2f6a92a6@linux.intel.com>
Date:   Fri, 14 Jan 2022 11:12:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220113191122.53bc6ac0@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/22 11:11 AM, Jacob Pan wrote:
> On Fri, 14 Jan 2022 08:58:53 +0800, Lu Baolu<baolu.lu@linux.intel.com>
> wrote:
> 
>> Hi Jacob,
>>
>> On 1/13/22 9:23 PM, Jacob Pan wrote:
>>> During PCI bus rescan, adding new devices involve two notifiers.
>>> 1. dmar_pci_bus_notifier()
>>> 2. iommu_bus_notifier()
>>> The current code sets #1 as low priority (INT_MIN) which resulted in #2
>>> being invoked first. The result is that struct device pointer cannot be
>>> found in DRHD search for the new device's DMAR/IOMMU. Subsequently, the
>>> device is put under the "catch-all" IOMMU instead of the correct one.
>>>
>>> This could cause system hang when device TLB invalidation is sent to the
>>> wrong IOMMU. Invalidation timeout error or hard lockup can be observed.
>>>
>>> This patch fixes the issue by setting a higher priority for
>>> dmar_pci_bus_notifier. DRHD search for a new device will find the
>>> correct IOMMU.
>>>
>>> Fixes: 59ce0515cdaf ("iommu/vt-d: Update DRHD/RMRR/ATSR device scope")
>>> Reported-by: Zhang, Bernice<bernice.zhang@intel.com>
>>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
>>> ---
>>>    drivers/iommu/intel/dmar.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>>> index 915bff76fe96..5d07e5b89c2e 100644
>>> --- a/drivers/iommu/intel/dmar.c
>>> +++ b/drivers/iommu/intel/dmar.c
>>> @@ -385,7 +385,7 @@ static int dmar_pci_bus_notifier(struct
>>> notifier_block *nb,
>>>    static struct notifier_block dmar_pci_bus_nb = {
>>>    	.notifier_call = dmar_pci_bus_notifier,
>>> -	.priority = INT_MIN,
>>> +	.priority = INT_MAX,
>>>    };
>>>    
>>>    static struct dmar_drhd_unit *
>>>    
>> Nice catch! dmar_pci_bus_add_dev() should take place*before*
>> iommu_probe_device(). This change enforces this with a higher notifier
>> priority for dmar callback.
>>
>> Comparably, dmar_pci_bus_del_dev() should take place*after*
>> iommu_release_device(). Perhaps we can use two notifiers, one for
>> ADD_DEVICE (with .priority=INT_MAX) and the other for REMOVE_DEVICE
>> (with .priority=INT_MIN)?
>>
> Since device_to_iommu() lookup in intel_iommu_release_device() only
> checks if device is under "an" IOMMU, not "the" IOMMU. Then the remove path
> order is not needed, right?
> 
> I know this is not robust, but having so many notifiers with implicit
> priority is not clean either.
> 
> Perhaps, we should have explicit priority defined around iommu_bus
> notifier? i.e.
> 
> @@ -1841,6 +1841,7 @@ static int iommu_bus_init(struct bus_type *bus, const
> struct iommu_ops *ops) return -ENOMEM;
>          nb->notifier_call = iommu_bus_notifier;
>                         
> +       nb->priority = IOMMU_BUS_NOTIFY_PRIORITY;
>                         
> 
>   static struct notifier_block dmar_pci_bus_add_nb = {
>          .notifier_call = dmar_pci_bus_notifier,
> -       .priority = INT_MIN,
> +       .priority = IOMMU_BUS_NOTIFY_PRIORITY + 1,
>   };
> 
>   static struct notifier_block dmar_pci_bus_remove_nb = {
>          .notifier_call = dmar_pci_bus_notifier,
> -       .priority = INT_MIN,
> +       .priority = IOMMU_BUS_NOTIFY_PRIORITY - 1,
>   };

IOMMU_BUS_NOTIFY_PRIORITY by default is 0. So you can simply use 1 and
-1? Adding a comment around it will be helpful.

Best regards,
baolu
