Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E673955AA10
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 14:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbiFYMpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 08:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiFYMpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 08:45:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAE3EE3B;
        Sat, 25 Jun 2022 05:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 452B061203;
        Sat, 25 Jun 2022 12:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D29FC3411C;
        Sat, 25 Jun 2022 12:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656161103;
        bh=jtBOB+fEQAt8XVOj1YNbq/Dy66rjLUV3m39esLC9KpM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lh1W4tH+kxjI+Tw/faCkYC40dOFtswR21Dr9YpHd9I5Z7AY0n+239LZ0xM7XNGciG
         /YPSQuMCuJFVqWMnnfzik6SFywa0c/HbU8mLQOmywALNDFOeyR6UPM07b/MwQCVDJT
         nKCnCCQCVD1TbQ2FdlteYVQME/v2LHwFZ8qJcyb/BKyfDcf/ug5P595rf+2yEvNKK6
         gpN/bKzJAnD/c5f+7Xu0S8y3x9ejS7XqwOKUTG4RAEJV/+2EeYU3KuE6fKMl4BK8mv
         QMldjqu7RGlpBOqgedNXXUdpABrgy0+PSz4F1bjW1gPBz6FpkFErF/WuPyBgEbC7rF
         ADpiQzXq2XMMg==
Date:   Sat, 25 Jun 2022 13:54:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] iio: adc: mcp3911: add support to set PGA
Message-ID: <20220625135431.3f82148a@jic23-huawei>
In-Reply-To: <20220625103853.2470346-10-marcus.folkesson@gmail.com>
References: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
        <20220625103853.2470346-10-marcus.folkesson@gmail.com>
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

On Sat, 25 Jun 2022 12:38:53 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Add support for setting the Programmable Gain Amplifiers by adjust the
> scale value.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
A few minor things inline.

Thanks,

Jonathan

> ---
> 
> Notes:
>     v2:
>         - add missing comma
>         - Address comments from Andy Shevchenko
> 
>  drivers/iio/adc/mcp3911.c | 134 +++++++++++++++++++++++++++++++-------
>  1 file changed, 110 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index a019264e73e3..f0179385485f 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -26,6 +26,8 @@
>  #define MCP3911_REG_MOD			0x06
>  #define MCP3911_REG_PHASE		0x07
>  #define MCP3911_REG_GAIN		0x09
> +#define MCP3911_GAIN_MASK(ch)          (0x7 << 3*ch)
> +#define MCP3911_GAIN_VAL(ch, val)      ((val << 3*ch) & MCP3911_GAIN_MASK(ch))
>  
>  #define MCP3911_REG_STATUSCOM		0x0a
>  #define MCP3911_STATUSCOM_DRHIZ         BIT(12)
> @@ -55,8 +57,10 @@
>  #define MCP3911_REG_WRITE(reg, id)	((((reg) << 1) | ((id) << 5) | (0 << 0)) & 0xff)
>  
>  #define MCP3911_NUM_CHANNELS		2
> +#define MCP3911_NUM_SCALES		6
>  
>  static const int mcp3911_osr_table[] = {32, 64, 128, 256, 512, 1024, 2048, 4096};
> +static u32 mcp3911_scale_table[MCP3911_NUM_SCALES][2];
>  
>  struct mcp3911 {
>  	struct spi_device *spi;
> @@ -65,6 +69,7 @@ struct mcp3911 {
>  	struct clk *clki;
>  	u32 dev_addr;
>  	struct iio_trigger *trig;
> +	u32 gain[MCP3911_NUM_CHANNELS];
>  	struct {
>  		u32 channels[2];
>  		s64 ts __aligned(8);
> @@ -113,6 +118,37 @@ static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask,
>  	return mcp3911_write(adc, reg, val, len);
>  }
>  
> +static int mcp3911_get_gain(struct mcp3911 *adc, u8 channel, u32 *val)
> +{
> +	int ret;
> +
> +	ret = mcp3911_read(adc, MCP3911_REG_GAIN, val, 1);
> +	if (ret)
> +		return ret;
> +
> +	*val >>= channel * 3;
> +	*val &= GENMASK(2, 0);
> +	*val = BIT(*val);
> +
> +	return 0;
> +}
> +
> +static int mcp3911_write_raw_get_fmt(struct iio_dev *indio_dev,
> +					struct iio_chan_spec const *chan,
> +					long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_PHASE:
> +		return IIO_VAL_INT;

Ah. here is what I asked for earlier. Please move it back to the
patches that introduced the other features.

> +	default:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	}
> +}
> +
>  static int mcp3911_read_avail(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *chan,
>  			     const int **vals, int *type, int *length,
> @@ -124,6 +160,11 @@ static int mcp3911_read_avail(struct iio_dev *indio_dev,
>  		*vals = mcp3911_osr_table;
>  		*length = ARRAY_SIZE(mcp3911_osr_table);
>  		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SCALE:
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		*vals = (int *)mcp3911_scale_table;
> +		*length = ARRAY_SIZE(mcp3911_scale_table) * 2;
> +		return IIO_AVAIL_LIST;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -180,29 +221,9 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
>  		break;
>  
>  	case IIO_CHAN_INFO_SCALE:
> -		if (adc->vref) {
> -			ret = regulator_get_voltage(adc->vref);
> -			if (ret < 0) {
> -				dev_err(indio_dev->dev.parent,
> -					"failed to get vref voltage: %d\n",
> -				       ret);
> -				goto out;
> -			}
> -
> -			*val = ret / 1000;
> -		} else {
> -			*val = MCP3911_INT_VREF_MV;
> -		}
> -
> -		/*
> -		 * For 24bit Conversion
> -		 * Raw = ((Voltage)/(Vref) * 2^23 * Gain * 1.5
> -		 * Voltage = Raw * (Vref)/(2^23 * Gain * 1.5)
> -		 */
> -
> -		/* val2 = (2^23 * 1.5) */
> -		*val2 = 12582912;
> -		ret = IIO_VAL_FRACTIONAL;
> +		*val = mcp3911_scale_table[ilog2(adc->gain[channel->channel])][0];
> +		*val2 = mcp3911_scale_table[ilog2(adc->gain[channel->channel])][1];
> +		ret = IIO_VAL_INT_PLUS_NANO;
>  		break;
>  	}
>  
> @@ -220,6 +241,18 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
>  
>  	mutex_lock(&adc->lock);
>  	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
> +			if (val == mcp3911_scale_table[i][0] &&
> +				val2 == mcp3911_scale_table[i][1]) {
> +
> +				adc->gain[channel->channel] = BIT(i);
> +				ret = mcp3911_update(adc, MCP3911_REG_GAIN,
> +						MCP3911_GAIN_MASK(channel->channel),
> +						MCP3911_GAIN_VAL(channel->channel, i), 1);
> +			}
> +		}
> +		break;
>  	case IIO_CHAN_INFO_OFFSET:
>  		if (val2 != 0) {
>  			ret = -EINVAL;
> @@ -264,6 +297,48 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int mcp3911_calc_scale_table(struct mcp3911 *adc)
> +{
> +	u32 ref = MCP3911_INT_VREF_MV;
> +	u32 div;
> +	int ret;
> +	int tmp0, tmp1;
> +	s64 tmp2;
> +
> +	if (adc->vref) {
> +		ret = regulator_get_voltage(adc->vref);
> +		if (ret < 0) {
> +			dev_err(&adc->spi->dev,
> +				"failed to get vref voltage: %d\n",
> +			       ret);
> +			return ret;
> +		}
> +
> +		ref = ret / 1000;
> +	}
> +
> +	/*
> +	 * For 24bit Conversion
> +	 * Raw = ((Voltage)/(Vref) * 2^23 * Gain * 1.5
> +	 * Voltage = Raw * (Vref)/(2^23 * Gain * 1.5)
> +	 */
> +
> +	/* ref = Reference voltage

comment syntax is wrong.  Also a bit odd to have two comment
blocks next to each other. Please combine them.

> +	 * div = (2^23 * 1.5 * gain) = 12582912 * gain
> +	 */
> +	for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
> +		div = 12582912 * BIT(i);
> +		tmp2 = div_s64((s64)ref * 1000000000LL, div);
> +		tmp1 = div;
> +		tmp0 = (int)div_s64_rem(tmp2, 1000000000, &tmp1);
> +
> +		mcp3911_scale_table[i][0] = 0;
> +		mcp3911_scale_table[i][1] = tmp1;
> +	}
> +
> +	return 0;
> +}
> +
>  #define MCP3911_CHAN(idx) {					\
>  		.type = IIO_VOLTAGE,				\
>  		.indexed = 1,					\
> @@ -276,8 +351,10 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
>  			BIT(IIO_CHAN_INFO_OFFSET) |		\
>  			BIT(IIO_CHAN_INFO_SCALE),		\
> -		.info_mask_shared_by_type_available =		\
> +		.info_mask_shared_by_type_available =           \
>  			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> +		.info_mask_separate_available =			\
> +			BIT(IIO_CHAN_INFO_SCALE),		\
>  		.scan_type = {					\
>  			.sign = 's',				\
>  			.realbits = 24,				\
> @@ -330,6 +407,7 @@ static const struct iio_info mcp3911_info = {
>  	.read_raw = mcp3911_read_raw,
>  	.write_raw = mcp3911_write_raw,
>  	.read_avail = mcp3911_read_avail,
> +	.write_raw_get_fmt = mcp3911_write_raw_get_fmt,
>  };
>  
>  static irqreturn_t mcp3911_interrupt(int irq, void *dev_id)
> @@ -460,6 +538,14 @@ static int mcp3911_probe(struct spi_device *spi)
>  	if (ret)
>  		goto clk_disable;
>  
> +	ret = mcp3911_calc_scale_table(adc);
> +	if (ret)
> +		goto clk_disable;
> +
> +       /* Store gain values to better calculate scale values */

Run checkpatch.pl You have spaces here which should be a tab.

> +	mcp3911_get_gain(adc, 0, &adc->gain[0]);
> +	mcp3911_get_gain(adc, 1, &adc->gain[1]);

We'd normally set something like this to default value rather than
rely on sane state from a previous startup.  Either that or rely on reset
(which device has, but I don't think driver supports yet).



> +
>  	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz"))
>  		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
>  				0, 2);

