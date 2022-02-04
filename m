Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565C84A9BB7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbiBDPMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:12:32 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60822 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359596AbiBDPMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:12:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C05E61132
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 15:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BD3C004E1;
        Fri,  4 Feb 2022 15:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643987550;
        bh=rvvwcqpr5WCBgFzc3z360qu5rbDLAccigRdzUjm0a2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C/GMxvSjpshvlGSovANszs9R8r6NcZ31Qzpl49eZPSMd8HDrBD3zNK9+IyTbDauGi
         Xsn6Bw67kDeU7cVqVKyWYcHe8wSz7qR/ss0eP6IElcJRt48PuIX6WzJEOi7ooy8CDr
         hyj7mqpgfG4DmulYva5E9iADaeN1kUf9X0MDHEGg=
Date:   Fri, 4 Feb 2022 16:12:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jorgen Hansen <jhansen@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, pv-drivers@vmware.com,
        Vishnu Dasa <vdasa@vmware.com>
Subject: Re: [PATCH v2 2/8] VMCI: dma dg: add MMIO access to registers
Message-ID: <Yf1CW3EyGkTm7H14@kroah.com>
References: <20220203131237.3380-1-jhansen@vmware.com>
 <20220203131237.3380-3-jhansen@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203131237.3380-3-jhansen@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 05:12:31AM -0800, Jorgen Hansen wrote:
> Detect the support for MMIO access through examination of the length
> of the region requested in BAR1. If it is 256KB, the VMCI device
> supports MMIO access to registers.
> 
> If MMIO access is supported, map the area of the region used for
> MMIO access (64KB size at offset 128KB).
> 
> Add wrapper functions for accessing 32 bit register accesses through
> either MMIO or IO ports based on device configuration.
> 
> Sending and receiving datagrams through iowrite8_rep/ioread8_rep is
> left unchanged for now, and will be addressed in a later change.
> 
> Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
> ---
>  drivers/misc/vmw_vmci/vmci_guest.c | 68 ++++++++++++++++++++++--------
>  include/linux/vmw_vmci_defs.h      | 12 ++++++
>  2 files changed, 62 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
> index 1018dc77269d..38ee7ed32ab9 100644
> --- a/drivers/misc/vmw_vmci/vmci_guest.c
> +++ b/drivers/misc/vmw_vmci/vmci_guest.c
> @@ -45,6 +45,7 @@ static u32 vm_context_id = VMCI_INVALID_ID;
>  struct vmci_guest_device {
>  	struct device *dev;	/* PCI device we are attached to */
>  	void __iomem *iobase;
> +	void __iomem *mmio_base;
>  
>  	bool exclusive_vectors;
>  
> @@ -89,6 +90,21 @@ u32 vmci_get_vm_context_id(void)
>  	return vm_context_id;
>  }
>  
> +static unsigned int vmci_read_reg(struct vmci_guest_device *dev, u32 reg)
> +{
> +	if (dev->mmio_base != NULL)
> +		return readl(dev->mmio_base + reg);
> +	return ioread32(dev->iobase + reg);
> +}
> +
> +static void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
> +{
> +	if (dev->mmio_base != NULL)
> +		writel(val, dev->mmio_base + reg);
> +	else
> +		iowrite32(val, dev->iobase + reg);
> +}
> +
>  /*
>   * VM to hypervisor call mechanism. We use the standard VMware naming
>   * convention since shared code is calling this function as well.
> @@ -116,7 +132,7 @@ int vmci_send_datagram(struct vmci_datagram *dg)
>  	if (vmci_dev_g) {
>  		iowrite8_rep(vmci_dev_g->iobase + VMCI_DATA_OUT_ADDR,
>  			     dg, VMCI_DG_SIZE(dg));
> -		result = ioread32(vmci_dev_g->iobase + VMCI_RESULT_LOW_ADDR);
> +		result = vmci_read_reg(vmci_dev_g, VMCI_RESULT_LOW_ADDR);
>  	} else {
>  		result = VMCI_ERROR_UNAVAILABLE;
>  	}
> @@ -384,7 +400,7 @@ static irqreturn_t vmci_interrupt(int irq, void *_dev)
>  		unsigned int icr;
>  
>  		/* Acknowledge interrupt and determine what needs doing. */
> -		icr = ioread32(dev->iobase + VMCI_ICR_ADDR);
> +		icr = vmci_read_reg(dev, VMCI_ICR_ADDR);
>  		if (icr == 0 || icr == ~0)
>  			return IRQ_NONE;
>  
> @@ -429,7 +445,8 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
>  				   const struct pci_device_id *id)
>  {
>  	struct vmci_guest_device *vmci_dev;
> -	void __iomem *iobase;
> +	void __iomem *iobase = NULL;
> +	void __iomem *mmio_base = NULL;
>  	unsigned int capabilities;
>  	unsigned int caps_in_use;
>  	unsigned long cmd;
> @@ -445,16 +462,32 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
>  		return error;
>  	}
>  
> -	error = pcim_iomap_regions(pdev, 1 << 0, KBUILD_MODNAME);
> -	if (error) {
> -		dev_err(&pdev->dev, "Failed to reserve/map IO regions\n");
> -		return error;
> +	/*
> +	 * The VMCI device with mmio access to registers requests 256KB
> +	 * for BAR1. If present, driver will use new VMCI device
> +	 * functionality for register access and datagram send/recv.
> +	 */
> +
> +	if (pci_resource_len(pdev, 1) == VMCI_WITH_MMIO_ACCESS_BAR_SIZE) {
> +		dev_info(&pdev->dev, "MMIO register access is available\n");
> +		mmio_base = pci_iomap_range(pdev, 1, VMCI_MMIO_ACCESS_OFFSET,
> +					    VMCI_MMIO_ACCESS_SIZE);
> +		/* If the map fails, we fall back to IOIO access. */
> +		if (!mmio_base)
> +			dev_warn(&pdev->dev, "Failed to map MMIO register access\n");
>  	}
>  
> -	iobase = pcim_iomap_table(pdev)[0];
> +	if (!mmio_base) {
> +		error = pcim_iomap_regions(pdev, BIT(0), KBUILD_MODNAME);
> +		if (error) {
> +			dev_err(&pdev->dev, "Failed to reserve/map IO regions\n");
> +			return error;
> +		}
> +		iobase = pcim_iomap_table(pdev)[0];
> +	}
>  
> -	dev_info(&pdev->dev, "Found VMCI PCI device at %#lx, irq %u\n",
> -		 (unsigned long)iobase, pdev->irq);
> +	dev_info(&pdev->dev, "Found VMCI PCI device at %#lx, %#lx, irq %u\n",
> +		 (unsigned long)iobase, (unsigned long)mmio_base, pdev->irq);

Why are you printing iomem addresses to userspace?  Are you sure that is
ok?  Who is going to use it?

thanks,

greg k-h
