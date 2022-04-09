Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F454FAA00
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 19:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242936AbiDIR5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 13:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238721AbiDIR5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 13:57:23 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D7F1704E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 10:55:12 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5ae90c.dynamic.kabel-deutschland.de [95.90.233.12])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 929A161EA1928;
        Sat,  9 Apr 2022 19:55:09 +0200 (CEST)
Message-ID: <67f42821-34ad-cee6-98fb-7086599c4c0f@molgen.mpg.de>
Date:   Sat, 9 Apr 2022 19:55:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] soc: nuvoton: Add SoC info driver for WPCM450
Content-Language: en-US
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Cc:     openbmc@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Joel Stanley <joel@jms.id.au>
References: <20220409173319.2491196-1-j.neuschaefer@gmx.net>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220409173319.2491196-1-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jonathan,


Thank you for your patch.

Am 09.04.22 um 19:33 schrieb Jonathan Neuschäfer:
> Add a SoC information driver for Nuvoton WPCM450 SoCs. It provides
> information such as the SoC revision.

Maybe add an example command, how to read the model and revision.

> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> ---
> 
> v2:
> - Add R-b tag
> - rebase on 5.18-rc1
> 
> v1:
> - https://lore.kernel.org/lkml/20220129143316.2321460-1-j.neuschaefer@gmx.net/
> ---
>   drivers/soc/Kconfig               |  1 +
>   drivers/soc/Makefile              |  1 +
>   drivers/soc/nuvoton/Kconfig       | 11 ++++
>   drivers/soc/nuvoton/Makefile      |  2 +
>   drivers/soc/nuvoton/wpcm450-soc.c | 90 +++++++++++++++++++++++++++++++
>   5 files changed, 105 insertions(+)
>   create mode 100644 drivers/soc/nuvoton/Kconfig
>   create mode 100644 drivers/soc/nuvoton/Makefile
>   create mode 100644 drivers/soc/nuvoton/wpcm450-soc.c
> 
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index c5aae42673d3b..42a5e0be77f3d 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -14,6 +14,7 @@ source "drivers/soc/ixp4xx/Kconfig"
>   source "drivers/soc/litex/Kconfig"
>   source "drivers/soc/mediatek/Kconfig"
>   source "drivers/soc/microchip/Kconfig"
> +source "drivers/soc/nuvoton/Kconfig"
>   source "drivers/soc/qcom/Kconfig"
>   source "drivers/soc/renesas/Kconfig"
>   source "drivers/soc/rockchip/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 904eec2a78713..3239fc49eeb27 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_SOC_XWAY)		+= lantiq/
>   obj-$(CONFIG_LITEX_SOC_CONTROLLER) += litex/
>   obj-y				+= mediatek/
>   obj-y				+= microchip/
> +obj-y				+= nuvoton/
>   obj-y				+= amlogic/
>   obj-y				+= qcom/
>   obj-y				+= renesas/
> diff --git a/drivers/soc/nuvoton/Kconfig b/drivers/soc/nuvoton/Kconfig
> new file mode 100644
> index 0000000000000..50166f37096b7
> --- /dev/null
> +++ b/drivers/soc/nuvoton/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +menuconfig WPCM450_SOC
> +	bool "Nuvoton WPCM450 SoC driver"
> +	default y if ARCH_WPCM450
> +	select SOC_BUS
> +	help
> +	  Say Y here to compile the SoC information driver for Nuvoton
> +	  WPCM450 SoCs.
> +
> +	  This driver provides information such as the SoC model and
> +	  revision.
> diff --git a/drivers/soc/nuvoton/Makefile b/drivers/soc/nuvoton/Makefile
> new file mode 100644
> index 0000000000000..e30317b4e8290
> --- /dev/null
> +++ b/drivers/soc/nuvoton/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_WPCM450_SOC)	+= wpcm450-soc.o
> diff --git a/drivers/soc/nuvoton/wpcm450-soc.c b/drivers/soc/nuvoton/wpcm450-soc.c
> new file mode 100644
> index 0000000000000..8bad63e1f7a80
> --- /dev/null
> +++ b/drivers/soc/nuvoton/wpcm450-soc.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Nuvoton WPCM450 SoC Identification
> + *
> + * Copyright (C) 2022 Jonathan Neuschäfer
> + */
> +
> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/sys_soc.h>
> +#include <linux/slab.h>
> +
> +#define GCR_PDID	0
> +#define PDID_CHIP(x)	((x) & 0x00ffffff)
> +#define CHIP_WPCM450	0x926450
> +#define PDID_REV(x)	((x) >> 24)
> +
> +struct revision {
> +	u8 number;

Can this be just be `unsigned int`s

> +	const char *name;
> +};
> +
> +const struct revision revisions[] __initconst = {
> +	{ 0x00, "Z1" },
> +	{ 0x03, "Z2" },
> +	{ 0x04, "Z21" },
> +	{ 0x08, "A1" },
> +	{ 0x09, "A2" },
> +	{ 0x0a, "A3" },
> +	{}
> +};
> +
> +static const char * __init get_revision(u8 rev)
> +{
> +	int i;

I’d do `unsigned int`, though it does not make a difference in the end 
result.

> +
> +	for (i = 0; revisions[i].name; i++)
> +		if (revisions[i].number == rev)
> +			return revisions[i].name;
> +	return NULL;
> +}
> +
> +static int __init wpcm450_soc_init(void)
> +{
> +	struct soc_device_attribute *attr;
> +	struct soc_device *soc;
> +	const char *revision;
> +	struct regmap *gcr;
> +	u32 pdid;
> +	int ret;
> +
> +	if (!of_machine_is_compatible("nuvoton,wpcm450"))
> +		return 0;
> +
> +	gcr = syscon_regmap_lookup_by_compatible("nuvoton,wpcm450-gcr");
> +	if (IS_ERR(gcr))
> +		return PTR_ERR(gcr);
> +	ret = regmap_read(gcr, GCR_PDID, &pdid);
> +	if (ret)
> +		return ret;
> +
> +	if (PDID_CHIP(pdid) != CHIP_WPCM450) {
> +		pr_warn("Unknown chip ID in GCR.PDID: 0x%06x\n", PDID_CHIP(pdid));
> +		return -ENODEV;
> +	}
> +
> +	revision = get_revision(PDID_REV(pdid));

The signature of `get_revision()` is u8, but you pass u32, if I am not 
mistaken.

> +	if (!revision) {
> +		pr_warn("Unknown chip revision in GCR.PDID: 0x%02x\n", PDID_REV(pdid));
> +		return -ENODEV;
> +	}
> +
> +	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
> +	if (!attr)
> +		return -ENOMEM;
> +
> +	attr->family = "Nuvoton NPCM";
> +	attr->soc_id = "WPCM450";
> +	attr->revision = revision;
> +	soc = soc_device_register(attr);
> +	if (IS_ERR(soc)) {
> +		kfree(attr);
> +		pr_warn("Could not register SoC device\n");
> +		return PTR_ERR(soc);
> +	}
> +
> +	return 0;
> +}
> +device_initcall(wpcm450_soc_init);
> --
> 2.35.1
> 

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
