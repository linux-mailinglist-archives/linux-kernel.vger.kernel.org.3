Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987134613CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241994AbhK2LZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:25:28 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:59113 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244428AbhK2LX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:23:27 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 706EA24001C;
        Mon, 29 Nov 2021 11:20:06 +0000 (UTC)
Date:   Mon, 29 Nov 2021 12:20:06 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Vincent Shih <vincent.sunplus@gmail.com>
Cc:     a.zummo@towertech.it, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com,
        in-reply-to=1635834123-24668-1-git-send-email-vincent.shih@sunplus.com,
        Vincent Shih <vincent.shih@sunplus.com>
Subject: Re: [PATCH v2 1/2] rtc: Add driver for Sunplus SP7021
Message-ID: <YaS3Zn7x+iEZN3fj@piout.net>
References: <1636439898-7358-1-git-send-email-vincent.shih@sunplus.com>
 <1636439898-7358-2-git-send-email-vincent.shih@sunplus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636439898-7358-2-git-send-email-vincent.shih@sunplus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 09/11/2021 14:38:17+0800, Vincent Shih wrote:
> +#define RTC_REG_NAME			"rtc_reg"
> +
> +#define RTC_CTRL			0x40
> +#define TIMER_FREEZE			(0x1 << 5)
> +#define TIMER_FREEZE_MASK		(1 << (5 + 16))
> +#define DIS_SYS_RST_RTC			(0x1 << 4)
> +#define DIS_SYS_RST_RTC_MASK		(1 << (4 + 16))
> +#define RTC32K_MODE_RESET		(0x1 << 3)
> +#define RTC32K_MODE_RESET_MASK		(1 << (3 + 16))
> +#define ALARM_EN_OVERDUE		(0x1 << 2)
> +#define ALARM_EN_OVERDUE_MASK		(1 << (2 + 16))
> +#define ALARM_EN_PMC			(0x1 << 1)
> +#define ALARM_EN_PMC_MASK		(1 << (1 + 16))
> +#define ALARM_EN			(0x1 << 0)
> +#define ALARM_EN_MASK			(1 << (0 + 16))

You should definitively use BIT() and probably GENMASK

> +#define RTC_TIMER_OUT			0x44
> +#define RTC_DIVIDER			0x48
> +#define RTC_TIMER_SET			0x4c
> +#define RTC_ALARM_SET			0x50
> +#define RTC_USER_DATA			0x54
> +#define RTC_RESET_RECORD		0x58
> +#define RTC_BATTERY_CTRL		0x5c
> +#define BAT_CHARGE_RSEL_2K_OHM		(0x0 << 2)
> +#define BAT_CHARGE_RSEL_250_OHM		(0x1 << 2)
> +#define BAT_CHARGE_RSEL_50_OHM		(0x2 << 2)
> +#define BAT_CHARGE_RSEL_0_OHM		(0x3 << 2)

Using FIELD_GET and FIELD_PREP later on will simplify those defines.

> +#define BAT_CHARGE_RSEL_MASK		(0x3 << (2 + 16))
> +#define BAT_CHARGE_DSEL_ON		(0x0 << 1)
> +#define BAT_CHARGE_DSEL_OFF		(0x1 << 1)
> +#define BAT_CHARGE_DSEL_MASK		(0x1 << (1 + 16))
> +#define BAT_CHARGE_EN			(0x1 << 0)
> +#define BAT_CHARGE_EN_MASK		(0x1 << (0 + 16))
> +#define RTC_TRIM_CTRL			0x60
> +
> +struct sunplus_rtc {
> +	struct clk *rtcclk;
> +	struct reset_control *rstc;
> +	void __iomem *base;
> +	u32 ohms;
> +};
> +
> +struct sunplus_rtc sp_rtc;
> +
> +static void sp_get_seconds(unsigned long *secs)
> +{
> +	*secs = (unsigned long)readl(sp_rtc.base + RTC_TIMER_OUT);
> +}
> +
> +static void sp_set_seconds(unsigned long secs)
> +{
> +	writel((u32)secs, sp_rtc.base + RTC_TIMER_SET);
> +}
> +
> +static int sp_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	unsigned long secs;
> +
> +	sp_get_seconds(&secs);
> +	rtc_time64_to_tm(secs, tm);
> +	dev_dbg(dev, "%s:  RTC date/time to %d-%d-%d, %02d:%02d:%02d.\r\n",
> +		__func__, tm->tm_mday, tm->tm_mon + 1, tm->tm_year,
> +					tm->tm_hour, tm->tm_min, tm->tm_sec);

You should use %ptR or simplify remove this debug message as the core
has a tracepoint

> +
> +	return rtc_valid_tm(tm);

This is uneccessary as the first thing the core does is check the
validity.

> +}
> +
> +int sp_rtc_get_time(struct rtc_time *tm)

This function seems unused.

> +{
> +	unsigned long secs;
> +
> +	sp_get_seconds(&secs);
> +	rtc_time64_to_tm(secs, tm);
> +
> +	return 0;
> +}
> +
> +static int sp_rtc_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	dev_dbg(&pdev->dev, "[RTC] Debug: %s(%d)\n", __func__, __LINE__);
> +
> +	// Keep RTC from system reset
> +	writel(DIS_SYS_RST_RTC_MASK | DIS_SYS_RST_RTC, sp_rtc.base + RTC_CTRL);
> +
> +	return 0;
> +}
> +
> +static int sp_rtc_resume(struct platform_device *pdev)
> +{
> +	/*						*/
> +	/* Because RTC is still powered during suspend,	*/
> +	/* there is nothing to do here.			*/
> +	/*						*/

I'd prefer this comment to use a more common formatting.

> +	dev_dbg(&pdev->dev, "[RTC] Debug: %s(%d)\n", __func__, __LINE__);
> +
> +	// Keep RTC from system reset
> +	writel(DIS_SYS_RST_RTC_MASK | DIS_SYS_RST_RTC, sp_rtc.base + RTC_CTRL);
> +

Isn't that already done on suspend?

> +	return 0;
> +}
> +
> +static int sp_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	unsigned long secs;
> +
> +	secs = rtc_tm_to_time64(tm);
> +	dev_dbg(dev, "%s, secs = %lu\n", __func__, secs);
> +	sp_set_seconds(secs);
> +
> +	return 0;
> +}
> +
> +static int sp_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	unsigned long alarm_time;
> +
> +	alarm_time = rtc_tm_to_time64(&alrm->time);
> +	dev_dbg(dev, "%s, alarm_time: %u\n", __func__, (u32)(alarm_time));
> +	writel((u32)alarm_time, sp_rtc.base + RTC_ALARM_SET);
> +
> +	return 0;
> +}
> +
> +static int sp_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	unsigned int alarm_time;
> +
> +	alarm_time = readl(sp_rtc.base + RTC_ALARM_SET);
> +	dev_dbg(dev, "%s, alarm_time: %u\n", __func__, alarm_time);
> +
> +	if (alarm_time == 0) {
> +		// alarm is disabled

This comment is not really useful

> +		alrm->enabled = 0;
> +	} else {
> +		// alarm is enabled

Ditto

> +		alrm->enabled = 1;
> +		rtc_time64_to_tm((unsigned long)(alarm_time), &alrm->time);

This should be done in either case.

> +	}
> +
> +	return 0;
> +}
> +
> +static int sp_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
> +{
> +	if (enabled)
> +		writel((TIMER_FREEZE_MASK | DIS_SYS_RST_RTC_MASK | RTC32K_MODE_RESET_MASK |
> +				ALARM_EN_OVERDUE_MASK | ALARM_EN_PMC_MASK | ALARM_EN_MASK) |
> +					(DIS_SYS_RST_RTC | ALARM_EN_OVERDUE | ALARM_EN_PMC |
> +						ALARM_EN), sp_rtc.base + RTC_CTRL);
> +	else
> +		writel((ALARM_EN_OVERDUE_MASK | ALARM_EN_PMC_MASK | ALARM_EN_MASK) | 0x0,
> +				sp_rtc.base + RTC_CTRL);
> +
> +	return 0;
> +}
> +
> +static const struct rtc_class_ops sp_rtc_ops = {
> +	.read_time =		sp_rtc_read_time,
> +	.set_time =		sp_rtc_set_time,
> +	.set_alarm =		sp_rtc_set_alarm,
> +	.read_alarm =		sp_rtc_read_alarm,
> +	.alarm_irq_enable =	sp_rtc_alarm_irq_enable,
> +};
> +
> +static irqreturn_t rtc_irq_handler(int irq, void *dev_id)
> +{
> +	struct platform_device *plat_dev = dev_id;
> +	struct rtc_device *rtc = platform_get_drvdata(plat_dev);
> +
> +	rtc_update_irq(rtc, 1, RTC_IRQF | RTC_AF);
> +	dev_dbg(&plat_dev->dev, "[RTC] ALARM INT\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* ---------------------------------------------------------------------------------------------- */
> +/* bat_charge_rsel   bat_charge_dsel   bat_charge_en     Remarks				  */
> +/*         x              x                 0            Disable				  */
> +/*         0              0                 1            0.86mA (2K Ohm with diode)		  */
> +/*         1              0                 1            1.81mA (250 Ohm with diode)		  */
> +/*         2              0                 1            2.07mA (50 Ohm with diode)		  */
> +/*         3              0                 1            16.0mA (0 Ohm with diode)		  */
> +/*         0              1                 1            1.36mA (2K Ohm without diode)		  */
> +/*         1              1                 1            3.99mA (250 Ohm without diode)		  */
> +/*         2              1                 1            4.41mA (50 Ohm without diode)		  */
> +/*         3              1                 1            16.0mA (0 Ohm without diode)		  */
> +/* ---------------------------------------------------------------------------------------------- */
> +static void sp_rtc_set_trickle_charger(struct device dev)
> +{
> +	int ret;
> +	u32 rsel;
> +
> +	ret = of_property_read_u32(dev.of_node, "trickle-resistor-ohms", &sp_rtc.ohms);
> +	if (ret)
> +		return;
> +
> +	switch (sp_rtc.ohms) {
> +	case 2000:
> +		rsel = BAT_CHARGE_RSEL_2K_OHM;
> +		break;
> +	case 250:
> +		rsel = BAT_CHARGE_RSEL_250_OHM;
> +		break;
> +	case 50:
> +		rsel = BAT_CHARGE_RSEL_50_OHM;
> +		break;
> +	case 0:
> +		rsel = BAT_CHARGE_RSEL_0_OHM;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	writel(BAT_CHARGE_RSEL_MASK | rsel, sp_rtc.base + RTC_BATTERY_CTRL);
> +
> +	ret = of_property_read_bool(dev.of_node, "trickle-diode-disable");

This property is deprecated and used to be about disabling the charger,
it has been replaced by aux-voltage-chargeable.

I guess we need a new property, probably "trickle-diode" that would take
a string parameter as some RTCs will need to know which type of diode
has to be enabled (e.g. rv1805 would need "standard" or "schottky")

> +	if (ret)
> +		writel(BAT_CHARGE_DSEL_MASK | BAT_CHARGE_DSEL_OFF, sp_rtc.base + RTC_BATTERY_CTRL);
> +	else
> +		writel(BAT_CHARGE_DSEL_MASK | BAT_CHARGE_DSEL_ON, sp_rtc.base + RTC_BATTERY_CTRL);
> +
> +	writel(BAT_CHARGE_EN_MASK | BAT_CHARGE_EN, sp_rtc.base + RTC_BATTERY_CTRL);
> +}
> +
> +static int sp_rtc_probe(struct platform_device *plat_dev)
> +{
> +	struct rtc_device *rtc;
> +	struct resource *res;
> +	const struct rtc_class_ops *rtc_ops;
> +	void __iomem *reg_base;
> +	int ret, irq;
> +
> +	memset(&sp_rtc, 0, sizeof(sp_rtc));
> +
> +	// find and map our resources
> +	res = platform_get_resource_byname(plat_dev, IORESOURCE_MEM, RTC_REG_NAME);
> +
> +	if (res) {
> +		dev_dbg(&plat_dev->dev, "res = 0x%x\n", res->start);
> +
> +		reg_base = devm_ioremap_resource(&plat_dev->dev, res);
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
> +

I guess this is already done in .suspend, are you sure you need that in
all those locations?

> +	// request irq

Useless comment

> +	irq = platform_get_irq(plat_dev, 0);
> +	if (irq < 0) {
> +		dev_err(&plat_dev->dev, "platform_get_irq failed\n");
> +		irq = IRQ_NOTCONNECTED;
> +	}
> +
> +	ret = devm_request_irq(&plat_dev->dev, irq, rtc_irq_handler,
> +					IRQF_TRIGGER_RISING, "rtc irq", plat_dev);
> +	if (ret) {
> +		dev_err(&plat_dev->dev, "devm_request_irq failed: %d\n", ret);
> +		return ret;
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
> +		return ret;
> +
> +	device_init_wakeup(&plat_dev->dev, 1);
> +
> +	rtc = devm_rtc_allocate_device(&plat_dev->dev);
> +	if (IS_ERR(rtc))
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

This message needs to be removed, it is wrong and a proper message is
already printed by the core.

> +
> +	return 0;
> +
> +free_reset_assert_clk:
> +	reset_control_assert(sp_rtc.rstc);
> +	clk_disable_unprepare(sp_rtc.rtcclk);
> +
> +	return ret;
> +}
> +
> +static int sp_rtc_remove(struct platform_device *plat_dev)
> +{
> +	reset_control_assert(sp_rtc.rstc);
> +	clk_disable_unprepare(sp_rtc.rtcclk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sp_rtc_of_match[] = {
> +	{ .compatible = "sunplus,sp7021-rtc" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sp_rtc_of_match);
> +
> +static struct platform_driver sp_rtc_driver = {
> +	.probe   = sp_rtc_probe,
> +	.remove  = sp_rtc_remove,
> +	.suspend = sp_rtc_suspend,
> +	.resume  = sp_rtc_resume,
> +	.driver  = {
> +		.name = "sp7021-rtc",
> +		.owner = THIS_MODULE,
> +		.of_match_table = sp_rtc_of_match,
> +	},
> +};
> +module_platform_driver(sp_rtc_driver);
> +
> +MODULE_AUTHOR("Vincent Shih <vincent.shih@sunplus.com>");
> +MODULE_DESCRIPTION("Sunplus RTC driver");
> +MODULE_LICENSE("GPL v2");
> +
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
