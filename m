Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441AC52ADC4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiEQWA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiEQWAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:00:15 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0742515A5;
        Tue, 17 May 2022 15:00:12 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 631C310000C;
        Tue, 17 May 2022 22:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652824811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=12X0FmcsfYhwGz+el3sXxYKsWvjlu+60ujmBj9L+DT0=;
        b=E53DsZxxxz3IViRWh1wkYAFVXuDmi3itxp6mWS16zViIeLF4uKimk/7UxALMw9hf2EHdLR
        5jxCKRr0HwaUYuCHhbMFwxvTJI6XyWWozuZTfy/LJWlj21FVXCVCLlcUZ0yCLzhClif7YK
        UcWU0BvsXJqnzPMzeL1LdX0/dL7uqo3tsUxFurIOr/chc/phoXElzAV79GAGFchxsUXj1c
        8xSvXJBpEdrUbVAryRT1wyx2hvGEPLEnX/k4g3O7H01cKPgyl0F9I8zrJw1lHVRRiu8Cxl
        9CoGAtnVjher50QKzPgwR9SShsHNhcchHMumSX0fQXnQnbXKFz6W6bxsiOyZ9Q==
Date:   Wed, 18 May 2022 00:00:08 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Davis <afd@ti.com>
Subject: Re: [PATCH V3 2/2] rtc: Introduce ti-k3-rtc
Message-ID: <YoQa6FoJV5eoxloa@mail.local>
References: <20220513194457.25942-1-nm@ti.com>
 <20220513194457.25942-3-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513194457.25942-3-nm@ti.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nishanth,

I have some very minor comments:

On 13/05/2022 14:44:57-0500, Nishanth Menon wrote:
> diff --git a/drivers/rtc/rtc-ti-k3.c b/drivers/rtc/rtc-ti-k3.c
> new file mode 100644
> index 000000000000..21a64051fd42
> --- /dev/null
> +++ b/drivers/rtc/rtc-ti-k3.c
> @@ -0,0 +1,695 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Texas Instruments K3 RTC driver
> + *
> + * Copyright (C) 2021-2022 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +#define dev_fmt(fmt) "%s: " fmt, __func__

Are you sure you want to keep this line?

> +static int ti_k3_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
> +{
> +	struct ti_k3_rtc *priv = dev_get_drvdata(dev);
> +	time64_t seconds;
> +	int ret;
> +
> +	seconds = rtc_tm_to_time64(&alarm->time);
> +
> +	k3rtc_field_write(priv, K3RTC_ALM_S_CNT_LSW, seconds);
> +	k3rtc_field_write(priv, K3RTC_ALM_S_CNT_MSW, (seconds >> 32));
> +
> +	/* Make sure the alarm time is synced in */
> +	ret = k3rtc_fence(priv);
> +	if (ret) {
> +		dev_err(dev, "Failed to fence(%d)!\n", ret);

I'm not sure this message is useful because the only thing the user may
do would be trying to set the time again.

> +		return ret;
> +	}
> +
> +	/* Alarm irq enable will do a sync */
> +	return ti_k3_rtc_alarm_irq_enable(dev, alarm->enabled);
> +}
> +


> +
> +static int k3rtc_get_vbusclk(struct device *dev, struct ti_k3_rtc *priv)
> +{
> +	int ret;
> +	struct clk *clk;
> +
> +	/* Note: VBUS is'nt a context clock, it is needed for hardware operation */
typo ---------------^

> +	clk = devm_clk_get(dev, "vbus");
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "No input vbus clock\n");
> +		return PTR_ERR(clk);
> +	}
> +
> +	ret = clk_prepare_enable(clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable the vbus clock(%d)\n", ret);

I would also remove those two dev_err

> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, (void (*)(void *))clk_disable_unprepare, clk);
> +	return ret;
> +}
> +
> +static int ti_k3_rtc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ti_k3_rtc *priv;
> +	void __iomem *rtc_base;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(struct ti_k3_rtc), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	rtc_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(rtc_base))
> +		return PTR_ERR(rtc_base);
> +
> +	priv->regmap = devm_regmap_init_mmio(dev, rtc_base, &ti_k3_rtc_regmap_config);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);
> +
> +	ret = devm_regmap_field_bulk_alloc(dev, priv->regmap, priv->r_fields,
> +					   ti_rtc_reg_fields, K3_RTC_MAX_FIELDS);
> +	if (ret)
> +		return ret;
> +
> +	ret = k3rtc_get_32kclk(dev, priv);
> +	if (ret)
> +		return ret;
> +	ret = k3rtc_get_vbusclk(dev, priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		return ret;
> +	priv->irq = (unsigned int)ret;
> +
> +	priv->rtc_dev = devm_rtc_allocate_device(dev);
> +	if (IS_ERR(priv->rtc_dev))
> +		return PTR_ERR(priv->rtc_dev);
> +
> +	priv->soc = of_device_get_match_data(dev);
> +
> +	priv->rtc_dev->ops = &ti_k3_rtc_ops;
> +	priv->rtc_dev->range_max = (1ULL << 48) - 1;	/* 48Bit seconds */
> +	ti_k3_rtc_nvmem_config.priv = priv;
> +
> +	ret = devm_request_threaded_irq(dev, priv->irq, NULL,
> +					ti_k3_rtc_interrupt,
> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					dev_name(dev), dev);
> +	if (ret) {
> +		dev_err(dev, "Could not request IRQ: %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	ret = k3rtc_configure(dev);
> +	if (ret)
> +		return ret;
> +
> +	if (device_property_present(dev, "wakeup-source"))
> +		device_init_wakeup(dev, true);
> +	else
> +		device_set_wakeup_capable(dev, true);
> +
> +	ret = devm_rtc_register_device(priv->rtc_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_rtc_nvmem_register(priv->rtc_dev, &ti_k3_rtc_nvmem_config);
> +	return ret;

You don't need ret here and if I take that, I'll soon get an
automatically generated patch.

> +}
> +
> +static const struct ti_k3_rtc_soc_data ti_k3_am62_data = {
> +	.unlock_irq_erratum = true,
> +};
> +
> +static const struct of_device_id ti_k3_rtc_of_match_table[] = {
> +	{.compatible = "ti,am62-rtc", .data = &ti_k3_am62_data},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ti_k3_rtc_of_match_table);
> +
> +static int __maybe_unused ti_k3_rtc_suspend(struct device *dev)
> +{
> +	struct ti_k3_rtc *priv = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		enable_irq_wake(priv->irq);
> +	return 0;
> +}
> +
> +static int __maybe_unused ti_k3_rtc_resume(struct device *dev)
> +{
> +	struct ti_k3_rtc *priv = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_wake(priv->irq);
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(ti_k3_rtc_pm_ops, ti_k3_rtc_suspend, ti_k3_rtc_resume);
> +
> +static struct platform_driver ti_k3_rtc_driver = {
> +	.probe = ti_k3_rtc_probe,
> +	.driver = {
> +		   .name = "rtc-ti-k3",
> +		   .of_match_table = ti_k3_rtc_of_match_table,
> +		   .pm = &ti_k3_rtc_pm_ops,
> +	},
> +};
> +module_platform_driver(ti_k3_rtc_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("TI K3 RTC driver");
> +MODULE_AUTHOR("Nishanth Menon");
> -- 
> 2.31.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
