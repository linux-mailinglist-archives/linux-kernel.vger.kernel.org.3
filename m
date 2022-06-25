Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4444955A9A4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 14:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbiFYME6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 08:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiFYME4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 08:04:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B575E14021;
        Sat, 25 Jun 2022 05:04:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4126A611E9;
        Sat, 25 Jun 2022 12:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08FBC3411C;
        Sat, 25 Jun 2022 12:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656158693;
        bh=v+nq6VKI00e2nKJ82BUSyHWq2binsIyiy8z0or5TJu4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RbQrAGZz1s4DDX7PqB95hkyVGX7hM5EWyN/EZz/dXspuXbTok6auAO7S5HiJSF2hp
         ljz/YlVBubGN+gmMCjX95zL+hZcYhUTgNFlnDuK8UzpjshmuYU6gNatKQKyjyoC1He
         cbHvL14nmmxzBHfMBcKtgryvgwZVdd0er/7oykV2VMi3tuZ6ypkSDsdd3uNKW6Vm/O
         3OSg9UOHtyrq42LBEwYI4UI3zZb8gnzzWWcvohlJoIrcqvrUgL9dDW79tYOZ6An89f
         QpqyycOSQvUmwYjeJhtAcqPujjb005MRHu/Zcj4+H94nwmhx4pohQ8+HW7wG1hy0Tw
         jjorI2WJqQXyw==
Date:   Sat, 25 Jun 2022 13:14:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] iio: adc: mcp3911: add support for
 oversampling ratio
Message-ID: <20220625131420.28c8bb5a@jic23-huawei>
In-Reply-To: <20220625103853.2470346-6-marcus.folkesson@gmail.com>
References: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
        <20220625103853.2470346-6-marcus.folkesson@gmail.com>
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

On Sat, 25 Jun 2022 12:38:49 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> The chip supports oversampling ratio, so expose it to userspace.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Hi Marcus,

A few minor comments inline.

Thanks,

Jonathan


> ---
> 
> Notes:
>     v2:
>         - Make use of osr table
>         - Change formatting and typos
> 
>  drivers/iio/adc/mcp3911.c | 47 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index f4ee0c27c2ab..1469c12ebbb2 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -5,6 +5,8 @@
>   * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
>   * Copyright (C) 2018 Kent Gustavsson <kent@minoris.se>
>   */
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> @@ -35,6 +37,7 @@
>  #define MCP3911_REG_CONFIG		0x0c
>  #define MCP3911_CONFIG_CLKEXT		BIT(1)
>  #define MCP3911_CONFIG_VREFEXT		BIT(2)
> +#define MCP3911_CONFIG_OSR		GENMASK(13, 11)
>  
>  #define MCP3911_REG_OFFCAL_CH0		0x0e
>  #define MCP3911_REG_GAINCAL_CH0		0x11
> @@ -53,6 +56,8 @@
>  
>  #define MCP3911_NUM_CHANNELS		2
>  
> +static const int mcp3911_osr_table[] = {32, 64, 128, 256, 512, 1024, 2048, 4096};
> +
>  struct mcp3911 {
>  	struct spi_device *spi;
>  	struct mutex lock;
> @@ -108,6 +113,22 @@ static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask,
>  	return mcp3911_write(adc, reg, val, len);
>  }
>  
> +static int mcp3911_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long info)
> +{
> +	switch (info) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*type = IIO_VAL_INT;
> +		*vals = mcp3911_osr_table;
> +		*length = ARRAY_SIZE(mcp3911_osr_table);
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int mcp3911_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *channel, int *val,
>  			    int *val2, long mask)
> @@ -134,6 +155,16 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
>  
>  		ret = IIO_VAL_INT;
>  		break;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret = mcp3911_read(adc,
> +				MCP3911_REG_CONFIG, val, 2);
> +		if (ret)
> +			goto out;
> +
> +		*val = FIELD_GET(MCP3911_CONFIG_OSR, *val);
> +		*val = 32 << *val;
> +		ret = IIO_VAL_INT;
> +		break;
>  
>  	case IIO_CHAN_INFO_SCALE:
>  		if (adc->vref) {
> @@ -186,6 +217,17 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
>  				MCP3911_STATUSCOM_EN_OFFCAL,
>  				MCP3911_STATUSCOM_EN_OFFCAL, 2);
>  		break;
> +
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		for (int i = 0; i < sizeof(mcp3911_osr_table); i++) {
> +			if (val == mcp3911_osr_table[i]) {

Default type of IIO writes is IIO_VAL_INT_PLUS_MICRO.  You can either provide
write_raw_get_fmt() or be lazy and check val2 == 0 here.
 
> +				val = FIELD_PREP(MCP3911_CONFIG_OSR, i);
> +				ret = mcp3911_update(adc, MCP3911_REG_CONFIG, MCP3911_CONFIG_OSR,
> +						val, 2);
> +				break;
> +			}
> +		}
> +		break;
>  	}
>  
>  out:
> @@ -198,9 +240,13 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
>  		.indexed = 1,					\
>  		.channel = idx,					\
>  		.scan_index = idx,				\
> +		.scan_index = idx,				\

repeated... I guess a merge conflict resolution issue.

> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
>  			BIT(IIO_CHAN_INFO_OFFSET) |		\
>  			BIT(IIO_CHAN_INFO_SCALE),		\
> +		.info_mask_shared_by_type_available =		\
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
>  		.scan_type = {					\
>  			.sign = 's',				\
>  			.realbits = 24,				\
> @@ -252,6 +298,7 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
>  static const struct iio_info mcp3911_info = {
>  	.read_raw = mcp3911_read_raw,
>  	.write_raw = mcp3911_write_raw,
> +	.read_avail = mcp3911_read_avail,
>  };
>  
>  static irqreturn_t mcp3911_interrupt(int irq, void *dev_id)


