Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E708A4A3DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 07:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243220AbiAaGfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 01:35:07 -0500
Received: from verein.lst.de ([213.95.11.211]:53678 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235726AbiAaGe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 01:34:56 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BC76868AFE; Mon, 31 Jan 2022 07:34:51 +0100 (CET)
Date:   Mon, 31 Jan 2022 07:34:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     hch@lst.de, jgg@nvidia.com, jani.nikula@linux.intel.com,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Vivi Rodrigo <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Terrence Xu <terrence.xu@intel.com>
Subject: Re: [PATCH 1/3] i915/gvt: Introduce the mmio_table.c to support
 VFIO new mdev API
Message-ID: <20220131063451.GA4390@lst.de>
References: <20220127120508.11330-1-zhi.a.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127120508.11330-1-zhi.a.wang@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  ifeq ($(CONFIG_DRM_I915_GVT),y)
> -i915-y += intel_gvt.o
> +i915-y += intel_gvt.o gvt/mmio_table.o

With the split from my series in mind that builds all of the gvt/
subdirectory into a separate module I'd be tempted to places this new
file into the main i915 directory as e.g. intel_gvt_mmio_table.c, given
that it will have to be built into the main i915 module.

> -static void init_device_info(struct intel_gvt *gvt)

I'd keep this function as-is, as the newly added caller isn't actually
needed (I'll comment on this more on the next patch).

> -/* Describe per-platform limitations. */
> -struct intel_gvt_device_info {
> -	u32 max_support_vgpus;
> -	u32 cfg_space_size;
> -	u32 mmio_size;
> -	u32 mmio_bar;
> -	unsigned long msi_cap_offset;
> -	u32 gtt_start_offset;
> -	u32 gtt_entry_size;
> -	u32 gtt_entry_size_shift;
> -	int gmadr_bytes_in_cmd;
> -	u32 max_surface_size;
> -};

.. and with that there should be no need to move this declaration
as well.

> -struct gvt_mmio_block {
> +struct intel_gvt_mmio_block {

Any good reason for this rename?  It just seems to create a lot of
churn without muchof a reason.

> +static int do_mmio(u32 offset, u16 flags, u32 size, u32 addr_mask,
> +		   u32 ro_mask, u32 device,
> +		   struct intel_gvt_mmio_table_iter *iter)

Nit:  I'd pass the iter first to these kinds of callbacks.
Also the do_ name (including for the method name in the struct itself)
looks odd.  I'd rather use a _cb or _fn postfix.

> +	for (i = start; i < end; i += 4) {
> +		info = kzalloc(sizeof(*info), GFP_KERNEL);
> +		if (!info)
> +			return -ENOMEM;
> +
> +		info->offset = i;
> +		p = intel_gvt_find_mmio_info(gvt, info->offset);
> +		if (p) {
> +			WARN(1, "dup mmio definition offset %x\n",
> +				info->offset);
> +			kfree(info);
> +
> +			/* We return -EEXIST here to make GVT-g load fail.
> +			 * So duplicated MMIO can be found as soon as
> +			 * possible.
> +			 */
> +			return -EEXIST;
> +		}

I'd allocate the new structure only after the lookup to simplify this
a bit.

> +
> +		info->ro_mask = ro_mask;

The r/o mask is only used here, so why not move it into the local
declarations in handlers.c instead of the table built into i915.ko?

> +		info->device = device;
> +		info->read = intel_vgpu_default_mmio_read;
> +		info->write = intel_vgpu_default_mmio_write;

Given that we always initialize ->read and ->write here,
setup_mmio_handler can be simplified a bit and only needs to override
the handlers if actually specified in the table.

> +static int init_mmio_info(struct intel_gvt *gvt)
> +{
> +	struct intel_gvt_mmio_table_iter iter;
> +
> +	iter.i915 = gvt->gt->i915;
> +	iter.data = gvt;
> +	iter.do_mmio = do_mmio;
> +	iter.do_mmio_block = do_mmio_block;

Nit: This and the other caller could initialize the iter structure
statically:

	struct intel_gvt_mmio_table_iter iter = {
		.i915		= gvt->gt->i915,
		.data		= gvt,
		.mmio_cb	= intel_gvt_setup_mmio_cb,
		.mmio_block_cb	= intel_gvt_setup_mmio_block_cb,
	};

> +	block = find_mmio_block(gvt, VGT_PVINFO_PAGE);
> +	block->read = pvinfo_mmio_read;
> +	block->write = pvinfo_mmio_write;

Check for NULL here?

>  	} else if (IS_SKYLAKE(i915) ||
> -		   IS_KABYLAKE(i915) ||
> -		   IS_COFFEELAKE(i915) ||
> -		   IS_COMETLAKE(i915)) {
> -		ret = init_bdw_mmio_info(gvt);
> +			IS_KABYLAKE(i915) ||
> +			IS_COFFEELAKE(i915) ||
> +			IS_COMETLAKE(i915)) {
> +		ret = init_bdw_mmio_handlers(gvt);

Why the spurious reformatting?

> +/**
> + * intel_gvt_get_device_type - return the device flag of a GVT device
> + * @i915: drm i915 private data
> + *
> + * This function will return the device flag of a GVT device.
> + */
> +unsigned long intel_gvt_get_device_type(struct drm_i915_private *i915)
> +{
> +	if (IS_BROADWELL(i915))
> +		return D_BDW;
> +	else if (IS_SKYLAKE(i915))
> +		return D_SKL;
> +	else if (IS_KABYLAKE(i915))
> +		return D_KBL;
> +	else if (IS_BROXTON(i915))
> +		return D_BXT;
> +	else if (IS_COFFEELAKE(i915) || IS_COMETLAKE(i915))
> +		return D_CFL;
> +
> +	return 0;
> +}

I'd move this into intel_gvt.c, next to is_supported_device which
also lists all the supported platforms.  Preferably as a prep patch
that does the move and change of argument before the main MMIO table
patch.

> +++ b/drivers/gpu/drm/i915/gvt/mmio_table.h

Do we really need this new header vs just using intel_gvt.h?
