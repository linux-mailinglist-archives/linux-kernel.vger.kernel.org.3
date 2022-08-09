Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6377158D5B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241099AbiHIIwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240092AbiHIIw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:52:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4F0220D5
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:52:27 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l4so13506262wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 01:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=8Ou04ju9WzWPDN0A9A1ViSUt6uT5liKE7OV5Ktj6+Ew=;
        b=ZTSSMGLIszA3cSPcygspeCZshz1kCpapXSGX5tJUCYXOHK4xR+1LN5evv9RI2xFaO5
         5vCSWFQLV1z3j8+WuepqnIZsNNq8EAQnCfDBAdXPjonukS1x+xBmNPjC1WGy8S7yeCWI
         MV/wl5YVn69CwaQFEPROfVkbdTVf1QKMCZUyStfGxAvnGqr7GVuIZINEp98CKMce/xAD
         3JGauh5E6LqcXMoiHANyKSiwGDD5KyFPu0WIQ3IRY6OiKpuyCvulgOKsB9QHPIoAUZ10
         WJ1tG35rudqbL8yMgwwAo9m3m0QXIvd94UIoYDiVKWFlb4c7lBT2aJBAWeeXs3RH2EVS
         N1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=8Ou04ju9WzWPDN0A9A1ViSUt6uT5liKE7OV5Ktj6+Ew=;
        b=CgYMK2IC4Puw7eqkSuyE0c3tXoVcyAapiIOfGiyUTlp6JgCOR1d8No6vNeookwLNRv
         9BgzTXHDMHOZ2KfWcZ1oEGxrvSMrBAF29uOrueARRQQYrycxIIJRY3ueVmt3N66xGo2V
         uaEIu/Y+QoGtKaOABaEZjz2N8uoLbhzZHLnxa1JDUWbxFHfgUf8GCKGpVB5r/40AVzXf
         7MHs1wtxX1AYEhpGpZdFMs2rSqgFREDIdt8loQIYxWqo56hyPcClW2Va/iJ39rQOnFdI
         RS4O9IWvH+m1Ubwde794iTzzO21HZ+AanMcPqaWtaRtw623R/6TX1MvdS4MPX9aEcZ2d
         Ds8Q==
X-Gm-Message-State: ACgBeo1+V6zLSAarB9lUWzA5DDZ6kXq3+ZpzvYxXSA5wqh0R7H+yoq4h
        EHuXj7SRRQWxFkZaTVhjXSDH2Q==
X-Google-Smtp-Source: AA6agR5mcuhtovx41DqwYdsZrPlvGfFXfZp70LDfByyQuh3ivcleUFJA5OuIeJlKYe7jai9QvT2fCw==
X-Received: by 2002:a5d:6988:0:b0:21f:bbc:65f8 with SMTP id g8-20020a5d6988000000b0021f0bbc65f8mr13721179wru.537.1660035145931;
        Tue, 09 Aug 2022 01:52:25 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id bg21-20020a05600c3c9500b003a4efb794d7sm18494010wmb.36.2022.08.09.01.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 01:52:25 -0700 (PDT)
Date:   Tue, 9 Aug 2022 09:52:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org, dmitry.torokhov@gmail.com, lgirdwood@gmail.com,
        cy_huang@richtek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3 2/3] mfd: rt5120: Add Richtek PMIC support
Message-ID: <YvIgR9RBDMp9VJ6B@google.com>
References: <1657780937-20891-1-git-send-email-u0084500@gmail.com>
 <1657780937-20891-3-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657780937-20891-3-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2022, cy_huang wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add Richtek RT5120 PMIC I2C driver.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Since v3:
> - Use a 'dev' variable and dev_err_probe to decrease the LOC in mfd.
> 
> ---
>  drivers/mfd/Kconfig  |  12 +++++
>  drivers/mfd/Makefile |   1 +
>  drivers/mfd/rt5120.c | 121 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 134 insertions(+)
>  create mode 100644 drivers/mfd/rt5120.c

Mostly good, couple of nits.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3b59456..866619c 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1127,6 +1127,18 @@ config MFD_RT5033
>  	  sub-devices like charger, fuel gauge, flash LED, current source,
>  	  LDO and Buck.
>  
> +config MFD_RT5120
> +	tristate "Richtek RT5120 Power Management IC"
> +	depends on I2C
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	help
> +	  The enables support for Richtek RT5120 PMIC. It includes four high
> +	  efficiency buck converters and one LDO voltage regulator. The device
> +	  is targeted at providing the CPU voltage, memory, I/O and peripheral
> +	  power rails in home entertainment devices.
> +
>  config MFD_RC5T583
>  	bool "Ricoh RC5T583 Power Management system device"
>  	depends on I2C=y
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 858cacf..27e8add 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -234,6 +234,7 @@ obj-$(CONFIG_MFD_HI655X_PMIC)   += hi655x-pmic.o
>  obj-$(CONFIG_MFD_DLN2)		+= dln2.o
>  obj-$(CONFIG_MFD_RT4831)	+= rt4831.o
>  obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
> +obj-$(CONFIG_MFD_RT5120)	+= rt5120.o
>  obj-$(CONFIG_MFD_SKY81452)	+= sky81452.o
>  
>  intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
> diff --git a/drivers/mfd/rt5120.c b/drivers/mfd/rt5120.c
> new file mode 100644
> index 00000000..12372fa
> --- /dev/null
> +++ b/drivers/mfd/rt5120.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0+

No Copyright?

> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/regmap.h>
> +
> +#define RT5120_REG_INTENABLE	0x1D
> +#define RT5120_REG_INTSTAT	0x1E
> +#define RT5120_REG_FZCMODE	0x44
> +
> +#define RT5120_INT_HOTDIE	0
> +#define RT5120_INT_PWRKEY_REL	5
> +#define RT5120_INT_PWRKEY_PRESS	6
> +
> +static const struct regmap_range rt5120_rd_yes_ranges[] = {
> +	regmap_reg_range(0x03, 0x13),
> +	regmap_reg_range(0x1c, 0x20),
> +	regmap_reg_range(0x44, 0x44)
> +};
> +
> +static const struct regmap_range rt5120_wr_yes_ranges[] = {
> +	regmap_reg_range(0x06, 0x13),
> +	regmap_reg_range(0x1c, 0x20),
> +	regmap_reg_range(0x44, 0x44)
> +};
> +
> +static const struct regmap_access_table rt5120_rd_table = {
> +	.yes_ranges = rt5120_rd_yes_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(rt5120_rd_yes_ranges),
> +};
> +
> +static const struct regmap_access_table rt5120_wr_table = {
> +	.yes_ranges = rt5120_wr_yes_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(rt5120_wr_yes_ranges),
> +};
> +
> +static const struct regmap_config rt5120_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = RT5120_REG_FZCMODE,
> +
> +	.wr_table = &rt5120_wr_table,
> +	.rd_table = &rt5120_rd_table,
> +};
> +
> +static const struct regmap_irq rt5120_irqs[] = {
> +	REGMAP_IRQ_REG_LINE(RT5120_INT_HOTDIE, 8),
> +	REGMAP_IRQ_REG_LINE(RT5120_INT_PWRKEY_REL, 8),
> +	REGMAP_IRQ_REG_LINE(RT5120_INT_PWRKEY_PRESS, 8)
> +};
> +
> +static const struct regmap_irq_chip rt5120_irq_chip = {
> +	.name = "rt5120-pmic",
> +	.status_base = RT5120_REG_INTSTAT,
> +	.mask_base = RT5120_REG_INTENABLE,
> +	.ack_base = RT5120_REG_INTSTAT,
> +	.mask_invert = true,
> +	.use_ack = true,
> +	.num_regs = 1,
> +	.irqs = rt5120_irqs,
> +	.num_irqs = ARRAY_SIZE(rt5120_irqs),
> +};
> +
> +static const struct resource rt5120_regulator_resources[] = {
> +	DEFINE_RES_IRQ(RT5120_INT_HOTDIE)
> +};
> +
> +static const struct resource rt5120_pwrkey_resources[] = {
> +	DEFINE_RES_IRQ_NAMED(RT5120_INT_PWRKEY_PRESS, "pwrkey-press"),
> +	DEFINE_RES_IRQ_NAMED(RT5120_INT_PWRKEY_REL, "pwrkey-release")
> +};
> +
> +static const struct mfd_cell rt5120_devs[] = {
> +	MFD_CELL_RES("rt5120-regulator", rt5120_regulator_resources),
> +	MFD_CELL_OF("rt5120-pwrkey", rt5120_pwrkey_resources, NULL, 0, 0,
> +		    "richtek,rt5120-pwrkey")

This can be on one line if you want.

> +};
> +
> +static int rt5120_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct regmap *regmap;
> +	struct regmap_irq_chip_data *irq_data;
> +	int ret;
> +
> +	regmap = devm_regmap_init_i2c(i2c, &rt5120_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Failed to init regmap\n");
> +
> +	ret = devm_regmap_add_irq_chip(dev, regmap, i2c->irq, IRQF_ONESHOT, 0,
> +				       &rt5120_irq_chip, &irq_data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add irq chip\n");

"IRQ"

> +	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, rt5120_devs,
> +				    ARRAY_SIZE(rt5120_devs), NULL, 0,
> +				    regmap_irq_get_domain(irq_data));
> +}
> +
> +static const struct of_device_id rt5120_device_match_table[] = {
> +	{ .compatible = "richtek,rt5120" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, rt5120_device_match_table);
> + 
> +static struct i2c_driver rt5120_driver = {
> +	.driver = {
> +		.name = "rt5120",
> +		.of_match_table = rt5120_device_match_table,
> +	},
> +	.probe_new = rt5120_probe,
> +};
> +module_i2c_driver(rt5120_driver);
> +
> +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> +MODULE_DESCRIPTION("Richtek RT5120 I2C driver");
> +MODULE_LICENSE("GPL v2");

-- 
DEPRECATED: Please use lee@kernel.org
