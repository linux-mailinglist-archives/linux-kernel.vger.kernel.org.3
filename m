Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EB5599CFE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349296AbiHSNiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348474AbiHSNiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:38:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C82A3342F;
        Fri, 19 Aug 2022 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660916326; x=1692452326;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WbPkOUdZh9ryRN6YS4sq2xkqxU3AQsRMWqp5gXa18DY=;
  b=axauOszOvQjJlaOy/unK7RbB2GW/V6GoLpG/lNi1BsOT0+8+GBknKIPN
   rH4ouuhkUg2dxCNFVJkdedvtqt/Yeq97MoSkkjWGHTEvHGdc8DEqbkp1G
   3Ap8PVi1mwRE2/dAwtKUVITYPomtw04hLF7Kuj0TWyVckeJdAQkctPC6I
   pYEsYTGUMKcgrInXy2e6+2X2CbXf7+6V3vy2JosCfcnqL7iKT9lD1UQLh
   5LMV2z9oobBsg11gB6y5xv8ZjDFolyrGAD/nPjrc8gmndbQN/MxErWuOV
   G39QS47+XNUhz/txXZHpAQZsDh32l3u2WtA76izTJ2fbBr4jbUzccwMzt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="354751558"
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="354751558"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 06:38:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="584662329"
Received: from mylly.fi.intel.com (HELO [10.237.72.180]) ([10.237.72.180])
  by orsmga006.jf.intel.com with ESMTP; 19 Aug 2022 06:38:42 -0700
Message-ID: <edecb3a9-e2d4-41a1-1d06-b3a30a9bac60@linux.intel.com>
Date:   Fri, 19 Aug 2022 16:38:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.1.2
Subject: Re: [RFC v4 06/10] pwm: dwc: split pci out of core driver
Content-Language: en-US
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
 <20220816211454.237751-7-ben.dooks@sifive.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20220816211454.237751-7-ben.dooks@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 8/17/22 00:14, Ben Dooks wrote:
> Moving towards adding non-pci support for the driver, move the pci
> parts out of the core into their own module. This is partly due to
> the module_driver() code only being allowed once in a module and also
> to avoid a number of #ifdef if we build a single file in a system
> without pci support.
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---

I quickly tested this on Intel Elkhart and didn't notice any regression. 
A few comments below.

>   drivers/pwm/Kconfig       |  14 +++-
>   drivers/pwm/Makefile      |   1 +
>   drivers/pwm/pwm-dwc-pci.c | 133 ++++++++++++++++++++++++++++++++
>   drivers/pwm/pwm-dwc.c     | 158 +-------------------------------------
>   drivers/pwm/pwm-dwc.h     |  58 ++++++++++++++
>   5 files changed, 207 insertions(+), 157 deletions(-)
>   create mode 100644 drivers/pwm/pwm-dwc-pci.c
>   create mode 100644 drivers/pwm/pwm-dwc.h
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 3f3c53af4a56..a9f1c554db2b 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -175,15 +175,23 @@ config PWM_CROS_EC
>   	  Controller.
>   
>   config PWM_DWC
> -	tristate "DesignWare PWM Controller"
> -	depends on PCI || COMPILE_TEST
> +	tristate "DesignWare PWM Controller core"
>   	depends on HAS_IOMEM
>   	help
> -	  PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
> +	  PWM driver for Synopsys DWC PWM Controller.
>   
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called pwm-dwc.
>   
> +config PWM_DWC_PCI
> +	tristate "DesignWare PWM Controller core"

Same text as core part has. How about "DesignWare PWM Controller PCI 
driver"?

> +	depends on PWM_DWC && HAS_IOMEM && PCI
> +	help
> +	  PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-dwc-pci.
> +
>   config PWM_EP93XX
>   	tristate "Cirrus Logic EP93xx PWM support"
>   	depends on ARCH_EP93XX || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 7bf1a29f02b8..a70d36623129 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
>   obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
>   obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
>   obj-$(CONFIG_PWM_DWC)		+= pwm-dwc.o
> +obj-$(CONFIG_PWM_DWC_PCI)	+= pwm-dwc-pci.o
>   obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
>   obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
>   obj-$(CONFIG_PWM_HIBVT)		+= pwm-hibvt.o
> diff --git a/drivers/pwm/pwm-dwc-pci.c b/drivers/pwm/pwm-dwc-pci.c
> new file mode 100644
> index 000000000000..2213d0e7f3c8
> --- /dev/null
> +++ b/drivers/pwm/pwm-dwc-pci.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DesignWare PWM Controller driver (PCI part)
> + *
> + * Copyright (C) 2018-2020 Intel Corporation
> + *
> + * Author: Felipe Balbi (Intel)
> + * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> + * Author: Raymond Tan <raymond.tan@intel.com>
> + *
> + * Limitations:
> + * - The hardware cannot generate a 0 % or 100 % duty cycle. Both high and low
> + *   periods are one or more input clock periods long.
> + */
> +

I think this is more common limitation rather than PCI part.

> --- a/drivers/pwm/pwm-dwc.c
> +++ b/drivers/pwm/pwm-dwc.c
> @@ -1,16 +1,12 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * DesignWare PWM Controller driver
> + * DesignWare PWM Controller driver core
>    *
>    * Copyright (C) 2018-2020 Intel Corporation
>    *
>    * Author: Felipe Balbi (Intel)
>    * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>    * Author: Raymond Tan <raymond.tan@intel.com>
> - *
> - * Limitations:
> - * - The hardware cannot generate a 0 % or 100 % duty cycle. Both high and low
> - *   periods are one or more input clock periods long.
>    */

Relates to previous comment, is there reason why this limitation is 
removed from the core part?

> --- /dev/null
> +++ b/drivers/pwm/pwm-dwc.h
> +#define DWC_CLK_PERIOD_NS	10

Perhaps this addition can be removed if patch 7/10 goes before this 
patch? It's anyway specific to PCI part only.
