Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847724BFE61
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbiBVQWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiBVQV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:21:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D779827B3C;
        Tue, 22 Feb 2022 08:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ev42OadWq8vJV+artW66Bqa32qEn5wnRjyQS5YnZUfA=; b=K85J3/EmImSwh8Nm5XOiFvEDhn
        10fci+/n1GGjuKrYNG9qXk0EV8sGEgb51sAWMB+hp4Pe56CU4l1OyYkpdiSQw+3IaRB8Dq7CNzVVV
        cKtLXyA7PaUtOFdiGX8PtGssDgZi3O04oAx3J0iK5vrJQUIYJB5ESrw1xSymRNJbTg2v3/iT3OobL
        OFmKLXDV7AiNAiX/F63tCkivHIVYGv51ygmO6qZbbdVm0oAIWk66lU+Gpd2iqUhdF/UIpa6s5Cn5y
        8gdTWUTyGvFgEjbA2/HN8DVe9tPEcGSfG0LVnWLWYEZavmOL885zA7WzTj5eHaFuKE42rJh/0zYc+
        uuL2MGxg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMXuq-00AbjJ-8Z; Tue, 22 Feb 2022 16:21:28 +0000
Date:   Tue, 22 Feb 2022 08:21:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mikko Perttunen <mperttunen@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/9] gpu: host1x: Add context bus
Message-ID: <YhUNiHiYdQfxJybk@infradead.org>
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-3-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218113952.3077606-3-mperttunen@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 01:39:45PM +0200, Mikko Perttunen wrote:
> The context bus is a "dummy" bus that contains struct devices that
> correspond to IOMMU contexts assigned through Host1x to processes.
> 
> Even when host1x itself is built as a module, the bus is registered
> in built-in code so that the built-in ARM SMMU driver is able to
> reference it.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/gpu/Makefile               |  3 +--
>  drivers/gpu/host1x/Kconfig         |  5 +++++
>  drivers/gpu/host1x/Makefile        |  1 +
>  drivers/gpu/host1x/context_bus.c   | 31 ++++++++++++++++++++++++++++++
>  include/linux/host1x_context_bus.h | 15 +++++++++++++++
>  5 files changed, 53 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/gpu/host1x/context_bus.c
>  create mode 100644 include/linux/host1x_context_bus.h
> 
> diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
> index 835c88318cec..8997f0096545 100644
> --- a/drivers/gpu/Makefile
> +++ b/drivers/gpu/Makefile
> @@ -2,7 +2,6 @@
>  # drm/tegra depends on host1x, so if both drivers are built-in care must be
>  # taken to initialize them in the correct order. Link order is the only way
>  # to ensure this currently.
> -obj-$(CONFIG_TEGRA_HOST1X)	+= host1x/
> -obj-y			+= drm/ vga/
> +obj-y			+= host1x/ drm/ vga/
>  obj-$(CONFIG_IMX_IPUV3_CORE)	+= ipu-v3/
>  obj-$(CONFIG_TRACE_GPU_MEM)		+= trace/
> diff --git a/drivers/gpu/host1x/Kconfig b/drivers/gpu/host1x/Kconfig
> index 6815b4db17c1..1861a8180d3f 100644
> --- a/drivers/gpu/host1x/Kconfig
> +++ b/drivers/gpu/host1x/Kconfig
> @@ -1,8 +1,13 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +
> +config TEGRA_HOST1X_CONTEXT_BUS
> +	bool
> +
>  config TEGRA_HOST1X
>  	tristate "NVIDIA Tegra host1x driver"
>  	depends on ARCH_TEGRA || (ARM && COMPILE_TEST)
>  	select DMA_SHARED_BUFFER
> +	select TEGRA_HOST1X_CONTEXT_BUS
>  	select IOMMU_IOVA
>  	help
>  	  Driver for the NVIDIA Tegra host1x hardware.
> diff --git a/drivers/gpu/host1x/Makefile b/drivers/gpu/host1x/Makefile
> index d2b6f7de0498..c891a3e33844 100644
> --- a/drivers/gpu/host1x/Makefile
> +++ b/drivers/gpu/host1x/Makefile
> @@ -18,3 +18,4 @@ host1x-y = \
>  	hw/host1x07.o
>  
>  obj-$(CONFIG_TEGRA_HOST1X) += host1x.o
> +obj-$(CONFIG_TEGRA_HOST1X_CONTEXT_BUS) += context_bus.o
> diff --git a/drivers/gpu/host1x/context_bus.c b/drivers/gpu/host1x/context_bus.c
> new file mode 100644
> index 000000000000..2625914f3c7d
> --- /dev/null
> +++ b/drivers/gpu/host1x/context_bus.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, NVIDIA Corporation.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/of.h>
> +
> +struct bus_type host1x_context_device_bus_type = {
> +	.name = "host1x-context",
> +};
> +EXPORT_SYMBOL(host1x_context_device_bus_type);

EXPORT_SYMBOL_GPL, please.

But the pattern that this copies in arm_smmu_bus_init is really
ugly.  I think we need to figure out a way todo that without having
to export all the low-level bus types.
