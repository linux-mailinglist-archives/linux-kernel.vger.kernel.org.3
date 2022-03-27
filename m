Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17434E8838
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 16:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbiC0Op4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 10:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiC0Opz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 10:45:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95AA6558;
        Sun, 27 Mar 2022 07:44:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48EDE6102C;
        Sun, 27 Mar 2022 14:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A5DC340EC;
        Sun, 27 Mar 2022 14:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648392254;
        bh=KaaMBLWHobctIZkx9Oel+yUjiNjl6Gc2pcQei+x3+ME=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KS/65AzesUTLsBp+XxUP1m9uj9heIV9TAaN7regkUeinj+GIlaecsUQYrLiGP7mBC
         GM2HzaELMVFqvwCRVopXDnRrgDzXVRoJRwJ7YT9ScorO1Fm0QHtksrYgNUoejadIt2
         j4+wTOP7WlHwxQeBYMrToomF4rdFX1IrcCyFlx7mlIIUnqnC0uta9LCMHecaWE+0UN
         joibO2ShmjF9U0STZ36Rn6bQyP9TlFdzi12xmxF3pD3jd7F21PDgM3XHAHx5Kstiq9
         MAT5v6WDEIfz21zYMnTelf0JnyDJ4YHSc8NeLmr2aIIyzkkK35yI5sev15RoNBe96a
         52azvuz+4S3aQ==
Date:   Sun, 27 Mar 2022 15:51:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v2] iio:proximity:sx9324: Fix hardware gain read/write
Message-ID: <20220327155147.52e898b4@jic23-huawei>
In-Reply-To: <20220324222928.874522-1-swboyd@chromium.org>
References: <20220324222928.874522-1-swboyd@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2022 15:29:28 -0700
Stephen Boyd <swboyd@chromium.org> wrote:

> There are four possible gain values according to 'sx9324_gain_vals[]':
> 
> 	1, 2, 4, and 8
> 
> The values are off by one when writing and reading the register. The
> bits should be set according to this equation:
> 
> 	ilog2(<gain>) + 1
> 
> so that a gain of 8 is 0x3 in the register field and a gain of 4 is 0x2
> in the register field, etc

Example seems wrong... 

ilog2(8) + 1 = 3 + 1 = 0x4
ilog2(4) + 1 = 2 + 1 = 0x3
ilog2(2) + 1 = 1 + 1 = 0x2
ilog2(1) + 1 = 0 + 1 = 0x1
                       0x0 reserved.

or have I misunderstood?

>. Note that a gain of 0 is reserved per the
> datasheet. The default gain (SX9324_REG_PROX_CTRL0_GAIN_1) is also
> wrong. It should be 0x1 << 3, i.e. 0x8, not 0x80 which is setting the
> reserved bit 7.
> 
> Fix this all up to properly handle the hardware gain and return errors
> for invalid settings.
> 
> Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Changes from v1 (https://lore.kernel.org/r/)20220318204808.3404542-1-swboyd@chromium.org:
>  * Reject invalid settings
>  * Fix default value
>  * More commit text details
> 
>  drivers/iio/proximity/sx9324.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index 0d9bbbb50cb4..6e90917e3e36 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -76,7 +76,10 @@
>  
>  #define SX9324_REG_PROX_CTRL0		0x30
>  #define SX9324_REG_PROX_CTRL0_GAIN_MASK	GENMASK(5, 3)
> -#define SX9324_REG_PROX_CTRL0_GAIN_1		0x80
> +#define SX9324_REG_PROX_CTRL0_GAIN_SHIFT	3
> +#define SX9324_REG_PROX_CTRL0_GAIN_RSVD		0x0
> +#define SX9324_REG_PROX_CTRL0_GAIN_1		0x1
> +#define SX9324_REG_PROX_CTRL0_GAIN_8		0x4
>  #define SX9324_REG_PROX_CTRL0_RAWFILT_MASK	GENMASK(2, 0)
>  #define SX9324_REG_PROX_CTRL0_RAWFILT_1P50	0x01
>  #define SX9324_REG_PROX_CTRL1		0x31
> @@ -379,7 +382,14 @@ static int sx9324_read_gain(struct sx_common_data *data,
>  	if (ret)
>  		return ret;
>  
> -	*val = 1 << FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
> +	regval = FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
> +	if (regval)
> +		regval--;
> +	else if (regval == SX9324_REG_PROX_CTRL0_GAIN_RSVD ||
> +		 regval > SX9324_REG_PROX_CTRL0_GAIN_8)
> +		return -EINVAL;
> +
> +	*val = 1 << regval;
>  
>  	return IIO_VAL_INT;
>  }
> @@ -725,8 +735,12 @@ static int sx9324_write_gain(struct sx_common_data *data,
>  	unsigned int gain, reg;
>  	int ret;
>  
> -	gain = ilog2(val);
>  	reg = SX9324_REG_PROX_CTRL0 + chan->channel / 2;
> +
> +	gain = ilog2(val) + 1;
> +	if (val <= 0 || gain > SX9324_REG_PROX_CTRL0_GAIN_8)
> +		return -EINVAL;
> +
>  	gain = FIELD_PREP(SX9324_REG_PROX_CTRL0_GAIN_MASK, gain);
>  
>  	mutex_lock(&data->mutex);
> @@ -784,9 +798,11 @@ static const struct sx_common_reg_default sx9324_default_regs[] = {
>  	{ SX9324_REG_AFE_CTRL8, SX9324_REG_AFE_CTRL8_RESFILTN_4KOHM },
>  	{ SX9324_REG_AFE_CTRL9, SX9324_REG_AFE_CTRL9_AGAIN_1 },
>  
> -	{ SX9324_REG_PROX_CTRL0, SX9324_REG_PROX_CTRL0_GAIN_1 |
> +	{ SX9324_REG_PROX_CTRL0,
> +		SX9324_REG_PROX_CTRL0_GAIN_1 << SX9324_REG_PROX_CTRL0_GAIN_SHIFT |
>  		SX9324_REG_PROX_CTRL0_RAWFILT_1P50 },
> -	{ SX9324_REG_PROX_CTRL1, SX9324_REG_PROX_CTRL0_GAIN_1 |
> +	{ SX9324_REG_PROX_CTRL1,
> +		SX9324_REG_PROX_CTRL0_GAIN_1 << SX9324_REG_PROX_CTRL0_GAIN_SHIFT |
>  		SX9324_REG_PROX_CTRL0_RAWFILT_1P50 },
>  	{ SX9324_REG_PROX_CTRL2, SX9324_REG_PROX_CTRL2_AVGNEG_THRESH_16K },
>  	{ SX9324_REG_PROX_CTRL3, SX9324_REG_PROX_CTRL3_AVGDEB_2SAMPLES |
> 
> base-commit: a8ee3b32f5da6c77a5ccc0e42c2250d61ba54fe0

