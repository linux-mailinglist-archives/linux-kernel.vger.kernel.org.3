Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40195494009
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356833AbiASShn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:37:43 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45190 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356825AbiASShm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:37:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3CDAB81B00
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 18:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E24C004E1;
        Wed, 19 Jan 2022 18:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642617459;
        bh=szT+VEBWfzNOkhPz4gHRcX0/BQhdb2Yct5Xv9ggEJVc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=K1/QIx297J8TFKBJWjCktT3OfQuL0SvWzyfGIsCfFMILXqFjqlGRnzuksJh16gpDD
         3aUSEAsHWi6udErj39AXGZdC5Dn2mdKAVxrmTQeG/X2bccT3pWLV5GxlWDsKJMzjXt
         tD+J/PN9m47GOLAmSjxCKbWXPQpAF4Whh5grViOEL97Art1FYp+mJ0/uCKYqUHzMdM
         rEVMUbibrwiM23aOnVmSZwiZNcjHMtaexPLC0A87tYP/+BEawVTGPcWk2m++PUVdGv
         9bgGzkVFQgtznU9ENCiW2IjYf6AztysUU/yzwHB3zXXUjOujREEkPIm9d0SOtOrqGP
         2NYWckqNsw5Vw==
Date:   Wed, 19 Jan 2022 12:37:37 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marc Zyngier <maz@kernel.org>, Tong Zhang <ztong0001@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/MSI: Prevent UAF in error path
Message-ID: <20220119183737.GA954267@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1938vbn.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 06:54:52PM +0100, Thomas Gleixner wrote:
> When the core MSI allocation fails, then the PCI/MSI code uses an already
> freed MSI descriptor to unmask the MSI mask register in order to bring it back
> into reset state.
> 
> Remove MSI_FLAG_FREE_MSI_DESCS from the PCI/MSI irqdomain flags and let the
> PCI/MSI code free the MSI descriptors after usage.
> 
> Fixes: 0f62d941acf9 ("genirq/msi: Provide msi_domain_alloc/free_irqs_descs_locked()")
> Reported-by: Tong Zhang <ztong0001@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

What does "UAF" stand for?  Ah, "use after free" I guess?

Let me know if I should take this.  Otherwise I assume it'll go
whereever 0f62d941acf9 went.

> ---
>  drivers/pci/msi/irqdomain.c |    4 ++--
>  drivers/pci/msi/legacy.c    |    1 -
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -28,6 +28,7 @@ void pci_msi_teardown_msi_irqs(struct pc
>  		msi_domain_free_irqs_descs_locked(domain, &dev->dev);
>  	else
>  		pci_msi_legacy_teardown_msi_irqs(dev);
> +	msi_free_msi_descs(&dev->dev);
>  }
>  
>  /**
> @@ -171,8 +172,7 @@ struct irq_domain *pci_msi_create_irq_do
>  	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
>  		pci_msi_domain_update_chip_ops(info);
>  
> -	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS |
> -		       MSI_FLAG_FREE_MSI_DESCS;
> +	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS;
>  	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
>  		info->flags |= MSI_FLAG_MUST_REACTIVATE;
>  
> --- a/drivers/pci/msi/legacy.c
> +++ b/drivers/pci/msi/legacy.c
> @@ -77,5 +77,4 @@ void pci_msi_legacy_teardown_msi_irqs(st
>  {
>  	msi_device_destroy_sysfs(&dev->dev);
>  	arch_teardown_msi_irqs(dev);
> -	msi_free_msi_descs(&dev->dev);
>  }
