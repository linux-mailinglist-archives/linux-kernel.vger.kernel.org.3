Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D5D551357
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbiFTIvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239179AbiFTIvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46A2712D05
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655715101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4SbZbSoHCtVIODRYa5BkuuEBPxhTo5Un/RiyGTkD1o=;
        b=HA8193cwQV+SEAr0izqnHQCYG1lfsyW+8rSdqQ3Xl1vhrCvlCsylTnON1VDZy6aIBG6gA6
        ZnSnmQ1OC42YK0bNm4bbczqlJ0qliBSt8eXiFokl7I11USMnxT3rR/+djYIYcwhHKcMy5i
        34hku1QOlS6ByX0Ut939M3gLkpIUzsQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-r6ryXFyGMfmEVkcmHXYNGA-1; Mon, 20 Jun 2022 04:51:39 -0400
X-MC-Unique: r6ryXFyGMfmEVkcmHXYNGA-1
Received: by mail-ed1-f72.google.com with SMTP id x8-20020a056402414800b0042d8498f50aso8205149eda.23
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P4SbZbSoHCtVIODRYa5BkuuEBPxhTo5Un/RiyGTkD1o=;
        b=4/hetm+H/W56byXQ73rbIHWUyR3QdSjOMUGCN9c0WW+Ezr4IKYo+kCv010lnVcanFl
         FPkshRILugE0fJH1D4gLR/Ph9cF5ksSqNKDV6wc9mPlKvEtu8sm7OcaZok2z4Przm8HN
         R6KYQfwDYJEJwt5yrd5H38A7HP5pUq/2v4A/yf2ZLLDutd/jA5e1JXY6xkEju1hOIHN9
         r8rQJrGrzdcmjsZC1QbTImuCW6PihHaAT/FaBy64UC+wr5BDjZhwH4v4pD1H0LjCB/MV
         uyt/ezVnQKiEPimxRvlR7hCn1I0opCdz86WPVrGufkXQ5oJBWMDRlCWapUVjSmHaohr2
         76Mw==
X-Gm-Message-State: AJIora++/Fe3W82E8DTxNK8QYMYRrpp1xD9miwspItKO0rbgJsAdInrF
        /l0m9LAZnG60Dg3ZXOzK8tk3vNmyPU6uswGYYaBg8cvXN1j/0Re8L4zl6FJtFwUJqXJ2p0qy60/
        Wl39UZNP1q8o3Q+Zm28V9oWDQ
X-Received: by 2002:a17:906:6a23:b0:711:ea9b:89ba with SMTP id qw35-20020a1709066a2300b00711ea9b89bamr20352997ejc.740.1655715098408;
        Mon, 20 Jun 2022 01:51:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t5iuR0Ph/5SJLGxa7yYLAzMf1WcJsLK7MuRicGL/HCaV/jr5bRiEd741PElvR4WDhL2gcdcA==
X-Received: by 2002:a17:906:6a23:b0:711:ea9b:89ba with SMTP id qw35-20020a1709066a2300b00711ea9b89bamr20352980ejc.740.1655715098155;
        Mon, 20 Jun 2022 01:51:38 -0700 (PDT)
Received: from [10.87.1.19] ([145.15.244.207])
        by smtp.gmail.com with ESMTPSA id v4-20020a056402348400b0042def6cd141sm9957388edc.30.2022.06.20.01.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 01:51:37 -0700 (PDT)
Message-ID: <f000cf13-5e73-3c76-700c-a087954d4050@redhat.com>
Date:   Mon, 20 Jun 2022 10:51:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 1/9] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to
 crc
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for this series, cleaning this up is long overdue.

The entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans

p.s.

Maybe do a follow up renaming CONFIG_INTEL_SOC_PMIC to
CONFIG_INTEL_SOC_PMIC_CRC and also change the module name
from intel-soc-pmic to intel-soc-pmic-crc ?

I don't expect any userspace dependencies on the module-name
(there are no module parameters) so this should be fine.




On 6/16/22 20:25, Andy Shevchenko wrote:
> The core part is misleading since its only purpose to serve Crystal Cove PMIC,
> although for couple of different platforms. Merge core part into crc one.
> 
> Advantages among others are:
> - speed up a compilation and build
> - decreasing the code base
> - reducing noise in the namespace by making some data static and const
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/Makefile              |   3 +-
>  drivers/mfd/intel_soc_pmic_core.c | 160 -----------------------------
>  drivers/mfd/intel_soc_pmic_core.h |  25 -----
>  drivers/mfd/intel_soc_pmic_crc.c  | 162 ++++++++++++++++++++++++++++--
>  4 files changed, 157 insertions(+), 193 deletions(-)
>  delete mode 100644 drivers/mfd/intel_soc_pmic_core.c
>  delete mode 100644 drivers/mfd/intel_soc_pmic_core.h
> 
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 858cacf659d6..61db669f864c 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -236,8 +236,7 @@ obj-$(CONFIG_MFD_RT4831)	+= rt4831.o
>  obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
>  obj-$(CONFIG_MFD_SKY81452)	+= sky81452.o
>  
> -intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
> -obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
> +obj-$(CONFIG_INTEL_SOC_PMIC)		+= intel_soc_pmic_crc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)	+= intel_soc_pmic_bxtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTWC)	+= intel_soc_pmic_chtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
> diff --git a/drivers/mfd/intel_soc_pmic_core.c b/drivers/mfd/intel_soc_pmic_core.c
> deleted file mode 100644
> index 5e8c94e008ed..000000000000
> --- a/drivers/mfd/intel_soc_pmic_core.c
> +++ /dev/null
> @@ -1,160 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Intel SoC PMIC MFD Driver
> - *
> - * Copyright (C) 2013, 2014 Intel Corporation. All rights reserved.
> - *
> - * Author: Yang, Bin <bin.yang@intel.com>
> - * Author: Zhu, Lejun <lejun.zhu@linux.intel.com>
> - */
> -
> -#include <linux/acpi.h>
> -#include <linux/i2c.h>
> -#include <linux/interrupt.h>
> -#include <linux/module.h>
> -#include <linux/mfd/core.h>
> -#include <linux/mfd/intel_soc_pmic.h>
> -#include <linux/platform_data/x86/soc.h>
> -#include <linux/pwm.h>
> -#include <linux/regmap.h>
> -
> -#include "intel_soc_pmic_core.h"
> -
> -/* PWM consumed by the Intel GFX */
> -static struct pwm_lookup crc_pwm_lookup[] = {
> -	PWM_LOOKUP("crystal_cove_pwm", 0, "0000:00:02.0", "pwm_pmic_backlight", 0, PWM_POLARITY_NORMAL),
> -};
> -
> -static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
> -				    const struct i2c_device_id *i2c_id)
> -{
> -	struct device *dev = &i2c->dev;
> -	struct intel_soc_pmic_config *config;
> -	struct intel_soc_pmic *pmic;
> -	int ret;
> -
> -	if (soc_intel_is_byt())
> -		config = &intel_soc_pmic_config_byt_crc;
> -	else
> -		config = &intel_soc_pmic_config_cht_crc;
> -
> -	pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
> -	if (!pmic)
> -		return -ENOMEM;
> -
> -	dev_set_drvdata(dev, pmic);
> -
> -	pmic->regmap = devm_regmap_init_i2c(i2c, config->regmap_config);
> -	if (IS_ERR(pmic->regmap))
> -		return PTR_ERR(pmic->regmap);
> -
> -	pmic->irq = i2c->irq;
> -
> -	ret = regmap_add_irq_chip(pmic->regmap, pmic->irq,
> -				  config->irq_flags | IRQF_ONESHOT,
> -				  0, config->irq_chip,
> -				  &pmic->irq_chip_data);
> -	if (ret)
> -		return ret;
> -
> -	ret = enable_irq_wake(pmic->irq);
> -	if (ret)
> -		dev_warn(dev, "Can't enable IRQ as wake source: %d\n", ret);
> -
> -	/* Add lookup table for crc-pwm */
> -	pwm_add_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
> -
> -	/* To distuingish this domain from the GPIO/charger's irqchip domains */
> -	irq_domain_update_bus_token(regmap_irq_get_domain(pmic->irq_chip_data),
> -				    DOMAIN_BUS_NEXUS);
> -
> -	ret = mfd_add_devices(dev, -1, config->cell_dev,
> -			      config->n_cell_devs, NULL, 0,
> -			      regmap_irq_get_domain(pmic->irq_chip_data));
> -	if (ret)
> -		goto err_del_irq_chip;
> -
> -	return 0;
> -
> -err_del_irq_chip:
> -	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
> -	return ret;
> -}
> -
> -static int intel_soc_pmic_i2c_remove(struct i2c_client *i2c)
> -{
> -	struct intel_soc_pmic *pmic = dev_get_drvdata(&i2c->dev);
> -
> -	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
> -
> -	/* remove crc-pwm lookup table */
> -	pwm_remove_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
> -
> -	mfd_remove_devices(&i2c->dev);
> -
> -	return 0;
> -}
> -
> -static void intel_soc_pmic_shutdown(struct i2c_client *i2c)
> -{
> -	struct intel_soc_pmic *pmic = dev_get_drvdata(&i2c->dev);
> -
> -	disable_irq(pmic->irq);
> -
> -	return;
> -}
> -
> -#if defined(CONFIG_PM_SLEEP)
> -static int intel_soc_pmic_suspend(struct device *dev)
> -{
> -	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
> -
> -	disable_irq(pmic->irq);
> -
> -	return 0;
> -}
> -
> -static int intel_soc_pmic_resume(struct device *dev)
> -{
> -	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
> -
> -	enable_irq(pmic->irq);
> -
> -	return 0;
> -}
> -#endif
> -
> -static SIMPLE_DEV_PM_OPS(intel_soc_pmic_pm_ops, intel_soc_pmic_suspend,
> -			 intel_soc_pmic_resume);
> -
> -static const struct i2c_device_id intel_soc_pmic_i2c_id[] = {
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(i2c, intel_soc_pmic_i2c_id);
> -
> -#if defined(CONFIG_ACPI)
> -static const struct acpi_device_id intel_soc_pmic_acpi_match[] = {
> -	{ "INT33FD" },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(acpi, intel_soc_pmic_acpi_match);
> -#endif
> -
> -static struct i2c_driver intel_soc_pmic_i2c_driver = {
> -	.driver = {
> -		.name = "intel_soc_pmic_i2c",
> -		.pm = &intel_soc_pmic_pm_ops,
> -		.acpi_match_table = ACPI_PTR(intel_soc_pmic_acpi_match),
> -	},
> -	.probe = intel_soc_pmic_i2c_probe,
> -	.remove = intel_soc_pmic_i2c_remove,
> -	.id_table = intel_soc_pmic_i2c_id,
> -	.shutdown = intel_soc_pmic_shutdown,
> -};
> -
> -module_i2c_driver(intel_soc_pmic_i2c_driver);
> -
> -MODULE_DESCRIPTION("I2C driver for Intel SoC PMIC");
> -MODULE_LICENSE("GPL v2");
> -MODULE_AUTHOR("Yang, Bin <bin.yang@intel.com>");
> -MODULE_AUTHOR("Zhu, Lejun <lejun.zhu@linux.intel.com>");
> diff --git a/drivers/mfd/intel_soc_pmic_core.h b/drivers/mfd/intel_soc_pmic_core.h
> deleted file mode 100644
> index d490685845eb..000000000000
> --- a/drivers/mfd/intel_soc_pmic_core.h
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Intel SoC PMIC MFD Driver
> - *
> - * Copyright (C) 2012-2014 Intel Corporation. All rights reserved.
> - *
> - * Author: Yang, Bin <bin.yang@intel.com>
> - * Author: Zhu, Lejun <lejun.zhu@linux.intel.com>
> - */
> -
> -#ifndef __INTEL_SOC_PMIC_CORE_H__
> -#define __INTEL_SOC_PMIC_CORE_H__
> -
> -struct intel_soc_pmic_config {
> -	unsigned long irq_flags;
> -	struct mfd_cell *cell_dev;
> -	int n_cell_devs;
> -	const struct regmap_config *regmap_config;
> -	const struct regmap_irq_chip *irq_chip;
> -};
> -
> -extern struct intel_soc_pmic_config intel_soc_pmic_config_byt_crc;
> -extern struct intel_soc_pmic_config intel_soc_pmic_config_cht_crc;
> -
> -#endif	/* __INTEL_SOC_PMIC_CORE_H__ */
> diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
> index 5bb0367bd974..b5974dfcc603 100644
> --- a/drivers/mfd/intel_soc_pmic_crc.c
> +++ b/drivers/mfd/intel_soc_pmic_crc.c
> @@ -2,18 +2,21 @@
>  /*
>   * Device access for Crystal Cove PMIC
>   *
> - * Copyright (C) 2013, 2014 Intel Corporation. All rights reserved.
> + * Copyright (C) 2012-2014 Intel Corporation. All rights reserved.
>   *
>   * Author: Yang, Bin <bin.yang@intel.com>
>   * Author: Zhu, Lejun <lejun.zhu@linux.intel.com>
>   */
>  
> +#include <linux/acpi.h>
> +#include <linux/i2c.h>
>  #include <linux/interrupt.h>
> -#include <linux/regmap.h>
> +#include <linux/module.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/intel_soc_pmic.h>
> -
> -#include "intel_soc_pmic_core.h"
> +#include <linux/platform_data/x86/soc.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
>  
>  #define CRYSTAL_COVE_MAX_REGISTER	0xC6
>  
> @@ -132,7 +135,20 @@ static const struct regmap_irq_chip crystal_cove_irq_chip = {
>  	.mask_base = CRYSTAL_COVE_REG_MIRQLVL1,
>  };
>  
> -struct intel_soc_pmic_config intel_soc_pmic_config_byt_crc = {
> +/* PWM consumed by the Intel GFX */
> +static struct pwm_lookup crc_pwm_lookup[] = {
> +	PWM_LOOKUP("crystal_cove_pwm", 0, "0000:00:02.0", "pwm_pmic_backlight", 0, PWM_POLARITY_NORMAL),
> +};
> +
> +struct intel_soc_pmic_config {
> +	unsigned long irq_flags;
> +	struct mfd_cell *cell_dev;
> +	int n_cell_devs;
> +	const struct regmap_config *regmap_config;
> +	const struct regmap_irq_chip *irq_chip;
> +};
> +
> +static const struct intel_soc_pmic_config intel_soc_pmic_config_byt_crc = {
>  	.irq_flags = IRQF_TRIGGER_RISING,
>  	.cell_dev = crystal_cove_byt_dev,
>  	.n_cell_devs = ARRAY_SIZE(crystal_cove_byt_dev),
> @@ -140,10 +156,144 @@ struct intel_soc_pmic_config intel_soc_pmic_config_byt_crc = {
>  	.irq_chip = &crystal_cove_irq_chip,
>  };
>  
> -struct intel_soc_pmic_config intel_soc_pmic_config_cht_crc = {
> +static const struct intel_soc_pmic_config intel_soc_pmic_config_cht_crc = {
>  	.irq_flags = IRQF_TRIGGER_RISING,
>  	.cell_dev = crystal_cove_cht_dev,
>  	.n_cell_devs = ARRAY_SIZE(crystal_cove_cht_dev),
>  	.regmap_config = &crystal_cove_regmap_config,
>  	.irq_chip = &crystal_cove_irq_chip,
>  };
> +
> +static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
> +				    const struct i2c_device_id *i2c_id)
> +{
> +	const struct intel_soc_pmic_config *config;
> +	struct device *dev = &i2c->dev;
> +	struct intel_soc_pmic *pmic;
> +	int ret;
> +
> +	if (soc_intel_is_byt())
> +		config = &intel_soc_pmic_config_byt_crc;
> +	else
> +		config = &intel_soc_pmic_config_cht_crc;
> +
> +	pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
> +	if (!pmic)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, pmic);
> +
> +	pmic->regmap = devm_regmap_init_i2c(i2c, config->regmap_config);
> +	if (IS_ERR(pmic->regmap))
> +		return PTR_ERR(pmic->regmap);
> +
> +	pmic->irq = i2c->irq;
> +
> +	ret = regmap_add_irq_chip(pmic->regmap, pmic->irq,
> +				  config->irq_flags | IRQF_ONESHOT,
> +				  0, config->irq_chip,
> +				  &pmic->irq_chip_data);
> +	if (ret)
> +		return ret;
> +
> +	ret = enable_irq_wake(pmic->irq);
> +	if (ret)
> +		dev_warn(dev, "Can't enable IRQ as wake source: %d\n", ret);
> +
> +	/* Add lookup table for crc-pwm */
> +	pwm_add_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
> +
> +	/* To distuingish this domain from the GPIO/charger's irqchip domains */
> +	irq_domain_update_bus_token(regmap_irq_get_domain(pmic->irq_chip_data),
> +				    DOMAIN_BUS_NEXUS);
> +
> +	ret = mfd_add_devices(dev, -1, config->cell_dev,
> +			      config->n_cell_devs, NULL, 0,
> +			      regmap_irq_get_domain(pmic->irq_chip_data));
> +	if (ret)
> +		goto err_del_irq_chip;
> +
> +	return 0;
> +
> +err_del_irq_chip:
> +	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
> +	return ret;
> +}
> +
> +static int intel_soc_pmic_i2c_remove(struct i2c_client *i2c)
> +{
> +	struct intel_soc_pmic *pmic = dev_get_drvdata(&i2c->dev);
> +
> +	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
> +
> +	/* remove crc-pwm lookup table */
> +	pwm_remove_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
> +
> +	mfd_remove_devices(&i2c->dev);
> +
> +	return 0;
> +}
> +
> +static void intel_soc_pmic_shutdown(struct i2c_client *i2c)
> +{
> +	struct intel_soc_pmic *pmic = dev_get_drvdata(&i2c->dev);
> +
> +	disable_irq(pmic->irq);
> +
> +	return;
> +}
> +
> +#if defined(CONFIG_PM_SLEEP)
> +static int intel_soc_pmic_suspend(struct device *dev)
> +{
> +	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
> +
> +	disable_irq(pmic->irq);
> +
> +	return 0;
> +}
> +
> +static int intel_soc_pmic_resume(struct device *dev)
> +{
> +	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
> +
> +	enable_irq(pmic->irq);
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(intel_soc_pmic_pm_ops, intel_soc_pmic_suspend,
> +			 intel_soc_pmic_resume);
> +
> +static const struct i2c_device_id intel_soc_pmic_i2c_id[] = {
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, intel_soc_pmic_i2c_id);
> +
> +#if defined(CONFIG_ACPI)
> +static const struct acpi_device_id intel_soc_pmic_acpi_match[] = {
> +	{ "INT33FD" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, intel_soc_pmic_acpi_match);
> +#endif
> +
> +static struct i2c_driver intel_soc_pmic_i2c_driver = {
> +	.driver = {
> +		.name = "intel_soc_pmic_i2c",
> +		.pm = &intel_soc_pmic_pm_ops,
> +		.acpi_match_table = ACPI_PTR(intel_soc_pmic_acpi_match),
> +	},
> +	.probe = intel_soc_pmic_i2c_probe,
> +	.remove = intel_soc_pmic_i2c_remove,
> +	.id_table = intel_soc_pmic_i2c_id,
> +	.shutdown = intel_soc_pmic_shutdown,
> +};
> +
> +module_i2c_driver(intel_soc_pmic_i2c_driver);
> +
> +MODULE_DESCRIPTION("I2C driver for Intel SoC PMIC");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Yang, Bin <bin.yang@intel.com>");
> +MODULE_AUTHOR("Zhu, Lejun <lejun.zhu@linux.intel.com>");

