Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA904E3DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbiCVLnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbiCVLnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:43:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6FB7E0BD;
        Tue, 22 Mar 2022 04:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647949293; x=1679485293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HvgOL6YZgSy7nSW+sywrpP3lBboqncbKKW+arHb8epo=;
  b=ig4Pr8BAr22IrjNcBs3FmjOJ1lVUFFJAkffsRfLHkiTPO8v6Qf7J5esW
   SPSATg94Lrh4hAfDQv/LizwZBUHoC/Wyg5srr8yJPSvRAp4TiWmYxnnYA
   V+swmUHKuNBbH+Ad01d9912VH7YIOC29z6A5QCSKor2J9k1oVZCBsZ0Fe
   YMK4GSnIxNX8p8HUcpObz/0YbHop2lk2PVhW23pd1L/fTNgzusDoW3Xmh
   tNq5QpHHFWairlviS+vFem1gS5p8iyB956S5c/thWWjtsTao6p9N+tGAb
   s2h2uvkTnWLBgVoxm03qHKeGyMq+oZvhsv8MFy+IwZ8PFb/P94umh88hb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="282631478"
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="282631478"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 04:41:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="646992054"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 04:41:30 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 22 Mar 2022 13:41:27 +0200
Date:   Tue, 22 Mar 2022 13:41:27 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, baolu.lu@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, iommu@lists.linux-foundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, hch@lst.de
Subject: Re: [PATCH v2 2/2] thunderbolt: Make iommu_dma_protection more
 accurate
Message-ID: <Yjm150r3KPKp/2O4@lahna>
References: <cover.1647624084.git.robin.murphy@arm.com>
 <0dd14883930c9f55ace22162e23765a37d91a057.1647624084.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dd14883930c9f55ace22162e23765a37d91a057.1647624084.git.robin.murphy@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

I tried this now on two Intel systems. One with integrated Thunderbolt
and one with discrete. There was a small issue, see below but once fixed
it worked as expected :)

On Fri, Mar 18, 2022 at 05:42:58PM +0000, Robin Murphy wrote:
> Between me trying to get rid of iommu_present() and Mario wanting to
> support the AMD equivalent of DMAR_PLATFORM_OPT_IN, scrutiny has shown
> that the iommu_dma_protection attribute is being far too optimistic.
> Even if an IOMMU might be present for some PCI segment in the system,
> that doesn't necessarily mean it provides translation for the device(s)
> we care about. Furthermore, all that DMAR_PLATFORM_OPT_IN really does
> is tell us that memory was protected before the kernel was loaded, and
> prevent the user from disabling the intel-iommu driver entirely. While
> that lets us assume kernel integrity, what matters for actual runtime
> DMA protection is whether we trust individual devices, based on the
> "external facing" property that we expect firmware to describe for
> Thunderbolt ports.
> 
> It's proven challenging to determine the appropriate ports accurately
> given the variety of possible topologies, so while still not getting a
> perfect answer, by putting enough faith in firmware we can at least get
> a good bit closer. If we can see that any device near a Thunderbolt NHI
> has all the requisites for Kernel DMA Protection, chances are that it
> *is* a relevant port, but moreover that implies that firmware is playing
> the game overall, so we'll use that to assume that all Thunderbolt ports
> should be correctly marked and thus will end up fully protected.
> 
> CC: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: Give up trying to look for specific devices, just look for evidence
>     that firmware cares at all.
> 
>  drivers/thunderbolt/domain.c | 12 +++--------
>  drivers/thunderbolt/nhi.c    | 41 ++++++++++++++++++++++++++++++++++++
>  include/linux/thunderbolt.h  |  2 ++
>  3 files changed, 46 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
> index 7018d959f775..2889a214dadc 100644
> --- a/drivers/thunderbolt/domain.c
> +++ b/drivers/thunderbolt/domain.c
> @@ -7,9 +7,7 @@
>   */
>  
>  #include <linux/device.h>
> -#include <linux/dmar.h>
>  #include <linux/idr.h>
> -#include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> @@ -257,13 +255,9 @@ static ssize_t iommu_dma_protection_show(struct device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
>  {
> -	/*
> -	 * Kernel DMA protection is a feature where Thunderbolt security is
> -	 * handled natively using IOMMU. It is enabled when IOMMU is
> -	 * enabled and ACPI DMAR table has DMAR_PLATFORM_OPT_IN set.
> -	 */
> -	return sprintf(buf, "%d\n",
> -		       iommu_present(&pci_bus_type) && dmar_platform_optin());
> +	struct tb *tb = container_of(dev, struct tb, dev);
> +
> +	return sysfs_emit(buf, "%d\n", tb->nhi->iommu_dma_protection);
>  }
>  static DEVICE_ATTR_RO(iommu_dma_protection);
>  
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index c73da0532be4..9e396e283792 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -14,6 +14,7 @@
>  #include <linux/errno.h>
>  #include <linux/pci.h>
>  #include <linux/interrupt.h>
> +#include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/property.h>
> @@ -1102,6 +1103,45 @@ static void nhi_check_quirks(struct tb_nhi *nhi)
>  		nhi->quirks |= QUIRK_AUTO_CLEAR_INT;
>  }
>  
> +static int nhi_check_iommu_pdev(struct pci_dev *pdev, void *data)
> +{
> +	if (!pdev->untrusted ||
> +	    !dev_iommu_capable(&pdev->dev, IOMMU_CAP_PRE_BOOT_PROTECTION))

This one needs to take the pdev->external_facing into account too
because most of the time there are no existing tunnels when the driver
is loaded so we only see the PCIe root/downstream port. I think this is
enough actually:

	if (!pdev->external_facing ||
	    !dev_iommu_capable(&pdev->dev, IOMMU_CAP_PRE_BOOT_PROTECTION))

> +		return 0;
> +	*(bool *)data = true;
> +	return 1; /* Stop walking */
> +}
> +
> +static void nhi_check_iommu(struct tb_nhi *nhi)
> +{
> +	struct pci_bus *bus = nhi->pdev->bus;
> +	bool port_ok = false;
> +
> +	/*
> +	 * Ideally what we'd do here is grab every PCI device that
> +	 * represents a tunnelling adapter for this NHI and check their
> +	 * status directly, but unfortunately USB4 seems to make it
> +	 * obnoxiously difficult to reliably make any correlation.
> +	 *
> +	 * So for now we'll have to bodge it... Hoping that the system
> +	 * is at least sane enough that an adapter is in the same PCI
> +	 * segment as its NHI, if we can find *something* on that segment
> +	 * which meets the requirements for Kernel DMA Protection, we'll
> +	 * take that to imply that firmware is aware and has (hopefully)
> +	 * done the right thing in general. We need to know that the PCI
> +	 * layer has seen the ExternalFacingPort property and propagated
> +	 * it to the "untrusted" flag that the IOMMU layer will then
> +	 * enforce, but also that the IOMMU driver itself can be trusted
> +	 * not to have been subverted by a pre-boot DMA attack.
> +	 */
> +	while (bus->parent)
> +		bus = bus->parent;
> +
> +	pci_walk_bus(bus, nhi_check_iommu_pdev, &port_ok);
> +
> +	nhi->iommu_dma_protection = port_ok;

I would put here a log debug, something like this:

dev_dbg(&nhi->pdev->dev, "IOMMU DMA protection is %sabled\n",
	port_ok ? "en" : "dis");
