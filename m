Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B297F55A992
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 13:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiFYLrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 07:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbiFYLr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 07:47:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9624E237C2;
        Sat, 25 Jun 2022 04:47:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 265B2611E7;
        Sat, 25 Jun 2022 11:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7015DC3411C;
        Sat, 25 Jun 2022 11:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656157644;
        bh=Yy4pcXuXA7h/qNmmOrDBiWAGLTfe6dH8mr0970nP94Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CFE/hYQ7FZuWbZjWvZea7Zc08MvhKBuNUnZRu0A8M8ioTYXZJeEWL23O1e/ueZbhB
         7TDtJmuZpSHjzY1RlpWbqIgYj1ZFxbYwolTgprTc0IY9ovaniJ48JySJNosxU0N+fq
         TW6+qqUeR13564Oe4dnEEBLV5XeIBRVUCBcm1vOndXWc7ga6g2P6Jw9KTYGyh3Zzi6
         0T2Otn7M5R9+p5HakGj692RTW5qd8+x34TtrHxpC0nx5RAzoj+pWQlQGl5lqB7FLwA
         MEH4ErmSbCyP8/saBAk0G2LdursI9ZxviQ5LUkPGO8cPmRcTK9C8aFIwaNyg+O7j97
         3xqXMKgsdLN9Q==
Date:   Sat, 25 Jun 2022 12:56:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] iio: adc: mcp3911: add support for interrupts
Message-ID: <20220625125652.2f988964@jic23-huawei>
In-Reply-To: <20220625103853.2470346-4-marcus.folkesson@gmail.com>
References: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
        <20220625103853.2470346-4-marcus.folkesson@gmail.com>
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

On Sat, 25 Jun 2022 12:38:47 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Make it possible to read values upon interrupts.
> Configure Data Ready Signal Output Pin to either HiZ or push-pull and
> use it as interrupt source.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Hi Marcus,

A few minor things inline.

Jonathan

> ---
> 
> Notes:
>     v2:
>         - Removed blank lines (Andy Shevchenko)
>         - Removed dr_hiz variable (Andy Shevchenko)
> 
>  drivers/iio/adc/mcp3911.c | 65 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index 2a4bf374f140..f4ee0c27c2ab 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -26,6 +26,7 @@
>  #define MCP3911_REG_GAIN		0x09
>  
>  #define MCP3911_REG_STATUSCOM		0x0a
> +#define MCP3911_STATUSCOM_DRHIZ         BIT(12)
>  #define MCP3911_STATUSCOM_CH1_24WIDTH	BIT(4)
>  #define MCP3911_STATUSCOM_CH0_24WIDTH	BIT(3)
>  #define MCP3911_STATUSCOM_EN_OFFCAL	BIT(2)
> @@ -58,6 +59,7 @@ struct mcp3911 {
>  	struct regulator *vref;
>  	struct clk *clki;
>  	u32 dev_addr;
> +	struct iio_trigger *trig;
>  	struct {
>  		u32 channels[2];
>  		s64 ts __aligned(8);
> @@ -252,6 +254,17 @@ static const struct iio_info mcp3911_info = {
>  	.write_raw = mcp3911_write_raw,
>  };
>  
> +static irqreturn_t mcp3911_interrupt(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev = dev_id;
> +	struct mcp3911 *adc = iio_priv(indio_dev);
> +
> +	if (iio_buffer_enabled(indio_dev))

Hmm. So I think this protection is only relevant for races around
disabling of the trigger.  Those shouldn't matter as just look
like the actual write to disable the trigger was a bit later relative
to the asynchronous capture of data.  So I think you can drop it.
If it is here for some other reason please ad a comment.

With that dropped you can use 
iio_trigger_generic_data_rdy_poll() for your interrupt handler
(as it's identical to the rest of this code).

> +		iio_trigger_poll(adc->trig);
> +
> +	return IRQ_HANDLED;
> +};
> +
>  static int mcp3911_config(struct mcp3911 *adc)
>  {
>  	struct device *dev = &adc->spi->dev;
> @@ -298,6 +311,23 @@ static int mcp3911_config(struct mcp3911 *adc)
>  	return  mcp3911_write(adc, MCP3911_REG_CONFIG, configreg, 2);
>  }
>  
> +static int mcp3911_set_trigger_state(struct iio_trigger *trig, bool enable)
> +{
> +	struct mcp3911 *adc = iio_trigger_get_drvdata(trig);
> +
> +	if (enable)
> +		enable_irq(adc->spi->irq);
> +	else
> +		disable_irq(adc->spi->irq);
> +
> +	return 0;
> +}
> +
> +static const struct iio_trigger_ops mcp3911_trigger_ops = {
> +	.validate_device = iio_trigger_validate_own_device,
> +	.set_trigger_state = mcp3911_set_trigger_state,
> +};
> +
>  static int mcp3911_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> @@ -352,6 +382,15 @@ static int mcp3911_probe(struct spi_device *spi)
>  	if (ret)
>  		goto clk_disable;
>  
> +	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz"))
> +		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
> +				0, 2);
> +	else
> +		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
> +				MCP3911_STATUSCOM_DRHIZ, 2);
> +	if (ret < 0)
> +		goto clk_disable;
> +
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
>  	indio_dev->info = &mcp3911_info;
> @@ -362,6 +401,32 @@ static int mcp3911_probe(struct spi_device *spi)
>  
>  	mutex_init(&adc->lock);
>  
> +	if (spi->irq > 0) {
> +		adc->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
> +				indio_dev->name,
> +				iio_device_id(indio_dev));
> +		if (!adc->trig)
> +			goto clk_disable;
You definitely want to use devm managed cleanup for these.

There is a patch set that adds these as standard functions, but I haven't
yet seen it being picked up for this cycle (reviews have been slow coming).

https://lore.kernel.org/all/20220520075737.758761-1-u.kleine-koenig@pengutronix.de/

In meantime role your own with devm_add_action_or_reset()

> +
> +		adc->trig->ops = &mcp3911_trigger_ops;
> +		iio_trigger_set_drvdata(adc->trig, adc);
> +		ret = devm_iio_trigger_register(&spi->dev, adc->trig);
> +		if (ret)
> +			goto clk_disable;
> +
> +		/*
> +		 * The device generates interrupts as long as it is powered up.
> +		 * Some platforms might not allow the option to power it down so
> +		 * don't enable the interrupt to avoid extra load on the system
> +		 */
Gah. Always annoying when devices don't support masking. Your handling is indeed
the best we can do.
> +		ret = devm_request_irq(&spi->dev, spi->irq,
> +				&mcp3911_interrupt,
> +				IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN | IRQF_ONESHOT,
Don't set trigger_falling in the driver, rely on the firmware bindings to do that
for you as there may well be inverters in the path on some boards that aren't
visible to Linux.   We used to always do it in the driver and unfortunately are stuck
with it where already present to avoid breaking boards that previously worked.

We don't want to introduce more cases of this pattern though!

Jonathan

> +				indio_dev->name, indio_dev);
> +		if (ret)
> +			goto clk_disable;
> +	}
> +
>  	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
>  			NULL,
>  			mcp3911_trigger_handler, NULL);

