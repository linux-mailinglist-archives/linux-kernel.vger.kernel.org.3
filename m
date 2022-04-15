Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38662502679
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 10:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351296AbiDOIGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 04:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244921AbiDOIGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 04:06:09 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A0159A61;
        Fri, 15 Apr 2022 01:03:40 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23F83J9P130367;
        Fri, 15 Apr 2022 03:03:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650009799;
        bh=NTy+10/rvDVv3oXf+hx+iRizmeAw7E8r66BdzQEdhq4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=lsgpdF1FJ4rrxua3gRmJL4ijFC0xjqwg+yoeNRIs7RAZg7aCcKfkFLO+rKrxvK3jZ
         pCCSHj1sbaeeuTEvQbhDXS5kBoaxp+4lMVDtD5UKa0XQr1Nw22H2SVTD/98dPFF7cI
         uZ1W7QA7Gv4Zv+e8s/Eo3mNXBigRf3xqzicj7G80=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23F83J0n002373
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Apr 2022 03:03:19 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 15
 Apr 2022 03:03:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 15 Apr 2022 03:03:19 -0500
Received: from [10.250.235.115] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23F83Fn4088810;
        Fri, 15 Apr 2022 03:03:16 -0500
Message-ID: <b0ae635f-461f-be80-ebff-a548c9dd66af@ti.com>
Date:   Fri, 15 Apr 2022 13:33:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] rtc: Introduce ti-k3-rtc
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20220412073138.25027-1-nm@ti.com>
 <20220412073138.25027-3-nm@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220412073138.25027-3-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/04/22 1:01 pm, Nishanth Menon wrote:
> +/**
> + * k3rtc_fence  - Ensure a register sync took place between the two domains
> + * @priv:      pointer to priv data
> + *
> + * Return: 0 if the sync took place, else returns -ETIMEDOUT
> + */
> +static int k3rtc_fence(struct ti_k3_rtc *priv)
> +{
> +	u32 timeout = priv->sync_timeout_us;
> +	u32 mask = K3RTC_RD_PEND_BIT | K3RTC_WR_PEND_BIT;
> +	u32 val = 0;
> +
> +	while (timeout--) {
> +		val = k3rtc_readl(priv, REG_K3RTC_SYNCPEND);
> +		if (!(val & mask))
> +			return 0;
> +		usleep_range(1, 2);
> +	}

readl_poll_timeout() ?

> +
> +	pr_err("RTC Fence timeout: 0x%08x\n", val);

Can we use dev_err()?  Provides better indication of the driver throwing
error.

> +	return -ETIMEDOUT;
> +}
> +
> +static inline int k3rtc_check_unlocked(struct ti_k3_rtc *priv)
> +{
> +	u32 val;
> +
> +	val = k3rtc_readl(priv, REG_K3RTC_GENERAL_CTL);
> +	return (val & K3RTC_UNLOCK_BIT) ? 0 : 1;
> +}
> +
> +static int k3rtc_unlock_rtc(struct ti_k3_rtc *priv)
> +{
> +	u32 timeout = priv->sync_timeout_us;
> +	int ret;
> +
> +	ret = k3rtc_check_unlocked(priv);
> +	if (!ret)
> +		return ret;
> +
> +	k3rtc_writel(priv, REG_K3RTC_KICK0, K3RTC_KICK0_UNLOCK_VALUE);
> +	k3rtc_writel(priv, REG_K3RTC_KICK1, K3RTC_KICK1_UNLOCK_VALUE);
> +
> +	/* Skip fence since we are going to check the unlock bit as fence */
> +	while (timeout--) {
> +		ret = k3rtc_check_unlocked(priv);
> +		if (!ret)
> +			return ret;
> +		usleep_range(1, 2);
> +	}

readl_poll_timeout() ?

> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int k3rtc_configure(struct device *dev)
> +{
> +	int ret;
> +	u32 ctl;
> +	struct ti_k3_rtc *priv = dev_get_drvdata(dev);
> +
> +	/*
> +	 * HWBUG: The compare statemachine is broken if the RTC module
> +	 * is NOT unlocked in under one second of boot - which is pretty long
> +	 * time from the perspective of Linux driver (module load, u-boot
> +	 * shell all can take much longer than this.
> +	 *
> +	 * In such occurrence, it is assumed that the RTC module is un-usable
> +	 */
> +	if (priv->soc->unlock_irq_erratum) {
> +		ret = k3rtc_check_unlocked(priv);
> +		/* If there is an error OR if we are locked, return error */
> +		if (ret) {
> +			dev_err(dev, HW_ERR "Erratum i2327 unlock QUIRK! Cannot operate!!\n");
> +			return -EFAULT;
> +		}
> +	} else {
> +		/* May Need to explicitly unlock first time */
> +		ret = k3rtc_unlock_rtc(priv);
> +		if (ret) {
> +			dev_err(dev, "Failed to unlock(%d)!\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	/* Enable Shadow register sync on 32k clk boundary */
> +	ctl = k3rtc_readl(priv, REG_K3RTC_GENERAL_CTL);
> +	ctl |= K3RTC_O32K_OSC_DEP_EN_BIT;
> +	k3rtc_writel(priv, REG_K3RTC_GENERAL_CTL, ctl);
> +
> +	/*
> +	 * Wait at least 2 clk sync time before proceeding further programming.
> +	 * This ensures that the 32k based sync is active.
> +	 */
> +	usleep_range(priv->sync_timeout_us, priv->sync_timeout_us + 5);
> +
> +	/* We need to ensure fence here to make sure sync here */
> +	ret = k3rtc_fence(priv);
> +	if (ret) {
> +		dev_err(dev, "Failed fence osc_dep enable(%d) - is 32k clk working?!\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	/* Lets just make sure we get consistent time value */
> +	ctl &= ~K3RTC_CNT_FMODE_MASK;
> +	/*
> +	 * FMODE setting: Reading lower seconds will freeze value on higher
> +	 * seconds. This also implies that we must *ALWAYS* read lower seconds
> +	 * prior to reading higher seconds
> +	 */
> +	ctl |= K3RTC_CNT_FMODE_S_CNT_VALUE;
> +	k3rtc_writel(priv, REG_K3RTC_GENERAL_CTL, ctl);
> +
> +	/* Clear any spurious IRQ sources if any */
> +	k3rtc_writel(priv, REG_K3RTC_IRQSTATUS_SYS,
> +		     K3RTC_EVENT_ON_OFF_BIT | K3RTC_EVENT_OFF_ON_BIT);
> +	/* Disable all IRQs */
> +	k3rtc_writel(priv, REG_K3RTC_IRQENABLE_CLR_SYS,
> +		     K3RTC_EVENT_ON_OFF_BIT | K3RTC_EVENT_OFF_ON_BIT);
> +
> +	/* And.. Let us Sync the writes in */
> +	ret = k3rtc_fence(priv);
> +	if (ret) {
> +		dev_err(dev, "Failed to fence(%d)!\n", ret);
> +		return ret;

nit: this can be dropped as next statement will return error code anyway

> +	}
> +
> +	return ret;
> +}
> +

[...]

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
> +#ifdef CONFIG_PM_SLEEP
> +static int ti_k3_rtc_suspend(struct device *dev)

 __maybe_unused preferred instead of #ifdef for better compile coverage
but upto you.

> +{
> +	struct ti_k3_rtc *priv = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		enable_irq_wake(priv->irq);
> +	return 0;
> +}
> +
> +static int ti_k3_rtc_resume(struct device *dev)
> +{
> +	struct ti_k3_rtc *priv = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_wake(priv->irq);
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(ti_k3_rtc_pm_ops, ti_k3_rtc_suspend, ti_k3_rtc_resume);
> +
> +static struct platform_driver ti_k3_rtc_driver = {
> +	.probe = ti_k3_rtc_probe,
> +	.driver = {
> +		   .name = "rtc-ti-k3",
> +		   .of_match_table = ti_k3_rtc_of_match_table,
> +		   .pm = &ti_k3_rtc_pm_ops,
> +		   },
Extra tab?

> +};
> +module_platform_driver(ti_k3_rtc_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("TI K3 RTC driver");
> +MODULE_AUTHOR("Nishanth Menon");
> +MODULE_ALIAS("platform:rtc-ti-k3");
> -- 2.31.1
