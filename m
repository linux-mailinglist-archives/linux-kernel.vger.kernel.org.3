Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA2748790C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347869AbiAGOeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347858AbiAGOeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:34:01 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF891C06173E;
        Fri,  7 Jan 2022 06:34:00 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8838B1F4436E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641566039;
        bh=RldGw44u6+AGmi0efrlIYXk9AL8VfKkwLM4lhnsDUXI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cPIH1x39COm7u9UN9YtQk3OD7h2sjmU4rBEhVRJrW7XnaiAyvz+uI1H/W038yL4M6
         luSZUkBdKz8uItmPWQ26E2T1onNo4MrjjJcpQuKWv8EN6P2tIbdREp4XIZzQUkzu9c
         Sp5kVo/2FfqKP0cWK+jYe+3ktoC+c2zAICAh4TU7YqGOSGaLTHtLmIwPTGqQoKfkzK
         oY0Xgvq7NGNmtgIWNk0vNGNv/06N/hHvNPcF6r3I/04k8FP6kryoRQLCBwTKtmc5co
         DOLZtHiBdxgDwLp+jtf9DwXjEQ6aIFNCxa2Z91HwtvV17qhecSeP/agYLjN3cfWbWL
         Mnn+E+hCx393w==
Subject: Re: [PATCH v21 3/8] soc: mediatek: SVS: introduce MTK SVS engine
To:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>
References: <20220107095200.4389-1-roger.lu@mediatek.com>
 <20220107095200.4389-4-roger.lu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <63d8884d-d02d-53f9-8524-4a074ca5bfea@collabora.com>
Date:   Fri, 7 Jan 2022 15:33:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220107095200.4389-4-roger.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/01/22 10:51, Roger Lu ha scritto:
> The Smart Voltage Scaling(SVS) engine is a piece of hardware
> which calculates suitable SVS bank voltages to OPP voltage table.
> Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
> when receiving OPP_EVENT_ADJUST_VOLTAGE.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>   drivers/soc/mediatek/Kconfig   |   10 +
>   drivers/soc/mediatek/Makefile  |    1 +
>   drivers/soc/mediatek/mtk-svs.c | 1446 ++++++++++++++++++++++++++++++++
>   3 files changed, 1457 insertions(+)
>   create mode 100644 drivers/soc/mediatek/mtk-svs.c
> 
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index fdd8bc08569e..3c3eedea35f7 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -73,4 +73,14 @@ config MTK_MMSYS
>   	  Say yes here to add support for the MediaTek Multimedia
>   	  Subsystem (MMSYS).
>   
> +config MTK_SVS
> +	tristate "MediaTek Smart Voltage Scaling(SVS)"
> +	depends on MTK_EFUSE && NVMEM
> +	help
> +	  The Smart Voltage Scaling(SVS) engine is a piece of hardware
> +	  which has several controllers(banks) for calculating suitable
> +	  voltage to different power domains(CPU/GPU/CCI) according to
> +	  chip process corner, temperatures and other factors. Then DVFS
> +	  driver could apply SVS bank voltage to PMIC/Buck.
> +
>   endmenu
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index 90270f8114ed..0e9e703c931a 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
>   obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) += mtk-pm-domains.o
>   obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
>   obj-$(CONFIG_MTK_MMSYS) += mtk-mutex.o
> +obj-$(CONFIG_MTK_SVS) += mtk-svs.o
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> new file mode 100644
> index 000000000000..fc7e2ee44a92
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -0,0 +1,1446 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020 MediaTek Inc.
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/kthread.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_opp.h>
> +#include <linux/pm_qos.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +/* svs bank 1-line sw id */
> +#define SVSB_CPU_LITTLE			BIT(0)
> +#define SVSB_CPU_BIG			BIT(1)
> +#define SVSB_CCI			BIT(2)
> +#define SVSB_GPU			BIT(3)
> +
> +/* svs bank mode support */
> +#define SVSB_MODE_ALL_DISABLE		0
> +#define SVSB_MODE_INIT01		BIT(1)
> +#define SVSB_MODE_INIT02		BIT(2)
> +
> +/* svs bank volt flags */
> +#define SVSB_INIT01_PD_REQ		BIT(0)
> +#define SVSB_INIT01_VOLT_IGNORE		BIT(1)
> +#define SVSB_INIT01_VOLT_INC_ONLY	BIT(2)
> +
> +/* svs bank common setting */
> +#define MAX_OPP_ENTRIES			16
> +#define SVSB_DC_SIGNED_BIT		BIT(15)
> +#define SVSB_DET_CLK_EN			BIT(31)
> +#define SVSB_DET_MAX			0xffff
> +#define SVSB_DET_WINDOW			0xa28
> +#define SVSB_DTHI			0x1
> +#define SVSB_DTLO			0xfe
> +#define SVSB_EN_INIT01			0x1
> +#define SVSB_EN_INIT02			0x5
> +#define SVSB_EN_MASK			0x7
> +#define SVSB_EN_OFF			0x0
> +#define SVSB_INTEN_INIT0x		0x00005f01
> +#define SVSB_INTSTS_CLEAN		0x00ffffff
> +#define SVSB_INTSTS_COMPLETE		0x1
> +#define SVSB_RUNCONFIG_DEFAULT		0x80000000
> +
> +static DEFINE_SPINLOCK(svs_lock);

snip....


> +
> +struct svs_platform_data {
> +	char *name;
> +	struct svs_bank *banks;
> +	bool (*efuse_parsing)(struct svs_platform *svsp);
> +	unsigned long irqflags;
> +	const u32 *regs;
> +	u32 bank_max;
> +	int (*probe)(struct svs_platform *svsp);
> +};
> +

Please move the definition of struct svs_platform_data at the beginning of
the file for increased readability.

With that done,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
