Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DFE4B6C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbiBOMab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:30:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236596AbiBOMaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:30:30 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488AB107D18
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644928220; x=1676464220;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bIFqNKHI6bOI6lXyvBll9J8BMAqcZiVtExxmAz4Vm7g=;
  b=mzhFwzCPqAPt5097qRGyo1elwRMZwDtO+f6699GLuDxtWLDM6yN8usOo
   /kCXcHhU87cyr+DqtiRigZQGDBsXaG2TJbt74HVyMt3yyu6st+D5w6ipD
   2ZGy2PaXZo5Az9N9+fIjfgPILsol6aE0XuB+g0KOxTybyAtpuf/zbvWD4
   CPmZ5CAohT5JpbL1n4yhLQ9ZpCkyw8FSDgVjG81G8K2qEMeHpu315mc5c
   C0PLIux/qUamECh9u052J+xCCC79OXtRJB/BUpYxVrep/f3QyzQVZS7Mv
   B4xaiI28y4zXC2zd7L3jN3XRhR3h4DsG1zrE3Cx+47WssAAkitqTKzhlS
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="247936243"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="247936243"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 04:30:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="624766664"
Received: from jkoratik-mobl2.amr.corp.intel.com (HELO [10.212.80.80]) ([10.212.80.80])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 04:30:14 -0800
Message-ID: <f88b7780-cf4f-d2f5-f2ba-cd3d7bf2a0d4@linux.intel.com>
Date:   Tue, 15 Feb 2022 12:30:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Intel-gfx] [PATCH v7 1/5] drm/i915/gsc: add gsc as a mei
 auxiliary device
Content-Language: en-US
To:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org
References: <20220213103215.2440248-1-alexander.usyskin@intel.com>
 <20220213103215.2440248-2-alexander.usyskin@intel.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20220213103215.2440248-2-alexander.usyskin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/02/2022 10:32, Alexander Usyskin wrote:
> From: Tomas Winkler <tomas.winkler@intel.com>
> 
> GSC is a graphics system controller, it provides
> a chassis controller for graphics discrete cards.
> 
> There are two MEI interfaces in GSC: HECI1 and HECI2.
> 
> Both interfaces are on the BAR0 at offsets 0x00258000 and 0x00259000.
> GSC is a GT Engine (class 4: instance 6). HECI1 interrupt is signaled
> via bit 15 and HECI2 via bit 14 in the interrupt register.
> 
> This patch exports GSC as auxiliary device for mei driver to bind to
> for HECI2 interface.
> 
> CC: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
> V4: add header to the MAINTAINERS file
>      drop empty line
> V5: rebase
> V6: rebase, drop redundant assignments
> V7: add Greg KH Reviewed-by
> ---
>   MAINTAINERS                              |   1 +
>   drivers/gpu/drm/i915/Kconfig             |   1 +
>   drivers/gpu/drm/i915/Makefile            |   3 +
>   drivers/gpu/drm/i915/gt/intel_gsc.c      | 196 +++++++++++++++++++++++
>   drivers/gpu/drm/i915/gt/intel_gsc.h      |  37 +++++
>   drivers/gpu/drm/i915/gt/intel_gt.c       |   3 +
>   drivers/gpu/drm/i915/gt/intel_gt.h       |   5 +
>   drivers/gpu/drm/i915/gt/intel_gt_irq.c   |  13 ++
>   drivers/gpu/drm/i915/gt/intel_gt_regs.h  |   1 +
>   drivers/gpu/drm/i915/gt/intel_gt_types.h |   2 +
>   drivers/gpu/drm/i915/i915_drv.h          |   8 +
>   drivers/gpu/drm/i915/i915_pci.c          |   3 +-
>   drivers/gpu/drm/i915/i915_reg.h          |   2 +
>   drivers/gpu/drm/i915/intel_device_info.h |   2 +
>   include/linux/mei_aux.h                  |  19 +++
>   15 files changed, 295 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.c
>   create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.h
>   create mode 100644 include/linux/mei_aux.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a0c2ae3d71d8..c92d34f8522a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9797,6 +9797,7 @@ S:	Supported
>   F:	Documentation/driver-api/mei/*
>   F:	drivers/misc/mei/
>   F:	drivers/watchdog/mei_wdt.c
> +F:	include/linux/mei_aux.h
>   F:	include/linux/mei_cl_bus.h
>   F:	include/uapi/linux/mei.h
>   F:	samples/mei/*
> diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
> index 2ac220bfd0ed..3b0508e7a805 100644
> --- a/drivers/gpu/drm/i915/Kconfig
> +++ b/drivers/gpu/drm/i915/Kconfig
> @@ -29,6 +29,7 @@ config DRM_I915
>   	select VMAP_PFN
>   	select DRM_TTM
>   	select DRM_BUDDY
> +	select AUXILIARY_BUS
>   	help
>   	  Choose this option if you have a system that has "Intel Graphics
>   	  Media Accelerator" or "HD Graphics" integrated graphics,
> diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> index 226dbef5f64a..e40ba71b3cdd 100644
> --- a/drivers/gpu/drm/i915/Makefile
> +++ b/drivers/gpu/drm/i915/Makefile
> @@ -195,6 +195,9 @@ i915-y += gt/uc/intel_uc.o \
>   	  gt/uc/intel_huc_debugfs.o \
>   	  gt/uc/intel_huc_fw.o
>   
> +# graphics system controller (GSC) support
> +i915-y += gt/intel_gsc.o
> +
>   # modesetting core code
>   i915-y += \
>   	display/hsw_ips.o \
> diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
> new file mode 100644
> index 000000000000..d07f182f64e4
> --- /dev/null
> +++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright(c) 2019-2022, Intel Corporation. All rights reserved.
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/mei_aux.h>
> +#include "i915_reg.h"
> +#include "i915_drv.h"
> +#include "gt/intel_gt.h"
> +#include "intel_gsc.h"
> +
> +#define GSC_BAR_LENGTH  0x00000FFC
> +
> +static void gsc_irq_mask(struct irq_data *d)
> +{
> +	/* generic irq handling */
> +}
> +
> +static void gsc_irq_unmask(struct irq_data *d)
> +{
> +	/* generic irq handling */
> +} > +
> +static struct irq_chip gsc_irq_chip = {
> +	.name = "gsc_irq_chip",
> +	.irq_mask = gsc_irq_mask,
> +	.irq_unmask = gsc_irq_unmask,
> +};
> +
> +static int gsc_irq_init(struct drm_i915_private *dev_priv, int irq)

I am not insisting but we tend to use i915 for the variable name instead 
of dev_priv since some time back.

> +{
> +	irq_set_chip_and_handler_name(irq, &gsc_irq_chip,
> +				      handle_simple_irq, "gsc_irq_handler");
> +
> +	return irq_set_chip_data(irq, dev_priv);

I am not familiar with this interrupt scheme - does dev_priv get used at 
all by handle_simple_irq, or anyone, after being set here?

> +}
> +
> +struct intel_gsc_def {
> +	const char *name;
> +	const unsigned long bar;

Unusual, why const out of curiosity? And is it "bar" or "base" would be 
more accurate?

> +	size_t bar_size;
> +};
> +
> +/* gscfi (graphics system controller firmware interface) resources */
> +static const struct intel_gsc_def intel_gsc_def_dg1[] = {
> +	{
> +	},

Maybe put a comment in this empty element like "/* HECI1 not yet 
implemented. */"?

> +	{
> +		.name = "mei-gscfi",
> +		.bar = GSC_DG1_HECI2_BASE,
> +		.bar_size = GSC_BAR_LENGTH,
> +	}
> +};
> +
> +static void intel_gsc_release_dev(struct device *dev)
> +{
> +	struct auxiliary_device *aux_dev = to_auxiliary_dev(dev);
> +	struct mei_aux_device *adev = auxiliary_dev_to_mei_aux_dev(aux_dev);
> +
> +	kfree(adev);
> +}
> +
> +static void intel_gsc_destroy_one(struct intel_gsc_intf *intf)
> +{
> +	if (intf->adev) {
> +		auxiliary_device_delete(&intf->adev->aux_dev);
> +		auxiliary_device_uninit(&intf->adev->aux_dev);
> +		intf->adev = NULL;
> +	}
> +	if (intf->irq >= 0)
> +		irq_free_desc(intf->irq);
> +	intf->irq = -1;
> +}
> +
> +static void intel_gsc_init_one(struct drm_i915_private *dev_priv,
> +			       struct intel_gsc_intf *intf,
> +			       unsigned int intf_id)

Could pass in intel_gsc instead of dev_priv to better match with 
intel_gsc prefix, but no big deal.

> +{
> +	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
> +	struct mei_aux_device *adev;
> +	struct auxiliary_device *aux_dev;
> +	const struct intel_gsc_def *def;
> +	int ret;
> +
> +	intf->irq = -1;
> +	intf->id = intf_id;
> +
> +	if (intf_id == 0 && !HAS_HECI_PXP(dev_priv))
> +		return;

Isn't inf_id == 0 always a bug with this patch, regardless of 
HAS_HECI_PXP, since the support is incomplete in this patch? If so I'd 
be more comfortable with a plain drm_WARN_ON_ONCE(intf_id == 0).

> +
> +	def = &intel_gsc_def_dg1[intf_id];
> +
> +	dev_dbg(&pdev->dev, "init gsc one with id %d\n", intf_id);

Meh, too much looks like a during development aid.

> +	intf->irq = irq_alloc_desc(0);
> +	if (intf->irq < 0) {
> +		dev_err(&pdev->dev, "gsc irq error %d\n", intf->irq);
> +		return;
> +	}
> +
> +	ret = gsc_irq_init(dev_priv, intf->irq);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "gsc irq init failed %d\n", ret);
> +		goto fail;
> +	}
> +
> +	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
> +	if (!adev)
> +		goto fail;
> +
> +	adev->irq = intf->irq;
> +	adev->bar.parent = &pdev->resource[0];
> +	adev->bar.start = def->bar + pdev->resource[0].start;
> +	adev->bar.end = adev->bar.start + def->bar_size - 1;
> +	adev->bar.flags = IORESOURCE_MEM;
> +	adev->bar.desc = IORES_DESC_NONE;
> +
> +	aux_dev = &adev->aux_dev;
> +	aux_dev->name = def->name;
> +	aux_dev->id = (pci_domain_nr(pdev->bus) << 16) |
> +		      PCI_DEVID(pdev->bus->number, pdev->devfn);
> +	aux_dev->dev.parent = &pdev->dev;
> +	aux_dev->dev.release = intel_gsc_release_dev;
> +
> +	ret = auxiliary_device_init(aux_dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "gsc aux init failed %d\n", ret);
> +		kfree(adev);
> +		goto fail;
> +	}
> +
> +	ret = auxiliary_device_add(aux_dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "gsc aux add failed %d\n", ret);
> +		/* adev will be freed with the put_device() and .release sequence */

For things which fail but do not prevent driver loading and operating 
otherwise correctly I'd suggest drm_warn throughout but maybe it is just me.

> +		auxiliary_device_uninit(aux_dev);
> +		goto fail;
> +	}
> +	intf->adev = adev;
> +
> +	dev_dbg(&pdev->dev, "gsc init one done\n");
> +	return;
> +fail:
> +	intel_gsc_destroy_one(intf);

Error handling is a bit meh but looks correct. Like you could avoid 
separate free's on the error paths by doing onion unwind, or even full 
onion unwind instead of conditional teardown in intel_gsc_destroy_one. 
Not asking for it, just commenting.

> +}
> +
> +static void intel_gsc_irq_handler(struct intel_gt *gt, unsigned int intf_id)
> +{
> +	int ret;
> +
> +	if (intf_id >= INTEL_GSC_NUM_INTERFACES)
> +		return;

Is this worthy of a WARN_ON or drm_warn? (ratelimited I suppose) Because 
it would be either bad hardware or a bad driver error to see the 
interrupt with wrong interface, no?

> +
> +	if (!HAS_HECI_GSC(gt->i915))
> +		return;

Likewise?

> +
> +	if (gt->gsc.intf[intf_id].irq <= 0) {
> +		DRM_ERROR_RATELIMITED("error handling GSC irq: irq not set");

Like this, but use logging functions which say which device please.

> +		return;
> +	}
> +
> +	ret = generic_handle_irq(gt->gsc.intf[intf_id].irq);
> +	if (ret)
> +		DRM_ERROR_RATELIMITED("error handling GSC irq: %d\n", ret);
> +}
> +
> +void gsc_irq_handler(struct intel_gt *gt, u32 iir)
> +{
> +	if (iir & GSC_IRQ_INTF(0))
> +		intel_gsc_irq_handler(gt, 0);
> +	if (iir & GSC_IRQ_INTF(1))
> +		intel_gsc_irq_handler(gt, 1);
> +}
> +
> +void intel_gsc_init(struct intel_gsc *gsc, struct drm_i915_private *dev_priv)

Here you don't need to pass in dev_priv since you can get it with 
container_of and gt->i915 but up to you, no big deal.

> +{
> +	unsigned int i;
> +
> +	if (!HAS_HECI_GSC(dev_priv))
> +		return;
> +
> +	for (i = 0; i < INTEL_GSC_NUM_INTERFACES; i++)
> +		intel_gsc_init_one(dev_priv, &gsc->intf[i], i);
> +}
> +
> +void intel_gsc_fini(struct intel_gsc *gsc)
> +{
> +	struct intel_gt *gt = gsc_to_gt(gsc);
> +	unsigned int i;
> +
> +	if (!HAS_HECI_GSC(gt->i915))
> +		return;
> +
> +	for (i = 0; i < INTEL_GSC_NUM_INTERFACES; i++)
> +		intel_gsc_destroy_one(&gsc->intf[i]);
> +}
> diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.h b/drivers/gpu/drm/i915/gt/intel_gsc.h
> new file mode 100644
> index 000000000000..67cb2a75f839
> --- /dev/null
> +++ b/drivers/gpu/drm/i915/gt/intel_gsc.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright(c) 2019-2022, Intel Corporation. All rights reserved.
> + */
> +#ifndef __INTEL_GSC_DEV_H__
> +#define __INTEL_GSC_DEV_H__
> +
> +#include <linux/types.h>
> +
> +struct drm_i915_private;
> +struct intel_gt;
> +struct mei_aux_device;
> +
> +#define INTEL_GSC_NUM_INTERFACES 2
> +/*
> + * The HECI1 bit corresponds to bit15 and HECI2 to bit14.
> + * The reason for this is to allow growth for more interfaces in the future.
> + */
> +#define GSC_IRQ_INTF(_x)  BIT(15 - (_x))
> +
> +/**
> + * struct intel_gsc - graphics security controller
> + * @intf : gsc interface
> + */
> +struct intel_gsc {
> +	struct intel_gsc_intf {
> +		struct mei_aux_device *adev;
> +		int irq;
> +		unsigned int id;
> +	} intf[INTEL_GSC_NUM_INTERFACES];
> +};
> +
> +void intel_gsc_init(struct intel_gsc *gsc, struct drm_i915_private *dev_priv);
> +void intel_gsc_fini(struct intel_gsc *gsc);
> +void gsc_irq_handler(struct intel_gt *gt, u32 iir);

Why not have consistent prefix on all exported functions?

> +
> +#endif /* __INTEL_GSC_DEV_H__ */
> diff --git a/drivers/gpu/drm/i915/gt/intel_gt.c b/drivers/gpu/drm/i915/gt/intel_gt.c
> index e8403fa53909..18961d154956 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gt.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gt.c
> @@ -446,6 +446,8 @@ void intel_gt_chipset_flush(struct intel_gt *gt)
>   
>   void intel_gt_driver_register(struct intel_gt *gt)
>   {
> +	intel_gsc_init(&gt->gsc, gt->i915);
> +
>   	intel_rps_driver_register(&gt->rps);
>   
>   	intel_gt_debugfs_register(gt);
> @@ -766,6 +768,7 @@ void intel_gt_driver_unregister(struct intel_gt *gt)
>   	intel_wakeref_t wakeref;
>   
>   	intel_rps_driver_unregister(&gt->rps);
> +	intel_gsc_fini(&gt->gsc);
>   
>   	intel_pxp_fini(&gt->pxp);
>   
> diff --git a/drivers/gpu/drm/i915/gt/intel_gt.h b/drivers/gpu/drm/i915/gt/intel_gt.h
> index 2dad46c3eff2..6ba817c02baa 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gt.h
> +++ b/drivers/gpu/drm/i915/gt/intel_gt.h
> @@ -34,6 +34,11 @@ static inline struct intel_gt *huc_to_gt(struct intel_huc *huc)
>   	return container_of(huc, struct intel_gt, uc.huc);
>   }
>   
> +static inline struct intel_gt *gsc_to_gt(struct intel_gsc *gsc)
> +{
> +	return container_of(gsc, struct intel_gt, gsc);
> +}
> +
>   void intel_gt_init_early(struct intel_gt *gt, struct drm_i915_private *i915);
>   void __intel_gt_init_early(struct intel_gt *gt, struct drm_i915_private *i915);
>   int intel_gt_assign_ggtt(struct intel_gt *gt);
> diff --git a/drivers/gpu/drm/i915/gt/intel_gt_irq.c b/drivers/gpu/drm/i915/gt/intel_gt_irq.c
> index 983264e10e0a..d36f919bbdf5 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gt_irq.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gt_irq.c
> @@ -68,6 +68,9 @@ gen11_other_irq_handler(struct intel_gt *gt, const u8 instance,
>   	if (instance == OTHER_KCR_INSTANCE)
>   		return intel_pxp_irq_handler(&gt->pxp, iir);
>   
> +	if (instance == OTHER_GSC_INSTANCE)
> +		return gsc_irq_handler(gt, iir);
> +
>   	WARN_ONCE(1, "unhandled other interrupt instance=0x%x, iir=0x%x\n",
>   		  instance, iir);

Digression - it would be nice to be able to report unhandled iir bits 
here but all handlers return void so refactoring would be needed.

>   }
> @@ -182,6 +185,8 @@ void gen11_gt_irq_reset(struct intel_gt *gt)
>   	/* Disable RCS, BCS, VCS and VECS class engines. */
>   	intel_uncore_write(uncore, GEN11_RENDER_COPY_INTR_ENABLE, 0);
>   	intel_uncore_write(uncore, GEN11_VCS_VECS_INTR_ENABLE,	  0);
> +	if (HAS_HECI_GSC(gt->i915))
> +		intel_uncore_write(uncore, GEN11_GUNIT_CSME_INTR_ENABLE, 0);
>   
>   	/* Restore masks irqs on RCS, BCS, VCS and VECS engines. */
>   	intel_uncore_write(uncore, GEN11_RCS0_RSVD_INTR_MASK,	~0);
> @@ -195,6 +200,8 @@ void gen11_gt_irq_reset(struct intel_gt *gt)
>   	intel_uncore_write(uncore, GEN11_VECS0_VECS1_INTR_MASK,	~0);
>   	if (HAS_ENGINE(gt, VECS2) || HAS_ENGINE(gt, VECS3))
>   		intel_uncore_write(uncore, GEN12_VECS2_VECS3_INTR_MASK, ~0);
> +	if (HAS_HECI_GSC(gt->i915))
> +		intel_uncore_write(uncore, GEN11_GUNIT_CSME_INTR_MASK, ~0);
>   
>   	intel_uncore_write(uncore, GEN11_GPM_WGBOXPERF_INTR_ENABLE, 0);
>   	intel_uncore_write(uncore, GEN11_GPM_WGBOXPERF_INTR_MASK,  ~0);
> @@ -209,6 +216,7 @@ void gen11_gt_irq_postinstall(struct intel_gt *gt)
>   {
>   	struct intel_uncore *uncore = gt->uncore;
>   	u32 irqs = GT_RENDER_USER_INTERRUPT;
> +	const u32 gsc_mask = GSC_IRQ_INTF(0) | GSC_IRQ_INTF(1);

Why enable the one which is not supported by the patch? No harm doing it?

>   	u32 dmask;
>   	u32 smask;
>   
> @@ -225,6 +233,9 @@ void gen11_gt_irq_postinstall(struct intel_gt *gt)
>   	/* Enable RCS, BCS, VCS and VECS class interrupts. */
>   	intel_uncore_write(uncore, GEN11_RENDER_COPY_INTR_ENABLE, dmask);
>   	intel_uncore_write(uncore, GEN11_VCS_VECS_INTR_ENABLE, dmask);
> +	if (HAS_HECI_GSC(gt->i915))
> +		intel_uncore_write(uncore, GEN11_GUNIT_CSME_INTR_ENABLE,
> +				   gsc_mask);
>   
>   	/* Unmask irqs on RCS, BCS, VCS and VECS engines. */
>   	intel_uncore_write(uncore, GEN11_RCS0_RSVD_INTR_MASK, ~smask);
> @@ -238,6 +249,8 @@ void gen11_gt_irq_postinstall(struct intel_gt *gt)
>   	intel_uncore_write(uncore, GEN11_VECS0_VECS1_INTR_MASK, ~dmask);
>   	if (HAS_ENGINE(gt, VECS2) || HAS_ENGINE(gt, VECS3))
>   		intel_uncore_write(uncore, GEN12_VECS2_VECS3_INTR_MASK, ~dmask);
> +	if (HAS_HECI_GSC(gt->i915))
> +		intel_uncore_write(uncore, GEN11_GUNIT_CSME_INTR_MASK, 0);
>   	/*
>   	 * RPS interrupts will get enabled/disabled on demand when RPS itself
>   	 * is enabled/disabled.
> diff --git a/drivers/gpu/drm/i915/gt/intel_gt_regs.h b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
> index a6f0220c2e9f..427f91900afc 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
> +++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
> @@ -944,6 +944,7 @@ enum {
>   #define OTHER_GUC_INSTANCE	0
>   #define OTHER_GTPM_INSTANCE	1
>   #define OTHER_KCR_INSTANCE	4
> +#define OTHER_GSC_INSTANCE	6
>   
>   #define GEN11_INTR_IDENTITY_REG(x)	_MMIO(0x190060 + ((x) * 4))
>   
> diff --git a/drivers/gpu/drm/i915/gt/intel_gt_types.h b/drivers/gpu/drm/i915/gt/intel_gt_types.h
> index f20687796490..5556d55f76ea 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gt_types.h
> +++ b/drivers/gpu/drm/i915/gt/intel_gt_types.h
> @@ -16,6 +16,7 @@
>   #include <linux/workqueue.h>
>   
>   #include "uc/intel_uc.h"
> +#include "intel_gsc.h"
>   
>   #include "i915_vma.h"
>   #include "intel_engine_types.h"
> @@ -72,6 +73,7 @@ struct intel_gt {
>   	struct i915_ggtt *ggtt;
>   
>   	struct intel_uc uc;
> +	struct intel_gsc gsc;
>   
>   	struct mutex tlb_invalidate_lock;
>   
> diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> index 4f057a45654a..b41871abe776 100644
> --- a/drivers/gpu/drm/i915/i915_drv.h
> +++ b/drivers/gpu/drm/i915/i915_drv.h
> @@ -1444,6 +1444,14 @@ IS_SUBPLATFORM(const struct drm_i915_private *i915,
>   
>   #define HAS_DMC(dev_priv)	(INTEL_INFO(dev_priv)->display.has_dmc)
>   
> +#define HAS_HECI_PXP(dev_priv) \
> +	(INTEL_INFO(dev_priv)->has_heci_pxp)
> +
> +#define HAS_HECI_GSCFI(dev_priv) \
> +	(INTEL_INFO(dev_priv)->has_heci_gscfi)
> +
> +#define HAS_HECI_GSC(dev_priv) (HAS_HECI_PXP(dev_priv) || HAS_HECI_GSCFI(dev_priv))
> +
>   #define HAS_MSO(i915)		(DISPLAY_VER(i915) >= 12)
>   
>   #define HAS_RUNTIME_PM(dev_priv) (INTEL_INFO(dev_priv)->has_runtime_pm)
> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
> index 467252f885c2..8f608b03d30b 100644
> --- a/drivers/gpu/drm/i915/i915_pci.c
> +++ b/drivers/gpu/drm/i915/i915_pci.c
> @@ -900,7 +900,8 @@ static const struct intel_device_info rkl_info = {
>   	.has_llc = 0, \
>   	.has_pxp = 0, \
>   	.has_snoop = 1, \
> -	.is_dgfx = 1
> +	.is_dgfx = 1, \
> +	.has_heci_gscfi = 1
>   
>   static const struct intel_device_info dg1_info = {
>   	GEN12_FEATURES,
> diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
> index ca6adfc234c0..e74934255198 100644
> --- a/drivers/gpu/drm/i915/i915_reg.h
> +++ b/drivers/gpu/drm/i915/i915_reg.h
> @@ -974,6 +974,8 @@
>   #define GEN11_VEBOX2_RING_BASE		0x1d8000
>   #define XEHP_VEBOX3_RING_BASE		0x1e8000
>   #define XEHP_VEBOX4_RING_BASE		0x1f8000
> +#define GSC_DG1_HECI1_BASE	0x00258000
> +#define GSC_DG1_HECI2_BASE	0x00259000
>   #define BLT_RING_BASE		0x22000
>   
>   
> diff --git a/drivers/gpu/drm/i915/intel_device_info.h b/drivers/gpu/drm/i915/intel_device_info.h
> index 27dcfe6f2429..fa75f464cb01 100644
> --- a/drivers/gpu/drm/i915/intel_device_info.h
> +++ b/drivers/gpu/drm/i915/intel_device_info.h
> @@ -135,6 +135,8 @@ enum intel_ppgtt_type {
>   	func(has_reset_engine); \
>   	func(has_global_mocs); \
>   	func(has_gt_uc); \
> +	func(has_heci_pxp); \

Presumably this will be used soon? (And the variety of HAS_ macros.)

> +	func(has_heci_gscfi); \
>   	func(has_guc_deprivilege); \
>   	func(has_l3_dpf); \
>   	func(has_llc); \
> diff --git a/include/linux/mei_aux.h b/include/linux/mei_aux.h
> new file mode 100644
> index 000000000000..587f25128848
> --- /dev/null
> +++ b/include/linux/mei_aux.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2022, Intel Corporation. All rights reserved.
> + */
> +#ifndef _LINUX_MEI_AUX_H
> +#define _LINUX_MEI_AUX_H
> +
> +#include <linux/auxiliary_bus.h>
> +
> +struct mei_aux_device {
> +	struct auxiliary_device aux_dev;
> +	int irq;
> +	struct resource bar;
> +};
> +
> +#define auxiliary_dev_to_mei_aux_dev(auxiliary_dev) \
> +	container_of(auxiliary_dev, struct mei_aux_device, aux_dev)
> +
> +#endif /* _LINUX_MEI_AUX_H */

In summary I think prefix on the exported function and 
drm_err_ratelimited were the only comments which need action. The rest 
were either questions of suggestions on how to polish it a bit more so 
it aligns better with established i915 patterns.

Regards,

Tvrtko

