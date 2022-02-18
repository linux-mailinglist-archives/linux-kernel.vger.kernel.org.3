Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DD24BAFE9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 03:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiBRCzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 21:55:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiBRCzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 21:55:40 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B6A60CF1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 18:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645152924; x=1676688924;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8tbuvYh0eK0b0TFW+yWYPs3qXHRE9DlvaagIPNoX7vY=;
  b=i2YUqfHeSM3Te0H+zfvOj6D1CJ2iwOuNLETJOu39TspBZNIiU8OAU/Mu
   VgxdGLE2Sb9SfcvBTqmPm+C/FDbf/uvxFv4/HnEk5IGHKulkz4OMgP2wr
   V/RmcWCaZAjgPDqEKh6KIowgHnmLmrvRtvHum0pIcoh2zn3o0Kd6R2YI1
   Iu1M4kxO8yV877lmM1b5xeD/CKhdxWLQqL5Y66xmcs+Jcugz6BPFF44ii
   Nv0xRbzUyXKKEsDORJ5dhmnpXuN47JU7qdohTLq8Hiszw1lXm/MBUNLya
   hj1jWQxlmxw2QGJoU2pNC75EVBmL3fVY9UsBintoEnqPzh3lLFGB81H+e
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="234568067"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="234568067"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 18:55:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="682316036"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 17 Feb 2022 18:55:21 -0800
Message-ID: <60d395f4-6103-94fe-9b05-daeaf0b00adb@linux.intel.com>
Date:   Fri, 18 Feb 2022 10:53:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: Enable ATS for the devices in SATC table
Content-Language: en-US
To:     Yian Chen <yian.chen@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220216193609.686107-1-yian.chen@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220216193609.686107-1-yian.chen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yian,

On 2/17/22 3:36 AM, Yian Chen wrote:
> Starting from Intel VT-d v3.2, Intel platform BIOS can provide
> additional SATC table structure. SATC table includes a list of
> SoC integrated devices that support ATC (Address translation
> cache).
> 
> Enabling ATC (via ATS capability) can be a functional requirement
> for SATC device operation or an optional to enhance device
> performance/functionality. This is determined by the bit of
> ATC_REQUIRED in SATC table. When IOMMU is working in scalable
> mode, software chooses to always enable ATS for every device in
> SATC table because Intel SoC devices in SATC table are trusted
> to use ATS.
> 
> On the other hand, if IOMMU is in legacy mode, ATS of SATC
> capable devices can work transparently to software and be
> automatically enabled by IOMMU hardware. As the result,
> there is no need for software to enable ATS on these devices.
> 
> Signed-off-by: Yian Chen <yian.chen@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 53 ++++++++++++++++++++++++++++++++++---
>   include/linux/intel-iommu.h |  2 +-
>   2 files changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 92fea3fbbb11..58a80cec50bb 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -872,7 +872,6 @@ static bool iommu_is_dummy(struct intel_iommu *iommu, struct device *dev)
>   
>   	return false;
>   }
> -

Unnecessary.

>   struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
>   {
>   	struct dmar_drhd_unit *drhd = NULL;
> @@ -2684,7 +2683,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>   
>   		if (ecap_dev_iotlb_support(iommu->ecap) &&
>   		    pci_ats_supported(pdev) &&
> -		    dmar_find_matched_atsr_unit(pdev))
> +		    dmar_ats_supported(pdev, iommu))
>   			info->ats_supported = 1;
>   
>   		if (sm_supported(iommu)) {
> @@ -4020,7 +4019,42 @@ static void intel_iommu_free_dmars(void)
>   	}
>   }
>   
> -int dmar_find_matched_atsr_unit(struct pci_dev *dev)
> +/* dev_satc_state - Find if dev is in a DMAR SATC table
> + *
> + * return value:
> + *    1: dev is in STAC table and ATS is required
> + *    0: dev is in SATC table and ATS is optional
> + *    -1: dev isn't in SATC table
> + */

Judging the status of the device in table according to the hard coded
return value will make the code hard to read. How about using two
helpers with meaningful names, for example,

bool dmar_find_matched_satc_unit()
bool dmar_ats_required_in_satc()?

> +static int dev_satc_state(struct pci_dev *dev)
> +{
> +	int i, ret = -1;
> +	struct device *tmp;
> +	struct dmar_satc_unit *satcu;
> +	struct acpi_dmar_satc *satc;
> +
> +	dev = pci_physfn(dev);
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(satcu, &dmar_satc_units, list) {
> +		satc = container_of(satcu->hdr, struct acpi_dmar_satc, header);
> +		if (satc->segment != pci_domain_nr(dev->bus))
> +			continue;
> +		for_each_dev_scope(satcu->devices, satcu->devices_cnt, i, tmp)
> +			if (to_pci_dev(tmp) == dev) {
> +				if (satc->flags)

Do you need to check the ATC_REQUIRED bit field?

> +					ret = 1;
> +				else
> +					ret = 0;
> +				goto out;
> +			}
> +	}
> +out:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
>   {
>   	int i, ret = 1;
>   	struct pci_bus *bus;
> @@ -4030,6 +4064,19 @@ int dmar_find_matched_atsr_unit(struct pci_dev *dev)
>   	struct dmar_atsr_unit *atsru;
>   
>   	dev = pci_physfn(dev);
> +	i = dev_satc_state(dev);
> +	if (i >= 0) {
> +		/* This dev supports ATS as it is in SATC table!
> +		 * When IOMMU is in legacy mode, enabling ATS is done
> +		 * automatically by HW for the device that requires
> +		 * ATS, hence OS should not enable this device ATS
> +		 * to avoid duplicated TLB invalidation
> +		 */
> +		if (i && !sm_supported(iommu))
> +			ret = 0;
> +		return ret;
> +	}
> +
>   	for (bus = dev->bus; bus; bus = bus->parent) {
>   		bridge = bus->self;
>   		/* If it's an integrated device, allow ATS */
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 69230fd695ea..fe9fd417d611 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -717,7 +717,7 @@ static inline int nr_pte_to_next_page(struct dma_pte *pte)
>   }
>   
>   extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
> -extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
> +extern int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu);

The dmar_find_matched_atsr_unit() is not used out of iommu.c. Can you
please make a patch to change it to a static one?

>   
>   extern int dmar_enable_qi(struct intel_iommu *iommu);
>   extern void dmar_disable_qi(struct intel_iommu *iommu);

Best regards,
baolu
