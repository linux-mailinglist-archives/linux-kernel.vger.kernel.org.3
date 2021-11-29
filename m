Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8184611B9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240390AbhK2KIv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Nov 2021 05:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344417AbhK2KGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:06:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6512C0617A0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 01:45:34 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mrdDw-0000Zg-Ul; Mon, 29 Nov 2021 10:45:24 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mrdDv-0003uZ-4L; Mon, 29 Nov 2021 10:45:23 +0100
Message-ID: <9640ea147188dc18586a399d903cd5a8759e2714.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] rtc: Add driver for Sunplus SP7021
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Vincent Shih <vincent.sunplus@gmail.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com,
        in-reply-to=1635834123-24668-1-git-send-email-vincent.shih@sunplus.com
Cc:     Vincent Shih <vincent.shih@sunplus.com>
Date:   Mon, 29 Nov 2021 10:45:23 +0100
In-Reply-To: <1636439898-7358-2-git-send-email-vincent.shih@sunplus.com>
References: <1636439898-7358-1-git-send-email-vincent.shih@sunplus.com>
         <1636439898-7358-2-git-send-email-vincent.shih@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Tue, 2021-11-09 at 14:38 +0800, Vincent Shih wrote:
[...]
> +struct sunplus_rtc {
> +	struct clk *rtcclk;
> +	struct reset_control *rstc;
> +	void __iomem *base;
> +	u32 ohms;
> +};
> +
> +struct sunplus_rtc sp_rtc;

Why is this global?


[...]
> +static int sp_rtc_probe(struct platform_device *plat_dev)
> +{
> +	struct rtc_device *rtc;
> +	struct resource *res;
> +	const struct rtc_class_ops *rtc_ops;
> +	void __iomem *reg_base;
> +	int ret, irq;
> +
> +	memset(&sp_rtc, 0, sizeof(sp_rtc));

I'd allocate device private data here with devm_kzalloc() instead.

> +	// find and map our resources
> +	res = platform_get_resource_byname(plat_dev, IORESOURCE_MEM, RTC_REG_NAME);
> +
> +	if (res) {
> +		dev_dbg(&plat_dev->dev, "res = 0x%x\n", res->start);
> +
> +		reg_base = devm_ioremap_resource(&plat_dev->dev, res);

There is no need to check res before feeding it into
devm_ioremap_resource(). You can simplify this even further with
devm_platform_ioremap_resource_by_name().

> +		if (IS_ERR(reg_base)) {
> +			dev_err(&plat_dev->dev, "%s devm_ioremap_resource fail\n", RTC_REG_NAME);
> +			return PTR_ERR(reg_base);
> +		}
> +
> +		dev_dbg(&plat_dev->dev, "reg_base = 0x%lx\n", (unsigned long)reg_base);
> +	}
> +
> +	sp_rtc.base = reg_base;
> +	rtc_ops = &sp_rtc_ops;
> +
> +	// Keep RTC from system reset
> +	writel(DIS_SYS_RST_RTC_MASK | DIS_SYS_RST_RTC, sp_rtc.base + RTC_CTRL);

Are you allowed to write to sp_rtc.base registers before releasing the
reset?

> +	// request irq
> +	irq = platform_get_irq(plat_dev, 0);
> +	if (irq < 0) {
> +		dev_err(&plat_dev->dev, "platform_get_irq failed\n");
> +		irq = IRQ_NOTCONNECTED;

By doing this you are making devm_request_irq() below return -ENOTCONN.
Why not return the real error code right here?

		return dev_err_probe(&plat_dev->dev, irq, "platform_get_irq failed\n");

> +	}
> +
> +	ret = devm_request_irq(&plat_dev->dev, irq, rtc_irq_handler,
> +					IRQF_TRIGGER_RISING, "rtc irq", plat_dev);
> +	if (ret) {
> +		dev_err(&plat_dev->dev, "devm_request_irq failed: %d\n", ret);
> +		return ret;

This could be shortened to:

		return dev_err_probe(&plat_dev->dev, ret, "devm_request_irq failed\n");

> +	}
> +
> +	// Setup trickle charger
> +	if (plat_dev->dev.of_node)
> +		sp_rtc_set_trickle_charger(plat_dev->dev);
> +
> +	// reset
> +	sp_rtc.rstc = devm_reset_control_get_exclusive(&plat_dev->dev, NULL);
> +	if (IS_ERR(sp_rtc.rstc)) {
> +		ret = dev_err_probe(&plat_dev->dev, PTR_ERR(sp_rtc.rstc),
> +					    "failed to retrieve reset controller\n");
> +		return PTR_ERR(sp_rtc.rstc);

This could be shortened to:

		return dev_err_probe(&plat_dev->dev, PTR_ERR(sp_rtc.rstc),
				     "failed to retrieve reset controller\n");

> +	}
> +
> +	// clk
> +	sp_rtc.rtcclk = devm_clk_get(&plat_dev->dev, NULL);
> +	if (IS_ERR(sp_rtc.rtcclk)) {
> +		dev_err(&plat_dev->dev, "devm_clk_get fail\n");
> +		return PTR_ERR(sp_rtc.rtcclk);


> +	}
> +
> +	ret = reset_control_deassert(sp_rtc.rstc);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(sp_rtc.rtcclk);
> +	if (ret)

Assert reset on failure?

> +		return ret;
> +
> +	device_init_wakeup(&plat_dev->dev, 1);
> +
> +	rtc = devm_rtc_allocate_device(&plat_dev->dev);
> +	if (IS_ERR(rtc))

Disable clock and assert reset on failure?

> +		return PTR_ERR(rtc);
> +
> +	rtc->range_max = U32_MAX;
> +	rtc->range_min = 0;
> +	rtc->ops = rtc_ops;
> +
> +	ret = devm_rtc_register_device(rtc);
> +	if (ret)
> +		goto free_reset_assert_clk;
> +
> +	platform_set_drvdata(plat_dev, rtc);
> +	dev_info(&plat_dev->dev, "sp7021-rtc loaded\n");
> +
> +	return 0;
> +
> +free_reset_assert_clk:
> +	reset_control_assert(sp_rtc.rstc);
> +	clk_disable_unprepare(sp_rtc.rtcclk);

Should this be the other way around? I'd expect this to be in the
opposite order of reset deassert and clock enable.

> +
> +	return ret;
> +}
> +
> +static int sp_rtc_remove(struct platform_device *plat_dev)
> +{
> +	reset_control_assert(sp_rtc.rstc);
> +	clk_disable_unprepare(sp_rtc.rtcclk);

Same as above.

regards
Philipp
