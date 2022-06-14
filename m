Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D87254BCD0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357487AbiFNVcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357441AbiFNVcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:32:33 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7B364C2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:32:29 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d5so6203711plo.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YQwlvrRLpaMgyIIZBdcAoIRZl+hOsdW2okVyMBrchCo=;
        b=Fi7ZN9brnB+dgYQjVX1XmP3R50egKTJ/tEm4PJdmz+at5S5AODBljnNJlAGf72CwcD
         4uw8jO6eRSn2h1WB7IPNRPKE57rFsSu6rmC/v75Yd1A+hDj0ZFEyFkgSmhVno2BEMuJt
         lnOMyu5iXnihBsYrt7+zCmuxfvwz+9ad7O7tqUNLGH97C+dlMuwaoSZvsfR6F+4yCvOY
         AZNfe79RcXBwUGex2SWmYNYZdxzyYASgYVZ97UIi+XzDNXwafdGDn+5XSxL5kMVcz7Gr
         78j26Ty3zbZIFxFfrQK8T8WgQzN0jk2+4ycgtWmqjFYBHEmXnb8nW0kJjD3IASuowiPc
         OQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YQwlvrRLpaMgyIIZBdcAoIRZl+hOsdW2okVyMBrchCo=;
        b=vTH9n+6Vn1pwpNvn/99bm8hUvLFGL78GVRrp2XREzTkg/JUnB8x7F1nyP50VmGcH4Y
         qeaDhdl7qA+wkacLL7Bgs0RFZojN9qYrQqys01wFUst/mufH584j7kLrs99NLhdmbPJJ
         JdfYTGiUpu+chg4MneFpKMQ5sTkEgZ6NZ2ueeE+m1N7YrrhT7ZHTVoTPk8OmWmTXQA5+
         K0MHLd7XTSBzjhrqR61z7ENO3GuDh06nTtCWHNoauCIr3q+sSfTXUt6B468gtYXxQlb7
         7Xxz1nLp95HvFSzwi4LeKoIkMB3jo/4vDGhmi/FpjEF2iA48csxj1FZ8a3fBov80+YKj
         TIhA==
X-Gm-Message-State: AJIora/gCgo2cPagmcsr3C18iDR85/MVNAhxDD89dGgcc7GZmuqsSrxB
        QfKzhjyGWnHsN0B4tFMPyxq4tw==
X-Google-Smtp-Source: AGRyM1vZFeBCV+2MEaUtB5g1aODUGbQyPVdP/UqNqTDXBO0UYkBQC5RBgAHDlNaQpX1kRVywAAOajg==
X-Received: by 2002:a17:90b:2248:b0:1ea:8403:d81c with SMTP id hk8-20020a17090b224800b001ea8403d81cmr6560837pjb.97.1655242348488;
        Tue, 14 Jun 2022 14:32:28 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id s17-20020a17090a5d1100b001e0d4169365sm63262pji.17.2022.06.14.14.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:32:28 -0700 (PDT)
Date:   Tue, 14 Jun 2022 22:32:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 4/5] mfd: sm5703: Add support for SM5703 MFD
Message-ID: <Yqj+aUNLC00Tcu49@google.com>
References: <20220423085319.483524-1-markuss.broks@gmail.com>
 <20220423085319.483524-5-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220423085319.483524-5-markuss.broks@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Apr 2022, Markuss Broks wrote:

> Silicon Mitus SM5703 is a multi-function device, meant to be

Please avoid using the term MFD.

How is the device described in the data-sheet?

What do you mean by "meant to be"?

> used in mobile devices. It has several modules: LDO, BUCK regulators,

Modules or functions?

> charger circuit, flash LED driver, a fuel gauge for monitoring the battery
> and a MUIC USB switcher. The MUIC and fuel gauge parts are separate in that
> they use separate i2c lines to communicate with the device, while charger

"I2C"

> circuit, LED driver and regulators are on the main i2c line the device is
> controlled with.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  MAINTAINERS                |   8 +++
>  drivers/mfd/Kconfig        |  13 +++++
>  drivers/mfd/Makefile       |   1 +
>  drivers/mfd/sm5703.c       |  78 +++++++++++++++++++++++++++
>  include/linux/mfd/sm5703.h | 105 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 205 insertions(+)
>  create mode 100644 drivers/mfd/sm5703.c
>  create mode 100644 include/linux/mfd/sm5703.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6157e706ed02..6125ed1a3be4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18172,6 +18172,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
>  F:	include/linux/srcu*.h
>  F:	kernel/rcu/srcu*.c
>  
> +SM5703 MFD DRIVER
> +M:	Markuss Broks <markuss.broks@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
> +F:	Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
> +F:	drivers/mfd/sm5703.c
> +F:	drivers/regulator/sm5703-regulator.c
> +
>  SMACK SECURITY MODULE
>  M:	Casey Schaufler <casey@schaufler-ca.com>
>  L:	linux-security-module@vger.kernel.org
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3b59456f5545..c13a99ceae99 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1237,6 +1237,19 @@ config MFD_SM501
>  	  interface. The device may be connected by PCI or local bus with
>  	  varying functions enabled.
>  
> +config MFD_SM5703
> +	tristate "Silicon Mitus SM5703 MFD"
> +	depends on I2C
> +	depends on OF
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	help
> +	  This is the core driver for the Silicon Mitus SM5703 multi-function

Please drop the MFD term, as above.

> +	  device. This device is meant to be used in phones and it has numerous

"meant to be"?

> +	  modules, including LED controller, regulators, fuel gauge, MUIC and

Either "an LED controller" or "LED controllers"

Same with "charger circuit" below.

> +	  charger circuit. It also support muxing a serial interface over USB

"supports"

What kind of serial?

> +	  data lines.
> +
>  config MFD_SM501_GPIO
>  	bool "Export GPIO via GPIO layer"
>  	depends on MFD_SM501 && GPIOLIB
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 858cacf659d6..ca8b86736a36 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -275,3 +275,4 @@ rsmu-i2c-objs			:= rsmu_core.o rsmu_i2c.o
>  rsmu-spi-objs			:= rsmu_core.o rsmu_spi.o
>  obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu-i2c.o
>  obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu-spi.o
> +obj-$(CONFIG_MFD_SM5703)	+= sm5703.o
> diff --git a/drivers/mfd/sm5703.c b/drivers/mfd/sm5703.c
> new file mode 100644
> index 000000000000..7f9838149051
> --- /dev/null
> +++ b/drivers/mfd/sm5703.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/sm5703.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +
> +static const struct mfd_cell sm5703_devs[] = {
> +	{ .name = "sm5703-regulator", },
> +};

Where are the rest of the child drivers?

> +static const struct regmap_config sm5703_regmap_config = {
> +	.reg_bits	= 8,
> +	.val_bits	= 8,

Tabbing looks odd.  Just use a space.

> +};
> +
> +static int sm5703_i2c_probe(struct i2c_client *i2c,
> +			    const struct i2c_device_id *id)
> +{
> +	struct sm5703_dev *sm5703;
> +	struct device *dev = &i2c->dev;
> +	unsigned int dev_id;
> +	int ret;
> +
> +	sm5703 = devm_kzalloc(dev, sizeof(*sm5703), GFP_KERNEL);
> +	if (!sm5703)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(i2c, sm5703);
> +	sm5703->dev = dev;
> +
> +	sm5703->regmap = devm_regmap_init_i2c(i2c, &sm5703_regmap_config);
> +	if (IS_ERR(sm5703->regmap))
> +		return dev_err_probe(dev, PTR_ERR(sm5703->regmap),
> +				     "Failed to allocate the register map\n");
> +
> +	sm5703->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(sm5703->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(sm5703->reset_gpio), "Cannot get reset GPIO\n");
> +
> +	gpiod_set_value_cansleep(sm5703->reset_gpio, 1);
> +	msleep(20);
> +
> +	ret = regmap_read(sm5703->regmap, SM5703_DEVICE_ID, &dev_id);
> +	if (ret)
> +		return dev_err_probe(dev, -ENODEV, "Device not found\n");
> +
> +	ret = devm_mfd_add_devices(sm5703->dev, -1, sm5703_devs,

Not -1.  Please use the defines provided.

> +				   ARRAY_SIZE(sm5703_devs), NULL, 0, NULL);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add child devices\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sm5703_of_match[] = {
> +	{ .compatible = "siliconmitus,sm5703", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sm5703_of_match);
> +
> +static struct i2c_driver sm5703_driver = {
> +	.driver = {
> +		.name = "sm5703",
> +		.of_match_table = sm5703_of_match,
> +	},
> +	.probe = sm5703_i2c_probe,
> +};
> +module_i2c_driver(sm5703_driver);
> +
> +MODULE_DESCRIPTION("Silicon Mitus SM5703 multi-function device driver");

There is no such thing as an MFD.

> +MODULE_AUTHOR("Markuss Broks <markuss.broks@gmail.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/sm5703.h b/include/linux/mfd/sm5703.h
> new file mode 100644
> index 000000000000..c62affa0d3f1
> --- /dev/null
> +++ b/include/linux/mfd/sm5703.h
> @@ -0,0 +1,105 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef _SM5703_H
> +#define _SM5703_H
> +
> +struct sm5703_dev {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct gpio_desc *reset_gpio;
> +};
> +
> +// Regulator-related defines

No C++ style comments.

> +#define SM5703_REG_LDO1				0x1A

I'd drop the REG parts from these.

What are these registers called in the data-sheet?

> +#define SM5703_REG_LDO2				0x1B
> +#define SM5703_REG_LDO3				0x1C
> +#define SM5703_LDO_EN				BIT(3)

Some people like to space out the bits to differentiate them from the
register addresses.

> +#define SM5703_LDO_VOLT_MASK			0x7

Please keep the bit length consistent, so 0x07 here if these are Byte
length registers.

> +#define SM5703_BUCK_VOLT_MASK			0x1F
> +#define SM5703_REG_USBLDO12			0x1C
> +#define SM5703_REG_EN_USBLDO1			BIT(6)
> +#define SM5703_REG_EN_USBLDO2			BIT(7)
> +#define SM5703_REG_BUCK				0x1D

Please place these in order.

> +#define SM5703_REG_EN_BUCK			BIT(6)
> +#define SM5703_USBLDO_MICROVOLT			4800000
> +#define SM5703_VBUS_MICROVOLT			5000000
> +
> +// Fuel-Gauge-related defines
> +
> +#define SM5703_FG_REG_DEVICE_ID			0x00
> +#define SM5703_FG_REG_CNTL			0x01
> +#define SM5703_FG_REG_INTFG			0x02
> +#define SM5703_FG_REG_INTFG_MASK		0x03
> +#define SM5703_FG_REG_STATUS			0x04
> +#define SM5703_FG_REG_SOC			0x05
> +#define SM5703_FG_REG_OCV			0x06
> +#define SM5703_FG_REG_VOLTAGE			0x07
> +#define SM5703_FG_REG_CURRENT			0x08
> +#define SM5703_FG_REG_TEMPERATURE		0x09
> +#define SM5703_FG_REG_CURRENT_EST		0x85
> +#define SM5703_FG_REG_FG_OP_STATUS		0x10
> +
> +// Flash LED driver-related defines
> +
> +#define SM5703_FLEDCNTL1			0x14
> +#define SM5703_FLEDCNTL2			0x15
> +#define SM5703_FLEDCNTL3			0x16
> +#define SM5703_FLEDCNTL4			0x17
> +#define SM5703_FLEDCNTL5			0x18
> +#define SM5703_FLEDCNTL6			0x19
> +
> +#define SM5703_FLEDEN_MASK			0x03
> +#define SM5703_FLEDEN_DISABLE			0x00
> +#define SM5703_FLEDEN_MOVIE_MODE		0x01
> +#define SM5703_FLEDEN_FLASH_MODE		0x02
> +#define SM5703_FLEDEN_EXTERNAL			0x03
> +
> +#define SM5703_IFLED_MASK			0x1F
> +#define SM5703_IMLED_MASK			0x1F
> +
> +// Charger-related, IRQ and device ID defines
> +
> +#define SM5703_REG_CNTL				0x0C
> +#define SM5703_VBUSCNTL				0x0D
> +#define SM5703_CHGCNTL1				0x0E
> +#define SM5703_CHGCNTL2				0x0F
> +#define SM5703_CHGCNTL3				0x10
> +#define SM5703_CHGCNTL4				0x11
> +#define SM5703_CHGCNTL5				0x12
> +#define SM5703_CHGCNTL6				0x13
> +#define SM5703_OTGCURRENTCNTL			0x60
> +#define SM5703_Q3LIMITCNTL			0x66
> +#define SM5703_DEVICE_ID			0x1E
> +#define SM5703_OPERATION_MODE			0x07
> +#define SM5703_OPERATION_MODE_MASK		0x07
> +
> +#define SM5703_OPERATION_MODE_SUSPEND		0x00
> +#define SM5703_OPERATION_MODE_CHARGING_OFF	0x04
> +#define SM5703_OPERATION_MODE_CHARGING_ON	0x05
> +#define SM5703_OPERATION_MODE_FLASH_BOOST_MODE	0x06
> +#define SM5703_OPERATION_MODE_USB_OTG_MODE	0x07
> +
> +#define SM5703_BSTOUT				0x0F
> +#define SM5703_BSTOUT_MASK			0x0F
> +#define SM5703_BSTOUT_SHIFT			0
> +
> +#define SM5703_BSTOUT_4P5			0x05
> +#define SM5703_BSTOUT_5P0			0x0A
> +#define SM5703_BSTOUT_5P1			0x0B
> +
> +#define SM5703_IRQ_STATUS1			0x08
> +#define SM5703_IRQ_STATUS2			0x09
> +#define SM5703_IRQ_STATUS3			0x0A
> +#define SM5703_IRQ_STATUS4			0x0B
> +#define SM5703_IRQ_STATUS5			0x6B
> +
> +#define SM5703_STATUS1_OTGFAIL			0x80
> +#define SM5703_STATUS3_DONE			0x08
> +#define SM5703_STATUS3_TOPOFF			0x04
> +#define SM5703_STATUS3_CHGON			0x01
> +#define SM5703_STATUS5_VBUSOVP			0x80
> +#define SM5703_STATUS5_VBUSUVLO			0x40
> +#define SM5703_STATUS5_VBUSOK			0x20
> +
> +#endif

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
