Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2CA477A88
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbhLPR1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240277AbhLPR1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:27:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19D6C061574;
        Thu, 16 Dec 2021 09:27:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81ABD61ECD;
        Thu, 16 Dec 2021 17:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E4DC36AE4;
        Thu, 16 Dec 2021 17:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639675619;
        bh=RxcIcwqtEtoh6b33m/mJM5c7KZEkU6Tcf4H5rd+1/mk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OunuMfCzpz7zaAb3tXW9Sqx7kb4RMGodaoh0+QMNvKZU4lU6+YNWN8YSmfTiiVwko
         DJpB988cRMtP2ciiv4KU9gvSYJt5yy6664RWK1AooAyjI64SQYWSdTbvypPQXQo9Yz
         iQrZPvaEOI65tWPbS+FIz5gepH3Of+9iaYDV2CzvmrRnkYL8Nki8eMaYs+tWh2SV3Z
         JUWqp9hYpRon+xhpo1nzqskU7H15lqJrBH40hzwIoPWbqWsbZyZK0brHkv9vnxIdcP
         ya9JNqnXLqTP5pEafYaFxZ6eGG9Bz1FoYqwoAnvq7c29+zGsftY86aG8YSHzrRG3zV
         HvAwEG2EOrBuw==
Date:   Thu, 16 Dec 2021 11:26:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com,
        michael.a.bottini@linux.intel.com, rafael@kernel.org,
        me@adhityamohan.in, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH V4 2/2] PCI: vmd: Override ASPM on TGL/ADL VMD devices
Message-ID: <20211216172658.GA770781@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216055600.2425362-2-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Rajat for LTR max latency write]

On Wed, Dec 15, 2021 at 09:56:00PM -0800, David E. Box wrote:
> From: Michael Bottini <michael.a.bottini@linux.intel.com>
> 
> On Tiger Lake and Alder Lake platforms, VMD controllers do not have ASPM
> enabled nor LTR values set by BIOS. This leads high power consumption on
> these platforms when VMD is enabled as reported in bugzilla [1].  Enable
> these features in the VMD driver using pcie_aspm_policy_override() to set
> the ASPM policy for the root ports.

s/leads high/leads to high/

Does this depend on "Tiger Lake and Alder Lake platforms"
specifically, or does it depend on a BIOS design choice, i.e., "don't
configure ASPM or LTR for devices below a VMD"?

The subject says "override ASPM on VMD devices," but it looks like
this affects the ASPM configuration of devices *below* the VMD, not of
the VMD itself.

It looks like this only affects *NVMe* devices, since
vmd_enable_aspm() checks for PCI_CLASS_STORAGE_EXPRESS.  Why is that?
Is there something special about NVMe?  I'd think you would want to do
this for *all* devices below a VMD.

Since it only affects PCI_CLASS_STORAGE_EXPRESS devices, I don't think
it actually "sets ASPM policy for the root ports".  vmd_enable_aspm()
calls pcie_aspm_policy_override() on endpoints.  It's true that the
link ASPM state happens to be attached to the upstream end of the
link, but that's an ASPM implementation detail.

This all needs to be clear in the subject and commit log.

> To do this, add an additional flag in VMD features to specify devices that
> must have their respective policies overridden.

I'm not clear on why you want this to apply to only certain VMDs and
not others.  Do some BIOSes configure ASPM for devices below some
VMDs?

> [1] https://bugzilla.kernel.org/show_bug.cgi?id=213717
> 
> Signed-off-by: Michael Bottini <michael.a.bottini@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Tested-by: Adhitya Mohan <me@adhityamohan.in>
> ---
> V4
>  - Refactor vmd_enable_apsm() to exit early, making the lines shorter
>    and more readable. Suggested by Christoph.
> V3
>  - No changes
> V2
>  - Use return status to print pci_info message if ASPM cannot be enabled.
>  - Add missing static declaration, caught by lkp@intel.com
> 
>  drivers/pci/controller/vmd.c | 43 +++++++++++++++++++++++++++++++++---
>  1 file changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index a45e8e59d3d4..880afd450a14 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -20,6 +20,8 @@
>  
>  #include <asm/irqdomain.h>
>  
> +#include "../pci.h"
> +
>  #define VMD_CFGBAR	0
>  #define VMD_MEMBAR1	2
>  #define VMD_MEMBAR2	4
> @@ -67,6 +69,12 @@ enum vmd_features {
>  	 * interrupt handling.
>  	 */
>  	VMD_FEAT_CAN_BYPASS_MSI_REMAP		= (1 << 4),
> +
> +	/*
> +	 * Device must have ASPM policy overridden, as its default policy is
> +	 * incorrect.
> +	 */
> +	VMD_FEAT_QUIRK_OVERRIDE_ASPM		= (1 << 5),

I think you specifically want to *enable* some ASPM link states, not
just "override the default policy."  "Override" tells us nothing about
whether you are enabling or disabling ASPM.  Applies to subject line
as well.

>  };
>  
>  static DEFINE_IDA(vmd_instance_ida);
> @@ -661,6 +669,30 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
>  	return 0;
>  }
>  
> +/*
> + * Override the BIOS ASPM policy and set the LTR value for PCI storage
> + * devices on the VMD bride.

I don't think there's any BIOS "policy" here.  At this point BIOS is
no longer involved at all, so all that's left is whatever ASPM config
the BIOS did or did not do.

Why only storage?

s/bride/bridge/

> + */
> +static int vmd_enable_aspm(struct pci_dev *pdev, void *userdata)
> +{
> +	int features = *(int *)userdata, pos;
> +
> +	if (!(features & VMD_FEAT_QUIRK_OVERRIDE_ASPM) ||
> +	    pdev->class != PCI_CLASS_STORAGE_EXPRESS)
> +		return 0;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
> +	if (!pos)
> +		return 0;
> +
> +	pci_write_config_word(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, 0x1003);
> +	pci_write_config_word(pdev, pos + PCI_LTR_MAX_NOSNOOP_LAT, 0x1003);

1) Where did this magic 0x1003 value come from?  Does that depend on
the VMD device?  The endpoint?  The circuit design?  The path between
endpoint and VMD?  What if there are switches in the path?

2) There exist broken devices where WORD config accesses don't work:
https://lore.kernel.org/all/20211208000948.487820-1-rajatja@google.com/

We might need a way to quirk config accesses to those devices, but we
don't have one yet.  So for now this needs to be a single DWORD write.

> +	if (pcie_aspm_policy_override(pdev))
> +		pci_info(pdev, "Unable of override ASPM policy\n");

s/Unable of/Unable to/

I think we might need a message about when we *do* override the
policy.  A note in dmesg might be useful for debugging.  I'm worried
about the LTR programming because I really don't understand how we
should be doing that.

> +	return 0;
> +}
> +
>  static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  {
>  	struct pci_sysdata *sd = &vmd->sysdata;
> @@ -807,6 +839,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	pci_scan_child_bus(vmd->bus);
>  	pci_assign_unassigned_bus_resources(vmd->bus);
>  
> +	pci_walk_bus(vmd->bus, vmd_enable_aspm, &features);

Do you support hotplug under VMD?  This will not happen for hot-added
devices.

>  	/*
>  	 * VMD root buses are virtual and don't return true on pci_is_pcie()
>  	 * and will fail pcie_bus_configure_settings() early. It can instead be
> @@ -948,15 +982,18 @@ static const struct pci_device_id vmd_ids[] = {
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> +				VMD_FEAT_OFFSET_FIRST_VECTOR |
> +				VMD_FEAT_QUIRK_OVERRIDE_ASPM,},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c3d),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> +				VMD_FEAT_OFFSET_FIRST_VECTOR |
> +				VMD_FEAT_QUIRK_OVERRIDE_ASPM,},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -				VMD_FEAT_OFFSET_FIRST_VECTOR,},
> +				VMD_FEAT_OFFSET_FIRST_VECTOR |
> +				VMD_FEAT_QUIRK_OVERRIDE_ASPM,},
>  	{0,}
>  };
>  MODULE_DEVICE_TABLE(pci, vmd_ids);
> -- 
> 2.25.1
> 
