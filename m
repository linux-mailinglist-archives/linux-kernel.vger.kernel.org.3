Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8CC4A34B0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 07:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354239AbiA3G2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 01:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbiA3G2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 01:28:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514E1C061714;
        Sat, 29 Jan 2022 22:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=hbegQiqCRQ0s45eKAn6OzrlJwshqG8ZUtRw1/WsvnxE=; b=QBwQcb+YAGcLw3iBLr/zC9kkBZ
        YrpflwePJnc3qN5HyKDnwIpa/8jO2n9cQOrON2TtDwJhwbjgRhqaLMhly3lLCdfEDpay17oP3Wk7x
        h1V3EVTx+XuDOljoPK8ljQqhCDHE0kUiyfmP8Ks9li3ytBwsFkvlMVFJVMw8ZZGBx3EngwkTDOK5B
        kfis5hM6c52BURRqwfJi1qwQnGP1oWMDIDjYot/3/aBJOYU6QRIqFUxzFTXgHcb7pvzUCDDIjcgoA
        t3fMmG3cEamlRvZ1Q4E0X+2XXKedINZWgJT9ccPM+nLets3PcOPxiMagiBOOtQmWnSN+wrQXjH9vB
        nlsZqmog==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nE3gF-008Bq0-Q4; Sun, 30 Jan 2022 06:27:20 +0000
Message-ID: <687c2d76-ecfd-f3a4-f9b0-8c0178705cdf@infradead.org>
Date:   Sat, 29 Jan 2022 22:27:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/1] drm/lsdc: add drm driver for loongson display
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
References: <20220130060412.12100-1-15330273260@189.cn>
 <20220130060412.12100-2-15330273260@189.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220130060412.12100-2-15330273260@189.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 1/29/22 22:04, Sui Jingfeng wrote:
> diff --git a/drivers/gpu/drm/lsdc/Kconfig b/drivers/gpu/drm/lsdc/Kconfig
> new file mode 100644
> index 000000000000..f470892ddf60
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
> +	  bridge chip and LS2K1000 SoC. The display controller have two

	                                                       has two

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
> +	  platform, the LS7A1000 bridge chip have dedicated video RAM.

	                                     has

> +	  Pass lsdc.use_vram_helper = 1 to the kernel cmd line will enable

	  Using "lsdc.use_vram_helper=1" in the kernel command line will enable

(No spaces allowed in the kernel command line.)

> +	  this driver mode and then the framebuffer will located at the
> +	  VRAM at the price of losing PRIME support.

-- 
~Randy
