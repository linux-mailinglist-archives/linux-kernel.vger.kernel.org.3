Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605F25505FD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 18:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbiFRQAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 12:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFRQAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 12:00:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB9513E1D;
        Sat, 18 Jun 2022 09:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EEB4B80A73;
        Sat, 18 Jun 2022 16:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA5FC3411A;
        Sat, 18 Jun 2022 16:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655568013;
        bh=f6eQqkMCCy7JOBuFzU98SzHbuGXhiTTDh0qo1FD3rRc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nKhv/oCvo3IgnfaeaZgect0mhgeASAg7V/biFCDZ7m2FENFdb4TigTTut6YEXBGs6
         dDrKDA86QOwfXUbLLOGy4pgpjp/WBrfuWbVtmUPe5Nyjq8wpkN0HSyZ3ld0kgx898T
         SdjW3VVBfmxzx7xdCAklxYwgNp9yVmeApzGHfAJ5GuQ5nB1faOwCwdmWvitNQHyyG/
         h7qEyk5P9Hyuw5xwOlpLGDkDT/sdkPdRhx428zzaRWJ2ZMnpfrfbUYlaUvml8vyL/5
         z6vgOjg4hqUHo6ZghCJRW0AfelETIteBBPG+80xjuu2aNJa3+9/p0FJ2wwiHPldVZ9
         xX7Jh3cum/qLg==
Date:   Sat, 18 Jun 2022 17:09:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     lars@metafoo.de, matthias.bgg@gmail.com, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, ChiaEn Wu <chiaen_wu@richtek.com>
Subject: Re: [PATCH v2 11/15] iio: adc: mt6370: Add Mediatek MT6370 support
Message-ID: <20220618170926.678dc05f@jic23-huawei>
In-Reply-To: <20220613111146.25221-12-peterwu.pub@gmail.com>
References: <20220613111146.25221-1-peterwu.pub@gmail.com>
        <20220613111146.25221-12-peterwu.pub@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2022 19:11:42 +0800
ChiaEn Wu <peterwu.pub@gmail.com> wrote:

> From: ChiaEn Wu <chiaen_wu@richtek.com>
> 
> Add Mediatek MT6370 ADC support.
> 
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>

Hi ChiaEn Wu,

A few comments inline, but mostly looks good to me
with the exception of the scales which look far too large.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig      |   9 ++
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/mt6370-adc.c | 262 +++++++++++++++++++++++++++++++++++
>  3 files changed, 272 insertions(+)
>  create mode 100644 drivers/iio/adc/mt6370-adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 71ab0a06aa82..09576fb478ad 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -737,6 +737,15 @@ config MEDIATEK_MT6360_ADC
>  	  is used in smartphones and tablets and supports a 11 channel
>  	  general purpose ADC.
>  
> +config MEDIATEK_MT6370_ADC
> +	tristate "Mediatek MT6370 ADC driver"
> +	depends on MFD_MT6370
> +	help
> +	  Say Y here to enable MT6370 ADC support.
> +
> +	  Integrated for System Monitoring includes is used in smartphones
> +	  and tablets and supports a 9 channel general purpose ADC.
> +
>  config MEDIATEK_MT6577_AUXADC
>  	tristate "MediaTek AUXADC driver"
>  	depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 39d806f6d457..0ce285c7e2d0 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_MCP320X) += mcp320x.o
>  obj-$(CONFIG_MCP3422) += mcp3422.o
>  obj-$(CONFIG_MCP3911) += mcp3911.o
>  obj-$(CONFIG_MEDIATEK_MT6360_ADC) += mt6360-adc.o
> +obj-$(CONFIG_MEDIATEK_MT6370_ADC) += mt6370-adc.o
>  obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
>  obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
>  obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
> diff --git a/drivers/iio/adc/mt6370-adc.c b/drivers/iio/adc/mt6370-adc.c
> new file mode 100644
> index 000000000000..c30e1290973a
> --- /dev/null
> +++ b/drivers/iio/adc/mt6370-adc.c
> @@ -0,0 +1,262 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <dt-bindings/iio/adc/mediatek,mt6370_adc.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

#include <linux/mod_devicetable.h>
rather than relying on indirect include for
struct of_device_id

We've just removed such an include path from IIO and had
to fix up a lot of drivers that falsely assumed that would
available.

> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define MT6370_REG_CHG_CTRL3		0x113 /* AICR */
> +#define MT6370_REG_CHG_CTRL7		0x117 /* ICHG */
> +#define MT6370_REG_CHG_ADC		0x121
> +#define MT6370_REG_ADC_DATA_H		0x14C
> +
> +#define MT6370_ADC_START_MASK		BIT(0)
> +#define MT6370_ADC_IN_SEL_MASK		GENMASK(7, 4)
> +#define MT6370_AICR_ICHG_MASK		GENMASK(7, 2)
> +
> +#define MT6370_AICR_400MA		0x6
> +#define MT6370_ICHG_500MA		0x4
> +#define MT6370_ICHG_900MA		0x8
> +
> +#define ADC_CONV_TIME_US		35000
> +#define ADC_CONV_POLLING_TIME		1000
> +
> +struct mt6370_adc_data {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct mutex adc_lock;
Please document scope of the lock.  I think it's to synchronize
access to the device state concerned with channel reads, but there
should be a comment here to say something about that.
> +};
> +
> +static int mt6370_adc_read_channel(struct mt6370_adc_data *priv, int chan,
> +				   unsigned long addr, int *val)
> +{
> +	__be16 be_val;
> +	unsigned int reg_val;
> +	int ret;
> +
> +	mutex_lock(&priv->adc_lock);
> +
> +	reg_val = MT6370_ADC_START_MASK |
> +		  FIELD_PREP(MT6370_ADC_IN_SEL_MASK, addr);
> +	ret = regmap_write(priv->regmap, MT6370_REG_CHG_ADC, reg_val);
> +	if (ret)
> +		goto adc_unlock;
> +
> +	msleep(ADC_CONV_TIME_US / 1000);
> +
> +	ret = regmap_read_poll_timeout(priv->regmap,
> +				       MT6370_REG_CHG_ADC, reg_val,
> +				       !(reg_val & MT6370_ADC_START_MASK),
> +				       ADC_CONV_POLLING_TIME,
> +				       ADC_CONV_TIME_US * 3);
> +	if (ret) {
> +		if (ret == -ETIMEDOUT)
> +			dev_err(priv->dev, "Failed to wait adc conversion\n");
Why are any other error here not worth reporting?  I'd print a message for
all return values.

> +		goto adc_unlock;
> +	}
> +
> +	ret = regmap_raw_read(priv->regmap, MT6370_REG_ADC_DATA_H,
> +			      &be_val, sizeof(be_val));
> +	if (ret)
> +		goto adc_unlock;
> +
> +	*val = be16_to_cpu(be_val);
> +	ret = IIO_VAL_INT;
> +
> +adc_unlock:
> +	mutex_unlock(&priv->adc_lock);
> +
> +	return ret;
> +}
> +
> +static int mt6370_adc_read_scale(struct mt6370_adc_data *priv,
> +				 int chan, int *val1, int *val2)
> +{
> +	unsigned int reg_val;
> +	int ret;
> +
> +	switch (chan) {
> +	case MT6370_CHAN_VBAT:
> +	case MT6370_CHAN_VSYS:
> +	case MT6370_CHAN_CHG_VDDP:
> +		*val1 = 5;
> +		return IIO_VAL_INT;
> +	case MT6370_CHAN_IBUS:
> +		ret = regmap_read(priv->regmap, MT6370_REG_CHG_CTRL3, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		reg_val = FIELD_GET(MT6370_AICR_ICHG_MASK, reg_val);
> +		if (reg_val < MT6370_AICR_400MA)
> +			*val1 = 33500;

As (scale * raw) must give a value in milliamps, this seems very large as
each ADC reading currently represents 33Amps. That would make an impressive
PMIC!)

Same for the various entries below.  Note that scale is often
not an integer value (or even as large as 1) Hence the many different precisions
of data type that IIO provides and the useful types like IIO_VAL_FRACTIONAL;


> +		else
> +			*val1 = 50000;
> +
> +		return IIO_VAL_INT;
> +	case MT6370_CHAN_IBAT:
> +		ret = regmap_read(priv->regmap, MT6370_REG_CHG_CTRL7, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		reg_val = FIELD_GET(MT6370_AICR_ICHG_MASK, reg_val);
> +		if (reg_val < MT6370_ICHG_500MA)
> +			*val1 = 23750;
> +		else if (reg_val >= MT6370_ICHG_500MA &&
> +			 reg_val < MT6370_ICHG_900MA)
> +			*val1 = 26800;
> +		else
> +			*val1 = 50000;
> +
> +		return IIO_VAL_INT;
> +	case MT6370_CHAN_VBUSDIV5:
> +		*val1 = 25000;
> +		return IIO_VAL_INT;
> +	case MT6370_CHAN_VBUSDIV2:
> +		*val1 = 50000;
> +		return IIO_VAL_INT;
> +	case MT6370_CHAN_TS_BAT:
> +		*val1 = 25;
> +		*val2 = 10000;
> +		return IIO_VAL_FRACTIONAL;
> +	case MT6370_CHAN_TEMP_JC:
> +		*val1 = 2;
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
As below, I'd prefer this as a default: in the switch statement.

> +}
> +

...

> +
> +static int mt6370_adc_read_raw(struct iio_dev *iio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       int *val, int *val2, long mask)
> +{
> +	struct mt6370_adc_data *priv = iio_priv(iio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return mt6370_adc_read_channel(priv, chan->channel,
> +					       chan->address, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		return mt6370_adc_read_scale(priv, chan->channel, val, val2);
> +	case IIO_CHAN_INFO_OFFSET:
> +		return mt6370_adc_read_offset(priv, chan->channel, val);
> +	}
> +
> +	return -EINVAL;
Add a default to the switch statement and return -EINVAL in there.
That makes it explicit that you are handling all the cases you
care about.

Sure, right now it's obvious that is the case, but it might not be so
obvious if more code happens to get added here in future.

> +}
> +
>

