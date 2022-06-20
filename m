Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA7F5513A9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbiFTJEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240283AbiFTJEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5643ABDB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655715883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cv6FFIalcEzDMD5rkRP5T5JjqeUnYG5Xg0qpfL+yYqg=;
        b=FWMB8CN1nSsUbeC6faDM7ExFqgdHuGyliIyNvOYsRLsS6UDrtChhjxq2DaMTqk/TTJ5WTM
        q09E5f48KxuLVeKxCgfgjoet1zZnhO4r7GQglysHdIs3XPlyuvX0odJ8z/aKKYh1tZ4uCK
        8PEEeZDmqk68isMz+x9oDBgorHhvyUc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-j5U47N7mP7y92ZqARsiS0w-1; Mon, 20 Jun 2022 05:04:42 -0400
X-MC-Unique: j5U47N7mP7y92ZqARsiS0w-1
Received: by mail-wr1-f71.google.com with SMTP id bv8-20020a0560001f0800b002183c5d5c26so2268942wrb.20
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Cv6FFIalcEzDMD5rkRP5T5JjqeUnYG5Xg0qpfL+yYqg=;
        b=ATKiR82F8tDYtHMkUZOr0KpsvuI5aSW3K+3HAgiSs527i+xKQKFfqkSaIIYeKD+j4r
         RKqqSzeDQCVQE5pqLrUxWygQYITMJ+PS8yBNOWll370CIe4D6TX75VSYutaFO7U0hke1
         8Os2V8/shRnZr3aY98k5AsHYXi6vPnWudX/A8wYRyHHkP6q0j3Q2SG6xDulECGGKH1nm
         KeQYKA3v8Zn+vPPpk2qSE2bBJEPrJEx+9B5Cvx8sKOzVhhGWK8lt5cPVUnRMJ9vICyx0
         1azdPdIVqzSHHRQPzp7+qM3ei/T3RUH7cl69UApWkoIp8jwo57p/VtuR7ycdP1q/bpz+
         Zz/Q==
X-Gm-Message-State: AJIora+wHY4MVg7fdw0NqdbuSg01HRZUeZCF7Q/NkkcHGcMHlOPL74Zy
        HLSZqIDXoJEiR6dwPTQyQQN2yoBqhmPB5irnyu3ZMK9m9NwdaXbrUIfqrDmmYcy6OsWxIkBKh3H
        GBFJU5Fn4H6HE9ut1l4aii2Ol
X-Received: by 2002:a05:600c:ac4:b0:39c:4f54:9c5f with SMTP id c4-20020a05600c0ac400b0039c4f549c5fmr22984395wmr.135.1655715880685;
        Mon, 20 Jun 2022 02:04:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1spgvovAhevE7cfDZe84NSTQxQi48QYGdxQ0u5jvFs0nzwMbQMwMtEtobiC7G0vZBc0pAI1kg==
X-Received: by 2002:a05:600c:ac4:b0:39c:4f54:9c5f with SMTP id c4-20020a05600c0ac400b0039c4f549c5fmr22984380wmr.135.1655715880454;
        Mon, 20 Jun 2022 02:04:40 -0700 (PDT)
Received: from [10.87.1.19] ([145.15.244.207])
        by smtp.gmail.com with ESMTPSA id p3-20020a1c5443000000b0039c362311d2sm21799030wmi.9.2022.06.20.02.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 02:04:40 -0700 (PDT)
Message-ID: <81201d93-ffc5-024c-c132-36f91d9e663e@redhat.com>
Date:   Mon, 20 Jun 2022 11:04:38 +0200
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

p.s.

I've added this commit to my local tree, so that the next time I boot
a device with a CRC PMIC it will get some testing.

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

