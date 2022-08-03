Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C9C588C2B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbiHCMdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiHCMdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:33:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53B61A074
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 05:33:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A372B8224F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 12:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DBBC433D6;
        Wed,  3 Aug 2022 12:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659529990;
        bh=mQK43iy8CjG3Yf9Mk4XNYrEBBfiZ/jVLOB7nOc+0mYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ul09QYqqMrLWbyztLH9OquscyD6hY+7Y1BzXftqmbOo4tzWnlq7ZVE4mqCZscmJv+
         iGWSCnB3TSgYXj8O3dYfWXRvCMRHVxa1B7/CtRcdWxReBl3zriXhz9ZQweCEKrCofH
         /rSSj90aZ5MM/Ta8NAf/G7lu+uRB+sbp65pMYaPE=
Date:   Wed, 3 Aug 2022 14:33:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rafael@kernel.org, maz@kernel.org, tglx@linutronix.de,
        okaya@kernel.org, harpreet.anand@amd.com, michal.simek@amd.com,
        nikhil.agarwal@amd.com
Subject: Re: [RFC PATCH 1/2] irqchip: cdx-bus: add cdx-MSI domain with
 gic-its domain as parent
Message-ID: <YuprA2OdGH6LSnZD@kroah.com>
References: <20220803122655.100254-1-nipun.gupta@amd.com>
 <20220803122655.100254-2-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803122655.100254-2-nipun.gupta@amd.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 05:56:54PM +0530, Nipun Gupta wrote:
> Devices on cdx bus are dynamically detected and registered using
> platform_device_register API. As these devices are not linked to
> of node they need a separate MSI domain for handling device ID
> to be provided to the GIC ITS domain.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> ---
> CONFIG_CDX_BUS and device tree bindings for xlnx,cdx-controller-1.0
> would be added as part of CDX bus patches
> 
>  drivers/irqchip/Makefile                 |   1 +
>  drivers/irqchip/irq-gic-v3-its-cdx-msi.c | 113 +++++++++++++++++++++++
>  include/linux/cdx/cdx.h                  |  15 +++
>  3 files changed, 129 insertions(+)
>  create mode 100644 drivers/irqchip/irq-gic-v3-its-cdx-msi.c
>  create mode 100644 include/linux/cdx/cdx.h
> 
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 5b67450a9538..623adb8a1f20 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -115,3 +115,4 @@ obj-$(CONFIG_WPCM450_AIC)		+= irq-wpcm450-aic.o
>  obj-$(CONFIG_IRQ_IDT3243X)		+= irq-idt3243x.o
>  obj-$(CONFIG_APPLE_AIC)			+= irq-apple-aic.o
>  obj-$(CONFIG_MCHP_EIC)			+= irq-mchp-eic.o
> +obj-$(CONFIG_CDX_BUS)			+= irq-gic-v3-its-cdx-msi.o
> diff --git a/drivers/irqchip/irq-gic-v3-its-cdx-msi.c b/drivers/irqchip/irq-gic-v3-its-cdx-msi.c
> new file mode 100644
> index 000000000000..eb17b74efdc5
> --- /dev/null
> +++ b/drivers/irqchip/irq-gic-v3-its-cdx-msi.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD CDX bus driver MSI support
> + *
> + * Copyright(C) 2022 Xilinx Inc.
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/msi.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/cdx/cdx.h>
> +
> +static struct irq_chip its_msi_irq_chip = {
> +	.name = "ITS-fMSI",
> +	.irq_mask = irq_chip_mask_parent,
> +	.irq_unmask = irq_chip_unmask_parent,
> +	.irq_eoi = irq_chip_eoi_parent,
> +	.irq_set_affinity = msi_domain_set_affinity
> +};
> +
> +static int its_cdx_msi_prepare(struct irq_domain *msi_domain,
> +				  struct device *dev,
> +				  int nvec, msi_alloc_info_t *info)
> +{
> +	struct msi_domain_info *msi_info;
> +	struct cdx_device_data *dev_data;
> +	u32 dev_id;
> +
> +	dev_data = dev->platform_data;
> +	dev_id = dev_data->dev_id;
> +
> +	/* Set the device Id to be passed to the GIC-ITS */
> +	info->scratchpad[0].ul = dev_id;
> +
> +	msi_info = msi_get_domain_info(msi_domain->parent);
> +
> +	/* Allocate at least 32 MSIs, and always as a power of 2 */
> +	nvec = max_t(int, 32, roundup_pow_of_two(nvec));
> +	return msi_info->ops->msi_prepare(msi_domain->parent, dev, nvec, info);
> +}
> +
> +static struct msi_domain_ops its_cdx_msi_ops __ro_after_init = {
> +	.msi_prepare = its_cdx_msi_prepare,
> +};
> +
> +static struct msi_domain_info its_cdx_msi_domain_info = {
> +	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
> +	.ops	= &its_cdx_msi_ops,
> +	.chip	= &its_msi_irq_chip,
> +};
> +
> +static const struct of_device_id cdx_device_id[] = {
> +	{.compatible = "xlnx,cdx-controller-1.0", },
> +	{},
> +};
> +
> +struct irq_domain *get_parent(struct fwnode_handle *handle)
> +{
> +	return irq_find_matching_fwnode(handle, DOMAIN_BUS_NEXUS);
> +}
> +
> +static void __init its_cdx_msi_init_one(struct device_node *np,
> +				    const char *name)
> +{
> +	struct irq_domain *parent;
> +	struct irq_domain *cdx_msi_domain;
> +	struct fwnode_handle *fwnode_handle;
> +	struct device_node *parent_node;
> +
> +	parent_node = of_parse_phandle(np, "msi-parent", 0);
> +
> +	parent = get_parent(of_node_to_fwnode(parent_node));
> +	if (!parent || !msi_get_domain_info(parent)) {
> +		pr_err("%s: unable to locate ITS domain\n", name);
> +		return;
> +	}
> +
> +	fwnode_handle = of_node_to_fwnode(np);
> +	cdx_msi_domain = platform_msi_create_irq_domain(fwnode_handle,
> +						&its_cdx_msi_domain_info,
> +						parent);
> +	if (!cdx_msi_domain) {
> +		pr_err("%s: unable to create cdx bus domain\n", name);
> +		return;
> +	}
> +
> +	pr_info("cdx bus MSI: %s domain created\n", name);

When drivers work properly, they should be quiet.

Also, when drivers print lines to the kernel log, they need to use the
dev_*() calls, not "raw" pr_*() calls please.

thanks,

greg k-h
