Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEAE466B05
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 21:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348954AbhLBUrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 15:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348866AbhLBUr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 15:47:28 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D13C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 12:44:05 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 09B05B7E;
        Thu,  2 Dec 2021 21:44:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638477843;
        bh=BcF0b/gcKoc2a+NPyzwkYCgQcw7BOSdkwY3q3mo9Pws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FewqRDpApEw81n0YP/9eIXcCXx94w1eJlTm0qLzRGmcv1VZrGaC9OQnMttivY1sqH
         EbKKKxWq/lpVEhENa0qBmI10FlWrf6jP6rEWq0BZj5J1lLLK0c3Ng2LQg2eDsNtMLR
         e61axILh25FodReLS+hB3Xu1cen5aSVB87Yu0YQU=
Date:   Thu, 2 Dec 2021 22:43:36 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, Dan Scally <djrscally@gmail.com>,
        Kate Hsuan <hpa@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH] mfd: intel-lpss: Fix I2C4 not being available on the
 Microsoft Surface Go & Go 2
Message-ID: <Yakv+JF+euUlE1Tv@pendragon.ideasonboard.com>
References: <20211202201351.74419-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211202201351.74419-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Thank you for the patch.

On Thu, Dec 02, 2021 at 09:13:51PM +0100, Hans de Goede wrote:
> Many DSDTs for Kaby Lake and Kaby Lake Refresh models contain a
> _SB.PCI0.GEXP ACPI Device node describing an I2C attached GPIO expander.
> 
> This seems to be something which is copy and pasted from the DSDT
> from some reference design since this ACPI Device is present even on
> models where no such GPIO expander is used at all, such as on the
> Microsoft Surface Go & Go 2.
> 
> This ACPI Device is a problem because it contains a SystemMemory
> OperationRegion which covers the MMIO for the I2C4 I2C controller this

s/this/that/ (or ". This" ?)

> causes the MFD cell for the I2C4 controller to not be instantiated due
> to a resource conflict, requiring the use of acpi_enforce_resources=lax
> to work around this.
> 
> I have done an extensive analysis of all the ACPI tables on the
> Microsoft Surface Go and the _SB.PCI0.GEXP ACPI Device's methods are
> not used by any code in the ACPI tables, neither are any of them
> directly called by any Linux kernel code. This is unsurprising since
> running i2cdetect on the I2C4 bus shows that there is no GPIO
> expander chip present on these devices at all.
> 
> This commit adds a PCI subsystem vendor:device table listing PCI devices
> where it is known to be safe to ignore a resource-conflicts with ACPI
> declared SystemMemory regions.
> 
> This makes the I2C4 bus work out of the box on the Microsoft Surface
> Go & Go 2, which is necessary for the cameras on these devices to work.

This will make the life of the Go and Go2 users *much* easier.

> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Dan Scally <djrscally@gmail.com>
> Cc: Kate Hsuan <hpa@redhat.com>
> Cc: Maximilian Luz <luzmaximilian@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 12 ++++++++++++
>  drivers/mfd/intel-lpss.c     |  1 +
>  drivers/mfd/intel-lpss.h     |  1 +
>  3 files changed, 14 insertions(+)
> 
> diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
> index a872b4485eac..593290ff08a6 100644
> --- a/drivers/mfd/intel-lpss-pci.c
> +++ b/drivers/mfd/intel-lpss-pci.c
> @@ -17,6 +17,15 @@
>  
>  #include "intel-lpss.h"
>  
> +/* Some DSDTs have an unused GEXP ACPI device conflicting with I2C4 resources */
> +static const struct pci_device_id ignore_resource_conflicts_ids[] = {
> +	/* Microsoft Surface Go (version 1) I2C4 */
> +	{ PCI_DEVICE_SUB(0x8086, 0x9d64, 0x152d, 0x1182), },
> +	/* Microsoft Surface Go 2 I2C4 */
> +	{ PCI_DEVICE_SUB(0x8086, 0x9d64, 0x152d, 0x1237), },
> +	{ }

Reading the commit message, I was going to mention that the match should
probably be machine-dependent, but that seems to be covered by the PCI
subsystem ID.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +};
> +
>  static int intel_lpss_pci_probe(struct pci_dev *pdev,
>  				const struct pci_device_id *id)
>  {
> @@ -35,6 +44,9 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
>  	info->mem = &pdev->resource[0];
>  	info->irq = pdev->irq;
>  
> +	if (pci_match_id(ignore_resource_conflicts_ids, pdev))
> +		info->ignore_resource_conflicts = true;
> +
>  	pdev->d3cold_delay = 0;
>  
>  	/* Probably it is enough to set this for iDMA capable devices only */
> diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
> index 0e15afc39f54..cfbee2cfba6b 100644
> --- a/drivers/mfd/intel-lpss.c
> +++ b/drivers/mfd/intel-lpss.c
> @@ -401,6 +401,7 @@ int intel_lpss_probe(struct device *dev,
>  		return ret;
>  
>  	lpss->cell->swnode = info->swnode;
> +	lpss->cell->ignore_resource_conflicts = info->ignore_resource_conflicts;
>  
>  	intel_lpss_init_dev(lpss);
>  
> diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
> index 22dbc4aed793..062ce95b68b9 100644
> --- a/drivers/mfd/intel-lpss.h
> +++ b/drivers/mfd/intel-lpss.h
> @@ -19,6 +19,7 @@ struct software_node;
>  
>  struct intel_lpss_platform_info {
>  	struct resource *mem;
> +	bool ignore_resource_conflicts;
>  	int irq;
>  	unsigned long clk_rate;
>  	const char *clk_con_id;

-- 
Regards,

Laurent Pinchart
