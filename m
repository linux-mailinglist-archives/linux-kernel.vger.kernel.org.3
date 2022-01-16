Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116D448FFA2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 00:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbiAPXVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 18:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiAPXVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 18:21:42 -0500
X-Greylist: delayed 1397 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Jan 2022 15:21:42 PST
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4ADC061574;
        Sun, 16 Jan 2022 15:21:41 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DBF0E20003;
        Sun, 16 Jan 2022 23:21:36 +0000 (UTC)
Date:   Mon, 17 Jan 2022 00:21:36 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     qianfanguijin@qq.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        a.zummo@towertech.it, qianfan Zhao <qianfanguijin@163.com>
Subject: Re: [PATCH] drivers: rtc: Add new rtc-rx8025t for EPSON RX8025-T
Message-ID: <YeSogPnxaAFvyhVK@piout.net>
References: <tencent_61ABA73477AC0DA2AD8C61A8A5D57AF8E209@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_61ABA73477AC0DA2AD8C61A8A5D57AF8E209@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 21/12/2021 10:22:59+0800, qianfanguijin@qq.com wrote:
> From: qianfan Zhao <qianfanguijin@163.com>
> 
> Supported features:
> - Date/time
> - Alarms
> - Low voltage detection
> 
> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> ---
>  drivers/rtc/Kconfig       |   9 +
>  drivers/rtc/Makefile      |   1 +
>  drivers/rtc/rtc-rx8025t.c | 588 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 598 insertions(+)
>  create mode 100644 drivers/rtc/rtc-rx8025t.c
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 65ad9d0b47ab..a0960f0cb7f9 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -650,6 +650,15 @@ config RTC_DRV_RX8025
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-rx8025.
>  
> +config RTC_DRV_RX8025T
> +	tristate "Epson RX-8025T"
> +	help
> +	  If you say yes here you get support for the Epson
> +	  RX-8025T RTC chips.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called rtc-rx8025t.
> +
>  config RTC_DRV_EM3027
>  	tristate "EM Microelectronic EM3027"
>  	help
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index bfb57464118d..5ecf6e7868fe 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -147,6 +147,7 @@ obj-$(CONFIG_RTC_DRV_RX4581)	+= rtc-rx4581.o
>  obj-$(CONFIG_RTC_DRV_RX6110)	+= rtc-rx6110.o
>  obj-$(CONFIG_RTC_DRV_RX8010)	+= rtc-rx8010.o
>  obj-$(CONFIG_RTC_DRV_RX8025)	+= rtc-rx8025.o
> +obj-$(CONFIG_RTC_DRV_RX8025T)	+= rtc-rx8025t.o
>  obj-$(CONFIG_RTC_DRV_RX8581)	+= rtc-rx8581.o
>  obj-$(CONFIG_RTC_DRV_S35390A)	+= rtc-s35390a.o
>  obj-$(CONFIG_RTC_DRV_S3C)	+= rtc-s3c.o
> diff --git a/drivers/rtc/rtc-rx8025t.c b/drivers/rtc/rtc-rx8025t.c
> new file mode 100644
> index 000000000000..093a88b1c788
> --- /dev/null
> +++ b/drivers/rtc/rtc-rx8025t.c
> @@ -0,0 +1,588 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for the Epson RTC module RX-8025 T

Is the datasheet publicly available? I'm not sure this actually needs
yet another driver

> + * Based on rtc-rx8010.c

I'm not sure this is relevant. why not rtc-rx8025.c, why did you chose
to write a third driver for this RTC?

> + *
> + * Copyright(C) 2021 qianfan Zhao <qianfanguijin@163.com>
> + */
> +
> +#include <linux/bcd.h>
> +#include <linux/bitops.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/rtc.h>
> +
> +#define RX8025T_SEC			0x00
> +#define RX8025T_MIN			0x01
> +#define RX8025T_HOUR			0x02
> +#define RX8025T_WDAY			0x03
> +#define RX8025T_MDAY			0x04
> +#define RX8025T_MONTH			0x05
> +#define RX8025T_YEAR			0x06
> +#define RX8025T_RAM			0x07
> +#define RX8025T_ALMIN			0x08
> +#define RX8025T_ALHOUR			0x09
> +#define RX8025T_ALWDAY			0x0A
> +#define RX8025T_TCOUNT0			0x0B
> +#define RX8025T_TCOUNT1			0x0C
> +#define RX8025T_EXT			0x0D
> +#define RX8025T_FLAG			0x0E
> +#define RX8025T_CTRL			0x0F
> +
> +/* Extension Register (1Dh) bit positions */
> +#define RX8025T_EXT_TSEL0		BIT(0)
> +#define RX8025T_EXT_TSEL1		BIT(1)
> +#define RX8025T_EXT_FSEL0		BIT(2)
> +#define RX8025T_EXT_FSEL1		BIT(3)
> +#define RX8025T_EXT_TE			BIT(4)
> +#define RX8025T_EXT_USEL		BIT(5)
> +#define RX8025T_EXT_WADA		BIT(6)
> +#define RX8025T_EXT_TEST		BIT(7)
> +
> +/* Flag Register (1Eh) bit positions */
> +#define RX8025T_FLAG_VDET		BIT(0)
> +#define RX8025T_FLAG_VLF		BIT(1)
> +#define RX8025T_FLAG_AF			BIT(3)
> +#define RX8025T_FLAG_TF			BIT(4)
> +#define RX8025T_FLAG_UF			BIT(5)
> +
> +/* Control Register (1Fh) bit positions */
> +#define RX8025T_CTRL_RESET		BIT(0)
> +#define RX8025T_CTRL_AIE		BIT(3)
> +#define RX8025T_CTRL_TIE		BIT(4)
> +#define RX8025T_CTRL_UIE		BIT(5)
> +#define RX8025T_CTRL_CSEL0		BIT(6)
> +#define RX8025T_CTRL_CSEL1		BIT(7)

1D, 1E and 1F doesn't seem to be existing on that RTC, are those
leftovers?

> +
> +#define RX8025T_ALARM_AE		BIT(7)
> +
> +/* RX8025T vendor ioctls */
> +#define RX8025T_IOCTL_GET_TYPE		_IOR('T', 0x10, unsigned int)
> +#define RX8025T_IOCTL_WRITE_REG		_IOW('T', 0x20, unsigned int)
> +#define RX8025T_IOCTL_READ_REG		_IOR('T', 0x30, unsigned int)
> +#define RX8025T_IOCTL_RD_DATE_RAW	_IOR('T', 0x40, __u8[7]) /* ignore VLF */
> +

Vendor ioctls are not allowed

> +static const struct i2c_device_id rx8025t_id[] = {
> +	{ "rx8025t", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, rx8025t_id);
> +
> +static const struct of_device_id rx8025t_of_match[] = {
> +	{ .compatible = "epson,rx8025t" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, rx8025t_of_match);
> +
> +struct rx8025t_data {
> +	struct regmap *regs;
> +	struct rtc_device *rtc;
> +};
> +
> +static int rx8025t_set_update_irq(struct device *dev, unsigned int enable)
> +{
> +	struct rx8025t_data *rx8025t = dev_get_drvdata(dev);
> +	int err;
> +
> +	err = regmap_write_bits(rx8025t->regs, RX8025T_CTRL, RX8025T_CTRL_UIE,
> +				enable ? RX8025T_CTRL_UIE : 0);
> +	if (err)
> +		dev_err(dev, "%sable update irq failed\n",
> +			enable ? "en" : "dis");
> +
> +	return err;
> +}
> +
> +static int rx8025t_set_freq_out(struct device *dev, u32 freq)
> +{
> +	struct rx8025t_data *rx8025t = dev_get_drvdata(dev);
> +	unsigned int fsel;
> +	int err;
> +
> +	switch (freq) {
> +	default: /* 32768 */
> +		fsel = 0;
> +		break;
> +	case 1024:
> +		fsel = RX8025T_EXT_FSEL0;
> +		break;
> +	case 1:
> +		fsel = RX8025T_EXT_FSEL1;
> +		break;
> +	}
> +
> +	err = regmap_write_bits(rx8025t->regs, RX8025T_EXT,
> +				RX8025T_EXT_FSEL0 | RX8025T_EXT_FSEL1,
> +				fsel);
> +	if (err)
> +		dev_err(dev, "set output frequency failed\n");
> +
> +	return err;

Please use the CCF for that.

> +}
> +
> +static int rx8025t_set_compensation_interval(struct device *dev, u32 ms)
> +{
> +	struct rx8025t_data *rx8025t = dev_get_drvdata(dev);
> +	unsigned int csel;
> +	int err;
> +
> +	switch (ms) {
> +	default: /* 2000 */
> +		csel = RX8025T_CTRL_CSEL0;
> +		break;
> +	case 500:
> +		csel = 0;
> +		break;
> +	case 10000:
> +		csel = RX8025T_CTRL_CSEL1;
> +		break;
> +	case 30000:
> +		csel = RX8025T_CTRL_CSEL0 | RX8025T_CTRL_CSEL1;
> +		break;
> +	}
> +
> +	err = regmap_write_bits(rx8025t->regs, RX8025T_CTRL,
> +				RX8025T_CTRL_CSEL0 | RX8025T_CTRL_CSEL1,
> +				csel);
> +	if (err)
> +		dev_err(dev, "set compensation interval failed\n");
> +
> +	return err;
> +}
> +
> +static irqreturn_t rx8025t_irq_1_handler(int irq, void *dev_id)
> +{
> +	struct i2c_client *client = dev_id;
> +	struct rx8025t_data *rx8025t = i2c_get_clientdata(client);
> +	int flagreg, err;
> +
> +	mutex_lock(&rx8025t->rtc->ops_lock);
> +
> +	err = regmap_read(rx8025t->regs, RX8025T_FLAG, &flagreg);
> +	if (err) {
> +		mutex_unlock(&rx8025t->rtc->ops_lock);
> +		return IRQ_NONE;
> +	}
> +
> +	if (flagreg & RX8025T_FLAG_VLF)
> +		dev_warn(&client->dev, "Frequency stop detected\n");

Is the warning useful? Who do you expect to read the kernel logs?

> +
> +	if (flagreg & RX8025T_FLAG_TF) {
> +		flagreg &= ~RX8025T_FLAG_TF;
> +		rtc_update_irq(rx8025t->rtc, 1, RTC_PF | RTC_IRQF);
> +	}

This will never happen

> +
> +	if (flagreg & RX8025T_FLAG_AF) {
> +		flagreg &= ~RX8025T_FLAG_AF;
> +		rtc_update_irq(rx8025t->rtc, 1, RTC_AF | RTC_IRQF);
> +	}
> +
> +	if (flagreg & RX8025T_FLAG_UF) {
> +		flagreg &= ~RX8025T_FLAG_UF;
> +		rtc_update_irq(rx8025t->rtc, 1, RTC_UF | RTC_IRQF);
> +	}
> +
> +	err = regmap_write(rx8025t->regs, RX8025T_FLAG, flagreg);
> +	mutex_unlock(&rx8025t->rtc->ops_lock);
> +	return err ? IRQ_NONE : IRQ_HANDLED;
> +}
> +
> +static int rx8025t_get_time(struct device *dev, struct rtc_time *dt)
> +{
> +	struct rx8025t_data *rx8025t = dev_get_drvdata(dev);
> +	u8 date[RX8025T_YEAR - RX8025T_SEC + 1];
> +	int flagreg, err;
> +
> +	err = regmap_read(rx8025t->regs, RX8025T_FLAG, &flagreg);
> +	if (err)
> +		return err;
> +
> +	if (flagreg & RX8025T_FLAG_VLF) {
> +		dev_warn(dev, "Frequency stop detected\n");
> +		return -EINVAL;
> +	}
> +
> +	err = regmap_bulk_read(rx8025t->regs, RX8025T_SEC, date, sizeof(date));
> +	if (err)
> +		return err;
> +
> +	dt->tm_sec = bcd2bin(date[RX8025T_SEC - RX8025T_SEC] & 0x7f);
> +	dt->tm_min = bcd2bin(date[RX8025T_MIN - RX8025T_SEC] & 0x7f);
> +	dt->tm_hour = bcd2bin(date[RX8025T_HOUR - RX8025T_SEC] & 0x3f);
> +	dt->tm_mday = bcd2bin(date[RX8025T_MDAY - RX8025T_SEC] & 0x3f);
> +	dt->tm_mon = bcd2bin(date[RX8025T_MONTH - RX8025T_SEC] & 0x1f) - 1;
> +	dt->tm_year = bcd2bin(date[RX8025T_YEAR - RX8025T_SEC]) + 100;
> +	dt->tm_wday = ffs(date[RX8025T_WDAY - RX8025T_SEC] & 0x7f);
> +
> +	return 0;
> +}
> +
> +static int rx8025t_set_time(struct device *dev, struct rtc_time *dt)
> +{
> +	struct rx8025t_data *rx8025t = dev_get_drvdata(dev);
> +	u8 date[RX8025T_YEAR - RX8025T_SEC + 1];
> +	int err;
> +
> +	date[RX8025T_SEC - RX8025T_SEC] = bin2bcd(dt->tm_sec);
> +	date[RX8025T_MIN - RX8025T_SEC] = bin2bcd(dt->tm_min);
> +	date[RX8025T_HOUR - RX8025T_SEC] = bin2bcd(dt->tm_hour);
> +	date[RX8025T_MDAY - RX8025T_SEC] = bin2bcd(dt->tm_mday);
> +	date[RX8025T_MONTH - RX8025T_SEC] = bin2bcd(dt->tm_mon + 1);
> +	date[RX8025T_YEAR - RX8025T_SEC] = bin2bcd(dt->tm_year - 100);
> +	date[RX8025T_WDAY - RX8025T_SEC] = bin2bcd(1 << dt->tm_wday);
> +
> +	err = regmap_bulk_write(rx8025t->regs, RX8025T_SEC, date, sizeof(date));
> +	if (err)
> +		return err;
> +
> +	err = regmap_clear_bits(rx8025t->regs, RX8025T_FLAG, RX8025T_FLAG_VLF);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static void rx8025t_patch_hardware_features(struct device *dev)
> +{
> +	bool default_on;
> +	u32 tmpval;
> +
> +	if (!device_property_read_u32(dev, "frequency-out", &tmpval))
> +		rx8025t_set_freq_out(dev, tmpval);
> +
> +	if (!device_property_read_u32(dev, "compensation-interval-ms", &tmpval))
> +		rx8025t_set_compensation_interval(dev, tmpval);
> +
> +	default_on = device_property_present(dev, "update-irq-default-on");
> +	rx8025t_set_update_irq(dev, default_on);

Custom device tree properties have to be documented and you have to have
a god reason for them.

> +}
> +
> +static int rx8025t_init(struct device *dev)
> +{
> +	struct rx8025t_data *rx8025t = dev_get_drvdata(dev);
> +	unsigned int ctrl;
> +	int need_clear = 0, err;
> +
> +	err = regmap_read(rx8025t->regs, RX8025T_FLAG, &ctrl);
> +	if (err)
> +		return err;
> +
> +	if (ctrl & RX8025T_FLAG_VLF)
> +		dev_warn(dev, "Frequency stop was detected\n");
> +
> +	if (ctrl & RX8025T_FLAG_AF) {
> +		dev_warn(dev, "Alarm was detected\n");
> +		need_clear = 1;
> +	}
> +
> +	if (ctrl & RX8025T_FLAG_TF)
> +		need_clear = 1;
> +
> +	if (ctrl & RX8025T_FLAG_UF)
> +		need_clear = 1;
> +
> +	if (need_clear) {
> +		ctrl &= ~(RX8025T_FLAG_AF | RX8025T_FLAG_TF | RX8025T_FLAG_UF);
> +		err = regmap_write(rx8025t->regs, RX8025T_FLAG, ctrl);
> +		if (err)
> +			return err;
> +	}
> +
> +	rx8025t_patch_hardware_features(dev);
> +	return 0;
> +}
> +
> +static int rx8025t_read_alarm(struct device *dev, struct rtc_wkalrm *t)
> +{
> +	struct rx8025t_data *rx8025t = dev_get_drvdata(dev);
> +	u8 alarmvals[3];
> +	int flagreg, ctrlreg, err;
> +
> +	err = regmap_read(rx8025t->regs, RX8025T_CTRL, &ctrlreg);
> +	if (err)
> +		return err;
> +
> +	err = regmap_bulk_read(rx8025t->regs, RX8025T_ALMIN, alarmvals, 3);
> +	if (err)
> +		return err;
> +
> +	err = regmap_read(rx8025t->regs, RX8025T_FLAG, &flagreg);
> +	if (err)
> +		return err;
> +
> +	t->time.tm_sec = 0;
> +	t->time.tm_min = bcd2bin(alarmvals[0] & 0x7f);
> +	t->time.tm_hour = bcd2bin(alarmvals[1] & 0x3f);
> +
> +	if (!(alarmvals[2] & RX8025T_ALARM_AE))
> +		t->time.tm_mday = bcd2bin(alarmvals[2] & 0x7f);
> +
> +	t->enabled = !!(ctrlreg & RX8025T_CTRL_AIE);
> +	t->pending = (flagreg & RX8025T_FLAG_AF) && t->enabled;
> +
> +	return 0;
> +}
> +
> +static int rx8025t_set_alarm(struct device *dev, struct rtc_wkalrm *t)
> +{
> +	struct rx8025t_data *rx8025t = dev_get_drvdata(dev);
> +	u8 alarmvals[3];
> +	int ctrlreg;
> +	int err;
> +
> +	err = regmap_read(rx8025t->regs, RX8025T_CTRL, &ctrlreg);
> +	if (err)
> +		return err;
> +
> +	if (ctrlreg & (RX8025T_CTRL_AIE | RX8025T_CTRL_UIE)) {
> +		ctrlreg &= ~(RX8025T_CTRL_AIE | RX8025T_CTRL_UIE);
> +		err = regmap_write(rx8025t->regs, RX8025T_CTRL, ctrlreg);
> +		if (err)
> +			return err;
> +	}
> +
> +	err = regmap_clear_bits(rx8025t->regs, RX8025T_FLAG, RX8025T_FLAG_AF);
> +	if (err)
> +		return err;
> +
> +	alarmvals[0] = bin2bcd(t->time.tm_min);
> +	alarmvals[1] = bin2bcd(t->time.tm_hour);
> +	alarmvals[2] = bin2bcd(t->time.tm_mday);
> +
> +	err = regmap_bulk_write(rx8025t->regs, RX8025T_ALMIN, alarmvals, 2);
> +	if (err)
> +		return err;
> +
> +	err = regmap_clear_bits(rx8025t->regs, RX8025T_EXT, RX8025T_EXT_WADA);
> +	if (err)
> +		return err;
> +
> +	if (alarmvals[2] == 0)
> +		alarmvals[2] |= RX8025T_ALARM_AE;
> +
> +	err = regmap_write(rx8025t->regs, RX8025T_ALWDAY, alarmvals[2]);
> +	if (err)
> +		return err;
> +
> +	if (t->enabled) {
> +		if (rx8025t->rtc->uie_rtctimer.enabled)
> +			ctrlreg |= RX8025T_CTRL_UIE;
> +		if (rx8025t->rtc->aie_timer.enabled)
> +			ctrlreg |= (RX8025T_CTRL_AIE | RX8025T_CTRL_UIE);
> +
> +		err = regmap_write(rx8025t->regs, RX8025T_CTRL, ctrlreg);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rx8025t_alarm_irq_enable(struct device *dev,
> +				   unsigned int enabled)
> +{
> +	struct rx8025t_data *rx8025t = dev_get_drvdata(dev);
> +	int ctrlreg, err;
> +	u8 ctrl;
> +
> +	err = regmap_read(rx8025t->regs, RX8025T_CTRL, &ctrlreg);
> +	if (err)
> +		return err;
> +
> +	ctrl = ctrlreg;
> +
> +	if (enabled) {
> +		if (rx8025t->rtc->uie_rtctimer.enabled)
> +			ctrl |= RX8025T_CTRL_UIE;
> +		if (rx8025t->rtc->aie_timer.enabled)
> +			ctrl |= (RX8025T_CTRL_AIE | RX8025T_CTRL_UIE);
> +	} else {
> +		if (!rx8025t->rtc->uie_rtctimer.enabled)
> +			ctrl &= ~RX8025T_CTRL_UIE;
> +		if (!rx8025t->rtc->aie_timer.enabled)
> +			ctrl &= ~RX8025T_CTRL_AIE;
> +	}
> +
> +	err = regmap_clear_bits(rx8025t->regs, RX8025T_FLAG, RX8025T_FLAG_AF);
> +	if (err)
> +		return err;
> +
> +	if (ctrl != ctrlreg) {
> +		err = regmap_write(rx8025t->regs, RX8025T_CTRL, ctrl);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rx8025t_ioctl_write_reg(struct device *dev, int reg, u8 mask, u8 val)
> +{
> +	struct rx8025t_data *rx8025t = dev_get_drvdata(dev);
> +
> +	switch (reg) {
> +	case RX8025T_RAM:
> +	case RX8025T_TCOUNT0:
> +	case RX8025T_TCOUNT1:
> +		mask = 0xff;
> +		break;
> +	case RX8025T_EXT:
> +		mask &= ~(RX8025T_EXT_TEST | RX8025T_EXT_WADA);
> +		break;
> +	case RX8025T_CTRL:
> +		mask &= ~(RX8025T_CTRL_AIE | RX8025T_CTRL_RESET);
> +		break;
> +	default:
> +		/* write those register are forbidden */
> +		return -EINVAL;
> +	}
> +
> +	if (unlikely(mask == 0))
> +		return -EINVAL;
> +
> +	return regmap_write_bits(rx8025t->regs, reg, mask, val);
> +}
> +
> +static int rx8025t_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
> +{
> +	struct rx8025t_data *rx8025t = dev_get_drvdata(dev);
> +	int tmp, flagreg, err;
> +	u8 reg, date[7];
> +
> +	switch (cmd) {
> +	case RTC_VL_READ:
> +		err = regmap_read(rx8025t->regs, RX8025T_FLAG, &flagreg);
> +		if (err)
> +			return err;
> +
> +		tmp = flagreg & RX8025T_FLAG_VLF ? RTC_VL_DATA_INVALID : 0;
> +		return put_user(tmp, (unsigned int __user *)arg);
> +
> +	case RTC_VL_CLR:
> +		return regmap_clear_bits(rx8025t->regs, RX8025T_FLAG,
> +					 RX8025T_FLAG_VLF);
> +
> +	case RX8025T_IOCTL_WRITE_REG:
> +		if (get_user(tmp, (unsigned int __user *)arg) < 0)
> +			return -EFAULT;
> +
> +		reg = (tmp >> 16) & 0xff;
> +		return rx8025t_ioctl_write_reg(dev, reg,
> +					       (tmp >> 8) & 0xff /* mask */,
> +					       (tmp >> 0) & 0xff /* val */);
> +
> +	case RX8025T_IOCTL_READ_REG:
> +		if (get_user(tmp, (unsigned int __user *)arg) < 0)
> +			return -EFAULT;
> +
> +		reg = tmp & 0xff;
> +		if (reg < RX8025T_SEC || reg > RX8025T_CTRL)
> +			return -EINVAL;
> +
> +		err = regmap_read(rx8025t->regs, reg, &tmp);
> +		if (err)
> +			return err;
> +
> +		return put_user(tmp, (unsigned int __user *)arg);
> +
> +	case RX8025T_IOCTL_GET_TYPE:
> +		tmp = 0x802554;
> +		return put_user(tmp, (unsigned int __user *)arg);
> +
> +	case RX8025T_IOCTL_RD_DATE_RAW:
> +		err = regmap_bulk_read(rx8025t->regs, RX8025T_SEC, date,
> +				       sizeof(date));
> +		if (err)
> +			return err;
> +
> +		return copy_to_user((__u8 __user *)arg, date, sizeof(date));
> +
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +}
> +
> +static const struct rtc_class_ops rx8025t_rtc_ops_default = {
> +	.read_time = rx8025t_get_time,
> +	.set_time = rx8025t_set_time,
> +	.ioctl = rx8025t_ioctl,
> +};
> +
> +static const struct rtc_class_ops rx8025t_rtc_ops_alarm = {
> +	.read_time = rx8025t_get_time,
> +	.set_time = rx8025t_set_time,
> +	.ioctl = rx8025t_ioctl,
> +	.read_alarm = rx8025t_read_alarm,
> +	.set_alarm = rx8025t_set_alarm,
> +	.alarm_irq_enable = rx8025t_alarm_irq_enable,
> +};
> +
> +static const struct regmap_config rx8025t_regmap_config = {
> +	.name = "rx8025t-rtc",
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static int rx8025t_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct rx8025t_data *rx8025t;
> +	int err = 0;
> +
> +	rx8025t = devm_kzalloc(dev, sizeof(*rx8025t), GFP_KERNEL);
> +	if (!rx8025t)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, rx8025t);
> +
> +	rx8025t->regs = devm_regmap_init_i2c(client, &rx8025t_regmap_config);
> +	if (IS_ERR(rx8025t->regs))
> +		return PTR_ERR(rx8025t->regs);
> +
> +	err = rx8025t_init(dev);
> +	if (err)
> +		return err;
> +
> +	rx8025t->rtc = devm_rtc_allocate_device(dev);
> +	if (IS_ERR(rx8025t->rtc))
> +		return PTR_ERR(rx8025t->rtc);
> +
> +	if (client->irq > 0) {
> +		dev_info(dev, "IRQ %d supplied\n", client->irq);
> +		err = devm_request_threaded_irq(dev, client->irq, NULL,
> +						rx8025t_irq_1_handler,
> +						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +						"rx8025t", client);
> +		if (err) {
> +			dev_err(dev, "unable to request IRQ\n");
> +			return err;
> +		}
> +
> +		rx8025t->rtc->ops = &rx8025t_rtc_ops_alarm;
> +	} else {
> +		rx8025t->rtc->ops = &rx8025t_rtc_ops_default;
> +	}
> +
> +	rx8025t->rtc->max_user_freq = 1;
> +	rx8025t->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> +	rx8025t->rtc->range_max = RTC_TIMESTAMP_END_2099;
> +
> +	return rtc_register_device(rx8025t->rtc);
> +}
> +
> +static struct i2c_driver rx8025t_driver = {
> +	.driver = {
> +		.name = "rtc-rx8025t",
> +		.of_match_table = of_match_ptr(rx8025t_of_match),
> +	},
> +	.probe_new	= rx8025t_probe,
> +	.id_table	= rx8025t_id,
> +};
> +
> +module_i2c_driver(rx8025t_driver);
> +
> +MODULE_AUTHOR("qianfan Zhao <qianfanguijin@163.com>");
> +MODULE_DESCRIPTION("Epson RX8025T RTC driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
