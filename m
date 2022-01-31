Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C454A4095
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239834AbiAaK5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:57:43 -0500
Received: from mga09.intel.com ([134.134.136.24]:43981 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239808AbiAaK5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643626653; x=1675162653;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ZdENkAwNTJtD0Npkluazkuj5//kfgKoLfVNh1OSJ8Us=;
  b=i4EwR1CEGWZqAO4CWu+i4YxDrBD4bpwP6hI5UwAJoBaBFU8MSiQ00pSh
   ctjHSKScIG7dv/PJEPgP9PSymyf6ewdmmT1Jsen5VhvdkrzXlDPdgyss7
   6yFnO5zQzaO22yrZwz5ewnKCTqtutxwKfyAsDbX7as/zAV6DuTeb8EaYB
   WtuXG38W/e+5S9OgtE/ugnBQ53IA3MuaMm84sdyfB/K3AnsaNHeQAzstA
   JQlnQY8E6s5Yq7DnsY0Me8ZS4UCnQXt+mG9U7+Jsv9X/HusSz6L/afr/i
   N9VcEnByo4j32bQIh2rsVUzoDnOkBfWS1bN4avSiTLfiZOvqqPL3Clwbr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="247208532"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="247208532"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 02:57:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="481712993"
Received: from ylian16-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.16.100])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 02:57:19 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Yong Wu <yong.wu@mediatek.com>
Cc:     David Airlie <airlied@linux.ie>, Liviu Dudau <liviu.dudau@arm.com>,
        dri-devel@lists.freedesktop.org,
        Sebastian Reichel <sre@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Joerg Roedel <joro@8bytes.org>,
        James Wang <james.qian.wang@arm.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-mediatek@lists.infradead.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        srv_heupstream@mediatek.com, Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] component: Add common helpers for compare/release
 functions
In-Reply-To: <YfRtGF3v+BwH5RkG@phenom.ffwll.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220128081101.27837-1-yong.wu@mediatek.com>
 <YfRtGF3v+BwH5RkG@phenom.ffwll.local>
Date:   Mon, 31 Jan 2022 12:57:16 +0200
Message-ID: <878ruww4tv.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Fri, Jan 28, 2022 at 04:11:01PM +0800, Yong Wu wrote:
>> The component requires the compare/release functions, there are so many
>> copy in current kernel. Just define three common helpers for them.
>> No functional change.
>> 
>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>> ---
>> Base on v5.17-rc1
>> ---
>>  .../gpu/drm/arm/display/komeda/komeda_drv.c    |  5 -----
>>  drivers/gpu/drm/arm/hdlcd_drv.c                |  7 +------
>>  drivers/gpu/drm/armada/armada_drv.c            |  5 -----
>>  drivers/gpu/drm/drm_of.c                       |  8 +-------
>>  drivers/gpu/drm/etnaviv/etnaviv_drv.c          |  7 -------
>>  drivers/gpu/drm/exynos/exynos_drm_drv.c        |  5 -----
>>  .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c    |  5 -----
>>  drivers/gpu/drm/imx/imx-drm-core.c             |  4 ++--
>>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c      |  5 -----
>>  drivers/gpu/drm/mcde/mcde_drv.c                |  7 +------
>>  drivers/gpu/drm/mediatek/mtk_drm_drv.c         |  5 -----
>>  drivers/gpu/drm/meson/meson_drv.c              |  8 --------
>>  drivers/gpu/drm/msm/msm_drv.c                  |  9 ---------
>>  drivers/gpu/drm/omapdrm/dss/dss.c              |  8 +-------
>>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c    |  5 -----
>>  drivers/gpu/drm/sti/sti_drv.c                  |  5 -----
>>  drivers/gpu/drm/sun4i/sun4i_drv.c              |  9 ---------
>>  drivers/gpu/drm/vc4/vc4_drv.c                  |  5 -----
>>  drivers/iommu/mtk_iommu.h                      | 10 ----------
>>  drivers/power/supply/ab8500_charger.c          |  8 +-------
>>  drivers/video/fbdev/omap2/omapfb/dss/dss.c     |  8 +-------
>>  include/linux/component.h                      | 18 ++++++++++++++++++
>>  sound/soc/codecs/wcd938x.c                     | 16 ++--------------
>
> Seems like a neat idea. Please add kerneldoc for the new functions you're
> adding (bonus point for an example in there) and make sure it all renders
> correctly in
>
> $ make htmldoc
>
> Also please split up the patch series per-driver and add the maintainers
> to each patches' Cc: list. With that I think this should be ready for
> merging.

Aren't the function names perhaps a bit short and generic for the global
namespace though? If you encounter compare_of, release_of, or
compare_dev in code, component.h is not where you'd expect to find them.

BR,
Jani.


>> diff --git a/include/linux/component.h b/include/linux/component.h
>> index 16de18f473d7..5a7468ea827c 100644
>> --- a/include/linux/component.h
>> +++ b/include/linux/component.h
>> @@ -2,6 +2,8 @@
>>  #ifndef COMPONENT_H
>>  #define COMPONENT_H
>>  
>> +#include <linux/device.h>
>> +#include <linux/of.h>
>>  #include <linux/stddef.h>
>>  
>>  
>> @@ -82,6 +84,22 @@ struct component_master_ops {
>>  	void (*unbind)(struct device *master);
>>  };
>>  
>> +/* A set common helpers for compare/release functions */
>> +static inline int compare_of(struct device *dev, void *data)
>> +{
>> +	return dev->of_node == data;
>> +}
>> +
>> +static inline void release_of(struct device *dev, void *data)
>> +{
>> +	of_node_put(data);
>> +}
>> +
>> +static inline int compare_dev(struct device *dev, void *data)
>> +{
>> +	return dev == data;
>> +}
>> +
>>  void component_master_del(struct device *,
>>  	const struct component_master_ops *);
>>  

-- 
Jani Nikula, Intel Open Source Graphics Center
