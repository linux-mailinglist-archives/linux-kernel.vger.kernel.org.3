Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D050464152
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344626AbhK3Wft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:35:49 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:37853 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344545AbhK3Wf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:35:29 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 62E591C0004;
        Tue, 30 Nov 2021 22:32:05 +0000 (UTC)
Date:   Tue, 30 Nov 2021 23:32:05 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alexey Firago <alexey_firago@mentor.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/2] rtc: max31343: Add a driver for Maxim MAX31343
Message-ID: <YaamZW1nyOGDXfyw@piout.net>
References: <20211016192118.255624-1-alexey_firago@mentor.com>
 <20211016192118.255624-2-alexey_firago@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016192118.255624-2-alexey_firago@mentor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 16/10/2021 22:21:17+0300, Alexey Firago wrote:
> +#define MAX31343_REG_TIMER_CFG	(0x05)
> +#define  TIMER_CFG_TFS		GENMASK(1, 0) /* Timer frequency */
> +#define  TIMER_CFG_TRPT		BIT(2) /* Timer repeat mode */
> +#define  TIMER_CFG_TPAUSE	BIT(3) /* Timer Pause */
> +#define  TIMER_CFG_TE		BIT(4) /* Timer enable */
> +
> +/* RTC section */
> +#define MAX31343_REG_SEC	(0x06)
> +#define  SEC10_MASK	GENMASK(6, 4) /* RTC seconds in multiples of 10 */
> +#define  SEC_MASK	GENMASK(3, 0) /* RTC seconds value */

I'm not convinced having separate masks is useful here, was that
automatically generated?

> +static int max31343_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct max31343_rtc_data *max31343 = dev_get_drvdata(dev);
> +	u8 date[7];
> +	int ret;
> +
> +	dev_dbg(dev, "RTC set time %04d-%02d-%02d %02d/%02d/%02d\n",
> +		tm->tm_year + 1900, tm->tm_mon, tm->tm_mday,
> +		tm->tm_hour, tm->tm_min, tm->tm_sec);
> +

This could use %ptR

> +	date[0] = bin2bcd(tm->tm_sec);
> +	date[1] = bin2bcd(tm->tm_min);
> +	date[2] = bin2bcd(tm->tm_hour);
> +	date[3] = tm->tm_wday;
> +	date[4] = bin2bcd(tm->tm_mday);
> +	date[5] = bin2bcd(tm->tm_mon + 1);
> +
> +	if (tm->tm_year >= 200)
> +		date[5] |= CENTURY;
> +	date[6] = bin2bcd(tm->tm_year % 100);
> +
> +	ret = regmap_bulk_write(max31343->regmap, MAX31343_REG_SEC, date,
> +				sizeof(date));
> +	return ret;
> +}
> +

[...]

> +static int
> +max31343_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	struct max31343_rtc_data *max31343 = NULL;
> +	int ret, status;
> +	struct nvmem_config nvmem_cfg = {
> +		.name = "max31343_nvram",
> +		.word_size = 1,
> +		.stride = 1,
> +		.size = MAX31343_RAM_SIZE,
> +		.type = NVMEM_TYPE_BATTERY_BACKED,
> +		.reg_read = max31343_nvram_read,
> +		.reg_write = max31343_nvram_write,
> +	};
> +
> +	max31343 = devm_kzalloc(&client->dev, sizeof(struct max31343_rtc_data),
> +				GFP_KERNEL);
> +	if (!max31343)
> +		return -ENOMEM;
> +
> +	max31343->regmap = devm_regmap_init_i2c(client, &max31343_regmap_config);
> +	if (IS_ERR(max31343->regmap))
> +		return PTR_ERR(max31343->regmap);
> +
> +	i2c_set_clientdata(client, max31343);
> +
> +	ret = regmap_read(max31343->regmap, MAX31343_REG_STATUS, &status);
> +	if (ret < 0)
> +		return ret;
> +
> +	max31343->rtc = devm_rtc_allocate_device(&client->dev);
> +	if (IS_ERR(max31343->rtc))
> +		return PTR_ERR(max31343->rtc);
> +
> +	max31343->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> +	max31343->rtc->range_max = RTC_TIMESTAMP_END_2199;

For my information, did you check the time continuity in this interval?

> +	max31343->rtc->ops = &max31343_rtc_ops;
> +	ret = devm_rtc_register_device(max31343->rtc);
> +	if (ret)
> +		return ret;
> +
> +	nvmem_cfg.priv = max31343->regmap;
> +	devm_rtc_nvmem_register(max31343->rtc, &nvmem_cfg);
> +	max31343_hwmon_register(&client->dev);

The whole driver seems ok, I'd like to get a review from the hwmon
maintainers on the hwmon part as it is quite large.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
