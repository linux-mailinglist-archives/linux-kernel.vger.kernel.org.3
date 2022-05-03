Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F641518CCE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241716AbiECTGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241711AbiECTGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:06:01 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8843F897
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 12:02:27 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id lxmynCNbVqoKwlxmyn5d1e; Tue, 03 May 2022 21:02:25 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 03 May 2022 21:02:25 +0200
X-ME-IP: 86.243.180.246
Message-ID: <6e8386fe-3b22-6f54-5636-bdc946beab59@wanadoo.fr>
Date:   Tue, 3 May 2022 21:02:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v8 1/2] thermal: Add thermal driver for Sunplus
Content-Language: en-US
References: <cover.1651543731.git.lhjeff911@gmail.com>
 <febcaf8229a33217b4bfb3654d6f0bfe7f55a84d.1651543731.git.lhjeff911@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     krzk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li-hao Kuo <lhjeff911@gmail.com>
In-Reply-To: <febcaf8229a33217b4bfb3654d6f0bfe7f55a84d.1651543731.git.lhjeff911@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

below, some additional nitpick.

CJ

Le 03/05/2022 à 04:13, Li-hao Kuo a écrit :
> Add thermal driver for Sunplus.
> 
> Signed-off-by: Li-hao Kuo <lhjeff911-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> Changes in v8:
>   - Modify yaml file.
>     modify the setting compatible
>   - Change yaml file name.
>   - Modify driver.
>     mosdify and simply the nvmem setting and remove valiable
> 
>   MAINTAINERS                       |   6 ++
>   drivers/thermal/Kconfig           |  10 +++
>   drivers/thermal/Makefile          |   1 +
>   drivers/thermal/sunplus_thermal.c | 135 ++++++++++++++++++++++++++++++++++++++
>   4 files changed, 152 insertions(+)
>   create mode 100644 drivers/thermal/sunplus_thermal.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index edc96cd..82143ff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18896,6 +18896,12 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
>   F:	drivers/spi/spi-sunplus-sp7021.c
>   
> +SUNPLUS THERMAL DRIVER
> +M:	Li-hao Kuo <lhjeff911-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> +L:	linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +S:	Maintained
> +F:	drivers/thermal/sunplus_thermal.c
> +
>   SUNPLUS UART DRIVER
>   M:	Hammer Hsieh <hammerh0314-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>   S:	Maintained
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 0e5cc94..595f507 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -504,4 +504,14 @@ config KHADAS_MCU_FAN_THERMAL
>   	  If you say yes here you get support for the FAN controlled
>   	  by the Microcontroller found on the Khadas VIM boards.
>   
> +config SUNPLUS_THERMAL
> +	tristate "Sunplus thermal drivers"
> +	depends on SOC_SP7021 || COMPILE_TEST
> +	help
> +	  This the Sunplus SP7021 thermal driver, which supports the primitive

Missing word?
This *enables* the... ?

> +	  temperature sensor embedded in Sunplus SP7021 SoC.
> +
> +	  If you have a Sunplus SP7021 platform say Y here and enable this option
> +	  to have support for thermal management
> +
>   endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index f0c36a1..38a76f9 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -61,3 +61,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>   obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>   obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
>   obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
> +obj-$(CONFIG_SUNPLUS_THERMAL)	+= sunplus_thermal.o
> diff --git a/drivers/thermal/sunplus_thermal.c b/drivers/thermal/sunplus_thermal.c
> new file mode 100644
> index 0000000..d4e22fc
> --- /dev/null
> +++ b/drivers/thermal/sunplus_thermal.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Sunplus Inc.
> + * Author: Li-hao Kuo <lhjeff911-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/thermal.h>
> +
> +#define ENABLE_THERMAL		BIT(31)
> +#define SP_THERMAL_MASK		GENMASK(10, 0)
> +
> +#define TEMP_RATE		608
> +#define TEMP_BASE		3500
> +#define TEMP_OTP_BASE		1518
> +
> +#define SP_THERMAL_CTL0_REG	0x0000
> +#define SP_THERMAL_STS0_REG	0x0030
> +
> +/* common data structures */
> +struct sp_thermal_data {
> +	struct thermal_zone_device *pcb_tz;
> +	void __iomem *regs;
> +	int *otp_temp0;
> +};
> +
> +static int sunplus_get_otp_temp_coef(struct sp_thermal_data *sp_data, struct device *dev)
> +{
> +	struct nvmem_cell *cell;
> +	ssize_t otp_l;
> +
> +	cell = nvmem_cell_get(dev, "calib");
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +
> +	sp_data->otp_temp0 = nvmem_cell_read(cell, &otp_l);
> +	nvmem_cell_put(cell);
> +
> +	if (*sp_data->otp_temp0 == 0)
> +		*sp_data->otp_temp0 = TEMP_OTP_BASE;
> +
> +	return 0;
> +}
> +
> +/*
> + * There is a thermal sensor instance for SUNPLUS Soc

I don't know what is the best, but if you want to be consistent, other 
places are about Sunplus, not SUNPLUS.

> + * T_CODE is the ADC of the thermal sensor
> + * T_CODE : 11 digits in total
> + * When remanufacturing, the 35 degree T_CODE will be read and stored in nvcell.
> + * otp_temp0 is the 35 degree T_CODE obtained from nvcell
> + * The function will get 35 degree T_CODE for thermal calibration.
> + * TEMP_RATE is the SUNPLUS thermal temperature slope.

Same here.

> + */
> +
> +static int sp_thermal_get_sensor_temp(void *data, int *temp)
> +{
> +	struct sp_thermal_data *sp_data = data;
> +	int t_code;
> +
> +	t_code = readl(sp_data->regs + SP_THERMAL_STS0_REG);
> +	t_code = FIELD_GET(SP_THERMAL_MASK, t_code);
> +	*temp = ((*sp_data->otp_temp0 - t_code) * 10000 / TEMP_RATE) + TEMP_BASE;
> +	*temp *= 10;
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops sp_of_thermal_ops = {
> +	.get_temp = sp_thermal_get_sensor_temp,
> +};
> +
> +static int sunplus_thermal_probe(struct platform_device *pdev)
> +{
> +	struct sp_thermal_data *sp_data;
> +	int ret;
> +
> +	sp_data = devm_kzalloc(&pdev->dev, sizeof(*sp_data), GFP_KERNEL);
> +	if (!sp_data)
> +		return -ENOMEM;
> +
> +	sp_data->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(sp_data->regs)) {
> +		dev_err(&pdev->dev, "resource get fail\n");
> +		return PTR_ERR(sp_data->regs);
> +	}
> +
> +	writel(ENABLE_THERMAL, sp_data->regs + SP_THERMAL_CTL0_REG);
> +
> +	platform_set_drvdata(pdev, sp_data);
> +	ret = sunplus_get_otp_temp_coef(sp_data, &pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	sp_data->pcb_tz = devm_thermal_zone_of_sensor_register(&pdev->dev,
> +							    0,
> +							    sp_data, &sp_of_thermal_ops);
> +	if (IS_ERR_OR_NULL(sp_data->pcb_tz))

I don't think that devm_thermal_zone_of_sensor_register() can return NULL.

> +		return PTR_ERR(sp_data->pcb_tz);
> +
> +	return ret;
> +}
> +
> +static int sunplus_thermal_remove(struct platform_device *pdev)
> +{
> +	struct sp_thermal_data *sp_data = platform_get_drvdata(pdev);
> +
> +	thermal_zone_device_unregister(sp_data->pcb_tz);
> +	return 0;
> +}
> +
> +static const struct of_device_id of_sunplus_thermal_ids[] = {
> +	{ .compatible = "sunplus,thermal" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, of_sunplus_thermal_ids);
> +
> +static struct platform_driver sunplus_thermal_driver = {
> +	.probe	= sunplus_thermal_probe,
> +	.remove = sunplus_thermal_remove,
> +	.driver	= {
> +		.name	= "sunplus-thermal",
> +		.of_match_table = of_sunplus_thermal_ids,
> +		},

The }, should be aligned on .driver (1 less tabulation)

> +};
> +module_platform_driver(sunplus_thermal_driver);
> +
> +MODULE_AUTHOR("Li-hao Kuo <lhjeff911-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
> +MODULE_DESCRIPTION("Thermal driver for sunplus SoC");

Other places are about Sunplus, not sunplus

> +MODULE_LICENSE("GPL");

