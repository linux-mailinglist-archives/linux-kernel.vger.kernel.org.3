Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482DF4A38DD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 21:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356069AbiA3UGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 15:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiA3UGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 15:06:04 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A768C061714;
        Sun, 30 Jan 2022 12:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=MowiDE8bpmM9qf7usod++nbiOO8GHb0E9NpRkxe8e/0=; b=NWjEDOcncq8BhlxBCMr4zo7mRs
        Y7SImgi2DdDjOPj7QcO7zXsFtiUbz0LO38NK31C8XW6NPEMLf4RRJCb2h7oSGyfQ5WGKQk2jZmanm
        Nqmz4m9IYOjGzCeG66jUgDjj/OoXdMpD216ub1y3NMmexJL7Hcs2eaDqpoFCsPnSUEDH+NVt+RwM0
        X90wXK1U3EOG25AENKqi1wT9gd85yiz1iRSYvIisFo4z99wyiHXyY7hbEr3/sTsZ/MhZ57efCN+MV
        f1jduW8tWkzLciayM3FYY7XVjb9dKdbmuJrwtIidV+naRjX95OQILW0wCef2jyu5szzILn1NWRKeJ
        4bl8IBxg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEGS2-005He6-L1; Sun, 30 Jan 2022 20:05:31 +0000
Message-ID: <26664eb5-59a2-d8c0-156b-f6a58538f063@infradead.org>
Date:   Sun, 30 Jan 2022 12:05:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/1] drm/lsdc: add drm driver for loongson display
 controller
Content-Language: en-US
To:     Sui Jingfeng <15330273260@189.cn>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20220130193723.2923-1-15330273260@189.cn>
 <20220130193723.2923-2-15330273260@189.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220130193723.2923-2-15330273260@189.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The Kconfig text is looking good. Just one minor nit below:

On 1/30/22 11:37, Sui Jingfeng wrote:
> diff --git a/drivers/gpu/drm/lsdc/Kconfig b/drivers/gpu/drm/lsdc/Kconfig
> new file mode 100644
> index 000000000000..8c908787b4aa
> --- /dev/null
> +++ b/drivers/gpu/drm/lsdc/Kconfig
> @@ -0,0 +1,38 @@
> +config DRM_LSDC
> +	tristate "DRM Support for loongson's display controller"
> +	depends on DRM && PCI
> +	depends on MACH_LOONGSON64 || LOONGARCH || MIPS || COMPILE_TEST
> +	select OF
> +	select CMA if HAVE_DMA_CONTIGUOUS
> +	select DMA_CMA if HAVE_DMA_CONTIGUOUS
> +	select DRM_KMS_HELPER
> +	select DRM_KMS_FB_HELPER
> +	select DRM_GEM_CMA_HELPER
> +	select VIDEOMODE_HELPERS
> +	select BACKLIGHT_PWM if CPU_LOONGSON2K
> +	select I2C_GPIO if CPU_LOONGSON2K
> +	select I2C_LS2X if CPU_LOONGSON2K
> +	default m
> +	help
> +	  This is a KMS driver for the display controller in the LS7A1000
> +	  bridge chip and LS2K1000 SoC. The display controller has two
> +	  display pipes and it is a PCI device.
> +	  When using this driver on LS2K1000/LS2K0500 SoC, its framebuffer
> +	  is located at system memory.
> +	  If "M" is selected, the module will be called lsdc.
> +
> +	  If in doubt, say "Y".
> +
> +config DRM_LSDC_VRAM_DRIVER
> +	bool "vram helper based device driver support"
> +	depends on DRM_LSDC
> +	select DRM_VRAM_HELPER
> +	default y
> +	help
> +	  When using this driver on LS7A1000 + LS3A3000/LS3A4000/LS3A5000
> +	  platform, the LS7A1000 bridge chip has dedicated video RAM. Using
> +	  "lsdc.use_vram_helper=1" in the kernel command line will enable
> +	  this driver mode and then the framebuffer will located at the

	                                            will be located at the

> +	  VRAM at the price of losing PRIME support.

thanks.
-- 
~Randy
