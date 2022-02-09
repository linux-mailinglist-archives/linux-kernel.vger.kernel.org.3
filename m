Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E094AEB0D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbiBIHcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237816AbiBIHcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:32:03 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE8CC05CB8A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:32:05 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C80E668B05; Wed,  9 Feb 2022 08:32:01 +0100 (CET)
Date:   Wed, 9 Feb 2022 08:32:01 +0100
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
Subject: Re: [PATCH v6 2/3] i915/gvt: Save the initial HW state snapshot in
 i915
Message-ID: <20220209073201.GB9050@lst.de>
References: <20220208111151.13115-1-zhi.a.wang@intel.com> <20220208111151.13115-2-zhi.a.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208111151.13115-2-zhi.a.wang@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 06:11:50AM -0500, Zhi Wang wrote:
> +	struct drm_i915_private *dev_priv = iter->i915;
> +	u32 *mmio, i;
> +
> +	for (i = offset; i < offset + size; i += 4) {
> +		mmio = iter->data + i;
> +		*mmio = intel_uncore_read_notrace(to_gt(dev_priv)->uncore,
> +						  _MMIO(i));

This reads much stranger than:

	u32 *mmio = iter->data;

	for (i = offset; i < offset + size; i += 4) {
		mmio[i] = intel_uncore_read_notrace(to_gt(dev_priv)->uncore,
						    _MMIO(i));
	}

> +static int handle_mmio(struct intel_gvt_mmio_table_iter *iter,
> +		       u32 offset, u32 device, u32 size)
> +{
> +	if (WARN_ON(!IS_ALIGNED(offset, 4)))
> +		return -EINVAL;

Shouldn't this be in the caller of the method?

> +	save_mmio(iter, offset, size);
> +	return 0;

Now that the block callback is gone save_mmio and handle_mmio
can be merged.

> +	mem = vzalloc(2 * SZ_1M);

Don't we want a driver-wide constant for this instead of a magic number?
