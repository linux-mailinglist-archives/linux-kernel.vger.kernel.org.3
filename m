Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5B54FF3B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbiDMJjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbiDMJjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:39:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B3054699
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649842612; x=1681378612;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=MT1Kf7edS218qgu1PUr9mXSGIu5bS3fCzq8ZJBUhQT4=;
  b=XCTXPatTIMqebrhjtS1oXzDl4fAbbf+IW+QT2P9U7Ir/xm0XegjoVRia
   Vk5hPSHjciGILKYgvFBoX6BIBaLkyiM6QnnN0sQvyJFBvtfDvNni0vk2m
   B2mKSNxsV+Y3FDzCKVyxhbp0b3D4sREifzR1nmHgWA0ELDiUUPbhMb17v
   RPaa2OJfcYStCc8i9zYY2L34o2RN7pL2qXC2Dsy7QCOuSd9wNhyZ5yxSP
   QPMSeXqpFP/rsCUD1b2JaQN34EryliOv4/tEV1QL1ssvLFVR17y6Ynh/z
   6N+iZHbZpZS0YOGwk43AyHTTq0zKJJrpkKE3sYYFDxXAyPFuR3GnIxMfb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="243206855"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="243206855"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 02:31:13 -0700
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="573192674"
Received: from psoltysi-mobl.ger.corp.intel.com (HELO localhost) ([10.249.149.160])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 02:31:09 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     "Wang, Zhi A" <zhi.a.wang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>
Cc:     Zhi Wang <zhi.a.wang@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v9 1/3] i915/gvt: Separate the MMIO tracking table from
 GVT-g
In-Reply-To: <986b8ff0-d0de-437c-8a56-c54aafb6159a@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220407071945.72148-1-zhi.a.wang@intel.com>
 <20220407071945.72148-2-zhi.a.wang@intel.com> <874k35541h.fsf@intel.com>
 <986b8ff0-d0de-437c-8a56-c54aafb6159a@intel.com>
Date:   Wed, 13 Apr 2022 12:31:07 +0300
Message-ID: <87h76xgwis.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Apr 2022, "Wang, Zhi A" <zhi.a.wang@intel.com> wrote:
> Hi Jani:
>
> Thanks so much for the help. Can you generate a new tag on
> drm-intel-next? I noticed that there was one patch moving the DMC
> related registers into display/intel_dmc_regs.h, which is not included
> in the latest tag on drm-intel-next.

Sorry, I'm not sure what you're asking exactly. We do tags when we
create pull requests for drm-next, but I don't see the connection to
gvt.

BR,
Jani.

>
> Guess it would be better that I can change this patch according to it
> when checking in. This would prevent a conflict in future.
>
> Thanks,
> Zhi.
>
> On 4/7/22 3:03 PM, Jani Nikula wrote:
>> On Thu, 07 Apr 2022, Zhi Wang <zhi.wang.linux@gmail.com> wrote:
>>> diff --git a/drivers/gpu/drm/i915/intel_gvt.h b/drivers/gpu/drm/i915/in=
tel_gvt.h
>>> index d7d3fb6186fd..7665d7cf0bdd 100644
>>> --- a/drivers/gpu/drm/i915/intel_gvt.h
>>> +++ b/drivers/gpu/drm/i915/intel_gvt.h
>>> @@ -26,7 +26,17 @@
>>>=20=20
>>>  struct drm_i915_private;
>>>=20=20
>>> +#include <linux/kernel.h>
>>=20
>> You only need <linux/types.h>. Please add it before the forward
>> declaration above.
>>=20
>>> +
>>>  #ifdef CONFIG_DRM_I915_GVT
>>> +
>>> +struct intel_gvt_mmio_table_iter {
>>> +	struct drm_i915_private *i915;
>>> +	void *data;
>>> +	int (*handle_mmio_cb)(struct intel_gvt_mmio_table_iter *iter,
>>> +			      u32 offset, u32 size);
>>> +};
>>> +
>>>  int intel_gvt_init(struct drm_i915_private *dev_priv);
>>>  void intel_gvt_driver_remove(struct drm_i915_private *dev_priv);
>>>  int intel_gvt_init_device(struct drm_i915_private *dev_priv);
>>> @@ -34,6 +44,7 @@ void intel_gvt_clean_device(struct drm_i915_private *=
dev_priv);
>>>  int intel_gvt_init_host(void);
>>>  void intel_gvt_sanitize_options(struct drm_i915_private *dev_priv);
>>>  void intel_gvt_resume(struct drm_i915_private *dev_priv);
>>> +int intel_gvt_iterate_mmio_table(struct intel_gvt_mmio_table_iter *ite=
r);
>>>  #else
>>>  static inline int intel_gvt_init(struct drm_i915_private *dev_priv)
>>>  {
>>> @@ -51,6 +62,16 @@ static inline void intel_gvt_sanitize_options(struct=
 drm_i915_private *dev_priv)
>>>  static inline void intel_gvt_resume(struct drm_i915_private *dev_priv)
>>>  {
>>>  }
>>> +
>>> +unsigned long intel_gvt_get_device_type(struct drm_i915_private *i915)
>>> +{
>>> +	return 0;
>>> +}
>>=20
>> The CONFIG_DRM_I915_GVT=3Dy counterpart for this is in mmio.h. Should be
>> both in the same header.
>>=20
>>> +
>>> +int intel_gvt_iterate_mmio_table(struct intel_gvt_mmio_table_iter *ite=
r)
>>> +{
>>> +	return 0;
>>> +}
>>>  #endif
>>>=20=20
>>>  #endif /* _INTEL_GVT_H_ */
>>> diff --git a/drivers/gpu/drm/i915/intel_gvt_mmio_table.c b/drivers/gpu/=
drm/i915/intel_gvt_mmio_table.c
>>> new file mode 100644
>>> index 000000000000..d29491a6d209
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/i915/intel_gvt_mmio_table.c
>>> @@ -0,0 +1,1290 @@
>>> +// SPDX-License-Identifier: MIT
>>> +/*
>>> + * Copyright =C2=A9 2020 Intel Corporation
>>> + */
>>> +
>>> +#include "i915_drv.h"
>>> +#include "i915_reg.h"
>>> +#include "display/vlv_dsi_pll_regs.h"
>>> +#include "gt/intel_gt_regs.h"
>>> +#include "intel_mchbar_regs.h"
>>> +#include "i915_pvinfo.h"
>>> +#include "intel_gvt.h"
>>> +#include "gvt/gvt.h"
>>=20
>> Generally we have the include lists sorted.
>>=20
>> Other than the nitpicks above, the series is
>>=20
>> Acked-by: Jani Nikula <jani.nikula@intel.com>
>>=20
>>=20
>> BR,
>> Jani.
>>=20
>>=20
>

--=20
Jani Nikula, Intel Open Source Graphics Center
