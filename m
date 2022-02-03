Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B374A87F4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351381AbiBCPrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:47:42 -0500
Received: from ptr.189.cn ([183.61.185.101]:11377 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351929AbiBCPrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:47:33 -0500
HMM_SOURCE_IP: 10.64.8.31:39466.934777394
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id DCD1E1001F1;
        Thu,  3 Feb 2022 23:47:30 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-b7fbf7d79-bwdqx with ESMTP id 028d37242dba4320bff33254090a6948 for maxime@cerno.tech;
        Thu, 03 Feb 2022 23:47:31 CST
X-Transaction-ID: 028d37242dba4320bff33254090a6948
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <57805e19-285a-76d3-16e3-09a3eb7a9540@189.cn>
Date:   Thu, 3 Feb 2022 23:47:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 1/3] drm/lsdc: add drm driver for loongson display
 controller
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
        suijingfeng <suijingfeng@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Randy Dunlap <rdunlap@infradead.org>
References: <20220203082546.3099-1-15330273260@189.cn>
 <20220203082546.3099-2-15330273260@189.cn>
 <20220203085851.yqstkfgt4dz7rcnw@houat>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <20220203085851.yqstkfgt4dz7rcnw@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/2/3 16:58, Maxime Ripard wrote:
>> diff --git a/drivers/gpu/drm/lsdc/Kconfig b/drivers/gpu/drm/lsdc/Kconfig
>> new file mode 100644
>> index 000000000000..7ed1b0fdbe1b
>> --- /dev/null
>> +++ b/drivers/gpu/drm/lsdc/Kconfig
>> @@ -0,0 +1,38 @@
>> +config DRM_LSDC
>> +	tristate "DRM Support for loongson's display controller"
>> +	depends on DRM && PCI
>> +	depends on MACH_LOONGSON64 || LOONGARCH || MIPS || COMPILE_TEST
>> +	select OF
>> +	select CMA if HAVE_DMA_CONTIGUOUS
>> +	select DMA_CMA if HAVE_DMA_CONTIGUOUS
>> +	select DRM_KMS_HELPER
>> +	select DRM_KMS_FB_HELPER
>> +	select DRM_GEM_CMA_HELPER
>> +	select VIDEOMODE_HELPERS
>> +	select BACKLIGHT_PWM if CPU_LOONGSON2K
>> +	select I2C_GPIO if CPU_LOONGSON2K
>> +	select I2C_LS2X if CPU_LOONGSON2K
>> +	default m
>> +	help
>> +	  This is a KMS driver for the display controller in the LS7A1000
>> +	  bridge chip and LS2K1000 SoC. The display controller has two
>> +	  display pipes and it is a PCI device.
>> +	  When using this driver on LS2K1000/LS2K0500 SoC, its framebuffer
>> +	  is located at system memory.
>> +	  If "M" is selected, the module will be called lsdc.
>> +
>> +	  If in doubt, say "Y".
>> +
>> +config DRM_LSDC_VRAM_DRIVER
>> +	bool "vram helper based device driver support"
>> +	depends on DRM_LSDC
>> +	select DRM_VRAM_HELPER
>> +	default y
>> +	help
>> +	  When using this driver on LS7A1000 + LS3A3000/LS3A4000/LS3A5000
>> +	  platform, the LS7A1000 bridge chip has dedicated video RAM. Using
>> +	  "lsdc.use_vram_helper=1" in the kernel command line will enable
>> +	  this driver mode and then the framebuffer will be located at the
>> +	  VRAM at the price of losing PRIME support.
>> +
>> +	  If in doubt, say "Y".
> This doesn't sound right. The driver should make the proper decision
> depending on the platform, not the user or the distribution.

The LS7A1000 north bridge chip has dedicated video RAM, but the DC in LS7A1000
can also scanout from the system memory directly like a display controller in a
SoC does. In fact, this display controller is envolved from early product of
Loongson 2H SoC. This driver still works even if the downstream PC board
manufacturer doesn't solder a video RAM on the mother board.

The lsdc_should_vram_helper_based() function in lsdc_drv.c will examine
if the DC device node contain a use_vram_helper property at driver loading time.
If there is no use_vram_helper property, CMA helper based DRM driver will be used.
Doing this way allow the user using "lsdc.use_vram_helper=0" override the default
behavior even through there is a "use_vram_helper;" property in the DTS.

In short, It is intend to let the command line passed from kernel has higher
priority than the device tree. Otherwise the end user can not switch different
driver mode through the kernel command line once the DC device node contain
"use_vram_helper;" property.

This driver's author already made the decision by the time when the patch is
sent out, even through this**may not proper.

The CMA helper based driver will be used by default, if the DC device node contain
"use_vram_helper;" then VRAM based driver will be used. This is my initial intention.


