Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A0E4A3DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 07:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357701AbiAaGiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 01:38:08 -0500
Received: from verein.lst.de ([213.95.11.211]:53688 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352820AbiAaGiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 01:38:07 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E502468AFE; Mon, 31 Jan 2022 07:38:03 +0100 (CET)
Date:   Mon, 31 Jan 2022 07:38:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     hch@lst.de, jgg@nvidia.com, jani.nikula@linux.intel.com,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zhi Wang <zhi.a.wang@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Vivi Rodrigo <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH 2/3] i915/gvt: save the initial HW state snapshot in
 i915.
Message-ID: <20220131063803.GB4390@lst.de>
References: <20220127120508.11330-1-zhi.a.wang@intel.com> <20220127120508.11330-2-zhi.a.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127120508.11330-2-zhi.a.wang@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 07:05:07AM -0500, Zhi Wang wrote:
> +static void save_mmio(struct intel_gvt_mmio_table_iter *iter, u32 offset,
> +		      u32 size)
> +{
> +	struct drm_i915_private *dev_priv = iter->i915;
> +	void *mmio = iter->data;
> +	u32 start, end, i;
> +
> +	start = offset;
> +	end = offset + size;
> +
> +	for (i = start; i < end; i += 4) {
> +		*(u32 *)(mmio + i) = intel_uncore_read_notrace(
> +				to_gt(dev_priv)->uncore, _MMIO(offset));
> +	}
> +}

This can be simplified to:

static void intel_gvt_save_mmio(struct intel_gvt_mmio_table_iter *iter,
		u32 offset, u32 size)
{
	struct drm_i915_private *dev_priv = iter->i915;
	u32 *mmio = iter->data, i;

	for (i = offset; i < offset + size; i += 4) {
		mmio[i] = intel_uncore_read_notrace(to_gt(dev_priv)->uncore,
						    _MMIO(offset));
	}
}

> +	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
> +	struct intel_gvt_device_info info;
> +	struct i915_virtual_gpu *vgpu = &dev_priv->vgpu;
> +	struct intel_gvt_mmio_table_iter iter;
> +	void *mem;
> +	int i, ret;
> +
> +	intel_gvt_init_device_info(dev_priv, &info);

There is no real need for this call.

> +
> +	mem = kzalloc(info.cfg_space_size, GFP_KERNEL);
> +	if (!mem)
> +		return -ENOMEM;

info.cfg_space_size is always PCI_CFG_SPACE_EXP_SIZE, and the code relies
onb that just a few lines below.

> +	mem = vzalloc(info.mmio_size);

And info.mmio_size is a constant that can just use a define.
