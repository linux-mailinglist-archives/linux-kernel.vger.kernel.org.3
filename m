Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DF649BB8E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiAYSw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:52:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:45031 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229861AbiAYSwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643136744; x=1674672744;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=choCxfNZioQkKVdX4wH1ew81T+xV4ZQllbIt3PKl1dc=;
  b=bu29hafbjnDNhG6oN9A6yylxWqj9QiQoJwFQUfuN6x04JvRMcIDNOPm1
   rUQy8RDTdXzKSg4jkpVXY1XAOd27jd/5EDWD9rfmQqeqmSuDfusJc+SNu
   WOr6TwND0pP9JpAaup8E7H9jSr+JofeC4TpciJtofx4JLbea8rB3DK6gR
   9U8n0aKiujneHaV7X5vf1EdhO2rXNyUDnUstaJFi/vul2NQkcMz6Ip0o8
   OhKMCqQ9jxO/6xfHfgUOlnb2pVF867mn1LZqoqlTyQqhrFSFIRGJp8lqa
   4dIp5jevTUHQ6oAC6HoAAjW7EcrBZ8tIMg49Nk9b0/cTIcclHvUXnbSLY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="227057614"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="227057614"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 10:52:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="479606720"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 10:52:21 -0800
Date:   Tue, 25 Jan 2022 10:57:04 -0800
From:   Jacob Pan <jacob.jun.pan@intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>
Cc:     "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, jacob.jun.pan@intel.com
Subject: Re: [PATCH v2] iommu/vt-d: Fix PCI bus rescan device hot add
Message-ID: <20220125105704.2375daed@jacob-builder>
In-Reply-To: <1642148470-11949-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1642148470-11949-1-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Just wondering if there are any other comments? This fixes a
regression that can cause system hang.

On Fri, 14 Jan 2022 00:21:10 -0800, Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:

> During PCI bus rescan, adding new devices involve two notifiers.
> 1. dmar_pci_bus_notifier()
> 2. iommu_bus_notifier()
> The current code sets #1 as low priority (INT_MIN) which resulted in #2
> being invoked first. The result is that struct device pointer cannot be
> found in DRHD search for the new device's DMAR/IOMMU. Subsequently, the
> device is put under the "catch-all" IOMMU instead of the correct one.
> 
> This could cause system hang when device TLB invalidation is sent to the
> wrong IOMMU. Invalidation timeout error and hard lockup have been
> observed.
> 
> On the reverse direction for device removal, the order should be #2-#1
> such that DMAR cleanup is done after IOMMU.
> 
> This patch fixes the issue by setting proper priorities for
> dmar_pci_bus_notifier around IOMMU bus notifier. DRHD search for a new
> device will find the correct IOMMU. The order with this patch is the
> following:
> 1. dmar_pci_bus_add_dev()
> 2. iommu_probe_device()
> 3. iommu_release_device()
> 4. dmar_pci_bus_remove_dev()
> 
> Fixes: 59ce0515cdaf ("iommu/vt-d: Update DRHD/RMRR/ATSR device scope")
> Reported-by: Zhang, Bernice <bernice.zhang@intel.com>
> Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel/dmar.c | 69 ++++++++++++++++++++++++++++----------
>  drivers/iommu/iommu.c      |  1 +
>  include/linux/iommu.h      |  1 +
>  3 files changed, 53 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 915bff76fe96..5f4751ba6bb1 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -340,15 +340,19 @@ static inline void vf_inherit_msi_domain(struct
> pci_dev *pdev) dev_set_msi_domain(&pdev->dev,
> dev_get_msi_domain(&physfn->dev)); }
>  
> -static int dmar_pci_bus_notifier(struct notifier_block *nb,
> +static int dmar_pci_bus_add_notifier(struct notifier_block *nb,
>  				 unsigned long action, void *data)
>  {
>  	struct pci_dev *pdev = to_pci_dev(data);
>  	struct dmar_pci_notify_info *info;
>  
> -	/* Only care about add/remove events for physical functions.
> +	if (action != BUS_NOTIFY_ADD_DEVICE)
> +		return NOTIFY_DONE;
> +
> +	/*
>  	 * For VFs we actually do the lookup based on the corresponding
> -	 * PF in device_to_iommu() anyway. */
> +	 * PF in device_to_iommu() anyway.
> +	 */
>  	if (pdev->is_virtfn) {
>  		/*
>  		 * Ensure that the VF device inherits the irq domain of
> the @@ -358,13 +362,34 @@ static int dmar_pci_bus_notifier(struct
> notifier_block *nb,
>  		 * from the PF device, but that's yet another x86'sism to
>  		 * inflict on everybody else.
>  		 */
> -		if (action == BUS_NOTIFY_ADD_DEVICE)
> -			vf_inherit_msi_domain(pdev);
> +		vf_inherit_msi_domain(pdev);
>  		return NOTIFY_DONE;
>  	}
>  
> -	if (action != BUS_NOTIFY_ADD_DEVICE &&
> -	    action != BUS_NOTIFY_REMOVED_DEVICE)
> +	info = dmar_alloc_pci_notify_info(pdev, action);
> +	if (!info)
> +		return NOTIFY_DONE;
> +
> +	down_write(&dmar_global_lock);
> +	dmar_pci_bus_add_dev(info);
> +	up_write(&dmar_global_lock);
> +	dmar_free_pci_notify_info(info);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block dmar_pci_bus_add_nb = {
> +	.notifier_call = dmar_pci_bus_add_notifier,
> +	.priority = IOMMU_BUS_NOTIFY_PRIORITY + 1,
> +};
> +
> +static int dmar_pci_bus_remove_notifier(struct notifier_block *nb,
> +				 unsigned long action, void *data)
> +{
> +	struct pci_dev *pdev = to_pci_dev(data);
> +	struct dmar_pci_notify_info *info;
> +
> +	if (pdev->is_virtfn || action != BUS_NOTIFY_REMOVED_DEVICE)
>  		return NOTIFY_DONE;
>  
>  	info = dmar_alloc_pci_notify_info(pdev, action);
> @@ -372,10 +397,7 @@ static int dmar_pci_bus_notifier(struct
> notifier_block *nb, return NOTIFY_DONE;
>  
>  	down_write(&dmar_global_lock);
> -	if (action == BUS_NOTIFY_ADD_DEVICE)
> -		dmar_pci_bus_add_dev(info);
> -	else if (action == BUS_NOTIFY_REMOVED_DEVICE)
> -		dmar_pci_bus_del_dev(info);
> +	dmar_pci_bus_del_dev(info);
>  	up_write(&dmar_global_lock);
>  
>  	dmar_free_pci_notify_info(info);
> @@ -383,11 +405,10 @@ static int dmar_pci_bus_notifier(struct
> notifier_block *nb, return NOTIFY_OK;
>  }
>  
> -static struct notifier_block dmar_pci_bus_nb = {
> -	.notifier_call = dmar_pci_bus_notifier,
> -	.priority = INT_MIN,
> +static struct notifier_block dmar_pci_bus_remove_nb = {
> +	.notifier_call = dmar_pci_bus_remove_notifier,
> +	.priority = IOMMU_BUS_NOTIFY_PRIORITY - 1,
>  };
> -
>  static struct dmar_drhd_unit *
>  dmar_find_dmaru(struct acpi_dmar_hardware_unit *drhd)
>  {
> @@ -835,7 +856,17 @@ int __init dmar_dev_scope_init(void)
>  
>  void __init dmar_register_bus_notifier(void)
>  {
> -	bus_register_notifier(&pci_bus_type, &dmar_pci_bus_nb);
> +	/*
> +	 * We need two notifiers in that we need to make sure the
> ordering
> +	 * is enforced as the following:
> +	 * 1. dmar_pci_bus_add_dev()
> +	 * 2. iommu_probe_device()
> +	 * 3. iommu_release_device()
> +	 * 4. dmar_pci_bus_remove_dev()
> +	 * Notifier block priority is used to enforce the order
> +	 */
> +	bus_register_notifier(&pci_bus_type, &dmar_pci_bus_add_nb);
> +	bus_register_notifier(&pci_bus_type, &dmar_pci_bus_remove_nb);
>  }
>  
>  
> @@ -2151,8 +2182,10 @@ static int __init dmar_free_unused_resources(void)
>  	if (dmar_in_use())
>  		return 0;
>  
> -	if (dmar_dev_scope_status != 1 && !list_empty(&dmar_drhd_units))
> -		bus_unregister_notifier(&pci_bus_type, &dmar_pci_bus_nb);
> +	if (dmar_dev_scope_status != 1 && !list_empty(&dmar_drhd_units))
> {
> +		bus_unregister_notifier(&pci_bus_type,
> &dmar_pci_bus_add_nb);
> +		bus_unregister_notifier(&pci_bus_type,
> &dmar_pci_bus_remove_nb);
> +	}
>  
>  	down_write(&dmar_global_lock);
>  	list_for_each_entry_safe(dmaru, dmaru_n, &dmar_drhd_units, list)
> { diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 8b86406b7162..6103bcde1f65 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1841,6 +1841,7 @@ static int iommu_bus_init(struct bus_type *bus,
> const struct iommu_ops *ops) return -ENOMEM;
>  
>  	nb->notifier_call = iommu_bus_notifier;
> +	nb->priority = IOMMU_BUS_NOTIFY_PRIORITY;
>  
>  	err = bus_register_notifier(bus, nb);
>  	if (err)
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index de0c57a567c8..8e13c69980be 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -403,6 +403,7 @@ static inline void iommu_iotlb_gather_init(struct
> iommu_iotlb_gather *gather) };
>  }
>  
> +#define IOMMU_BUS_NOTIFY_PRIORITY		0
>  #define IOMMU_GROUP_NOTIFY_ADD_DEVICE		1 /* Device added */
>  #define IOMMU_GROUP_NOTIFY_DEL_DEVICE		2 /* Pre Device
> removed */ #define IOMMU_GROUP_NOTIFY_BIND_DRIVER		3 /* Pre
> Driver bind */


Thanks,

Jacob
