Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA24854D45A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349648AbiFOWO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345119AbiFOWOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:14:20 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CE315FE4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:14:19 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id w29so107224pgl.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AXCSdNdOG+CgFIG88ib23kuKIvvzOLK+/Co0bGDcI+o=;
        b=jPYVmTsdWKg5NMY9ngNRlfmDud5TflXzM52JfxGV2TzRmtX3BaGyrV+3Zp6PGXAn7g
         bFSxv5YacUC9fVhbTWNjBxQjSbTnwDkg4Xio76T342UB4EF0dSadUJ4ru22B7jm3CvMN
         pTRjrEQvJ/BBx9409aavxHLlnIyLU/bYuchwcMd2Q7fx6KZT1xmAma38NO1a918vV37w
         MqoRZDVShJIU1vKMbq+zpjaXm1nQXFmk5MoT+f5MXlgP5yVjPnCAeJ5uXU4a2fZCfhQd
         JYbHhh18xk7XKzlyzCqslZMqpcIImgG/1j0ib6ixl5DRXEp9Ht4IPYBkARfGsD05I1P/
         zeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AXCSdNdOG+CgFIG88ib23kuKIvvzOLK+/Co0bGDcI+o=;
        b=Ry3stnBohX0a7b4zqVTggwGLgS02FNcc5Qll1QAnCClXri45nFaFgv9Htba3SVDpOv
         d9YfElWMMr1ts9NDVsBDr+/FVd2typHa3Pqp8n/tZZzQZaRPVbBV45sqgGc8jdHJykGE
         H2SRvUIDv6689dCjJFUYp+49al33lXJSz7YMZghSFPoLannlDUaiIME0e1BBPHCMfyLA
         Wa8/TpUqZ0IJZ1DBv9rNOfNigh/iELLPMRGzhbysnzFdpc8oc+bWRfDG6Cvhw8i+3VJg
         hOViSKqZS8B/vjYmx58Ph/vywIWpayAcboNPB+7Gm5end2ve32HWLoGvFW/QMTukWT/G
         IVOg==
X-Gm-Message-State: AJIora95TQUgEFwY6Pyq0ZKv3X3GAcxQA48iP/8MU5PiYUFC5FW/ZMuX
        J+PR/B7hahMkKpjhccpjW7dUfw==
X-Google-Smtp-Source: AGRyM1t0vDXZjnqNVhNR6NaKiKCfvtB9Iyx0wWfiRtvikmjxCnNrvxUyS8KyW4itRr/yrTlpPBLrbg==
X-Received: by 2002:a63:5250:0:b0:3fd:b280:2020 with SMTP id s16-20020a635250000000b003fdb2802020mr1683560pgl.184.1655331258592;
        Wed, 15 Jun 2022 15:14:18 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p2-20020a62b802000000b00522af870b5dsm138335pfe.56.2022.06.15.15.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 15:14:18 -0700 (PDT)
Date:   Wed, 15 Jun 2022 23:14:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thu Nguyen <thu@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Subject: Re: [PATCH v8 8/9] mfd: smpro-mfd: Adds Ampere's Altra SMpro MFD
 driver
Message-ID: <YqpZuBjRJhe/Pje7@google.com>
References: <20220422024653.2199489-1-quan@os.amperecomputing.com>
 <20220422024653.2199489-9-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220422024653.2199489-9-quan@os.amperecomputing.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022, Quan Nguyen wrote:

> Adds Multi-function devices driver for SMpro co-processor found on the

Please drop the term MFD and describe the device instead.

> Mt.Jade hardware reference platform with Ampere's Altra processor family.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
> Changes in v8:
>   + None
> 
> Changes in v7:
>   + Smpro-mfd now significant changes in compare with simple-mfd-i2c
>     driver, remove the copyright note about simple-mfd-i2c    [Quan]
>   + Install bus->read/write()  to handle multiple types of bus
>     access.                                                   [Quan]
>   + Update license to MODULE_LICENSE("GPL")                   [Quan]
>   + Add others minor refactor the code                        [Quan]
> 
> Changes in v6:
>   + Update license part to reflect that this driver is clone from
>   simple-mfd-i2c driver [Quan]
> 
> Changes in v5:
>   + Dropped the use of simple-mfd-i2c driver [Quan]
>   + Introduced drivers/mfd/smpro-mfd.c driver to instantiate
>   sub-devices. This is to avoid DT nodes without resource issue [Quan]
>   + Revised commit message [Quan]
> 
> Changes in v4:
>   + Add "depends on I2C" to fix build issue found by kernel test
>   robot [Guenter]
> 
> Changes in v3:
>   + None
> 
> Changes in v2:
>   + Used 'struct of_device_id's .data attribute [Lee Jones]
> 
>  drivers/mfd/Kconfig     |  12 ++++
>  drivers/mfd/Makefile    |   1 +
>  drivers/mfd/smpro-mfd.c | 134 ++++++++++++++++++++++++++++++++++++++++

Please drop the 'mfd' part.  Does 'core' work instead?

>  3 files changed, 147 insertions(+)
>  create mode 100644 drivers/mfd/smpro-mfd.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3b59456f5545..383d0e6cfb91 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -77,6 +77,18 @@ config MFD_AS3711
>  	help
>  	  Support for the AS3711 PMIC from AMS
>  
> +config MFD_SMPRO
> +	tristate "Ampere Computing MFD SMpro core driver"

Drop 'MFD'.

> +	depends on I2C
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	help
> +	  Say yes here to enable SMpro driver support for Ampere's Altra
> +	  processor family.
> +
> +	  Ampere's Altra SMpro exposes an I2C regmap interface that can
> +	  be accessed by child devices.
> +
>  config MFD_AS3722
>  	tristate "ams AS3722 Power Management IC"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 858cacf659d6..36f8981cc4fd 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -266,6 +266,7 @@ obj-$(CONFIG_MFD_QCOM_PM8008)	+= qcom-pm8008.o
>  
>  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
>  obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
> +obj-$(CONFIG_MFD_SMPRO)		+= smpro-mfd.o
>  obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
>  
>  obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
> diff --git a/drivers/mfd/smpro-mfd.c b/drivers/mfd/smpro-mfd.c
> new file mode 100644
> index 000000000000..485c4f89ebd9
> --- /dev/null
> +++ b/drivers/mfd/smpro-mfd.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Ampere Altra Family SMPro MFD - I2C

Drop 'MFD' throughout.

> + * Copyright (c) 2022, Ampere Computing LLC
> + * Author: Quan Nguyen <quan@os.amperecomputing..com>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/mfd/core.h>
> +#include <linux/regmap.h>

Alphabetical.

> +/* Identification Registers */
> +#define MANUFACTURER_ID_REG     0x02
> +#define AMPERE_MANUFACTURER_ID  0xCD3A
> +
> +static int smpro_mfd_write(void *context, const void *data, size_t count)
> +{
> +	struct device *dev = context;
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +	int ret;
> +
> +	ret = i2c_master_send(i2c, data, count);
> +	if (ret == count)
> +		return 0;
> +	else if (ret < 0)
> +		return ret;
> +	else
> +		return -EIO;
> +}
> +
> +static int smpro_mfd_read(void *context, const void *reg, size_t reg_size,
> +			  void *val, size_t val_size)
> +{
> +	struct device *dev = context;
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +	struct i2c_msg xfer[2];
> +	unsigned char buf[2];
> +	int ret;
> +
> +	xfer[0].addr = i2c->addr;
> +	xfer[0].flags = 0;
> +
> +	buf[0] = *(u8 *)reg;
> +	buf[1] = val_size;
> +	xfer[0].len = 2;
> +	xfer[0].buf = buf;
> +
> +	xfer[1].addr = i2c->addr;
> +	xfer[1].flags = I2C_M_RD;
> +	xfer[1].len = val_size;
> +	xfer[1].buf = val;
> +
> +	ret = i2c_transfer(i2c->adapter, xfer, 2);
> +	if (ret == 2)
> +		return 0;
> +	else if (ret < 0)
> +		return ret;
> +	else
> +		return -EIO;
> +}

This looks all too familiar.

I wonder how generic these i2c call-backs actually are.

> +static const struct regmap_bus smpro_regmap_bus = {
> +	.read = smpro_mfd_read,
> +	.write = smpro_mfd_write,
> +	.val_format_endian_default = REGMAP_ENDIAN_BIG,
> +};
> +
> +static bool smpro_mfd_readable_noinc_reg(struct device *dev, unsigned int reg)
> +{
> +	return  (reg == 0x82 || reg == 0x85 || reg == 0x92 || reg == 0x95 ||
> +		 reg == 0xC2 || reg == 0xC5 || reg == 0xD2 || reg == 0xDA);

No magic numbers.  Please define these registers.

> +}
> +
> +static const struct regmap_config smpro_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.readable_noinc_reg = smpro_mfd_readable_noinc_reg,
> +};
> +
> +static const struct mfd_cell smpro_devs[] = {
> +	MFD_CELL_NAME("smpro-hwmon"),
> +	MFD_CELL_NAME("smpro-errmon"),
> +	MFD_CELL_NAME("smpro-misc"),
> +};
> +
> +static int smpro_mfd_probe(struct i2c_client *i2c)
> +{
> +	const struct regmap_config *config;
> +	struct regmap *regmap;
> +	unsigned int val;
> +	int ret;
> +
> +	config = device_get_match_data(&i2c->dev);
> +	if (!config)
> +		config = &smpro_regmap_config;

This use-case is not currently supported.

Please return an error instead.

> +	regmap = devm_regmap_init(&i2c->dev, &smpro_regmap_bus, &i2c->dev, config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	/* Check for valid ID */

Decent #define nomenclature should render this comment superfluous.

> +	ret = regmap_read(regmap, MANUFACTURER_ID_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != AMPERE_MANUFACTURER_ID)
> +		return -ENODEV;
> +
> +	return devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> +				    smpro_devs, ARRAY_SIZE(smpro_devs), NULL, 0, NULL);
> +}
> +
> +static const struct of_device_id smpro_mfd_of_match[] = {
> +	{ .compatible = "ampere,smpro", .data = &smpro_regmap_config },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, smpro_mfd_of_match);
> +
> +static struct i2c_driver smpro_mfd_driver = {
> +	.probe_new = smpro_mfd_probe,
> +	.driver = {
> +		.name = "smpro-mfd-i2c",

"smpro-core"

> +		.of_match_table = smpro_mfd_of_match,
> +	},
> +};
> +module_i2c_driver(smpro_mfd_driver);
> +
> +MODULE_AUTHOR("Quan Nguyen <quan@os.amperecomputing.com>");
> +MODULE_DESCRIPTION("SMPRO MFD - I2C driver");
> +MODULE_LICENSE("GPL");

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
