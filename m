Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51E54F8263
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344421AbiDGPGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344418AbiDGPGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:06:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6CD1B29DC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649343845; x=1680879845;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Y3VPFPEBEueMVx8dW2rbCqqe+xkFwaxTb9dysb5/jW4=;
  b=SvpNrF/ZCwWO0p9BEUgbfJx/b7lZ7cDiKr6M/fQvkNRoTZ3PLs42A5ED
   9RQpPrBwVkt8sVSBvdtPOfmURXuc5aLm571IB5vAZ9x8x9Bu9kIqRbS0a
   0KCvoupiS74T/UwAT5D2PltvBlkTmgiLoawWnxIL+yCG+nL290CAe7aTv
   d9ASxR8cvKC5qFXf+79Oypx6UN8CJMZ2MhNkY5N8fx0h4YnYhG4DmAkl0
   mPejXBqwuaGt9YtgMuQoO1KtESwRqgy6xhcrmExrmppn3sHzH/UcofIEa
   a4OikKwZMgAoqr1iIsKSW6TPg33WVfHiU2qwxH86nidbmmITu9zdLynCu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10309"; a="258943885"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="258943885"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 08:03:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571089386"
Received: from kgibala-mobl.ger.corp.intel.com (HELO localhost) ([10.249.142.48])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 08:03:41 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Zhi Wang <zhi.wang.linux@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org
Cc:     Zhi Wang <zhi.a.wang@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Vivi Rodrigo <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Subject: Re: [PATCH v9 1/3] i915/gvt: Separate the MMIO tracking table from
 GVT-g
In-Reply-To: <20220407071945.72148-2-zhi.a.wang@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220407071945.72148-1-zhi.a.wang@intel.com>
 <20220407071945.72148-2-zhi.a.wang@intel.com>
Date:   Thu, 07 Apr 2022 18:03:38 +0300
Message-ID: <874k35541h.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Apr 2022, Zhi Wang <zhi.wang.linux@gmail.com> wrote:
> diff --git a/drivers/gpu/drm/i915/intel_gvt.h b/drivers/gpu/drm/i915/inte=
l_gvt.h
> index d7d3fb6186fd..7665d7cf0bdd 100644
> --- a/drivers/gpu/drm/i915/intel_gvt.h
> +++ b/drivers/gpu/drm/i915/intel_gvt.h
> @@ -26,7 +26,17 @@
>=20=20
>  struct drm_i915_private;
>=20=20
> +#include <linux/kernel.h>

You only need <linux/types.h>. Please add it before the forward
declaration above.

> +
>  #ifdef CONFIG_DRM_I915_GVT
> +
> +struct intel_gvt_mmio_table_iter {
> +	struct drm_i915_private *i915;
> +	void *data;
> +	int (*handle_mmio_cb)(struct intel_gvt_mmio_table_iter *iter,
> +			      u32 offset, u32 size);
> +};
> +
>  int intel_gvt_init(struct drm_i915_private *dev_priv);
>  void intel_gvt_driver_remove(struct drm_i915_private *dev_priv);
>  int intel_gvt_init_device(struct drm_i915_private *dev_priv);
> @@ -34,6 +44,7 @@ void intel_gvt_clean_device(struct drm_i915_private *de=
v_priv);
>  int intel_gvt_init_host(void);
>  void intel_gvt_sanitize_options(struct drm_i915_private *dev_priv);
>  void intel_gvt_resume(struct drm_i915_private *dev_priv);
> +int intel_gvt_iterate_mmio_table(struct intel_gvt_mmio_table_iter *iter);
>  #else
>  static inline int intel_gvt_init(struct drm_i915_private *dev_priv)
>  {
> @@ -51,6 +62,16 @@ static inline void intel_gvt_sanitize_options(struct d=
rm_i915_private *dev_priv)
>  static inline void intel_gvt_resume(struct drm_i915_private *dev_priv)
>  {
>  }
> +
> +unsigned long intel_gvt_get_device_type(struct drm_i915_private *i915)
> +{
> +	return 0;
> +}

The CONFIG_DRM_I915_GVT=3Dy counterpart for this is in mmio.h. Should be
both in the same header.

> +
> +int intel_gvt_iterate_mmio_table(struct intel_gvt_mmio_table_iter *iter)
> +{
> +	return 0;
> +}
>  #endif
>=20=20
>  #endif /* _INTEL_GVT_H_ */
> diff --git a/drivers/gpu/drm/i915/intel_gvt_mmio_table.c b/drivers/gpu/dr=
m/i915/intel_gvt_mmio_table.c
> new file mode 100644
> index 000000000000..d29491a6d209
> --- /dev/null
> +++ b/drivers/gpu/drm/i915/intel_gvt_mmio_table.c
> @@ -0,0 +1,1290 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright =C2=A9 2020 Intel Corporation
> + */
> +
> +#include "i915_drv.h"
> +#include "i915_reg.h"
> +#include "display/vlv_dsi_pll_regs.h"
> +#include "gt/intel_gt_regs.h"
> +#include "intel_mchbar_regs.h"
> +#include "i915_pvinfo.h"
> +#include "intel_gvt.h"
> +#include "gvt/gvt.h"

Generally we have the include lists sorted.

Other than the nitpicks above, the series is

Acked-by: Jani Nikula <jani.nikula@intel.com>


BR,
Jani.


--=20
Jani Nikula, Intel Open Source Graphics Center
