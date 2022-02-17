Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234594B9C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbiBQJiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:38:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238736AbiBQJiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:38:07 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F099D1D4582
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645090671; x=1676626671;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AIEJwum5fz+0fnPPiXtVQloBFXDJoLvv1OBFHrUxUH8=;
  b=gjVV/UzecLjZB2HeE51DlH6FOcie6kp6H2g5X1F2m9+zLww6Y3wOzFAX
   J2GTsiAU99AcvXJ0wUZ2wa++Cl51hwyNSUbg5g86vrgbWIwQe2zpN8GA4
   3AVG1qqRA7CtsnABgMyUTvbxj/aZnjnCnZZ/eVkLKq1OOktXEUM3miuD2
   WijBirqX4Vr1zR3l5OATWBujP0ekmOb8C0CFNdG7yFxVwEBYCcjJhqAOe
   NuV2+NnnbgsBmPW4hf35C153VrJuzW2t3/cTltxZZCzz05zqRIdLq/jwR
   OSx5XauhvlIPVcvpaaDuOMpCl9FKGpUDBKxP8dBju9adqz5jhQe3oQZmS
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="314105088"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="314105088"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 01:37:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="530077941"
Received: from markorti-mobl.ger.corp.intel.com (HELO [10.213.216.21]) ([10.213.216.21])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 01:37:48 -0800
Message-ID: <7c381584-85bb-fb20-3bc4-2857d1dc24df@linux.intel.com>
Date:   Thu, 17 Feb 2022 09:37:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8 1/5] drm/i915/gsc: add gsc as a mei auxiliary device
Content-Language: en-US
To:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220216195459.3918414-1-alexander.usyskin@intel.com>
 <20220216195459.3918414-2-alexander.usyskin@intel.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20220216195459.3918414-2-alexander.usyskin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/02/2022 19:54, Alexander Usyskin wrote:
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
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
> V4: add header to the MAINTAINERS file
>      drop empty line
> V5: rebase
> V6: rebase, drop redundant assignments
> V7: add Greg KH Reviewed-by
> V8: rename dev_priv variable to i915,
>      drop data from irq_set_chip_data,
>      switch intel_gsc_irq_handler with gsc_irq_handler to have same prefixes in the external API,
>      add error prints and use right drm print functions
> ---
>   MAINTAINERS                              |   1 +
>   drivers/gpu/drm/i915/Kconfig             |   1 +
>   drivers/gpu/drm/i915/Makefile            |   3 +
>   drivers/gpu/drm/i915/gt/intel_gsc.c      | 199 +++++++++++++++++++++++
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
>   15 files changed, 298 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.c
>   create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.h
>   create mode 100644 include/linux/mei_aux.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 78b8f2038ce8..e95dad2b628c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9810,6 +9810,7 @@ S:	Supported
>   F:	Documentation/driver-api/mei/*
>   F:	drivers/misc/mei/
>   F:	drivers/watchdog/mei_wdt.c
> +F:	include/linux/mei_aux.h
>   F:	include/linux/mei_cl_bus.h
>   F:	include/uapi/linux/mei.h
>   F:	samples/mei/*
> diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
> index 42b5400f0fef..b51dbe3c09ee 100644
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
> index 000000000000..a3a73c234bad
> --- /dev/null
> +++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
> @@ -0,0 +1,199 @@
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
> +}
> +
> +static struct irq_chip gsc_irq_chip = {
> +	.name = "gsc_irq_chip",
> +	.irq_mask = gsc_irq_mask,
> +	.irq_unmask = gsc_irq_unmask,
> +};
> +
> +static int gsc_irq_init(int irq)
> +{
> +	irq_set_chip_and_handler_name(irq, &gsc_irq_chip,
> +				      handle_simple_irq, "gsc_irq_handler");
> +
> +	return irq_set_chip_data(irq, NULL);
> +}
> +
> +struct intel_gsc_def {
> +	const char *name;
> +	unsigned long bar;
> +	size_t bar_size;
> +};
> +
> +/* gscfi (graphics system controller firmware interface) resources */
> +static const struct intel_gsc_def intel_gsc_def_dg1[] = {
> +	{
> +		/* HECI1 not yet implemented. */
> +	},
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
> +static void intel_gsc_init_one(struct drm_i915_private *i915,
> +			       struct intel_gsc_intf *intf,
> +			       unsigned int intf_id)
> +{
> +	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
> +	struct mei_aux_device *adev;
> +	struct auxiliary_device *aux_dev;
> +	const struct intel_gsc_def *def;
> +	int ret;
> +
> +	intf->irq = -1;
> +	intf->id = intf_id;
> +
> +	if (intf_id == 0 && !HAS_HECI_PXP(i915))
> +		return;
> +
> +	def = &intel_gsc_def_dg1[intf_id];
> +
> +	intf->irq = irq_alloc_desc(0);
> +	if (intf->irq < 0) {
> +		dev_err(&pdev->dev, "gsc irq error %d\n", intf->irq);
> +		return;
> +	}
> +
> +	ret = gsc_irq_init(intf->irq);
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
> +		auxiliary_device_uninit(aux_dev);
> +		goto fail;
> +	}
> +	intf->adev = adev;
> +
> +	return;
> +fail:
> +	intel_gsc_destroy_one(intf);
> +}
> +
> +static void gsc_irq_handler(struct intel_gt *gt, unsigned int intf_id)
> +{
> +	int ret;
> +
> +	if (intf_id >= INTEL_GSC_NUM_INTERFACES) {
> +		drm_warn_once(&gt->i915->drm, "GSC irq: intf_id %d is out of range", intf_id);
> +		return;
> +	}
> +
> +	if (!HAS_HECI_GSC(gt->i915)) {
> +		drm_warn_once(&gt->i915->drm, "GSC irq: not supported");
> +		return;
> +	}
> +
> +	if (gt->gsc.intf[intf_id].irq <= 0) {
> +		drm_err_ratelimited(&gt->i915->drm, "GSC irq: irq not set");
> +		return;

IRQ 0 is valid, right?

Regards,

Tvrtko

> +	}
> +
> +	ret = generic_handle_irq(gt->gsc.intf[intf_id].irq);
> +	if (ret)
> +		drm_err_ratelimited(&gt->i915->drm, "error handling GSC irq: %d\n", ret);
> +}
> +
> +void intel_gsc_irq_handler(struct intel_gt *gt, u32 iir)
> +{
> +	if (iir & GSC_IRQ_INTF(0))
> +		gsc_irq_handler(gt, 0);
> +	if (iir & GSC_IRQ_INTF(1))
> +		gsc_irq_handler(gt, 1);
> +}
> +
> +void intel_gsc_init(struct intel_gsc *gsc, struct drm_i915_private *i915)
> +{
> +	unsigned int i;
> +
> +	if (!HAS_HECI_GSC(i915))
> +		return;
> +
> +	for (i = 0; i < INTEL_GSC_NUM_INTERFACES; i++)
> +		intel_gsc_init_one(i915, &gsc->intf[i], i);
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
> index 000000000000..68582f912b21
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
> +void intel_gsc_irq_handler(struct intel_gt *gt, u32 iir);
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
> index 983264e10e0a..08bf2796c3c1 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gt_irq.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gt_irq.c
> @@ -68,6 +68,9 @@ gen11_other_irq_handler(struct intel_gt *gt, const u8 instance,
>   	if (instance == OTHER_KCR_INSTANCE)
>   		return intel_pxp_irq_handler(&gt->pxp, iir);
>   
> +	if (instance == OTHER_GSC_INSTANCE)
> +		return intel_gsc_irq_handler(gt, iir);
> +
>   	WARN_ONCE(1, "unhandled other interrupt instance=0x%x, iir=0x%x\n",
>   		  instance, iir);
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
> index 418091484e02..168bf32deea0 100644
> --- a/drivers/gpu/drm/i915/i915_drv.h
> +++ b/drivers/gpu/drm/i915/i915_drv.h
> @@ -1327,6 +1327,14 @@ IS_SUBPLATFORM(const struct drm_i915_private *i915,
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
> index 8246cbe9b01d..ef54917a0000 100644
> --- a/drivers/gpu/drm/i915/i915_pci.c
> +++ b/drivers/gpu/drm/i915/i915_pci.c
> @@ -901,7 +901,8 @@ static const struct intel_device_info rkl_info = {
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
> index 4ea1713e6b60..8afe4af6c844 100644
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
